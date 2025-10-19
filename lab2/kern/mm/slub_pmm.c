#include <slub_pmm.h>
#include <pmm.h>
#include <list.h>
#include <string.h>
#include <stdio.h>

#define SLUB_MIN_SIZE 8
#define SLUB_MAX_SIZE 1024
#define SLUB_SIZE_NUM 8

// convert list entry to slab
#define le2slab(le, member)                 \
    to_struct((le), slab_t, member)

// convert list entry to cache
#define le2cache(le, member)                 \
    to_struct((le), kmem_cache_t, member)

// 检查链表节点是否在链表中
static inline int list_in_list(list_entry_t *node) {
    return node->next != NULL && node->prev != NULL;
}

// 管理一个内存页，将其划分为多个相同大小的对象
// 当分配一个对象时，从current开始取一个对象大小，然后current向后移动
// 当slab被释放一个对象时，我们减少使用计数，如果整个slab都空闲了，就释放这个slab回页分配器
typedef struct slab_struct {
    list_entry_t list;
    void *current;
    void *end;
    int used;
} slab_t;

// 管理同一大小的所有 slab
typedef struct kmem_cache {
    size_t obj_size;
    list_entry_t partial;
    slab_t *current_slab;
} kmem_cache_t;

static kmem_cache_t cache_list[SLUB_SIZE_NUM];
static size_t size_list[SLUB_SIZE_NUM] = {8, 16, 32, 64, 128, 256, 512, 1024};

// 创建一个slab
static slab_t *slab_create(void) {
    // 从页分配器分配一页
    struct Page *page = pmm_manager->alloc_pages(1);
    if (!page) return NULL;
    
    // 使用page2pa 从page转到相应地址
    slab_t *slab = (slab_t *)((uintptr_t)page2pa(page) + va_pa_offset);
    slab->current = (void *)slab + sizeof(slab_t);
    slab->end = (void *)slab + PGSIZE;
    slab->used = 0;
    list_init(&slab->list);
    return slab;
}

// 回收一个slab
static void slab_destroy(slab_t *slab) {
    // 找到对应的页，调用pmm回收
    /* slab 是内核虚拟地址，先转换为物理地址再取 Page */
    struct Page *page = pa2page(PADDR(slab));
    pmm_manager->free_pages(page, 1);
}

// 从指定的cache中分配一个对象
static void *slab_alloc(kmem_cache_t *cache) {
    slab_t *slab = cache->current_slab;
    
    // 若当前slab不可用，从partial中找或者新建
    if (!slab || (char *)slab->current + cache->obj_size > (char *)slab->end) {
        if ( list_empty(&cache->partial) ) {
            slab = slab_create();
            if (!slab) return NULL;
        } else {
            list_entry_t* le = &cache->partial;
            le = list_next(le);
            slab = le2slab(le, list);
            /* 从 partial 中取出时要删除该节点，避免重复 */
            list_del(&slab->list);
        }
        cache->current_slab = slab;
    }
    
    // 然后从slab中分配
    void *obj = slab->current;
    slab->current = (char *)slab->current + cache->obj_size;
    slab->used++;
    return obj;
}

// 回收一个对象
static void slab_free(kmem_cache_t *cache, void *obj) {
    // 找到obj对应的页和slab
    slab_t *slab = NULL;
    /* obj 是内核虚拟地址，先转换为物理地址再得到 Page */
    struct Page *page = pa2page(PADDR(obj));
    slab = (slab_t *)((uintptr_t)page2pa(page) + va_pa_offset);

    slab->used--;
    // 如果该slab空了，回收整个页
    if (slab->used == 0) {
        if (cache->current_slab == slab) {
            cache->current_slab = NULL;
        }
        list_del(&slab->list);
        slab_destroy(slab);
    } else if (slab != cache->current_slab && !list_in_list(&slab->list)) {
        list_add(&cache->partial, &slab->list);
    }
}

// 找到合适大小的cache
static kmem_cache_t *get_cache(size_t size) {
    for (int i = 0; i < SLUB_SIZE_NUM; i++) {
        if (size <= size_list[i]) {
            return &cache_list[i];
        }
    }
    return NULL;
}

static void slub_init(void) {
    for (int i = 0; i < SLUB_SIZE_NUM; i++) {
        cache_list[i].obj_size = size_list[i];
        list_init(&cache_list[i].partial);
        cache_list[i].current_slab = NULL;
    }
}

static void *slub_kmalloc(size_t size) {
    // 太大了，交给pmm分配
    if (size > SLUB_MAX_SIZE) {
        size_t cnt = (size + PGSIZE - 1) / PGSIZE;
        struct Page *page = pmm_manager->alloc_pages(cnt);
        if (!page) return NULL;
        /* 记录分配的页数，便于 kfree 时释放 */
        set_page_ref(page, (int)cnt);
        return (void *)((uintptr_t)page2pa(page) + va_pa_offset);
    }
    
    kmem_cache_t *cache = get_cache(size);
    return cache ? slab_alloc(cache) : NULL;
}

static void slub_kfree(void *ptr) {
    if (!ptr) return;
    /* ptr 为内核虚拟地址；转换到 Page */
    struct Page *page = pa2page(PADDR(ptr));
    slab_t *slab = (slab_t *)((uintptr_t)page2pa(page) + va_pa_offset);

    for (int i = 0; i < SLUB_SIZE_NUM; i++) {
        kmem_cache_t *cache = &cache_list[i];
        if (cache->current_slab == slab || list_in_list(&slab->list)) {
            slab_free(cache, ptr);
            return;
        }
    }

    /* 不在缓存管理范围内，按页分配的大块内存，page->ref 存储了页数 */
    size_t page_cnt = page_ref(page);
    pmm_manager->free_pages(page, page_cnt);
}

static void slub_check(void) {
    const size_t small_sizes[] = {8, 16, 128, 512, 1024}; // 测试SLUB范围内的各种大小
    const size_t large_size = 4096; // 必须大于SLUB_MAX_SIZE=1024，测试PMM路径
    const int TEST_COUNT = 5; // 用于测试分配和回收机制
    void *ptrs[TEST_COUNT];
    void *large_ptr = NULL;
    void *small_ptr = NULL;

    // 1. 测试小对象的基本分配和释放 (最小 size)
    small_ptr = slub_kmalloc(8);
    assert(small_ptr != NULL);
    // 假设内存内容可以被安全修改和检查
    memset(small_ptr, 0xAA, 8);
    slub_kfree(small_ptr);

    // 2. 测试大对象的基本分配和释放 (PMM 路径)
    large_ptr = slub_kmalloc(large_size);
    assert(large_ptr != NULL);
    memset(large_ptr, 0xBB, large_size);
    slub_kfree(large_ptr);

    // 3. 测试不同SLUB大小的分配和释放
    for (size_t i = 0; i < sizeof(small_sizes) / sizeof(small_sizes[0]); i++) {
        size_t size = small_sizes[i];
        void *p = slub_kmalloc(size);
        assert(p != NULL);
        memset(p, (i + 1), size);
        slub_kfree(p);
    }

    // 4. 连续分配，填满一个或多个SLAB，然后释放
    // 这将测试current_slab切换和partial链表的使用
    size_t test_size = 16; // 选用一个小尺寸

    // 连续分配
    for (int i = 0; i < TEST_COUNT; i++) {
        ptrs[i] = slub_kmalloc(test_size);
        assert(ptrs[i] != NULL);
        memset(ptrs[i], (i % 256), test_size);
    }
    
    // 释放所有对象
    for (int i = 0; i < TEST_COUNT; i++) {
        slub_kfree(ptrs[i]);
    }

    // 5. 边界值测试：测试最大 SLUB 大小
    small_ptr = slub_kmalloc(1024);
    assert(small_ptr != NULL);
    slub_kfree(small_ptr);

    // 6. 边界值测试：测试刚好超出 SLUB_MAX_SIZE 的分配
    large_ptr = slub_kmalloc(1025);
    assert(large_ptr != NULL);
    slub_kfree(large_ptr);
    
    // 7. 测试 slub_kfree(NULL)
    slub_kfree(NULL);
}

const struct pmm_cache_manager slub_manager = {
    .name = "slub_manager",
    .init = slub_init,
    .kmalloc = slub_kmalloc,
    .kfree = slub_kfree,
    .check = slub_check,
};