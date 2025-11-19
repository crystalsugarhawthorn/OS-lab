#include <list.h>
#include <sync.h>
#include <proc.h>
#include <sched.h>
#include <assert.h>

void
wakeup_proc(struct proc_struct *proc) {
    assert(proc->state != PROC_ZOMBIE && proc->state != PROC_RUNNABLE);
    proc->state = PROC_RUNNABLE;
}

void
schedule(void) {
    bool intr_flag;
    list_entry_t *le, *last;
    struct proc_struct *next = NULL;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
        // last 表示搜索的起点（也是终点）
        // 如果当前是idleproc，则从proc_list开始搜索（因为idleproc不在proc_list中）
        // 否则从当前进程的下一个进程开始搜索
        last = (current == idleproc) ? &proc_list : &(current->list_link);
        le = last;
        do {
            // 需要跳过proc_list的头结点
            if ((le = list_next(le)) != &proc_list) {
                next = le2proc(le, list_link);
                if (next->state == PROC_RUNNABLE) {
                    break;
                }
            }
        } while (le != last); // 循环直到回到起点，避免死循环
        // 如果没有找到可运行的进程，则运行idleproc
        if (next == NULL || next->state != PROC_RUNNABLE) {
            next = idleproc;
        }
        next->runs ++;
        // 更新当前运行进程为 next
        // 调用 proc_run 切换上下文
        if (next != current) {
            proc_run(next);
        }
    }
    local_intr_restore(intr_flag);
}

