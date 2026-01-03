#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <hrrn_sched.h>

/*
 * HRRN (Highest Response Ratio Next) 调度算法
 * 最高响应比优先调度算法
 * 
 * 响应比 = (等待时间 + 服务时间) / 服务时间 = 1 + 等待时间/服务时间
 * 
 * 特点：
 * - 综合考虑等待时间和服务时间
 * - 短作业优先，但避免长作业饥饿
 * - 等待时间越长，响应比越高
 * - 非抢占式（本实现中为了配合时钟中断，实现为抢占式）
 * 
 * 实现说明：
 * - 使用 proc->lab6_priority 作为预估服务时间（值越小，服务时间越短）
 * - 使用 proc->lab6_stride 记录进程进入就绪队列的时间（时钟tick数）
 * - 响应比 = 1 + (当前时间 - 进入时间) / 服务时间
 */

// 简单的时钟计数器，用于记录时间
static volatile uint32_t hrrn_ticks = 0;

static void
HRRN_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->proc_num = 0;
    hrrn_ticks = 0;
}

static void
HRRN_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(list_empty(&(proc->run_link)));
    
    // HRRN: 添加到队尾，记录进入时间
    list_add_before(&(rq->run_list), &(proc->run_link));
    
    // 使用 lab6_stride 记录进入就绪队列的时间
    proc->lab6_stride = hrrn_ticks;
    
    // 确保 lab6_priority 至少为 1（避免除零）
    if (proc->lab6_priority == 0) {
        proc->lab6_priority = 1;
    }
    
    // 给较大的时间片，模拟非抢占式
    proc->time_slice = rq->max_time_slice * 50;
    proc->rq = rq;
    rq->proc_num++;
}

static void
HRRN_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
    list_del_init(&(proc->run_link));
    rq->proc_num--;
}

/*
 * 计算响应比：RR = 1 + (当前时间 - 进入时间) / 服务时间
 * 为避免浮点运算，我们计算：RR * 服务时间 = 服务时间 + (当前时间 - 进入时间)
 */
static uint32_t
calc_response_ratio(struct proc_struct *proc, uint32_t current_time)
{
    uint32_t wait_time = current_time - proc->lab6_stride;
    uint32_t service_time = proc->lab6_priority;
    
    // 返回 响应比 * 服务时间，避免浮点运算
    // RR * service_time = service_time + wait_time
    return service_time + wait_time;
}

static struct proc_struct *
HRRN_pick_next(struct run_queue *rq)
{
    if (list_empty(&(rq->run_list))) {
        return NULL;
    }
    
    // HRRN: 遍历所有进程，找出响应比最高的
    struct proc_struct *best_proc = NULL;
    uint32_t best_ratio = 0;
    uint32_t current_time = hrrn_ticks;
    
    list_entry_t *le = list_next(&(rq->run_list));
    while (le != &(rq->run_list)) {
        struct proc_struct *p = le2proc(le, run_link);
        
        // 计算响应比（实际是响应比 * 服务时间）
        uint32_t ratio = calc_response_ratio(p, current_time);
        
        // 如果响应比相同，优先选择服务时间短的（lab6_priority小的）
        if (best_proc == NULL || 
            ratio > best_ratio || 
            (ratio == best_ratio && p->lab6_priority < best_proc->lab6_priority)) {
            best_proc = p;
            best_ratio = ratio;
        }
        
        le = list_next(le);
    }
    
    return best_proc;
}

static void
HRRN_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // 增加时钟计数
    hrrn_ticks++;
    
    // 处理时间片
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}

struct sched_class hrrn_sched_class = {
    .name = "HRRN_scheduler",
    .init = HRRN_init,
    .enqueue = HRRN_enqueue,
    .dequeue = HRRN_dequeue,
    .pick_next = HRRN_pick_next,
    .proc_tick = HRRN_proc_tick,
};
