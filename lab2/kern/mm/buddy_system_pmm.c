#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_system_pmm.h>
#include <stdio.h>

/*
 * 伙伴系统（Buddy System）物理内存管理器（PMM）
 *
 * 核心约定：
 *   - Page.property 字段用于存放内存块的阶（order），一个阶为 order 的块包含 2^order 个页。
 *   - nr_free[order] 数组表示第 order 阶的空闲块的数量（单位是块，不是页）。
 *   - 所有地址计算和伙伴查找都基于页帧号（PPN），以简化对齐和位运算。
 */

#define MAX_ORDER   16  // 定义系统支持的最大阶，一页为 4KB，则最大块大小为 256MB

// 用于管理每一阶空闲块的数组
static free_area_t free_area[MAX_ORDER + 1];

// 宏定义，方便地访问指定阶的空闲链表和空闲块计数器
#define free_list(order)   (free_area[(order)].free_list)
#define nr_free(order)     (free_area[(order)].nr_free)

/**
 * @brief 将阶（order）转换为对应的页数。
 * @param order 内存块的阶。
 * @return size_t 阶对应的页数（2^order）。
 *
 * 这是一个内联辅助函数，用于快速计算。
 */
static inline size_t order2pages(int order) {
    // 使用位移运算 (1 << order) 高效地计算 2 的 order 次方。
    return (1U << order);
}

/**
 * @brief 初始化伙伴系统的所有数据结构。
 *
 * 此函数在 PMM 初始化阶段被调用，它会遍历所有支持的阶，
 * 将每个阶的空闲链表初始化为空，并将空闲块计数器清零。
 */
static void
buddy_system_init(void) {
    for (int i = 0; i <= MAX_ORDER; i++) {
        // 初始化双向链表，使其头节点的 prev 和 next 都指向自身。
        list_init(&free_list(i));
        // 将该阶的空闲块数量设置为 0。
        nr_free(i) = 0;
    }
}

/**
 * @brief 将一段连续的物理内存区域纳入伙伴系统管理。
 * @param base 这段内存区域的起始 Page 结构体指针。
 * @param n 这段内存区域包含的总页数。
 *
 * 此函数负责将一块大的、连续的物理内存“劈分”成符合伙伴系统大小和对齐要求的
 * 多个块，并将这些块添加到对应阶的空闲链表中。
 * 这是一个自顶向下（Top-Down）的分解过程。
 */
static void
buddy_system_init_memmap(struct Page *base, size_t n) {
    // 确保传入的内存大小是有效的。
    assert(n > 0);

    /* 步骤 1: 初始化这段区域内每一页的基础状态。 */
    for (struct Page *p = base; p < base + n; p++) {
        // 调用者应确保这些页在交给伙伴系统前被标记为“保留”，防止被意外使用。
        assert(PageReserved(p));
        // 清除所有标志位。
        p->flags = 0;
        // 将 property 字段清零。这是关键约定：只有块的首页才存储 order，块内的其他页 property 为 0。
        p->property = 0;
        // 引用计数清零，因为它们现在是空闲页。
        set_page_ref(p, 0);
    }

    /* 步骤 2: 将连续内存按 2^k 对齐的方式分解，并插入到各阶空闲链表。 */
    // 获取起始页的页帧号（PPN），后续计算都基于此。
    ppn_t addr = page2ppn(base);
    size_t remaining = n; // 剩余待处理的页数。

    // 循环处理，直到所有页都被划分到伙伴系统中。
    while (remaining > 0) {
        int order = MAX_ORDER;

        /* 首先，找到不大于剩余页数的最大阶。例如，如果还剩 100 页，最大的块只能是 64 页 (order=6)。 */
        while (order > 0 && order2pages(order) > remaining) {
            order--;
        }

        /* 接着，确保选定的阶与当前地址是对齐的。一个 order 阶的块，其起始地址必须是 2^order 的整数倍。
         * 如果不对齐，就降低 order 直到对齐为止。这是伙伴系统的核心约束。
         * 例如，地址为 6，不能作为 order=3 (大小=8) 的块的起点，但可以作为 order=1 (大小=2) 的块的起点。
         */
        while (order > 0 && (addr & (order2pages(order) - 1)) != 0) {
            order--;
        }

        // 根据计算好的页帧号，找到对应块的起始 Page 结构体。
        struct Page *block = pa2page(((uintptr_t)addr) << PGSHIFT);

        // 设置块的元数据：在首页的 property 字段中存储它的阶。
        block->property = order;
        // 设置 PG_property 标志位，表示这是一个空闲块的首页。
        SetPageProperty(block);

        // 将这个新划分出的块添加到对应阶空闲链表的尾部。
        list_add_tail(&free_list(order), &block->page_link);
        // 对应阶的空闲块数量加一。
        nr_free(order) += 1;

        // 更新下一个待处理的地址和剩余页数。
        addr += order2pages(order);
        remaining -= order2pages(order);
    }
}

/**
 * @brief 从伙伴系统中分配 n 个页。
 * @param n 请求分配的页数。
 * @return struct Page* 分配成功则返回块的首页指针，失败则返回 NULL。
 *
 * 分配过程如下：
 * 1. 计算满足 n 个页所需的最小块阶 order。
 * 2. 从 order 阶开始向上查找，找到第一个有空闲块的阶 (current_order)。
 * 3. 如果找到的块大于所需 (current_order > order)，则将其反复分裂，直到得到一个 order 阶的块。
 * 4. 返回这个 order 阶的块，分裂出的其他伙伴块被加入对应阶的空闲链表。
 */
static struct Page *
buddy_system_alloc_pages(size_t n) {
    assert(n > 0);

    /* 步骤 1: 计算满足 n 页需求的最小阶 order (2^order >= n)。 */
    int order = 0;
    while (order <= MAX_ORDER && order2pages(order) < n) {
        order++;
    }
    // 如果请求的页数超过了最大块的大小，则无法满足。
    if (order > MAX_ORDER) {
        return NULL;
    }

    /* 步骤 2: 从 `order` 阶开始，向上查找第一个非空的空闲链表。 */
    int current_order = order;
    while (current_order <= MAX_ORDER && list_empty(&free_list(current_order))) {
        current_order++;
    }
    // 如果查找到超过最大阶都没有找到空闲块，说明内存不足。
    if (current_order > MAX_ORDER) {
        return NULL;
    }

    /* 步骤 3: 从找到的 `current_order` 阶链表中取出一个块（通常是第一个）。 */
    list_entry_t *le = list_next(&free_list(current_order));
    struct Page *block = le2page(le, page_link);
    // 从链表中移除。
    list_del(le);
    assert(nr_free(current_order) > 0);
    // 更新该阶的空闲块计数。
    nr_free(current_order) -= 1;
    // 临时清除 PG_property 标志，因为它要么被分裂，要么被分配，状态会改变。
    ClearPageProperty(block);

    /* 步骤 4: 如果取出的块大于所需的块，则进行分裂（split）。 */
    while (current_order > order) {
        // 阶数减一，准备分裂成两半。
        current_order--;

        // 计算伙伴块（右半部分）的地址。`block` 始终指向左半部分。
        struct Page *buddy = block + order2pages(current_order);
        // 设置伙伴块的元数据，它现在是一个独立的、更小的空闲块。
        buddy->property = current_order;
        SetPageProperty(buddy);

        // 将新分裂出的伙伴块加入到 `current_order` 阶的空闲链表中。
        list_add_tail(&free_list(current_order), &buddy->page_link);
        nr_free(current_order) += 1;
        // `block` 指针保持不变，代表左半部分，继续下一轮分裂（如果需要）。
    }

    /* 步骤 5: 标记最终要分配出去的块，并设置其属性。 */
    // 在块首页记录其阶，以便将来释放时知道它的大小。
    block->property = order;
    // 确保 PG_property 标志是清除的，因为它现在是“已分配”状态，不是“空闲块首页”。
    ClearPageProperty(block);

    // 将该块中的每一页的引用计数设置为 1，表示它们被占用了。
    for (size_t i = 0; i < order2pages(order); i++) {
        set_page_ref(block + i, 1);
    }

    return block;
}

/**
 * @brief 释放一个之前分配的内存块，并尝试与伙伴块合并。
 * @param base 要释放的块的首页指针。
 * @param n 创建该块时请求的页数（用于计算 order）。
 *
 * 释放过程如下：
 * 1. 根据 n 计算出块的阶 order。
 * 2. 清理块内所有页的状态（引用计数、标志位）。
 * 3. 循环尝试合并：计算伙伴块的地址，检查它是否也是同阶的空闲块。
 * 4. 如果是，则将伙伴块从其空闲链表移除，两个块合并成一个大一阶的新块，继续尝试与新块的伙伴合并。
 * 5. 如果伙伴块不可合并，则停止合并，将当前块加入对应阶的空闲链表。
 */
static void
buddy_system_free_pages(struct Page *base, size_t n) {
    assert(n > 0);

    /* 步骤 1: 计算被释放块的阶 order。 */
    int order = 0;
    while (order <= MAX_ORDER && order2pages(order) < n) {
        order++;
    }
    assert(order <= MAX_ORDER);

    /* 将块内所有页的状态重置为空闲状态。 */
    for (size_t i = 0; i < order2pages(order); i++) {
        struct Page *p = base + i;
        // 确保要释放的页不是内核保留页。
        assert(!PageReserved(p));
        // 清除所有标志位。
        p->flags = 0;
        // 引用计数清零。
        set_page_ref(p, 0);
    }

    // 获取块首页的页帧号，用于计算伙伴。
    ppn_t ppn = page2ppn(base);

    /* 步骤 2: 循环尝试与伙伴块合并，直到无法合并或达到最大阶。 */
    while (order < MAX_ORDER) {
        // 使用异或运算计算伙伴块的页帧号，这是伙伴系统的精髓。
        ppn_t buddy_ppn = ppn ^ order2pages(order);
        struct Page *buddy = pa2page(((uintptr_t)buddy_ppn) << PGSHIFT);

        // 合并的条件：伙伴块必须是空闲块的首页 (PageProperty 为 true)，且阶数必须相同。
        if (!PageProperty(buddy) || buddy->property != order) {
            // 如果不满足条件，则无法合并，跳出循环。
            break;
        }

        // 伙伴块可以合并，将其从它的空闲链表中移除。
        list_del(&buddy->page_link);
        nr_free(order) -= 1;

        // 当两个块合并时，只有一个能成为新块的块头。
        // 另一个块的首页就不再是块头了，必须清除它的 property 字段。
        if (buddy < base) {
            // buddy 地址更低，它成为新块（更大块）的块头。
            // 那么原 base 块就成了新块的后半部分。
            ClearPageProperty(base); // 清除 base 的空闲块首页标志。
            base->property = 0;      // 将 base 的 order 信息清零。

            // 更新 base 和 ppn，指向新合并块的起始位置。
            base = buddy;
            ppn = buddy_ppn;
        } else {
            // base 地址更低，它仍然是新块的块头。
            // 那么 buddy 块就成了新块的后半部分。
            ClearPageProperty(buddy); // 清除 buddy 的空闲块首页标志。
            buddy->property = 0;      // 将 buddy 的 order 信息清零。
        }

        // 阶数加一，准备在下一轮检查这个新合并的、更大的块能否继续合并。
        order++;
    }

    // 合并循环结束后，将最终形成的（可能被合并过的）块加入其对应阶的空闲链表。
    base->property = order;
    SetPageProperty(base);
    list_add_tail(&free_list(order), &base->page_link);
    nr_free(order) += 1;

    // 为安全起见，再次确保最终块中所有页的引用计数都为 0。
    for (size_t i = 0; i < order2pages(order); i++) {
        set_page_ref(base + i, 0);
    }
}

/**
 * @brief 计算当前系统中所有空闲页的总数。
 * @return size_t 空闲页总数。
 *
 * 此函数会遍历每一阶的空闲链表，将（块数 * 每块的页数）累加起来。
 */
static size_t
buddy_system_nr_free_pages(void) {
    size_t sum = 0;
    for (int i = 0; i <= MAX_ORDER; i++) {
        // 累加：该阶的空闲块数量 * 该阶每个块的页数。
        sum += nr_free(i) * order2pages(i);
    }
    return sum;
}

/**
 * @brief 用于测试伙伴系统实现的正确性的检查函数。
 *
 * 通过一系列的分配、释放、分裂、合并等场景来验证算法的鲁棒性和正确性。
 */
static void
buddy_system_check(void) {
    // 记录初始空闲页总数
    size_t total = buddy_system_nr_free_pages();
    assert(total > 0);

    // === 1. 基本分配测试 ===
    struct Page *p0 = buddy_system_alloc_pages(1);
    assert(p0 != NULL);
    struct Page *p1 = buddy_system_alloc_pages(2);
    assert(p1 != NULL);
    struct Page *p2 = buddy_system_alloc_pages(4);
    assert(p2 != NULL);
    size_t left = buddy_system_nr_free_pages();
    assert(left < total);

    // === 2. 回收部分块，检查是否能恢复到初始状态 ===
    buddy_system_free_pages(p0, 1);
    buddy_system_free_pages(p1, 2);
    buddy_system_free_pages(p2, 4);
    assert(buddy_system_nr_free_pages() == total);

    // === 3. 分裂测试 ===
    // 分配一个大块，再分配两个小块，测试大块是否被正确分裂
    struct Page *p_big = buddy_system_alloc_pages(8);
    assert(p_big != NULL);
    struct Page *p_small1 = buddy_system_alloc_pages(1);
    struct Page *p_small2 = buddy_system_alloc_pages(1);
    assert(p_small1 && p_small2);
    buddy_system_free_pages(p_small1, 1);
    buddy_system_free_pages(p_small2, 1);
    buddy_system_free_pages(p_big, 8);
    assert(buddy_system_nr_free_pages() == total);

    // === 4. 合并测试 ===
    // 分配两个相邻的小块，然后释放它们，检查是否能正确合并成一个大块
    struct Page *a = buddy_system_alloc_pages(2);
    struct Page *b = buddy_system_alloc_pages(2);
    assert(a && b);
    buddy_system_free_pages(a, 2);
    buddy_system_free_pages(b, 2);
    assert(buddy_system_nr_free_pages() == total);

    // === 5. 连续分配耗尽测试 ===
    // 循环分配最小的块
    struct Page *allocs[1 << MAX_ORDER];
    int count = 0;
    for(int i = 0; i < (1 << MAX_ORDER); i++) {
        struct Page *p = buddy_system_alloc_pages(1);
        if (!p) break;
        allocs[count++] = p;
    }
    assert(buddy_system_nr_free_pages() == 0);
    // 全部释放，检查内存是否完全恢复
    for (int i = 0; i < count; i++) {
        buddy_system_free_pages(allocs[i], 1);
    }
    assert(buddy_system_nr_free_pages() == total);

    // === 6. 随机顺序释放测试 ===
    // 测试乱序释放是否也能正确合并
    struct Page *x1 = buddy_system_alloc_pages(1);
    struct Page *x2 = buddy_system_alloc_pages(1);
    struct Page *x3 = buddy_system_alloc_pages(2);
    assert(x1 && x2 && x3);
    buddy_system_free_pages(x2, 1);
    buddy_system_free_pages(x1, 1);
    buddy_system_free_pages(x3, 2);
    assert(buddy_system_nr_free_pages() == total);

    // === 7. 边界条件测试 ===
    // 测试分配一个过大的块，预期失败并返回 NULL
    struct Page *too_big = buddy_system_alloc_pages(1 << (MAX_ORDER + 1));
    assert(too_big == NULL);
}


/* ---- 导出 pmm_manager 结构体 ----
 * 这个结构体将伙伴系统的所有操作函数封装起来，提供给上层物理内存管理框架（PMM）统一调用。
 * PMM 框架通过这个结构体，可以像使用插件一样切换不同的内存分配算法（如 best-fit, buddy system 等）。
 */
const struct pmm_manager buddy_system_pmm_manager = {
    .name = "buddy_system_pmm_manager",
    .init = buddy_system_init,
    .init_memmap = buddy_system_init_memmap,
    .alloc_pages = buddy_system_alloc_pages,
    .free_pages = buddy_system_free_pages,
    .nr_free_pages = buddy_system_nr_free_pages,
    .check = buddy_system_check,

};
