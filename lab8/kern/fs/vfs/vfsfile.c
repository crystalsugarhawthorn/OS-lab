#include <defs.h>
#include <string.h>
#include <vfs.h>
#include <inode.h>
#include <unistd.h>
#include <error.h>
#include <assert.h>


// open file in vfs, get/create inode for file with filename path.
/*
 * vfs_open - 通过虚拟文件系统打开文件
 * @path: 要打开的文件路径
 * @open_flags: 文件打开标志（如只读、只写、读写、创建、截断等）
 * @node_store: 用于返回打开文件的inode指针
 * 
 * 返回值：成功返回0，失败返回错误码
 * 
 * 该函数处理文件打开的各种情况，包括文件存在性检查、权限验证、
 * 文件创建、截断等操作，最终返回对应文件的inode。
 */
int
vfs_open(char *path, uint32_t open_flags, struct inode **node_store) {
    bool can_write = 0;
    /* 检查文件访问模式，确定是否需要写权限 */
    switch (open_flags & O_ACCMODE) {
    case O_RDONLY:                        /* 只读模式 */
        break;
    case O_WRONLY:                        /* 只写模式 */
    case O_RDWR:                          /* 读写模式 */
        can_write = 1;
        break;
    default:
        return -E_INVAL;                  /* 无效的访问模式 */
    }

    /* 如果设置了截断标志，必须有写权限 */
    if (open_flags & O_TRUNC) {
        if (!can_write) {
            return -E_INVAL;
        }
    }

    int ret; 
    struct inode *node;
    bool excl = (open_flags & O_EXCL) != 0;   /* 独占创建标志 */
    bool create = (open_flags & O_CREAT) != 0; /* 创建标志 */
    
    /* 查找文件 */
    //1
    ret = vfs_lookup(path, &node);

    /* 文件不存在的情况处理 */
    if (ret != 0) {
        /* 如果文件不存在且设置了创建标志，则创建新文件 */
        if (ret == -16 && (create)) {         /* -16 是文件不存在的错误码 */
            char *name;
            struct inode *dir;
            /* 获取父目录和文件名 */
            if ((ret = vfs_lookup_parent(path, &dir, &name)) != 0) {
                return ret;
            }
            /* 创建新文件 */
            ret = vop_create(dir, name, excl, &node);
        } else return ret;                    /* 其他错误直接返回 */
    } 
    /* 文件存在，但设置了独占创建标志，返回文件已存在错误 */
    else if (excl && create) {
        return -E_EXISTS;
    }
    assert(node != NULL);
    
    /* 调用文件系统特定的打开操作 */
    //2
    if ((ret = vop_open(node, open_flags)) != 0) {
        vop_ref_dec(node);                    /* 减少引用计数 */
        return ret;
    }

    /* 增加打开计数 */
    vop_open_inc(node);
    /* 如果设置了截断标志或是新创建的文件，将文件大小截断为0 */
    if (open_flags & O_TRUNC || create) {
        if ((ret = vop_truncate(node, 0)) != 0) {
            vop_open_dec(node);               /* 减少打开计数 */
            vop_ref_dec(node);                /* 减少引用计数 */
            return ret;
        }
    }
    *node_store = node;                       /* 返回inode指针 */
    return 0;
}

// close file in vfs
int
vfs_close(struct inode *node) {
    vop_open_dec(node);
    vop_ref_dec(node);
    return 0;
}

// unimplement
int
vfs_unlink(char *path) {
    return -E_UNIMP;
}

// unimplement
int
vfs_rename(char *old_path, char *new_path) {
    return -E_UNIMP;
}

// unimplement
int
vfs_link(char *old_path, char *new_path) {
    return -E_UNIMP;
}

// unimplement
int
vfs_symlink(char *old_path, char *new_path) {
    return -E_UNIMP;
}

// unimplement
int
vfs_readlink(char *path, struct iobuf *iob) {
    return -E_UNIMP;
}

// unimplement
int
vfs_mkdir(char *path){
    return -E_UNIMP;
}
