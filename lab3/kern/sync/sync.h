#ifndef __KERN_SYNC_SYNC_H__
#define __KERN_SYNC_SYNC_H__

#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
        intr_disable();
        return 1;
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
    }
}

// 原本宏展开后需要是一个赋值语句
// do while(0) 保证宏展开后在任何语法环境下都表现得像一个单独的语句，以及避免“悬挂else”问题。

#define local_intr_save(x) \
    do {                   \
        x = __intr_save(); \
    } while (0)

// 下面这个宏本身就是一个函数调用语句，已经是单一语句了，所以不加 do-while(0) 也不会有语法问题

#define local_intr_restore(x) __intr_restore(x);

#endif /* !__KERN_SYNC_SYNC_H__ */
