#include <pmm.h>
#include <buddy_system_array_pmm.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

/*
 * 伙伴系统（Buddy System）物理内存管理器（PMM）—— 完全二叉树数组实现
 *
 * 核心思想：
 *   - 使用完全二叉树来表示内存的层次结构，树的每个节点代表一个内存块。
 *   - 节点编号从 1 开始（根节点），左右子节点分别为 2*i 和 2*i+1。
 *   - 树的深度 d（根节点深度为 0）表示该层节点代表的块大小为 2^(actual_order - d) 页。
 *   - 最深层（深度 = actual_order）的节点是叶节点，每个代表 1 页。
 *   - node_state 数组记录每个节点的状态：0=已分配，1=空闲，2=已分裂。
 *
 * 与链表实现的区别：
 *   - 链表实现通过双向链表管理空闲块，需要频繁的链表操作和伙伴查找。
 *   - 数组实现通过完全二叉树索引直接定位节点和伙伴，操作更简洁但需要固定大小的数组。
 */

#define MAX_ORDER 15                 // 系统支持的最大阶, 128MB
#define MAX_TREE_NODES ((1 << (MAX_ORDER + 1)) - 1) // 最大节点数：2^(MAX_ORDER+1) - 1

/* ----- 全局变量 ----- */

static struct Page *pages_base = NULL;        // 指向物理内存区域的起始 Page 结构体
static size_t total_pages = 0;                // 该内存区域包含的总页数
static int actual_order = 0;                  // 根节点实际表示的阶（取决于 total_pages）
static size_t tree_size = 0;                  // 完全二叉树的节点总数
static unsigned char node_state[MAX_TREE_NODES + 1]; // 节点状态数组，索引从 1 开始

/* 节点状态定义：
 *   0 = ALLOCATED（已分配）：整棵子树都已被分配，不可用
 *   1 = FREE（空闲）：整棵子树完全空闲，可以作为一个整块分配
 *   2 = SPLIT（已分裂）：节点已被分裂，子节点各自有独立的状态
 */

/* ----- 辅助函数 ----- */

/**
 * @brief 计算 floor(log2(x))，即找到不大于 x 的最大的 2 的幂的指数。
 * @param x 输入值，必须大于 0。
 * @return int log2(x) 的向下取整值。
 *
 * 例如：flog2(8) = 3, flog2(7) = 2, flog2(1) = 0
 * 这个函数用于确定可以容纳 x 个页面的最大完全二叉树的阶数。
 */
static int flog2(size_t x) {
    int r = -1;
    // 通过不断右移，统计最高位 1 的位置
    while (x) { 
        x >>= 1; 
        r++; 
    }
    return r;
}

/**
 * @brief 计算阶为 ord 的完全二叉树的节点总数。
 * @param ord 树的阶数。
 * @return size_t 节点总数，等于 2^(ord+1) - 1。
 *
 * 完全二叉树的节点数公式：如果树有 (ord+1) 层（深度从 0 到 ord），
 * 则节点总数为 1 + 2 + 4 + ... + 2^ord = 2^(ord+1) - 1。
 */
static size_t calc_tree_nodes(int ord) {
    return ((size_t)1 << (ord + 1)) - 1;
}

/**
 * @brief 返回树的第 d 层（深度为 d）的第一个节点的数组索引。
 * @param d 深度，根节点深度为 0。
 * @return size_t 该层第一个节点的索引，等于 2^d。
 *
 * 在完全二叉树中，第 d 层的节点索引范围是 [2^d, 2^(d+1) - 1]。
 * 例如：深度 0（根）：索引 1，深度 1：索引 2-3，深度 2：索引 4-7。
 */
static size_t level_first_index(int d) {
    return (size_t)1 << d;
}

/**
 * @brief 递归地将以 idx 为根的子树中所有节点的状态设置为 s。
 * @param idx 子树根节点的索引。
 * @param s 要设置的状态值（0/1/2）。
 * @param max_idx 树中有效节点的最大索引，防止越界。
 *
 * 这个函数用于快速初始化或重置整个子树的状态。
 * 例如，分配一个块时，将其整个子树标记为 ALLOCATED (0)。
 */
static void set_subtree_state(size_t idx, unsigned char s, int max_idx) {
    // 如果索引超出有效范围，停止递归
    if (idx > (size_t)max_idx) return;
    
    // 设置当前节点的状态
    node_state[idx] = s;
    
    // 计算左右子节点的索引
    size_t left = idx << 1;      // left = 2 * idx
    size_t right = left + 1;     // right = 2 * idx + 1
    
    // 递归设置左右子树
    if (left <= (size_t)max_idx) set_subtree_state(left, s, max_idx);
    if (right <= (size_t)max_idx) set_subtree_state(right, s, max_idx);
}

/**
 * @brief 在以 idx 为根的子树中递归查找目标深度的空闲节点。
 * @param idx 当前搜索的节点索引。
 * @param depth_cur 当前节点的深度。
 * @param target_depth 目标深度（要查找的空闲块所在的层）。
 * @param max_idx 有效节点的最大索引。
 * @return size_t 找到的空闲节点索引，如果没找到则返回 0。
 *
 * 这是分配算法的核心函数：
 * 1. 如果当前节点已分配（状态为 0），则该子树不可用，返回 0。
 * 2. 如果已达到目标深度且当前节点空闲（状态为 1），返回该节点。
 * 3. 如果当前节点空闲但未达到目标深度，需要"懒惰分裂"：
 *    - 将当前节点标记为 SPLIT (2)
 *    - 将其左右子节点初始化为 FREE (1)
 * 4. 递归在左右子树中继续查找。
 */
static size_t find_free_node(size_t idx, int depth_cur, int target_depth, int max_idx) {
    // 索引越界检查
    if (idx > (size_t)max_idx) return 0;
    
    unsigned char st = node_state[idx];
    
    // 如果当前节点已分配，整个子树不可用
    if (st == 0) return 0;
    
    // 如果已达到目标深度
    if (depth_cur == target_depth) {
        // 如果该节点空闲，返回它
        if (st == 1) return idx;
        // 否则（已分裂但子节点都被占用），返回 0
        return 0;
    }
    
    // 如果当前节点完全空闲（状态为 1），需要进行懒惰分裂
    if (st == 1) {
        node_state[idx] = 2; // 标记为已分裂
        size_t l = idx << 1;
        size_t r = l + 1;
        // 将左右子节点初始化为空闲状态
        if (l <= (size_t)max_idx) node_state[l] = 1;
        if (r <= (size_t)max_idx) node_state[r] = 1;
    }
    
    // 先尝试在左子树中查找
    size_t left = find_free_node(idx << 1, depth_cur + 1, target_depth, max_idx);
    if (left) return left;
    
    // 左子树没找到，尝试右子树
    return find_free_node((idx << 1) + 1, depth_cur + 1, target_depth, max_idx);
}

/**
 * @brief 计算给定节点 idx 在树中的深度。
 * @param idx 节点索引。
 * @return int 该节点的深度（根节点深度为 0）。
 *
 * 算法：根据完全二叉树的性质，深度为 d 的节点索引范围是 [2^d, 2^(d+1) - 1]。
 * 通过找到包含 idx 的范围来确定深度。
 */
static int node_depth(size_t idx) {
    int d = 0;
    size_t one = 1;
    // 找到满足 2^d <= idx < 2^(d+1) 的 d
    while (!(idx >= (one << d) && idx < (one << (d + 1)))) {
        d++;
    }
    return d;
}

/**
 * @brief 计算节点 idx 代表的内存块在 pages_base 中的起始页号（偏移量）。
 * @param idx 节点索引。
 * @return size_t 该块的起始页号（相对于 pages_base）。
 *
 * 计算步骤：
 * 1. 确定节点所在的深度 d。
 * 2. 计算该节点在其层中的相对位置 b = idx - 2^d。
 * 3. 计算该层节点代表的块大小 block_size = 2^(actual_order - d)。
 * 4. 起始页号 = b * block_size。
 *
 * 例如：actual_order=3（总共 8 页），深度 1 的节点（索引 2-3）各代表 4 页。
 *       索引 2 的起始页号 = (2-2) * 4 = 0
 *       索引 3 的起始页号 = (3-2) * 4 = 4
 */
static size_t node_start_page(size_t idx) {
    int d = node_depth(idx);
    size_t level_first = (size_t)1 << d;      // 该层第一个节点的索引
    size_t b = idx - level_first;             // 节点在该层中的偏移
    int k = actual_order - d;                 // 该层节点代表的块的阶
    size_t block_size = (size_t)1 << k;       // 块大小（页数）
    return b * block_size;
}

/**
 * @brief 分配后更新从 node_idx 到根的所有祖先节点的状态。
 * @param node_idx 刚刚被分配的节点索引。
 * @param max_idx 有效节点的最大索引。
 *
 * 更新规则：
 * - 从被分配的节点开始，向上遍历到根。
 * - 对于每个父节点，检查其左右子节点的状态：
 *   - 如果左右子节点都已分配（状态为 0），则父节点也标记为已分配（0）。
 *   - 否则，父节点标记为已分裂（2）。
 *
 * 这确保了树的状态一致性：如果一个节点的两个子节点都不可用，
 * 则该节点本身也应该被标记为不可用。
 */
static void update_ancestors_after_alloc(size_t node_idx, int max_idx) {
    size_t cur = node_idx;
    
    // 向上遍历到根节点（索引 1）
    while (cur > 1) {
        size_t parent = cur >> 1;      // parent = cur / 2
        size_t left = parent << 1;     // left = parent * 2
        size_t right = left + 1;       // right = parent * 2 + 1
        
        // 获取左右子节点的状态
        unsigned char ls = (left <= (size_t)max_idx) ? node_state[left] : 0;
        unsigned char rs = (right <= (size_t)max_idx) ? node_state[right] : 0;
        
        // 更新父节点状态
        node_state[parent] = (ls == 0 && rs == 0) ? 0 : 2;
        
        cur = parent;
    }
}

/**
 * @brief 释放后更新从 node_idx 到根的所有祖先节点的状态，并尝试合并。
 * @param node_idx 刚刚被释放的节点索引。
 * @param max_idx 有效节点的最大索引。
 *
 * 更新规则：
 * - 从被释放的节点开始，向上遍历到根。
 * - 对于每个父节点，检查其左右子节点的状态：
 *   - 如果左右子节点都完全空闲（状态为 1），则可以合并：
 *     将父节点及其整个子树都标记为空闲（1）。
 *   - 否则，父节点标记为已分裂（2）。
 *
 * 这实现了伙伴系统的自动合并机制：当两个伙伴块都空闲时，
 * 自动合并成一个更大的块。
 */
static void update_ancestors_after_free(size_t node_idx, int max_idx) {
    size_t cur = node_idx;
    
    // 向上遍历到根节点
    while (cur > 1) {
        size_t parent = cur >> 1;
        size_t left = parent << 1;
        size_t right = left + 1;
        
        // 获取左右子节点的状态（如果不存在则默认为空闲）
        unsigned char ls = (left <= (size_t)max_idx) ? node_state[left] : 1;
        unsigned char rs = (right <= (size_t)max_idx) ? node_state[right] : 1;
        
        // 如果两个子节点都完全空闲，可以合并
        if (ls == 1 && rs == 1) {
            // 将父节点及其整个子树标记为空闲
            set_subtree_state(parent, 1, max_idx);
        } else {
            // 否则标记为已分裂
            node_state[parent] = 2;
        }
        
        cur = parent;
    }
}

/* ----- 对外接口函数 ----- */

/**
 * @brief 初始化伙伴系统的所有数据结构。
 *
 * 此函数在 PMM 初始化阶段被调用，将所有全局变量重置为初始状态。
 */
static void buddy_system_array_init(void) {
    pages_base = NULL;
    total_pages = 0;
    actual_order = 0;
    tree_size = 0;
    // 清零整个状态数组
    memset(node_state, 0, sizeof(node_state));
}

/**
 * @brief 将一段连续的物理内存区域纳入伙伴系统管理。
 * @param base 这段内存区域的起始 Page 结构体指针。
 * @param n 这段内存区域包含的总页数。
 *
 * 此函数负责：
 * 1. 根据内存区域的大小（n 页）计算完全二叉树的阶数。
 * 2. 初始化完全二叉树，将所有节点标记为空闲（状态 1）。
 *
 * 注意：实际可用的内存可能小于 2^actual_order，因为我们向下取整。
 * 例如，如果 n=100，actual_order=6（2^6=64），实际只有 64 页可用。
 */
static void buddy_system_array_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    if (!base) return;

    // 记录内存区域的起始地址和大小
    pages_base = base;
    total_pages = n;

    // 计算可以容纳 n 个页面的最大完全二叉树的阶数
    // flog2(n) 返回满足 2^k <= n 的最大 k
    int fl = flog2(total_pages);
    actual_order = fl;
    
    // 确保不超过系统支持的最大阶
    if (actual_order > MAX_ORDER) actual_order = MAX_ORDER;

    // 计算树的节点总数
    tree_size = calc_tree_nodes(actual_order);

    // 初始化整棵树，所有节点标记为空闲（状态 1）
    for (size_t i = 1; i <= tree_size; i++) {
        node_state[i] = 1;
    }
}

/**
 * @brief 从伙伴系统中分配 n 个页。
 * @param n 请求分配的页数。
 * @return struct Page* 分配成功则返回块的首页指针，失败则返回 NULL。
 *
 * 分配过程：
 * 1. 将 n 向上舍入到最近的 2 的幂（例如，n=5 舍入到 8）。
 * 2. 计算对应的阶 k 和目标深度（depth = actual_order - k）。
 * 3. 调用 find_free_node 在树中查找目标深度的空闲节点。
 * 4. 如果找到，将该节点及其子树标记为已分配（状态 0）。
 * 5. 向上更新祖先节点的状态。
 * 6. 计算该节点对应的内存块起始地址并返回。
 */
static struct Page *buddy_system_array_alloc_pages(size_t n) {
    // 基本检查
    if (n == 0 || !pages_base) return NULL;

    /* 步骤 1: 将请求的页数 n 向上舍入到最近的 2 的幂 */
    size_t need = 1;
    int k = 0;
    // 找到最小的 k 使得 2^k >= n
    while (need < n) { 
        need <<= 1; 
        k++; 
    }
    
    // 如果请求的块太大，超过了系统能提供的最大块
    if (k > actual_order) return NULL;

    /* 步骤 2: 计算目标深度（要在哪一层查找节点）*/
    // 根节点（深度 0）代表 2^actual_order 页
    // 深度 d 的节点代表 2^(actual_order - d) 页
    // 所以要分配 2^k 页的块，应该在深度 (actual_order - k) 查找
    int target_depth = actual_order - k;
    int max_idx = (int)tree_size;

    /* 步骤 3: 在树中查找空闲节点 */
    size_t found = find_free_node(1, 0, target_depth, max_idx);
    if (!found) return NULL;  // 没有找到合适的空闲块

    /* 步骤 4: 将找到的节点及其子树标记为已分配 */
    set_subtree_state(found, 0, max_idx);
    
    /* 步骤 5: 向上更新祖先节点的状态 */
    update_ancestors_after_alloc(found, max_idx);

    /* 步骤 6: 计算该节点对应的物理内存地址 */
    size_t start_page = node_start_page(found);
    size_t block_size = (size_t)1 << k;
    
    // 安全检查：确保计算出的地址在有效范围内
    if (start_page + block_size > total_pages) {
        // 如果越界，撤销分配
        set_subtree_state(found, 1, max_idx);
        update_ancestors_after_free(found, max_idx);
        return NULL;
    }

    // 返回块的起始 Page 指针
    return pages_base + start_page;
}

/**
 * @brief 释放一个之前分配的内存块。
 * @param base 要释放的块的首页指针。
 * @param n 分配该块时请求的页数。
 *
 * 释放过程：
 * 1. 根据 base 和 n 计算出该块在树中对应的节点索引。
 * 2. 将该节点及其子树标记为空闲（状态 1）。
 * 3. 向上更新祖先节点，尝试合并伙伴块。
 *
 * 注意：必须确保 base 和 n 与分配时的参数一致，否则可能导致错误。
 */
static void buddy_system_array_free_pages(struct Page *base, size_t n) {
    // 基本检查
    if (!base || n == 0 || !pages_base) return;

    /* 步骤 1: 计算块在 pages_base 中的偏移量 */
    size_t off = base - pages_base;
    if (off >= total_pages) return;  // 地址越界

    /* 步骤 2: 将 n 向上舍入到最近的 2 的幂，确定块的实际大小 */
    size_t need = 1;
    int k = 0;
    while (need < n) { 
        need <<= 1; 
        k++; 
    }
    if (k > actual_order) return;

    size_t block_size = (size_t)1 << k;
    
    /* 步骤 3: 验证对齐 */
    // 伙伴系统要求块的起始地址必须是块大小的整数倍
    if (off % block_size != 0) return;

    /* 步骤 4: 计算该块在树中对应的节点索引 */
    int target_depth = actual_order - k;           // 该块所在的深度
    size_t level_first = (size_t)1 << target_depth; // 该层第一个节点的索引
    size_t block_index = off / block_size;         // 块在该层中的位置
    size_t node_idx = level_first + block_index;   // 节点的绝对索引
    
    int max_idx = (int)tree_size;
    // 索引有效性检查
    if (node_idx < 1 || node_idx > (size_t)max_idx) return;

    /* 步骤 5: 将该节点及其子树标记为空闲 */
    set_subtree_state(node_idx, 1, max_idx);
    
    /* 步骤 6: 向上更新祖先节点，尝试合并 */
    update_ancestors_after_free(node_idx, max_idx);
}

/**
 * @brief 计算当前系统中所有空闲页的总数。
 * @return size_t 空闲页总数。
 *
 * 此函数遍历整棵树，统计所有状态为 FREE (1) 的节点。
 * 为了避免重复计数，只统计"最大的空闲块"，即：
 * - 如果一个节点是空闲的（状态 1），且它的父节点不是空闲的，
 *   则该节点代表一个独立的空闲块。
 * - 根节点（索引 1）如果空闲，直接计数。
 *
 * 每个空闲节点贡献的页数 = 2^(actual_order - depth)。
 */
static size_t buddy_system_array_nr_free_pages(void) {
    size_t sum = 0;
    int max_idx = (int)tree_size;
    
    // 遍历树中的所有节点
    for (int idx = 1; idx <= max_idx; idx++) {
        // 只统计状态为 FREE 的节点
        if (node_state[idx] != 1) continue;
        
        // 如果不是根节点，检查父节点的状态
        if (idx != 1) {
            size_t parent = idx >> 1;
            // 如果父节点也是空闲的，说明这个节点已经被父节点包含了，跳过
            if (node_state[parent] == 1) continue;
        }
        
        // 计算该节点代表的块的大小（页数）
        int d = node_depth((size_t)idx);
        int k = actual_order - d;
        sum += (size_t)1 << k;
    }
    
    return sum;
}

/**
 * @brief 用于测试伙伴系统实现的正确性的检查函数。
 *
 * 通过一系列的分配、释放、合并等场景来验证算法的正确性。
 * 测试用例与链表实现的测试保持一致，确保两种实现的行为相同。
 */
static void
buddy_system_array_check(void) {
    // 记录初始空闲页总数
    size_t total = buddy_system_array_nr_free_pages();
    assert(total > 0);

    // === 1. 基本分配测试 ===
    struct Page *p0 = buddy_system_array_alloc_pages(1);
    assert(p0 != NULL);
    struct Page *p1 = buddy_system_array_alloc_pages(2);
    assert(p1 != NULL);
    struct Page *p2 = buddy_system_array_alloc_pages(4);
    assert(p2 != NULL);
    size_t left = buddy_system_array_nr_free_pages();
    assert(left < total);

    // === 2. 回收部分块，检查是否能恢复到初始状态 ===
    buddy_system_array_free_pages(p0, 1);
    buddy_system_array_free_pages(p1, 2);
    buddy_system_array_free_pages(p2, 4);
    assert(buddy_system_array_nr_free_pages() == total);

    // === 3. 分裂测试 ===
    // 分配一个大块，再分配两个小块，测试大块是否被正确分裂
    struct Page *p_big = buddy_system_array_alloc_pages(8);
    assert(p_big != NULL);
    struct Page *p_small1 = buddy_system_array_alloc_pages(1);
    struct Page *p_small2 = buddy_system_array_alloc_pages(1);
    assert(p_small1 && p_small2);
    buddy_system_array_free_pages(p_small1, 1);
    buddy_system_array_free_pages(p_small2, 1);
    buddy_system_array_free_pages(p_big, 8);
    assert(buddy_system_array_nr_free_pages() == total);

    // === 4. 合并测试 ===
    // 分配两个相邻的小块，然后释放它们，检查是否能正确合并成一个大块
    struct Page *a = buddy_system_array_alloc_pages(2);
    struct Page *b = buddy_system_array_alloc_pages(2);
    assert(a && b);
    buddy_system_array_free_pages(a, 2);
    buddy_system_array_free_pages(b, 2);
    assert(buddy_system_array_nr_free_pages() == total);

    // === 5. 连续分配耗尽测试 ===
    // 循环分配最小的块
    struct Page *allocs[1 << MAX_ORDER];
    int count = 0;
    for(int i = 0; i < (1 << MAX_ORDER); i++) {
        struct Page *p = buddy_system_array_alloc_pages(1);
        if (!p) break;
        allocs[count++] = p;
    }
    assert(buddy_system_array_nr_free_pages() == 0);
    // 全部释放，检查内存是否完全恢复
    for (int i = 0; i < count; i++) {
        buddy_system_array_free_pages(allocs[i], 1);
    }
    assert(buddy_system_array_nr_free_pages() == total);

    // === 6. 随机顺序释放测试 ===
    // 测试乱序释放是否也能正确合并
    struct Page *x1 = buddy_system_array_alloc_pages(1);
    struct Page *x2 = buddy_system_array_alloc_pages(1);
    struct Page *x3 = buddy_system_array_alloc_pages(2);
    assert(x1 && x2 && x3);
    buddy_system_array_free_pages(x2, 1);
    buddy_system_array_free_pages(x1, 1);
    buddy_system_array_free_pages(x3, 2);
    assert(buddy_system_array_nr_free_pages() == total);

    // === 7. 边界条件测试 ===
    // 测试分配一个过大的块，预期失败并返回 NULL
    struct Page *too_big = buddy_system_array_alloc_pages(1 << (MAX_ORDER + 1));
    assert(too_big == NULL);
}

/* ---- 导出 pmm_manager 结构体 ----
 * 这个结构体将伙伴系统的所有操作函数封装起来，提供给上层物理内存管理框架（PMM）统一调用。
 * PMM 框架通过这个结构体，可以像使用插件一样切换不同的内存分配算法。
 * 
 * 与链表实现相比，数组实现的特点：
 * - 优点：索引访问快速，代码结构清晰，伙伴查找通过位运算直接完成
 * - 缺点：需要预先分配固定大小的数组，空间利用率可能不如链表实现
 */
const struct pmm_manager buddy_system_array_pmm_manager = {
    .name = "buddy_system_array_pmm_manager",
    .init = buddy_system_array_init,
    .init_memmap = buddy_system_array_init_memmap,
    .alloc_pages = buddy_system_array_alloc_pages,
    .free_pages = buddy_system_array_free_pages,
    .nr_free_pages = buddy_system_array_nr_free_pages,
    .check = buddy_system_array_check,
};