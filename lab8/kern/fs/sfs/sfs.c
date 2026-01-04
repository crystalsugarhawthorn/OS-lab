#include <defs.h>
#include <sfs.h>
#include <error.h>
#include <assert.h>

/*
 * sfs_init - mount sfs on disk0
 *
 * CALL GRAPH:
 *   kern_init-->fs_init-->sfs_init
 */
/**
 * 文件系统初始化函数
 * 用于挂载SFS(Simple File System)文件系统
 */
void
sfs_init(void) {
    int ret;  // 用于存储函数返回值
    // 尝试挂载名为"disk0"的磁盘分区上的SFS文件系统
    // 如果挂载失败，ret将不为0，触发panic错误
    if ((ret = sfs_mount("disk0")) != 0) {
        // 输出错误信息，包含具体的错误码
        panic("failed: sfs: sfs_mount: %e.\n", ret);
    }
}

