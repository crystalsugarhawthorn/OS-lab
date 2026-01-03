#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <sjf_sched.h>

/*
 * SJF (Shortest Job First) 调度算法
 * 选择预计执行时间最短的进程优先执行
 * 特点：
 * - 理论上最优（最小化平均等待时间）
 * - 需要预知进程执行时间（实际中很难）
 * - 可能导致长作业饥饿
 * 
 * 实现说明：
 * - 使用 proc->lab6_priority 作为预估的执行时间（值越小，时间越短）
 * - 优先级高（lab6_priority小）的进程先执行
 */

static void
SJF_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->proc_num = 0;
}

static void
SJF_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(list_empty(&(proc->run_link)));
    
    // SJF: 按照预估执行时间（lab6_priority）插入到合适位置
    // lab6_priority 越小，执行时间越短，越优先
    list_entry_t *le = list_next(&(rq->run_list));
    while (le != &(rq->run_list)) {
        struct proc_struct *p = le2proc(le, run_link);
        // 如果当前进程的执行时间更短，插入到这里
        if (proc->lab6_priority < p->lab6_priority) {
            break;
        }
        le = list_next(le);
    }
    // 插入到找到的位置之前
    list_add_before(le, &(proc->run_link));
    
    // 给较大的时间片，模拟非抢占式
    proc->time_slice = rq->max_time_slice * 50;
    proc->rq = rq;
    rq->proc_num++;
}

static void
SJF_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
    list_del_init(&(proc->run_link));
    rq->proc_num--;
}

static struct proc_struct *
SJF_pick_next(struct run_queue *rq)
{
    // SJF: 由于已经排序，直接取队首
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
        return le2proc(le, run_link);
    }
    return NULL;
}

static void
SJF_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}

struct sched_class sjf_sched_class = {
    .name = "SJF_scheduler",
    .init = SJF_init,
    .enqueue = SJF_enqueue,
    .dequeue = SJF_dequeue,
    .pick_next = SJF_pick_next,
    .proc_tick = SJF_proc_tick,
};
