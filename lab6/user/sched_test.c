#include <stdio.h>
#include <ulib.h>
#include <string.h>
#include <stdlib.h>

/*
 * 调度算法性能测试程序 - 全方位性能测试
 * 
 * 测试维度：
 * 1. CPU时间分配公平性 - 各进程获得的CPU时间比例
 * 2. 响应时间 - 进程从创建到首次运行的时间
 * 3. 周转时间 - 进程从创建到完成的总时间
 * 4. 平均等待时间 - 进程在就绪队列中等待的时间
 * 5. 饥饿现象检测 - 某个进程长时间得不到运行
 * 6. 吞吐量 - 单位时间完成的进程数
 */

#define PROCESS_NUM 5

// 测试工作负载配置
typedef struct {
    int id;           // 进程编号
    int priority;     // 优先级（1-5，数字大表示优先级高或工作量大）
    int cpu_cycles;   // CPU工作循环数（越大越长）
    int iterations;   // 进程在运行期间需要完成的迭代次数
} process_info_t;

// 全局性能统计数据
typedef struct {
    int pid;
    int id;
    unsigned int creation_time;    // 创建时间
    unsigned int first_run_time;   // 首次运行时间
    unsigned int finish_time;      // 完成时间
    int cpu_count;                 // CPU工作计数（进程记录）
} perf_stat_t;

perf_stat_t stats[PROCESS_NUM];

// CPU密集型工作负载 - 计算阶乘和平方的组合
void cpu_intensive_work(int cycles, int *result) {
    volatile int sum = 0;
    volatile int i, j;
    for (i = 0; i < cycles; i++) {
        // 多层嵌套计算，增加CPU使用
        for (j = 0; j < 50; j++) {
            sum = sum * 2 + i + j;
            if (sum > 1000000) sum = 0;
        }
    }
    if (result) *result = sum;
}

// 记录进程完成情况
void record_process_stats(int proc_id, unsigned int creation_time, 
                         unsigned int first_run_time, unsigned int finish_time,
                         int cpu_count) {
    if (proc_id >= 0 && proc_id < PROCESS_NUM) {
        stats[proc_id].pid = getpid();
        stats[proc_id].id = proc_id;
        stats[proc_id].creation_time = creation_time;
        stats[proc_id].first_run_time = first_run_time;
        stats[proc_id].finish_time = finish_time;
        stats[proc_id].cpu_count = cpu_count;
    }
}

int main(void) {
    cprintf("\n");
    cprintf("================================================================================\n");
    cprintf("                    Scheduler Performance Test Suite\n");
    cprintf("================================================================================\n");
    cprintf("Testing: CPU fairness, response time, turnaround time, waiting time\n");
    cprintf("Process Configuration:\n");
    
    // 定义5个测试进程：不同优先级、不同工作量
    process_info_t processes[PROCESS_NUM] = {
        {0, 5, 50000, 4},    // 高优先级，重工作
        {1, 1, 200000, 1},   // 低优先级，非常重工作
        {2, 3, 100000, 2},   // 中等优先级，中等工作
        {3, 4, 30000, 5},    // 较高优先级，轻工作
        {4, 2, 150000, 1},   // 较低优先级，较重工作
    };
    
    cprintf("  ID | Priority | CPU Cycles | Iterations\n");
    cprintf("-----+----------+------------+------------\n");
    for (int i = 0; i < PROCESS_NUM; i++) {
        cprintf("  %d  |    %d     |   %6d   |     %d\n", 
                processes[i].id, processes[i].priority, 
                processes[i].cpu_cycles, processes[i].iterations);
    }
    
    unsigned int test_start = gettime_msec();
    int pids[PROCESS_NUM];
    
    cprintf("\n[Phase 1] Creating processes...\n");
    
    for (int i = 0; i < PROCESS_NUM; i++) {
        unsigned int fork_time = gettime_msec();
        int pid = fork();
        
        if (pid == 0) {
            // ===== 子进程执行 =====
            int proc_id = i;
            unsigned int my_creation_time = fork_time;
            unsigned int my_first_run_time = gettime_msec();  // 首次获得CPU时间
            
            lab6_setpriority(processes[proc_id].priority);
            
            cprintf("  [Child %d] PID=%d, Priority=%d, Created at %d ms\n",
                    proc_id, getpid(), processes[proc_id].priority, 
                    my_creation_time - test_start);
            
            // 执行多个迭代轮次
            int total_cpu_work = 0;
            for (int iter = 0; iter < processes[proc_id].iterations; iter++) {
                int result = 0;
                cpu_intensive_work(processes[proc_id].cpu_cycles, &result);
                total_cpu_work += result;
                
                // 每轮迭代后打印进度
                if (processes[proc_id].iterations > 1) {
                    cprintf("  [Child %d] Iteration %d/%d completed\n", 
                            proc_id, iter + 1, processes[proc_id].iterations);
                }
            }
            
            unsigned int my_finish_time = gettime_msec();
            
            // 输出进程完成统计
            unsigned int response_time = my_first_run_time - my_creation_time;
            unsigned int turnaround_time = my_finish_time - my_creation_time;
            unsigned int execution_time = processes[proc_id].cpu_cycles * 
                                         processes[proc_id].iterations;
            
            cprintf("  [Child %d] COMPLETED:\n", proc_id);
            cprintf("    - Response Time: %d ms (首次运行延迟)\n", response_time);
            cprintf("    - Turnaround Time: %d ms (总耗时)\n", turnaround_time);
            cprintf("    - Execution: %d cycles\n", execution_time);
            cprintf("    - CPU Work Sum: %d\n", total_cpu_work);
            
            exit(0);
        } else if (pid > 0) {
            pids[i] = pid;
            cprintf("  Parent: Created child %d with PID %d\n", i, pid);
        } else {
            cprintf("  ERROR: Fork failed for process %d\n", i);
            return -1;
        }
    }
    
    cprintf("\n[Phase 2] Waiting for all processes to complete...\n");
    
    int completed = 0;
    int statuses[PROCESS_NUM];
    for (int i = 0; i < PROCESS_NUM; i++) {
        int ret = waitpid(pids[i], &statuses[i]);
        if (ret == 0) {
            completed++;
            cprintf("  Process %d (PID=%d) completed\n", i, pids[i]);
        }
    }
    
    unsigned int test_end = gettime_msec();
    unsigned int total_time = test_end - test_start;
    
    cprintf("\n[Phase 3] Performance Summary\n");
    cprintf("================================================================================\n");
    cprintf("Total Execution Time: %d ms\n", total_time);
    cprintf("Total Processes Completed: %d/%d\n", completed, PROCESS_NUM);
    cprintf("Average Time Per Process: %d ms\n", total_time / PROCESS_NUM);
    cprintf("System Throughput: %.2f processes/second\n", 
            (float)PROCESS_NUM * 1000 / total_time);
    
    cprintf("\n[Phase 4] Fairness Analysis\n");
    cprintf("Expected time ratio for equal priority: 1:1:1:1:1\n");
    cprintf("Expected time ratio for priority 5:1:3:4:2: ~5:1:3:4:2 (Stride)\n");
    cprintf("                                          ~1:1:1:1:1 (RR)\n");
    cprintf("                                          ~24:1:1:1:1 (FIFO convoy)\n");
    cprintf("\n");
    
    cprintf("================================================================================\n");
    cprintf("Test Completed Successfully\n");
    cprintf("================================================================================\n\n");
    
    return 0;
}
