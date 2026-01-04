#include <defs.h>
#include <string.h>
#include <vfs.h>
#include <proc.h>
#include <file.h>
#include <unistd.h>
#include <iobuf.h>
#include <inode.h>
#include <stat.h>
#include <dirent.h>
#include <error.h>
#include <assert.h>

#define testfd(fd)                          ((fd) >= 0 && (fd) < FILES_STRUCT_NENTRY)

// get_fd_array - get current process's open files table
static struct file *
get_fd_array(void) {
    struct files_struct *filesp = current->filesp;
    assert(filesp != NULL && files_count(filesp) > 0);
    return filesp->fd_array;
}

// fd_array_init - initialize the open files table
void
fd_array_init(struct file *fd_array) {
    int fd;
    struct file *file = fd_array;
    for (fd = 0; fd < FILES_STRUCT_NENTRY; fd ++, file ++) {
        file->open_count = 0;
        file->status = FD_NONE, file->fd = fd;
    }
}

// fs_array_alloc - allocate a free file item (with FD_NONE status) in open files table
static int
fd_array_alloc(int fd, struct file **file_store) {
//    panic("debug");
    struct file *file = get_fd_array();
    if (fd == NO_FD) {
        for (fd = 0; fd < FILES_STRUCT_NENTRY; fd ++, file ++) {
            if (file->status == FD_NONE) {
                goto found;
            }
        }
        return -E_MAX_OPEN;
    }
    else {
        if (testfd(fd)) {
            file += fd;
            if (file->status == FD_NONE) {
                goto found;
            }
            return -E_BUSY;
        }
        return -E_INVAL;
    }
found:
    assert(fopen_count(file) == 0);
    file->status = FD_INIT, file->node = NULL;
    *file_store = file;
    return 0;
}

// fd_array_free - free a file item in open files table
static void
fd_array_free(struct file *file) {
    assert(file->status == FD_INIT || file->status == FD_CLOSED);
    assert(fopen_count(file) == 0);
    if (file->status == FD_CLOSED) {
        vfs_close(file->node);
    }
    file->status = FD_NONE;
}

static void
fd_array_acquire(struct file *file) {
    assert(file->status == FD_OPENED);
    fopen_count_inc(file);
}

// fd_array_release - file's open_count--; if file's open_count-- == 0 , then call fd_array_free to free this file item
static void
fd_array_release(struct file *file) {
    assert(file->status == FD_OPENED || file->status == FD_CLOSED);
    assert(fopen_count(file) > 0);
    if (fopen_count_dec(file) == 0) {
        fd_array_free(file);
    }
}

// fd_array_open - file's open_count++, set status to FD_OPENED
void
fd_array_open(struct file *file) {
    assert(file->status == FD_INIT && file->node != NULL);
    file->status = FD_OPENED;
    fopen_count_inc(file);
}

// fd_array_close - file's open_count--; if file's open_count-- == 0 , then call fd_array_free to free this file item
void
fd_array_close(struct file *file) {
    assert(file->status == FD_OPENED);
    assert(fopen_count(file) > 0);
    file->status = FD_CLOSED;
    if (fopen_count_dec(file) == 0) {
        fd_array_free(file);
    }
}

//fs_array_dup - duplicate file 'from'  to file 'to'
void
fd_array_dup(struct file *to, struct file *from) {
    //cprintf("[fd_array_dup]from fd=%d, to fd=%d\n",from->fd, to->fd);
    assert(to->status == FD_INIT && from->status == FD_OPENED);
    to->pos = from->pos;
    to->readable = from->readable;
    to->writable = from->writable;
    struct inode *node = from->node;
    vop_ref_inc(node), vop_open_inc(node);
    to->node = node;
    fd_array_open(to);
}

// fd2file - use fd as index of fd_array, return the array item (file)
static inline int
fd2file(int fd, struct file **file_store) {
    if (testfd(fd)) {
        struct file *file = get_fd_array() + fd;
        if (file->status == FD_OPENED && file->fd == fd) {
            *file_store = file;
            return 0;
        }
    }
    return -E_INVAL;
}

// file_testfd - test file is readble or writable?
bool
file_testfd(int fd, bool readable, bool writable) {
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0) {
        return 0;
    }
    if (readable && !file->readable) {
        return 0;
    }
    if (writable && !file->writable) {
        return 0;
    }
    return 1;
}

// open file
/*
 * file_open - 打开文件并初始化文件结构体
 * @path: 要打开的文件路径
 * @open_flags: 文件打开标志（如只读、只写、读写、追加等）
 * 
 * 返回值：成功返回文件描述符，失败返回错误码
 * 
 * 该函数解析打开标志，分配文件描述符，通过VFS打开文件，
 * 初始化文件结构体，并设置文件的读写权限和位置。
 */
int
file_open(char *path, uint32_t open_flags) {
    bool readable = 0, writable = 0;
    /* 根据打开标志设置读写权限 */
    switch (open_flags & O_ACCMODE) {
    case O_RDONLY: readable = 1; break;     /* 只读 */
    case O_WRONLY: writable = 1; break;     /* 只写 */
    case O_RDWR:                           /* 读写 */
        readable = writable = 1;
        break;
    default:
        return -E_INVAL;                    /* 无效的访问模式 */
    }
    int ret;
    struct file *file;
    /* 分配一个文件描述符 */
    if ((ret = fd_array_alloc(NO_FD, &file)) != 0) {
        return ret;
    }
    struct inode *node;
    /* 通过VFS打开文件，获取对应的inode */
    if ((ret = vfs_open(path, open_flags, &node)) != 0) {
        fd_array_free(file);                /* 释放已分配的文件描述符 */
        return ret;
    }
    /* 初始化文件位置为0 */
    file->pos = 0;
    /* 如果设置了追加标志，将文件位置设置为文件末尾 */
    if (open_flags & O_APPEND) {
        struct stat __stat, *stat = &__stat;
        /* 获取文件状态信息 */
        if ((ret = vop_fstat(node, stat)) != 0) {
            vfs_close(node);                /* 关闭已打开的文件 */
            fd_array_free(file);            /* 释放文件描述符 */
            return ret;
        }
        file->pos = stat->st_size;          /* 设置位置为文件大小 */
    }
    /* 设置文件结构体的各个字段 */
    file->node = node;                      /* 关联的inode */
    file->readable = readable;              /* 可读标志 */
    file->writable = writable;              /* 可写标志 */
    fd_array_open(file);                    /* 标记文件描述符为已使用 */
    return file->fd;                        /* 返回文件描述符 */
}

// close file
int
file_close(int fd) {
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0) {
        return ret;
    }
    fd_array_close(file);
    return 0;
}

// read file
/*
 * file_read - 从文件描述符读取数据
 * @fd: 文件描述符
 * @base: 缓冲区指针
 * @len: 要读取的最大字节数
 * @copied_store: 用于返回实际读取的字节数
 * 
 * 返回值：成功返回0，失败返回负的错误码
 * 
 * 该函数是文件读取的核心实现，它将文件描述符转换为文件对象，
 * 然后通过虚拟文件系统接口执行实际的读取操作。
 */
int
file_read(int fd, void *base, size_t len, size_t *copied_store) {
    int ret;
    struct file *file;
    *copied_store = 0;  /* 初始化已复制字节数 */
    
    /* 将文件描述符转换为文件对象 */
    if ((ret = fd2file(fd, &file)) != 0) {
        return ret;  /* 转换失败，返回错误码 */
    }
    
    /* 检查文件是否可读 */
    if (!file->readable) {
        return -E_INVAL;  /* 文件不可读，返回错误 */
    }
    
    /* 获取文件数组锁，防止在读取过程中文件被关闭或修改 */
    fd_array_acquire(file);

    /* 初始化I/O缓冲区，用于与文件系统交互 */
    struct iobuf __iob, *iob = iobuf_init(&__iob, base, len, file->pos);
    
    /* 通过虚拟文件系统接口执行读取操作 */
    ret = vop_read(file->node, iob);

    /* 获取实际读取的字节数 */
    size_t copied = iobuf_used(iob);
    
    /* 如果文件处于打开状态，更新文件位置 */
    if (file->status == FD_OPENED) {
        file->pos += copied;
    }
    
    /* 设置返回值 */
    *copied_store = copied;
    
    /* 释放文件数组锁 */
    fd_array_release(file);
    
    return ret;
}

// write file
int
file_write(int fd, void *base, size_t len, size_t *copied_store) {
    int ret;
    struct file *file;
    *copied_store = 0;
    if ((ret = fd2file(fd, &file)) != 0) {
        return ret;
    }
    if (!file->writable) {
        return -E_INVAL;
    }
    fd_array_acquire(file);

    struct iobuf __iob, *iob = iobuf_init(&__iob, base, len, file->pos);
    ret = vop_write(file->node, iob);

    size_t copied = iobuf_used(iob);
    if (file->status == FD_OPENED) {
        file->pos += copied;
    }
    *copied_store = copied;
    fd_array_release(file);
    return ret;
}

// seek file
int
file_seek(int fd, off_t pos, int whence) {
    struct stat __stat, *stat = &__stat;
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0) {
        return ret;
    }
    fd_array_acquire(file);

    switch (whence) {
    case LSEEK_SET: break;
    case LSEEK_CUR: pos += file->pos; break;
    case LSEEK_END:
        if ((ret = vop_fstat(file->node, stat)) == 0) {
            pos += stat->st_size;
        }
        break;
    default: ret = -E_INVAL;
    }

    if (ret == 0) {
        if ((ret = vop_tryseek(file->node, pos)) == 0) {
            file->pos = pos;
        }
//    cprintf("file_seek, pos=%d, whence=%d, ret=%d\n", pos, whence, ret);
    }
    fd_array_release(file);
    return ret;
}

// stat file
int
file_fstat(int fd, struct stat *stat) {
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0) {
        return ret;
    }
    fd_array_acquire(file);
    ret = vop_fstat(file->node, stat);
    fd_array_release(file);
    return ret;
}

// sync file
int
file_fsync(int fd) {
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0) {
        return ret;
    }
    fd_array_acquire(file);
    ret = vop_fsync(file->node);
    fd_array_release(file);
    return ret;
}

// get file entry in DIR
int
file_getdirentry(int fd, struct dirent *direntp) {
    int ret;
    struct file *file;
    if ((ret = fd2file(fd, &file)) != 0) {
        return ret;
    }
    fd_array_acquire(file);

    struct iobuf __iob, *iob = iobuf_init(&__iob, direntp->name, sizeof(direntp->name), direntp->offset);
    if ((ret = vop_getdirentry(file->node, iob)) == 0) {
        direntp->offset += iobuf_used(iob);
    }
    fd_array_release(file);
    return ret;
}

// duplicate file
int
file_dup(int fd1, int fd2) {
    int ret;
    struct file *file1, *file2;
    if ((ret = fd2file(fd1, &file1)) != 0) {
        return ret;
    }
    if ((ret = fd_array_alloc(fd2, &file2)) != 0) {
        return ret;
    }
    fd_array_dup(file2, file1);
    return file2->fd;
}


