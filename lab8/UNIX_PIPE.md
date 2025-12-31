# 在 uCore 中加入 UNIX Pipe 机制：数据结构与接口设计（概要方案）

> 目标：在 uCore 中实现 **匿名管道（pipe）**：`pipe()` 创建一对 fd（读端/写端），形成 **单向字节流** IPC 通道；支持阻塞/非阻塞、EOF/SIGPIPE/EPIPE 语义，并在多进程/多 fd（fork/dup）场景下正确处理同步互斥与资源回收。

---

## 1. 需求与语义对齐（参考 Linux/POSIX）

### 1.1 基本模型：单向字节流 + 两个端点

* Pipe/FIFO 提供 **单向**进程间通信：有 **read end** 与 **write end**，写入端的数据从读取端读出。([man7.org][1])
* `pipe()` 创建新管道并返回两个 fd：一个指向读端，一个指向写端。([man7.org][1])
* Pipe 是 **字节流**：不保留消息边界（无 message boundary）。([man7.org][1])

### 1.2 阻塞/非阻塞（empty/full）

* 读空管道：`read()` 阻塞直到有数据。([man7.org][1])
* 写满管道：`write()` 阻塞直到有空间。([man7.org][1])
* 开启 `O_NONBLOCK`：空读/满写可失败并返回 `EAGAIN`（pipe(7) 给出详细规则）。([man7.org][1])

### 1.3 关闭端点后的 EOF / SIGPIPE / EPIPE

* 所有写端都关闭：读端 `read()` 看到 EOF，返回 0。([man7.org][1])
* 所有读端都关闭：`write()` 触发 `SIGPIPE`；若忽略该信号则 `write()` 失败并置 `EPIPE`。([man7.org][1])

### 1.4 原子性：PIPE_BUF

* POSIX 要求：写入 **小于 PIPE_BUF** 的一次 `write()` 必须原子（数据连续、不与其他写者交叉）；写入 **大于 PIPE_BUF** 可被交错。POSIX 要求 PIPE_BUF 至少 512 字节；pipe(7) 也给出了阻塞/非阻塞下的精确语义分支。([man7.org][1])

---

## 2. uCore 落点：把 pipe 作为一种 “文件类型（FD_PIPE）”

uCore 教程常见做法：将 pipe 两端抽象成两个 `struct file`，通过 `sys_read/sys_write` 走统一文件读写路径；`fileclose()` 在 `FD_PIPE` 时调用 `pipeclose()`。([uCore-Tutorial-Book][2])

> 本方案遵循同样的总体结构，但将教程中简单的“yield 等待”升级为 **互斥锁 + 等待队列**，避免忙等并解决丢唤醒/竞态问题。

---

## 3. 需要定义的数据结构

### 3.1 `struct file`

uCore 教程中强调 `file.ref` 的引用计数与 `FD_PIPE` 分派（`fileclose()` 对 pipe 单独处理）。([uCore-Tutorial-Book][2])

```c
// file.h
typedef enum {
    FD_NONE = 0,
    FD_PIPE,
    FD_INODE,
    // ...
} fd_type_t;

struct pipe;  // forward decl

struct file {
    fd_type_t type;
    int ref;                 // file 对象引用计数（dup/fork 影响）
    int readable;
    int writable;
    int flags;               // 可选：O_NONBLOCK 等

    union {
        struct pipe *pipe;   // FD_PIPE
        void *inode;         // FD_INODE（示意）
    };

    // off 对 pipe 无意义，可保留给其它类型
};
```

### 3.2 `struct pipe`（核心共享对象：环形缓冲区 + 端点计数 + 同步原语）

Linux 内核 pipe 的核心结构 `pipe_inode_info` 包含：**mutex、wait queue、readers/writers/files** 等字段，用于同步与端点/引用管理。([Cregit][3])

uCore 里我们实现一个“足够用且语义清晰”的版本（以 ring buffer 存字节）：

```c
// pipe.h
#include <stdint.h>
#include <stddef.h>

#define PIPE_SIZE 4096     // 可选：512/4096；
#define PIPE_BUF  512      // 原子写保障阈值（至少 512；也可设为 PIPE_SIZE）

// 这些类型名按 uCore 现有实现替换：mutex / wait_queue / condvar 等
typedef struct mutex      mutex_t;
typedef struct wait_queue wait_queue_t;

struct pipe {
    // ===== 数据缓冲：环形队列 =====
    uint8_t  buf[PIPE_SIZE];
    uint32_t rpos;         // 读指针（可单调递增，访问时对 PIPE_SIZE 取模）
    uint32_t wpos;         // 写指针
    uint32_t used;         // 当前可读字节数 [0, PIPE_SIZE]

    // ===== 端点状态：用于 EOF/EPIPE 判断 =====
    uint32_t readers;      // 当前打开的“读端 file”数量
    uint32_t writers;      // 当前打开的“写端 file”数量

    // ===== 同步互斥 =====
    mutex_t      lock;     // 保护 buf/rpos/wpos/used/readers/writers 等共享状态
    wait_queue_t rd_wait;  // 条件：used > 0 或 writers == 0(EOF)
    wait_queue_t wr_wait;  // 条件：used < PIPE_SIZE 或 readers == 0(EPIPE)

    // ===== 资源管理 =====
    int refcnt;            // pipe 对象被多少 file 引用（用于最终释放）
};
```

#### 端点计数与引用计数的约定（关键）

* `file.ref`：描述 **同一个 file 对象**被多少 fd 引用（dup/fork 会增加）。([uCore-Tutorial-Book][2])
* `pipe.readers / pipe.writers`：描述 **逻辑端点是否仍存在**。

  * 建议：仅当某个 `struct file` 的 `ref` 从 1 变 0（真正销毁该 file 对象）时，才对 `pipe.readers` 或 `pipe.writers` 执行 `--`。
  * 这样能正确覆盖 fork/dup 情况，避免“还有 fd 但端点被误判关闭”。

---

## 4. 需要提供的接口

### 4.1 系统调用：`sys_pipe(int pipefd[2])`

语义：

1. 创建并初始化 `struct pipe *p`：`used=0, rpos=wpos=0, readers=1, writers=1, refcnt=2`，初始化锁与等待队列。
2. 分配两个 `struct file`：

   * `f0`：`type=FD_PIPE, readable=1, writable=0, pipe=p`
   * `f1`：`type=FD_PIPE, readable=0, writable=1, pipe=p`
     uCore 教程同样将 pipe 两端抽象为两个文件对象并设置可读/可写属性。([uCore-Tutorial-Book][2])
3. 在当前进程 fd 表中分配两个空闲 fd（例如从 3 开始），分别绑定 `f0/f1`。([uCore-Tutorial-Book][2])
4. 返回 `pipefd[0]=read_fd, pipefd[1]=write_fd`。

> 可选扩展：`sys_pipe2(int pipefd[2], int flags)`（支持 `O_NONBLOCK` 等 open-file-status flag；pipe(7) 指出对 pipe 有意义的主要 flags 是 O_NONBLOCK/O_ASYNC）。([man7.org][1])

---

### 4.2 fileops / VFS 分派接口（FD_PIPE 专用）

可采用两种接入方式：

* **方式 A：**在 `sys_read/sys_write/sys_close` 内按 `file->type` 分派；
* **方式 B：**引入 `fileops` 表：`file->ops->read/write/close`。

至少要有：

```c
ssize_t pipe_read (struct file *f, void *ubuf, size_t n);
ssize_t pipe_write(struct file *f, const void *ubuf, size_t n);
int     pipe_close(struct file *f);
int     pipe_fcntl(struct file *f, int cmd, unsigned long arg); // 可选：O_NONBLOCK
```

---

## 5. 接口语义详述（含同步互斥策略）

> 下面的语义严格对齐 pipe(7) 的行为描述（empty/full 阻塞、EOF、SIGPIPE/EPIPE、PIPE_BUF 原子性）。([man7.org][1])

### 5.1 `pipe_read(f, ubuf, n)` 语义

前置检查：

* 若 `!f->readable`：返回 `-EBADF`。

核心逻辑（需要 `p->lock` 保护，并使用 **while 循环**防止虚假唤醒）：

1. 加锁 `lock`。
2. 若 `p->used > 0`：

   * 从 ring buffer 拷贝 `k = min(n, p->used)` 字节到用户缓冲区；
   * 更新 `p->rpos += k; p->used -= k;`
   * `wakeup(p->wr_wait)`（让写者知道出现空位）；
   * 解锁并返回 `k`（允许短读）。
3. 若 `p->used == 0` 且 `p->writers == 0`：

   * 解锁并返回 `0`（EOF）。([man7.org][1])
4. 若 `p->used == 0` 且 `p->writers > 0`：

   * 若 `O_NONBLOCK`：解锁并返回 `-EAGAIN`（空读非阻塞失败）。([man7.org][1])
   * 否则：将当前线程睡眠在 `rd_wait`：

     * 必须保证 “入队睡眠 + 释放锁” 原子化（典型 `sleep(queue, &lock)` 模式）；醒来后重新加锁，回到步骤 2 重新检查条件。

### 5.2 `pipe_write(f, ubuf, n)` 语义

前置检查：

* 若 `!f->writable`：返回 `-EBADF`。

核心逻辑：

1. 加锁 `lock`。
2. 若 `p->readers == 0`：

   * 按 UNIX 语义：`write()` 触发 `SIGPIPE`；若忽略则返回 `EPIPE`。在 uCore 若暂不支持信号，至少返回 `-EPIPE` 并失败。([man7.org][1])
3. 写入分两类讨论（原子性要求来自 PIPE_BUF 规则）：([man7.org][1])

#### (A) `n <= PIPE_BUF`：必须原子写（建议实现方式）

* 若 `PIPE_SIZE - p->used < n`：

  * 若 `O_NONBLOCK`：解锁并返回 `-EAGAIN`（要求 “要么全写入、要么失败”）。([man7.org][1])
  * 否则：睡眠在 `wr_wait`（释放锁、醒来重试）。
* 若空间足够：一次性写入 n 字节并提交（更新 `wpos/used`），然后 `wakeup(rd_wait)`，解锁并返回 `n`。
* 这样可确保多写者并发时，`<= PIPE_BUF` 的写不会交叉，满足“原子性/连续性”要求。([man7.org][1])

#### (B) `n > PIPE_BUF`：允许非原子、可分段

* 阻塞模式：允许循环写入，缓冲区满则睡眠等待；最终尽可能把 n 字节写完（pipe(7) 说明可能交错）。([man7.org][1])
* 非阻塞模式：若 pipe 为空位不足，可发生 partial write（返回已写字节数，或若完全写不进则 `-EAGAIN`）。([man7.org][1])

### 5.3 `pipe_close(f)` 语义（端点关闭与唤醒）

当 `file.ref` 递减至 0 时（真正关闭该 file 对象），才执行：

1. 加锁 `p->lock`。
2. 若关闭的是读端：`p->readers--`，并 `wakeup(wr_wait)`：让潜在写者及时观察到 `readers==0` 并返回 `EPIPE`。([man7.org][1])
3. 若关闭的是写端：`p->writers--`，并 `wakeup(rd_wait)`：让潜在读者及时观察到 `writers==0` 并返回 EOF(0)。([man7.org][1])
4. 维护 `p->refcnt--`；若 `p->refcnt==0`（且 readers/writers 都为 0）则释放 pipe 对象。

---

## 6. 同步互斥问题分析与处理方案

### 6.1 典型竞态与“丢唤醒”风险

* **空读准备睡眠时，写者可能刚写入并唤醒**：如果“检查条件/入队/释放锁”不是原子序列，会丢失唤醒导致读者永久睡眠。
* **满写准备睡眠时，读者可能刚读出并唤醒**：同理。
* **close 与阻塞读写并发**：

  * 写端全关：阻塞读者必须被唤醒并返回 EOF。
  * 读端全关：阻塞写者必须被唤醒并失败（EPIPE/SIGPIPE）。([man7.org][1])

### 6.2 解决：mutex + 等待队列（条件变量范式）

* 使用 **可睡眠 mutex** 保护 pipe 共享状态；
* 使用两个等待队列：

  * `rd_wait`：等待“可读”（`used>0` 或 `writers==0`）
  * `wr_wait`：等待“可写”（`used<PIPE_SIZE` 或 `readers==0`）
* 所有阻塞点采用：

  * `while (!cond) sleep(queue, &lock);`
  * 由 `sleep()` 内部完成 “释放锁 + 入队睡眠” 的原子操作，避免丢唤醒。

> Linux 内核 pipe 的结构也围绕 “mutex + wait + readers/writers/files” 来实现同步与端点管理，可作为设计合理性的参考。([Cregit][3])

---

## 7. 与 fork/dup 的交互（必须覆盖）

* uCore 教程中 `file.ref` 体现了文件对象引用计数：关闭时若 `--ref > 0` 则不真正关闭；当类型为 `FD_PIPE` 时会走 `pipeclose()`。([uCore-Tutorial-Book][2])
* 因此本方案要求：

  1. `dup()` / `fork()`：增加 `file.ref`（或复制 fd 指针并增加 ref）。
  2. 只有当 `file.ref` 降至 0 时，才对 `pipe.readers/writers` 递减并触发 EOF/EPIPE 语义。
* pipe(7) 也明确提示：使用 `pipe()+fork()` 的程序应关闭不需要的重复 fd，才能正确触发 EOF 与 SIGPIPE/EPIPE。([man7.org][1])

---

## 8. 最小实现清单（“至少需要哪些数据结构与接口”）

### 8.1 必需数据结构

* `struct pipe`（必须包含）：

  * ring buffer（或等价缓冲结构）
  * 读写位置与 `used`
  * `readers/writers`（决定 EOF/EPIPE）
  * `mutex + wait_queue`（解决阻塞与同步互斥）
  * 引用计数 `refcnt`
* `struct file`（至少支持）：

  * `type=FD_PIPE`
  * `ref/readable/writable/flags`
  * `pipe*` 指针

> uCore 教程中已给出简化 `struct pipe` 与 pipe 分配/关闭/读写的大体框架（但读写用 `yield()` 忙等）。本方案是在该框架上补齐同步互斥与 UNIX 语义。([uCore-Tutorial-Book][2])

### 8.2 必需接口（语义级）

* `sys_pipe(int pipefd[2])`（可选 `sys_pipe2`）
* `pipe_read / pipe_write / pipe_close`（挂到 `sys_read/sys_write/sys_close` 的分派或 fileops）
* （可选）`pipe_fcntl`：支持 `O_NONBLOCK` 等

---

## 参考资料

* Linux man-pages：pipe(7)（empty/full 阻塞、EOF、SIGPIPE/EPIPE、PIPE_BUF 原子性与 O_NONBLOCK 细则）。([man7.org][1])
* Linux 内核历史头文件 `include/linux/pipe_fs_i.h`（pipe_inode_info 的 mutex/wait/readers/writers/files 等字段，体现同步与端点计数设计）。([Cregit][3])
* uCore Tutorial Book（FD/FILE 引用计数、FD_PIPE 分派、pipe 抽象成文件对象及基础 pipe 结构示例）。([uCore-Tutorial-Book][2])

[1]: https://www.man7.org/linux/man-pages/man7/pipe.7.html "pipe(7) - Linux manual page"
[2]: https://exusial.github.io/uCore-Tutorial-Book/chapter6/1file-descriptor.html "文件系统初步 — uCore-Tutorial-Book-v2 0.1 文档"
[3]: https://cregit.linuxsources.org/code/4.10/include/linux/pipe_fs_i.h.html "include/linux/pipe_fs_i.h · cregit-Linux"
