# 简易SLUB分配器设计文档
## 概述
本SLUB分配器是一个针对小内存对象的高效内存管理器，作为页分配器的补充，专门处理8B到1024B的小内存分配请求。

## 设计目标
- 提供高效的小内存分配和释放

- 减少内存碎片

- 与现有页分配器无缝集成

- 支持不同大小的对象缓存

## 核心数据结构
### `kmem_cache_t`
内存缓存结构，管理特定大小的对象：

`name`: 缓存名称

`obj_size`: 对象大小

`partial`: 部分使用的slab链表

`current_slab`: 当前活跃的slab

### `slab_t`
内存页管理结构：

`list`: 链表节点，用于连接到partial链表

`current`: 当前分配位置指针

`end`: slab结束边界

`used`: 已使用对象计数

`cache`: 所属缓存指针

`page`: 对应的物理页


## 核心算法
### 分配流程 (slub_kmalloc)
1. 请求大小>1024B：直接调用页分配器

2. 请求大小≤1024B：

- 找到对应的对象缓存

- 从current_slab分配

- 如果current_slab已满，从partial链表获取

- 如果partial链表为空，创建新slab

### 释放流程 (slub_kfree)
1. 找到对象所在的slab

2. 减少使用计数

3. 如果slab完全空闲：释放整个页

4. 如果slab部分使用且不是current_slab：加入partial链表

### 缓存大小配置
预设8种对象大小：

8B, 16B, 32B, 64B

128B, 256B, 512B, 1024B


## 接口说明
```c
struct pmm_cache_manager {
    const char *name;
    void (*init)(void);           // 初始化SLUB分配器
    void *(*kmalloc)(size_t size); // 分配内存
    void (*kfree)(void *ptr);     // 释放内存
    void (*check)(void);          // 完整性检查
};
```
## 性能特点
O(1)时间复杂度的小对象分配

极低的内存开销（每个slab一个管理头）

良好的空间利用率（对象紧密排列）

可分配最小8Byte对象

## 测试验证
包含完整的测试：

- 基本分配/释放测试

- 数据完整性验证

- 边界情况处理

- 压力测试和混合测试
