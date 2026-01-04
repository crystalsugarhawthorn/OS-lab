#include <defs.h>
#include <string.h>
#include <vfs.h>
#include <inode.h>
#include <error.h>
#include <assert.h>

/*
 * get_device- Common code to pull the device name, if any, off the front of a
 *             path and choose the inode to begin the name lookup relative to.
 */

/*
 * get_device - 解析路径中的设备部分，获取设备inode和剩余路径
 * @path: 要解析的完整路径
 * @subpath: 用于返回解析后的剩余路径部分
 * @node_store: 用于返回设备inode或文件系统根inode
 * 
 * 返回值：成功返回0，失败返回错误码
 * 
 * 该函数处理多种路径格式：
 * 1. 相对路径（如"file.txt"）：从当前目录开始查找
 * 2. 设备路径（如"device0:path"）：从指定设备的文件系统根目录开始查找
 * 3. 绝对路径（如"/path"）：从启动文件系统的根目录开始查找
 * 4. 当前文件系统路径（如":path"）：从当前文件系统的根目录开始查找
 */
static int
get_device(char *path, char **subpath, struct inode **node_store) {
    int i, slash = -1, colon = -1;
    /* 查找路径中的第一个冒号或斜杠 */
    for (i = 0; path[i] != '\0'; i ++) {
        if (path[i] == ':') { colon = i; break; }  /* 找到设备分隔符 */
        if (path[i] == '/') { slash = i; break; }  /* 找到路径分隔符 */
    }
    
    /* 情况1：相对路径或裸文件名（没有冒号，且斜杠不在开头） */
    if (colon < 0 && slash != 0) {
        /* 没有指定设备名，斜杠不在开头或不存在，
         * 这是相对路径或裸文件名，从当前目录开始查找，
         * 使用整个路径作为子路径。 */
        *subpath = path;
        return vfs_get_curdir(node_store);
    }
    
    /* 情况2：设备路径（device:path 或 device:/path） */
    if (colon > 0) {
        /* 获取设备文件系统的根目录 */
        path[colon] = '\0';  /* 临时截断字符串以获取设备名 */

        /* 跳过冒号后的斜杠，将device:/path视为device:path */
        while (path[++ colon] == '/');
        *subpath = path + colon;  /* 设置剩余路径 */
        return vfs_get_root(path, node_store);  /* 获取设备文件系统的根inode */
    }

    /* 情况3：绝对路径（/path）或当前文件系统路径（:path） */
    /* /path 是相对于"启动文件系统"根目录的路径
     * :path 是相对于当前文件系统根目录的路径 */
    int ret;
    if (*path == '/') {
        /* 绝对路径：获取启动文件系统的根inode */
        // 这个inode就是位于vfs.c中的inode变量bootfs_node。这个变量在init_main函数（位于kern/process/proc.c）执行时获得了赋值。
        if ((ret = vfs_get_bootfs(node_store)) != 0) {
            return ret;
        }
    }
    else {
        /* 当前文件系统路径 */
        assert(*path == ':');
        struct inode *node;
        /* 获取当前目录的inode */
        if ((ret = vfs_get_curdir(&node)) != 0) {
            return ret;
        }
        /* 当前目录可能不是设备，所以它必须有一个文件系统 */
        assert(node->in_fs != NULL);
        /* 获取当前文件系统的根inode */
        *node_store = fsop_get_root(node->in_fs);
        vop_ref_dec(node);  /* 减少当前目录inode的引用计数 */
    }

    /* 处理 ///... 或 :/... 的情况，跳过多余的斜杠 */
    while (*(++ path) == '/');
    *subpath = path;  /* 设置剩余路径 */
    return 0;
}

/*
 * vfs_lookup - get the inode according to the path filename
 */
/*
 * vfs_lookup - 在虚拟文件系统中查找路径对应的inode
 * @path: 要查找的文件路径
 * @node_store: 用于返回找到的inode指针
 * 
 * 返回值：成功返回0，失败返回错误码
 * 
 * 该函数首先解析路径中的设备部分，然后查找剩余路径对应的inode。
 * 如果路径只包含设备部分，则直接返回设备inode。
 */
int
vfs_lookup(char *path, struct inode **node_store) {
    int ret;
    struct inode *node;
    /* 解析路径中的设备部分，获取设备inode和剩余路径 */
    if ((ret = get_device(path, &path, &node)) != 0) {
        return ret;
    }
    /* 如果剩余路径不为空，则继续在设备inode中查找 */
    if (*path != '\0') {
        ret = vop_lookup(node, path, node_store);  /* 在设备inode中查找剩余路径 */
        vop_ref_dec(node);                         /* 减少设备inode的引用计数 */
        return ret;
    }
    /* 路径只包含设备部分，直接返回设备inode */
    *node_store = node;
    return 0;
}

/*
 * vfs_lookup_parent - Name-to-vnode translation.
 *  (In BSD, both of these are subsumed by namei().)
 */
int
vfs_lookup_parent(char *path, struct inode **node_store, char **endp){
    int ret;
    struct inode *node;
    if ((ret = get_device(path, &path, &node)) != 0) {
        return ret;
    }
    *endp = path;
    *node_store = node;
    return 0;
}
