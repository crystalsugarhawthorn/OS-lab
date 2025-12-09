#include <stdio.h>
#include <ulib.h>
#include <string.h>

// 一个全局变量，位于数据段，将被父子进程共享
volatile int shared_var = 100;

int main(void) {
    cprintf("COW test starting.\n");
    cprintf("Parent: initial shared_var = %d\n", shared_var);

    int pid = fork();

    if (pid < 0) {
        cprintf("fork failed.\n");
        return -1;
    }

    if (pid == 0) {
        // --- 子进程 ---
        cprintf("Child: initial shared_var = %d (inherited from parent)\n", shared_var);
        
        // 子进程修改变量，这应该触发 COW
        shared_var = 200;
        cprintf("Child: modified shared_var to %d\n", shared_var);
        
        exit(0); // 子进程正常退出
    } else {
        // --- 父进程 ---
        // 等待子进程结束
        int exit_code;
        waitpid(pid, &exit_code);
        cprintf("Parent: child has exited.\n");

        // 检查父进程中的变量值
        cprintf("Parent: final shared_var = %d\n", shared_var);

        // 验证 COW 是否成功
        if (shared_var == 100) {
            cprintf("COW test passed: Parent's variable was not changed.\n");
        } else {
            cprintf("COW test failed: Parent's variable was changed to %d.\n", shared_var);
        }
    }

    return 0;
}