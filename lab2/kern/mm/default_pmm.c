#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>

/* In the first fit algorithm, the allocator keeps a list of free blocks (known as the free list) and,
   on receiving a request for memory, scans along the list for the first block that is large enough to
   satisfy the request. If the chosen block is significantly larger than that requested, then it is 
   usually split, and the remainder added to the list as another free block.
   Please see Page 196~198, Section 8.2 of Yan Wei Min's chinese book "Data Structure -- C programming language"
*/
// LAB2 EXERCISE 1: 2310648 2313892
// you should rewrite functions: default_init,default_init_memmap,default_alloc_pages, default_free_pages.
/*
 * Details of FFMA
 * (1) Prepare: In order to implement the First-Fit Mem Alloc (FFMA), we should manage the free mem block use some list.
 *              The struct free_area_t is used for the management of free mem blocks. At first you should
 *              be familiar to the struct list in list.h. struct list is a simple doubly linked list implementation.
 *              You should know howto USE: list_init, list_add(list_add_after), list_add_before, list_del, list_next, list_prev
 *              Another tricky method is to transform a general list struct to a special struct (such as struct page):
 *              you can find some MACRO: le2page (in memlayout.h), (in future labs: le2vma (in vmm.h), le2proc (in proc.h),etc.)
 * (2) default_init: you can reuse the  demo default_init fun to init the free_list and set nr_free to 0.
 *              free_list is used to record the free mem blocks. nr_free is the total number for free mem blocks.
 * (3) default_init_memmap:  CALL GRAPH: kern_init --> pmm_init-->page_init-->init_memmap--> pmm_manager->init_memmap
 *              This fun is used to init a free block (with parameter: addr_base, page_number).
 *              First you should init each page (in memlayout.h) in this free block, include:
 *                  p->flags should be set bit PG_property (means this page is valid. In pmm_init fun (in pmm.c),
 *                  the bit PG_reserved is setted in p->flags)
 *                  if this page  is free and is not the first page of free block, p->property should be set to 0.
 *                  if this page  is free and is the first page of free block, p->property should be set to total num of block.
 *                  p->ref should be 0, because now p is free and no reference.
 *                  We can use p->page_link to link this page to free_list, (such as: list_add_before(&free_list, &(p->page_link)); )
 *              Finally, we should sum the number of free mem block: nr_free+=n
 * (4) default_alloc_pages: search find a first free block (block size >=n) in free list and reszie the free block, return the addr
 *              of malloced block.
 *              (4.1) So you should search freelist like this:
 *                       list_entry_t le = &free_list;
 *                       while((le=list_next(le)) != &free_list) {
 *                       ....
 *                 (4.1.1) In while loop, get the struct page and check the p->property (record the num of free block) >=n?
 *                       struct Page *p = le2page(le, page_link);
 *                       if(p->property >= n){ ...
 *                 (4.1.2) If we find this p, then it' means we find a free block(block size >=n), and the first n pages can be malloced.
 *                     Some flag bits of this page should be setted: PG_reserved =1, PG_property =0
 *                     unlink the pages from free_list
 *                     (4.1.2.1) If (p->property >n), we should re-caluclate number of the the rest of this free block,
 *                           (such as: le2page(le,page_link))->property = p->property - n;)
 *                 (4.1.3)  re-caluclate nr_free (number of the the rest of all free block)
 *                 (4.1.4)  return p
 *               (4.2) If we can not find a free block (block size >=n), then return NULL
 * (5) default_free_pages: relink the pages into  free list, maybe merge small free blocks into big free blocks.
 *               (5.1) according the base addr of withdrawed blocks, search free list, find the correct position
 *                     (from low to high addr), and insert the pages. (may use list_next, le2page, list_add_before)
 *               (5.2) reset the fields of pages, such as p->ref, p->flags (PageProperty)
 *               (5.3) try to merge low addr or high addr blocks. Notice: should change some pages's p->property correctly.
 */

// 管理空闲内存块的结构体，定义在memlayout.h中
// 包含list_entry_t free_list（list head用于构建双向链表）和nr_free（总空闲页数）
static free_area_t free_area;

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

/*
// 功能：
// 初始化空闲链表管理器。这是内存管理器的“启动”函数。
// 实现逻辑：
// list_init(&free_list);：调用 list.h 中的函数，将 free_list 初始化为一个空的双向链表。此时链表中只有头结点自己，形成一个环。
// nr_free = 0;：将总的空闲页计数器清零。
*/
static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
}

// 用于初始化一个空闲块
/*
// 功能：
//      接收一个物理内存区域（由起始页 base 和总页数 n 定义），并将其作为一个大的空闲块加入到全局空闲链表 free_list 中。
// 实现逻辑：
//      初始化每一页：遍历从 base 开始的 n 个 Page 结构体，对每一个进行初始化：
//          p->flags = p->property = 0;：清除 flags 和 property 字段。
//          set_page_ref(p, 0);：将页的引用计数清零，表示它当前未被任何进程使用。
//      标记起始页：
//          base->property = n;：对于这块连续内存的起始页 base，将其 property 字段设置为块的总大小 n。
//          SetPageProperty(base);：设置 base 的 flags 中的 PG_property 位，明确标记它是一个空闲块的“头”。
//      更新总空闲页数：
//          nr_free += n;：将这 n 个页加入到总空闲页数中。
//      插入空闲链表：将这个新的空闲块（由 base 代表）插入到全局的 free_list 中。为了方便后续的合并操作，代码实现了一个按地址有序的插入逻辑：
//          它会遍历 free_list，找到第一个地址比 base 大的空闲块，然后将 base 插入到它的前面。
//          这确保了 free_list 中的空闲块始终是按照物理地址从低到高排列的。
*/
static void
default_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    // 遍历从 base 到 base + n - 1 的所有 page
    for (; p != base + n; p ++) {
        assert(PageReserved(p)); // 在memlayout中的宏定义，判断flags的第PG_reserved（0）位是否为1
        p->flags = p->property = 0; // property是连续可用块数量
        set_page_ref(p, 0);  // 正在使用这个页的进程/页表数量置为0
    }
    base->property = n;
    // 设置了base 的 PG_property 标志，其 property 字段存储了连续空闲页的总数
    // 分配器在遍历空闲列表时，通过检查这个标志来确定当前页是否是一个可分配的空闲块的起点
    SetPageProperty(base);  
    nr_free += n; // number of free pages in this free list

    // 构建双向链表，将page的list head连接到free_list上
    if (list_empty(&free_list)) {
        list_add(&free_list, &(base->page_link));
    } else {
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {
            struct Page* page = le2page(le, page_link);
            if (base < page) {
                list_add_before(le, &(base->page_link));
                break;
            } else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link));
            }
        }
    }
}

// 搜索空闲列表，找到第一个空闲块（块大小≥n页），调整该空闲块的大小，并返回已分配块的起始地址
/*
// 功能：
//      根据首次适应算法分配 n 个连续的物理页。
// 实现逻辑：
//      预检查：首先检查请求的页数 n 是否大于总的空闲页数 nr_free。如果是，则直接返回 NULL，表示内存不足。
//      遍历查找 (First-Fit)：
//          从 free_list 的头部开始，依次遍历每一个空闲块。
//          struct Page *p = le2page(le, page_link);：通过链表节点 le 获取对应的 Page 结构体指针。
//          if (p->property >= n)：检查当前空闲块的大小是否满足请求（>= n）。
//          一旦找到第一个满足条件的块，就跳出循环。这就是“首次适应”的核心体现。
// 执行分配：
//      如果找到了合适的块 (page != NULL)：
//          从链表移除：首先将这个找到的空闲块（由 page 代表）从 free_list 中移除 (list_del)。
//          分割操作：检查 if (page->property > n)，即这个块是否比请求的要大。
//                   如果更大，说明有剩余。那么就从 page + n 的位置创建一个新的空闲块，其大小为 page->property - n。
//                   将这个新的、更小的剩余块重新插入到 free_list 中原来的位置。
//          更新计数：nr_free -= n;，从总空闲页数中减去已分配的 n 页。
//          清除标志：ClearPageProperty(page);，清除被分配出去的内存块起始页的 PG_property 标志，因为它现在不再是空闲块了。
//          返回：返回分配到的内存块的起始页指针 page。
// 分配失败：如果遍历完整个 free_list 都没有找到足够大的块，则返回 NULL。
*/
static struct Page *
default_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > nr_free) {
        return NULL;
    }

    // 按顺序找到一个合适的块
    struct Page *page = NULL;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        if (p->property >= n) {
            page = p;
            break;
        }
    }

    // 如果找到了，分配其中空间
    if (page != NULL) {
        // 保留前一项，然后将找到的块从链中删除
        list_entry_t* prev = list_prev(&(page->page_link));
        list_del(&(page->page_link));
        // >n 表示有空余，剩下的需要接入原链表
        if (page->property > n) {
            struct Page *p = page + n;
            p->property = page->property - n;
            SetPageProperty(p);
            list_add(prev, &(p->page_link));
        }
        nr_free -= n;
        ClearPageProperty(page);
    }
    return page;
}

// 将页重新链接回空闲列表，并尝试将小的空闲块合并成大的空闲块
/*
// 功能：
//      回收 n 个从 base 地址开始的连续物理页，并将它们放回 free_list 中。同时，尝试与相邻的空闲块进行合并，以减少内存碎片。
// 实现逻辑：
//      初始化被回收的页：遍历要释放的 n 个页，重置它们的 flags 和引用计数。
//      标记为新空闲块：
//          base->property = n;：设置起始页 base 的 property 为 n。
//          SetPageProperty(base);：将其标记为空闲块的头部。
//      插入空闲链表：和 default_init_memmap 一样，按照地址有序的规则，将被回收的块插入到 free_list 中。
//      向前合并 (Merge with previous)：
//          找到刚刚插入的 base 块在链表中的前一个块 p。
//          检查 p + p->property == base 是否成立。这个条件判断前一个空闲块 p 的末尾是否正好与当前回收的块 base 的开头相连。
//          如果相连，则将两个块合并：将 p 的大小增加 n (p->property += base->property;)，并从链表中删除 base 节点。
//      向后合并 (Merge with next)：
//          找到当前块 base（可能是已经合并过的块）在链表中的后一个块 p。
//          检查 base + base->property == p 是否成立，即当前块的末尾是否与后一个块的开头相连。
//          如果相连，则将两个块合并：将 base 的大小增加 p 的大小 (base->property += p->property;)，并从链表中删除 p 节点。
*/
static void
default_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p ++) {
        assert(!PageReserved(p) && !PageProperty(p)); // 确保是连续的 n 页
        p->flags = 0;
        set_page_ref(p, 0);
    }
    base->property = n;
    SetPageProperty(base);
    nr_free += n;

    // 将释放出来的块插入free_list
    if (list_empty(&free_list)) {
        list_add(&free_list, &(base->page_link));
    } else {
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {
            struct Page* page = le2page(le, page_link);
            // 按地址从低到高插入
            if (base < page) {
                list_add_before(le, &(base->page_link));
                break;
            } else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link));
            }
        }
    }

    // 尝试合并上一个块
    list_entry_t* le = list_prev(&(base->page_link));
    if (le != &free_list) {
        p = le2page(le, page_link);
        if (p + p->property == base) {
            p->property += base->property;
            ClearPageProperty(base);
            list_del(&(base->page_link));
            base = p;
        }
    }

    // 尝试合并下一个块
    le = list_next(&(base->page_link));
    if (le != &free_list) {
        p = le2page(le, page_link);
        if (base + base->property == p) {
            base->property += p->property;
            ClearPageProperty(p);
            list_del(&(p->page_link));
        }
    }
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}

static void
basic_check(void) {
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(p0 != p1 && p0 != p2 && p1 != p2);
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);

    assert(page2pa(p0) < npage * PGSIZE);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    assert(alloc_page() == NULL);

    free_page(p0);
    free_page(p1);
    free_page(p2);
    assert(nr_free == 3);

    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(alloc_page() == NULL);

    free_page(p0);
    assert(!list_empty(&free_list));

    struct Page *p;
    assert((p = alloc_page()) == p0);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    free_list = free_list_store;
    nr_free = nr_free_store;

    free_page(p);
    free_page(p1);
    free_page(p2);
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count ++, total += p->property;
    }
    assert(total == nr_free_pages());

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
    assert(p0 != NULL);
    assert(!PageProperty(p0));

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
    assert(alloc_pages(4) == NULL);
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
    assert((p1 = alloc_pages(3)) != NULL);
    assert(alloc_page() == NULL);
    assert(p0 + 2 == p1);

    p2 = p0 + 1;
    free_page(p0);
    free_pages(p1, 3);
    assert(PageProperty(p0) && p0->property == 1);
    assert(PageProperty(p1) && p1->property == 3);

    assert((p0 = alloc_page()) == p2 - 1);
    free_page(p0);
    assert((p0 = alloc_pages(2)) == p2 + 1);

    free_pages(p0, 2);
    free_page(p2);

    assert((p0 = alloc_pages(5)) != NULL);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
    }
    assert(count == 0);
    assert(total == 0);
}

const struct pmm_manager default_pmm_manager = {
    .name = "default_pmm_manager",
    .init = default_init,
    .init_memmap = default_init_memmap,
    .alloc_pages = default_alloc_pages,
    .free_pages = default_free_pages,
    .nr_free_pages = default_nr_free_pages,
    .check = default_check,
};

