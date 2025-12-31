# 在 uCore 中加入 UNIX 硬链接与软链接机制的设计报告

## 摘要

本文给出一个面向 uCore（类 UNIX 教学 OS）的**硬链接（hard link）**与**软链接/符号链接（symbolic link, symlink）**机制的概要设计方案。设计目标对齐 Linux/POSIX 的关键语义：硬链接共享同一 inode、禁止对目录创建硬链接、禁止跨文件系统硬链接；软链接以“保存目标路径字符串”的方式存在，并在路径解析时按规则展开；支持 `lstat/stat` 的跟随差异、`readlink` 不自动补 `\0`、路径解析中 symlink 递归上限与 `ELOOP`；并给出一套可落地的**数据结构（C struct）**、**VFS/系统调用接口语义**、**namei 路径解析改造点**与**同步互斥/死锁规避策略**。本文同步与锁规则参考 Linux 内核目录锁文档的分类与加锁顺序。 ([Linux 内核文档][1])

---

## 1. 需求与语义目标

### 1.1 硬链接（link）

* **语义**：`link(oldpath, newpath)` 在 `newpath` 的父目录中创建一个新目录项，使其指向 `oldpath` 对应的 **同一个 inode**，从而“两个名字，一个对象”。 ([man7.org][2])
* **限制**：

  1. **禁止对目录创建硬链接**：Linux `link(2)` 明确给出 `EPERM oldpath is a directory`。 ([man7.org][2])
  2. **禁止跨文件系统**：若 `oldpath` 与 `newpath` 不在同一挂载文件系统，返回 `EXDEV`。 ([man7.org][2])
* **链接计数**：inode 需要持久化 `nlink`。建立硬链接：`nlink++`；删除目录项：`nlink--`；当最后一个链接消失且没有打开引用时，才回收对象。 ([手册页][3])

### 1.2 软链接（symlink/readlink）

* **语义**：`symlink(target, linkpath)` 创建一个类型为 symlink 的新 inode，其“文件内容”保存字符串 `target`；路径解析时等价于把该字符串替换进待解析路径继续解析。 ([Arch手册页][4])
* **readlink**：`readlink(path, buf, bufsiz)` 返回写入 `buf` 的字节数，**不附加 NUL 终止符**，可能因缓冲区过小而截断。 ([EuroLinux Manpages][5])

### 1.3 unlink 删除语义（删除“名字”，不一定删除“对象”）

* `unlink(path)` 删除目录项并递减 inode 的链接计数；若减到 0 且 **没有进程打开该文件**，才回收资源；若仍有打开引用，则延迟到最后一个引用关闭再回收。 ([手册页][3])
* 若 `path` 是 symlink：`unlink` 删除的是 **symlink 本身**，不影响其指向的目标。 ([OmniOS手册][6])

### 1.4 `stat/lstat` 与“最后一段是否跟随”

* `lstat`：若 `path` 最后一段是 symlink，返回 symlink 自身信息；`stat` 则返回其指向目标的文件信息。 ([man7.org][7])

### 1.5 symlink 递归上限与 `ELOOP`，以及 `O_NOFOLLOW`

* Linux 路径解析对 symlink 跟随次数设上限：**最多 40 次**，超过返回 `ELOOP`。 ([man7.org][8])
* `open(path, O_NOFOLLOW)`：若 `path` 的**最后一段**是 symlink，则 open 失败并返回 `ELOOP`。 ([man7.org][9])

---

## 2. 总体设计：uCore 中需要补齐的模块与职责

为最小可用实现，建议在 uCore 的“VFS + 具体 FS（如 SFS）”层面完成：

1. **VFS inode/dirent 数据结构扩展**：引入 inode 类型 `IT_LNK`、持久化 `i_nlink`、以及可选的“symlink 目标存储区”。
2. **VFS 接口扩展**：增加/补齐 `link/unlink/symlink/readlink/getattr` 等 inode 操作。
3. **namei（路径解析）扩展**：实现 symlink 展开、递归次数限制、最后一段是否跟随（用于 `lstat`/`O_NOFOLLOW`）。 ([man7.org][8])
4. **同步互斥**：采用“每 inode 锁 + 每文件系统锁”的组合，严格遵循锁顺序，避免死锁；该模式与 Linux 目录锁文档一致。 ([Linux 内核文档][1])

---

## 3. 数据结构设计（C struct）

> 说明：以下是“至少需要”的字段集合；若 uCore 已有类似结构，可视为在现有结构上增加字段或等价映射。

### 3.1 inode（内存态/VFS）

```c
#include <stdint.h>
#include <stddef.h>

#define NAME_MAX       255
#define PATH_MAX       4096
#define SYMLOOP_MAX    40   // 对齐 Linux 上限

typedef enum {
    IT_REG = 1,
    IT_DIR = 2,
    IT_LNK = 3,   // symlink
    IT_DEV = 4,
} inode_type_t;

/* 用 uCore 现有 mutex/sleeplock 实现替换 */
typedef struct mutex {
    int dummy;
} mutex_t;

struct inode_ops;

typedef struct inode {
    uint32_t          i_ino;      // inode number
    inode_type_t      i_type;     // 必须包含 IT_LNK
    uint32_t          i_mode;     // 可选：权限位
    uint32_t          i_nlink;    // 必须：硬链接计数
    uint64_t          i_size;     // symlink: target 长度；普通文件: 文件长度
    uint32_t          i_refcnt;   // 打开引用计数（unlink 延迟回收用）
    void             *i_fs_info;  // 具体 FS 私有信息（磁盘 inode 缓存等）
    struct inode_ops *i_ops;      // VFS 操作表
    mutex_t           i_lock;     // inode 锁：保护 i_nlink/i_size/数据等
} inode_t;
```

### 3.2 目录项（dirent）

硬链接的本质是“**多个目录项指向同一 inode**”，因此目录项必须包含 `ino`。

```c
typedef struct dirent {
    uint32_t ino;                 // 指向的 inode number
    uint16_t reclen;              // 目录项长度（可固定）
    uint8_t  type;                // 可选：DT_REG/DT_DIR/DT_LNK...
    char     name[NAME_MAX + 1];
} dirent_t;
```

### 3.3 file（打开文件对象）

用于实现 `unlink` 的“最后链接删除但仍被打开”延迟回收语义。 ([手册页][3])

```c
typedef struct file {
    inode_t  *f_inode;
    uint64_t  f_pos;
    uint32_t  f_flags;     // O_NOFOLLOW 等
    uint32_t  f_refcnt;
} file_t;
```

### 3.4 superblock（文件系统级锁：跨目录操作死锁保险）

Linux 目录锁设计中使用 per-inode 锁与 per-fs 锁（`s_vfs_rename_mutex`）配合。uCore 可引入类似全局锁用于跨目录 rename/link 等复杂元数据操作。 ([Linux 内核文档][1])

```c
typedef struct superblock {
    mutex_t s_rename_lock;   // 类似 Linux 的 per-fs rename mutex
    // 其他：块设备、位图、inode 表等
} superblock_t;
```

### 3.5 磁盘态 inode（建议：支持“短 symlink 内联存储”）

在 ext4 中，若 symlink 目标字符串长度 < 60 字节，可直接存入 inode 固定区域；否则用数据块存储。uCore 可借鉴该思路，减少一次数据块分配。 ([Linux Kernel Archives][10])

```c
#define INLINE_SYMLINK_MAX 60

typedef struct dinode {
    uint32_t i_ino;
    uint16_t i_type;                 // IT_REG/IT_DIR/IT_LNK
    uint16_t i_mode;
    uint32_t i_nlink;
    uint64_t i_size;

    uint32_t i_direct[12];
    uint32_t i_indirect;

    char     i_inline_symlink[INLINE_SYMLINK_MAX]; // 仅 IT_LNK 且短目标使用
} dinode_t;
```

---

## 4. 接口设计（语义即可，不要求具体实现）

### 4.1 系统调用（user → kernel）

建议至少实现以下 syscall（命名可按 uCore 风格调整）：

1. `int sys_link(const char *oldpath, const char *newpath);`

* 在 `newpath` 的父目录新增目录项指向 `oldpath` 的 inode。
* `oldpath` 为目录：返回 `-EPERM`。 ([man7.org][2])
* 跨文件系统：返回 `-EXDEV`。 ([man7.org][2])

2. `int sys_unlink(const char *path);`

* 删除目录项并 `nlink--`；若 `nlink==0` 且无打开引用则回收，否则延迟。 ([手册页][3])
* 若 `path` 为 symlink：删除 symlink 本身，不影响目标。 ([OmniOS手册][6])

3. `int sys_symlink(const char *target, const char *linkpath);`

* 创建 symlink inode，保存字符串 `target`。 ([Arch手册页][4])

4. `ssize_t sys_readlink(const char *path, char *buf, size_t bufsiz);`

* 读取 symlink 内容到 `buf`，**不补 `\0`**，返回写入字节数。 ([EuroLinux Manpages][5])

5. `int sys_lstat(const char *path, struct stat *st);`

* 最后一段是 symlink 时，返回 symlink 自身信息（不跟随）；`stat` 则跟随。 ([man7.org][7])

（可选增强：实现 `linkat/symlinkat/unlinkat` 用于相对目录 fd 的原子性与安全性，但非最小集。）

### 4.2 VFS inode 操作表（核心）

```c
typedef struct inode_ops {
    int     (*lookup)(inode_t *dir, const char *name, inode_t **out);
    int     (*create)(inode_t *dir, const char *name, inode_t **out);
    int     (*mkdir)(inode_t *dir, const char *name, inode_t **out);

    int     (*link)(inode_t *dir, const char *name, inode_t *src);
    int     (*unlink)(inode_t *dir, const char *name);

    int     (*symlink)(inode_t *dir, const char *name, const char *target);
    ssize_t (*readlink)(inode_t *lnk, char *buf, size_t bufsiz);

    int     (*getattr)(inode_t *node, struct stat *st);
} inode_ops_t;
```

---

## 5. namei（路径解析）设计：支持 symlink 展开与 NOFOLLOW

### 5.1 关键参数（flags）设计

* `LOOKUP_FOLLOW`：默认跟随中间 symlink；最终是否跟随由调用者决定。
* `LOOKUP_NOFOLLOW_FINAL`：最终分量为 symlink 则不展开（用于 `lstat`、以及 `open(O_NOFOLLOW)`）。
* `follow_cnt`：记录已跟随 symlink 次数，超过 `SYMLOOP_MAX=40` 返回 `-ELOOP`。 ([man7.org][8])

### 5.2 展开规则（实现要点）

当解析到某个分量 inode 类型为 `IT_LNK`：

1. 调用 `readlink` 取出 `target` 字符串。 ([EuroLinux Manpages][5])
2. 若 `target` 为绝对路径：从进程 root/cwd 规则重新开始；若为相对路径：以当前目录为基准继续。
3. 把 `target` 与剩余未解析后缀拼接成新的待解析路径。
4. `follow_cnt++`，若 > 40，返回 `-ELOOP`。 ([man7.org][8])

### 5.3 `O_NOFOLLOW` 的实现映射

`open(path, O_NOFOLLOW)` 只要求“最后一段不跟随”，并在最后一段为 symlink 时返回 `ELOOP`。 ([man7.org][9])
实现方式：`namei(path, LOOKUP_NOFOLLOW_FINAL)`，若解析得到的最终 inode 是 `IT_LNK`，直接返回 `-ELOOP`。

---

## 6. 同步互斥与一致性：避免 nlink 错乱与目录死锁

### 6.1 锁模型选型

参考 Linux 目录锁文档：目录操作使用两类锁

* **每 inode 锁**（Linux：`->i_rwsem`）
* **每文件系统锁**（Linux：`->s_vfs_rename_mutex`）
  并规定多把锁的获取顺序以避免死锁。uCore 可简化为互斥锁，但必须遵循相同的“先后顺序”思想。 ([Linux 内核文档][1])

### 6.2 基本不变量（必须保证）

* 目录项插入/删除与 inode `i_nlink` 修改必须在互斥下完成，否则并发 `link/unlink` 会造成 `nlink` 计数错误（可能导致“过早回收”或“泄漏”）。
* `unlink` 的“延迟回收”必须以 `i_refcnt`（打开引用数）为依据，符合 UNIX 语义。 ([手册页][3])

### 6.3 `link()` 的推荐加锁顺序（对齐 Linux 文档的“链接创建”类）

Linux 文档给出“链接创建”的锁规则：锁父目录（独占）→检查源不是目录→锁源对象。 ([Linux 内核文档][1])
uCore 建议：

1. `lock(parent_dir->i_lock)`
2. 检查 `src->i_type != IT_DIR`，否则 `-EPERM`。 ([man7.org][2])
3. `lock(src->i_lock)`
4. 写目录项 `name -> src->i_ino`
5. `src->i_nlink++` 并落盘
6. 解锁（先 src 再 parent）

### 6.4 `unlink()` 的推荐加锁顺序（对齐 Linux 文档的“对象删除”类）

Linux 文档给出“对象删除”：锁父目录（独占）→找到受害者→锁受害者（独占）。 ([Linux 内核文档][1])
uCore 建议：

1. `lock(parent_dir->i_lock)`
2. `lookup` 得到 victim inode（增加内存引用/临时 pin）
3. `lock(victim->i_lock)`
4. 删除目录项；`victim->i_nlink--` 并落盘
5. 若 `victim->i_nlink==0 && victim->i_refcnt==0`：回收数据块与 inode；否则标记“待回收”，等待最后 close。 ([手册页][3])
6. 解锁（先 victim 再 parent）

### 6.5 symlink 的同步

* `symlink()`：锁父目录创建目录项；初始化新 inode（写入 target 与 size）；落盘。 ([Arch手册页][4])
* `readlink()`：只需锁 symlink inode 以避免并发读写不一致。 ([EuroLinux Manpages][5])

### 6.6 跨目录操作的死锁规避（可扩展到 rename）

当操作同时涉及多个目录（尤其是跨目录 rename），必须引入文件系统级锁作为“拓扑变化”的序列化手段，并按 Linux 文档的顺序获取锁（先 fs 锁，再按祖先优先/固定顺序锁目录）。uCore 即便暂不实现 rename，也建议预留 `superblock->s_rename_lock`，避免未来扩展时推倒重来。 ([Linux 内核文档][1])

---

## 7. 具体文件系统（如 SFS）落地要点

### 7.1 硬链接落地

* 目录文件中新增一个指向已有 inode 的目录项即可；关键是维护并持久化 `i_nlink`。 ([man7.org][2])

### 7.2 软链接落地（symlink inode 内容存储）

两种存储策略：

1. **短目标内联**：`strlen(target) < 60` 时直接写入 `dinode.i_inline_symlink`（借鉴 ext4：symlink 目标短则存 inode 固定区）。 ([Linux Kernel Archives][10])
2. **长目标走数据块**：像普通小文件一样分配数据块保存 `target` 字符串。

---

## 8. 测试用例建议（用于实验报告验证）

1. **硬链接共享 inode**：创建 `a`，再 `link(a,b)`，检查 `stat` 中链接数增加；`unlink(a)` 后仍可通过 `b` 读写。 ([手册页][3])
2. **symlink 悬空**：`symlink("a","s")`，删除 `a` 后 `open("s")` 应失败（dangling），但 `readlink("s")` 仍返回 `"a"`。 ([Arch手册页][4])
3. **stat/lstat 差异**：`lstat("s")` 返回类型为 symlink，`stat("s")` 跟随目标。 ([man7.org][7])
4. **symlink 环与上限**：构造 symlink 链超过 40 次，返回 `ELOOP`。 ([man7.org][8])
5. **O_NOFOLLOW**：对 symlink 最后一段执行 `open(O_NOFOLLOW)` 返回 `ELOOP`。 ([man7.org][9])

---

## 9. 参考文献

1. Linux man-pages: **link(2)** — 硬链接语义、禁止链接目录（EPERM）、禁止跨 FS（EXDEV）。 ([man7.org][2])
2. Linux man-pages: **unlink(2)** — 删除目录项、最后链接与打开引用的延迟回收语义。 ([Linux Documentation][11])
3. Linux man-pages: **symlink(2)** — symlink 保存目标字符串、运行时路径替换语义。 ([Arch手册页][4])
4. Linux man-pages: **readlink(2)** — 不追加 `\0`、返回写入字节数与截断行为。 ([EuroLinux Manpages][5])
5. Linux man-pages: **stat(2)** / `lstat` 差异（symlink 是否跟随）。 ([man7.org][7])
6. Linux man-pages: **path_resolution(7)** — 路径解析流程、symlink 跟随上限 40、超限 `ELOOP`。 ([man7.org][8])
7. Linux man-pages: **open(2)** — `O_NOFOLLOW`：最后分量为 symlink 时返回 `ELOOP`。 ([man7.org][9])
8. Linux Kernel Documentation: **Directory Locking** — per-inode 锁与 per-fs 锁、操作分类（link/unlink/rename）及锁顺序/死锁规避。 ([Linux 内核文档][1])
9. Linux Kernel Documentation (ext4): **The Contents of inode.i_block / Symbolic Links** — symlink 目标字符串 < 60 字节时存 inode 固定区，否则用块映射/extent。 ([Linux Kernel Archives][10])

---

[1]: https://docs.kernel.org/6.18/filesystems/directory-locking.html?utm_source=chatgpt.com "Directory Locking — The Linux Kernel documentation"
[2]: https://www.man7.org/linux/man-pages/man2/link.2.html "link(2) - Linux manual page"
[3]: https://manpages.org/unlink/2?utm_source=chatgpt.com "man unlink (2): remove directory entry"
[4]: https://man.archlinux.org/man/symlink.2.zh_CN?utm_source=chatgpt.com "symlink (2) — Arch manual pages"
[5]: https://man.docs.euro-linux.com/EL%207/man-pages/readlink.2.en.html?utm_source=chatgpt.com "readlink (2) — man-pages"
[6]: https://man.omnios.org/man2/unlink?utm_source=chatgpt.com "UNLINK (2) - man.omnios.org"
[7]: https://www.man7.org/linux/man-pages/man2/stat.2.html?utm_source=chatgpt.com "stat (2) - Linux manual page - man7.org"
[8]: https://www.man7.org/linux/man-pages/man7/path_resolution.7.html "path_resolution(7) - Linux manual page"
[9]: https://www.man7.org/linux/man-pages/man2/open.2.html "open(2) - Linux manual page"
[10]: https://www.kernel.org/doc/html/latest/filesystems/ext4/ifork.html?utm_source=chatgpt.com "4.2. The Contents of inode.i_block — The Linux Kernel documentation"
[11]: https://linux.die.net/man/2/unlink?utm_source=chatgpt.com "unlink (2) - Linux man page"
