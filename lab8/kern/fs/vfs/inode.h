#ifndef __KERN_FS_VFS_INODE_H__
#define __KERN_FS_VFS_INODE_H__

#include <defs.h>
#include <dev.h>
#include <sfs.h>
#include <atomic.h>
#include <assert.h>

struct stat;
struct iobuf;

/*
 * A struct inode is an abstract representation of a file.
 *
 * It is an interface that allows the kernel's filesystem-independent 
 * code to interact usefully with multiple sets of filesystem code.
 */

/*
 * Abstract low-level file.
 *
 * Note: in_info is Filesystem-specific data, in_type is the inode type
 *
 * open_count is managed using VOP_INCOPEN and VOP_DECOPEN by
 * vfs_open() and vfs_close(). Code above the VFS layer should not
 * need to worry about it.
 */
struct inode {
    union {
        struct device __device_info;
        struct sfs_inode __sfs_inode_info;
    } in_info;
    enum {
        inode_type_device_info = 0x1234,
        inode_type_sfs_inode_info,
    } in_type;
    int ref_count;
    int open_count;
    struct fs *in_fs;
    const struct inode_ops *in_ops;
};

#define __in_type(type)                                             inode_type_##type##_info

#define check_inode_type(node, type)                                ((node)->in_type == __in_type(type))

#define __vop_info(node, type)                                      \
    ({                                                              \
        struct inode *__node = (node);                              \
        assert(__node != NULL && check_inode_type(__node, type));   \
        &(__node->in_info.__##type##_info);                         \
     })

#define vop_info(node, type)                                        __vop_info(node, type)

#define info2node(info, type)                                       \
    to_struct((info), struct inode, in_info.__##type##_info)

struct inode *__alloc_inode(int type);

#define alloc_inode(type)                                           __alloc_inode(__in_type(type))

#define MAX_INODE_COUNT                     0x10000

int inode_ref_inc(struct inode *node);
int inode_ref_dec(struct inode *node);
int inode_open_inc(struct inode *node);
int inode_open_dec(struct inode *node);

void inode_init(struct inode *node, const struct inode_ops *ops, struct fs *fs);
void inode_kill(struct inode *node);

#define VOP_MAGIC                           0x8c4ba476

/*
 * Abstract operations on a inode.
 *
 * These are used in the form VOP_FOO(inode, args), which are macros
 * that expands to inode->inode_ops->vop_foo(inode, args). The operations
 * "foo" are:
 *
 *    vop_open        - Called on open() of a file. Can be used to
 *                      reject illegal or undesired open modes. Note that
 *                      various operations can be performed without the
 *                      file actually being opened.
 *                      The inode need not look at O_CREAT, O_EXCL, or 
 *                      O_TRUNC, as these are handled in the VFS layer.
 *
 *                      VOP_EACHOPEN should not be called directly from
 *                      above the VFS layer - use vfs_open() to open inodes.
 *                      This maintains the open count so VOP_LASTCLOSE can
 *                      be called at the right time.
 *
 *    vop_close       - To be called on *last* close() of a file.
 *
 *                      VOP_LASTCLOSE should not be called directly from
 *                      above the VFS layer - use vfs_close() to close
 *                      inodes opened with vfs_open().
 *
 *    vop_reclaim     - Called when inode is no longer in use. Note that
 *                      this may be substantially after vop_lastclose is
 *                      called.
 *
 *****************************************
 *
 *    vop_read        - Read data from file to uio, at offset specified
 *                      in the uio, updating uio_resid to reflect the
 *                      amount read, and updating uio_offset to match.
 *                      Not allowed on directories or symlinks.
 *
 *    vop_getdirentry - Read a single filename from a directory into a
 *                      uio, choosing what name based on the offset
 *                      field in the uio, and updating that field.
 *                      Unlike with I/O on regular files, the value of
 *                      the offset field is not interpreted outside
 *                      the filesystem and thus need not be a byte
 *                      count. However, the uio_resid field should be
 *                      handled in the normal fashion.
 *                      On non-directory objects, return ENOTDIR.
 *
 *    vop_write       - Write data from uio to file at offset specified
 *                      in the uio, updating uio_resid to reflect the
 *                      amount written, and updating uio_offset to match.
 *                      Not allowed on directories or symlinks.
 *
 *    vop_ioctl       - Perform ioctl operation OP on file using data
 *                      DATA. The interpretation of the data is specific
 *                      to each ioctl.
 *
 *    vop_fstat        -Return info about a file. The pointer is a 
 *                      pointer to struct stat; see stat.h.
 *
 *    vop_gettype     - Return type of file. The values for file types
 *                      are in sfs.h.
 *
 *    vop_tryseek     - Check if seeking to the specified position within
 *                      the file is legal. (For instance, all seeks
 *                      are illegal on serial port devices, and seeks
 *                      past EOF on files whose sizes are fixed may be
 *                      as well.)
 *
 *    vop_fsync       - Force any dirty buffers associated with this file
 *                      to stable storage.
 *
 *    vop_truncate    - Forcibly set size of file to the length passed
 *                      in, discarding any excess blocks.
 *
 *    vop_namefile    - Compute pathname relative to filesystem root
 *                      of the file and copy to the specified io buffer. 
 *                      Need not work on objects that are not
 *                      directories.
 *
 *****************************************
 *
 *    vop_creat       - Create a regular file named NAME in the passed
 *                      directory DIR. If boolean EXCL is true, fail if
 *                      the file already exists; otherwise, use the
 *                      existing file if there is one. Hand back the
 *                      inode for the file as per vop_lookup.
 *
 *****************************************
 *
 *    vop_lookup      - Parse PATHNAME relative to the passed directory
 *                      DIR, and hand back the inode for the file it
 *                      refers to. May destroy PATHNAME. Should increment
 *                      refcount on inode handed back.
 */
/*
 * 对 inode 的抽象操作。
 *
 * 这些操作以 VOP_FOO(inode, args) 的形式使用，它们是一些宏，
 * 会展开为 inode->inode_ops->vop_foo(inode, args)。其中 “foo”
 * 表示的操作包括：
 *
 *    vop_open        - 在对文件调用 open() 时被调用。可用于拒绝
 *                      非法或不期望的打开模式。需要注意的是，即使
 *                      文件并未真正被打开，某些操作也可能被执行。
 *                      inode 不需要处理 O_CREAT、O_EXCL 或
 *                      O_TRUNC，因为这些由 VFS 层负责处理。
 *
 *                      不应在 VFS 层之上直接调用 VOP_EACHOPEN，
 *                      而应使用 vfs_open() 来打开 inode。
 *                      这样可以维护打开计数，从而在合适的时机
 *                      调用 VOP_LASTCLOSE。
 *
 *    vop_close       - 在文件被“最后一次” close() 时调用。
 *
 *                      不应在 VFS 层之上直接调用 VOP_LASTCLOSE，
 *                      应使用 vfs_close() 来关闭通过 vfs_open()
 *                      打开的 inode。
 *
 *    vop_reclaim     - 当 inode 不再被使用时调用。需要注意的是，
 *                      该调用可能会在 vop_lastclose 被调用很久之后
 *                      才发生。
 *
 *****************************************
 *
 *    vop_read        - 从文件中读取数据到 uio，读取位置由 uio 中
 *                      的偏移量指定；同时更新 uio_resid 以反映
 *                      实际读取的字节数，并更新 uio_offset。
 *                      不允许用于目录或符号链接。
 *
 *    vop_getdirentry - 从目录中读取一个文件名到 uio 中，具体读取
 *                      哪个名字由 uio 中的 offset 字段决定，并在
 *                      读取后更新该字段。与普通文件 I/O 不同，
 *                      offset 字段的值不会在文件系统之外被解释，
 *                      因此不必是字节计数。不过，uio_resid 字段
 *                      仍应按常规方式处理。
 *                      如果对象不是目录，应返回 ENOTDIR。
 *
 *    vop_write       - 将数据从 uio 写入文件，写入位置由 uio 中
 *                      的偏移量指定；同时更新 uio_resid 以反映
 *                      实际写入的字节数，并更新 uio_offset。
 *                      不允许用于目录或符号链接。
 *
 *    vop_ioctl       - 使用数据 DATA 在文件上执行 ioctl 操作 OP。
 *                      DATA 的具体含义由各个 ioctl 自行定义。
 *
 *    vop_fstat       - 返回文件的信息。传入的指针是指向 struct stat
 *                      的指针，参见 stat.h。
 *
 *    vop_gettype     - 返回文件的类型。文件类型的取值定义在 sfs.h 中。
 *
 *    vop_tryseek     - 检查在文件中 seek 到指定位置是否合法。
 *                      （例如，串口设备不允许任何形式的 seek；
 *                      对于大小固定的文件，seek 到 EOF 之后
 *                      也可能是不允许的。）
 *
 *    vop_fsync       - 强制将与该文件关联的所有脏缓冲区写回到
 *                      稳定存储介质。
 *
 *    vop_truncate    - 强制将文件大小设置为指定长度，并丢弃
 *                      超出该长度的所有数据块。
 *
 *    vop_namefile    - 计算该文件相对于文件系统根目录的路径名，
 *                      并将其拷贝到指定的 I/O 缓冲区中。
 *                      对于非目录对象，不要求必须实现该操作。
 *
 *****************************************
 *
 *    vop_creat       - 在给定目录 DIR 中创建一个名为 NAME 的普通文件。
 *                      如果布尔值 EXCL 为真，则当文件已存在时失败；
 *                      否则如果文件已存在，则使用已有文件。
 *                      返回的 inode 与 vop_lookup 的行为一致。
 *
 *****************************************
 *
 *    vop_lookup      - 相对于给定目录 DIR 解析 PATHNAME，
 *                      并返回其所指向文件的 inode。
 *                      该操作可能会销毁 PATHNAME。
 *                      应当增加返回 inode 的引用计数。
 */

struct inode_ops {
    unsigned long vop_magic;
    int (*vop_open)(struct inode *node, uint32_t open_flags);
    int (*vop_close)(struct inode *node);
    int (*vop_read)(struct inode *node, struct iobuf *iob);
    int (*vop_write)(struct inode *node, struct iobuf *iob);
    int (*vop_fstat)(struct inode *node, struct stat *stat);
    int (*vop_fsync)(struct inode *node);
    int (*vop_namefile)(struct inode *node, struct iobuf *iob);
    int (*vop_getdirentry)(struct inode *node, struct iobuf *iob);
    int (*vop_reclaim)(struct inode *node);
    int (*vop_gettype)(struct inode *node, uint32_t *type_store);
    int (*vop_tryseek)(struct inode *node, off_t pos);
    int (*vop_truncate)(struct inode *node, off_t len);
    int (*vop_create)(struct inode *node, const char *name, bool excl, struct inode **node_store);
    int (*vop_lookup)(struct inode *node, char *path, struct inode **node_store);
    int (*vop_ioctl)(struct inode *node, int op, void *data);
};

/*
 * Consistency check
 */
void inode_check(struct inode *node, const char *opstr);

#define __vop_op(node, sym)                                                                         \
    ({                                                                                              \
        struct inode *__node = (node);                                                              \
        assert(__node != NULL && __node->in_ops != NULL && __node->in_ops->vop_##sym != NULL);      \
        inode_check(__node, #sym);                                                                  \
        __node->in_ops->vop_##sym;                                                                  \
     })

#define vop_open(node, open_flags)                                  (__vop_op(node, open)(node, open_flags))
#define vop_close(node)                                             (__vop_op(node, close)(node))
#define vop_read(node, iob)                                         (__vop_op(node, read)(node, iob))
#define vop_write(node, iob)                                        (__vop_op(node, write)(node, iob))
#define vop_fstat(node, stat)                                       (__vop_op(node, fstat)(node, stat))
#define vop_fsync(node)                                             (__vop_op(node, fsync)(node))
#define vop_namefile(node, iob)                                     (__vop_op(node, namefile)(node, iob))
#define vop_getdirentry(node, iob)                                  (__vop_op(node, getdirentry)(node, iob))
#define vop_reclaim(node)                                           (__vop_op(node, reclaim)(node))
#define vop_ioctl(node, op, data)                                   (__vop_op(node, ioctl)(node, op, data))
#define vop_gettype(node, type_store)                               (__vop_op(node, gettype)(node, type_store))
#define vop_tryseek(node, pos)                                      (__vop_op(node, tryseek)(node, pos))
#define vop_truncate(node, len)                                     (__vop_op(node, truncate)(node, len))
#define vop_create(node, name, excl, node_store)                    (__vop_op(node, create)(node, name, excl, node_store))
#define vop_lookup(node, path, node_store)                          (__vop_op(node, lookup)(node, path, node_store))


#define vop_fs(node)                                                ((node)->in_fs)
#define vop_init(node, ops, fs)                                     inode_init(node, ops, fs)
#define vop_kill(node)                                              inode_kill(node)

/*
 * Reference count manipulation (handled above filesystem level)
 */
#define vop_ref_inc(node)                                           inode_ref_inc(node)
#define vop_ref_dec(node)                                           inode_ref_dec(node)
/*
 * Open count manipulation (handled above filesystem level)
 *
 * VOP_INCOPEN is called by vfs_open. VOP_DECOPEN is called by vfs_close.
 * Neither of these should need to be called from above the vfs layer.
 */
#define vop_open_inc(node)                                          inode_open_inc(node)
#define vop_open_dec(node)                                          inode_open_dec(node)


static inline int
inode_ref_count(struct inode *node) {
    return node->ref_count;
}

static inline int
inode_open_count(struct inode *node) {
    return node->open_count;
}

#endif /* !__KERN_FS_VFS_INODE_H__ */

