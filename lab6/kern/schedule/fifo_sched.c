#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <fifo_sched.h>

/*
 * FIFO (First In First Out) 调度算法
 * 最简单的调度算法，按照进程进入就绪队列的顺序调度
 * 特点：
 * - 非抢占式（本实现中为了配合时钟中断，实现为抢占式）
 * - 公平，但可能导致长作业等待时间过长
 * - 平均周转时间较长
 */

static void
FIFO_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->proc_num = 0;
}

static void
FIFO_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(list_empty(&(proc->run_link)));
    // FIFO: 添加到队尾
    list_add_before(&(rq->run_list), &(proc->run_link));
    
    // 设置一个很大的时间片，模拟非抢占
    proc->time_slice = rq->max_time_slice * 100;
    proc->rq = rq;
    rq->proc_num++;
}

static void
FIFO_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
    list_del_init(&(proc->run_link));
    rq->proc_num--;
}

static struct proc_struct *
FIFO_pick_next(struct run_queue *rq)
{
    // FIFO: 总是选择队首（最早进入的）
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
        return le2proc(le, run_link);
    }
    return NULL;
}

static void
FIFO_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // FIFO 理论上是非抢占的，但为了系统响应性，我们仍然递减时间片
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}

struct sched_class fifo_sched_class = {
    .name = "FIFO_scheduler",
    .init = FIFO_init,
    .enqueue = FIFO_enqueue,
    .dequeue = FIFO_dequeue,
    .pick_next = FIFO_pick_next,
    .proc_tick = FIFO_proc_tick,
};
