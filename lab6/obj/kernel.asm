
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000c297          	auipc	t0,0xc
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020c000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000c297          	auipc	t0,0xc
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020c008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020b2b7          	lui	t0,0xc020b
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c020b137          	lui	sp,0xc020b

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc020004a:	000c2517          	auipc	a0,0xc2
ffffffffc020004e:	6c650513          	addi	a0,a0,1734 # ffffffffc02c2710 <buf>
ffffffffc0200052:	000c7617          	auipc	a2,0xc7
ffffffffc0200056:	b9e60613          	addi	a2,a2,-1122 # ffffffffc02c6bf0 <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	7ce050ef          	jal	ra,ffffffffc0205830 <memset>
    cons_init(); // init the console
ffffffffc0200066:	520000ef          	jal	ra,ffffffffc0200586 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006a:	00005597          	auipc	a1,0x5
ffffffffc020006e:	7f658593          	addi	a1,a1,2038 # ffffffffc0205860 <etext+0x6>
ffffffffc0200072:	00006517          	auipc	a0,0x6
ffffffffc0200076:	80e50513          	addi	a0,a0,-2034 # ffffffffc0205880 <etext+0x26>
ffffffffc020007a:	11e000ef          	jal	ra,ffffffffc0200198 <cprintf>

    print_kerninfo();
ffffffffc020007e:	1a2000ef          	jal	ra,ffffffffc0200220 <print_kerninfo>

    // grade_backtrace();

    dtb_init(); // init dtb
ffffffffc0200082:	576000ef          	jal	ra,ffffffffc02005f8 <dtb_init>

    pmm_init(); // init physical memory management
ffffffffc0200086:	598020ef          	jal	ra,ffffffffc020261e <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	12b000ef          	jal	ra,ffffffffc02009b4 <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	129000ef          	jal	ra,ffffffffc02009b6 <idt_init>

    vmm_init(); // init virtual memory management
ffffffffc0200092:	0df030ef          	jal	ra,ffffffffc0203970 <vmm_init>
    sched_init();
ffffffffc0200096:	030050ef          	jal	ra,ffffffffc02050c6 <sched_init>
    proc_init(); // init process table
ffffffffc020009a:	4c7040ef          	jal	ra,ffffffffc0204d60 <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009e:	4a0000ef          	jal	ra,ffffffffc020053e <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc02000a2:	107000ef          	jal	ra,ffffffffc02009a8 <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a6:	653040ef          	jal	ra,ffffffffc0204ef8 <cpu_idle>

ffffffffc02000aa <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02000aa:	715d                	addi	sp,sp,-80
ffffffffc02000ac:	e486                	sd	ra,72(sp)
ffffffffc02000ae:	e0a6                	sd	s1,64(sp)
ffffffffc02000b0:	fc4a                	sd	s2,56(sp)
ffffffffc02000b2:	f84e                	sd	s3,48(sp)
ffffffffc02000b4:	f452                	sd	s4,40(sp)
ffffffffc02000b6:	f056                	sd	s5,32(sp)
ffffffffc02000b8:	ec5a                	sd	s6,24(sp)
ffffffffc02000ba:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc02000bc:	c901                	beqz	a0,ffffffffc02000cc <readline+0x22>
ffffffffc02000be:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc02000c0:	00005517          	auipc	a0,0x5
ffffffffc02000c4:	7c850513          	addi	a0,a0,1992 # ffffffffc0205888 <etext+0x2e>
ffffffffc02000c8:	0d0000ef          	jal	ra,ffffffffc0200198 <cprintf>
readline(const char *prompt) {
ffffffffc02000cc:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ce:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc02000d0:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc02000d2:	4aa9                	li	s5,10
ffffffffc02000d4:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc02000d6:	000c2b97          	auipc	s7,0xc2
ffffffffc02000da:	63ab8b93          	addi	s7,s7,1594 # ffffffffc02c2710 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000de:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02000e2:	12e000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc02000e6:	00054a63          	bltz	a0,ffffffffc02000fa <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ea:	00a95a63          	bge	s2,a0,ffffffffc02000fe <readline+0x54>
ffffffffc02000ee:	029a5263          	bge	s4,s1,ffffffffc0200112 <readline+0x68>
        c = getchar();
ffffffffc02000f2:	11e000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc02000f6:	fe055ae3          	bgez	a0,ffffffffc02000ea <readline+0x40>
            return NULL;
ffffffffc02000fa:	4501                	li	a0,0
ffffffffc02000fc:	a091                	j	ffffffffc0200140 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02000fe:	03351463          	bne	a0,s3,ffffffffc0200126 <readline+0x7c>
ffffffffc0200102:	e8a9                	bnez	s1,ffffffffc0200154 <readline+0xaa>
        c = getchar();
ffffffffc0200104:	10c000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc0200108:	fe0549e3          	bltz	a0,ffffffffc02000fa <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc020010c:	fea959e3          	bge	s2,a0,ffffffffc02000fe <readline+0x54>
ffffffffc0200110:	4481                	li	s1,0
            cputchar(c);
ffffffffc0200112:	e42a                	sd	a0,8(sp)
ffffffffc0200114:	0ba000ef          	jal	ra,ffffffffc02001ce <cputchar>
            buf[i ++] = c;
ffffffffc0200118:	6522                	ld	a0,8(sp)
ffffffffc020011a:	009b87b3          	add	a5,s7,s1
ffffffffc020011e:	2485                	addiw	s1,s1,1
ffffffffc0200120:	00a78023          	sb	a0,0(a5)
ffffffffc0200124:	bf7d                	j	ffffffffc02000e2 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0200126:	01550463          	beq	a0,s5,ffffffffc020012e <readline+0x84>
ffffffffc020012a:	fb651ce3          	bne	a0,s6,ffffffffc02000e2 <readline+0x38>
            cputchar(c);
ffffffffc020012e:	0a0000ef          	jal	ra,ffffffffc02001ce <cputchar>
            buf[i] = '\0';
ffffffffc0200132:	000c2517          	auipc	a0,0xc2
ffffffffc0200136:	5de50513          	addi	a0,a0,1502 # ffffffffc02c2710 <buf>
ffffffffc020013a:	94aa                	add	s1,s1,a0
ffffffffc020013c:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0200140:	60a6                	ld	ra,72(sp)
ffffffffc0200142:	6486                	ld	s1,64(sp)
ffffffffc0200144:	7962                	ld	s2,56(sp)
ffffffffc0200146:	79c2                	ld	s3,48(sp)
ffffffffc0200148:	7a22                	ld	s4,40(sp)
ffffffffc020014a:	7a82                	ld	s5,32(sp)
ffffffffc020014c:	6b62                	ld	s6,24(sp)
ffffffffc020014e:	6bc2                	ld	s7,16(sp)
ffffffffc0200150:	6161                	addi	sp,sp,80
ffffffffc0200152:	8082                	ret
            cputchar(c);
ffffffffc0200154:	4521                	li	a0,8
ffffffffc0200156:	078000ef          	jal	ra,ffffffffc02001ce <cputchar>
            i --;
ffffffffc020015a:	34fd                	addiw	s1,s1,-1
ffffffffc020015c:	b759                	j	ffffffffc02000e2 <readline+0x38>

ffffffffc020015e <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc020015e:	1141                	addi	sp,sp,-16
ffffffffc0200160:	e022                	sd	s0,0(sp)
ffffffffc0200162:	e406                	sd	ra,8(sp)
ffffffffc0200164:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200166:	422000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    (*cnt)++;
ffffffffc020016a:	401c                	lw	a5,0(s0)
}
ffffffffc020016c:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc020016e:	2785                	addiw	a5,a5,1
ffffffffc0200170:	c01c                	sw	a5,0(s0)
}
ffffffffc0200172:	6402                	ld	s0,0(sp)
ffffffffc0200174:	0141                	addi	sp,sp,16
ffffffffc0200176:	8082                	ret

ffffffffc0200178 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc0200178:	1101                	addi	sp,sp,-32
ffffffffc020017a:	862a                	mv	a2,a0
ffffffffc020017c:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020017e:	00000517          	auipc	a0,0x0
ffffffffc0200182:	fe050513          	addi	a0,a0,-32 # ffffffffc020015e <cputch>
ffffffffc0200186:	006c                	addi	a1,sp,12
{
ffffffffc0200188:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc020018a:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020018c:	280050ef          	jal	ra,ffffffffc020540c <vprintfmt>
    return cnt;
}
ffffffffc0200190:	60e2                	ld	ra,24(sp)
ffffffffc0200192:	4532                	lw	a0,12(sp)
ffffffffc0200194:	6105                	addi	sp,sp,32
ffffffffc0200196:	8082                	ret

ffffffffc0200198 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc0200198:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc020019a:	02810313          	addi	t1,sp,40 # ffffffffc020b028 <boot_page_table_sv39+0x28>
{
ffffffffc020019e:	8e2a                	mv	t3,a0
ffffffffc02001a0:	f42e                	sd	a1,40(sp)
ffffffffc02001a2:	f832                	sd	a2,48(sp)
ffffffffc02001a4:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001a6:	00000517          	auipc	a0,0x0
ffffffffc02001aa:	fb850513          	addi	a0,a0,-72 # ffffffffc020015e <cputch>
ffffffffc02001ae:	004c                	addi	a1,sp,4
ffffffffc02001b0:	869a                	mv	a3,t1
ffffffffc02001b2:	8672                	mv	a2,t3
{
ffffffffc02001b4:	ec06                	sd	ra,24(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	e4be                	sd	a5,72(sp)
ffffffffc02001ba:	e8c2                	sd	a6,80(sp)
ffffffffc02001bc:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001be:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001c0:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001c2:	24a050ef          	jal	ra,ffffffffc020540c <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001c6:	60e2                	ld	ra,24(sp)
ffffffffc02001c8:	4512                	lw	a0,4(sp)
ffffffffc02001ca:	6125                	addi	sp,sp,96
ffffffffc02001cc:	8082                	ret

ffffffffc02001ce <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc02001ce:	ae6d                	j	ffffffffc0200588 <cons_putc>

ffffffffc02001d0 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc02001d0:	1101                	addi	sp,sp,-32
ffffffffc02001d2:	e822                	sd	s0,16(sp)
ffffffffc02001d4:	ec06                	sd	ra,24(sp)
ffffffffc02001d6:	e426                	sd	s1,8(sp)
ffffffffc02001d8:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc02001da:	00054503          	lbu	a0,0(a0)
ffffffffc02001de:	c51d                	beqz	a0,ffffffffc020020c <cputs+0x3c>
ffffffffc02001e0:	0405                	addi	s0,s0,1
ffffffffc02001e2:	4485                	li	s1,1
ffffffffc02001e4:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001e6:	3a2000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc02001ea:	00044503          	lbu	a0,0(s0)
ffffffffc02001ee:	008487bb          	addw	a5,s1,s0
ffffffffc02001f2:	0405                	addi	s0,s0,1
ffffffffc02001f4:	f96d                	bnez	a0,ffffffffc02001e6 <cputs+0x16>
    (*cnt)++;
ffffffffc02001f6:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001fa:	4529                	li	a0,10
ffffffffc02001fc:	38c000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200200:	60e2                	ld	ra,24(sp)
ffffffffc0200202:	8522                	mv	a0,s0
ffffffffc0200204:	6442                	ld	s0,16(sp)
ffffffffc0200206:	64a2                	ld	s1,8(sp)
ffffffffc0200208:	6105                	addi	sp,sp,32
ffffffffc020020a:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc020020c:	4405                	li	s0,1
ffffffffc020020e:	b7f5                	j	ffffffffc02001fa <cputs+0x2a>

ffffffffc0200210 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc0200210:	1141                	addi	sp,sp,-16
ffffffffc0200212:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200214:	3a8000ef          	jal	ra,ffffffffc02005bc <cons_getc>
ffffffffc0200218:	dd75                	beqz	a0,ffffffffc0200214 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020021a:	60a2                	ld	ra,8(sp)
ffffffffc020021c:	0141                	addi	sp,sp,16
ffffffffc020021e:	8082                	ret

ffffffffc0200220 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc0200220:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc0200222:	00005517          	auipc	a0,0x5
ffffffffc0200226:	66e50513          	addi	a0,a0,1646 # ffffffffc0205890 <etext+0x36>
void print_kerninfo(void) {
ffffffffc020022a:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc020022c:	f6dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc0200230:	00000597          	auipc	a1,0x0
ffffffffc0200234:	e1a58593          	addi	a1,a1,-486 # ffffffffc020004a <kern_init>
ffffffffc0200238:	00005517          	auipc	a0,0x5
ffffffffc020023c:	67850513          	addi	a0,a0,1656 # ffffffffc02058b0 <etext+0x56>
ffffffffc0200240:	f59ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc0200244:	00005597          	auipc	a1,0x5
ffffffffc0200248:	61658593          	addi	a1,a1,1558 # ffffffffc020585a <etext>
ffffffffc020024c:	00005517          	auipc	a0,0x5
ffffffffc0200250:	68450513          	addi	a0,a0,1668 # ffffffffc02058d0 <etext+0x76>
ffffffffc0200254:	f45ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200258:	000c2597          	auipc	a1,0xc2
ffffffffc020025c:	4b858593          	addi	a1,a1,1208 # ffffffffc02c2710 <buf>
ffffffffc0200260:	00005517          	auipc	a0,0x5
ffffffffc0200264:	69050513          	addi	a0,a0,1680 # ffffffffc02058f0 <etext+0x96>
ffffffffc0200268:	f31ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc020026c:	000c7597          	auipc	a1,0xc7
ffffffffc0200270:	98458593          	addi	a1,a1,-1660 # ffffffffc02c6bf0 <end>
ffffffffc0200274:	00005517          	auipc	a0,0x5
ffffffffc0200278:	69c50513          	addi	a0,a0,1692 # ffffffffc0205910 <etext+0xb6>
ffffffffc020027c:	f1dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc0200280:	000c7597          	auipc	a1,0xc7
ffffffffc0200284:	d6f58593          	addi	a1,a1,-657 # ffffffffc02c6fef <end+0x3ff>
ffffffffc0200288:	00000797          	auipc	a5,0x0
ffffffffc020028c:	dc278793          	addi	a5,a5,-574 # ffffffffc020004a <kern_init>
ffffffffc0200290:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200294:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200298:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020029a:	3ff5f593          	andi	a1,a1,1023
ffffffffc020029e:	95be                	add	a1,a1,a5
ffffffffc02002a0:	85a9                	srai	a1,a1,0xa
ffffffffc02002a2:	00005517          	auipc	a0,0x5
ffffffffc02002a6:	68e50513          	addi	a0,a0,1678 # ffffffffc0205930 <etext+0xd6>
}
ffffffffc02002aa:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02002ac:	b5f5                	j	ffffffffc0200198 <cprintf>

ffffffffc02002ae <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc02002ae:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02002b0:	00005617          	auipc	a2,0x5
ffffffffc02002b4:	6b060613          	addi	a2,a2,1712 # ffffffffc0205960 <etext+0x106>
ffffffffc02002b8:	04d00593          	li	a1,77
ffffffffc02002bc:	00005517          	auipc	a0,0x5
ffffffffc02002c0:	6bc50513          	addi	a0,a0,1724 # ffffffffc0205978 <etext+0x11e>
void print_stackframe(void) {
ffffffffc02002c4:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02002c6:	1cc000ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02002ca <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002ca:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002cc:	00005617          	auipc	a2,0x5
ffffffffc02002d0:	6c460613          	addi	a2,a2,1732 # ffffffffc0205990 <etext+0x136>
ffffffffc02002d4:	00005597          	auipc	a1,0x5
ffffffffc02002d8:	6dc58593          	addi	a1,a1,1756 # ffffffffc02059b0 <etext+0x156>
ffffffffc02002dc:	00005517          	auipc	a0,0x5
ffffffffc02002e0:	6dc50513          	addi	a0,a0,1756 # ffffffffc02059b8 <etext+0x15e>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002e4:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002e6:	eb3ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc02002ea:	00005617          	auipc	a2,0x5
ffffffffc02002ee:	6de60613          	addi	a2,a2,1758 # ffffffffc02059c8 <etext+0x16e>
ffffffffc02002f2:	00005597          	auipc	a1,0x5
ffffffffc02002f6:	6fe58593          	addi	a1,a1,1790 # ffffffffc02059f0 <etext+0x196>
ffffffffc02002fa:	00005517          	auipc	a0,0x5
ffffffffc02002fe:	6be50513          	addi	a0,a0,1726 # ffffffffc02059b8 <etext+0x15e>
ffffffffc0200302:	e97ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0200306:	00005617          	auipc	a2,0x5
ffffffffc020030a:	6fa60613          	addi	a2,a2,1786 # ffffffffc0205a00 <etext+0x1a6>
ffffffffc020030e:	00005597          	auipc	a1,0x5
ffffffffc0200312:	71258593          	addi	a1,a1,1810 # ffffffffc0205a20 <etext+0x1c6>
ffffffffc0200316:	00005517          	auipc	a0,0x5
ffffffffc020031a:	6a250513          	addi	a0,a0,1698 # ffffffffc02059b8 <etext+0x15e>
ffffffffc020031e:	e7bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    }
    return 0;
}
ffffffffc0200322:	60a2                	ld	ra,8(sp)
ffffffffc0200324:	4501                	li	a0,0
ffffffffc0200326:	0141                	addi	sp,sp,16
ffffffffc0200328:	8082                	ret

ffffffffc020032a <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc020032a:	1141                	addi	sp,sp,-16
ffffffffc020032c:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020032e:	ef3ff0ef          	jal	ra,ffffffffc0200220 <print_kerninfo>
    return 0;
}
ffffffffc0200332:	60a2                	ld	ra,8(sp)
ffffffffc0200334:	4501                	li	a0,0
ffffffffc0200336:	0141                	addi	sp,sp,16
ffffffffc0200338:	8082                	ret

ffffffffc020033a <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc020033a:	1141                	addi	sp,sp,-16
ffffffffc020033c:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020033e:	f71ff0ef          	jal	ra,ffffffffc02002ae <print_stackframe>
    return 0;
}
ffffffffc0200342:	60a2                	ld	ra,8(sp)
ffffffffc0200344:	4501                	li	a0,0
ffffffffc0200346:	0141                	addi	sp,sp,16
ffffffffc0200348:	8082                	ret

ffffffffc020034a <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc020034a:	7115                	addi	sp,sp,-224
ffffffffc020034c:	ed5e                	sd	s7,152(sp)
ffffffffc020034e:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200350:	00005517          	auipc	a0,0x5
ffffffffc0200354:	6e050513          	addi	a0,a0,1760 # ffffffffc0205a30 <etext+0x1d6>
kmonitor(struct trapframe *tf) {
ffffffffc0200358:	ed86                	sd	ra,216(sp)
ffffffffc020035a:	e9a2                	sd	s0,208(sp)
ffffffffc020035c:	e5a6                	sd	s1,200(sp)
ffffffffc020035e:	e1ca                	sd	s2,192(sp)
ffffffffc0200360:	fd4e                	sd	s3,184(sp)
ffffffffc0200362:	f952                	sd	s4,176(sp)
ffffffffc0200364:	f556                	sd	s5,168(sp)
ffffffffc0200366:	f15a                	sd	s6,160(sp)
ffffffffc0200368:	e962                	sd	s8,144(sp)
ffffffffc020036a:	e566                	sd	s9,136(sp)
ffffffffc020036c:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020036e:	e2bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc0200372:	00005517          	auipc	a0,0x5
ffffffffc0200376:	6e650513          	addi	a0,a0,1766 # ffffffffc0205a58 <etext+0x1fe>
ffffffffc020037a:	e1fff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    if (tf != NULL) {
ffffffffc020037e:	000b8563          	beqz	s7,ffffffffc0200388 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc0200382:	855e                	mv	a0,s7
ffffffffc0200384:	01b000ef          	jal	ra,ffffffffc0200b9e <print_trapframe>
ffffffffc0200388:	00005c17          	auipc	s8,0x5
ffffffffc020038c:	740c0c13          	addi	s8,s8,1856 # ffffffffc0205ac8 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200390:	00005917          	auipc	s2,0x5
ffffffffc0200394:	6f090913          	addi	s2,s2,1776 # ffffffffc0205a80 <etext+0x226>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200398:	00005497          	auipc	s1,0x5
ffffffffc020039c:	6f048493          	addi	s1,s1,1776 # ffffffffc0205a88 <etext+0x22e>
        if (argc == MAXARGS - 1) {
ffffffffc02003a0:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003a2:	00005b17          	auipc	s6,0x5
ffffffffc02003a6:	6eeb0b13          	addi	s6,s6,1774 # ffffffffc0205a90 <etext+0x236>
        argv[argc ++] = buf;
ffffffffc02003aa:	00005a17          	auipc	s4,0x5
ffffffffc02003ae:	606a0a13          	addi	s4,s4,1542 # ffffffffc02059b0 <etext+0x156>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003b2:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02003b4:	854a                	mv	a0,s2
ffffffffc02003b6:	cf5ff0ef          	jal	ra,ffffffffc02000aa <readline>
ffffffffc02003ba:	842a                	mv	s0,a0
ffffffffc02003bc:	dd65                	beqz	a0,ffffffffc02003b4 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003be:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02003c2:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003c4:	e1bd                	bnez	a1,ffffffffc020042a <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc02003c6:	fe0c87e3          	beqz	s9,ffffffffc02003b4 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003ca:	6582                	ld	a1,0(sp)
ffffffffc02003cc:	00005d17          	auipc	s10,0x5
ffffffffc02003d0:	6fcd0d13          	addi	s10,s10,1788 # ffffffffc0205ac8 <commands>
        argv[argc ++] = buf;
ffffffffc02003d4:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003d6:	4401                	li	s0,0
ffffffffc02003d8:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003da:	3fc050ef          	jal	ra,ffffffffc02057d6 <strcmp>
ffffffffc02003de:	c919                	beqz	a0,ffffffffc02003f4 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003e0:	2405                	addiw	s0,s0,1
ffffffffc02003e2:	0b540063          	beq	s0,s5,ffffffffc0200482 <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003e6:	000d3503          	ld	a0,0(s10)
ffffffffc02003ea:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003ec:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003ee:	3e8050ef          	jal	ra,ffffffffc02057d6 <strcmp>
ffffffffc02003f2:	f57d                	bnez	a0,ffffffffc02003e0 <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc02003f4:	00141793          	slli	a5,s0,0x1
ffffffffc02003f8:	97a2                	add	a5,a5,s0
ffffffffc02003fa:	078e                	slli	a5,a5,0x3
ffffffffc02003fc:	97e2                	add	a5,a5,s8
ffffffffc02003fe:	6b9c                	ld	a5,16(a5)
ffffffffc0200400:	865e                	mv	a2,s7
ffffffffc0200402:	002c                	addi	a1,sp,8
ffffffffc0200404:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200408:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc020040a:	fa0555e3          	bgez	a0,ffffffffc02003b4 <kmonitor+0x6a>
}
ffffffffc020040e:	60ee                	ld	ra,216(sp)
ffffffffc0200410:	644e                	ld	s0,208(sp)
ffffffffc0200412:	64ae                	ld	s1,200(sp)
ffffffffc0200414:	690e                	ld	s2,192(sp)
ffffffffc0200416:	79ea                	ld	s3,184(sp)
ffffffffc0200418:	7a4a                	ld	s4,176(sp)
ffffffffc020041a:	7aaa                	ld	s5,168(sp)
ffffffffc020041c:	7b0a                	ld	s6,160(sp)
ffffffffc020041e:	6bea                	ld	s7,152(sp)
ffffffffc0200420:	6c4a                	ld	s8,144(sp)
ffffffffc0200422:	6caa                	ld	s9,136(sp)
ffffffffc0200424:	6d0a                	ld	s10,128(sp)
ffffffffc0200426:	612d                	addi	sp,sp,224
ffffffffc0200428:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020042a:	8526                	mv	a0,s1
ffffffffc020042c:	3ee050ef          	jal	ra,ffffffffc020581a <strchr>
ffffffffc0200430:	c901                	beqz	a0,ffffffffc0200440 <kmonitor+0xf6>
ffffffffc0200432:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc0200436:	00040023          	sb	zero,0(s0)
ffffffffc020043a:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020043c:	d5c9                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc020043e:	b7f5                	j	ffffffffc020042a <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc0200440:	00044783          	lbu	a5,0(s0)
ffffffffc0200444:	d3c9                	beqz	a5,ffffffffc02003c6 <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc0200446:	033c8963          	beq	s9,s3,ffffffffc0200478 <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc020044a:	003c9793          	slli	a5,s9,0x3
ffffffffc020044e:	0118                	addi	a4,sp,128
ffffffffc0200450:	97ba                	add	a5,a5,a4
ffffffffc0200452:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200456:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc020045a:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc020045c:	e591                	bnez	a1,ffffffffc0200468 <kmonitor+0x11e>
ffffffffc020045e:	b7b5                	j	ffffffffc02003ca <kmonitor+0x80>
ffffffffc0200460:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc0200464:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200466:	d1a5                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc0200468:	8526                	mv	a0,s1
ffffffffc020046a:	3b0050ef          	jal	ra,ffffffffc020581a <strchr>
ffffffffc020046e:	d96d                	beqz	a0,ffffffffc0200460 <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200470:	00044583          	lbu	a1,0(s0)
ffffffffc0200474:	d9a9                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc0200476:	bf55                	j	ffffffffc020042a <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200478:	45c1                	li	a1,16
ffffffffc020047a:	855a                	mv	a0,s6
ffffffffc020047c:	d1dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0200480:	b7e9                	j	ffffffffc020044a <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc0200482:	6582                	ld	a1,0(sp)
ffffffffc0200484:	00005517          	auipc	a0,0x5
ffffffffc0200488:	62c50513          	addi	a0,a0,1580 # ffffffffc0205ab0 <etext+0x256>
ffffffffc020048c:	d0dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return 0;
ffffffffc0200490:	b715                	j	ffffffffc02003b4 <kmonitor+0x6a>

ffffffffc0200492 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200492:	000c6317          	auipc	t1,0xc6
ffffffffc0200496:	6d630313          	addi	t1,t1,1750 # ffffffffc02c6b68 <is_panic>
ffffffffc020049a:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc020049e:	715d                	addi	sp,sp,-80
ffffffffc02004a0:	ec06                	sd	ra,24(sp)
ffffffffc02004a2:	e822                	sd	s0,16(sp)
ffffffffc02004a4:	f436                	sd	a3,40(sp)
ffffffffc02004a6:	f83a                	sd	a4,48(sp)
ffffffffc02004a8:	fc3e                	sd	a5,56(sp)
ffffffffc02004aa:	e0c2                	sd	a6,64(sp)
ffffffffc02004ac:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02004ae:	020e1a63          	bnez	t3,ffffffffc02004e2 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02004b2:	4785                	li	a5,1
ffffffffc02004b4:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02004b8:	8432                	mv	s0,a2
ffffffffc02004ba:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004bc:	862e                	mv	a2,a1
ffffffffc02004be:	85aa                	mv	a1,a0
ffffffffc02004c0:	00005517          	auipc	a0,0x5
ffffffffc02004c4:	65050513          	addi	a0,a0,1616 # ffffffffc0205b10 <commands+0x48>
    va_start(ap, fmt);
ffffffffc02004c8:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004ca:	ccfff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02004ce:	65a2                	ld	a1,8(sp)
ffffffffc02004d0:	8522                	mv	a0,s0
ffffffffc02004d2:	ca7ff0ef          	jal	ra,ffffffffc0200178 <vcprintf>
    cprintf("\n");
ffffffffc02004d6:	00006517          	auipc	a0,0x6
ffffffffc02004da:	73250513          	addi	a0,a0,1842 # ffffffffc0206c08 <default_pmm_manager+0x578>
ffffffffc02004de:	cbbff0ef          	jal	ra,ffffffffc0200198 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc02004e2:	4501                	li	a0,0
ffffffffc02004e4:	4581                	li	a1,0
ffffffffc02004e6:	4601                	li	a2,0
ffffffffc02004e8:	48a1                	li	a7,8
ffffffffc02004ea:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc02004ee:	4c0000ef          	jal	ra,ffffffffc02009ae <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc02004f2:	4501                	li	a0,0
ffffffffc02004f4:	e57ff0ef          	jal	ra,ffffffffc020034a <kmonitor>
    while (1) {
ffffffffc02004f8:	bfed                	j	ffffffffc02004f2 <__panic+0x60>

ffffffffc02004fa <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc02004fa:	715d                	addi	sp,sp,-80
ffffffffc02004fc:	832e                	mv	t1,a1
ffffffffc02004fe:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200500:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200502:	8432                	mv	s0,a2
ffffffffc0200504:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200506:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200508:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020050a:	00005517          	auipc	a0,0x5
ffffffffc020050e:	62650513          	addi	a0,a0,1574 # ffffffffc0205b30 <commands+0x68>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200512:	ec06                	sd	ra,24(sp)
ffffffffc0200514:	f436                	sd	a3,40(sp)
ffffffffc0200516:	f83a                	sd	a4,48(sp)
ffffffffc0200518:	e0c2                	sd	a6,64(sp)
ffffffffc020051a:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020051c:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020051e:	c7bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200522:	65a2                	ld	a1,8(sp)
ffffffffc0200524:	8522                	mv	a0,s0
ffffffffc0200526:	c53ff0ef          	jal	ra,ffffffffc0200178 <vcprintf>
    cprintf("\n");
ffffffffc020052a:	00006517          	auipc	a0,0x6
ffffffffc020052e:	6de50513          	addi	a0,a0,1758 # ffffffffc0206c08 <default_pmm_manager+0x578>
ffffffffc0200532:	c67ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    va_end(ap);
}
ffffffffc0200536:	60e2                	ld	ra,24(sp)
ffffffffc0200538:	6442                	ld	s0,16(sp)
ffffffffc020053a:	6161                	addi	sp,sp,80
ffffffffc020053c:	8082                	ret

ffffffffc020053e <clock_init>:
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void)
{
    set_csr(sie, MIP_STIP);
ffffffffc020053e:	02000793          	li	a5,32
ffffffffc0200542:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200546:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020054a:	67e1                	lui	a5,0x18
ffffffffc020054c:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_matrix_out_size+0xbf90>
ffffffffc0200550:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc0200552:	4581                	li	a1,0
ffffffffc0200554:	4601                	li	a2,0
ffffffffc0200556:	4881                	li	a7,0
ffffffffc0200558:	00000073          	ecall
    cprintf("++ setup timer interrupts\n");
ffffffffc020055c:	00005517          	auipc	a0,0x5
ffffffffc0200560:	5f450513          	addi	a0,a0,1524 # ffffffffc0205b50 <commands+0x88>
    ticks = 0;
ffffffffc0200564:	000c6797          	auipc	a5,0xc6
ffffffffc0200568:	6007b623          	sd	zero,1548(a5) # ffffffffc02c6b70 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc020056c:	b135                	j	ffffffffc0200198 <cprintf>

ffffffffc020056e <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020056e:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200572:	67e1                	lui	a5,0x18
ffffffffc0200574:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_matrix_out_size+0xbf90>
ffffffffc0200578:	953e                	add	a0,a0,a5
ffffffffc020057a:	4581                	li	a1,0
ffffffffc020057c:	4601                	li	a2,0
ffffffffc020057e:	4881                	li	a7,0
ffffffffc0200580:	00000073          	ecall
ffffffffc0200584:	8082                	ret

ffffffffc0200586 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200586:	8082                	ret

ffffffffc0200588 <cons_putc>:
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0200588:	100027f3          	csrr	a5,sstatus
ffffffffc020058c:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc020058e:	0ff57513          	zext.b	a0,a0
ffffffffc0200592:	e799                	bnez	a5,ffffffffc02005a0 <cons_putc+0x18>
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4885                	li	a7,1
ffffffffc020059a:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc020059e:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005a6:	408000ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02005aa:	6522                	ld	a0,8(sp)
ffffffffc02005ac:	4581                	li	a1,0
ffffffffc02005ae:	4601                	li	a2,0
ffffffffc02005b0:	4885                	li	a7,1
ffffffffc02005b2:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005b6:	60e2                	ld	ra,24(sp)
ffffffffc02005b8:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc02005ba:	a6fd                	j	ffffffffc02009a8 <intr_enable>

ffffffffc02005bc <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	eb89                	bnez	a5,ffffffffc02005d4 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005c4:	4501                	li	a0,0
ffffffffc02005c6:	4581                	li	a1,0
ffffffffc02005c8:	4601                	li	a2,0
ffffffffc02005ca:	4889                	li	a7,2
ffffffffc02005cc:	00000073          	ecall
ffffffffc02005d0:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d2:	8082                	ret
int cons_getc(void) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005d8:	3d6000ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02005dc:	4501                	li	a0,0
ffffffffc02005de:	4581                	li	a1,0
ffffffffc02005e0:	4601                	li	a2,0
ffffffffc02005e2:	4889                	li	a7,2
ffffffffc02005e4:	00000073          	ecall
ffffffffc02005e8:	2501                	sext.w	a0,a0
ffffffffc02005ea:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005ec:	3bc000ef          	jal	ra,ffffffffc02009a8 <intr_enable>
}
ffffffffc02005f0:	60e2                	ld	ra,24(sp)
ffffffffc02005f2:	6522                	ld	a0,8(sp)
ffffffffc02005f4:	6105                	addi	sp,sp,32
ffffffffc02005f6:	8082                	ret

ffffffffc02005f8 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02005f8:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc02005fa:	00005517          	auipc	a0,0x5
ffffffffc02005fe:	57650513          	addi	a0,a0,1398 # ffffffffc0205b70 <commands+0xa8>
void dtb_init(void) {
ffffffffc0200602:	fc86                	sd	ra,120(sp)
ffffffffc0200604:	f8a2                	sd	s0,112(sp)
ffffffffc0200606:	e8d2                	sd	s4,80(sp)
ffffffffc0200608:	f4a6                	sd	s1,104(sp)
ffffffffc020060a:	f0ca                	sd	s2,96(sp)
ffffffffc020060c:	ecce                	sd	s3,88(sp)
ffffffffc020060e:	e4d6                	sd	s5,72(sp)
ffffffffc0200610:	e0da                	sd	s6,64(sp)
ffffffffc0200612:	fc5e                	sd	s7,56(sp)
ffffffffc0200614:	f862                	sd	s8,48(sp)
ffffffffc0200616:	f466                	sd	s9,40(sp)
ffffffffc0200618:	f06a                	sd	s10,32(sp)
ffffffffc020061a:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc020061c:	b7dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200620:	0000c597          	auipc	a1,0xc
ffffffffc0200624:	9e05b583          	ld	a1,-1568(a1) # ffffffffc020c000 <boot_hartid>
ffffffffc0200628:	00005517          	auipc	a0,0x5
ffffffffc020062c:	55850513          	addi	a0,a0,1368 # ffffffffc0205b80 <commands+0xb8>
ffffffffc0200630:	b69ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc0200634:	0000c417          	auipc	s0,0xc
ffffffffc0200638:	9d440413          	addi	s0,s0,-1580 # ffffffffc020c008 <boot_dtb>
ffffffffc020063c:	600c                	ld	a1,0(s0)
ffffffffc020063e:	00005517          	auipc	a0,0x5
ffffffffc0200642:	55250513          	addi	a0,a0,1362 # ffffffffc0205b90 <commands+0xc8>
ffffffffc0200646:	b53ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc020064a:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc020064e:	00005517          	auipc	a0,0x5
ffffffffc0200652:	55a50513          	addi	a0,a0,1370 # ffffffffc0205ba8 <commands+0xe0>
    if (boot_dtb == 0) {
ffffffffc0200656:	120a0463          	beqz	s4,ffffffffc020077e <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc020065a:	57f5                	li	a5,-3
ffffffffc020065c:	07fa                	slli	a5,a5,0x1e
ffffffffc020065e:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200662:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200664:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200668:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020066e:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200672:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200676:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020067a:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067e:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200680:	8ec9                	or	a3,a3,a0
ffffffffc0200682:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200686:	1b7d                	addi	s6,s6,-1
ffffffffc0200688:	0167f7b3          	and	a5,a5,s6
ffffffffc020068c:	8dd5                	or	a1,a1,a3
ffffffffc020068e:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200690:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200694:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc0200696:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe192fd>
ffffffffc020069a:	10f59163          	bne	a1,a5,ffffffffc020079c <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc020069e:	471c                	lw	a5,8(a4)
ffffffffc02006a0:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02006a2:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006a4:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02006a8:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02006ac:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b0:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006b4:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b8:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006bc:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c0:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c4:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c8:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006cc:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ce:	01146433          	or	s0,s0,a7
ffffffffc02006d2:	0086969b          	slliw	a3,a3,0x8
ffffffffc02006d6:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006da:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006dc:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e0:	8c49                	or	s0,s0,a0
ffffffffc02006e2:	0166f6b3          	and	a3,a3,s6
ffffffffc02006e6:	00ca6a33          	or	s4,s4,a2
ffffffffc02006ea:	0167f7b3          	and	a5,a5,s6
ffffffffc02006ee:	8c55                	or	s0,s0,a3
ffffffffc02006f0:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006f4:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006f6:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006f8:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006fa:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fe:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200700:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200702:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc0200706:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200708:	00005917          	auipc	s2,0x5
ffffffffc020070c:	4f090913          	addi	s2,s2,1264 # ffffffffc0205bf8 <commands+0x130>
ffffffffc0200710:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200712:	4d91                	li	s11,4
ffffffffc0200714:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200716:	00005497          	auipc	s1,0x5
ffffffffc020071a:	4da48493          	addi	s1,s1,1242 # ffffffffc0205bf0 <commands+0x128>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc020071e:	000a2703          	lw	a4,0(s4)
ffffffffc0200722:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200726:	0087569b          	srliw	a3,a4,0x8
ffffffffc020072a:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020072e:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200732:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200736:	0107571b          	srliw	a4,a4,0x10
ffffffffc020073a:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020073c:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200740:	0087171b          	slliw	a4,a4,0x8
ffffffffc0200744:	8fd5                	or	a5,a5,a3
ffffffffc0200746:	00eb7733          	and	a4,s6,a4
ffffffffc020074a:	8fd9                	or	a5,a5,a4
ffffffffc020074c:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc020074e:	09778c63          	beq	a5,s7,ffffffffc02007e6 <dtb_init+0x1ee>
ffffffffc0200752:	00fbea63          	bltu	s7,a5,ffffffffc0200766 <dtb_init+0x16e>
ffffffffc0200756:	07a78663          	beq	a5,s10,ffffffffc02007c2 <dtb_init+0x1ca>
ffffffffc020075a:	4709                	li	a4,2
ffffffffc020075c:	00e79763          	bne	a5,a4,ffffffffc020076a <dtb_init+0x172>
ffffffffc0200760:	4c81                	li	s9,0
ffffffffc0200762:	8a56                	mv	s4,s5
ffffffffc0200764:	bf6d                	j	ffffffffc020071e <dtb_init+0x126>
ffffffffc0200766:	ffb78ee3          	beq	a5,s11,ffffffffc0200762 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc020076a:	00005517          	auipc	a0,0x5
ffffffffc020076e:	50650513          	addi	a0,a0,1286 # ffffffffc0205c70 <commands+0x1a8>
ffffffffc0200772:	a27ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc0200776:	00005517          	auipc	a0,0x5
ffffffffc020077a:	53250513          	addi	a0,a0,1330 # ffffffffc0205ca8 <commands+0x1e0>
}
ffffffffc020077e:	7446                	ld	s0,112(sp)
ffffffffc0200780:	70e6                	ld	ra,120(sp)
ffffffffc0200782:	74a6                	ld	s1,104(sp)
ffffffffc0200784:	7906                	ld	s2,96(sp)
ffffffffc0200786:	69e6                	ld	s3,88(sp)
ffffffffc0200788:	6a46                	ld	s4,80(sp)
ffffffffc020078a:	6aa6                	ld	s5,72(sp)
ffffffffc020078c:	6b06                	ld	s6,64(sp)
ffffffffc020078e:	7be2                	ld	s7,56(sp)
ffffffffc0200790:	7c42                	ld	s8,48(sp)
ffffffffc0200792:	7ca2                	ld	s9,40(sp)
ffffffffc0200794:	7d02                	ld	s10,32(sp)
ffffffffc0200796:	6de2                	ld	s11,24(sp)
ffffffffc0200798:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc020079a:	bafd                	j	ffffffffc0200198 <cprintf>
}
ffffffffc020079c:	7446                	ld	s0,112(sp)
ffffffffc020079e:	70e6                	ld	ra,120(sp)
ffffffffc02007a0:	74a6                	ld	s1,104(sp)
ffffffffc02007a2:	7906                	ld	s2,96(sp)
ffffffffc02007a4:	69e6                	ld	s3,88(sp)
ffffffffc02007a6:	6a46                	ld	s4,80(sp)
ffffffffc02007a8:	6aa6                	ld	s5,72(sp)
ffffffffc02007aa:	6b06                	ld	s6,64(sp)
ffffffffc02007ac:	7be2                	ld	s7,56(sp)
ffffffffc02007ae:	7c42                	ld	s8,48(sp)
ffffffffc02007b0:	7ca2                	ld	s9,40(sp)
ffffffffc02007b2:	7d02                	ld	s10,32(sp)
ffffffffc02007b4:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007b6:	00005517          	auipc	a0,0x5
ffffffffc02007ba:	41250513          	addi	a0,a0,1042 # ffffffffc0205bc8 <commands+0x100>
}
ffffffffc02007be:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007c0:	bae1                	j	ffffffffc0200198 <cprintf>
                int name_len = strlen(name);
ffffffffc02007c2:	8556                	mv	a0,s5
ffffffffc02007c4:	7cb040ef          	jal	ra,ffffffffc020578e <strlen>
ffffffffc02007c8:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007ca:	4619                	li	a2,6
ffffffffc02007cc:	85a6                	mv	a1,s1
ffffffffc02007ce:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02007d0:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d2:	022050ef          	jal	ra,ffffffffc02057f4 <strncmp>
ffffffffc02007d6:	e111                	bnez	a0,ffffffffc02007da <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc02007d8:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc02007da:	0a91                	addi	s5,s5,4
ffffffffc02007dc:	9ad2                	add	s5,s5,s4
ffffffffc02007de:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02007e2:	8a56                	mv	s4,s5
ffffffffc02007e4:	bf2d                	j	ffffffffc020071e <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007e6:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007ea:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007ee:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02007f2:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007f6:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007fa:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007fe:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200802:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200806:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020080a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020080e:	00eaeab3          	or	s5,s5,a4
ffffffffc0200812:	00fb77b3          	and	a5,s6,a5
ffffffffc0200816:	00faeab3          	or	s5,s5,a5
ffffffffc020081a:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020081c:	000c9c63          	bnez	s9,ffffffffc0200834 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200820:	1a82                	slli	s5,s5,0x20
ffffffffc0200822:	00368793          	addi	a5,a3,3
ffffffffc0200826:	020ada93          	srli	s5,s5,0x20
ffffffffc020082a:	9abe                	add	s5,s5,a5
ffffffffc020082c:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200830:	8a56                	mv	s4,s5
ffffffffc0200832:	b5f5                	j	ffffffffc020071e <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200834:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200838:	85ca                	mv	a1,s2
ffffffffc020083a:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020083c:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200840:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200844:	0187971b          	slliw	a4,a5,0x18
ffffffffc0200848:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020084c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200850:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200852:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200856:	0087979b          	slliw	a5,a5,0x8
ffffffffc020085a:	8d59                	or	a0,a0,a4
ffffffffc020085c:	00fb77b3          	and	a5,s6,a5
ffffffffc0200860:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200862:	1502                	slli	a0,a0,0x20
ffffffffc0200864:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200866:	9522                	add	a0,a0,s0
ffffffffc0200868:	76f040ef          	jal	ra,ffffffffc02057d6 <strcmp>
ffffffffc020086c:	66a2                	ld	a3,8(sp)
ffffffffc020086e:	f94d                	bnez	a0,ffffffffc0200820 <dtb_init+0x228>
ffffffffc0200870:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200820 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc0200874:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc0200878:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc020087c:	00005517          	auipc	a0,0x5
ffffffffc0200880:	38450513          	addi	a0,a0,900 # ffffffffc0205c00 <commands+0x138>
           fdt32_to_cpu(x >> 32);
ffffffffc0200884:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200888:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc020088c:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200890:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200894:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200898:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020089c:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008a0:	0187d693          	srli	a3,a5,0x18
ffffffffc02008a4:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02008a8:	0087579b          	srliw	a5,a4,0x8
ffffffffc02008ac:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008b0:	0106561b          	srliw	a2,a2,0x10
ffffffffc02008b4:	010f6f33          	or	t5,t5,a6
ffffffffc02008b8:	0187529b          	srliw	t0,a4,0x18
ffffffffc02008bc:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c0:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008c4:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c8:	0186f6b3          	and	a3,a3,s8
ffffffffc02008cc:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02008d0:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008d4:	0107581b          	srliw	a6,a4,0x10
ffffffffc02008d8:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008dc:	8361                	srli	a4,a4,0x18
ffffffffc02008de:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008e2:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02008e6:	01e6e6b3          	or	a3,a3,t5
ffffffffc02008ea:	00cb7633          	and	a2,s6,a2
ffffffffc02008ee:	0088181b          	slliw	a6,a6,0x8
ffffffffc02008f2:	0085959b          	slliw	a1,a1,0x8
ffffffffc02008f6:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008fa:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008fe:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200902:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200906:	0088989b          	slliw	a7,a7,0x8
ffffffffc020090a:	011b78b3          	and	a7,s6,a7
ffffffffc020090e:	005eeeb3          	or	t4,t4,t0
ffffffffc0200912:	00c6e733          	or	a4,a3,a2
ffffffffc0200916:	006c6c33          	or	s8,s8,t1
ffffffffc020091a:	010b76b3          	and	a3,s6,a6
ffffffffc020091e:	00bb7b33          	and	s6,s6,a1
ffffffffc0200922:	01d7e7b3          	or	a5,a5,t4
ffffffffc0200926:	016c6b33          	or	s6,s8,s6
ffffffffc020092a:	01146433          	or	s0,s0,a7
ffffffffc020092e:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200930:	1702                	slli	a4,a4,0x20
ffffffffc0200932:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200934:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200936:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200938:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020093a:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093e:	0167eb33          	or	s6,a5,s6
ffffffffc0200942:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200944:	855ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc0200948:	85a2                	mv	a1,s0
ffffffffc020094a:	00005517          	auipc	a0,0x5
ffffffffc020094e:	2d650513          	addi	a0,a0,726 # ffffffffc0205c20 <commands+0x158>
ffffffffc0200952:	847ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc0200956:	014b5613          	srli	a2,s6,0x14
ffffffffc020095a:	85da                	mv	a1,s6
ffffffffc020095c:	00005517          	auipc	a0,0x5
ffffffffc0200960:	2dc50513          	addi	a0,a0,732 # ffffffffc0205c38 <commands+0x170>
ffffffffc0200964:	835ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200968:	008b05b3          	add	a1,s6,s0
ffffffffc020096c:	15fd                	addi	a1,a1,-1
ffffffffc020096e:	00005517          	auipc	a0,0x5
ffffffffc0200972:	2ea50513          	addi	a0,a0,746 # ffffffffc0205c58 <commands+0x190>
ffffffffc0200976:	823ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc020097a:	00005517          	auipc	a0,0x5
ffffffffc020097e:	32e50513          	addi	a0,a0,814 # ffffffffc0205ca8 <commands+0x1e0>
        memory_base = mem_base;
ffffffffc0200982:	000c6797          	auipc	a5,0xc6
ffffffffc0200986:	1e87bb23          	sd	s0,502(a5) # ffffffffc02c6b78 <memory_base>
        memory_size = mem_size;
ffffffffc020098a:	000c6797          	auipc	a5,0xc6
ffffffffc020098e:	1f67bb23          	sd	s6,502(a5) # ffffffffc02c6b80 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200992:	b3f5                	j	ffffffffc020077e <dtb_init+0x186>

ffffffffc0200994 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc0200994:	000c6517          	auipc	a0,0xc6
ffffffffc0200998:	1e453503          	ld	a0,484(a0) # ffffffffc02c6b78 <memory_base>
ffffffffc020099c:	8082                	ret

ffffffffc020099e <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc020099e:	000c6517          	auipc	a0,0xc6
ffffffffc02009a2:	1e253503          	ld	a0,482(a0) # ffffffffc02c6b80 <memory_size>
ffffffffc02009a6:	8082                	ret

ffffffffc02009a8 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009a8:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009ac:	8082                	ret

ffffffffc02009ae <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ae:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009b4:	8082                	ret

ffffffffc02009b6 <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009b6:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009ba:	00000797          	auipc	a5,0x0
ffffffffc02009be:	43a78793          	addi	a5,a5,1082 # ffffffffc0200df4 <__alltraps>
ffffffffc02009c2:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009c6:	000407b7          	lui	a5,0x40
ffffffffc02009ca:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009ce:	8082                	ret

ffffffffc02009d0 <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d0:	610c                	ld	a1,0(a0)
{
ffffffffc02009d2:	1141                	addi	sp,sp,-16
ffffffffc02009d4:	e022                	sd	s0,0(sp)
ffffffffc02009d6:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d8:	00005517          	auipc	a0,0x5
ffffffffc02009dc:	2e850513          	addi	a0,a0,744 # ffffffffc0205cc0 <commands+0x1f8>
{
ffffffffc02009e0:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e2:	fb6ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009e6:	640c                	ld	a1,8(s0)
ffffffffc02009e8:	00005517          	auipc	a0,0x5
ffffffffc02009ec:	2f050513          	addi	a0,a0,752 # ffffffffc0205cd8 <commands+0x210>
ffffffffc02009f0:	fa8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009f4:	680c                	ld	a1,16(s0)
ffffffffc02009f6:	00005517          	auipc	a0,0x5
ffffffffc02009fa:	2fa50513          	addi	a0,a0,762 # ffffffffc0205cf0 <commands+0x228>
ffffffffc02009fe:	f9aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a02:	6c0c                	ld	a1,24(s0)
ffffffffc0200a04:	00005517          	auipc	a0,0x5
ffffffffc0200a08:	30450513          	addi	a0,a0,772 # ffffffffc0205d08 <commands+0x240>
ffffffffc0200a0c:	f8cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a10:	700c                	ld	a1,32(s0)
ffffffffc0200a12:	00005517          	auipc	a0,0x5
ffffffffc0200a16:	30e50513          	addi	a0,a0,782 # ffffffffc0205d20 <commands+0x258>
ffffffffc0200a1a:	f7eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a1e:	740c                	ld	a1,40(s0)
ffffffffc0200a20:	00005517          	auipc	a0,0x5
ffffffffc0200a24:	31850513          	addi	a0,a0,792 # ffffffffc0205d38 <commands+0x270>
ffffffffc0200a28:	f70ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a2c:	780c                	ld	a1,48(s0)
ffffffffc0200a2e:	00005517          	auipc	a0,0x5
ffffffffc0200a32:	32250513          	addi	a0,a0,802 # ffffffffc0205d50 <commands+0x288>
ffffffffc0200a36:	f62ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a3a:	7c0c                	ld	a1,56(s0)
ffffffffc0200a3c:	00005517          	auipc	a0,0x5
ffffffffc0200a40:	32c50513          	addi	a0,a0,812 # ffffffffc0205d68 <commands+0x2a0>
ffffffffc0200a44:	f54ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a48:	602c                	ld	a1,64(s0)
ffffffffc0200a4a:	00005517          	auipc	a0,0x5
ffffffffc0200a4e:	33650513          	addi	a0,a0,822 # ffffffffc0205d80 <commands+0x2b8>
ffffffffc0200a52:	f46ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a56:	642c                	ld	a1,72(s0)
ffffffffc0200a58:	00005517          	auipc	a0,0x5
ffffffffc0200a5c:	34050513          	addi	a0,a0,832 # ffffffffc0205d98 <commands+0x2d0>
ffffffffc0200a60:	f38ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a64:	682c                	ld	a1,80(s0)
ffffffffc0200a66:	00005517          	auipc	a0,0x5
ffffffffc0200a6a:	34a50513          	addi	a0,a0,842 # ffffffffc0205db0 <commands+0x2e8>
ffffffffc0200a6e:	f2aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a72:	6c2c                	ld	a1,88(s0)
ffffffffc0200a74:	00005517          	auipc	a0,0x5
ffffffffc0200a78:	35450513          	addi	a0,a0,852 # ffffffffc0205dc8 <commands+0x300>
ffffffffc0200a7c:	f1cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a80:	702c                	ld	a1,96(s0)
ffffffffc0200a82:	00005517          	auipc	a0,0x5
ffffffffc0200a86:	35e50513          	addi	a0,a0,862 # ffffffffc0205de0 <commands+0x318>
ffffffffc0200a8a:	f0eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a8e:	742c                	ld	a1,104(s0)
ffffffffc0200a90:	00005517          	auipc	a0,0x5
ffffffffc0200a94:	36850513          	addi	a0,a0,872 # ffffffffc0205df8 <commands+0x330>
ffffffffc0200a98:	f00ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200a9c:	782c                	ld	a1,112(s0)
ffffffffc0200a9e:	00005517          	auipc	a0,0x5
ffffffffc0200aa2:	37250513          	addi	a0,a0,882 # ffffffffc0205e10 <commands+0x348>
ffffffffc0200aa6:	ef2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200aaa:	7c2c                	ld	a1,120(s0)
ffffffffc0200aac:	00005517          	auipc	a0,0x5
ffffffffc0200ab0:	37c50513          	addi	a0,a0,892 # ffffffffc0205e28 <commands+0x360>
ffffffffc0200ab4:	ee4ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200ab8:	604c                	ld	a1,128(s0)
ffffffffc0200aba:	00005517          	auipc	a0,0x5
ffffffffc0200abe:	38650513          	addi	a0,a0,902 # ffffffffc0205e40 <commands+0x378>
ffffffffc0200ac2:	ed6ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200ac6:	644c                	ld	a1,136(s0)
ffffffffc0200ac8:	00005517          	auipc	a0,0x5
ffffffffc0200acc:	39050513          	addi	a0,a0,912 # ffffffffc0205e58 <commands+0x390>
ffffffffc0200ad0:	ec8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ad4:	684c                	ld	a1,144(s0)
ffffffffc0200ad6:	00005517          	auipc	a0,0x5
ffffffffc0200ada:	39a50513          	addi	a0,a0,922 # ffffffffc0205e70 <commands+0x3a8>
ffffffffc0200ade:	ebaff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200ae2:	6c4c                	ld	a1,152(s0)
ffffffffc0200ae4:	00005517          	auipc	a0,0x5
ffffffffc0200ae8:	3a450513          	addi	a0,a0,932 # ffffffffc0205e88 <commands+0x3c0>
ffffffffc0200aec:	eacff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200af0:	704c                	ld	a1,160(s0)
ffffffffc0200af2:	00005517          	auipc	a0,0x5
ffffffffc0200af6:	3ae50513          	addi	a0,a0,942 # ffffffffc0205ea0 <commands+0x3d8>
ffffffffc0200afa:	e9eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200afe:	744c                	ld	a1,168(s0)
ffffffffc0200b00:	00005517          	auipc	a0,0x5
ffffffffc0200b04:	3b850513          	addi	a0,a0,952 # ffffffffc0205eb8 <commands+0x3f0>
ffffffffc0200b08:	e90ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b0c:	784c                	ld	a1,176(s0)
ffffffffc0200b0e:	00005517          	auipc	a0,0x5
ffffffffc0200b12:	3c250513          	addi	a0,a0,962 # ffffffffc0205ed0 <commands+0x408>
ffffffffc0200b16:	e82ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b1a:	7c4c                	ld	a1,184(s0)
ffffffffc0200b1c:	00005517          	auipc	a0,0x5
ffffffffc0200b20:	3cc50513          	addi	a0,a0,972 # ffffffffc0205ee8 <commands+0x420>
ffffffffc0200b24:	e74ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b28:	606c                	ld	a1,192(s0)
ffffffffc0200b2a:	00005517          	auipc	a0,0x5
ffffffffc0200b2e:	3d650513          	addi	a0,a0,982 # ffffffffc0205f00 <commands+0x438>
ffffffffc0200b32:	e66ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b36:	646c                	ld	a1,200(s0)
ffffffffc0200b38:	00005517          	auipc	a0,0x5
ffffffffc0200b3c:	3e050513          	addi	a0,a0,992 # ffffffffc0205f18 <commands+0x450>
ffffffffc0200b40:	e58ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b44:	686c                	ld	a1,208(s0)
ffffffffc0200b46:	00005517          	auipc	a0,0x5
ffffffffc0200b4a:	3ea50513          	addi	a0,a0,1002 # ffffffffc0205f30 <commands+0x468>
ffffffffc0200b4e:	e4aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b52:	6c6c                	ld	a1,216(s0)
ffffffffc0200b54:	00005517          	auipc	a0,0x5
ffffffffc0200b58:	3f450513          	addi	a0,a0,1012 # ffffffffc0205f48 <commands+0x480>
ffffffffc0200b5c:	e3cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b60:	706c                	ld	a1,224(s0)
ffffffffc0200b62:	00005517          	auipc	a0,0x5
ffffffffc0200b66:	3fe50513          	addi	a0,a0,1022 # ffffffffc0205f60 <commands+0x498>
ffffffffc0200b6a:	e2eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b6e:	746c                	ld	a1,232(s0)
ffffffffc0200b70:	00005517          	auipc	a0,0x5
ffffffffc0200b74:	40850513          	addi	a0,a0,1032 # ffffffffc0205f78 <commands+0x4b0>
ffffffffc0200b78:	e20ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b7c:	786c                	ld	a1,240(s0)
ffffffffc0200b7e:	00005517          	auipc	a0,0x5
ffffffffc0200b82:	41250513          	addi	a0,a0,1042 # ffffffffc0205f90 <commands+0x4c8>
ffffffffc0200b86:	e12ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b8a:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b8c:	6402                	ld	s0,0(sp)
ffffffffc0200b8e:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b90:	00005517          	auipc	a0,0x5
ffffffffc0200b94:	41850513          	addi	a0,a0,1048 # ffffffffc0205fa8 <commands+0x4e0>
}
ffffffffc0200b98:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b9a:	dfeff06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0200b9e <print_trapframe>:
{
ffffffffc0200b9e:	1141                	addi	sp,sp,-16
ffffffffc0200ba0:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba2:	85aa                	mv	a1,a0
{
ffffffffc0200ba4:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba6:	00005517          	auipc	a0,0x5
ffffffffc0200baa:	41a50513          	addi	a0,a0,1050 # ffffffffc0205fc0 <commands+0x4f8>
{
ffffffffc0200bae:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb0:	de8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	e1bff0ef          	jal	ra,ffffffffc02009d0 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bba:	10043583          	ld	a1,256(s0)
ffffffffc0200bbe:	00005517          	auipc	a0,0x5
ffffffffc0200bc2:	41a50513          	addi	a0,a0,1050 # ffffffffc0205fd8 <commands+0x510>
ffffffffc0200bc6:	dd2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bca:	10843583          	ld	a1,264(s0)
ffffffffc0200bce:	00005517          	auipc	a0,0x5
ffffffffc0200bd2:	42250513          	addi	a0,a0,1058 # ffffffffc0205ff0 <commands+0x528>
ffffffffc0200bd6:	dc2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200bda:	11043583          	ld	a1,272(s0)
ffffffffc0200bde:	00005517          	auipc	a0,0x5
ffffffffc0200be2:	42a50513          	addi	a0,a0,1066 # ffffffffc0206008 <commands+0x540>
ffffffffc0200be6:	db2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bea:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bee:	6402                	ld	s0,0(sp)
ffffffffc0200bf0:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf2:	00005517          	auipc	a0,0x5
ffffffffc0200bf6:	42650513          	addi	a0,a0,1062 # ffffffffc0206018 <commands+0x550>
}
ffffffffc0200bfa:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bfc:	d9cff06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0200c00 <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c00:	11853783          	ld	a5,280(a0)
ffffffffc0200c04:	472d                	li	a4,11
ffffffffc0200c06:	0786                	slli	a5,a5,0x1
ffffffffc0200c08:	8385                	srli	a5,a5,0x1
ffffffffc0200c0a:	06f76c63          	bltu	a4,a5,ffffffffc0200c82 <interrupt_handler+0x82>
ffffffffc0200c0e:	00005717          	auipc	a4,0x5
ffffffffc0200c12:	4c270713          	addi	a4,a4,1218 # ffffffffc02060d0 <commands+0x608>
ffffffffc0200c16:	078a                	slli	a5,a5,0x2
ffffffffc0200c18:	97ba                	add	a5,a5,a4
ffffffffc0200c1a:	439c                	lw	a5,0(a5)
ffffffffc0200c1c:	97ba                	add	a5,a5,a4
ffffffffc0200c1e:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c20:	00005517          	auipc	a0,0x5
ffffffffc0200c24:	47050513          	addi	a0,a0,1136 # ffffffffc0206090 <commands+0x5c8>
ffffffffc0200c28:	d70ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c2c:	00005517          	auipc	a0,0x5
ffffffffc0200c30:	44450513          	addi	a0,a0,1092 # ffffffffc0206070 <commands+0x5a8>
ffffffffc0200c34:	d64ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c38:	00005517          	auipc	a0,0x5
ffffffffc0200c3c:	3f850513          	addi	a0,a0,1016 # ffffffffc0206030 <commands+0x568>
ffffffffc0200c40:	d58ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c44:	00005517          	auipc	a0,0x5
ffffffffc0200c48:	40c50513          	addi	a0,a0,1036 # ffffffffc0206050 <commands+0x588>
ffffffffc0200c4c:	d4cff06f          	j	ffffffffc0200198 <cprintf>
{
ffffffffc0200c50:	1141                	addi	sp,sp,-16
ffffffffc0200c52:	e406                	sd	ra,8(sp)
        /*(1)设置下次时钟中断- clock_set_next_event()
        *(2)计数器（ticks）加一
        *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
        *(4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
        */
        clock_set_next_event();
ffffffffc0200c54:	91bff0ef          	jal	ra,ffffffffc020056e <clock_set_next_event>
        ticks++;
ffffffffc0200c58:	000c6717          	auipc	a4,0xc6
ffffffffc0200c5c:	f1870713          	addi	a4,a4,-232 # ffffffffc02c6b70 <ticks>
ffffffffc0200c60:	631c                	ld	a5,0(a4)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c62:	60a2                	ld	ra,8(sp)
        sched_class_proc_tick(current);
ffffffffc0200c64:	000c6517          	auipc	a0,0xc6
ffffffffc0200c68:	f5c53503          	ld	a0,-164(a0) # ffffffffc02c6bc0 <current>
        ticks++;
ffffffffc0200c6c:	0785                	addi	a5,a5,1
ffffffffc0200c6e:	e31c                	sd	a5,0(a4)
}
ffffffffc0200c70:	0141                	addi	sp,sp,16
        sched_class_proc_tick(current);
ffffffffc0200c72:	42c0406f          	j	ffffffffc020509e <sched_class_proc_tick>
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c76:	00005517          	auipc	a0,0x5
ffffffffc0200c7a:	43a50513          	addi	a0,a0,1082 # ffffffffc02060b0 <commands+0x5e8>
ffffffffc0200c7e:	d1aff06f          	j	ffffffffc0200198 <cprintf>
        print_trapframe(tf);
ffffffffc0200c82:	bf31                	j	ffffffffc0200b9e <print_trapframe>

ffffffffc0200c84 <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200c84:	11853783          	ld	a5,280(a0)
{
ffffffffc0200c88:	1141                	addi	sp,sp,-16
ffffffffc0200c8a:	e022                	sd	s0,0(sp)
ffffffffc0200c8c:	e406                	sd	ra,8(sp)
ffffffffc0200c8e:	473d                	li	a4,15
ffffffffc0200c90:	842a                	mv	s0,a0
ffffffffc0200c92:	0af76b63          	bltu	a4,a5,ffffffffc0200d48 <exception_handler+0xc4>
ffffffffc0200c96:	00005717          	auipc	a4,0x5
ffffffffc0200c9a:	5fa70713          	addi	a4,a4,1530 # ffffffffc0206290 <commands+0x7c8>
ffffffffc0200c9e:	078a                	slli	a5,a5,0x2
ffffffffc0200ca0:	97ba                	add	a5,a5,a4
ffffffffc0200ca2:	439c                	lw	a5,0(a5)
ffffffffc0200ca4:	97ba                	add	a5,a5,a4
ffffffffc0200ca6:	8782                	jr	a5
        // cprintf("Environment call from U-mode\n");
        tf->epc += 4;
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200ca8:	00005517          	auipc	a0,0x5
ffffffffc0200cac:	54050513          	addi	a0,a0,1344 # ffffffffc02061e8 <commands+0x720>
ffffffffc0200cb0:	ce8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        tf->epc += 4;
ffffffffc0200cb4:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200cb8:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200cba:	0791                	addi	a5,a5,4
ffffffffc0200cbc:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200cc0:	6402                	ld	s0,0(sp)
ffffffffc0200cc2:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200cc4:	6440406f          	j	ffffffffc0205308 <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200cc8:	00005517          	auipc	a0,0x5
ffffffffc0200ccc:	54050513          	addi	a0,a0,1344 # ffffffffc0206208 <commands+0x740>
}
ffffffffc0200cd0:	6402                	ld	s0,0(sp)
ffffffffc0200cd2:	60a2                	ld	ra,8(sp)
ffffffffc0200cd4:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200cd6:	cc2ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200cda:	00005517          	auipc	a0,0x5
ffffffffc0200cde:	54e50513          	addi	a0,a0,1358 # ffffffffc0206228 <commands+0x760>
ffffffffc0200ce2:	b7fd                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200ce4:	00005517          	auipc	a0,0x5
ffffffffc0200ce8:	56450513          	addi	a0,a0,1380 # ffffffffc0206248 <commands+0x780>
ffffffffc0200cec:	b7d5                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200cee:	00005517          	auipc	a0,0x5
ffffffffc0200cf2:	57250513          	addi	a0,a0,1394 # ffffffffc0206260 <commands+0x798>
ffffffffc0200cf6:	bfe9                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200cf8:	00005517          	auipc	a0,0x5
ffffffffc0200cfc:	58050513          	addi	a0,a0,1408 # ffffffffc0206278 <commands+0x7b0>
ffffffffc0200d00:	bfc1                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d02:	00005517          	auipc	a0,0x5
ffffffffc0200d06:	3fe50513          	addi	a0,a0,1022 # ffffffffc0206100 <commands+0x638>
ffffffffc0200d0a:	b7d9                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d0c:	00005517          	auipc	a0,0x5
ffffffffc0200d10:	41450513          	addi	a0,a0,1044 # ffffffffc0206120 <commands+0x658>
ffffffffc0200d14:	bf75                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d16:	00005517          	auipc	a0,0x5
ffffffffc0200d1a:	42a50513          	addi	a0,a0,1066 # ffffffffc0206140 <commands+0x678>
ffffffffc0200d1e:	bf4d                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d20:	00005517          	auipc	a0,0x5
ffffffffc0200d24:	43850513          	addi	a0,a0,1080 # ffffffffc0206158 <commands+0x690>
ffffffffc0200d28:	b765                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Load address misaligned\n");
ffffffffc0200d2a:	00005517          	auipc	a0,0x5
ffffffffc0200d2e:	43e50513          	addi	a0,a0,1086 # ffffffffc0206168 <commands+0x6a0>
ffffffffc0200d32:	bf79                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200d34:	00005517          	auipc	a0,0x5
ffffffffc0200d38:	45450513          	addi	a0,a0,1108 # ffffffffc0206188 <commands+0x6c0>
ffffffffc0200d3c:	bf51                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200d3e:	00005517          	auipc	a0,0x5
ffffffffc0200d42:	49250513          	addi	a0,a0,1170 # ffffffffc02061d0 <commands+0x708>
ffffffffc0200d46:	b769                	j	ffffffffc0200cd0 <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200d48:	8522                	mv	a0,s0
}
ffffffffc0200d4a:	6402                	ld	s0,0(sp)
ffffffffc0200d4c:	60a2                	ld	ra,8(sp)
ffffffffc0200d4e:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200d50:	b5b9                	j	ffffffffc0200b9e <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200d52:	00005617          	auipc	a2,0x5
ffffffffc0200d56:	44e60613          	addi	a2,a2,1102 # ffffffffc02061a0 <commands+0x6d8>
ffffffffc0200d5a:	0c800593          	li	a1,200
ffffffffc0200d5e:	00005517          	auipc	a0,0x5
ffffffffc0200d62:	45a50513          	addi	a0,a0,1114 # ffffffffc02061b8 <commands+0x6f0>
ffffffffc0200d66:	f2cff0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0200d6a <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200d6a:	1101                	addi	sp,sp,-32
ffffffffc0200d6c:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200d6e:	000c6417          	auipc	s0,0xc6
ffffffffc0200d72:	e5240413          	addi	s0,s0,-430 # ffffffffc02c6bc0 <current>
ffffffffc0200d76:	6018                	ld	a4,0(s0)
{
ffffffffc0200d78:	ec06                	sd	ra,24(sp)
ffffffffc0200d7a:	e426                	sd	s1,8(sp)
ffffffffc0200d7c:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200d7e:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200d82:	cf1d                	beqz	a4,ffffffffc0200dc0 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200d84:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200d88:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200d8c:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200d8e:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200d92:	0206c463          	bltz	a3,ffffffffc0200dba <trap+0x50>
        exception_handler(tf);
ffffffffc0200d96:	eefff0ef          	jal	ra,ffffffffc0200c84 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200d9a:	601c                	ld	a5,0(s0)
ffffffffc0200d9c:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_obj___user_matrix_out_size+0x33990>
        if (!in_kernel)
ffffffffc0200da0:	e499                	bnez	s1,ffffffffc0200dae <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200da2:	0b07a703          	lw	a4,176(a5)
ffffffffc0200da6:	8b05                	andi	a4,a4,1
ffffffffc0200da8:	e329                	bnez	a4,ffffffffc0200dea <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200daa:	6f9c                	ld	a5,24(a5)
ffffffffc0200dac:	eb85                	bnez	a5,ffffffffc0200ddc <trap+0x72>
            {
                schedule();
            }
        }
    }
}
ffffffffc0200dae:	60e2                	ld	ra,24(sp)
ffffffffc0200db0:	6442                	ld	s0,16(sp)
ffffffffc0200db2:	64a2                	ld	s1,8(sp)
ffffffffc0200db4:	6902                	ld	s2,0(sp)
ffffffffc0200db6:	6105                	addi	sp,sp,32
ffffffffc0200db8:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200dba:	e47ff0ef          	jal	ra,ffffffffc0200c00 <interrupt_handler>
ffffffffc0200dbe:	bff1                	j	ffffffffc0200d9a <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200dc0:	0006c863          	bltz	a3,ffffffffc0200dd0 <trap+0x66>
}
ffffffffc0200dc4:	6442                	ld	s0,16(sp)
ffffffffc0200dc6:	60e2                	ld	ra,24(sp)
ffffffffc0200dc8:	64a2                	ld	s1,8(sp)
ffffffffc0200dca:	6902                	ld	s2,0(sp)
ffffffffc0200dcc:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200dce:	bd5d                	j	ffffffffc0200c84 <exception_handler>
}
ffffffffc0200dd0:	6442                	ld	s0,16(sp)
ffffffffc0200dd2:	60e2                	ld	ra,24(sp)
ffffffffc0200dd4:	64a2                	ld	s1,8(sp)
ffffffffc0200dd6:	6902                	ld	s2,0(sp)
ffffffffc0200dd8:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200dda:	b51d                	j	ffffffffc0200c00 <interrupt_handler>
}
ffffffffc0200ddc:	6442                	ld	s0,16(sp)
ffffffffc0200dde:	60e2                	ld	ra,24(sp)
ffffffffc0200de0:	64a2                	ld	s1,8(sp)
ffffffffc0200de2:	6902                	ld	s2,0(sp)
ffffffffc0200de4:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200de6:	3e40406f          	j	ffffffffc02051ca <schedule>
                do_exit(-E_KILLED);
ffffffffc0200dea:	555d                	li	a0,-9
ffffffffc0200dec:	4c0030ef          	jal	ra,ffffffffc02042ac <do_exit>
            if (current->need_resched)
ffffffffc0200df0:	601c                	ld	a5,0(s0)
ffffffffc0200df2:	bf65                	j	ffffffffc0200daa <trap+0x40>

ffffffffc0200df4 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200df4:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200df8:	00011463          	bnez	sp,ffffffffc0200e00 <__alltraps+0xc>
ffffffffc0200dfc:	14002173          	csrr	sp,sscratch
ffffffffc0200e00:	712d                	addi	sp,sp,-288
ffffffffc0200e02:	e002                	sd	zero,0(sp)
ffffffffc0200e04:	e406                	sd	ra,8(sp)
ffffffffc0200e06:	ec0e                	sd	gp,24(sp)
ffffffffc0200e08:	f012                	sd	tp,32(sp)
ffffffffc0200e0a:	f416                	sd	t0,40(sp)
ffffffffc0200e0c:	f81a                	sd	t1,48(sp)
ffffffffc0200e0e:	fc1e                	sd	t2,56(sp)
ffffffffc0200e10:	e0a2                	sd	s0,64(sp)
ffffffffc0200e12:	e4a6                	sd	s1,72(sp)
ffffffffc0200e14:	e8aa                	sd	a0,80(sp)
ffffffffc0200e16:	ecae                	sd	a1,88(sp)
ffffffffc0200e18:	f0b2                	sd	a2,96(sp)
ffffffffc0200e1a:	f4b6                	sd	a3,104(sp)
ffffffffc0200e1c:	f8ba                	sd	a4,112(sp)
ffffffffc0200e1e:	fcbe                	sd	a5,120(sp)
ffffffffc0200e20:	e142                	sd	a6,128(sp)
ffffffffc0200e22:	e546                	sd	a7,136(sp)
ffffffffc0200e24:	e94a                	sd	s2,144(sp)
ffffffffc0200e26:	ed4e                	sd	s3,152(sp)
ffffffffc0200e28:	f152                	sd	s4,160(sp)
ffffffffc0200e2a:	f556                	sd	s5,168(sp)
ffffffffc0200e2c:	f95a                	sd	s6,176(sp)
ffffffffc0200e2e:	fd5e                	sd	s7,184(sp)
ffffffffc0200e30:	e1e2                	sd	s8,192(sp)
ffffffffc0200e32:	e5e6                	sd	s9,200(sp)
ffffffffc0200e34:	e9ea                	sd	s10,208(sp)
ffffffffc0200e36:	edee                	sd	s11,216(sp)
ffffffffc0200e38:	f1f2                	sd	t3,224(sp)
ffffffffc0200e3a:	f5f6                	sd	t4,232(sp)
ffffffffc0200e3c:	f9fa                	sd	t5,240(sp)
ffffffffc0200e3e:	fdfe                	sd	t6,248(sp)
ffffffffc0200e40:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200e44:	100024f3          	csrr	s1,sstatus
ffffffffc0200e48:	14102973          	csrr	s2,sepc
ffffffffc0200e4c:	143029f3          	csrr	s3,stval
ffffffffc0200e50:	14202a73          	csrr	s4,scause
ffffffffc0200e54:	e822                	sd	s0,16(sp)
ffffffffc0200e56:	e226                	sd	s1,256(sp)
ffffffffc0200e58:	e64a                	sd	s2,264(sp)
ffffffffc0200e5a:	ea4e                	sd	s3,272(sp)
ffffffffc0200e5c:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200e5e:	850a                	mv	a0,sp
    jal trap
ffffffffc0200e60:	f0bff0ef          	jal	ra,ffffffffc0200d6a <trap>

ffffffffc0200e64 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200e64:	6492                	ld	s1,256(sp)
ffffffffc0200e66:	6932                	ld	s2,264(sp)
ffffffffc0200e68:	1004f413          	andi	s0,s1,256
ffffffffc0200e6c:	e401                	bnez	s0,ffffffffc0200e74 <__trapret+0x10>
ffffffffc0200e6e:	1200                	addi	s0,sp,288
ffffffffc0200e70:	14041073          	csrw	sscratch,s0
ffffffffc0200e74:	10049073          	csrw	sstatus,s1
ffffffffc0200e78:	14191073          	csrw	sepc,s2
ffffffffc0200e7c:	60a2                	ld	ra,8(sp)
ffffffffc0200e7e:	61e2                	ld	gp,24(sp)
ffffffffc0200e80:	7202                	ld	tp,32(sp)
ffffffffc0200e82:	72a2                	ld	t0,40(sp)
ffffffffc0200e84:	7342                	ld	t1,48(sp)
ffffffffc0200e86:	73e2                	ld	t2,56(sp)
ffffffffc0200e88:	6406                	ld	s0,64(sp)
ffffffffc0200e8a:	64a6                	ld	s1,72(sp)
ffffffffc0200e8c:	6546                	ld	a0,80(sp)
ffffffffc0200e8e:	65e6                	ld	a1,88(sp)
ffffffffc0200e90:	7606                	ld	a2,96(sp)
ffffffffc0200e92:	76a6                	ld	a3,104(sp)
ffffffffc0200e94:	7746                	ld	a4,112(sp)
ffffffffc0200e96:	77e6                	ld	a5,120(sp)
ffffffffc0200e98:	680a                	ld	a6,128(sp)
ffffffffc0200e9a:	68aa                	ld	a7,136(sp)
ffffffffc0200e9c:	694a                	ld	s2,144(sp)
ffffffffc0200e9e:	69ea                	ld	s3,152(sp)
ffffffffc0200ea0:	7a0a                	ld	s4,160(sp)
ffffffffc0200ea2:	7aaa                	ld	s5,168(sp)
ffffffffc0200ea4:	7b4a                	ld	s6,176(sp)
ffffffffc0200ea6:	7bea                	ld	s7,184(sp)
ffffffffc0200ea8:	6c0e                	ld	s8,192(sp)
ffffffffc0200eaa:	6cae                	ld	s9,200(sp)
ffffffffc0200eac:	6d4e                	ld	s10,208(sp)
ffffffffc0200eae:	6dee                	ld	s11,216(sp)
ffffffffc0200eb0:	7e0e                	ld	t3,224(sp)
ffffffffc0200eb2:	7eae                	ld	t4,232(sp)
ffffffffc0200eb4:	7f4e                	ld	t5,240(sp)
ffffffffc0200eb6:	7fee                	ld	t6,248(sp)
ffffffffc0200eb8:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200eba:	10200073          	sret

ffffffffc0200ebe <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200ebe:	812a                	mv	sp,a0
ffffffffc0200ec0:	b755                	j	ffffffffc0200e64 <__trapret>

ffffffffc0200ec2 <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200ec2:	000c2797          	auipc	a5,0xc2
ffffffffc0200ec6:	c4e78793          	addi	a5,a5,-946 # ffffffffc02c2b10 <free_area>
ffffffffc0200eca:	e79c                	sd	a5,8(a5)
ffffffffc0200ecc:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200ece:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200ed2:	8082                	ret

ffffffffc0200ed4 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0200ed4:	000c2517          	auipc	a0,0xc2
ffffffffc0200ed8:	c4c56503          	lwu	a0,-948(a0) # ffffffffc02c2b20 <free_area+0x10>
ffffffffc0200edc:	8082                	ret

ffffffffc0200ede <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc0200ede:	715d                	addi	sp,sp,-80
ffffffffc0200ee0:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200ee2:	000c2417          	auipc	s0,0xc2
ffffffffc0200ee6:	c2e40413          	addi	s0,s0,-978 # ffffffffc02c2b10 <free_area>
ffffffffc0200eea:	641c                	ld	a5,8(s0)
ffffffffc0200eec:	e486                	sd	ra,72(sp)
ffffffffc0200eee:	fc26                	sd	s1,56(sp)
ffffffffc0200ef0:	f84a                	sd	s2,48(sp)
ffffffffc0200ef2:	f44e                	sd	s3,40(sp)
ffffffffc0200ef4:	f052                	sd	s4,32(sp)
ffffffffc0200ef6:	ec56                	sd	s5,24(sp)
ffffffffc0200ef8:	e85a                	sd	s6,16(sp)
ffffffffc0200efa:	e45e                	sd	s7,8(sp)
ffffffffc0200efc:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0200efe:	2a878d63          	beq	a5,s0,ffffffffc02011b8 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0200f02:	4481                	li	s1,0
ffffffffc0200f04:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200f06:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200f0a:	8b09                	andi	a4,a4,2
ffffffffc0200f0c:	2a070a63          	beqz	a4,ffffffffc02011c0 <default_check+0x2e2>
        count++, total += p->property;
ffffffffc0200f10:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200f14:	679c                	ld	a5,8(a5)
ffffffffc0200f16:	2905                	addiw	s2,s2,1
ffffffffc0200f18:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0200f1a:	fe8796e3          	bne	a5,s0,ffffffffc0200f06 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200f1e:	89a6                	mv	s3,s1
ffffffffc0200f20:	6df000ef          	jal	ra,ffffffffc0201dfe <nr_free_pages>
ffffffffc0200f24:	6f351e63          	bne	a0,s3,ffffffffc0201620 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200f28:	4505                	li	a0,1
ffffffffc0200f2a:	657000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0200f2e:	8aaa                	mv	s5,a0
ffffffffc0200f30:	42050863          	beqz	a0,ffffffffc0201360 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200f34:	4505                	li	a0,1
ffffffffc0200f36:	64b000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0200f3a:	89aa                	mv	s3,a0
ffffffffc0200f3c:	70050263          	beqz	a0,ffffffffc0201640 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200f40:	4505                	li	a0,1
ffffffffc0200f42:	63f000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0200f46:	8a2a                	mv	s4,a0
ffffffffc0200f48:	48050c63          	beqz	a0,ffffffffc02013e0 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200f4c:	293a8a63          	beq	s5,s3,ffffffffc02011e0 <default_check+0x302>
ffffffffc0200f50:	28aa8863          	beq	s5,a0,ffffffffc02011e0 <default_check+0x302>
ffffffffc0200f54:	28a98663          	beq	s3,a0,ffffffffc02011e0 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200f58:	000aa783          	lw	a5,0(s5)
ffffffffc0200f5c:	2a079263          	bnez	a5,ffffffffc0201200 <default_check+0x322>
ffffffffc0200f60:	0009a783          	lw	a5,0(s3)
ffffffffc0200f64:	28079e63          	bnez	a5,ffffffffc0201200 <default_check+0x322>
ffffffffc0200f68:	411c                	lw	a5,0(a0)
ffffffffc0200f6a:	28079b63          	bnez	a5,ffffffffc0201200 <default_check+0x322>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc0200f6e:	000c6797          	auipc	a5,0xc6
ffffffffc0200f72:	c3a7b783          	ld	a5,-966(a5) # ffffffffc02c6ba8 <pages>
ffffffffc0200f76:	40fa8733          	sub	a4,s5,a5
ffffffffc0200f7a:	00007617          	auipc	a2,0x7
ffffffffc0200f7e:	1c663603          	ld	a2,454(a2) # ffffffffc0208140 <nbase>
ffffffffc0200f82:	8719                	srai	a4,a4,0x6
ffffffffc0200f84:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200f86:	000c6697          	auipc	a3,0xc6
ffffffffc0200f8a:	c1a6b683          	ld	a3,-998(a3) # ffffffffc02c6ba0 <npage>
ffffffffc0200f8e:	06b2                	slli	a3,a3,0xc
}

static inline uintptr_t
page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
ffffffffc0200f90:	0732                	slli	a4,a4,0xc
ffffffffc0200f92:	28d77763          	bgeu	a4,a3,ffffffffc0201220 <default_check+0x342>
    return page - pages + nbase;
ffffffffc0200f96:	40f98733          	sub	a4,s3,a5
ffffffffc0200f9a:	8719                	srai	a4,a4,0x6
ffffffffc0200f9c:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200f9e:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200fa0:	4cd77063          	bgeu	a4,a3,ffffffffc0201460 <default_check+0x582>
    return page - pages + nbase;
ffffffffc0200fa4:	40f507b3          	sub	a5,a0,a5
ffffffffc0200fa8:	8799                	srai	a5,a5,0x6
ffffffffc0200faa:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200fac:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200fae:	30d7f963          	bgeu	a5,a3,ffffffffc02012c0 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc0200fb2:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200fb4:	00043c03          	ld	s8,0(s0)
ffffffffc0200fb8:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0200fbc:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0200fc0:	e400                	sd	s0,8(s0)
ffffffffc0200fc2:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0200fc4:	000c2797          	auipc	a5,0xc2
ffffffffc0200fc8:	b407ae23          	sw	zero,-1188(a5) # ffffffffc02c2b20 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0200fcc:	5b5000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0200fd0:	2c051863          	bnez	a0,ffffffffc02012a0 <default_check+0x3c2>
    free_page(p0);
ffffffffc0200fd4:	4585                	li	a1,1
ffffffffc0200fd6:	8556                	mv	a0,s5
ffffffffc0200fd8:	5e7000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    free_page(p1);
ffffffffc0200fdc:	4585                	li	a1,1
ffffffffc0200fde:	854e                	mv	a0,s3
ffffffffc0200fe0:	5df000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    free_page(p2);
ffffffffc0200fe4:	4585                	li	a1,1
ffffffffc0200fe6:	8552                	mv	a0,s4
ffffffffc0200fe8:	5d7000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    assert(nr_free == 3);
ffffffffc0200fec:	4818                	lw	a4,16(s0)
ffffffffc0200fee:	478d                	li	a5,3
ffffffffc0200ff0:	28f71863          	bne	a4,a5,ffffffffc0201280 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200ff4:	4505                	li	a0,1
ffffffffc0200ff6:	58b000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0200ffa:	89aa                	mv	s3,a0
ffffffffc0200ffc:	26050263          	beqz	a0,ffffffffc0201260 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201000:	4505                	li	a0,1
ffffffffc0201002:	57f000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201006:	8aaa                	mv	s5,a0
ffffffffc0201008:	3a050c63          	beqz	a0,ffffffffc02013c0 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020100c:	4505                	li	a0,1
ffffffffc020100e:	573000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201012:	8a2a                	mv	s4,a0
ffffffffc0201014:	38050663          	beqz	a0,ffffffffc02013a0 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201018:	4505                	li	a0,1
ffffffffc020101a:	567000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc020101e:	36051163          	bnez	a0,ffffffffc0201380 <default_check+0x4a2>
    free_page(p0);
ffffffffc0201022:	4585                	li	a1,1
ffffffffc0201024:	854e                	mv	a0,s3
ffffffffc0201026:	599000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    assert(!list_empty(&free_list));
ffffffffc020102a:	641c                	ld	a5,8(s0)
ffffffffc020102c:	20878a63          	beq	a5,s0,ffffffffc0201240 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201030:	4505                	li	a0,1
ffffffffc0201032:	54f000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201036:	30a99563          	bne	s3,a0,ffffffffc0201340 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc020103a:	4505                	li	a0,1
ffffffffc020103c:	545000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201040:	2e051063          	bnez	a0,ffffffffc0201320 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201044:	481c                	lw	a5,16(s0)
ffffffffc0201046:	2a079d63          	bnez	a5,ffffffffc0201300 <default_check+0x422>
    free_page(p);
ffffffffc020104a:	854e                	mv	a0,s3
ffffffffc020104c:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc020104e:	01843023          	sd	s8,0(s0)
ffffffffc0201052:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0201056:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc020105a:	565000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    free_page(p1);
ffffffffc020105e:	4585                	li	a1,1
ffffffffc0201060:	8556                	mv	a0,s5
ffffffffc0201062:	55d000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    free_page(p2);
ffffffffc0201066:	4585                	li	a1,1
ffffffffc0201068:	8552                	mv	a0,s4
ffffffffc020106a:	555000ef          	jal	ra,ffffffffc0201dbe <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc020106e:	4515                	li	a0,5
ffffffffc0201070:	511000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201074:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0201076:	26050563          	beqz	a0,ffffffffc02012e0 <default_check+0x402>
ffffffffc020107a:	651c                	ld	a5,8(a0)
ffffffffc020107c:	8385                	srli	a5,a5,0x1
ffffffffc020107e:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc0201080:	54079063          	bnez	a5,ffffffffc02015c0 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0201084:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0201086:	00043b03          	ld	s6,0(s0)
ffffffffc020108a:	00843a83          	ld	s5,8(s0)
ffffffffc020108e:	e000                	sd	s0,0(s0)
ffffffffc0201090:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0201092:	4ef000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201096:	50051563          	bnez	a0,ffffffffc02015a0 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc020109a:	08098a13          	addi	s4,s3,128
ffffffffc020109e:	8552                	mv	a0,s4
ffffffffc02010a0:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02010a2:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02010a6:	000c2797          	auipc	a5,0xc2
ffffffffc02010aa:	a607ad23          	sw	zero,-1414(a5) # ffffffffc02c2b20 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02010ae:	511000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02010b2:	4511                	li	a0,4
ffffffffc02010b4:	4cd000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc02010b8:	4c051463          	bnez	a0,ffffffffc0201580 <default_check+0x6a2>
ffffffffc02010bc:	0889b783          	ld	a5,136(s3)
ffffffffc02010c0:	8385                	srli	a5,a5,0x1
ffffffffc02010c2:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02010c4:	48078e63          	beqz	a5,ffffffffc0201560 <default_check+0x682>
ffffffffc02010c8:	0909a703          	lw	a4,144(s3)
ffffffffc02010cc:	478d                	li	a5,3
ffffffffc02010ce:	48f71963          	bne	a4,a5,ffffffffc0201560 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc02010d2:	450d                	li	a0,3
ffffffffc02010d4:	4ad000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc02010d8:	8c2a                	mv	s8,a0
ffffffffc02010da:	46050363          	beqz	a0,ffffffffc0201540 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc02010de:	4505                	li	a0,1
ffffffffc02010e0:	4a1000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc02010e4:	42051e63          	bnez	a0,ffffffffc0201520 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc02010e8:	418a1c63          	bne	s4,s8,ffffffffc0201500 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc02010ec:	4585                	li	a1,1
ffffffffc02010ee:	854e                	mv	a0,s3
ffffffffc02010f0:	4cf000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    free_pages(p1, 3);
ffffffffc02010f4:	458d                	li	a1,3
ffffffffc02010f6:	8552                	mv	a0,s4
ffffffffc02010f8:	4c7000ef          	jal	ra,ffffffffc0201dbe <free_pages>
ffffffffc02010fc:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201100:	04098c13          	addi	s8,s3,64
ffffffffc0201104:	8385                	srli	a5,a5,0x1
ffffffffc0201106:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201108:	3c078c63          	beqz	a5,ffffffffc02014e0 <default_check+0x602>
ffffffffc020110c:	0109a703          	lw	a4,16(s3)
ffffffffc0201110:	4785                	li	a5,1
ffffffffc0201112:	3cf71763          	bne	a4,a5,ffffffffc02014e0 <default_check+0x602>
ffffffffc0201116:	008a3783          	ld	a5,8(s4)
ffffffffc020111a:	8385                	srli	a5,a5,0x1
ffffffffc020111c:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc020111e:	3a078163          	beqz	a5,ffffffffc02014c0 <default_check+0x5e2>
ffffffffc0201122:	010a2703          	lw	a4,16(s4)
ffffffffc0201126:	478d                	li	a5,3
ffffffffc0201128:	38f71c63          	bne	a4,a5,ffffffffc02014c0 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc020112c:	4505                	li	a0,1
ffffffffc020112e:	453000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201132:	36a99763          	bne	s3,a0,ffffffffc02014a0 <default_check+0x5c2>
    free_page(p0);
ffffffffc0201136:	4585                	li	a1,1
ffffffffc0201138:	487000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc020113c:	4509                	li	a0,2
ffffffffc020113e:	443000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201142:	32aa1f63          	bne	s4,a0,ffffffffc0201480 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0201146:	4589                	li	a1,2
ffffffffc0201148:	477000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    free_page(p2);
ffffffffc020114c:	4585                	li	a1,1
ffffffffc020114e:	8562                	mv	a0,s8
ffffffffc0201150:	46f000ef          	jal	ra,ffffffffc0201dbe <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201154:	4515                	li	a0,5
ffffffffc0201156:	42b000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc020115a:	89aa                	mv	s3,a0
ffffffffc020115c:	48050263          	beqz	a0,ffffffffc02015e0 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201160:	4505                	li	a0,1
ffffffffc0201162:	41f000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0201166:	2c051d63          	bnez	a0,ffffffffc0201440 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc020116a:	481c                	lw	a5,16(s0)
ffffffffc020116c:	2a079a63          	bnez	a5,ffffffffc0201420 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0201170:	4595                	li	a1,5
ffffffffc0201172:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0201174:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0201178:	01643023          	sd	s6,0(s0)
ffffffffc020117c:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0201180:	43f000ef          	jal	ra,ffffffffc0201dbe <free_pages>
    return listelm->next;
ffffffffc0201184:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0201186:	00878963          	beq	a5,s0,ffffffffc0201198 <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc020118a:	ff87a703          	lw	a4,-8(a5)
ffffffffc020118e:	679c                	ld	a5,8(a5)
ffffffffc0201190:	397d                	addiw	s2,s2,-1
ffffffffc0201192:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0201194:	fe879be3          	bne	a5,s0,ffffffffc020118a <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc0201198:	26091463          	bnez	s2,ffffffffc0201400 <default_check+0x522>
    assert(total == 0);
ffffffffc020119c:	46049263          	bnez	s1,ffffffffc0201600 <default_check+0x722>
}
ffffffffc02011a0:	60a6                	ld	ra,72(sp)
ffffffffc02011a2:	6406                	ld	s0,64(sp)
ffffffffc02011a4:	74e2                	ld	s1,56(sp)
ffffffffc02011a6:	7942                	ld	s2,48(sp)
ffffffffc02011a8:	79a2                	ld	s3,40(sp)
ffffffffc02011aa:	7a02                	ld	s4,32(sp)
ffffffffc02011ac:	6ae2                	ld	s5,24(sp)
ffffffffc02011ae:	6b42                	ld	s6,16(sp)
ffffffffc02011b0:	6ba2                	ld	s7,8(sp)
ffffffffc02011b2:	6c02                	ld	s8,0(sp)
ffffffffc02011b4:	6161                	addi	sp,sp,80
ffffffffc02011b6:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc02011b8:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc02011ba:	4481                	li	s1,0
ffffffffc02011bc:	4901                	li	s2,0
ffffffffc02011be:	b38d                	j	ffffffffc0200f20 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc02011c0:	00005697          	auipc	a3,0x5
ffffffffc02011c4:	11068693          	addi	a3,a3,272 # ffffffffc02062d0 <commands+0x808>
ffffffffc02011c8:	00005617          	auipc	a2,0x5
ffffffffc02011cc:	11860613          	addi	a2,a2,280 # ffffffffc02062e0 <commands+0x818>
ffffffffc02011d0:	11000593          	li	a1,272
ffffffffc02011d4:	00005517          	auipc	a0,0x5
ffffffffc02011d8:	12450513          	addi	a0,a0,292 # ffffffffc02062f8 <commands+0x830>
ffffffffc02011dc:	ab6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc02011e0:	00005697          	auipc	a3,0x5
ffffffffc02011e4:	1b068693          	addi	a3,a3,432 # ffffffffc0206390 <commands+0x8c8>
ffffffffc02011e8:	00005617          	auipc	a2,0x5
ffffffffc02011ec:	0f860613          	addi	a2,a2,248 # ffffffffc02062e0 <commands+0x818>
ffffffffc02011f0:	0db00593          	li	a1,219
ffffffffc02011f4:	00005517          	auipc	a0,0x5
ffffffffc02011f8:	10450513          	addi	a0,a0,260 # ffffffffc02062f8 <commands+0x830>
ffffffffc02011fc:	a96ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201200:	00005697          	auipc	a3,0x5
ffffffffc0201204:	1b868693          	addi	a3,a3,440 # ffffffffc02063b8 <commands+0x8f0>
ffffffffc0201208:	00005617          	auipc	a2,0x5
ffffffffc020120c:	0d860613          	addi	a2,a2,216 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201210:	0dc00593          	li	a1,220
ffffffffc0201214:	00005517          	auipc	a0,0x5
ffffffffc0201218:	0e450513          	addi	a0,a0,228 # ffffffffc02062f8 <commands+0x830>
ffffffffc020121c:	a76ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201220:	00005697          	auipc	a3,0x5
ffffffffc0201224:	1d868693          	addi	a3,a3,472 # ffffffffc02063f8 <commands+0x930>
ffffffffc0201228:	00005617          	auipc	a2,0x5
ffffffffc020122c:	0b860613          	addi	a2,a2,184 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201230:	0de00593          	li	a1,222
ffffffffc0201234:	00005517          	auipc	a0,0x5
ffffffffc0201238:	0c450513          	addi	a0,a0,196 # ffffffffc02062f8 <commands+0x830>
ffffffffc020123c:	a56ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201240:	00005697          	auipc	a3,0x5
ffffffffc0201244:	24068693          	addi	a3,a3,576 # ffffffffc0206480 <commands+0x9b8>
ffffffffc0201248:	00005617          	auipc	a2,0x5
ffffffffc020124c:	09860613          	addi	a2,a2,152 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201250:	0f700593          	li	a1,247
ffffffffc0201254:	00005517          	auipc	a0,0x5
ffffffffc0201258:	0a450513          	addi	a0,a0,164 # ffffffffc02062f8 <commands+0x830>
ffffffffc020125c:	a36ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201260:	00005697          	auipc	a3,0x5
ffffffffc0201264:	0d068693          	addi	a3,a3,208 # ffffffffc0206330 <commands+0x868>
ffffffffc0201268:	00005617          	auipc	a2,0x5
ffffffffc020126c:	07860613          	addi	a2,a2,120 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201270:	0f000593          	li	a1,240
ffffffffc0201274:	00005517          	auipc	a0,0x5
ffffffffc0201278:	08450513          	addi	a0,a0,132 # ffffffffc02062f8 <commands+0x830>
ffffffffc020127c:	a16ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 3);
ffffffffc0201280:	00005697          	auipc	a3,0x5
ffffffffc0201284:	1f068693          	addi	a3,a3,496 # ffffffffc0206470 <commands+0x9a8>
ffffffffc0201288:	00005617          	auipc	a2,0x5
ffffffffc020128c:	05860613          	addi	a2,a2,88 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201290:	0ee00593          	li	a1,238
ffffffffc0201294:	00005517          	auipc	a0,0x5
ffffffffc0201298:	06450513          	addi	a0,a0,100 # ffffffffc02062f8 <commands+0x830>
ffffffffc020129c:	9f6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02012a0:	00005697          	auipc	a3,0x5
ffffffffc02012a4:	1b868693          	addi	a3,a3,440 # ffffffffc0206458 <commands+0x990>
ffffffffc02012a8:	00005617          	auipc	a2,0x5
ffffffffc02012ac:	03860613          	addi	a2,a2,56 # ffffffffc02062e0 <commands+0x818>
ffffffffc02012b0:	0e900593          	li	a1,233
ffffffffc02012b4:	00005517          	auipc	a0,0x5
ffffffffc02012b8:	04450513          	addi	a0,a0,68 # ffffffffc02062f8 <commands+0x830>
ffffffffc02012bc:	9d6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02012c0:	00005697          	auipc	a3,0x5
ffffffffc02012c4:	17868693          	addi	a3,a3,376 # ffffffffc0206438 <commands+0x970>
ffffffffc02012c8:	00005617          	auipc	a2,0x5
ffffffffc02012cc:	01860613          	addi	a2,a2,24 # ffffffffc02062e0 <commands+0x818>
ffffffffc02012d0:	0e000593          	li	a1,224
ffffffffc02012d4:	00005517          	auipc	a0,0x5
ffffffffc02012d8:	02450513          	addi	a0,a0,36 # ffffffffc02062f8 <commands+0x830>
ffffffffc02012dc:	9b6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 != NULL);
ffffffffc02012e0:	00005697          	auipc	a3,0x5
ffffffffc02012e4:	1e868693          	addi	a3,a3,488 # ffffffffc02064c8 <commands+0xa00>
ffffffffc02012e8:	00005617          	auipc	a2,0x5
ffffffffc02012ec:	ff860613          	addi	a2,a2,-8 # ffffffffc02062e0 <commands+0x818>
ffffffffc02012f0:	11800593          	li	a1,280
ffffffffc02012f4:	00005517          	auipc	a0,0x5
ffffffffc02012f8:	00450513          	addi	a0,a0,4 # ffffffffc02062f8 <commands+0x830>
ffffffffc02012fc:	996ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 0);
ffffffffc0201300:	00005697          	auipc	a3,0x5
ffffffffc0201304:	1b868693          	addi	a3,a3,440 # ffffffffc02064b8 <commands+0x9f0>
ffffffffc0201308:	00005617          	auipc	a2,0x5
ffffffffc020130c:	fd860613          	addi	a2,a2,-40 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201310:	0fd00593          	li	a1,253
ffffffffc0201314:	00005517          	auipc	a0,0x5
ffffffffc0201318:	fe450513          	addi	a0,a0,-28 # ffffffffc02062f8 <commands+0x830>
ffffffffc020131c:	976ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201320:	00005697          	auipc	a3,0x5
ffffffffc0201324:	13868693          	addi	a3,a3,312 # ffffffffc0206458 <commands+0x990>
ffffffffc0201328:	00005617          	auipc	a2,0x5
ffffffffc020132c:	fb860613          	addi	a2,a2,-72 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201330:	0fb00593          	li	a1,251
ffffffffc0201334:	00005517          	auipc	a0,0x5
ffffffffc0201338:	fc450513          	addi	a0,a0,-60 # ffffffffc02062f8 <commands+0x830>
ffffffffc020133c:	956ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201340:	00005697          	auipc	a3,0x5
ffffffffc0201344:	15868693          	addi	a3,a3,344 # ffffffffc0206498 <commands+0x9d0>
ffffffffc0201348:	00005617          	auipc	a2,0x5
ffffffffc020134c:	f9860613          	addi	a2,a2,-104 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201350:	0fa00593          	li	a1,250
ffffffffc0201354:	00005517          	auipc	a0,0x5
ffffffffc0201358:	fa450513          	addi	a0,a0,-92 # ffffffffc02062f8 <commands+0x830>
ffffffffc020135c:	936ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201360:	00005697          	auipc	a3,0x5
ffffffffc0201364:	fd068693          	addi	a3,a3,-48 # ffffffffc0206330 <commands+0x868>
ffffffffc0201368:	00005617          	auipc	a2,0x5
ffffffffc020136c:	f7860613          	addi	a2,a2,-136 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201370:	0d700593          	li	a1,215
ffffffffc0201374:	00005517          	auipc	a0,0x5
ffffffffc0201378:	f8450513          	addi	a0,a0,-124 # ffffffffc02062f8 <commands+0x830>
ffffffffc020137c:	916ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201380:	00005697          	auipc	a3,0x5
ffffffffc0201384:	0d868693          	addi	a3,a3,216 # ffffffffc0206458 <commands+0x990>
ffffffffc0201388:	00005617          	auipc	a2,0x5
ffffffffc020138c:	f5860613          	addi	a2,a2,-168 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201390:	0f400593          	li	a1,244
ffffffffc0201394:	00005517          	auipc	a0,0x5
ffffffffc0201398:	f6450513          	addi	a0,a0,-156 # ffffffffc02062f8 <commands+0x830>
ffffffffc020139c:	8f6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02013a0:	00005697          	auipc	a3,0x5
ffffffffc02013a4:	fd068693          	addi	a3,a3,-48 # ffffffffc0206370 <commands+0x8a8>
ffffffffc02013a8:	00005617          	auipc	a2,0x5
ffffffffc02013ac:	f3860613          	addi	a2,a2,-200 # ffffffffc02062e0 <commands+0x818>
ffffffffc02013b0:	0f200593          	li	a1,242
ffffffffc02013b4:	00005517          	auipc	a0,0x5
ffffffffc02013b8:	f4450513          	addi	a0,a0,-188 # ffffffffc02062f8 <commands+0x830>
ffffffffc02013bc:	8d6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02013c0:	00005697          	auipc	a3,0x5
ffffffffc02013c4:	f9068693          	addi	a3,a3,-112 # ffffffffc0206350 <commands+0x888>
ffffffffc02013c8:	00005617          	auipc	a2,0x5
ffffffffc02013cc:	f1860613          	addi	a2,a2,-232 # ffffffffc02062e0 <commands+0x818>
ffffffffc02013d0:	0f100593          	li	a1,241
ffffffffc02013d4:	00005517          	auipc	a0,0x5
ffffffffc02013d8:	f2450513          	addi	a0,a0,-220 # ffffffffc02062f8 <commands+0x830>
ffffffffc02013dc:	8b6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02013e0:	00005697          	auipc	a3,0x5
ffffffffc02013e4:	f9068693          	addi	a3,a3,-112 # ffffffffc0206370 <commands+0x8a8>
ffffffffc02013e8:	00005617          	auipc	a2,0x5
ffffffffc02013ec:	ef860613          	addi	a2,a2,-264 # ffffffffc02062e0 <commands+0x818>
ffffffffc02013f0:	0d900593          	li	a1,217
ffffffffc02013f4:	00005517          	auipc	a0,0x5
ffffffffc02013f8:	f0450513          	addi	a0,a0,-252 # ffffffffc02062f8 <commands+0x830>
ffffffffc02013fc:	896ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(count == 0);
ffffffffc0201400:	00005697          	auipc	a3,0x5
ffffffffc0201404:	21868693          	addi	a3,a3,536 # ffffffffc0206618 <commands+0xb50>
ffffffffc0201408:	00005617          	auipc	a2,0x5
ffffffffc020140c:	ed860613          	addi	a2,a2,-296 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201410:	14600593          	li	a1,326
ffffffffc0201414:	00005517          	auipc	a0,0x5
ffffffffc0201418:	ee450513          	addi	a0,a0,-284 # ffffffffc02062f8 <commands+0x830>
ffffffffc020141c:	876ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 0);
ffffffffc0201420:	00005697          	auipc	a3,0x5
ffffffffc0201424:	09868693          	addi	a3,a3,152 # ffffffffc02064b8 <commands+0x9f0>
ffffffffc0201428:	00005617          	auipc	a2,0x5
ffffffffc020142c:	eb860613          	addi	a2,a2,-328 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201430:	13a00593          	li	a1,314
ffffffffc0201434:	00005517          	auipc	a0,0x5
ffffffffc0201438:	ec450513          	addi	a0,a0,-316 # ffffffffc02062f8 <commands+0x830>
ffffffffc020143c:	856ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201440:	00005697          	auipc	a3,0x5
ffffffffc0201444:	01868693          	addi	a3,a3,24 # ffffffffc0206458 <commands+0x990>
ffffffffc0201448:	00005617          	auipc	a2,0x5
ffffffffc020144c:	e9860613          	addi	a2,a2,-360 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201450:	13800593          	li	a1,312
ffffffffc0201454:	00005517          	auipc	a0,0x5
ffffffffc0201458:	ea450513          	addi	a0,a0,-348 # ffffffffc02062f8 <commands+0x830>
ffffffffc020145c:	836ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201460:	00005697          	auipc	a3,0x5
ffffffffc0201464:	fb868693          	addi	a3,a3,-72 # ffffffffc0206418 <commands+0x950>
ffffffffc0201468:	00005617          	auipc	a2,0x5
ffffffffc020146c:	e7860613          	addi	a2,a2,-392 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201470:	0df00593          	li	a1,223
ffffffffc0201474:	00005517          	auipc	a0,0x5
ffffffffc0201478:	e8450513          	addi	a0,a0,-380 # ffffffffc02062f8 <commands+0x830>
ffffffffc020147c:	816ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201480:	00005697          	auipc	a3,0x5
ffffffffc0201484:	15868693          	addi	a3,a3,344 # ffffffffc02065d8 <commands+0xb10>
ffffffffc0201488:	00005617          	auipc	a2,0x5
ffffffffc020148c:	e5860613          	addi	a2,a2,-424 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201490:	13200593          	li	a1,306
ffffffffc0201494:	00005517          	auipc	a0,0x5
ffffffffc0201498:	e6450513          	addi	a0,a0,-412 # ffffffffc02062f8 <commands+0x830>
ffffffffc020149c:	ff7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02014a0:	00005697          	auipc	a3,0x5
ffffffffc02014a4:	11868693          	addi	a3,a3,280 # ffffffffc02065b8 <commands+0xaf0>
ffffffffc02014a8:	00005617          	auipc	a2,0x5
ffffffffc02014ac:	e3860613          	addi	a2,a2,-456 # ffffffffc02062e0 <commands+0x818>
ffffffffc02014b0:	13000593          	li	a1,304
ffffffffc02014b4:	00005517          	auipc	a0,0x5
ffffffffc02014b8:	e4450513          	addi	a0,a0,-444 # ffffffffc02062f8 <commands+0x830>
ffffffffc02014bc:	fd7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02014c0:	00005697          	auipc	a3,0x5
ffffffffc02014c4:	0d068693          	addi	a3,a3,208 # ffffffffc0206590 <commands+0xac8>
ffffffffc02014c8:	00005617          	auipc	a2,0x5
ffffffffc02014cc:	e1860613          	addi	a2,a2,-488 # ffffffffc02062e0 <commands+0x818>
ffffffffc02014d0:	12e00593          	li	a1,302
ffffffffc02014d4:	00005517          	auipc	a0,0x5
ffffffffc02014d8:	e2450513          	addi	a0,a0,-476 # ffffffffc02062f8 <commands+0x830>
ffffffffc02014dc:	fb7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc02014e0:	00005697          	auipc	a3,0x5
ffffffffc02014e4:	08868693          	addi	a3,a3,136 # ffffffffc0206568 <commands+0xaa0>
ffffffffc02014e8:	00005617          	auipc	a2,0x5
ffffffffc02014ec:	df860613          	addi	a2,a2,-520 # ffffffffc02062e0 <commands+0x818>
ffffffffc02014f0:	12d00593          	li	a1,301
ffffffffc02014f4:	00005517          	auipc	a0,0x5
ffffffffc02014f8:	e0450513          	addi	a0,a0,-508 # ffffffffc02062f8 <commands+0x830>
ffffffffc02014fc:	f97fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201500:	00005697          	auipc	a3,0x5
ffffffffc0201504:	05868693          	addi	a3,a3,88 # ffffffffc0206558 <commands+0xa90>
ffffffffc0201508:	00005617          	auipc	a2,0x5
ffffffffc020150c:	dd860613          	addi	a2,a2,-552 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201510:	12800593          	li	a1,296
ffffffffc0201514:	00005517          	auipc	a0,0x5
ffffffffc0201518:	de450513          	addi	a0,a0,-540 # ffffffffc02062f8 <commands+0x830>
ffffffffc020151c:	f77fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201520:	00005697          	auipc	a3,0x5
ffffffffc0201524:	f3868693          	addi	a3,a3,-200 # ffffffffc0206458 <commands+0x990>
ffffffffc0201528:	00005617          	auipc	a2,0x5
ffffffffc020152c:	db860613          	addi	a2,a2,-584 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201530:	12700593          	li	a1,295
ffffffffc0201534:	00005517          	auipc	a0,0x5
ffffffffc0201538:	dc450513          	addi	a0,a0,-572 # ffffffffc02062f8 <commands+0x830>
ffffffffc020153c:	f57fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201540:	00005697          	auipc	a3,0x5
ffffffffc0201544:	ff868693          	addi	a3,a3,-8 # ffffffffc0206538 <commands+0xa70>
ffffffffc0201548:	00005617          	auipc	a2,0x5
ffffffffc020154c:	d9860613          	addi	a2,a2,-616 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201550:	12600593          	li	a1,294
ffffffffc0201554:	00005517          	auipc	a0,0x5
ffffffffc0201558:	da450513          	addi	a0,a0,-604 # ffffffffc02062f8 <commands+0x830>
ffffffffc020155c:	f37fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201560:	00005697          	auipc	a3,0x5
ffffffffc0201564:	fa868693          	addi	a3,a3,-88 # ffffffffc0206508 <commands+0xa40>
ffffffffc0201568:	00005617          	auipc	a2,0x5
ffffffffc020156c:	d7860613          	addi	a2,a2,-648 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201570:	12500593          	li	a1,293
ffffffffc0201574:	00005517          	auipc	a0,0x5
ffffffffc0201578:	d8450513          	addi	a0,a0,-636 # ffffffffc02062f8 <commands+0x830>
ffffffffc020157c:	f17fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0201580:	00005697          	auipc	a3,0x5
ffffffffc0201584:	f7068693          	addi	a3,a3,-144 # ffffffffc02064f0 <commands+0xa28>
ffffffffc0201588:	00005617          	auipc	a2,0x5
ffffffffc020158c:	d5860613          	addi	a2,a2,-680 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201590:	12400593          	li	a1,292
ffffffffc0201594:	00005517          	auipc	a0,0x5
ffffffffc0201598:	d6450513          	addi	a0,a0,-668 # ffffffffc02062f8 <commands+0x830>
ffffffffc020159c:	ef7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02015a0:	00005697          	auipc	a3,0x5
ffffffffc02015a4:	eb868693          	addi	a3,a3,-328 # ffffffffc0206458 <commands+0x990>
ffffffffc02015a8:	00005617          	auipc	a2,0x5
ffffffffc02015ac:	d3860613          	addi	a2,a2,-712 # ffffffffc02062e0 <commands+0x818>
ffffffffc02015b0:	11e00593          	li	a1,286
ffffffffc02015b4:	00005517          	auipc	a0,0x5
ffffffffc02015b8:	d4450513          	addi	a0,a0,-700 # ffffffffc02062f8 <commands+0x830>
ffffffffc02015bc:	ed7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(!PageProperty(p0));
ffffffffc02015c0:	00005697          	auipc	a3,0x5
ffffffffc02015c4:	f1868693          	addi	a3,a3,-232 # ffffffffc02064d8 <commands+0xa10>
ffffffffc02015c8:	00005617          	auipc	a2,0x5
ffffffffc02015cc:	d1860613          	addi	a2,a2,-744 # ffffffffc02062e0 <commands+0x818>
ffffffffc02015d0:	11900593          	li	a1,281
ffffffffc02015d4:	00005517          	auipc	a0,0x5
ffffffffc02015d8:	d2450513          	addi	a0,a0,-732 # ffffffffc02062f8 <commands+0x830>
ffffffffc02015dc:	eb7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc02015e0:	00005697          	auipc	a3,0x5
ffffffffc02015e4:	01868693          	addi	a3,a3,24 # ffffffffc02065f8 <commands+0xb30>
ffffffffc02015e8:	00005617          	auipc	a2,0x5
ffffffffc02015ec:	cf860613          	addi	a2,a2,-776 # ffffffffc02062e0 <commands+0x818>
ffffffffc02015f0:	13700593          	li	a1,311
ffffffffc02015f4:	00005517          	auipc	a0,0x5
ffffffffc02015f8:	d0450513          	addi	a0,a0,-764 # ffffffffc02062f8 <commands+0x830>
ffffffffc02015fc:	e97fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(total == 0);
ffffffffc0201600:	00005697          	auipc	a3,0x5
ffffffffc0201604:	02868693          	addi	a3,a3,40 # ffffffffc0206628 <commands+0xb60>
ffffffffc0201608:	00005617          	auipc	a2,0x5
ffffffffc020160c:	cd860613          	addi	a2,a2,-808 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201610:	14700593          	li	a1,327
ffffffffc0201614:	00005517          	auipc	a0,0x5
ffffffffc0201618:	ce450513          	addi	a0,a0,-796 # ffffffffc02062f8 <commands+0x830>
ffffffffc020161c:	e77fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(total == nr_free_pages());
ffffffffc0201620:	00005697          	auipc	a3,0x5
ffffffffc0201624:	cf068693          	addi	a3,a3,-784 # ffffffffc0206310 <commands+0x848>
ffffffffc0201628:	00005617          	auipc	a2,0x5
ffffffffc020162c:	cb860613          	addi	a2,a2,-840 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201630:	11300593          	li	a1,275
ffffffffc0201634:	00005517          	auipc	a0,0x5
ffffffffc0201638:	cc450513          	addi	a0,a0,-828 # ffffffffc02062f8 <commands+0x830>
ffffffffc020163c:	e57fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201640:	00005697          	auipc	a3,0x5
ffffffffc0201644:	d1068693          	addi	a3,a3,-752 # ffffffffc0206350 <commands+0x888>
ffffffffc0201648:	00005617          	auipc	a2,0x5
ffffffffc020164c:	c9860613          	addi	a2,a2,-872 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201650:	0d800593          	li	a1,216
ffffffffc0201654:	00005517          	auipc	a0,0x5
ffffffffc0201658:	ca450513          	addi	a0,a0,-860 # ffffffffc02062f8 <commands+0x830>
ffffffffc020165c:	e37fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201660 <default_free_pages>:
{
ffffffffc0201660:	1141                	addi	sp,sp,-16
ffffffffc0201662:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201664:	14058463          	beqz	a1,ffffffffc02017ac <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc0201668:	00659693          	slli	a3,a1,0x6
ffffffffc020166c:	96aa                	add	a3,a3,a0
ffffffffc020166e:	87aa                	mv	a5,a0
ffffffffc0201670:	02d50263          	beq	a0,a3,ffffffffc0201694 <default_free_pages+0x34>
ffffffffc0201674:	6798                	ld	a4,8(a5)
ffffffffc0201676:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0201678:	10071a63          	bnez	a4,ffffffffc020178c <default_free_pages+0x12c>
ffffffffc020167c:	6798                	ld	a4,8(a5)
ffffffffc020167e:	8b09                	andi	a4,a4,2
ffffffffc0201680:	10071663          	bnez	a4,ffffffffc020178c <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc0201684:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc0201688:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc020168c:	04078793          	addi	a5,a5,64
ffffffffc0201690:	fed792e3          	bne	a5,a3,ffffffffc0201674 <default_free_pages+0x14>
    base->property = n;
ffffffffc0201694:	2581                	sext.w	a1,a1
ffffffffc0201696:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc0201698:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020169c:	4789                	li	a5,2
ffffffffc020169e:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02016a2:	000c1697          	auipc	a3,0xc1
ffffffffc02016a6:	46e68693          	addi	a3,a3,1134 # ffffffffc02c2b10 <free_area>
ffffffffc02016aa:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02016ac:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02016ae:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02016b2:	9db9                	addw	a1,a1,a4
ffffffffc02016b4:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02016b6:	0ad78463          	beq	a5,a3,ffffffffc020175e <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc02016ba:	fe878713          	addi	a4,a5,-24
ffffffffc02016be:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02016c2:	4581                	li	a1,0
            if (base < page)
ffffffffc02016c4:	00e56a63          	bltu	a0,a4,ffffffffc02016d8 <default_free_pages+0x78>
    return listelm->next;
ffffffffc02016c8:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02016ca:	04d70c63          	beq	a4,a3,ffffffffc0201722 <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc02016ce:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02016d0:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc02016d4:	fee57ae3          	bgeu	a0,a4,ffffffffc02016c8 <default_free_pages+0x68>
ffffffffc02016d8:	c199                	beqz	a1,ffffffffc02016de <default_free_pages+0x7e>
ffffffffc02016da:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02016de:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc02016e0:	e390                	sd	a2,0(a5)
ffffffffc02016e2:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02016e4:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02016e6:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc02016e8:	00d70d63          	beq	a4,a3,ffffffffc0201702 <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc02016ec:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc02016f0:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc02016f4:	02059813          	slli	a6,a1,0x20
ffffffffc02016f8:	01a85793          	srli	a5,a6,0x1a
ffffffffc02016fc:	97b2                	add	a5,a5,a2
ffffffffc02016fe:	02f50c63          	beq	a0,a5,ffffffffc0201736 <default_free_pages+0xd6>
    return listelm->next;
ffffffffc0201702:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc0201704:	00d78c63          	beq	a5,a3,ffffffffc020171c <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc0201708:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc020170a:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc020170e:	02061593          	slli	a1,a2,0x20
ffffffffc0201712:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201716:	972a                	add	a4,a4,a0
ffffffffc0201718:	04e68a63          	beq	a3,a4,ffffffffc020176c <default_free_pages+0x10c>
}
ffffffffc020171c:	60a2                	ld	ra,8(sp)
ffffffffc020171e:	0141                	addi	sp,sp,16
ffffffffc0201720:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201722:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201724:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201726:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201728:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc020172a:	02d70763          	beq	a4,a3,ffffffffc0201758 <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc020172e:	8832                	mv	a6,a2
ffffffffc0201730:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201732:	87ba                	mv	a5,a4
ffffffffc0201734:	bf71                	j	ffffffffc02016d0 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0201736:	491c                	lw	a5,16(a0)
ffffffffc0201738:	9dbd                	addw	a1,a1,a5
ffffffffc020173a:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020173e:	57f5                	li	a5,-3
ffffffffc0201740:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201744:	01853803          	ld	a6,24(a0)
ffffffffc0201748:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc020174a:	8532                	mv	a0,a2
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc020174c:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc0201750:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc0201752:	0105b023          	sd	a6,0(a1)
ffffffffc0201756:	b77d                	j	ffffffffc0201704 <default_free_pages+0xa4>
ffffffffc0201758:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc020175a:	873e                	mv	a4,a5
ffffffffc020175c:	bf41                	j	ffffffffc02016ec <default_free_pages+0x8c>
}
ffffffffc020175e:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201760:	e390                	sd	a2,0(a5)
ffffffffc0201762:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201764:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201766:	ed1c                	sd	a5,24(a0)
ffffffffc0201768:	0141                	addi	sp,sp,16
ffffffffc020176a:	8082                	ret
            base->property += p->property;
ffffffffc020176c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201770:	ff078693          	addi	a3,a5,-16
ffffffffc0201774:	9e39                	addw	a2,a2,a4
ffffffffc0201776:	c910                	sw	a2,16(a0)
ffffffffc0201778:	5775                	li	a4,-3
ffffffffc020177a:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc020177e:	6398                	ld	a4,0(a5)
ffffffffc0201780:	679c                	ld	a5,8(a5)
}
ffffffffc0201782:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc0201784:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0201786:	e398                	sd	a4,0(a5)
ffffffffc0201788:	0141                	addi	sp,sp,16
ffffffffc020178a:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc020178c:	00005697          	auipc	a3,0x5
ffffffffc0201790:	eb468693          	addi	a3,a3,-332 # ffffffffc0206640 <commands+0xb78>
ffffffffc0201794:	00005617          	auipc	a2,0x5
ffffffffc0201798:	b4c60613          	addi	a2,a2,-1204 # ffffffffc02062e0 <commands+0x818>
ffffffffc020179c:	09400593          	li	a1,148
ffffffffc02017a0:	00005517          	auipc	a0,0x5
ffffffffc02017a4:	b5850513          	addi	a0,a0,-1192 # ffffffffc02062f8 <commands+0x830>
ffffffffc02017a8:	cebfe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(n > 0);
ffffffffc02017ac:	00005697          	auipc	a3,0x5
ffffffffc02017b0:	e8c68693          	addi	a3,a3,-372 # ffffffffc0206638 <commands+0xb70>
ffffffffc02017b4:	00005617          	auipc	a2,0x5
ffffffffc02017b8:	b2c60613          	addi	a2,a2,-1236 # ffffffffc02062e0 <commands+0x818>
ffffffffc02017bc:	09000593          	li	a1,144
ffffffffc02017c0:	00005517          	auipc	a0,0x5
ffffffffc02017c4:	b3850513          	addi	a0,a0,-1224 # ffffffffc02062f8 <commands+0x830>
ffffffffc02017c8:	ccbfe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02017cc <default_alloc_pages>:
    assert(n > 0);
ffffffffc02017cc:	c941                	beqz	a0,ffffffffc020185c <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc02017ce:	000c1597          	auipc	a1,0xc1
ffffffffc02017d2:	34258593          	addi	a1,a1,834 # ffffffffc02c2b10 <free_area>
ffffffffc02017d6:	0105a803          	lw	a6,16(a1)
ffffffffc02017da:	872a                	mv	a4,a0
ffffffffc02017dc:	02081793          	slli	a5,a6,0x20
ffffffffc02017e0:	9381                	srli	a5,a5,0x20
ffffffffc02017e2:	00a7ee63          	bltu	a5,a0,ffffffffc02017fe <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc02017e6:	87ae                	mv	a5,a1
ffffffffc02017e8:	a801                	j	ffffffffc02017f8 <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc02017ea:	ff87a683          	lw	a3,-8(a5)
ffffffffc02017ee:	02069613          	slli	a2,a3,0x20
ffffffffc02017f2:	9201                	srli	a2,a2,0x20
ffffffffc02017f4:	00e67763          	bgeu	a2,a4,ffffffffc0201802 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc02017f8:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc02017fa:	feb798e3          	bne	a5,a1,ffffffffc02017ea <default_alloc_pages+0x1e>
        return NULL;
ffffffffc02017fe:	4501                	li	a0,0
}
ffffffffc0201800:	8082                	ret
    return listelm->prev;
ffffffffc0201802:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201806:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020180a:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc020180e:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc0201812:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0201816:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc020181a:	02c77863          	bgeu	a4,a2,ffffffffc020184a <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc020181e:	071a                	slli	a4,a4,0x6
ffffffffc0201820:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0201822:	41c686bb          	subw	a3,a3,t3
ffffffffc0201826:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201828:	00870613          	addi	a2,a4,8
ffffffffc020182c:	4689                	li	a3,2
ffffffffc020182e:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201832:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201836:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc020183a:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc020183e:	e290                	sd	a2,0(a3)
ffffffffc0201840:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0201844:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0201846:	01173c23          	sd	a7,24(a4)
ffffffffc020184a:	41c8083b          	subw	a6,a6,t3
ffffffffc020184e:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201852:	5775                	li	a4,-3
ffffffffc0201854:	17c1                	addi	a5,a5,-16
ffffffffc0201856:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020185a:	8082                	ret
{
ffffffffc020185c:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc020185e:	00005697          	auipc	a3,0x5
ffffffffc0201862:	dda68693          	addi	a3,a3,-550 # ffffffffc0206638 <commands+0xb70>
ffffffffc0201866:	00005617          	auipc	a2,0x5
ffffffffc020186a:	a7a60613          	addi	a2,a2,-1414 # ffffffffc02062e0 <commands+0x818>
ffffffffc020186e:	06c00593          	li	a1,108
ffffffffc0201872:	00005517          	auipc	a0,0x5
ffffffffc0201876:	a8650513          	addi	a0,a0,-1402 # ffffffffc02062f8 <commands+0x830>
{
ffffffffc020187a:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020187c:	c17fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201880 <default_init_memmap>:
{
ffffffffc0201880:	1141                	addi	sp,sp,-16
ffffffffc0201882:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201884:	c5f1                	beqz	a1,ffffffffc0201950 <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc0201886:	00659693          	slli	a3,a1,0x6
ffffffffc020188a:	96aa                	add	a3,a3,a0
ffffffffc020188c:	87aa                	mv	a5,a0
ffffffffc020188e:	00d50f63          	beq	a0,a3,ffffffffc02018ac <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201892:	6798                	ld	a4,8(a5)
ffffffffc0201894:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc0201896:	cf49                	beqz	a4,ffffffffc0201930 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc0201898:	0007a823          	sw	zero,16(a5)
ffffffffc020189c:	0007b423          	sd	zero,8(a5)
ffffffffc02018a0:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02018a4:	04078793          	addi	a5,a5,64
ffffffffc02018a8:	fed795e3          	bne	a5,a3,ffffffffc0201892 <default_init_memmap+0x12>
    base->property = n;
ffffffffc02018ac:	2581                	sext.w	a1,a1
ffffffffc02018ae:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02018b0:	4789                	li	a5,2
ffffffffc02018b2:	00850713          	addi	a4,a0,8
ffffffffc02018b6:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02018ba:	000c1697          	auipc	a3,0xc1
ffffffffc02018be:	25668693          	addi	a3,a3,598 # ffffffffc02c2b10 <free_area>
ffffffffc02018c2:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02018c4:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02018c6:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02018ca:	9db9                	addw	a1,a1,a4
ffffffffc02018cc:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02018ce:	04d78a63          	beq	a5,a3,ffffffffc0201922 <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc02018d2:	fe878713          	addi	a4,a5,-24
ffffffffc02018d6:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02018da:	4581                	li	a1,0
            if (base < page)
ffffffffc02018dc:	00e56a63          	bltu	a0,a4,ffffffffc02018f0 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc02018e0:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02018e2:	02d70263          	beq	a4,a3,ffffffffc0201906 <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc02018e6:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02018e8:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc02018ec:	fee57ae3          	bgeu	a0,a4,ffffffffc02018e0 <default_init_memmap+0x60>
ffffffffc02018f0:	c199                	beqz	a1,ffffffffc02018f6 <default_init_memmap+0x76>
ffffffffc02018f2:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02018f6:	6398                	ld	a4,0(a5)
}
ffffffffc02018f8:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02018fa:	e390                	sd	a2,0(a5)
ffffffffc02018fc:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02018fe:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201900:	ed18                	sd	a4,24(a0)
ffffffffc0201902:	0141                	addi	sp,sp,16
ffffffffc0201904:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201906:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201908:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020190a:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020190c:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc020190e:	00d70663          	beq	a4,a3,ffffffffc020191a <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0201912:	8832                	mv	a6,a2
ffffffffc0201914:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201916:	87ba                	mv	a5,a4
ffffffffc0201918:	bfc1                	j	ffffffffc02018e8 <default_init_memmap+0x68>
}
ffffffffc020191a:	60a2                	ld	ra,8(sp)
ffffffffc020191c:	e290                	sd	a2,0(a3)
ffffffffc020191e:	0141                	addi	sp,sp,16
ffffffffc0201920:	8082                	ret
ffffffffc0201922:	60a2                	ld	ra,8(sp)
ffffffffc0201924:	e390                	sd	a2,0(a5)
ffffffffc0201926:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201928:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020192a:	ed1c                	sd	a5,24(a0)
ffffffffc020192c:	0141                	addi	sp,sp,16
ffffffffc020192e:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201930:	00005697          	auipc	a3,0x5
ffffffffc0201934:	d3868693          	addi	a3,a3,-712 # ffffffffc0206668 <commands+0xba0>
ffffffffc0201938:	00005617          	auipc	a2,0x5
ffffffffc020193c:	9a860613          	addi	a2,a2,-1624 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201940:	04b00593          	li	a1,75
ffffffffc0201944:	00005517          	auipc	a0,0x5
ffffffffc0201948:	9b450513          	addi	a0,a0,-1612 # ffffffffc02062f8 <commands+0x830>
ffffffffc020194c:	b47fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(n > 0);
ffffffffc0201950:	00005697          	auipc	a3,0x5
ffffffffc0201954:	ce868693          	addi	a3,a3,-792 # ffffffffc0206638 <commands+0xb70>
ffffffffc0201958:	00005617          	auipc	a2,0x5
ffffffffc020195c:	98860613          	addi	a2,a2,-1656 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201960:	04700593          	li	a1,71
ffffffffc0201964:	00005517          	auipc	a0,0x5
ffffffffc0201968:	99450513          	addi	a0,a0,-1644 # ffffffffc02062f8 <commands+0x830>
ffffffffc020196c:	b27fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201970 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201970:	c94d                	beqz	a0,ffffffffc0201a22 <slob_free+0xb2>
{
ffffffffc0201972:	1141                	addi	sp,sp,-16
ffffffffc0201974:	e022                	sd	s0,0(sp)
ffffffffc0201976:	e406                	sd	ra,8(sp)
ffffffffc0201978:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc020197a:	e9c1                	bnez	a1,ffffffffc0201a0a <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020197c:	100027f3          	csrr	a5,sstatus
ffffffffc0201980:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201982:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201984:	ebd9                	bnez	a5,ffffffffc0201a1a <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201986:	000c1617          	auipc	a2,0xc1
ffffffffc020198a:	d7a60613          	addi	a2,a2,-646 # ffffffffc02c2700 <slobfree>
ffffffffc020198e:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201990:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201992:	679c                	ld	a5,8(a5)
ffffffffc0201994:	02877a63          	bgeu	a4,s0,ffffffffc02019c8 <slob_free+0x58>
ffffffffc0201998:	00f46463          	bltu	s0,a5,ffffffffc02019a0 <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc020199c:	fef76ae3          	bltu	a4,a5,ffffffffc0201990 <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc02019a0:	400c                	lw	a1,0(s0)
ffffffffc02019a2:	00459693          	slli	a3,a1,0x4
ffffffffc02019a6:	96a2                	add	a3,a3,s0
ffffffffc02019a8:	02d78a63          	beq	a5,a3,ffffffffc02019dc <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc02019ac:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc02019ae:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc02019b0:	00469793          	slli	a5,a3,0x4
ffffffffc02019b4:	97ba                	add	a5,a5,a4
ffffffffc02019b6:	02f40e63          	beq	s0,a5,ffffffffc02019f2 <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc02019ba:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc02019bc:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc02019be:	e129                	bnez	a0,ffffffffc0201a00 <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc02019c0:	60a2                	ld	ra,8(sp)
ffffffffc02019c2:	6402                	ld	s0,0(sp)
ffffffffc02019c4:	0141                	addi	sp,sp,16
ffffffffc02019c6:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc02019c8:	fcf764e3          	bltu	a4,a5,ffffffffc0201990 <slob_free+0x20>
ffffffffc02019cc:	fcf472e3          	bgeu	s0,a5,ffffffffc0201990 <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc02019d0:	400c                	lw	a1,0(s0)
ffffffffc02019d2:	00459693          	slli	a3,a1,0x4
ffffffffc02019d6:	96a2                	add	a3,a3,s0
ffffffffc02019d8:	fcd79ae3          	bne	a5,a3,ffffffffc02019ac <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc02019dc:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc02019de:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc02019e0:	9db5                	addw	a1,a1,a3
ffffffffc02019e2:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc02019e4:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc02019e6:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc02019e8:	00469793          	slli	a5,a3,0x4
ffffffffc02019ec:	97ba                	add	a5,a5,a4
ffffffffc02019ee:	fcf416e3          	bne	s0,a5,ffffffffc02019ba <slob_free+0x4a>
		cur->units += b->units;
ffffffffc02019f2:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc02019f4:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc02019f6:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc02019f8:	9ebd                	addw	a3,a3,a5
ffffffffc02019fa:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc02019fc:	e70c                	sd	a1,8(a4)
ffffffffc02019fe:	d169                	beqz	a0,ffffffffc02019c0 <slob_free+0x50>
}
ffffffffc0201a00:	6402                	ld	s0,0(sp)
ffffffffc0201a02:	60a2                	ld	ra,8(sp)
ffffffffc0201a04:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201a06:	fa3fe06f          	j	ffffffffc02009a8 <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc0201a0a:	25bd                	addiw	a1,a1,15
ffffffffc0201a0c:	8191                	srli	a1,a1,0x4
ffffffffc0201a0e:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a10:	100027f3          	csrr	a5,sstatus
ffffffffc0201a14:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201a16:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a18:	d7bd                	beqz	a5,ffffffffc0201986 <slob_free+0x16>
        intr_disable();
ffffffffc0201a1a:	f95fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0201a1e:	4505                	li	a0,1
ffffffffc0201a20:	b79d                	j	ffffffffc0201986 <slob_free+0x16>
ffffffffc0201a22:	8082                	ret

ffffffffc0201a24 <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a24:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201a26:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a28:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201a2c:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a2e:	352000ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
	if (!page)
ffffffffc0201a32:	c91d                	beqz	a0,ffffffffc0201a68 <__slob_get_free_pages.constprop.0+0x44>
    return page - pages + nbase;
ffffffffc0201a34:	000c5697          	auipc	a3,0xc5
ffffffffc0201a38:	1746b683          	ld	a3,372(a3) # ffffffffc02c6ba8 <pages>
ffffffffc0201a3c:	8d15                	sub	a0,a0,a3
ffffffffc0201a3e:	8519                	srai	a0,a0,0x6
ffffffffc0201a40:	00006697          	auipc	a3,0x6
ffffffffc0201a44:	7006b683          	ld	a3,1792(a3) # ffffffffc0208140 <nbase>
ffffffffc0201a48:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201a4a:	00c51793          	slli	a5,a0,0xc
ffffffffc0201a4e:	83b1                	srli	a5,a5,0xc
ffffffffc0201a50:	000c5717          	auipc	a4,0xc5
ffffffffc0201a54:	15073703          	ld	a4,336(a4) # ffffffffc02c6ba0 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201a58:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201a5a:	00e7fa63          	bgeu	a5,a4,ffffffffc0201a6e <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201a5e:	000c5697          	auipc	a3,0xc5
ffffffffc0201a62:	15a6b683          	ld	a3,346(a3) # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc0201a66:	9536                	add	a0,a0,a3
}
ffffffffc0201a68:	60a2                	ld	ra,8(sp)
ffffffffc0201a6a:	0141                	addi	sp,sp,16
ffffffffc0201a6c:	8082                	ret
ffffffffc0201a6e:	86aa                	mv	a3,a0
ffffffffc0201a70:	00005617          	auipc	a2,0x5
ffffffffc0201a74:	c5860613          	addi	a2,a2,-936 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0201a78:	07100593          	li	a1,113
ffffffffc0201a7c:	00005517          	auipc	a0,0x5
ffffffffc0201a80:	c7450513          	addi	a0,a0,-908 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0201a84:	a0ffe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201a88 <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201a88:	1101                	addi	sp,sp,-32
ffffffffc0201a8a:	ec06                	sd	ra,24(sp)
ffffffffc0201a8c:	e822                	sd	s0,16(sp)
ffffffffc0201a8e:	e426                	sd	s1,8(sp)
ffffffffc0201a90:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201a92:	01050713          	addi	a4,a0,16
ffffffffc0201a96:	6785                	lui	a5,0x1
ffffffffc0201a98:	0cf77363          	bgeu	a4,a5,ffffffffc0201b5e <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201a9c:	00f50493          	addi	s1,a0,15
ffffffffc0201aa0:	8091                	srli	s1,s1,0x4
ffffffffc0201aa2:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201aa4:	10002673          	csrr	a2,sstatus
ffffffffc0201aa8:	8a09                	andi	a2,a2,2
ffffffffc0201aaa:	e25d                	bnez	a2,ffffffffc0201b50 <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201aac:	000c1917          	auipc	s2,0xc1
ffffffffc0201ab0:	c5490913          	addi	s2,s2,-940 # ffffffffc02c2700 <slobfree>
ffffffffc0201ab4:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201ab8:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201aba:	4398                	lw	a4,0(a5)
ffffffffc0201abc:	08975e63          	bge	a4,s1,ffffffffc0201b58 <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc0201ac0:	00f68b63          	beq	a3,a5,ffffffffc0201ad6 <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201ac4:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201ac6:	4018                	lw	a4,0(s0)
ffffffffc0201ac8:	02975a63          	bge	a4,s1,ffffffffc0201afc <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201acc:	00093683          	ld	a3,0(s2)
ffffffffc0201ad0:	87a2                	mv	a5,s0
ffffffffc0201ad2:	fef699e3          	bne	a3,a5,ffffffffc0201ac4 <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201ad6:	ee31                	bnez	a2,ffffffffc0201b32 <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201ad8:	4501                	li	a0,0
ffffffffc0201ada:	f4bff0ef          	jal	ra,ffffffffc0201a24 <__slob_get_free_pages.constprop.0>
ffffffffc0201ade:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201ae0:	cd05                	beqz	a0,ffffffffc0201b18 <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201ae2:	6585                	lui	a1,0x1
ffffffffc0201ae4:	e8dff0ef          	jal	ra,ffffffffc0201970 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201ae8:	10002673          	csrr	a2,sstatus
ffffffffc0201aec:	8a09                	andi	a2,a2,2
ffffffffc0201aee:	ee05                	bnez	a2,ffffffffc0201b26 <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201af0:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201af4:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201af6:	4018                	lw	a4,0(s0)
ffffffffc0201af8:	fc974ae3          	blt	a4,s1,ffffffffc0201acc <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc0201afc:	04e48763          	beq	s1,a4,ffffffffc0201b4a <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201b00:	00449693          	slli	a3,s1,0x4
ffffffffc0201b04:	96a2                	add	a3,a3,s0
ffffffffc0201b06:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201b08:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201b0a:	9f05                	subw	a4,a4,s1
ffffffffc0201b0c:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0201b0e:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0201b10:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0201b12:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc0201b16:	e20d                	bnez	a2,ffffffffc0201b38 <slob_alloc.constprop.0+0xb0>
}
ffffffffc0201b18:	60e2                	ld	ra,24(sp)
ffffffffc0201b1a:	8522                	mv	a0,s0
ffffffffc0201b1c:	6442                	ld	s0,16(sp)
ffffffffc0201b1e:	64a2                	ld	s1,8(sp)
ffffffffc0201b20:	6902                	ld	s2,0(sp)
ffffffffc0201b22:	6105                	addi	sp,sp,32
ffffffffc0201b24:	8082                	ret
        intr_disable();
ffffffffc0201b26:	e89fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
			cur = slobfree;
ffffffffc0201b2a:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0201b2e:	4605                	li	a2,1
ffffffffc0201b30:	b7d1                	j	ffffffffc0201af4 <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc0201b32:	e77fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201b36:	b74d                	j	ffffffffc0201ad8 <slob_alloc.constprop.0+0x50>
ffffffffc0201b38:	e71fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
}
ffffffffc0201b3c:	60e2                	ld	ra,24(sp)
ffffffffc0201b3e:	8522                	mv	a0,s0
ffffffffc0201b40:	6442                	ld	s0,16(sp)
ffffffffc0201b42:	64a2                	ld	s1,8(sp)
ffffffffc0201b44:	6902                	ld	s2,0(sp)
ffffffffc0201b46:	6105                	addi	sp,sp,32
ffffffffc0201b48:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201b4a:	6418                	ld	a4,8(s0)
ffffffffc0201b4c:	e798                	sd	a4,8(a5)
ffffffffc0201b4e:	b7d1                	j	ffffffffc0201b12 <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc0201b50:	e5ffe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0201b54:	4605                	li	a2,1
ffffffffc0201b56:	bf99                	j	ffffffffc0201aac <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201b58:	843e                	mv	s0,a5
ffffffffc0201b5a:	87b6                	mv	a5,a3
ffffffffc0201b5c:	b745                	j	ffffffffc0201afc <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201b5e:	00005697          	auipc	a3,0x5
ffffffffc0201b62:	ba268693          	addi	a3,a3,-1118 # ffffffffc0206700 <default_pmm_manager+0x70>
ffffffffc0201b66:	00004617          	auipc	a2,0x4
ffffffffc0201b6a:	77a60613          	addi	a2,a2,1914 # ffffffffc02062e0 <commands+0x818>
ffffffffc0201b6e:	06300593          	li	a1,99
ffffffffc0201b72:	00005517          	auipc	a0,0x5
ffffffffc0201b76:	bae50513          	addi	a0,a0,-1106 # ffffffffc0206720 <default_pmm_manager+0x90>
ffffffffc0201b7a:	919fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201b7e <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc0201b7e:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc0201b80:	00005517          	auipc	a0,0x5
ffffffffc0201b84:	bb850513          	addi	a0,a0,-1096 # ffffffffc0206738 <default_pmm_manager+0xa8>
{
ffffffffc0201b88:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201b8a:	e0efe0ef          	jal	ra,ffffffffc0200198 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201b8e:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201b90:	00005517          	auipc	a0,0x5
ffffffffc0201b94:	bc050513          	addi	a0,a0,-1088 # ffffffffc0206750 <default_pmm_manager+0xc0>
}
ffffffffc0201b98:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201b9a:	dfefe06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0201b9e <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc0201b9e:	4501                	li	a0,0
ffffffffc0201ba0:	8082                	ret

ffffffffc0201ba2 <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201ba2:	1101                	addi	sp,sp,-32
ffffffffc0201ba4:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201ba6:	6905                	lui	s2,0x1
{
ffffffffc0201ba8:	e822                	sd	s0,16(sp)
ffffffffc0201baa:	ec06                	sd	ra,24(sp)
ffffffffc0201bac:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bae:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8f49>
{
ffffffffc0201bb2:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bb4:	04a7f963          	bgeu	a5,a0,ffffffffc0201c06 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201bb8:	4561                	li	a0,24
ffffffffc0201bba:	ecfff0ef          	jal	ra,ffffffffc0201a88 <slob_alloc.constprop.0>
ffffffffc0201bbe:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201bc0:	c929                	beqz	a0,ffffffffc0201c12 <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201bc2:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201bc6:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201bc8:	00f95763          	bge	s2,a5,ffffffffc0201bd6 <kmalloc+0x34>
ffffffffc0201bcc:	6705                	lui	a4,0x1
ffffffffc0201bce:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201bd0:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc0201bd2:	fef74ee3          	blt	a4,a5,ffffffffc0201bce <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201bd6:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201bd8:	e4dff0ef          	jal	ra,ffffffffc0201a24 <__slob_get_free_pages.constprop.0>
ffffffffc0201bdc:	e488                	sd	a0,8(s1)
ffffffffc0201bde:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc0201be0:	c525                	beqz	a0,ffffffffc0201c48 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201be2:	100027f3          	csrr	a5,sstatus
ffffffffc0201be6:	8b89                	andi	a5,a5,2
ffffffffc0201be8:	ef8d                	bnez	a5,ffffffffc0201c22 <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201bea:	000c5797          	auipc	a5,0xc5
ffffffffc0201bee:	f9e78793          	addi	a5,a5,-98 # ffffffffc02c6b88 <bigblocks>
ffffffffc0201bf2:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201bf4:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201bf6:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc0201bf8:	60e2                	ld	ra,24(sp)
ffffffffc0201bfa:	8522                	mv	a0,s0
ffffffffc0201bfc:	6442                	ld	s0,16(sp)
ffffffffc0201bfe:	64a2                	ld	s1,8(sp)
ffffffffc0201c00:	6902                	ld	s2,0(sp)
ffffffffc0201c02:	6105                	addi	sp,sp,32
ffffffffc0201c04:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0201c06:	0541                	addi	a0,a0,16
ffffffffc0201c08:	e81ff0ef          	jal	ra,ffffffffc0201a88 <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201c0c:	01050413          	addi	s0,a0,16
ffffffffc0201c10:	f565                	bnez	a0,ffffffffc0201bf8 <kmalloc+0x56>
ffffffffc0201c12:	4401                	li	s0,0
}
ffffffffc0201c14:	60e2                	ld	ra,24(sp)
ffffffffc0201c16:	8522                	mv	a0,s0
ffffffffc0201c18:	6442                	ld	s0,16(sp)
ffffffffc0201c1a:	64a2                	ld	s1,8(sp)
ffffffffc0201c1c:	6902                	ld	s2,0(sp)
ffffffffc0201c1e:	6105                	addi	sp,sp,32
ffffffffc0201c20:	8082                	ret
        intr_disable();
ffffffffc0201c22:	d8dfe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
		bb->next = bigblocks;
ffffffffc0201c26:	000c5797          	auipc	a5,0xc5
ffffffffc0201c2a:	f6278793          	addi	a5,a5,-158 # ffffffffc02c6b88 <bigblocks>
ffffffffc0201c2e:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201c30:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201c32:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0201c34:	d75fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
		return bb->pages;
ffffffffc0201c38:	6480                	ld	s0,8(s1)
}
ffffffffc0201c3a:	60e2                	ld	ra,24(sp)
ffffffffc0201c3c:	64a2                	ld	s1,8(sp)
ffffffffc0201c3e:	8522                	mv	a0,s0
ffffffffc0201c40:	6442                	ld	s0,16(sp)
ffffffffc0201c42:	6902                	ld	s2,0(sp)
ffffffffc0201c44:	6105                	addi	sp,sp,32
ffffffffc0201c46:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201c48:	45e1                	li	a1,24
ffffffffc0201c4a:	8526                	mv	a0,s1
ffffffffc0201c4c:	d25ff0ef          	jal	ra,ffffffffc0201970 <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201c50:	b765                	j	ffffffffc0201bf8 <kmalloc+0x56>

ffffffffc0201c52 <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201c52:	c169                	beqz	a0,ffffffffc0201d14 <kfree+0xc2>
{
ffffffffc0201c54:	1101                	addi	sp,sp,-32
ffffffffc0201c56:	e822                	sd	s0,16(sp)
ffffffffc0201c58:	ec06                	sd	ra,24(sp)
ffffffffc0201c5a:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201c5c:	03451793          	slli	a5,a0,0x34
ffffffffc0201c60:	842a                	mv	s0,a0
ffffffffc0201c62:	e3d9                	bnez	a5,ffffffffc0201ce8 <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201c64:	100027f3          	csrr	a5,sstatus
ffffffffc0201c68:	8b89                	andi	a5,a5,2
ffffffffc0201c6a:	e7d9                	bnez	a5,ffffffffc0201cf8 <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201c6c:	000c5797          	auipc	a5,0xc5
ffffffffc0201c70:	f1c7b783          	ld	a5,-228(a5) # ffffffffc02c6b88 <bigblocks>
    return 0;
ffffffffc0201c74:	4601                	li	a2,0
ffffffffc0201c76:	cbad                	beqz	a5,ffffffffc0201ce8 <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201c78:	000c5697          	auipc	a3,0xc5
ffffffffc0201c7c:	f1068693          	addi	a3,a3,-240 # ffffffffc02c6b88 <bigblocks>
ffffffffc0201c80:	a021                	j	ffffffffc0201c88 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201c82:	01048693          	addi	a3,s1,16
ffffffffc0201c86:	c3a5                	beqz	a5,ffffffffc0201ce6 <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201c88:	6798                	ld	a4,8(a5)
ffffffffc0201c8a:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201c8c:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201c8e:	fe871ae3          	bne	a4,s0,ffffffffc0201c82 <kfree+0x30>
				*last = bb->next;
ffffffffc0201c92:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201c94:	ee2d                	bnez	a2,ffffffffc0201d0e <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0201c96:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201c9a:	4098                	lw	a4,0(s1)
ffffffffc0201c9c:	08f46963          	bltu	s0,a5,ffffffffc0201d2e <kfree+0xdc>
ffffffffc0201ca0:	000c5697          	auipc	a3,0xc5
ffffffffc0201ca4:	f186b683          	ld	a3,-232(a3) # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc0201ca8:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201caa:	8031                	srli	s0,s0,0xc
ffffffffc0201cac:	000c5797          	auipc	a5,0xc5
ffffffffc0201cb0:	ef47b783          	ld	a5,-268(a5) # ffffffffc02c6ba0 <npage>
ffffffffc0201cb4:	06f47163          	bgeu	s0,a5,ffffffffc0201d16 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201cb8:	00006517          	auipc	a0,0x6
ffffffffc0201cbc:	48853503          	ld	a0,1160(a0) # ffffffffc0208140 <nbase>
ffffffffc0201cc0:	8c09                	sub	s0,s0,a0
ffffffffc0201cc2:	041a                	slli	s0,s0,0x6
	free_pages(kva2page(kva), 1 << order);
ffffffffc0201cc4:	000c5517          	auipc	a0,0xc5
ffffffffc0201cc8:	ee453503          	ld	a0,-284(a0) # ffffffffc02c6ba8 <pages>
ffffffffc0201ccc:	4585                	li	a1,1
ffffffffc0201cce:	9522                	add	a0,a0,s0
ffffffffc0201cd0:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201cd4:	0ea000ef          	jal	ra,ffffffffc0201dbe <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201cd8:	6442                	ld	s0,16(sp)
ffffffffc0201cda:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201cdc:	8526                	mv	a0,s1
}
ffffffffc0201cde:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201ce0:	45e1                	li	a1,24
}
ffffffffc0201ce2:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201ce4:	b171                	j	ffffffffc0201970 <slob_free>
ffffffffc0201ce6:	e20d                	bnez	a2,ffffffffc0201d08 <kfree+0xb6>
ffffffffc0201ce8:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201cec:	6442                	ld	s0,16(sp)
ffffffffc0201cee:	60e2                	ld	ra,24(sp)
ffffffffc0201cf0:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201cf2:	4581                	li	a1,0
}
ffffffffc0201cf4:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201cf6:	b9ad                	j	ffffffffc0201970 <slob_free>
        intr_disable();
ffffffffc0201cf8:	cb7fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201cfc:	000c5797          	auipc	a5,0xc5
ffffffffc0201d00:	e8c7b783          	ld	a5,-372(a5) # ffffffffc02c6b88 <bigblocks>
        return 1;
ffffffffc0201d04:	4605                	li	a2,1
ffffffffc0201d06:	fbad                	bnez	a5,ffffffffc0201c78 <kfree+0x26>
        intr_enable();
ffffffffc0201d08:	ca1fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201d0c:	bff1                	j	ffffffffc0201ce8 <kfree+0x96>
ffffffffc0201d0e:	c9bfe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201d12:	b751                	j	ffffffffc0201c96 <kfree+0x44>
ffffffffc0201d14:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201d16:	00005617          	auipc	a2,0x5
ffffffffc0201d1a:	a8260613          	addi	a2,a2,-1406 # ffffffffc0206798 <default_pmm_manager+0x108>
ffffffffc0201d1e:	06900593          	li	a1,105
ffffffffc0201d22:	00005517          	auipc	a0,0x5
ffffffffc0201d26:	9ce50513          	addi	a0,a0,-1586 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0201d2a:	f68fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201d2e:	86a2                	mv	a3,s0
ffffffffc0201d30:	00005617          	auipc	a2,0x5
ffffffffc0201d34:	a4060613          	addi	a2,a2,-1472 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc0201d38:	07700593          	li	a1,119
ffffffffc0201d3c:	00005517          	auipc	a0,0x5
ffffffffc0201d40:	9b450513          	addi	a0,a0,-1612 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0201d44:	f4efe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201d48 <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc0201d48:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0201d4a:	00005617          	auipc	a2,0x5
ffffffffc0201d4e:	a4e60613          	addi	a2,a2,-1458 # ffffffffc0206798 <default_pmm_manager+0x108>
ffffffffc0201d52:	06900593          	li	a1,105
ffffffffc0201d56:	00005517          	auipc	a0,0x5
ffffffffc0201d5a:	99a50513          	addi	a0,a0,-1638 # ffffffffc02066f0 <default_pmm_manager+0x60>
pa2page(uintptr_t pa)
ffffffffc0201d5e:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0201d60:	f32fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201d64 <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc0201d64:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc0201d66:	00005617          	auipc	a2,0x5
ffffffffc0201d6a:	a5260613          	addi	a2,a2,-1454 # ffffffffc02067b8 <default_pmm_manager+0x128>
ffffffffc0201d6e:	07f00593          	li	a1,127
ffffffffc0201d72:	00005517          	auipc	a0,0x5
ffffffffc0201d76:	97e50513          	addi	a0,a0,-1666 # ffffffffc02066f0 <default_pmm_manager+0x60>
pte2page(pte_t pte)
ffffffffc0201d7a:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc0201d7c:	f16fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201d80 <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201d80:	100027f3          	csrr	a5,sstatus
ffffffffc0201d84:	8b89                	andi	a5,a5,2
ffffffffc0201d86:	e799                	bnez	a5,ffffffffc0201d94 <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc0201d88:	000c5797          	auipc	a5,0xc5
ffffffffc0201d8c:	e287b783          	ld	a5,-472(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201d90:	6f9c                	ld	a5,24(a5)
ffffffffc0201d92:	8782                	jr	a5
{
ffffffffc0201d94:	1141                	addi	sp,sp,-16
ffffffffc0201d96:	e406                	sd	ra,8(sp)
ffffffffc0201d98:	e022                	sd	s0,0(sp)
ffffffffc0201d9a:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201d9c:	c13fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201da0:	000c5797          	auipc	a5,0xc5
ffffffffc0201da4:	e107b783          	ld	a5,-496(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201da8:	6f9c                	ld	a5,24(a5)
ffffffffc0201daa:	8522                	mv	a0,s0
ffffffffc0201dac:	9782                	jalr	a5
ffffffffc0201dae:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201db0:	bf9fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc0201db4:	60a2                	ld	ra,8(sp)
ffffffffc0201db6:	8522                	mv	a0,s0
ffffffffc0201db8:	6402                	ld	s0,0(sp)
ffffffffc0201dba:	0141                	addi	sp,sp,16
ffffffffc0201dbc:	8082                	ret

ffffffffc0201dbe <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201dbe:	100027f3          	csrr	a5,sstatus
ffffffffc0201dc2:	8b89                	andi	a5,a5,2
ffffffffc0201dc4:	e799                	bnez	a5,ffffffffc0201dd2 <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201dc6:	000c5797          	auipc	a5,0xc5
ffffffffc0201dca:	dea7b783          	ld	a5,-534(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201dce:	739c                	ld	a5,32(a5)
ffffffffc0201dd0:	8782                	jr	a5
{
ffffffffc0201dd2:	1101                	addi	sp,sp,-32
ffffffffc0201dd4:	ec06                	sd	ra,24(sp)
ffffffffc0201dd6:	e822                	sd	s0,16(sp)
ffffffffc0201dd8:	e426                	sd	s1,8(sp)
ffffffffc0201dda:	842a                	mv	s0,a0
ffffffffc0201ddc:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0201dde:	bd1fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201de2:	000c5797          	auipc	a5,0xc5
ffffffffc0201de6:	dce7b783          	ld	a5,-562(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201dea:	739c                	ld	a5,32(a5)
ffffffffc0201dec:	85a6                	mv	a1,s1
ffffffffc0201dee:	8522                	mv	a0,s0
ffffffffc0201df0:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201df2:	6442                	ld	s0,16(sp)
ffffffffc0201df4:	60e2                	ld	ra,24(sp)
ffffffffc0201df6:	64a2                	ld	s1,8(sp)
ffffffffc0201df8:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201dfa:	baffe06f          	j	ffffffffc02009a8 <intr_enable>

ffffffffc0201dfe <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201dfe:	100027f3          	csrr	a5,sstatus
ffffffffc0201e02:	8b89                	andi	a5,a5,2
ffffffffc0201e04:	e799                	bnez	a5,ffffffffc0201e12 <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201e06:	000c5797          	auipc	a5,0xc5
ffffffffc0201e0a:	daa7b783          	ld	a5,-598(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201e0e:	779c                	ld	a5,40(a5)
ffffffffc0201e10:	8782                	jr	a5
{
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	e406                	sd	ra,8(sp)
ffffffffc0201e16:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201e18:	b97fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201e1c:	000c5797          	auipc	a5,0xc5
ffffffffc0201e20:	d947b783          	ld	a5,-620(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201e24:	779c                	ld	a5,40(a5)
ffffffffc0201e26:	9782                	jalr	a5
ffffffffc0201e28:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201e2a:	b7ffe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201e2e:	60a2                	ld	ra,8(sp)
ffffffffc0201e30:	8522                	mv	a0,s0
ffffffffc0201e32:	6402                	ld	s0,0(sp)
ffffffffc0201e34:	0141                	addi	sp,sp,16
ffffffffc0201e36:	8082                	ret

ffffffffc0201e38 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e38:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0201e3c:	1ff7f793          	andi	a5,a5,511
{
ffffffffc0201e40:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e42:	078e                	slli	a5,a5,0x3
{
ffffffffc0201e44:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e46:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc0201e4a:	6094                	ld	a3,0(s1)
{
ffffffffc0201e4c:	f04a                	sd	s2,32(sp)
ffffffffc0201e4e:	ec4e                	sd	s3,24(sp)
ffffffffc0201e50:	e852                	sd	s4,16(sp)
ffffffffc0201e52:	fc06                	sd	ra,56(sp)
ffffffffc0201e54:	f822                	sd	s0,48(sp)
ffffffffc0201e56:	e456                	sd	s5,8(sp)
ffffffffc0201e58:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc0201e5a:	0016f793          	andi	a5,a3,1
{
ffffffffc0201e5e:	892e                	mv	s2,a1
ffffffffc0201e60:	8a32                	mv	s4,a2
ffffffffc0201e62:	000c5997          	auipc	s3,0xc5
ffffffffc0201e66:	d3e98993          	addi	s3,s3,-706 # ffffffffc02c6ba0 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc0201e6a:	efbd                	bnez	a5,ffffffffc0201ee8 <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201e6c:	14060c63          	beqz	a2,ffffffffc0201fc4 <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201e70:	100027f3          	csrr	a5,sstatus
ffffffffc0201e74:	8b89                	andi	a5,a5,2
ffffffffc0201e76:	14079963          	bnez	a5,ffffffffc0201fc8 <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201e7a:	000c5797          	auipc	a5,0xc5
ffffffffc0201e7e:	d367b783          	ld	a5,-714(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201e82:	6f9c                	ld	a5,24(a5)
ffffffffc0201e84:	4505                	li	a0,1
ffffffffc0201e86:	9782                	jalr	a5
ffffffffc0201e88:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201e8a:	12040d63          	beqz	s0,ffffffffc0201fc4 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201e8e:	000c5b17          	auipc	s6,0xc5
ffffffffc0201e92:	d1ab0b13          	addi	s6,s6,-742 # ffffffffc02c6ba8 <pages>
ffffffffc0201e96:	000b3503          	ld	a0,0(s6)
ffffffffc0201e9a:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201e9e:	000c5997          	auipc	s3,0xc5
ffffffffc0201ea2:	d0298993          	addi	s3,s3,-766 # ffffffffc02c6ba0 <npage>
ffffffffc0201ea6:	40a40533          	sub	a0,s0,a0
ffffffffc0201eaa:	8519                	srai	a0,a0,0x6
ffffffffc0201eac:	9556                	add	a0,a0,s5
ffffffffc0201eae:	0009b703          	ld	a4,0(s3)
ffffffffc0201eb2:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201eb6:	4685                	li	a3,1
ffffffffc0201eb8:	c014                	sw	a3,0(s0)
ffffffffc0201eba:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201ebc:	0532                	slli	a0,a0,0xc
ffffffffc0201ebe:	16e7f763          	bgeu	a5,a4,ffffffffc020202c <get_pte+0x1f4>
ffffffffc0201ec2:	000c5797          	auipc	a5,0xc5
ffffffffc0201ec6:	cf67b783          	ld	a5,-778(a5) # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc0201eca:	6605                	lui	a2,0x1
ffffffffc0201ecc:	4581                	li	a1,0
ffffffffc0201ece:	953e                	add	a0,a0,a5
ffffffffc0201ed0:	161030ef          	jal	ra,ffffffffc0205830 <memset>
    return page - pages + nbase;
ffffffffc0201ed4:	000b3683          	ld	a3,0(s6)
ffffffffc0201ed8:	40d406b3          	sub	a3,s0,a3
ffffffffc0201edc:	8699                	srai	a3,a3,0x6
ffffffffc0201ede:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201ee0:	06aa                	slli	a3,a3,0xa
ffffffffc0201ee2:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201ee6:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201ee8:	77fd                	lui	a5,0xfffff
ffffffffc0201eea:	068a                	slli	a3,a3,0x2
ffffffffc0201eec:	0009b703          	ld	a4,0(s3)
ffffffffc0201ef0:	8efd                	and	a3,a3,a5
ffffffffc0201ef2:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201ef6:	10e7ff63          	bgeu	a5,a4,ffffffffc0202014 <get_pte+0x1dc>
ffffffffc0201efa:	000c5a97          	auipc	s5,0xc5
ffffffffc0201efe:	cbea8a93          	addi	s5,s5,-834 # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc0201f02:	000ab403          	ld	s0,0(s5)
ffffffffc0201f06:	01595793          	srli	a5,s2,0x15
ffffffffc0201f0a:	1ff7f793          	andi	a5,a5,511
ffffffffc0201f0e:	96a2                	add	a3,a3,s0
ffffffffc0201f10:	00379413          	slli	s0,a5,0x3
ffffffffc0201f14:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc0201f16:	6014                	ld	a3,0(s0)
ffffffffc0201f18:	0016f793          	andi	a5,a3,1
ffffffffc0201f1c:	ebad                	bnez	a5,ffffffffc0201f8e <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f1e:	0a0a0363          	beqz	s4,ffffffffc0201fc4 <get_pte+0x18c>
ffffffffc0201f22:	100027f3          	csrr	a5,sstatus
ffffffffc0201f26:	8b89                	andi	a5,a5,2
ffffffffc0201f28:	efcd                	bnez	a5,ffffffffc0201fe2 <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201f2a:	000c5797          	auipc	a5,0xc5
ffffffffc0201f2e:	c867b783          	ld	a5,-890(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201f32:	6f9c                	ld	a5,24(a5)
ffffffffc0201f34:	4505                	li	a0,1
ffffffffc0201f36:	9782                	jalr	a5
ffffffffc0201f38:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f3a:	c4c9                	beqz	s1,ffffffffc0201fc4 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201f3c:	000c5b17          	auipc	s6,0xc5
ffffffffc0201f40:	c6cb0b13          	addi	s6,s6,-916 # ffffffffc02c6ba8 <pages>
ffffffffc0201f44:	000b3503          	ld	a0,0(s6)
ffffffffc0201f48:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201f4c:	0009b703          	ld	a4,0(s3)
ffffffffc0201f50:	40a48533          	sub	a0,s1,a0
ffffffffc0201f54:	8519                	srai	a0,a0,0x6
ffffffffc0201f56:	9552                	add	a0,a0,s4
ffffffffc0201f58:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201f5c:	4685                	li	a3,1
ffffffffc0201f5e:	c094                	sw	a3,0(s1)
ffffffffc0201f60:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201f62:	0532                	slli	a0,a0,0xc
ffffffffc0201f64:	0ee7f163          	bgeu	a5,a4,ffffffffc0202046 <get_pte+0x20e>
ffffffffc0201f68:	000ab783          	ld	a5,0(s5)
ffffffffc0201f6c:	6605                	lui	a2,0x1
ffffffffc0201f6e:	4581                	li	a1,0
ffffffffc0201f70:	953e                	add	a0,a0,a5
ffffffffc0201f72:	0bf030ef          	jal	ra,ffffffffc0205830 <memset>
    return page - pages + nbase;
ffffffffc0201f76:	000b3683          	ld	a3,0(s6)
ffffffffc0201f7a:	40d486b3          	sub	a3,s1,a3
ffffffffc0201f7e:	8699                	srai	a3,a3,0x6
ffffffffc0201f80:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201f82:	06aa                	slli	a3,a3,0xa
ffffffffc0201f84:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201f88:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0201f8a:	0009b703          	ld	a4,0(s3)
ffffffffc0201f8e:	068a                	slli	a3,a3,0x2
ffffffffc0201f90:	757d                	lui	a0,0xfffff
ffffffffc0201f92:	8ee9                	and	a3,a3,a0
ffffffffc0201f94:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201f98:	06e7f263          	bgeu	a5,a4,ffffffffc0201ffc <get_pte+0x1c4>
ffffffffc0201f9c:	000ab503          	ld	a0,0(s5)
ffffffffc0201fa0:	00c95913          	srli	s2,s2,0xc
ffffffffc0201fa4:	1ff97913          	andi	s2,s2,511
ffffffffc0201fa8:	96aa                	add	a3,a3,a0
ffffffffc0201faa:	00391513          	slli	a0,s2,0x3
ffffffffc0201fae:	9536                	add	a0,a0,a3
}
ffffffffc0201fb0:	70e2                	ld	ra,56(sp)
ffffffffc0201fb2:	7442                	ld	s0,48(sp)
ffffffffc0201fb4:	74a2                	ld	s1,40(sp)
ffffffffc0201fb6:	7902                	ld	s2,32(sp)
ffffffffc0201fb8:	69e2                	ld	s3,24(sp)
ffffffffc0201fba:	6a42                	ld	s4,16(sp)
ffffffffc0201fbc:	6aa2                	ld	s5,8(sp)
ffffffffc0201fbe:	6b02                	ld	s6,0(sp)
ffffffffc0201fc0:	6121                	addi	sp,sp,64
ffffffffc0201fc2:	8082                	ret
            return NULL;
ffffffffc0201fc4:	4501                	li	a0,0
ffffffffc0201fc6:	b7ed                	j	ffffffffc0201fb0 <get_pte+0x178>
        intr_disable();
ffffffffc0201fc8:	9e7fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201fcc:	000c5797          	auipc	a5,0xc5
ffffffffc0201fd0:	be47b783          	ld	a5,-1052(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201fd4:	6f9c                	ld	a5,24(a5)
ffffffffc0201fd6:	4505                	li	a0,1
ffffffffc0201fd8:	9782                	jalr	a5
ffffffffc0201fda:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201fdc:	9cdfe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201fe0:	b56d                	j	ffffffffc0201e8a <get_pte+0x52>
        intr_disable();
ffffffffc0201fe2:	9cdfe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0201fe6:	000c5797          	auipc	a5,0xc5
ffffffffc0201fea:	bca7b783          	ld	a5,-1078(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0201fee:	6f9c                	ld	a5,24(a5)
ffffffffc0201ff0:	4505                	li	a0,1
ffffffffc0201ff2:	9782                	jalr	a5
ffffffffc0201ff4:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc0201ff6:	9b3fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201ffa:	b781                	j	ffffffffc0201f3a <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0201ffc:	00004617          	auipc	a2,0x4
ffffffffc0202000:	6cc60613          	addi	a2,a2,1740 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0202004:	0fa00593          	li	a1,250
ffffffffc0202008:	00004517          	auipc	a0,0x4
ffffffffc020200c:	7d850513          	addi	a0,a0,2008 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202010:	c82fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202014:	00004617          	auipc	a2,0x4
ffffffffc0202018:	6b460613          	addi	a2,a2,1716 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc020201c:	0ed00593          	li	a1,237
ffffffffc0202020:	00004517          	auipc	a0,0x4
ffffffffc0202024:	7c050513          	addi	a0,a0,1984 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202028:	c6afe0ef          	jal	ra,ffffffffc0200492 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020202c:	86aa                	mv	a3,a0
ffffffffc020202e:	00004617          	auipc	a2,0x4
ffffffffc0202032:	69a60613          	addi	a2,a2,1690 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0202036:	0e900593          	li	a1,233
ffffffffc020203a:	00004517          	auipc	a0,0x4
ffffffffc020203e:	7a650513          	addi	a0,a0,1958 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202042:	c50fe0ef          	jal	ra,ffffffffc0200492 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202046:	86aa                	mv	a3,a0
ffffffffc0202048:	00004617          	auipc	a2,0x4
ffffffffc020204c:	68060613          	addi	a2,a2,1664 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0202050:	0f700593          	li	a1,247
ffffffffc0202054:	00004517          	auipc	a0,0x4
ffffffffc0202058:	78c50513          	addi	a0,a0,1932 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020205c:	c36fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0202060 <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc0202060:	1141                	addi	sp,sp,-16
ffffffffc0202062:	e022                	sd	s0,0(sp)
ffffffffc0202064:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202066:	4601                	li	a2,0
{
ffffffffc0202068:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc020206a:	dcfff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
    if (ptep_store != NULL)
ffffffffc020206e:	c011                	beqz	s0,ffffffffc0202072 <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc0202070:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc0202072:	c511                	beqz	a0,ffffffffc020207e <get_page+0x1e>
ffffffffc0202074:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc0202076:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc0202078:	0017f713          	andi	a4,a5,1
ffffffffc020207c:	e709                	bnez	a4,ffffffffc0202086 <get_page+0x26>
}
ffffffffc020207e:	60a2                	ld	ra,8(sp)
ffffffffc0202080:	6402                	ld	s0,0(sp)
ffffffffc0202082:	0141                	addi	sp,sp,16
ffffffffc0202084:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0202086:	078a                	slli	a5,a5,0x2
ffffffffc0202088:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020208a:	000c5717          	auipc	a4,0xc5
ffffffffc020208e:	b1673703          	ld	a4,-1258(a4) # ffffffffc02c6ba0 <npage>
ffffffffc0202092:	00e7ff63          	bgeu	a5,a4,ffffffffc02020b0 <get_page+0x50>
ffffffffc0202096:	60a2                	ld	ra,8(sp)
ffffffffc0202098:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc020209a:	fff80537          	lui	a0,0xfff80
ffffffffc020209e:	97aa                	add	a5,a5,a0
ffffffffc02020a0:	079a                	slli	a5,a5,0x6
ffffffffc02020a2:	000c5517          	auipc	a0,0xc5
ffffffffc02020a6:	b0653503          	ld	a0,-1274(a0) # ffffffffc02c6ba8 <pages>
ffffffffc02020aa:	953e                	add	a0,a0,a5
ffffffffc02020ac:	0141                	addi	sp,sp,16
ffffffffc02020ae:	8082                	ret
ffffffffc02020b0:	c99ff0ef          	jal	ra,ffffffffc0201d48 <pa2page.part.0>

ffffffffc02020b4 <unmap_range>:
        tlb_invalidate(pgdir, la); //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc02020b4:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02020b6:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc02020ba:	f486                	sd	ra,104(sp)
ffffffffc02020bc:	f0a2                	sd	s0,96(sp)
ffffffffc02020be:	eca6                	sd	s1,88(sp)
ffffffffc02020c0:	e8ca                	sd	s2,80(sp)
ffffffffc02020c2:	e4ce                	sd	s3,72(sp)
ffffffffc02020c4:	e0d2                	sd	s4,64(sp)
ffffffffc02020c6:	fc56                	sd	s5,56(sp)
ffffffffc02020c8:	f85a                	sd	s6,48(sp)
ffffffffc02020ca:	f45e                	sd	s7,40(sp)
ffffffffc02020cc:	f062                	sd	s8,32(sp)
ffffffffc02020ce:	ec66                	sd	s9,24(sp)
ffffffffc02020d0:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02020d2:	17d2                	slli	a5,a5,0x34
ffffffffc02020d4:	e3ed                	bnez	a5,ffffffffc02021b6 <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc02020d6:	002007b7          	lui	a5,0x200
ffffffffc02020da:	842e                	mv	s0,a1
ffffffffc02020dc:	0ef5ed63          	bltu	a1,a5,ffffffffc02021d6 <unmap_range+0x122>
ffffffffc02020e0:	8932                	mv	s2,a2
ffffffffc02020e2:	0ec5fa63          	bgeu	a1,a2,ffffffffc02021d6 <unmap_range+0x122>
ffffffffc02020e6:	4785                	li	a5,1
ffffffffc02020e8:	07fe                	slli	a5,a5,0x1f
ffffffffc02020ea:	0ec7e663          	bltu	a5,a2,ffffffffc02021d6 <unmap_range+0x122>
ffffffffc02020ee:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc02020f0:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc02020f2:	000c5c97          	auipc	s9,0xc5
ffffffffc02020f6:	aaec8c93          	addi	s9,s9,-1362 # ffffffffc02c6ba0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02020fa:	000c5c17          	auipc	s8,0xc5
ffffffffc02020fe:	aaec0c13          	addi	s8,s8,-1362 # ffffffffc02c6ba8 <pages>
ffffffffc0202102:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc0202106:	000c5d17          	auipc	s10,0xc5
ffffffffc020210a:	aaad0d13          	addi	s10,s10,-1366 # ffffffffc02c6bb0 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc020210e:	00200b37          	lui	s6,0x200
ffffffffc0202112:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc0202116:	4601                	li	a2,0
ffffffffc0202118:	85a2                	mv	a1,s0
ffffffffc020211a:	854e                	mv	a0,s3
ffffffffc020211c:	d1dff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
ffffffffc0202120:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc0202122:	cd29                	beqz	a0,ffffffffc020217c <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc0202124:	611c                	ld	a5,0(a0)
ffffffffc0202126:	e395                	bnez	a5,ffffffffc020214a <unmap_range+0x96>
        start += PGSIZE;
ffffffffc0202128:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020212a:	ff2466e3          	bltu	s0,s2,ffffffffc0202116 <unmap_range+0x62>
}
ffffffffc020212e:	70a6                	ld	ra,104(sp)
ffffffffc0202130:	7406                	ld	s0,96(sp)
ffffffffc0202132:	64e6                	ld	s1,88(sp)
ffffffffc0202134:	6946                	ld	s2,80(sp)
ffffffffc0202136:	69a6                	ld	s3,72(sp)
ffffffffc0202138:	6a06                	ld	s4,64(sp)
ffffffffc020213a:	7ae2                	ld	s5,56(sp)
ffffffffc020213c:	7b42                	ld	s6,48(sp)
ffffffffc020213e:	7ba2                	ld	s7,40(sp)
ffffffffc0202140:	7c02                	ld	s8,32(sp)
ffffffffc0202142:	6ce2                	ld	s9,24(sp)
ffffffffc0202144:	6d42                	ld	s10,16(sp)
ffffffffc0202146:	6165                	addi	sp,sp,112
ffffffffc0202148:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc020214a:	0017f713          	andi	a4,a5,1
ffffffffc020214e:	df69                	beqz	a4,ffffffffc0202128 <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc0202150:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202154:	078a                	slli	a5,a5,0x2
ffffffffc0202156:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202158:	08e7ff63          	bgeu	a5,a4,ffffffffc02021f6 <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc020215c:	000c3503          	ld	a0,0(s8)
ffffffffc0202160:	97de                	add	a5,a5,s7
ffffffffc0202162:	079a                	slli	a5,a5,0x6
ffffffffc0202164:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202166:	411c                	lw	a5,0(a0)
ffffffffc0202168:	fff7871b          	addiw	a4,a5,-1
ffffffffc020216c:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc020216e:	cf11                	beqz	a4,ffffffffc020218a <unmap_range+0xd6>
        *ptep = 0;                 //(5) clear second page table entry
ffffffffc0202170:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202174:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc0202178:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020217a:	bf45                	j	ffffffffc020212a <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc020217c:	945a                	add	s0,s0,s6
ffffffffc020217e:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc0202182:	d455                	beqz	s0,ffffffffc020212e <unmap_range+0x7a>
ffffffffc0202184:	f92469e3          	bltu	s0,s2,ffffffffc0202116 <unmap_range+0x62>
ffffffffc0202188:	b75d                	j	ffffffffc020212e <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020218a:	100027f3          	csrr	a5,sstatus
ffffffffc020218e:	8b89                	andi	a5,a5,2
ffffffffc0202190:	e799                	bnez	a5,ffffffffc020219e <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc0202192:	000d3783          	ld	a5,0(s10)
ffffffffc0202196:	4585                	li	a1,1
ffffffffc0202198:	739c                	ld	a5,32(a5)
ffffffffc020219a:	9782                	jalr	a5
    if (flag)
ffffffffc020219c:	bfd1                	j	ffffffffc0202170 <unmap_range+0xbc>
ffffffffc020219e:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02021a0:	80ffe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02021a4:	000d3783          	ld	a5,0(s10)
ffffffffc02021a8:	6522                	ld	a0,8(sp)
ffffffffc02021aa:	4585                	li	a1,1
ffffffffc02021ac:	739c                	ld	a5,32(a5)
ffffffffc02021ae:	9782                	jalr	a5
        intr_enable();
ffffffffc02021b0:	ff8fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02021b4:	bf75                	j	ffffffffc0202170 <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021b6:	00004697          	auipc	a3,0x4
ffffffffc02021ba:	63a68693          	addi	a3,a3,1594 # ffffffffc02067f0 <default_pmm_manager+0x160>
ffffffffc02021be:	00004617          	auipc	a2,0x4
ffffffffc02021c2:	12260613          	addi	a2,a2,290 # ffffffffc02062e0 <commands+0x818>
ffffffffc02021c6:	12200593          	li	a1,290
ffffffffc02021ca:	00004517          	auipc	a0,0x4
ffffffffc02021ce:	61650513          	addi	a0,a0,1558 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02021d2:	ac0fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02021d6:	00004697          	auipc	a3,0x4
ffffffffc02021da:	64a68693          	addi	a3,a3,1610 # ffffffffc0206820 <default_pmm_manager+0x190>
ffffffffc02021de:	00004617          	auipc	a2,0x4
ffffffffc02021e2:	10260613          	addi	a2,a2,258 # ffffffffc02062e0 <commands+0x818>
ffffffffc02021e6:	12300593          	li	a1,291
ffffffffc02021ea:	00004517          	auipc	a0,0x4
ffffffffc02021ee:	5f650513          	addi	a0,a0,1526 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02021f2:	aa0fe0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc02021f6:	b53ff0ef          	jal	ra,ffffffffc0201d48 <pa2page.part.0>

ffffffffc02021fa <exit_range>:
{
ffffffffc02021fa:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021fc:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202200:	fc86                	sd	ra,120(sp)
ffffffffc0202202:	f8a2                	sd	s0,112(sp)
ffffffffc0202204:	f4a6                	sd	s1,104(sp)
ffffffffc0202206:	f0ca                	sd	s2,96(sp)
ffffffffc0202208:	ecce                	sd	s3,88(sp)
ffffffffc020220a:	e8d2                	sd	s4,80(sp)
ffffffffc020220c:	e4d6                	sd	s5,72(sp)
ffffffffc020220e:	e0da                	sd	s6,64(sp)
ffffffffc0202210:	fc5e                	sd	s7,56(sp)
ffffffffc0202212:	f862                	sd	s8,48(sp)
ffffffffc0202214:	f466                	sd	s9,40(sp)
ffffffffc0202216:	f06a                	sd	s10,32(sp)
ffffffffc0202218:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020221a:	17d2                	slli	a5,a5,0x34
ffffffffc020221c:	20079a63          	bnez	a5,ffffffffc0202430 <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc0202220:	002007b7          	lui	a5,0x200
ffffffffc0202224:	24f5e463          	bltu	a1,a5,ffffffffc020246c <exit_range+0x272>
ffffffffc0202228:	8ab2                	mv	s5,a2
ffffffffc020222a:	24c5f163          	bgeu	a1,a2,ffffffffc020246c <exit_range+0x272>
ffffffffc020222e:	4785                	li	a5,1
ffffffffc0202230:	07fe                	slli	a5,a5,0x1f
ffffffffc0202232:	22c7ed63          	bltu	a5,a2,ffffffffc020246c <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc0202236:	c00009b7          	lui	s3,0xc0000
ffffffffc020223a:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc020223e:	ffe00937          	lui	s2,0xffe00
ffffffffc0202242:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc0202246:	5cfd                	li	s9,-1
ffffffffc0202248:	8c2a                	mv	s8,a0
ffffffffc020224a:	0125f933          	and	s2,a1,s2
ffffffffc020224e:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc0202250:	000c5d17          	auipc	s10,0xc5
ffffffffc0202254:	950d0d13          	addi	s10,s10,-1712 # ffffffffc02c6ba0 <npage>
    return KADDR(page2pa(page));
ffffffffc0202258:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc020225c:	000c5717          	auipc	a4,0xc5
ffffffffc0202260:	94c70713          	addi	a4,a4,-1716 # ffffffffc02c6ba8 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc0202264:	000c5d97          	auipc	s11,0xc5
ffffffffc0202268:	94cd8d93          	addi	s11,s11,-1716 # ffffffffc02c6bb0 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc020226c:	c0000437          	lui	s0,0xc0000
ffffffffc0202270:	944e                	add	s0,s0,s3
ffffffffc0202272:	8079                	srli	s0,s0,0x1e
ffffffffc0202274:	1ff47413          	andi	s0,s0,511
ffffffffc0202278:	040e                	slli	s0,s0,0x3
ffffffffc020227a:	9462                	add	s0,s0,s8
ffffffffc020227c:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_matrix_out_size+0xffffffffbfff38f0>
        if (pde1 & PTE_V)
ffffffffc0202280:	001a7793          	andi	a5,s4,1
ffffffffc0202284:	eb99                	bnez	a5,ffffffffc020229a <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc0202286:	12098463          	beqz	s3,ffffffffc02023ae <exit_range+0x1b4>
ffffffffc020228a:	400007b7          	lui	a5,0x40000
ffffffffc020228e:	97ce                	add	a5,a5,s3
ffffffffc0202290:	894e                	mv	s2,s3
ffffffffc0202292:	1159fe63          	bgeu	s3,s5,ffffffffc02023ae <exit_range+0x1b4>
ffffffffc0202296:	89be                	mv	s3,a5
ffffffffc0202298:	bfd1                	j	ffffffffc020226c <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc020229a:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc020229e:	0a0a                	slli	s4,s4,0x2
ffffffffc02022a0:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc02022a4:	1cfa7263          	bgeu	s4,a5,ffffffffc0202468 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02022a8:	fff80637          	lui	a2,0xfff80
ffffffffc02022ac:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc02022ae:	000806b7          	lui	a3,0x80
ffffffffc02022b2:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02022b4:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc02022b8:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc02022ba:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02022bc:	18f5fa63          	bgeu	a1,a5,ffffffffc0202450 <exit_range+0x256>
ffffffffc02022c0:	000c5817          	auipc	a6,0xc5
ffffffffc02022c4:	8f880813          	addi	a6,a6,-1800 # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc02022c8:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc02022cc:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc02022ce:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc02022d2:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc02022d4:	00080337          	lui	t1,0x80
ffffffffc02022d8:	6885                	lui	a7,0x1
ffffffffc02022da:	a819                	j	ffffffffc02022f0 <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc02022dc:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc02022de:	002007b7          	lui	a5,0x200
ffffffffc02022e2:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc02022e4:	08090c63          	beqz	s2,ffffffffc020237c <exit_range+0x182>
ffffffffc02022e8:	09397a63          	bgeu	s2,s3,ffffffffc020237c <exit_range+0x182>
ffffffffc02022ec:	0f597063          	bgeu	s2,s5,ffffffffc02023cc <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc02022f0:	01595493          	srli	s1,s2,0x15
ffffffffc02022f4:	1ff4f493          	andi	s1,s1,511
ffffffffc02022f8:	048e                	slli	s1,s1,0x3
ffffffffc02022fa:	94da                	add	s1,s1,s6
ffffffffc02022fc:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc02022fe:	0017f693          	andi	a3,a5,1
ffffffffc0202302:	dee9                	beqz	a3,ffffffffc02022dc <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc0202304:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202308:	078a                	slli	a5,a5,0x2
ffffffffc020230a:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020230c:	14b7fe63          	bgeu	a5,a1,ffffffffc0202468 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202310:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc0202312:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc0202316:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc020231a:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc020231e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202320:	12bef863          	bgeu	t4,a1,ffffffffc0202450 <exit_range+0x256>
ffffffffc0202324:	00083783          	ld	a5,0(a6)
ffffffffc0202328:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc020232a:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc020232e:	629c                	ld	a5,0(a3)
ffffffffc0202330:	8b85                	andi	a5,a5,1
ffffffffc0202332:	f7d5                	bnez	a5,ffffffffc02022de <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202334:	06a1                	addi	a3,a3,8
ffffffffc0202336:	fed59ce3          	bne	a1,a3,ffffffffc020232e <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc020233a:	631c                	ld	a5,0(a4)
ffffffffc020233c:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020233e:	100027f3          	csrr	a5,sstatus
ffffffffc0202342:	8b89                	andi	a5,a5,2
ffffffffc0202344:	e7d9                	bnez	a5,ffffffffc02023d2 <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc0202346:	000db783          	ld	a5,0(s11)
ffffffffc020234a:	4585                	li	a1,1
ffffffffc020234c:	e032                	sd	a2,0(sp)
ffffffffc020234e:	739c                	ld	a5,32(a5)
ffffffffc0202350:	9782                	jalr	a5
    if (flag)
ffffffffc0202352:	6602                	ld	a2,0(sp)
ffffffffc0202354:	000c5817          	auipc	a6,0xc5
ffffffffc0202358:	86480813          	addi	a6,a6,-1948 # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc020235c:	fff80e37          	lui	t3,0xfff80
ffffffffc0202360:	00080337          	lui	t1,0x80
ffffffffc0202364:	6885                	lui	a7,0x1
ffffffffc0202366:	000c5717          	auipc	a4,0xc5
ffffffffc020236a:	84270713          	addi	a4,a4,-1982 # ffffffffc02c6ba8 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc020236e:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc0202372:	002007b7          	lui	a5,0x200
ffffffffc0202376:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202378:	f60918e3          	bnez	s2,ffffffffc02022e8 <exit_range+0xee>
            if (free_pd0)
ffffffffc020237c:	f00b85e3          	beqz	s7,ffffffffc0202286 <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc0202380:	000d3783          	ld	a5,0(s10)
ffffffffc0202384:	0efa7263          	bgeu	s4,a5,ffffffffc0202468 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202388:	6308                	ld	a0,0(a4)
ffffffffc020238a:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020238c:	100027f3          	csrr	a5,sstatus
ffffffffc0202390:	8b89                	andi	a5,a5,2
ffffffffc0202392:	efad                	bnez	a5,ffffffffc020240c <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc0202394:	000db783          	ld	a5,0(s11)
ffffffffc0202398:	4585                	li	a1,1
ffffffffc020239a:	739c                	ld	a5,32(a5)
ffffffffc020239c:	9782                	jalr	a5
ffffffffc020239e:	000c5717          	auipc	a4,0xc5
ffffffffc02023a2:	80a70713          	addi	a4,a4,-2038 # ffffffffc02c6ba8 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc02023a6:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc02023aa:	ee0990e3          	bnez	s3,ffffffffc020228a <exit_range+0x90>
}
ffffffffc02023ae:	70e6                	ld	ra,120(sp)
ffffffffc02023b0:	7446                	ld	s0,112(sp)
ffffffffc02023b2:	74a6                	ld	s1,104(sp)
ffffffffc02023b4:	7906                	ld	s2,96(sp)
ffffffffc02023b6:	69e6                	ld	s3,88(sp)
ffffffffc02023b8:	6a46                	ld	s4,80(sp)
ffffffffc02023ba:	6aa6                	ld	s5,72(sp)
ffffffffc02023bc:	6b06                	ld	s6,64(sp)
ffffffffc02023be:	7be2                	ld	s7,56(sp)
ffffffffc02023c0:	7c42                	ld	s8,48(sp)
ffffffffc02023c2:	7ca2                	ld	s9,40(sp)
ffffffffc02023c4:	7d02                	ld	s10,32(sp)
ffffffffc02023c6:	6de2                	ld	s11,24(sp)
ffffffffc02023c8:	6109                	addi	sp,sp,128
ffffffffc02023ca:	8082                	ret
            if (free_pd0)
ffffffffc02023cc:	ea0b8fe3          	beqz	s7,ffffffffc020228a <exit_range+0x90>
ffffffffc02023d0:	bf45                	j	ffffffffc0202380 <exit_range+0x186>
ffffffffc02023d2:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc02023d4:	e42a                	sd	a0,8(sp)
ffffffffc02023d6:	dd8fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02023da:	000db783          	ld	a5,0(s11)
ffffffffc02023de:	6522                	ld	a0,8(sp)
ffffffffc02023e0:	4585                	li	a1,1
ffffffffc02023e2:	739c                	ld	a5,32(a5)
ffffffffc02023e4:	9782                	jalr	a5
        intr_enable();
ffffffffc02023e6:	dc2fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02023ea:	6602                	ld	a2,0(sp)
ffffffffc02023ec:	000c4717          	auipc	a4,0xc4
ffffffffc02023f0:	7bc70713          	addi	a4,a4,1980 # ffffffffc02c6ba8 <pages>
ffffffffc02023f4:	6885                	lui	a7,0x1
ffffffffc02023f6:	00080337          	lui	t1,0x80
ffffffffc02023fa:	fff80e37          	lui	t3,0xfff80
ffffffffc02023fe:	000c4817          	auipc	a6,0xc4
ffffffffc0202402:	7ba80813          	addi	a6,a6,1978 # ffffffffc02c6bb8 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202406:	0004b023          	sd	zero,0(s1)
ffffffffc020240a:	b7a5                	j	ffffffffc0202372 <exit_range+0x178>
ffffffffc020240c:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc020240e:	da0fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202412:	000db783          	ld	a5,0(s11)
ffffffffc0202416:	6502                	ld	a0,0(sp)
ffffffffc0202418:	4585                	li	a1,1
ffffffffc020241a:	739c                	ld	a5,32(a5)
ffffffffc020241c:	9782                	jalr	a5
        intr_enable();
ffffffffc020241e:	d8afe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202422:	000c4717          	auipc	a4,0xc4
ffffffffc0202426:	78670713          	addi	a4,a4,1926 # ffffffffc02c6ba8 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc020242a:	00043023          	sd	zero,0(s0)
ffffffffc020242e:	bfb5                	j	ffffffffc02023aa <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202430:	00004697          	auipc	a3,0x4
ffffffffc0202434:	3c068693          	addi	a3,a3,960 # ffffffffc02067f0 <default_pmm_manager+0x160>
ffffffffc0202438:	00004617          	auipc	a2,0x4
ffffffffc020243c:	ea860613          	addi	a2,a2,-344 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202440:	13700593          	li	a1,311
ffffffffc0202444:	00004517          	auipc	a0,0x4
ffffffffc0202448:	39c50513          	addi	a0,a0,924 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020244c:	846fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc0202450:	00004617          	auipc	a2,0x4
ffffffffc0202454:	27860613          	addi	a2,a2,632 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0202458:	07100593          	li	a1,113
ffffffffc020245c:	00004517          	auipc	a0,0x4
ffffffffc0202460:	29450513          	addi	a0,a0,660 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0202464:	82efe0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0202468:	8e1ff0ef          	jal	ra,ffffffffc0201d48 <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc020246c:	00004697          	auipc	a3,0x4
ffffffffc0202470:	3b468693          	addi	a3,a3,948 # ffffffffc0206820 <default_pmm_manager+0x190>
ffffffffc0202474:	00004617          	auipc	a2,0x4
ffffffffc0202478:	e6c60613          	addi	a2,a2,-404 # ffffffffc02062e0 <commands+0x818>
ffffffffc020247c:	13800593          	li	a1,312
ffffffffc0202480:	00004517          	auipc	a0,0x4
ffffffffc0202484:	36050513          	addi	a0,a0,864 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202488:	80afe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020248c <page_remove>:
{
ffffffffc020248c:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc020248e:	4601                	li	a2,0
{
ffffffffc0202490:	ec26                	sd	s1,24(sp)
ffffffffc0202492:	f406                	sd	ra,40(sp)
ffffffffc0202494:	f022                	sd	s0,32(sp)
ffffffffc0202496:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202498:	9a1ff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
    if (ptep != NULL)
ffffffffc020249c:	c511                	beqz	a0,ffffffffc02024a8 <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc020249e:	611c                	ld	a5,0(a0)
ffffffffc02024a0:	842a                	mv	s0,a0
ffffffffc02024a2:	0017f713          	andi	a4,a5,1
ffffffffc02024a6:	e711                	bnez	a4,ffffffffc02024b2 <page_remove+0x26>
}
ffffffffc02024a8:	70a2                	ld	ra,40(sp)
ffffffffc02024aa:	7402                	ld	s0,32(sp)
ffffffffc02024ac:	64e2                	ld	s1,24(sp)
ffffffffc02024ae:	6145                	addi	sp,sp,48
ffffffffc02024b0:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02024b2:	078a                	slli	a5,a5,0x2
ffffffffc02024b4:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02024b6:	000c4717          	auipc	a4,0xc4
ffffffffc02024ba:	6ea73703          	ld	a4,1770(a4) # ffffffffc02c6ba0 <npage>
ffffffffc02024be:	06e7f363          	bgeu	a5,a4,ffffffffc0202524 <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc02024c2:	fff80537          	lui	a0,0xfff80
ffffffffc02024c6:	97aa                	add	a5,a5,a0
ffffffffc02024c8:	079a                	slli	a5,a5,0x6
ffffffffc02024ca:	000c4517          	auipc	a0,0xc4
ffffffffc02024ce:	6de53503          	ld	a0,1758(a0) # ffffffffc02c6ba8 <pages>
ffffffffc02024d2:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc02024d4:	411c                	lw	a5,0(a0)
ffffffffc02024d6:	fff7871b          	addiw	a4,a5,-1
ffffffffc02024da:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc02024dc:	cb11                	beqz	a4,ffffffffc02024f0 <page_remove+0x64>
        *ptep = 0;                 //(5) clear second page table entry
ffffffffc02024de:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02024e2:	12048073          	sfence.vma	s1
}
ffffffffc02024e6:	70a2                	ld	ra,40(sp)
ffffffffc02024e8:	7402                	ld	s0,32(sp)
ffffffffc02024ea:	64e2                	ld	s1,24(sp)
ffffffffc02024ec:	6145                	addi	sp,sp,48
ffffffffc02024ee:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02024f0:	100027f3          	csrr	a5,sstatus
ffffffffc02024f4:	8b89                	andi	a5,a5,2
ffffffffc02024f6:	eb89                	bnez	a5,ffffffffc0202508 <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc02024f8:	000c4797          	auipc	a5,0xc4
ffffffffc02024fc:	6b87b783          	ld	a5,1720(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0202500:	739c                	ld	a5,32(a5)
ffffffffc0202502:	4585                	li	a1,1
ffffffffc0202504:	9782                	jalr	a5
    if (flag)
ffffffffc0202506:	bfe1                	j	ffffffffc02024de <page_remove+0x52>
        intr_disable();
ffffffffc0202508:	e42a                	sd	a0,8(sp)
ffffffffc020250a:	ca4fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc020250e:	000c4797          	auipc	a5,0xc4
ffffffffc0202512:	6a27b783          	ld	a5,1698(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0202516:	739c                	ld	a5,32(a5)
ffffffffc0202518:	6522                	ld	a0,8(sp)
ffffffffc020251a:	4585                	li	a1,1
ffffffffc020251c:	9782                	jalr	a5
        intr_enable();
ffffffffc020251e:	c8afe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202522:	bf75                	j	ffffffffc02024de <page_remove+0x52>
ffffffffc0202524:	825ff0ef          	jal	ra,ffffffffc0201d48 <pa2page.part.0>

ffffffffc0202528 <page_insert>:
{
ffffffffc0202528:	7139                	addi	sp,sp,-64
ffffffffc020252a:	e852                	sd	s4,16(sp)
ffffffffc020252c:	8a32                	mv	s4,a2
ffffffffc020252e:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202530:	4605                	li	a2,1
{
ffffffffc0202532:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202534:	85d2                	mv	a1,s4
{
ffffffffc0202536:	f426                	sd	s1,40(sp)
ffffffffc0202538:	fc06                	sd	ra,56(sp)
ffffffffc020253a:	f04a                	sd	s2,32(sp)
ffffffffc020253c:	ec4e                	sd	s3,24(sp)
ffffffffc020253e:	e456                	sd	s5,8(sp)
ffffffffc0202540:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202542:	8f7ff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
    if (ptep == NULL)
ffffffffc0202546:	c961                	beqz	a0,ffffffffc0202616 <page_insert+0xee>
    page->ref += 1;
ffffffffc0202548:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc020254a:	611c                	ld	a5,0(a0)
ffffffffc020254c:	89aa                	mv	s3,a0
ffffffffc020254e:	0016871b          	addiw	a4,a3,1
ffffffffc0202552:	c018                	sw	a4,0(s0)
ffffffffc0202554:	0017f713          	andi	a4,a5,1
ffffffffc0202558:	ef05                	bnez	a4,ffffffffc0202590 <page_insert+0x68>
    return page - pages + nbase;
ffffffffc020255a:	000c4717          	auipc	a4,0xc4
ffffffffc020255e:	64e73703          	ld	a4,1614(a4) # ffffffffc02c6ba8 <pages>
ffffffffc0202562:	8c19                	sub	s0,s0,a4
ffffffffc0202564:	000807b7          	lui	a5,0x80
ffffffffc0202568:	8419                	srai	s0,s0,0x6
ffffffffc020256a:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020256c:	042a                	slli	s0,s0,0xa
ffffffffc020256e:	8cc1                	or	s1,s1,s0
ffffffffc0202570:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc0202574:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_matrix_out_size+0xffffffffbfff38f0>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202578:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc020257c:	4501                	li	a0,0
}
ffffffffc020257e:	70e2                	ld	ra,56(sp)
ffffffffc0202580:	7442                	ld	s0,48(sp)
ffffffffc0202582:	74a2                	ld	s1,40(sp)
ffffffffc0202584:	7902                	ld	s2,32(sp)
ffffffffc0202586:	69e2                	ld	s3,24(sp)
ffffffffc0202588:	6a42                	ld	s4,16(sp)
ffffffffc020258a:	6aa2                	ld	s5,8(sp)
ffffffffc020258c:	6121                	addi	sp,sp,64
ffffffffc020258e:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0202590:	078a                	slli	a5,a5,0x2
ffffffffc0202592:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202594:	000c4717          	auipc	a4,0xc4
ffffffffc0202598:	60c73703          	ld	a4,1548(a4) # ffffffffc02c6ba0 <npage>
ffffffffc020259c:	06e7ff63          	bgeu	a5,a4,ffffffffc020261a <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc02025a0:	000c4a97          	auipc	s5,0xc4
ffffffffc02025a4:	608a8a93          	addi	s5,s5,1544 # ffffffffc02c6ba8 <pages>
ffffffffc02025a8:	000ab703          	ld	a4,0(s5)
ffffffffc02025ac:	fff80937          	lui	s2,0xfff80
ffffffffc02025b0:	993e                	add	s2,s2,a5
ffffffffc02025b2:	091a                	slli	s2,s2,0x6
ffffffffc02025b4:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc02025b6:	01240c63          	beq	s0,s2,ffffffffc02025ce <page_insert+0xa6>
    page->ref -= 1;
ffffffffc02025ba:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcb9410>
ffffffffc02025be:	fff7869b          	addiw	a3,a5,-1
ffffffffc02025c2:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) ==
ffffffffc02025c6:	c691                	beqz	a3,ffffffffc02025d2 <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02025c8:	120a0073          	sfence.vma	s4
}
ffffffffc02025cc:	bf59                	j	ffffffffc0202562 <page_insert+0x3a>
ffffffffc02025ce:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc02025d0:	bf49                	j	ffffffffc0202562 <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02025d2:	100027f3          	csrr	a5,sstatus
ffffffffc02025d6:	8b89                	andi	a5,a5,2
ffffffffc02025d8:	ef91                	bnez	a5,ffffffffc02025f4 <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc02025da:	000c4797          	auipc	a5,0xc4
ffffffffc02025de:	5d67b783          	ld	a5,1494(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc02025e2:	739c                	ld	a5,32(a5)
ffffffffc02025e4:	4585                	li	a1,1
ffffffffc02025e6:	854a                	mv	a0,s2
ffffffffc02025e8:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc02025ea:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02025ee:	120a0073          	sfence.vma	s4
ffffffffc02025f2:	bf85                	j	ffffffffc0202562 <page_insert+0x3a>
        intr_disable();
ffffffffc02025f4:	bbafe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02025f8:	000c4797          	auipc	a5,0xc4
ffffffffc02025fc:	5b87b783          	ld	a5,1464(a5) # ffffffffc02c6bb0 <pmm_manager>
ffffffffc0202600:	739c                	ld	a5,32(a5)
ffffffffc0202602:	4585                	li	a1,1
ffffffffc0202604:	854a                	mv	a0,s2
ffffffffc0202606:	9782                	jalr	a5
        intr_enable();
ffffffffc0202608:	ba0fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020260c:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202610:	120a0073          	sfence.vma	s4
ffffffffc0202614:	b7b9                	j	ffffffffc0202562 <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc0202616:	5571                	li	a0,-4
ffffffffc0202618:	b79d                	j	ffffffffc020257e <page_insert+0x56>
ffffffffc020261a:	f2eff0ef          	jal	ra,ffffffffc0201d48 <pa2page.part.0>

ffffffffc020261e <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc020261e:	00004797          	auipc	a5,0x4
ffffffffc0202622:	07278793          	addi	a5,a5,114 # ffffffffc0206690 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202626:	638c                	ld	a1,0(a5)
{
ffffffffc0202628:	7159                	addi	sp,sp,-112
ffffffffc020262a:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020262c:	00004517          	auipc	a0,0x4
ffffffffc0202630:	20c50513          	addi	a0,a0,524 # ffffffffc0206838 <default_pmm_manager+0x1a8>
    pmm_manager = &default_pmm_manager;
ffffffffc0202634:	000c4b17          	auipc	s6,0xc4
ffffffffc0202638:	57cb0b13          	addi	s6,s6,1404 # ffffffffc02c6bb0 <pmm_manager>
{
ffffffffc020263c:	f486                	sd	ra,104(sp)
ffffffffc020263e:	e8ca                	sd	s2,80(sp)
ffffffffc0202640:	e4ce                	sd	s3,72(sp)
ffffffffc0202642:	f0a2                	sd	s0,96(sp)
ffffffffc0202644:	eca6                	sd	s1,88(sp)
ffffffffc0202646:	e0d2                	sd	s4,64(sp)
ffffffffc0202648:	fc56                	sd	s5,56(sp)
ffffffffc020264a:	f45e                	sd	s7,40(sp)
ffffffffc020264c:	f062                	sd	s8,32(sp)
ffffffffc020264e:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202650:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202654:	b45fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    pmm_manager->init();
ffffffffc0202658:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020265c:	000c4997          	auipc	s3,0xc4
ffffffffc0202660:	55c98993          	addi	s3,s3,1372 # ffffffffc02c6bb8 <va_pa_offset>
    pmm_manager->init();
ffffffffc0202664:	679c                	ld	a5,8(a5)
ffffffffc0202666:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202668:	57f5                	li	a5,-3
ffffffffc020266a:	07fa                	slli	a5,a5,0x1e
ffffffffc020266c:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc0202670:	b24fe0ef          	jal	ra,ffffffffc0200994 <get_memory_base>
ffffffffc0202674:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc0202676:	b28fe0ef          	jal	ra,ffffffffc020099e <get_memory_size>
    if (mem_size == 0)
ffffffffc020267a:	200505e3          	beqz	a0,ffffffffc0203084 <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc020267e:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc0202680:	00004517          	auipc	a0,0x4
ffffffffc0202684:	1f050513          	addi	a0,a0,496 # ffffffffc0206870 <default_pmm_manager+0x1e0>
ffffffffc0202688:	b11fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc020268c:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc0202690:	fff40693          	addi	a3,s0,-1
ffffffffc0202694:	864a                	mv	a2,s2
ffffffffc0202696:	85a6                	mv	a1,s1
ffffffffc0202698:	00004517          	auipc	a0,0x4
ffffffffc020269c:	1f050513          	addi	a0,a0,496 # ffffffffc0206888 <default_pmm_manager+0x1f8>
ffffffffc02026a0:	af9fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02026a4:	c8000737          	lui	a4,0xc8000
ffffffffc02026a8:	87a2                	mv	a5,s0
ffffffffc02026aa:	54876163          	bltu	a4,s0,ffffffffc0202bec <pmm_init+0x5ce>
ffffffffc02026ae:	757d                	lui	a0,0xfffff
ffffffffc02026b0:	000c5617          	auipc	a2,0xc5
ffffffffc02026b4:	53f60613          	addi	a2,a2,1343 # ffffffffc02c7bef <end+0xfff>
ffffffffc02026b8:	8e69                	and	a2,a2,a0
ffffffffc02026ba:	000c4497          	auipc	s1,0xc4
ffffffffc02026be:	4e648493          	addi	s1,s1,1254 # ffffffffc02c6ba0 <npage>
ffffffffc02026c2:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02026c6:	000c4b97          	auipc	s7,0xc4
ffffffffc02026ca:	4e2b8b93          	addi	s7,s7,1250 # ffffffffc02c6ba8 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02026ce:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02026d0:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02026d4:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02026d8:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02026da:	02f50863          	beq	a0,a5,ffffffffc020270a <pmm_init+0xec>
ffffffffc02026de:	4781                	li	a5,0
ffffffffc02026e0:	4585                	li	a1,1
ffffffffc02026e2:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc02026e6:	00679513          	slli	a0,a5,0x6
ffffffffc02026ea:	9532                	add	a0,a0,a2
ffffffffc02026ec:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd38418>
ffffffffc02026f0:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02026f4:	6088                	ld	a0,0(s1)
ffffffffc02026f6:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc02026f8:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02026fc:	00d50733          	add	a4,a0,a3
ffffffffc0202700:	fee7e3e3          	bltu	a5,a4,ffffffffc02026e6 <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202704:	071a                	slli	a4,a4,0x6
ffffffffc0202706:	00e606b3          	add	a3,a2,a4
ffffffffc020270a:	c02007b7          	lui	a5,0xc0200
ffffffffc020270e:	2ef6ece3          	bltu	a3,a5,ffffffffc0203206 <pmm_init+0xbe8>
ffffffffc0202712:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0202716:	77fd                	lui	a5,0xfffff
ffffffffc0202718:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020271a:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc020271c:	5086eb63          	bltu	a3,s0,ffffffffc0202c32 <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202720:	00004517          	auipc	a0,0x4
ffffffffc0202724:	19050513          	addi	a0,a0,400 # ffffffffc02068b0 <default_pmm_manager+0x220>
ffffffffc0202728:	a71fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc020272c:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202730:	000c4917          	auipc	s2,0xc4
ffffffffc0202734:	46890913          	addi	s2,s2,1128 # ffffffffc02c6b98 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc0202738:	7b9c                	ld	a5,48(a5)
ffffffffc020273a:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc020273c:	00004517          	auipc	a0,0x4
ffffffffc0202740:	18c50513          	addi	a0,a0,396 # ffffffffc02068c8 <default_pmm_manager+0x238>
ffffffffc0202744:	a55fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202748:	00009697          	auipc	a3,0x9
ffffffffc020274c:	8b868693          	addi	a3,a3,-1864 # ffffffffc020b000 <boot_page_table_sv39>
ffffffffc0202750:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0202754:	c02007b7          	lui	a5,0xc0200
ffffffffc0202758:	28f6ebe3          	bltu	a3,a5,ffffffffc02031ee <pmm_init+0xbd0>
ffffffffc020275c:	0009b783          	ld	a5,0(s3)
ffffffffc0202760:	8e9d                	sub	a3,a3,a5
ffffffffc0202762:	000c4797          	auipc	a5,0xc4
ffffffffc0202766:	42d7b723          	sd	a3,1070(a5) # ffffffffc02c6b90 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020276a:	100027f3          	csrr	a5,sstatus
ffffffffc020276e:	8b89                	andi	a5,a5,2
ffffffffc0202770:	4a079763          	bnez	a5,ffffffffc0202c1e <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202774:	000b3783          	ld	a5,0(s6)
ffffffffc0202778:	779c                	ld	a5,40(a5)
ffffffffc020277a:	9782                	jalr	a5
ffffffffc020277c:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc020277e:	6098                	ld	a4,0(s1)
ffffffffc0202780:	c80007b7          	lui	a5,0xc8000
ffffffffc0202784:	83b1                	srli	a5,a5,0xc
ffffffffc0202786:	66e7e363          	bltu	a5,a4,ffffffffc0202dec <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc020278a:	00093503          	ld	a0,0(s2)
ffffffffc020278e:	62050f63          	beqz	a0,ffffffffc0202dcc <pmm_init+0x7ae>
ffffffffc0202792:	03451793          	slli	a5,a0,0x34
ffffffffc0202796:	62079b63          	bnez	a5,ffffffffc0202dcc <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc020279a:	4601                	li	a2,0
ffffffffc020279c:	4581                	li	a1,0
ffffffffc020279e:	8c3ff0ef          	jal	ra,ffffffffc0202060 <get_page>
ffffffffc02027a2:	60051563          	bnez	a0,ffffffffc0202dac <pmm_init+0x78e>
ffffffffc02027a6:	100027f3          	csrr	a5,sstatus
ffffffffc02027aa:	8b89                	andi	a5,a5,2
ffffffffc02027ac:	44079e63          	bnez	a5,ffffffffc0202c08 <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc02027b0:	000b3783          	ld	a5,0(s6)
ffffffffc02027b4:	4505                	li	a0,1
ffffffffc02027b6:	6f9c                	ld	a5,24(a5)
ffffffffc02027b8:	9782                	jalr	a5
ffffffffc02027ba:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc02027bc:	00093503          	ld	a0,0(s2)
ffffffffc02027c0:	4681                	li	a3,0
ffffffffc02027c2:	4601                	li	a2,0
ffffffffc02027c4:	85d2                	mv	a1,s4
ffffffffc02027c6:	d63ff0ef          	jal	ra,ffffffffc0202528 <page_insert>
ffffffffc02027ca:	26051ae3          	bnez	a0,ffffffffc020323e <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc02027ce:	00093503          	ld	a0,0(s2)
ffffffffc02027d2:	4601                	li	a2,0
ffffffffc02027d4:	4581                	li	a1,0
ffffffffc02027d6:	e62ff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
ffffffffc02027da:	240502e3          	beqz	a0,ffffffffc020321e <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc02027de:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc02027e0:	0017f713          	andi	a4,a5,1
ffffffffc02027e4:	5a070263          	beqz	a4,ffffffffc0202d88 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc02027e8:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc02027ea:	078a                	slli	a5,a5,0x2
ffffffffc02027ec:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02027ee:	58e7fb63          	bgeu	a5,a4,ffffffffc0202d84 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02027f2:	000bb683          	ld	a3,0(s7)
ffffffffc02027f6:	fff80637          	lui	a2,0xfff80
ffffffffc02027fa:	97b2                	add	a5,a5,a2
ffffffffc02027fc:	079a                	slli	a5,a5,0x6
ffffffffc02027fe:	97b6                	add	a5,a5,a3
ffffffffc0202800:	14fa17e3          	bne	s4,a5,ffffffffc020314e <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc0202804:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f38>
ffffffffc0202808:	4785                	li	a5,1
ffffffffc020280a:	12f692e3          	bne	a3,a5,ffffffffc020312e <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc020280e:	00093503          	ld	a0,0(s2)
ffffffffc0202812:	77fd                	lui	a5,0xfffff
ffffffffc0202814:	6114                	ld	a3,0(a0)
ffffffffc0202816:	068a                	slli	a3,a3,0x2
ffffffffc0202818:	8efd                	and	a3,a3,a5
ffffffffc020281a:	00c6d613          	srli	a2,a3,0xc
ffffffffc020281e:	0ee67ce3          	bgeu	a2,a4,ffffffffc0203116 <pmm_init+0xaf8>
ffffffffc0202822:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202826:	96e2                	add	a3,a3,s8
ffffffffc0202828:	0006ba83          	ld	s5,0(a3)
ffffffffc020282c:	0a8a                	slli	s5,s5,0x2
ffffffffc020282e:	00fafab3          	and	s5,s5,a5
ffffffffc0202832:	00cad793          	srli	a5,s5,0xc
ffffffffc0202836:	0ce7f3e3          	bgeu	a5,a4,ffffffffc02030fc <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020283a:	4601                	li	a2,0
ffffffffc020283c:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020283e:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202840:	df8ff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202844:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202846:	55551363          	bne	a0,s5,ffffffffc0202d8c <pmm_init+0x76e>
ffffffffc020284a:	100027f3          	csrr	a5,sstatus
ffffffffc020284e:	8b89                	andi	a5,a5,2
ffffffffc0202850:	3a079163          	bnez	a5,ffffffffc0202bf2 <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202854:	000b3783          	ld	a5,0(s6)
ffffffffc0202858:	4505                	li	a0,1
ffffffffc020285a:	6f9c                	ld	a5,24(a5)
ffffffffc020285c:	9782                	jalr	a5
ffffffffc020285e:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0202860:	00093503          	ld	a0,0(s2)
ffffffffc0202864:	46d1                	li	a3,20
ffffffffc0202866:	6605                	lui	a2,0x1
ffffffffc0202868:	85e2                	mv	a1,s8
ffffffffc020286a:	cbfff0ef          	jal	ra,ffffffffc0202528 <page_insert>
ffffffffc020286e:	060517e3          	bnez	a0,ffffffffc02030dc <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0202872:	00093503          	ld	a0,0(s2)
ffffffffc0202876:	4601                	li	a2,0
ffffffffc0202878:	6585                	lui	a1,0x1
ffffffffc020287a:	dbeff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
ffffffffc020287e:	02050fe3          	beqz	a0,ffffffffc02030bc <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc0202882:	611c                	ld	a5,0(a0)
ffffffffc0202884:	0107f713          	andi	a4,a5,16
ffffffffc0202888:	7c070e63          	beqz	a4,ffffffffc0203064 <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc020288c:	8b91                	andi	a5,a5,4
ffffffffc020288e:	7a078b63          	beqz	a5,ffffffffc0203044 <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc0202892:	00093503          	ld	a0,0(s2)
ffffffffc0202896:	611c                	ld	a5,0(a0)
ffffffffc0202898:	8bc1                	andi	a5,a5,16
ffffffffc020289a:	78078563          	beqz	a5,ffffffffc0203024 <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc020289e:	000c2703          	lw	a4,0(s8)
ffffffffc02028a2:	4785                	li	a5,1
ffffffffc02028a4:	76f71063          	bne	a4,a5,ffffffffc0203004 <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02028a8:	4681                	li	a3,0
ffffffffc02028aa:	6605                	lui	a2,0x1
ffffffffc02028ac:	85d2                	mv	a1,s4
ffffffffc02028ae:	c7bff0ef          	jal	ra,ffffffffc0202528 <page_insert>
ffffffffc02028b2:	72051963          	bnez	a0,ffffffffc0202fe4 <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc02028b6:	000a2703          	lw	a4,0(s4)
ffffffffc02028ba:	4789                	li	a5,2
ffffffffc02028bc:	70f71463          	bne	a4,a5,ffffffffc0202fc4 <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc02028c0:	000c2783          	lw	a5,0(s8)
ffffffffc02028c4:	6e079063          	bnez	a5,ffffffffc0202fa4 <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02028c8:	00093503          	ld	a0,0(s2)
ffffffffc02028cc:	4601                	li	a2,0
ffffffffc02028ce:	6585                	lui	a1,0x1
ffffffffc02028d0:	d68ff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
ffffffffc02028d4:	6a050863          	beqz	a0,ffffffffc0202f84 <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc02028d8:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc02028da:	00177793          	andi	a5,a4,1
ffffffffc02028de:	4a078563          	beqz	a5,ffffffffc0202d88 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc02028e2:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc02028e4:	00271793          	slli	a5,a4,0x2
ffffffffc02028e8:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02028ea:	48d7fd63          	bgeu	a5,a3,ffffffffc0202d84 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02028ee:	000bb683          	ld	a3,0(s7)
ffffffffc02028f2:	fff80ab7          	lui	s5,0xfff80
ffffffffc02028f6:	97d6                	add	a5,a5,s5
ffffffffc02028f8:	079a                	slli	a5,a5,0x6
ffffffffc02028fa:	97b6                	add	a5,a5,a3
ffffffffc02028fc:	66fa1463          	bne	s4,a5,ffffffffc0202f64 <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202900:	8b41                	andi	a4,a4,16
ffffffffc0202902:	64071163          	bnez	a4,ffffffffc0202f44 <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc0202906:	00093503          	ld	a0,0(s2)
ffffffffc020290a:	4581                	li	a1,0
ffffffffc020290c:	b81ff0ef          	jal	ra,ffffffffc020248c <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc0202910:	000a2c83          	lw	s9,0(s4)
ffffffffc0202914:	4785                	li	a5,1
ffffffffc0202916:	60fc9763          	bne	s9,a5,ffffffffc0202f24 <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc020291a:	000c2783          	lw	a5,0(s8)
ffffffffc020291e:	5e079363          	bnez	a5,ffffffffc0202f04 <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc0202922:	00093503          	ld	a0,0(s2)
ffffffffc0202926:	6585                	lui	a1,0x1
ffffffffc0202928:	b65ff0ef          	jal	ra,ffffffffc020248c <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc020292c:	000a2783          	lw	a5,0(s4)
ffffffffc0202930:	52079a63          	bnez	a5,ffffffffc0202e64 <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc0202934:	000c2783          	lw	a5,0(s8)
ffffffffc0202938:	50079663          	bnez	a5,ffffffffc0202e44 <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc020293c:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202940:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202942:	000a3683          	ld	a3,0(s4)
ffffffffc0202946:	068a                	slli	a3,a3,0x2
ffffffffc0202948:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc020294a:	42b6fd63          	bgeu	a3,a1,ffffffffc0202d84 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc020294e:	000bb503          	ld	a0,0(s7)
ffffffffc0202952:	96d6                	add	a3,a3,s5
ffffffffc0202954:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc0202956:	00d507b3          	add	a5,a0,a3
ffffffffc020295a:	439c                	lw	a5,0(a5)
ffffffffc020295c:	4d979463          	bne	a5,s9,ffffffffc0202e24 <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc0202960:	8699                	srai	a3,a3,0x6
ffffffffc0202962:	00080637          	lui	a2,0x80
ffffffffc0202966:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc0202968:	00c69713          	slli	a4,a3,0xc
ffffffffc020296c:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc020296e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202970:	48b77e63          	bgeu	a4,a1,ffffffffc0202e0c <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc0202974:	0009b703          	ld	a4,0(s3)
ffffffffc0202978:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc020297a:	629c                	ld	a5,0(a3)
ffffffffc020297c:	078a                	slli	a5,a5,0x2
ffffffffc020297e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202980:	40b7f263          	bgeu	a5,a1,ffffffffc0202d84 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202984:	8f91                	sub	a5,a5,a2
ffffffffc0202986:	079a                	slli	a5,a5,0x6
ffffffffc0202988:	953e                	add	a0,a0,a5
ffffffffc020298a:	100027f3          	csrr	a5,sstatus
ffffffffc020298e:	8b89                	andi	a5,a5,2
ffffffffc0202990:	30079963          	bnez	a5,ffffffffc0202ca2 <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc0202994:	000b3783          	ld	a5,0(s6)
ffffffffc0202998:	4585                	li	a1,1
ffffffffc020299a:	739c                	ld	a5,32(a5)
ffffffffc020299c:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc020299e:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc02029a2:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc02029a4:	078a                	slli	a5,a5,0x2
ffffffffc02029a6:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029a8:	3ce7fe63          	bgeu	a5,a4,ffffffffc0202d84 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02029ac:	000bb503          	ld	a0,0(s7)
ffffffffc02029b0:	fff80737          	lui	a4,0xfff80
ffffffffc02029b4:	97ba                	add	a5,a5,a4
ffffffffc02029b6:	079a                	slli	a5,a5,0x6
ffffffffc02029b8:	953e                	add	a0,a0,a5
ffffffffc02029ba:	100027f3          	csrr	a5,sstatus
ffffffffc02029be:	8b89                	andi	a5,a5,2
ffffffffc02029c0:	2c079563          	bnez	a5,ffffffffc0202c8a <pmm_init+0x66c>
ffffffffc02029c4:	000b3783          	ld	a5,0(s6)
ffffffffc02029c8:	4585                	li	a1,1
ffffffffc02029ca:	739c                	ld	a5,32(a5)
ffffffffc02029cc:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc02029ce:	00093783          	ld	a5,0(s2)
ffffffffc02029d2:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd38410>
    asm volatile("sfence.vma");
ffffffffc02029d6:	12000073          	sfence.vma
ffffffffc02029da:	100027f3          	csrr	a5,sstatus
ffffffffc02029de:	8b89                	andi	a5,a5,2
ffffffffc02029e0:	28079b63          	bnez	a5,ffffffffc0202c76 <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc02029e4:	000b3783          	ld	a5,0(s6)
ffffffffc02029e8:	779c                	ld	a5,40(a5)
ffffffffc02029ea:	9782                	jalr	a5
ffffffffc02029ec:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc02029ee:	4b441b63          	bne	s0,s4,ffffffffc0202ea4 <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc02029f2:	00004517          	auipc	a0,0x4
ffffffffc02029f6:	1fe50513          	addi	a0,a0,510 # ffffffffc0206bf0 <default_pmm_manager+0x560>
ffffffffc02029fa:	f9efd0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc02029fe:	100027f3          	csrr	a5,sstatus
ffffffffc0202a02:	8b89                	andi	a5,a5,2
ffffffffc0202a04:	24079f63          	bnez	a5,ffffffffc0202c62 <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202a08:	000b3783          	ld	a5,0(s6)
ffffffffc0202a0c:	779c                	ld	a5,40(a5)
ffffffffc0202a0e:	9782                	jalr	a5
ffffffffc0202a10:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a12:	6098                	ld	a4,0(s1)
ffffffffc0202a14:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202a18:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a1a:	00c71793          	slli	a5,a4,0xc
ffffffffc0202a1e:	6a05                	lui	s4,0x1
ffffffffc0202a20:	02f47c63          	bgeu	s0,a5,ffffffffc0202a58 <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202a24:	00c45793          	srli	a5,s0,0xc
ffffffffc0202a28:	00093503          	ld	a0,0(s2)
ffffffffc0202a2c:	2ee7ff63          	bgeu	a5,a4,ffffffffc0202d2a <pmm_init+0x70c>
ffffffffc0202a30:	0009b583          	ld	a1,0(s3)
ffffffffc0202a34:	4601                	li	a2,0
ffffffffc0202a36:	95a2                	add	a1,a1,s0
ffffffffc0202a38:	c00ff0ef          	jal	ra,ffffffffc0201e38 <get_pte>
ffffffffc0202a3c:	32050463          	beqz	a0,ffffffffc0202d64 <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202a40:	611c                	ld	a5,0(a0)
ffffffffc0202a42:	078a                	slli	a5,a5,0x2
ffffffffc0202a44:	0157f7b3          	and	a5,a5,s5
ffffffffc0202a48:	2e879e63          	bne	a5,s0,ffffffffc0202d44 <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a4c:	6098                	ld	a4,0(s1)
ffffffffc0202a4e:	9452                	add	s0,s0,s4
ffffffffc0202a50:	00c71793          	slli	a5,a4,0xc
ffffffffc0202a54:	fcf468e3          	bltu	s0,a5,ffffffffc0202a24 <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc0202a58:	00093783          	ld	a5,0(s2)
ffffffffc0202a5c:	639c                	ld	a5,0(a5)
ffffffffc0202a5e:	42079363          	bnez	a5,ffffffffc0202e84 <pmm_init+0x866>
ffffffffc0202a62:	100027f3          	csrr	a5,sstatus
ffffffffc0202a66:	8b89                	andi	a5,a5,2
ffffffffc0202a68:	24079963          	bnez	a5,ffffffffc0202cba <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202a6c:	000b3783          	ld	a5,0(s6)
ffffffffc0202a70:	4505                	li	a0,1
ffffffffc0202a72:	6f9c                	ld	a5,24(a5)
ffffffffc0202a74:	9782                	jalr	a5
ffffffffc0202a76:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202a78:	00093503          	ld	a0,0(s2)
ffffffffc0202a7c:	4699                	li	a3,6
ffffffffc0202a7e:	10000613          	li	a2,256
ffffffffc0202a82:	85d2                	mv	a1,s4
ffffffffc0202a84:	aa5ff0ef          	jal	ra,ffffffffc0202528 <page_insert>
ffffffffc0202a88:	44051e63          	bnez	a0,ffffffffc0202ee4 <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc0202a8c:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f38>
ffffffffc0202a90:	4785                	li	a5,1
ffffffffc0202a92:	42f71963          	bne	a4,a5,ffffffffc0202ec4 <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0202a96:	00093503          	ld	a0,0(s2)
ffffffffc0202a9a:	6405                	lui	s0,0x1
ffffffffc0202a9c:	4699                	li	a3,6
ffffffffc0202a9e:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8e38>
ffffffffc0202aa2:	85d2                	mv	a1,s4
ffffffffc0202aa4:	a85ff0ef          	jal	ra,ffffffffc0202528 <page_insert>
ffffffffc0202aa8:	72051363          	bnez	a0,ffffffffc02031ce <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0202aac:	000a2703          	lw	a4,0(s4)
ffffffffc0202ab0:	4789                	li	a5,2
ffffffffc0202ab2:	6ef71e63          	bne	a4,a5,ffffffffc02031ae <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0202ab6:	00004597          	auipc	a1,0x4
ffffffffc0202aba:	28258593          	addi	a1,a1,642 # ffffffffc0206d38 <default_pmm_manager+0x6a8>
ffffffffc0202abe:	10000513          	li	a0,256
ffffffffc0202ac2:	503020ef          	jal	ra,ffffffffc02057c4 <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0202ac6:	10040593          	addi	a1,s0,256
ffffffffc0202aca:	10000513          	li	a0,256
ffffffffc0202ace:	509020ef          	jal	ra,ffffffffc02057d6 <strcmp>
ffffffffc0202ad2:	6a051e63          	bnez	a0,ffffffffc020318e <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0202ad6:	000bb683          	ld	a3,0(s7)
ffffffffc0202ada:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0202ade:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc0202ae0:	40da06b3          	sub	a3,s4,a3
ffffffffc0202ae4:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0202ae6:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0202ae8:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0202aea:	8031                	srli	s0,s0,0xc
ffffffffc0202aec:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202af0:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202af2:	30f77d63          	bgeu	a4,a5,ffffffffc0202e0c <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202af6:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202afa:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202afe:	96be                	add	a3,a3,a5
ffffffffc0202b00:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202b04:	48b020ef          	jal	ra,ffffffffc020578e <strlen>
ffffffffc0202b08:	66051363          	bnez	a0,ffffffffc020316e <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0202b0c:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202b10:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b12:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd38410>
ffffffffc0202b16:	068a                	slli	a3,a3,0x2
ffffffffc0202b18:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b1a:	26f6f563          	bgeu	a3,a5,ffffffffc0202d84 <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0202b1e:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0202b20:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202b22:	2ef47563          	bgeu	s0,a5,ffffffffc0202e0c <pmm_init+0x7ee>
ffffffffc0202b26:	0009b403          	ld	s0,0(s3)
ffffffffc0202b2a:	9436                	add	s0,s0,a3
ffffffffc0202b2c:	100027f3          	csrr	a5,sstatus
ffffffffc0202b30:	8b89                	andi	a5,a5,2
ffffffffc0202b32:	1e079163          	bnez	a5,ffffffffc0202d14 <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc0202b36:	000b3783          	ld	a5,0(s6)
ffffffffc0202b3a:	4585                	li	a1,1
ffffffffc0202b3c:	8552                	mv	a0,s4
ffffffffc0202b3e:	739c                	ld	a5,32(a5)
ffffffffc0202b40:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b42:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc0202b44:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b46:	078a                	slli	a5,a5,0x2
ffffffffc0202b48:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b4a:	22e7fd63          	bgeu	a5,a4,ffffffffc0202d84 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b4e:	000bb503          	ld	a0,0(s7)
ffffffffc0202b52:	fff80737          	lui	a4,0xfff80
ffffffffc0202b56:	97ba                	add	a5,a5,a4
ffffffffc0202b58:	079a                	slli	a5,a5,0x6
ffffffffc0202b5a:	953e                	add	a0,a0,a5
ffffffffc0202b5c:	100027f3          	csrr	a5,sstatus
ffffffffc0202b60:	8b89                	andi	a5,a5,2
ffffffffc0202b62:	18079d63          	bnez	a5,ffffffffc0202cfc <pmm_init+0x6de>
ffffffffc0202b66:	000b3783          	ld	a5,0(s6)
ffffffffc0202b6a:	4585                	li	a1,1
ffffffffc0202b6c:	739c                	ld	a5,32(a5)
ffffffffc0202b6e:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b70:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc0202b74:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b76:	078a                	slli	a5,a5,0x2
ffffffffc0202b78:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b7a:	20e7f563          	bgeu	a5,a4,ffffffffc0202d84 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b7e:	000bb503          	ld	a0,0(s7)
ffffffffc0202b82:	fff80737          	lui	a4,0xfff80
ffffffffc0202b86:	97ba                	add	a5,a5,a4
ffffffffc0202b88:	079a                	slli	a5,a5,0x6
ffffffffc0202b8a:	953e                	add	a0,a0,a5
ffffffffc0202b8c:	100027f3          	csrr	a5,sstatus
ffffffffc0202b90:	8b89                	andi	a5,a5,2
ffffffffc0202b92:	14079963          	bnez	a5,ffffffffc0202ce4 <pmm_init+0x6c6>
ffffffffc0202b96:	000b3783          	ld	a5,0(s6)
ffffffffc0202b9a:	4585                	li	a1,1
ffffffffc0202b9c:	739c                	ld	a5,32(a5)
ffffffffc0202b9e:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202ba0:	00093783          	ld	a5,0(s2)
ffffffffc0202ba4:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0202ba8:	12000073          	sfence.vma
ffffffffc0202bac:	100027f3          	csrr	a5,sstatus
ffffffffc0202bb0:	8b89                	andi	a5,a5,2
ffffffffc0202bb2:	10079f63          	bnez	a5,ffffffffc0202cd0 <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202bb6:	000b3783          	ld	a5,0(s6)
ffffffffc0202bba:	779c                	ld	a5,40(a5)
ffffffffc0202bbc:	9782                	jalr	a5
ffffffffc0202bbe:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202bc0:	4c8c1e63          	bne	s8,s0,ffffffffc020309c <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc0202bc4:	00004517          	auipc	a0,0x4
ffffffffc0202bc8:	1ec50513          	addi	a0,a0,492 # ffffffffc0206db0 <default_pmm_manager+0x720>
ffffffffc0202bcc:	dccfd0ef          	jal	ra,ffffffffc0200198 <cprintf>
}
ffffffffc0202bd0:	7406                	ld	s0,96(sp)
ffffffffc0202bd2:	70a6                	ld	ra,104(sp)
ffffffffc0202bd4:	64e6                	ld	s1,88(sp)
ffffffffc0202bd6:	6946                	ld	s2,80(sp)
ffffffffc0202bd8:	69a6                	ld	s3,72(sp)
ffffffffc0202bda:	6a06                	ld	s4,64(sp)
ffffffffc0202bdc:	7ae2                	ld	s5,56(sp)
ffffffffc0202bde:	7b42                	ld	s6,48(sp)
ffffffffc0202be0:	7ba2                	ld	s7,40(sp)
ffffffffc0202be2:	7c02                	ld	s8,32(sp)
ffffffffc0202be4:	6ce2                	ld	s9,24(sp)
ffffffffc0202be6:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0202be8:	f97fe06f          	j	ffffffffc0201b7e <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0202bec:	c80007b7          	lui	a5,0xc8000
ffffffffc0202bf0:	bc7d                	j	ffffffffc02026ae <pmm_init+0x90>
        intr_disable();
ffffffffc0202bf2:	dbdfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202bf6:	000b3783          	ld	a5,0(s6)
ffffffffc0202bfa:	4505                	li	a0,1
ffffffffc0202bfc:	6f9c                	ld	a5,24(a5)
ffffffffc0202bfe:	9782                	jalr	a5
ffffffffc0202c00:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202c02:	da7fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c06:	b9a9                	j	ffffffffc0202860 <pmm_init+0x242>
        intr_disable();
ffffffffc0202c08:	da7fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202c0c:	000b3783          	ld	a5,0(s6)
ffffffffc0202c10:	4505                	li	a0,1
ffffffffc0202c12:	6f9c                	ld	a5,24(a5)
ffffffffc0202c14:	9782                	jalr	a5
ffffffffc0202c16:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202c18:	d91fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c1c:	b645                	j	ffffffffc02027bc <pmm_init+0x19e>
        intr_disable();
ffffffffc0202c1e:	d91fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202c22:	000b3783          	ld	a5,0(s6)
ffffffffc0202c26:	779c                	ld	a5,40(a5)
ffffffffc0202c28:	9782                	jalr	a5
ffffffffc0202c2a:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202c2c:	d7dfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c30:	b6b9                	j	ffffffffc020277e <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0202c32:	6705                	lui	a4,0x1
ffffffffc0202c34:	177d                	addi	a4,a4,-1
ffffffffc0202c36:	96ba                	add	a3,a3,a4
ffffffffc0202c38:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc0202c3a:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202c3e:	14a77363          	bgeu	a4,a0,ffffffffc0202d84 <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc0202c42:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc0202c46:	fff80537          	lui	a0,0xfff80
ffffffffc0202c4a:	972a                	add	a4,a4,a0
ffffffffc0202c4c:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0202c4e:	8c1d                	sub	s0,s0,a5
ffffffffc0202c50:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0202c54:	00c45593          	srli	a1,s0,0xc
ffffffffc0202c58:	9532                	add	a0,a0,a2
ffffffffc0202c5a:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202c5c:	0009b583          	ld	a1,0(s3)
}
ffffffffc0202c60:	b4c1                	j	ffffffffc0202720 <pmm_init+0x102>
        intr_disable();
ffffffffc0202c62:	d4dfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202c66:	000b3783          	ld	a5,0(s6)
ffffffffc0202c6a:	779c                	ld	a5,40(a5)
ffffffffc0202c6c:	9782                	jalr	a5
ffffffffc0202c6e:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202c70:	d39fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c74:	bb79                	j	ffffffffc0202a12 <pmm_init+0x3f4>
        intr_disable();
ffffffffc0202c76:	d39fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202c7a:	000b3783          	ld	a5,0(s6)
ffffffffc0202c7e:	779c                	ld	a5,40(a5)
ffffffffc0202c80:	9782                	jalr	a5
ffffffffc0202c82:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202c84:	d25fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c88:	b39d                	j	ffffffffc02029ee <pmm_init+0x3d0>
ffffffffc0202c8a:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202c8c:	d23fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202c90:	000b3783          	ld	a5,0(s6)
ffffffffc0202c94:	6522                	ld	a0,8(sp)
ffffffffc0202c96:	4585                	li	a1,1
ffffffffc0202c98:	739c                	ld	a5,32(a5)
ffffffffc0202c9a:	9782                	jalr	a5
        intr_enable();
ffffffffc0202c9c:	d0dfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202ca0:	b33d                	j	ffffffffc02029ce <pmm_init+0x3b0>
ffffffffc0202ca2:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202ca4:	d0bfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202ca8:	000b3783          	ld	a5,0(s6)
ffffffffc0202cac:	6522                	ld	a0,8(sp)
ffffffffc0202cae:	4585                	li	a1,1
ffffffffc0202cb0:	739c                	ld	a5,32(a5)
ffffffffc0202cb2:	9782                	jalr	a5
        intr_enable();
ffffffffc0202cb4:	cf5fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cb8:	b1dd                	j	ffffffffc020299e <pmm_init+0x380>
        intr_disable();
ffffffffc0202cba:	cf5fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202cbe:	000b3783          	ld	a5,0(s6)
ffffffffc0202cc2:	4505                	li	a0,1
ffffffffc0202cc4:	6f9c                	ld	a5,24(a5)
ffffffffc0202cc6:	9782                	jalr	a5
ffffffffc0202cc8:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202cca:	cdffd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cce:	b36d                	j	ffffffffc0202a78 <pmm_init+0x45a>
        intr_disable();
ffffffffc0202cd0:	cdffd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202cd4:	000b3783          	ld	a5,0(s6)
ffffffffc0202cd8:	779c                	ld	a5,40(a5)
ffffffffc0202cda:	9782                	jalr	a5
ffffffffc0202cdc:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202cde:	ccbfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202ce2:	bdf9                	j	ffffffffc0202bc0 <pmm_init+0x5a2>
ffffffffc0202ce4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202ce6:	cc9fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202cea:	000b3783          	ld	a5,0(s6)
ffffffffc0202cee:	6522                	ld	a0,8(sp)
ffffffffc0202cf0:	4585                	li	a1,1
ffffffffc0202cf2:	739c                	ld	a5,32(a5)
ffffffffc0202cf4:	9782                	jalr	a5
        intr_enable();
ffffffffc0202cf6:	cb3fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cfa:	b55d                	j	ffffffffc0202ba0 <pmm_init+0x582>
ffffffffc0202cfc:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202cfe:	cb1fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202d02:	000b3783          	ld	a5,0(s6)
ffffffffc0202d06:	6522                	ld	a0,8(sp)
ffffffffc0202d08:	4585                	li	a1,1
ffffffffc0202d0a:	739c                	ld	a5,32(a5)
ffffffffc0202d0c:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d0e:	c9bfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d12:	bdb9                	j	ffffffffc0202b70 <pmm_init+0x552>
        intr_disable();
ffffffffc0202d14:	c9bfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202d18:	000b3783          	ld	a5,0(s6)
ffffffffc0202d1c:	4585                	li	a1,1
ffffffffc0202d1e:	8552                	mv	a0,s4
ffffffffc0202d20:	739c                	ld	a5,32(a5)
ffffffffc0202d22:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d24:	c85fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d28:	bd29                	j	ffffffffc0202b42 <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202d2a:	86a2                	mv	a3,s0
ffffffffc0202d2c:	00004617          	auipc	a2,0x4
ffffffffc0202d30:	99c60613          	addi	a2,a2,-1636 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0202d34:	25b00593          	li	a1,603
ffffffffc0202d38:	00004517          	auipc	a0,0x4
ffffffffc0202d3c:	aa850513          	addi	a0,a0,-1368 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202d40:	f52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202d44:	00004697          	auipc	a3,0x4
ffffffffc0202d48:	f0c68693          	addi	a3,a3,-244 # ffffffffc0206c50 <default_pmm_manager+0x5c0>
ffffffffc0202d4c:	00003617          	auipc	a2,0x3
ffffffffc0202d50:	59460613          	addi	a2,a2,1428 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202d54:	25c00593          	li	a1,604
ffffffffc0202d58:	00004517          	auipc	a0,0x4
ffffffffc0202d5c:	a8850513          	addi	a0,a0,-1400 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202d60:	f32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202d64:	00004697          	auipc	a3,0x4
ffffffffc0202d68:	eac68693          	addi	a3,a3,-340 # ffffffffc0206c10 <default_pmm_manager+0x580>
ffffffffc0202d6c:	00003617          	auipc	a2,0x3
ffffffffc0202d70:	57460613          	addi	a2,a2,1396 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202d74:	25b00593          	li	a1,603
ffffffffc0202d78:	00004517          	auipc	a0,0x4
ffffffffc0202d7c:	a6850513          	addi	a0,a0,-1432 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202d80:	f12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0202d84:	fc5fe0ef          	jal	ra,ffffffffc0201d48 <pa2page.part.0>
ffffffffc0202d88:	fddfe0ef          	jal	ra,ffffffffc0201d64 <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202d8c:	00004697          	auipc	a3,0x4
ffffffffc0202d90:	c7c68693          	addi	a3,a3,-900 # ffffffffc0206a08 <default_pmm_manager+0x378>
ffffffffc0202d94:	00003617          	auipc	a2,0x3
ffffffffc0202d98:	54c60613          	addi	a2,a2,1356 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202d9c:	22b00593          	li	a1,555
ffffffffc0202da0:	00004517          	auipc	a0,0x4
ffffffffc0202da4:	a4050513          	addi	a0,a0,-1472 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202da8:	eeafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202dac:	00004697          	auipc	a3,0x4
ffffffffc0202db0:	b9c68693          	addi	a3,a3,-1124 # ffffffffc0206948 <default_pmm_manager+0x2b8>
ffffffffc0202db4:	00003617          	auipc	a2,0x3
ffffffffc0202db8:	52c60613          	addi	a2,a2,1324 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202dbc:	21e00593          	li	a1,542
ffffffffc0202dc0:	00004517          	auipc	a0,0x4
ffffffffc0202dc4:	a2050513          	addi	a0,a0,-1504 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202dc8:	ecafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202dcc:	00004697          	auipc	a3,0x4
ffffffffc0202dd0:	b3c68693          	addi	a3,a3,-1220 # ffffffffc0206908 <default_pmm_manager+0x278>
ffffffffc0202dd4:	00003617          	auipc	a2,0x3
ffffffffc0202dd8:	50c60613          	addi	a2,a2,1292 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202ddc:	21d00593          	li	a1,541
ffffffffc0202de0:	00004517          	auipc	a0,0x4
ffffffffc0202de4:	a0050513          	addi	a0,a0,-1536 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202de8:	eaafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202dec:	00004697          	auipc	a3,0x4
ffffffffc0202df0:	afc68693          	addi	a3,a3,-1284 # ffffffffc02068e8 <default_pmm_manager+0x258>
ffffffffc0202df4:	00003617          	auipc	a2,0x3
ffffffffc0202df8:	4ec60613          	addi	a2,a2,1260 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202dfc:	21c00593          	li	a1,540
ffffffffc0202e00:	00004517          	auipc	a0,0x4
ffffffffc0202e04:	9e050513          	addi	a0,a0,-1568 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202e08:	e8afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc0202e0c:	00004617          	auipc	a2,0x4
ffffffffc0202e10:	8bc60613          	addi	a2,a2,-1860 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0202e14:	07100593          	li	a1,113
ffffffffc0202e18:	00004517          	auipc	a0,0x4
ffffffffc0202e1c:	8d850513          	addi	a0,a0,-1832 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0202e20:	e72fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202e24:	00004697          	auipc	a3,0x4
ffffffffc0202e28:	d7468693          	addi	a3,a3,-652 # ffffffffc0206b98 <default_pmm_manager+0x508>
ffffffffc0202e2c:	00003617          	auipc	a2,0x3
ffffffffc0202e30:	4b460613          	addi	a2,a2,1204 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202e34:	24400593          	li	a1,580
ffffffffc0202e38:	00004517          	auipc	a0,0x4
ffffffffc0202e3c:	9a850513          	addi	a0,a0,-1624 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202e40:	e52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202e44:	00004697          	auipc	a3,0x4
ffffffffc0202e48:	d0c68693          	addi	a3,a3,-756 # ffffffffc0206b50 <default_pmm_manager+0x4c0>
ffffffffc0202e4c:	00003617          	auipc	a2,0x3
ffffffffc0202e50:	49460613          	addi	a2,a2,1172 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202e54:	24200593          	li	a1,578
ffffffffc0202e58:	00004517          	auipc	a0,0x4
ffffffffc0202e5c:	98850513          	addi	a0,a0,-1656 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202e60:	e32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 0);
ffffffffc0202e64:	00004697          	auipc	a3,0x4
ffffffffc0202e68:	d1c68693          	addi	a3,a3,-740 # ffffffffc0206b80 <default_pmm_manager+0x4f0>
ffffffffc0202e6c:	00003617          	auipc	a2,0x3
ffffffffc0202e70:	47460613          	addi	a2,a2,1140 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202e74:	24100593          	li	a1,577
ffffffffc0202e78:	00004517          	auipc	a0,0x4
ffffffffc0202e7c:	96850513          	addi	a0,a0,-1688 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202e80:	e12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc0202e84:	00004697          	auipc	a3,0x4
ffffffffc0202e88:	de468693          	addi	a3,a3,-540 # ffffffffc0206c68 <default_pmm_manager+0x5d8>
ffffffffc0202e8c:	00003617          	auipc	a2,0x3
ffffffffc0202e90:	45460613          	addi	a2,a2,1108 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202e94:	25f00593          	li	a1,607
ffffffffc0202e98:	00004517          	auipc	a0,0x4
ffffffffc0202e9c:	94850513          	addi	a0,a0,-1720 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202ea0:	df2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0202ea4:	00004697          	auipc	a3,0x4
ffffffffc0202ea8:	d2468693          	addi	a3,a3,-732 # ffffffffc0206bc8 <default_pmm_manager+0x538>
ffffffffc0202eac:	00003617          	auipc	a2,0x3
ffffffffc0202eb0:	43460613          	addi	a2,a2,1076 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202eb4:	24c00593          	li	a1,588
ffffffffc0202eb8:	00004517          	auipc	a0,0x4
ffffffffc0202ebc:	92850513          	addi	a0,a0,-1752 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202ec0:	dd2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p) == 1);
ffffffffc0202ec4:	00004697          	auipc	a3,0x4
ffffffffc0202ec8:	dfc68693          	addi	a3,a3,-516 # ffffffffc0206cc0 <default_pmm_manager+0x630>
ffffffffc0202ecc:	00003617          	auipc	a2,0x3
ffffffffc0202ed0:	41460613          	addi	a2,a2,1044 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202ed4:	26400593          	li	a1,612
ffffffffc0202ed8:	00004517          	auipc	a0,0x4
ffffffffc0202edc:	90850513          	addi	a0,a0,-1784 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202ee0:	db2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202ee4:	00004697          	auipc	a3,0x4
ffffffffc0202ee8:	d9c68693          	addi	a3,a3,-612 # ffffffffc0206c80 <default_pmm_manager+0x5f0>
ffffffffc0202eec:	00003617          	auipc	a2,0x3
ffffffffc0202ef0:	3f460613          	addi	a2,a2,1012 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202ef4:	26300593          	li	a1,611
ffffffffc0202ef8:	00004517          	auipc	a0,0x4
ffffffffc0202efc:	8e850513          	addi	a0,a0,-1816 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202f00:	d92fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202f04:	00004697          	auipc	a3,0x4
ffffffffc0202f08:	c4c68693          	addi	a3,a3,-948 # ffffffffc0206b50 <default_pmm_manager+0x4c0>
ffffffffc0202f0c:	00003617          	auipc	a2,0x3
ffffffffc0202f10:	3d460613          	addi	a2,a2,980 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202f14:	23e00593          	li	a1,574
ffffffffc0202f18:	00004517          	auipc	a0,0x4
ffffffffc0202f1c:	8c850513          	addi	a0,a0,-1848 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202f20:	d72fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0202f24:	00004697          	auipc	a3,0x4
ffffffffc0202f28:	acc68693          	addi	a3,a3,-1332 # ffffffffc02069f0 <default_pmm_manager+0x360>
ffffffffc0202f2c:	00003617          	auipc	a2,0x3
ffffffffc0202f30:	3b460613          	addi	a2,a2,948 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202f34:	23d00593          	li	a1,573
ffffffffc0202f38:	00004517          	auipc	a0,0x4
ffffffffc0202f3c:	8a850513          	addi	a0,a0,-1880 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202f40:	d52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202f44:	00004697          	auipc	a3,0x4
ffffffffc0202f48:	c2468693          	addi	a3,a3,-988 # ffffffffc0206b68 <default_pmm_manager+0x4d8>
ffffffffc0202f4c:	00003617          	auipc	a2,0x3
ffffffffc0202f50:	39460613          	addi	a2,a2,916 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202f54:	23a00593          	li	a1,570
ffffffffc0202f58:	00004517          	auipc	a0,0x4
ffffffffc0202f5c:	88850513          	addi	a0,a0,-1912 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202f60:	d32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0202f64:	00004697          	auipc	a3,0x4
ffffffffc0202f68:	a7468693          	addi	a3,a3,-1420 # ffffffffc02069d8 <default_pmm_manager+0x348>
ffffffffc0202f6c:	00003617          	auipc	a2,0x3
ffffffffc0202f70:	37460613          	addi	a2,a2,884 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202f74:	23900593          	li	a1,569
ffffffffc0202f78:	00004517          	auipc	a0,0x4
ffffffffc0202f7c:	86850513          	addi	a0,a0,-1944 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202f80:	d12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0202f84:	00004697          	auipc	a3,0x4
ffffffffc0202f88:	af468693          	addi	a3,a3,-1292 # ffffffffc0206a78 <default_pmm_manager+0x3e8>
ffffffffc0202f8c:	00003617          	auipc	a2,0x3
ffffffffc0202f90:	35460613          	addi	a2,a2,852 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202f94:	23800593          	li	a1,568
ffffffffc0202f98:	00004517          	auipc	a0,0x4
ffffffffc0202f9c:	84850513          	addi	a0,a0,-1976 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202fa0:	cf2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202fa4:	00004697          	auipc	a3,0x4
ffffffffc0202fa8:	bac68693          	addi	a3,a3,-1108 # ffffffffc0206b50 <default_pmm_manager+0x4c0>
ffffffffc0202fac:	00003617          	auipc	a2,0x3
ffffffffc0202fb0:	33460613          	addi	a2,a2,820 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202fb4:	23700593          	li	a1,567
ffffffffc0202fb8:	00004517          	auipc	a0,0x4
ffffffffc0202fbc:	82850513          	addi	a0,a0,-2008 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202fc0:	cd2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 2);
ffffffffc0202fc4:	00004697          	auipc	a3,0x4
ffffffffc0202fc8:	b7468693          	addi	a3,a3,-1164 # ffffffffc0206b38 <default_pmm_manager+0x4a8>
ffffffffc0202fcc:	00003617          	auipc	a2,0x3
ffffffffc0202fd0:	31460613          	addi	a2,a2,788 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202fd4:	23600593          	li	a1,566
ffffffffc0202fd8:	00004517          	auipc	a0,0x4
ffffffffc0202fdc:	80850513          	addi	a0,a0,-2040 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0202fe0:	cb2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc0202fe4:	00004697          	auipc	a3,0x4
ffffffffc0202fe8:	b2468693          	addi	a3,a3,-1244 # ffffffffc0206b08 <default_pmm_manager+0x478>
ffffffffc0202fec:	00003617          	auipc	a2,0x3
ffffffffc0202ff0:	2f460613          	addi	a2,a2,756 # ffffffffc02062e0 <commands+0x818>
ffffffffc0202ff4:	23500593          	li	a1,565
ffffffffc0202ff8:	00003517          	auipc	a0,0x3
ffffffffc0202ffc:	7e850513          	addi	a0,a0,2024 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203000:	c92fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 1);
ffffffffc0203004:	00004697          	auipc	a3,0x4
ffffffffc0203008:	aec68693          	addi	a3,a3,-1300 # ffffffffc0206af0 <default_pmm_manager+0x460>
ffffffffc020300c:	00003617          	auipc	a2,0x3
ffffffffc0203010:	2d460613          	addi	a2,a2,724 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203014:	23300593          	li	a1,563
ffffffffc0203018:	00003517          	auipc	a0,0x3
ffffffffc020301c:	7c850513          	addi	a0,a0,1992 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203020:	c72fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc0203024:	00004697          	auipc	a3,0x4
ffffffffc0203028:	aac68693          	addi	a3,a3,-1364 # ffffffffc0206ad0 <default_pmm_manager+0x440>
ffffffffc020302c:	00003617          	auipc	a2,0x3
ffffffffc0203030:	2b460613          	addi	a2,a2,692 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203034:	23200593          	li	a1,562
ffffffffc0203038:	00003517          	auipc	a0,0x3
ffffffffc020303c:	7a850513          	addi	a0,a0,1960 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203040:	c52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(*ptep & PTE_W);
ffffffffc0203044:	00004697          	auipc	a3,0x4
ffffffffc0203048:	a7c68693          	addi	a3,a3,-1412 # ffffffffc0206ac0 <default_pmm_manager+0x430>
ffffffffc020304c:	00003617          	auipc	a2,0x3
ffffffffc0203050:	29460613          	addi	a2,a2,660 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203054:	23100593          	li	a1,561
ffffffffc0203058:	00003517          	auipc	a0,0x3
ffffffffc020305c:	78850513          	addi	a0,a0,1928 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203060:	c32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(*ptep & PTE_U);
ffffffffc0203064:	00004697          	auipc	a3,0x4
ffffffffc0203068:	a4c68693          	addi	a3,a3,-1460 # ffffffffc0206ab0 <default_pmm_manager+0x420>
ffffffffc020306c:	00003617          	auipc	a2,0x3
ffffffffc0203070:	27460613          	addi	a2,a2,628 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203074:	23000593          	li	a1,560
ffffffffc0203078:	00003517          	auipc	a0,0x3
ffffffffc020307c:	76850513          	addi	a0,a0,1896 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203080:	c12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("DTB memory info not available");
ffffffffc0203084:	00003617          	auipc	a2,0x3
ffffffffc0203088:	7cc60613          	addi	a2,a2,1996 # ffffffffc0206850 <default_pmm_manager+0x1c0>
ffffffffc020308c:	06500593          	li	a1,101
ffffffffc0203090:	00003517          	auipc	a0,0x3
ffffffffc0203094:	75050513          	addi	a0,a0,1872 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203098:	bfafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc020309c:	00004697          	auipc	a3,0x4
ffffffffc02030a0:	b2c68693          	addi	a3,a3,-1236 # ffffffffc0206bc8 <default_pmm_manager+0x538>
ffffffffc02030a4:	00003617          	auipc	a2,0x3
ffffffffc02030a8:	23c60613          	addi	a2,a2,572 # ffffffffc02062e0 <commands+0x818>
ffffffffc02030ac:	27600593          	li	a1,630
ffffffffc02030b0:	00003517          	auipc	a0,0x3
ffffffffc02030b4:	73050513          	addi	a0,a0,1840 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02030b8:	bdafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02030bc:	00004697          	auipc	a3,0x4
ffffffffc02030c0:	9bc68693          	addi	a3,a3,-1604 # ffffffffc0206a78 <default_pmm_manager+0x3e8>
ffffffffc02030c4:	00003617          	auipc	a2,0x3
ffffffffc02030c8:	21c60613          	addi	a2,a2,540 # ffffffffc02062e0 <commands+0x818>
ffffffffc02030cc:	22f00593          	li	a1,559
ffffffffc02030d0:	00003517          	auipc	a0,0x3
ffffffffc02030d4:	71050513          	addi	a0,a0,1808 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02030d8:	bbafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc02030dc:	00004697          	auipc	a3,0x4
ffffffffc02030e0:	95c68693          	addi	a3,a3,-1700 # ffffffffc0206a38 <default_pmm_manager+0x3a8>
ffffffffc02030e4:	00003617          	auipc	a2,0x3
ffffffffc02030e8:	1fc60613          	addi	a2,a2,508 # ffffffffc02062e0 <commands+0x818>
ffffffffc02030ec:	22e00593          	li	a1,558
ffffffffc02030f0:	00003517          	auipc	a0,0x3
ffffffffc02030f4:	6f050513          	addi	a0,a0,1776 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02030f8:	b9afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc02030fc:	86d6                	mv	a3,s5
ffffffffc02030fe:	00003617          	auipc	a2,0x3
ffffffffc0203102:	5ca60613          	addi	a2,a2,1482 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0203106:	22a00593          	li	a1,554
ffffffffc020310a:	00003517          	auipc	a0,0x3
ffffffffc020310e:	6d650513          	addi	a0,a0,1750 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203112:	b80fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0203116:	00003617          	auipc	a2,0x3
ffffffffc020311a:	5b260613          	addi	a2,a2,1458 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc020311e:	22900593          	li	a1,553
ffffffffc0203122:	00003517          	auipc	a0,0x3
ffffffffc0203126:	6be50513          	addi	a0,a0,1726 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020312a:	b68fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 1);
ffffffffc020312e:	00004697          	auipc	a3,0x4
ffffffffc0203132:	8c268693          	addi	a3,a3,-1854 # ffffffffc02069f0 <default_pmm_manager+0x360>
ffffffffc0203136:	00003617          	auipc	a2,0x3
ffffffffc020313a:	1aa60613          	addi	a2,a2,426 # ffffffffc02062e0 <commands+0x818>
ffffffffc020313e:	22700593          	li	a1,551
ffffffffc0203142:	00003517          	auipc	a0,0x3
ffffffffc0203146:	69e50513          	addi	a0,a0,1694 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020314a:	b48fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc020314e:	00004697          	auipc	a3,0x4
ffffffffc0203152:	88a68693          	addi	a3,a3,-1910 # ffffffffc02069d8 <default_pmm_manager+0x348>
ffffffffc0203156:	00003617          	auipc	a2,0x3
ffffffffc020315a:	18a60613          	addi	a2,a2,394 # ffffffffc02062e0 <commands+0x818>
ffffffffc020315e:	22600593          	li	a1,550
ffffffffc0203162:	00003517          	auipc	a0,0x3
ffffffffc0203166:	67e50513          	addi	a0,a0,1662 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020316a:	b28fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc020316e:	00004697          	auipc	a3,0x4
ffffffffc0203172:	c1a68693          	addi	a3,a3,-998 # ffffffffc0206d88 <default_pmm_manager+0x6f8>
ffffffffc0203176:	00003617          	auipc	a2,0x3
ffffffffc020317a:	16a60613          	addi	a2,a2,362 # ffffffffc02062e0 <commands+0x818>
ffffffffc020317e:	26d00593          	li	a1,621
ffffffffc0203182:	00003517          	auipc	a0,0x3
ffffffffc0203186:	65e50513          	addi	a0,a0,1630 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020318a:	b08fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc020318e:	00004697          	auipc	a3,0x4
ffffffffc0203192:	bc268693          	addi	a3,a3,-1086 # ffffffffc0206d50 <default_pmm_manager+0x6c0>
ffffffffc0203196:	00003617          	auipc	a2,0x3
ffffffffc020319a:	14a60613          	addi	a2,a2,330 # ffffffffc02062e0 <commands+0x818>
ffffffffc020319e:	26a00593          	li	a1,618
ffffffffc02031a2:	00003517          	auipc	a0,0x3
ffffffffc02031a6:	63e50513          	addi	a0,a0,1598 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02031aa:	ae8fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p) == 2);
ffffffffc02031ae:	00004697          	auipc	a3,0x4
ffffffffc02031b2:	b7268693          	addi	a3,a3,-1166 # ffffffffc0206d20 <default_pmm_manager+0x690>
ffffffffc02031b6:	00003617          	auipc	a2,0x3
ffffffffc02031ba:	12a60613          	addi	a2,a2,298 # ffffffffc02062e0 <commands+0x818>
ffffffffc02031be:	26600593          	li	a1,614
ffffffffc02031c2:	00003517          	auipc	a0,0x3
ffffffffc02031c6:	61e50513          	addi	a0,a0,1566 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02031ca:	ac8fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc02031ce:	00004697          	auipc	a3,0x4
ffffffffc02031d2:	b0a68693          	addi	a3,a3,-1270 # ffffffffc0206cd8 <default_pmm_manager+0x648>
ffffffffc02031d6:	00003617          	auipc	a2,0x3
ffffffffc02031da:	10a60613          	addi	a2,a2,266 # ffffffffc02062e0 <commands+0x818>
ffffffffc02031de:	26500593          	li	a1,613
ffffffffc02031e2:	00003517          	auipc	a0,0x3
ffffffffc02031e6:	5fe50513          	addi	a0,a0,1534 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02031ea:	aa8fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc02031ee:	00003617          	auipc	a2,0x3
ffffffffc02031f2:	58260613          	addi	a2,a2,1410 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc02031f6:	0c900593          	li	a1,201
ffffffffc02031fa:	00003517          	auipc	a0,0x3
ffffffffc02031fe:	5e650513          	addi	a0,a0,1510 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203202:	a90fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0203206:	00003617          	auipc	a2,0x3
ffffffffc020320a:	56a60613          	addi	a2,a2,1386 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc020320e:	08100593          	li	a1,129
ffffffffc0203212:	00003517          	auipc	a0,0x3
ffffffffc0203216:	5ce50513          	addi	a0,a0,1486 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020321a:	a78fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc020321e:	00003697          	auipc	a3,0x3
ffffffffc0203222:	78a68693          	addi	a3,a3,1930 # ffffffffc02069a8 <default_pmm_manager+0x318>
ffffffffc0203226:	00003617          	auipc	a2,0x3
ffffffffc020322a:	0ba60613          	addi	a2,a2,186 # ffffffffc02062e0 <commands+0x818>
ffffffffc020322e:	22500593          	li	a1,549
ffffffffc0203232:	00003517          	auipc	a0,0x3
ffffffffc0203236:	5ae50513          	addi	a0,a0,1454 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020323a:	a58fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc020323e:	00003697          	auipc	a3,0x3
ffffffffc0203242:	73a68693          	addi	a3,a3,1850 # ffffffffc0206978 <default_pmm_manager+0x2e8>
ffffffffc0203246:	00003617          	auipc	a2,0x3
ffffffffc020324a:	09a60613          	addi	a2,a2,154 # ffffffffc02062e0 <commands+0x818>
ffffffffc020324e:	22200593          	li	a1,546
ffffffffc0203252:	00003517          	auipc	a0,0x3
ffffffffc0203256:	58e50513          	addi	a0,a0,1422 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020325a:	a38fd0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020325e <copy_range>:
{
ffffffffc020325e:	7119                	addi	sp,sp,-128
ffffffffc0203260:	f4a6                	sd	s1,104(sp)
ffffffffc0203262:	84b6                	mv	s1,a3
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203264:	8ed1                	or	a3,a3,a2
{
ffffffffc0203266:	fc86                	sd	ra,120(sp)
ffffffffc0203268:	f8a2                	sd	s0,112(sp)
ffffffffc020326a:	f0ca                	sd	s2,96(sp)
ffffffffc020326c:	ecce                	sd	s3,88(sp)
ffffffffc020326e:	e8d2                	sd	s4,80(sp)
ffffffffc0203270:	e4d6                	sd	s5,72(sp)
ffffffffc0203272:	e0da                	sd	s6,64(sp)
ffffffffc0203274:	fc5e                	sd	s7,56(sp)
ffffffffc0203276:	f862                	sd	s8,48(sp)
ffffffffc0203278:	f466                	sd	s9,40(sp)
ffffffffc020327a:	f06a                	sd	s10,32(sp)
ffffffffc020327c:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020327e:	16d2                	slli	a3,a3,0x34
{
ffffffffc0203280:	e43a                	sd	a4,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203282:	28069b63          	bnez	a3,ffffffffc0203518 <copy_range+0x2ba>
    assert(USER_ACCESS(start, end));
ffffffffc0203286:	00200737          	lui	a4,0x200
ffffffffc020328a:	8db2                	mv	s11,a2
ffffffffc020328c:	26e66663          	bltu	a2,a4,ffffffffc02034f8 <copy_range+0x29a>
ffffffffc0203290:	26967463          	bgeu	a2,s1,ffffffffc02034f8 <copy_range+0x29a>
ffffffffc0203294:	4705                	li	a4,1
ffffffffc0203296:	077e                	slli	a4,a4,0x1f
ffffffffc0203298:	26976063          	bltu	a4,s1,ffffffffc02034f8 <copy_range+0x29a>
ffffffffc020329c:	5c7d                	li	s8,-1
ffffffffc020329e:	8a2a                	mv	s4,a0
ffffffffc02032a0:	842e                	mv	s0,a1
        start += PGSIZE;
ffffffffc02032a2:	6985                	lui	s3,0x1
    if (PPN(pa) >= npage)
ffffffffc02032a4:	000c4b97          	auipc	s7,0xc4
ffffffffc02032a8:	8fcb8b93          	addi	s7,s7,-1796 # ffffffffc02c6ba0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02032ac:	000c4b17          	auipc	s6,0xc4
ffffffffc02032b0:	8fcb0b13          	addi	s6,s6,-1796 # ffffffffc02c6ba8 <pages>
    return KADDR(page2pa(page));
ffffffffc02032b4:	00cc5c13          	srli	s8,s8,0xc
        page = pmm_manager->alloc_pages(n);
ffffffffc02032b8:	000c4a97          	auipc	s5,0xc4
ffffffffc02032bc:	8f8a8a93          	addi	s5,s5,-1800 # ffffffffc02c6bb0 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02032c0:	4601                	li	a2,0
ffffffffc02032c2:	85ee                	mv	a1,s11
ffffffffc02032c4:	8522                	mv	a0,s0
ffffffffc02032c6:	b73fe0ef          	jal	ra,ffffffffc0201e38 <get_pte>
ffffffffc02032ca:	892a                	mv	s2,a0
        if (ptep == NULL)
ffffffffc02032cc:	c179                	beqz	a0,ffffffffc0203392 <copy_range+0x134>
        if (*ptep & PTE_V)
ffffffffc02032ce:	6118                	ld	a4,0(a0)
ffffffffc02032d0:	8b05                	andi	a4,a4,1
ffffffffc02032d2:	e705                	bnez	a4,ffffffffc02032fa <copy_range+0x9c>
        start += PGSIZE;
ffffffffc02032d4:	9dce                	add	s11,s11,s3
    } while (start != 0 && start < end);
ffffffffc02032d6:	fe9de5e3          	bltu	s11,s1,ffffffffc02032c0 <copy_range+0x62>
    return 0;
ffffffffc02032da:	4501                	li	a0,0
}
ffffffffc02032dc:	70e6                	ld	ra,120(sp)
ffffffffc02032de:	7446                	ld	s0,112(sp)
ffffffffc02032e0:	74a6                	ld	s1,104(sp)
ffffffffc02032e2:	7906                	ld	s2,96(sp)
ffffffffc02032e4:	69e6                	ld	s3,88(sp)
ffffffffc02032e6:	6a46                	ld	s4,80(sp)
ffffffffc02032e8:	6aa6                	ld	s5,72(sp)
ffffffffc02032ea:	6b06                	ld	s6,64(sp)
ffffffffc02032ec:	7be2                	ld	s7,56(sp)
ffffffffc02032ee:	7c42                	ld	s8,48(sp)
ffffffffc02032f0:	7ca2                	ld	s9,40(sp)
ffffffffc02032f2:	7d02                	ld	s10,32(sp)
ffffffffc02032f4:	6de2                	ld	s11,24(sp)
ffffffffc02032f6:	6109                	addi	sp,sp,128
ffffffffc02032f8:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc02032fa:	4605                	li	a2,1
ffffffffc02032fc:	85ee                	mv	a1,s11
ffffffffc02032fe:	8552                	mv	a0,s4
ffffffffc0203300:	b39fe0ef          	jal	ra,ffffffffc0201e38 <get_pte>
ffffffffc0203304:	14050363          	beqz	a0,ffffffffc020344a <copy_range+0x1ec>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0203308:	00093703          	ld	a4,0(s2)
    if (!(pte & PTE_V))
ffffffffc020330c:	00177693          	andi	a3,a4,1
ffffffffc0203310:	0007091b          	sext.w	s2,a4
ffffffffc0203314:	14068963          	beqz	a3,ffffffffc0203466 <copy_range+0x208>
    if (PPN(pa) >= npage)
ffffffffc0203318:	000bb683          	ld	a3,0(s7)
    return pa2page(PTE_ADDR(pte));
ffffffffc020331c:	070a                	slli	a4,a4,0x2
ffffffffc020331e:	8331                	srli	a4,a4,0xc
    if (PPN(pa) >= npage)
ffffffffc0203320:	12d77763          	bgeu	a4,a3,ffffffffc020344e <copy_range+0x1f0>
    return &pages[PPN(pa) - nbase];
ffffffffc0203324:	000b3583          	ld	a1,0(s6)
ffffffffc0203328:	fff807b7          	lui	a5,0xfff80
ffffffffc020332c:	973e                	add	a4,a4,a5
ffffffffc020332e:	071a                	slli	a4,a4,0x6
ffffffffc0203330:	00e58d33          	add	s10,a1,a4
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203334:	10002773          	csrr	a4,sstatus
ffffffffc0203338:	8b09                	andi	a4,a4,2
ffffffffc020333a:	e375                	bnez	a4,ffffffffc020341e <copy_range+0x1c0>
        page = pmm_manager->alloc_pages(n);
ffffffffc020333c:	000ab703          	ld	a4,0(s5)
ffffffffc0203340:	4505                	li	a0,1
ffffffffc0203342:	6f18                	ld	a4,24(a4)
ffffffffc0203344:	9702                	jalr	a4
ffffffffc0203346:	8caa                	mv	s9,a0
            assert(page != NULL);
ffffffffc0203348:	160d0863          	beqz	s10,ffffffffc02034b8 <copy_range+0x25a>
            assert(npage != NULL);
ffffffffc020334c:	140c8663          	beqz	s9,ffffffffc0203498 <copy_range+0x23a>
            if (share) {
ffffffffc0203350:	67a2                	ld	a5,8(sp)
ffffffffc0203352:	cfa9                	beqz	a5,ffffffffc02033ac <copy_range+0x14e>
                page_insert(from, page, start, perm & ~PTE_W);
ffffffffc0203354:	01b97913          	andi	s2,s2,27
ffffffffc0203358:	86ca                	mv	a3,s2
ffffffffc020335a:	866e                	mv	a2,s11
ffffffffc020335c:	85ea                	mv	a1,s10
ffffffffc020335e:	8522                	mv	a0,s0
ffffffffc0203360:	9c8ff0ef          	jal	ra,ffffffffc0202528 <page_insert>
                ret = page_insert(to, page, start, perm & ~PTE_W);
ffffffffc0203364:	86ca                	mv	a3,s2
ffffffffc0203366:	866e                	mv	a2,s11
ffffffffc0203368:	85ea                	mv	a1,s10
ffffffffc020336a:	8552                	mv	a0,s4
ffffffffc020336c:	9bcff0ef          	jal	ra,ffffffffc0202528 <page_insert>
            assert(ret == 0);
ffffffffc0203370:	d135                	beqz	a0,ffffffffc02032d4 <copy_range+0x76>
ffffffffc0203372:	00004697          	auipc	a3,0x4
ffffffffc0203376:	a7e68693          	addi	a3,a3,-1410 # ffffffffc0206df0 <default_pmm_manager+0x760>
ffffffffc020337a:	00003617          	auipc	a2,0x3
ffffffffc020337e:	f6660613          	addi	a2,a2,-154 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203382:	1ba00593          	li	a1,442
ffffffffc0203386:	00003517          	auipc	a0,0x3
ffffffffc020338a:	45a50513          	addi	a0,a0,1114 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc020338e:	904fd0ef          	jal	ra,ffffffffc0200492 <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0203392:	00200637          	lui	a2,0x200
ffffffffc0203396:	00cd87b3          	add	a5,s11,a2
ffffffffc020339a:	ffe00637          	lui	a2,0xffe00
ffffffffc020339e:	00c7fdb3          	and	s11,a5,a2
    } while (start != 0 && start < end);
ffffffffc02033a2:	f20d8ce3          	beqz	s11,ffffffffc02032da <copy_range+0x7c>
ffffffffc02033a6:	f09dede3          	bltu	s11,s1,ffffffffc02032c0 <copy_range+0x62>
ffffffffc02033aa:	bf05                	j	ffffffffc02032da <copy_range+0x7c>
ffffffffc02033ac:	10002773          	csrr	a4,sstatus
ffffffffc02033b0:	8b09                	andi	a4,a4,2
ffffffffc02033b2:	e349                	bnez	a4,ffffffffc0203434 <copy_range+0x1d6>
        page = pmm_manager->alloc_pages(n);
ffffffffc02033b4:	000ab703          	ld	a4,0(s5)
ffffffffc02033b8:	4505                	li	a0,1
ffffffffc02033ba:	6f18                	ld	a4,24(a4)
ffffffffc02033bc:	9702                	jalr	a4
ffffffffc02033be:	8caa                	mv	s9,a0
                assert(npage != NULL);
ffffffffc02033c0:	100c8c63          	beqz	s9,ffffffffc02034d8 <copy_range+0x27a>
    return page - pages + nbase;
ffffffffc02033c4:	000b3703          	ld	a4,0(s6)
ffffffffc02033c8:	000808b7          	lui	a7,0x80
    return KADDR(page2pa(page));
ffffffffc02033cc:	000bb603          	ld	a2,0(s7)
    return page - pages + nbase;
ffffffffc02033d0:	40ed06b3          	sub	a3,s10,a4
ffffffffc02033d4:	8699                	srai	a3,a3,0x6
ffffffffc02033d6:	96c6                	add	a3,a3,a7
    return KADDR(page2pa(page));
ffffffffc02033d8:	0186f5b3          	and	a1,a3,s8
    return page2ppn(page) << PGSHIFT;
ffffffffc02033dc:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02033de:	0ac5f163          	bgeu	a1,a2,ffffffffc0203480 <copy_range+0x222>
    return page - pages + nbase;
ffffffffc02033e2:	40ec8733          	sub	a4,s9,a4
    return KADDR(page2pa(page));
ffffffffc02033e6:	000c3797          	auipc	a5,0xc3
ffffffffc02033ea:	7d278793          	addi	a5,a5,2002 # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc02033ee:	6388                	ld	a0,0(a5)
    return page - pages + nbase;
ffffffffc02033f0:	8719                	srai	a4,a4,0x6
ffffffffc02033f2:	9746                	add	a4,a4,a7
    return KADDR(page2pa(page));
ffffffffc02033f4:	018778b3          	and	a7,a4,s8
ffffffffc02033f8:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc02033fc:	0732                	slli	a4,a4,0xc
    return KADDR(page2pa(page));
ffffffffc02033fe:	08c8f063          	bgeu	a7,a2,ffffffffc020347e <copy_range+0x220>
                memcpy((void *)dst_kvaddr, (void *)src_kvaddr, PGSIZE);
ffffffffc0203402:	6605                	lui	a2,0x1
ffffffffc0203404:	953a                	add	a0,a0,a4
ffffffffc0203406:	43c020ef          	jal	ra,ffffffffc0205842 <memcpy>
                ret = page_insert(to, npage, start, perm);
ffffffffc020340a:	01f97693          	andi	a3,s2,31
ffffffffc020340e:	866e                	mv	a2,s11
ffffffffc0203410:	85e6                	mv	a1,s9
ffffffffc0203412:	8552                	mv	a0,s4
ffffffffc0203414:	914ff0ef          	jal	ra,ffffffffc0202528 <page_insert>
            assert(ret == 0);
ffffffffc0203418:	ea050ee3          	beqz	a0,ffffffffc02032d4 <copy_range+0x76>
ffffffffc020341c:	bf99                	j	ffffffffc0203372 <copy_range+0x114>
        intr_disable();
ffffffffc020341e:	d90fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203422:	000ab703          	ld	a4,0(s5)
ffffffffc0203426:	4505                	li	a0,1
ffffffffc0203428:	6f18                	ld	a4,24(a4)
ffffffffc020342a:	9702                	jalr	a4
ffffffffc020342c:	8caa                	mv	s9,a0
        intr_enable();
ffffffffc020342e:	d7afd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0203432:	bf19                	j	ffffffffc0203348 <copy_range+0xea>
        intr_disable();
ffffffffc0203434:	d7afd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0203438:	000ab703          	ld	a4,0(s5)
ffffffffc020343c:	4505                	li	a0,1
ffffffffc020343e:	6f18                	ld	a4,24(a4)
ffffffffc0203440:	9702                	jalr	a4
ffffffffc0203442:	8caa                	mv	s9,a0
        intr_enable();
ffffffffc0203444:	d64fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0203448:	bfa5                	j	ffffffffc02033c0 <copy_range+0x162>
                return -E_NO_MEM;
ffffffffc020344a:	5571                	li	a0,-4
ffffffffc020344c:	bd41                	j	ffffffffc02032dc <copy_range+0x7e>
        panic("pa2page called with invalid pa");
ffffffffc020344e:	00003617          	auipc	a2,0x3
ffffffffc0203452:	34a60613          	addi	a2,a2,842 # ffffffffc0206798 <default_pmm_manager+0x108>
ffffffffc0203456:	06900593          	li	a1,105
ffffffffc020345a:	00003517          	auipc	a0,0x3
ffffffffc020345e:	29650513          	addi	a0,a0,662 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0203462:	830fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0203466:	00003617          	auipc	a2,0x3
ffffffffc020346a:	35260613          	addi	a2,a2,850 # ffffffffc02067b8 <default_pmm_manager+0x128>
ffffffffc020346e:	07f00593          	li	a1,127
ffffffffc0203472:	00003517          	auipc	a0,0x3
ffffffffc0203476:	27e50513          	addi	a0,a0,638 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc020347a:	818fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc020347e:	86ba                	mv	a3,a4
ffffffffc0203480:	00003617          	auipc	a2,0x3
ffffffffc0203484:	24860613          	addi	a2,a2,584 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0203488:	07100593          	li	a1,113
ffffffffc020348c:	00003517          	auipc	a0,0x3
ffffffffc0203490:	26450513          	addi	a0,a0,612 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0203494:	ffffc0ef          	jal	ra,ffffffffc0200492 <__panic>
            assert(npage != NULL);
ffffffffc0203498:	00004697          	auipc	a3,0x4
ffffffffc020349c:	94868693          	addi	a3,a3,-1720 # ffffffffc0206de0 <default_pmm_manager+0x750>
ffffffffc02034a0:	00003617          	auipc	a2,0x3
ffffffffc02034a4:	e4060613          	addi	a2,a2,-448 # ffffffffc02062e0 <commands+0x818>
ffffffffc02034a8:	19700593          	li	a1,407
ffffffffc02034ac:	00003517          	auipc	a0,0x3
ffffffffc02034b0:	33450513          	addi	a0,a0,820 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02034b4:	fdffc0ef          	jal	ra,ffffffffc0200492 <__panic>
            assert(page != NULL);
ffffffffc02034b8:	00004697          	auipc	a3,0x4
ffffffffc02034bc:	91868693          	addi	a3,a3,-1768 # ffffffffc0206dd0 <default_pmm_manager+0x740>
ffffffffc02034c0:	00003617          	auipc	a2,0x3
ffffffffc02034c4:	e2060613          	addi	a2,a2,-480 # ffffffffc02062e0 <commands+0x818>
ffffffffc02034c8:	19600593          	li	a1,406
ffffffffc02034cc:	00003517          	auipc	a0,0x3
ffffffffc02034d0:	31450513          	addi	a0,a0,788 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02034d4:	fbffc0ef          	jal	ra,ffffffffc0200492 <__panic>
                assert(npage != NULL);
ffffffffc02034d8:	00004697          	auipc	a3,0x4
ffffffffc02034dc:	90868693          	addi	a3,a3,-1784 # ffffffffc0206de0 <default_pmm_manager+0x750>
ffffffffc02034e0:	00003617          	auipc	a2,0x3
ffffffffc02034e4:	e0060613          	addi	a2,a2,-512 # ffffffffc02062e0 <commands+0x818>
ffffffffc02034e8:	1b300593          	li	a1,435
ffffffffc02034ec:	00003517          	auipc	a0,0x3
ffffffffc02034f0:	2f450513          	addi	a0,a0,756 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02034f4:	f9ffc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02034f8:	00003697          	auipc	a3,0x3
ffffffffc02034fc:	32868693          	addi	a3,a3,808 # ffffffffc0206820 <default_pmm_manager+0x190>
ffffffffc0203500:	00003617          	auipc	a2,0x3
ffffffffc0203504:	de060613          	addi	a2,a2,-544 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203508:	17e00593          	li	a1,382
ffffffffc020350c:	00003517          	auipc	a0,0x3
ffffffffc0203510:	2d450513          	addi	a0,a0,724 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203514:	f7ffc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203518:	00003697          	auipc	a3,0x3
ffffffffc020351c:	2d868693          	addi	a3,a3,728 # ffffffffc02067f0 <default_pmm_manager+0x160>
ffffffffc0203520:	00003617          	auipc	a2,0x3
ffffffffc0203524:	dc060613          	addi	a2,a2,-576 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203528:	17d00593          	li	a1,381
ffffffffc020352c:	00003517          	auipc	a0,0x3
ffffffffc0203530:	2b450513          	addi	a0,a0,692 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc0203534:	f5ffc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203538 <pgdir_alloc_page>:
{
ffffffffc0203538:	7179                	addi	sp,sp,-48
ffffffffc020353a:	ec26                	sd	s1,24(sp)
ffffffffc020353c:	e84a                	sd	s2,16(sp)
ffffffffc020353e:	e052                	sd	s4,0(sp)
ffffffffc0203540:	f406                	sd	ra,40(sp)
ffffffffc0203542:	f022                	sd	s0,32(sp)
ffffffffc0203544:	e44e                	sd	s3,8(sp)
ffffffffc0203546:	8a2a                	mv	s4,a0
ffffffffc0203548:	84ae                	mv	s1,a1
ffffffffc020354a:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020354c:	100027f3          	csrr	a5,sstatus
ffffffffc0203550:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc0203552:	000c3997          	auipc	s3,0xc3
ffffffffc0203556:	65e98993          	addi	s3,s3,1630 # ffffffffc02c6bb0 <pmm_manager>
ffffffffc020355a:	ef8d                	bnez	a5,ffffffffc0203594 <pgdir_alloc_page+0x5c>
ffffffffc020355c:	0009b783          	ld	a5,0(s3)
ffffffffc0203560:	4505                	li	a0,1
ffffffffc0203562:	6f9c                	ld	a5,24(a5)
ffffffffc0203564:	9782                	jalr	a5
ffffffffc0203566:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc0203568:	cc09                	beqz	s0,ffffffffc0203582 <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc020356a:	86ca                	mv	a3,s2
ffffffffc020356c:	8626                	mv	a2,s1
ffffffffc020356e:	85a2                	mv	a1,s0
ffffffffc0203570:	8552                	mv	a0,s4
ffffffffc0203572:	fb7fe0ef          	jal	ra,ffffffffc0202528 <page_insert>
ffffffffc0203576:	e915                	bnez	a0,ffffffffc02035aa <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc0203578:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc020357a:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc020357c:	4785                	li	a5,1
ffffffffc020357e:	04f71e63          	bne	a4,a5,ffffffffc02035da <pgdir_alloc_page+0xa2>
}
ffffffffc0203582:	70a2                	ld	ra,40(sp)
ffffffffc0203584:	8522                	mv	a0,s0
ffffffffc0203586:	7402                	ld	s0,32(sp)
ffffffffc0203588:	64e2                	ld	s1,24(sp)
ffffffffc020358a:	6942                	ld	s2,16(sp)
ffffffffc020358c:	69a2                	ld	s3,8(sp)
ffffffffc020358e:	6a02                	ld	s4,0(sp)
ffffffffc0203590:	6145                	addi	sp,sp,48
ffffffffc0203592:	8082                	ret
        intr_disable();
ffffffffc0203594:	c1afd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203598:	0009b783          	ld	a5,0(s3)
ffffffffc020359c:	4505                	li	a0,1
ffffffffc020359e:	6f9c                	ld	a5,24(a5)
ffffffffc02035a0:	9782                	jalr	a5
ffffffffc02035a2:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02035a4:	c04fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02035a8:	b7c1                	j	ffffffffc0203568 <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02035aa:	100027f3          	csrr	a5,sstatus
ffffffffc02035ae:	8b89                	andi	a5,a5,2
ffffffffc02035b0:	eb89                	bnez	a5,ffffffffc02035c2 <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc02035b2:	0009b783          	ld	a5,0(s3)
ffffffffc02035b6:	8522                	mv	a0,s0
ffffffffc02035b8:	4585                	li	a1,1
ffffffffc02035ba:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc02035bc:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc02035be:	9782                	jalr	a5
    if (flag)
ffffffffc02035c0:	b7c9                	j	ffffffffc0203582 <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc02035c2:	becfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02035c6:	0009b783          	ld	a5,0(s3)
ffffffffc02035ca:	8522                	mv	a0,s0
ffffffffc02035cc:	4585                	li	a1,1
ffffffffc02035ce:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc02035d0:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc02035d2:	9782                	jalr	a5
        intr_enable();
ffffffffc02035d4:	bd4fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02035d8:	b76d                	j	ffffffffc0203582 <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc02035da:	00004697          	auipc	a3,0x4
ffffffffc02035de:	82668693          	addi	a3,a3,-2010 # ffffffffc0206e00 <default_pmm_manager+0x770>
ffffffffc02035e2:	00003617          	auipc	a2,0x3
ffffffffc02035e6:	cfe60613          	addi	a2,a2,-770 # ffffffffc02062e0 <commands+0x818>
ffffffffc02035ea:	20300593          	li	a1,515
ffffffffc02035ee:	00003517          	auipc	a0,0x3
ffffffffc02035f2:	1f250513          	addi	a0,a0,498 # ffffffffc02067e0 <default_pmm_manager+0x150>
ffffffffc02035f6:	e9dfc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02035fa <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02035fa:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc02035fc:	00004697          	auipc	a3,0x4
ffffffffc0203600:	81c68693          	addi	a3,a3,-2020 # ffffffffc0206e18 <default_pmm_manager+0x788>
ffffffffc0203604:	00003617          	auipc	a2,0x3
ffffffffc0203608:	cdc60613          	addi	a2,a2,-804 # ffffffffc02062e0 <commands+0x818>
ffffffffc020360c:	07400593          	li	a1,116
ffffffffc0203610:	00004517          	auipc	a0,0x4
ffffffffc0203614:	82850513          	addi	a0,a0,-2008 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc0203618:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc020361a:	e79fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020361e <mm_create>:
{
ffffffffc020361e:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203620:	04000513          	li	a0,64
{
ffffffffc0203624:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203626:	d7cfe0ef          	jal	ra,ffffffffc0201ba2 <kmalloc>
    if (mm != NULL)
ffffffffc020362a:	cd19                	beqz	a0,ffffffffc0203648 <mm_create+0x2a>
    elm->prev = elm->next = elm;
ffffffffc020362c:	e508                	sd	a0,8(a0)
ffffffffc020362e:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203630:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0203634:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0203638:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc020363c:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc0203640:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc0203644:	02053c23          	sd	zero,56(a0)
}
ffffffffc0203648:	60a2                	ld	ra,8(sp)
ffffffffc020364a:	0141                	addi	sp,sp,16
ffffffffc020364c:	8082                	ret

ffffffffc020364e <find_vma>:
{
ffffffffc020364e:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc0203650:	c505                	beqz	a0,ffffffffc0203678 <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0203652:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0203654:	c501                	beqz	a0,ffffffffc020365c <find_vma+0xe>
ffffffffc0203656:	651c                	ld	a5,8(a0)
ffffffffc0203658:	02f5f263          	bgeu	a1,a5,ffffffffc020367c <find_vma+0x2e>
    return listelm->next;
ffffffffc020365c:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc020365e:	00f68d63          	beq	a3,a5,ffffffffc0203678 <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc0203662:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203666:	00e5e663          	bltu	a1,a4,ffffffffc0203672 <find_vma+0x24>
ffffffffc020366a:	ff07b703          	ld	a4,-16(a5)
ffffffffc020366e:	00e5ec63          	bltu	a1,a4,ffffffffc0203686 <find_vma+0x38>
ffffffffc0203672:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc0203674:	fef697e3          	bne	a3,a5,ffffffffc0203662 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc0203678:	4501                	li	a0,0
}
ffffffffc020367a:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc020367c:	691c                	ld	a5,16(a0)
ffffffffc020367e:	fcf5ffe3          	bgeu	a1,a5,ffffffffc020365c <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0203682:	ea88                	sd	a0,16(a3)
ffffffffc0203684:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc0203686:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc020368a:	ea88                	sd	a0,16(a3)
ffffffffc020368c:	8082                	ret

ffffffffc020368e <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc020368e:	6590                	ld	a2,8(a1)
ffffffffc0203690:	0105b803          	ld	a6,16(a1)
{
ffffffffc0203694:	1141                	addi	sp,sp,-16
ffffffffc0203696:	e406                	sd	ra,8(sp)
ffffffffc0203698:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc020369a:	01066763          	bltu	a2,a6,ffffffffc02036a8 <insert_vma_struct+0x1a>
ffffffffc020369e:	a085                	j	ffffffffc02036fe <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc02036a0:	fe87b703          	ld	a4,-24(a5)
ffffffffc02036a4:	04e66863          	bltu	a2,a4,ffffffffc02036f4 <insert_vma_struct+0x66>
ffffffffc02036a8:	86be                	mv	a3,a5
ffffffffc02036aa:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc02036ac:	fef51ae3          	bne	a0,a5,ffffffffc02036a0 <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc02036b0:	02a68463          	beq	a3,a0,ffffffffc02036d8 <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc02036b4:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc02036b8:	fe86b883          	ld	a7,-24(a3)
ffffffffc02036bc:	08e8f163          	bgeu	a7,a4,ffffffffc020373e <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02036c0:	04e66f63          	bltu	a2,a4,ffffffffc020371e <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc02036c4:	00f50a63          	beq	a0,a5,ffffffffc02036d8 <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc02036c8:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc02036cc:	05076963          	bltu	a4,a6,ffffffffc020371e <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc02036d0:	ff07b603          	ld	a2,-16(a5)
ffffffffc02036d4:	02c77363          	bgeu	a4,a2,ffffffffc02036fa <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc02036d8:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc02036da:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc02036dc:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc02036e0:	e390                	sd	a2,0(a5)
ffffffffc02036e2:	e690                	sd	a2,8(a3)
}
ffffffffc02036e4:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc02036e6:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc02036e8:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc02036ea:	0017079b          	addiw	a5,a4,1
ffffffffc02036ee:	d11c                	sw	a5,32(a0)
}
ffffffffc02036f0:	0141                	addi	sp,sp,16
ffffffffc02036f2:	8082                	ret
    if (le_prev != list)
ffffffffc02036f4:	fca690e3          	bne	a3,a0,ffffffffc02036b4 <insert_vma_struct+0x26>
ffffffffc02036f8:	bfd1                	j	ffffffffc02036cc <insert_vma_struct+0x3e>
ffffffffc02036fa:	f01ff0ef          	jal	ra,ffffffffc02035fa <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc02036fe:	00003697          	auipc	a3,0x3
ffffffffc0203702:	74a68693          	addi	a3,a3,1866 # ffffffffc0206e48 <default_pmm_manager+0x7b8>
ffffffffc0203706:	00003617          	auipc	a2,0x3
ffffffffc020370a:	bda60613          	addi	a2,a2,-1062 # ffffffffc02062e0 <commands+0x818>
ffffffffc020370e:	07a00593          	li	a1,122
ffffffffc0203712:	00003517          	auipc	a0,0x3
ffffffffc0203716:	72650513          	addi	a0,a0,1830 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc020371a:	d79fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc020371e:	00003697          	auipc	a3,0x3
ffffffffc0203722:	76a68693          	addi	a3,a3,1898 # ffffffffc0206e88 <default_pmm_manager+0x7f8>
ffffffffc0203726:	00003617          	auipc	a2,0x3
ffffffffc020372a:	bba60613          	addi	a2,a2,-1094 # ffffffffc02062e0 <commands+0x818>
ffffffffc020372e:	07300593          	li	a1,115
ffffffffc0203732:	00003517          	auipc	a0,0x3
ffffffffc0203736:	70650513          	addi	a0,a0,1798 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc020373a:	d59fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc020373e:	00003697          	auipc	a3,0x3
ffffffffc0203742:	72a68693          	addi	a3,a3,1834 # ffffffffc0206e68 <default_pmm_manager+0x7d8>
ffffffffc0203746:	00003617          	auipc	a2,0x3
ffffffffc020374a:	b9a60613          	addi	a2,a2,-1126 # ffffffffc02062e0 <commands+0x818>
ffffffffc020374e:	07200593          	li	a1,114
ffffffffc0203752:	00003517          	auipc	a0,0x3
ffffffffc0203756:	6e650513          	addi	a0,a0,1766 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc020375a:	d39fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020375e <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc020375e:	591c                	lw	a5,48(a0)
{
ffffffffc0203760:	1141                	addi	sp,sp,-16
ffffffffc0203762:	e406                	sd	ra,8(sp)
ffffffffc0203764:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0203766:	e78d                	bnez	a5,ffffffffc0203790 <mm_destroy+0x32>
ffffffffc0203768:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc020376a:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc020376c:	00a40c63          	beq	s0,a0,ffffffffc0203784 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203770:	6118                	ld	a4,0(a0)
ffffffffc0203772:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc0203774:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc0203776:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc0203778:	e398                	sd	a4,0(a5)
ffffffffc020377a:	cd8fe0ef          	jal	ra,ffffffffc0201c52 <kfree>
    return listelm->next;
ffffffffc020377e:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc0203780:	fea418e3          	bne	s0,a0,ffffffffc0203770 <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc0203784:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc0203786:	6402                	ld	s0,0(sp)
ffffffffc0203788:	60a2                	ld	ra,8(sp)
ffffffffc020378a:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc020378c:	cc6fe06f          	j	ffffffffc0201c52 <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0203790:	00003697          	auipc	a3,0x3
ffffffffc0203794:	71868693          	addi	a3,a3,1816 # ffffffffc0206ea8 <default_pmm_manager+0x818>
ffffffffc0203798:	00003617          	auipc	a2,0x3
ffffffffc020379c:	b4860613          	addi	a2,a2,-1208 # ffffffffc02062e0 <commands+0x818>
ffffffffc02037a0:	09e00593          	li	a1,158
ffffffffc02037a4:	00003517          	auipc	a0,0x3
ffffffffc02037a8:	69450513          	addi	a0,a0,1684 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc02037ac:	ce7fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02037b0 <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc02037b0:	7139                	addi	sp,sp,-64
ffffffffc02037b2:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02037b4:	6405                	lui	s0,0x1
ffffffffc02037b6:	147d                	addi	s0,s0,-1
ffffffffc02037b8:	77fd                	lui	a5,0xfffff
ffffffffc02037ba:	9622                	add	a2,a2,s0
ffffffffc02037bc:	962e                	add	a2,a2,a1
{
ffffffffc02037be:	f426                	sd	s1,40(sp)
ffffffffc02037c0:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc02037c2:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc02037c6:	f04a                	sd	s2,32(sp)
ffffffffc02037c8:	ec4e                	sd	s3,24(sp)
ffffffffc02037ca:	e852                	sd	s4,16(sp)
ffffffffc02037cc:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc02037ce:	002005b7          	lui	a1,0x200
ffffffffc02037d2:	00f67433          	and	s0,a2,a5
ffffffffc02037d6:	06b4e363          	bltu	s1,a1,ffffffffc020383c <mm_map+0x8c>
ffffffffc02037da:	0684f163          	bgeu	s1,s0,ffffffffc020383c <mm_map+0x8c>
ffffffffc02037de:	4785                	li	a5,1
ffffffffc02037e0:	07fe                	slli	a5,a5,0x1f
ffffffffc02037e2:	0487ed63          	bltu	a5,s0,ffffffffc020383c <mm_map+0x8c>
ffffffffc02037e6:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc02037e8:	cd21                	beqz	a0,ffffffffc0203840 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc02037ea:	85a6                	mv	a1,s1
ffffffffc02037ec:	8ab6                	mv	s5,a3
ffffffffc02037ee:	8a3a                	mv	s4,a4
ffffffffc02037f0:	e5fff0ef          	jal	ra,ffffffffc020364e <find_vma>
ffffffffc02037f4:	c501                	beqz	a0,ffffffffc02037fc <mm_map+0x4c>
ffffffffc02037f6:	651c                	ld	a5,8(a0)
ffffffffc02037f8:	0487e263          	bltu	a5,s0,ffffffffc020383c <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02037fc:	03000513          	li	a0,48
ffffffffc0203800:	ba2fe0ef          	jal	ra,ffffffffc0201ba2 <kmalloc>
ffffffffc0203804:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc0203806:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc0203808:	02090163          	beqz	s2,ffffffffc020382a <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc020380c:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc020380e:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc0203812:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc0203816:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc020381a:	85ca                	mv	a1,s2
ffffffffc020381c:	e73ff0ef          	jal	ra,ffffffffc020368e <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc0203820:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc0203822:	000a0463          	beqz	s4,ffffffffc020382a <mm_map+0x7a>
        *vma_store = vma;
ffffffffc0203826:	012a3023          	sd	s2,0(s4)

out:
    return ret;
}
ffffffffc020382a:	70e2                	ld	ra,56(sp)
ffffffffc020382c:	7442                	ld	s0,48(sp)
ffffffffc020382e:	74a2                	ld	s1,40(sp)
ffffffffc0203830:	7902                	ld	s2,32(sp)
ffffffffc0203832:	69e2                	ld	s3,24(sp)
ffffffffc0203834:	6a42                	ld	s4,16(sp)
ffffffffc0203836:	6aa2                	ld	s5,8(sp)
ffffffffc0203838:	6121                	addi	sp,sp,64
ffffffffc020383a:	8082                	ret
        return -E_INVAL;
ffffffffc020383c:	5575                	li	a0,-3
ffffffffc020383e:	b7f5                	j	ffffffffc020382a <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc0203840:	00003697          	auipc	a3,0x3
ffffffffc0203844:	68068693          	addi	a3,a3,1664 # ffffffffc0206ec0 <default_pmm_manager+0x830>
ffffffffc0203848:	00003617          	auipc	a2,0x3
ffffffffc020384c:	a9860613          	addi	a2,a2,-1384 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203850:	0b300593          	li	a1,179
ffffffffc0203854:	00003517          	auipc	a0,0x3
ffffffffc0203858:	5e450513          	addi	a0,a0,1508 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc020385c:	c37fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203860 <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc0203860:	7139                	addi	sp,sp,-64
ffffffffc0203862:	fc06                	sd	ra,56(sp)
ffffffffc0203864:	f822                	sd	s0,48(sp)
ffffffffc0203866:	f426                	sd	s1,40(sp)
ffffffffc0203868:	f04a                	sd	s2,32(sp)
ffffffffc020386a:	ec4e                	sd	s3,24(sp)
ffffffffc020386c:	e852                	sd	s4,16(sp)
ffffffffc020386e:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0203870:	c52d                	beqz	a0,ffffffffc02038da <dup_mmap+0x7a>
ffffffffc0203872:	892a                	mv	s2,a0
ffffffffc0203874:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0203876:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc0203878:	e595                	bnez	a1,ffffffffc02038a4 <dup_mmap+0x44>
ffffffffc020387a:	a085                	j	ffffffffc02038da <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc020387c:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc020387e:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_matrix_out_size+0x1f38f8>
        vma->vm_end = vm_end;
ffffffffc0203882:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc0203886:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc020388a:	e05ff0ef          	jal	ra,ffffffffc020368e <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc020388e:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8f48>
ffffffffc0203892:	fe843603          	ld	a2,-24(s0)
ffffffffc0203896:	6c8c                	ld	a1,24(s1)
ffffffffc0203898:	01893503          	ld	a0,24(s2)
ffffffffc020389c:	4701                	li	a4,0
ffffffffc020389e:	9c1ff0ef          	jal	ra,ffffffffc020325e <copy_range>
ffffffffc02038a2:	e105                	bnez	a0,ffffffffc02038c2 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc02038a4:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc02038a6:	02848863          	beq	s1,s0,ffffffffc02038d6 <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02038aa:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc02038ae:	fe843a83          	ld	s5,-24(s0)
ffffffffc02038b2:	ff043a03          	ld	s4,-16(s0)
ffffffffc02038b6:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02038ba:	ae8fe0ef          	jal	ra,ffffffffc0201ba2 <kmalloc>
ffffffffc02038be:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc02038c0:	fd55                	bnez	a0,ffffffffc020387c <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc02038c2:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc02038c4:	70e2                	ld	ra,56(sp)
ffffffffc02038c6:	7442                	ld	s0,48(sp)
ffffffffc02038c8:	74a2                	ld	s1,40(sp)
ffffffffc02038ca:	7902                	ld	s2,32(sp)
ffffffffc02038cc:	69e2                	ld	s3,24(sp)
ffffffffc02038ce:	6a42                	ld	s4,16(sp)
ffffffffc02038d0:	6aa2                	ld	s5,8(sp)
ffffffffc02038d2:	6121                	addi	sp,sp,64
ffffffffc02038d4:	8082                	ret
    return 0;
ffffffffc02038d6:	4501                	li	a0,0
ffffffffc02038d8:	b7f5                	j	ffffffffc02038c4 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc02038da:	00003697          	auipc	a3,0x3
ffffffffc02038de:	5f668693          	addi	a3,a3,1526 # ffffffffc0206ed0 <default_pmm_manager+0x840>
ffffffffc02038e2:	00003617          	auipc	a2,0x3
ffffffffc02038e6:	9fe60613          	addi	a2,a2,-1538 # ffffffffc02062e0 <commands+0x818>
ffffffffc02038ea:	0cf00593          	li	a1,207
ffffffffc02038ee:	00003517          	auipc	a0,0x3
ffffffffc02038f2:	54a50513          	addi	a0,a0,1354 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc02038f6:	b9dfc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02038fa <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc02038fa:	1101                	addi	sp,sp,-32
ffffffffc02038fc:	ec06                	sd	ra,24(sp)
ffffffffc02038fe:	e822                	sd	s0,16(sp)
ffffffffc0203900:	e426                	sd	s1,8(sp)
ffffffffc0203902:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0203904:	c531                	beqz	a0,ffffffffc0203950 <exit_mmap+0x56>
ffffffffc0203906:	591c                	lw	a5,48(a0)
ffffffffc0203908:	84aa                	mv	s1,a0
ffffffffc020390a:	e3b9                	bnez	a5,ffffffffc0203950 <exit_mmap+0x56>
    return listelm->next;
ffffffffc020390c:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc020390e:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc0203912:	02850663          	beq	a0,s0,ffffffffc020393e <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0203916:	ff043603          	ld	a2,-16(s0)
ffffffffc020391a:	fe843583          	ld	a1,-24(s0)
ffffffffc020391e:	854a                	mv	a0,s2
ffffffffc0203920:	f94fe0ef          	jal	ra,ffffffffc02020b4 <unmap_range>
ffffffffc0203924:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc0203926:	fe8498e3          	bne	s1,s0,ffffffffc0203916 <exit_mmap+0x1c>
ffffffffc020392a:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc020392c:	00848c63          	beq	s1,s0,ffffffffc0203944 <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc0203930:	ff043603          	ld	a2,-16(s0)
ffffffffc0203934:	fe843583          	ld	a1,-24(s0)
ffffffffc0203938:	854a                	mv	a0,s2
ffffffffc020393a:	8c1fe0ef          	jal	ra,ffffffffc02021fa <exit_range>
ffffffffc020393e:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc0203940:	fe8498e3          	bne	s1,s0,ffffffffc0203930 <exit_mmap+0x36>
    }
}
ffffffffc0203944:	60e2                	ld	ra,24(sp)
ffffffffc0203946:	6442                	ld	s0,16(sp)
ffffffffc0203948:	64a2                	ld	s1,8(sp)
ffffffffc020394a:	6902                	ld	s2,0(sp)
ffffffffc020394c:	6105                	addi	sp,sp,32
ffffffffc020394e:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0203950:	00003697          	auipc	a3,0x3
ffffffffc0203954:	5a068693          	addi	a3,a3,1440 # ffffffffc0206ef0 <default_pmm_manager+0x860>
ffffffffc0203958:	00003617          	auipc	a2,0x3
ffffffffc020395c:	98860613          	addi	a2,a2,-1656 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203960:	0e800593          	li	a1,232
ffffffffc0203964:	00003517          	auipc	a0,0x3
ffffffffc0203968:	4d450513          	addi	a0,a0,1236 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc020396c:	b27fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203970 <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc0203970:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203972:	04000513          	li	a0,64
{
ffffffffc0203976:	fc06                	sd	ra,56(sp)
ffffffffc0203978:	f822                	sd	s0,48(sp)
ffffffffc020397a:	f426                	sd	s1,40(sp)
ffffffffc020397c:	f04a                	sd	s2,32(sp)
ffffffffc020397e:	ec4e                	sd	s3,24(sp)
ffffffffc0203980:	e852                	sd	s4,16(sp)
ffffffffc0203982:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203984:	a1efe0ef          	jal	ra,ffffffffc0201ba2 <kmalloc>
    if (mm != NULL)
ffffffffc0203988:	2e050663          	beqz	a0,ffffffffc0203c74 <vmm_init+0x304>
ffffffffc020398c:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc020398e:	e508                	sd	a0,8(a0)
ffffffffc0203990:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203992:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0203996:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc020399a:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc020399e:	02053423          	sd	zero,40(a0)
ffffffffc02039a2:	02052823          	sw	zero,48(a0)
ffffffffc02039a6:	02053c23          	sd	zero,56(a0)
ffffffffc02039aa:	03200413          	li	s0,50
ffffffffc02039ae:	a811                	j	ffffffffc02039c2 <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc02039b0:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc02039b2:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc02039b4:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc02039b8:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc02039ba:	8526                	mv	a0,s1
ffffffffc02039bc:	cd3ff0ef          	jal	ra,ffffffffc020368e <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc02039c0:	c80d                	beqz	s0,ffffffffc02039f2 <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02039c2:	03000513          	li	a0,48
ffffffffc02039c6:	9dcfe0ef          	jal	ra,ffffffffc0201ba2 <kmalloc>
ffffffffc02039ca:	85aa                	mv	a1,a0
ffffffffc02039cc:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc02039d0:	f165                	bnez	a0,ffffffffc02039b0 <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc02039d2:	00003697          	auipc	a3,0x3
ffffffffc02039d6:	6b668693          	addi	a3,a3,1718 # ffffffffc0207088 <default_pmm_manager+0x9f8>
ffffffffc02039da:	00003617          	auipc	a2,0x3
ffffffffc02039de:	90660613          	addi	a2,a2,-1786 # ffffffffc02062e0 <commands+0x818>
ffffffffc02039e2:	12c00593          	li	a1,300
ffffffffc02039e6:	00003517          	auipc	a0,0x3
ffffffffc02039ea:	45250513          	addi	a0,a0,1106 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc02039ee:	aa5fc0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc02039f2:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc02039f6:	1f900913          	li	s2,505
ffffffffc02039fa:	a819                	j	ffffffffc0203a10 <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc02039fc:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc02039fe:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203a00:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a04:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203a06:	8526                	mv	a0,s1
ffffffffc0203a08:	c87ff0ef          	jal	ra,ffffffffc020368e <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203a0c:	03240a63          	beq	s0,s2,ffffffffc0203a40 <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203a10:	03000513          	li	a0,48
ffffffffc0203a14:	98efe0ef          	jal	ra,ffffffffc0201ba2 <kmalloc>
ffffffffc0203a18:	85aa                	mv	a1,a0
ffffffffc0203a1a:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203a1e:	fd79                	bnez	a0,ffffffffc02039fc <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc0203a20:	00003697          	auipc	a3,0x3
ffffffffc0203a24:	66868693          	addi	a3,a3,1640 # ffffffffc0207088 <default_pmm_manager+0x9f8>
ffffffffc0203a28:	00003617          	auipc	a2,0x3
ffffffffc0203a2c:	8b860613          	addi	a2,a2,-1864 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203a30:	13300593          	li	a1,307
ffffffffc0203a34:	00003517          	auipc	a0,0x3
ffffffffc0203a38:	40450513          	addi	a0,a0,1028 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203a3c:	a57fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return listelm->next;
ffffffffc0203a40:	649c                	ld	a5,8(s1)
ffffffffc0203a42:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc0203a44:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc0203a48:	16f48663          	beq	s1,a5,ffffffffc0203bb4 <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203a4c:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd383f8>
ffffffffc0203a50:	ffe70693          	addi	a3,a4,-2 # 1ffffe <_binary_obj___user_matrix_out_size+0x1f38ee>
ffffffffc0203a54:	10d61063          	bne	a2,a3,ffffffffc0203b54 <vmm_init+0x1e4>
ffffffffc0203a58:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203a5c:	0ed71c63          	bne	a4,a3,ffffffffc0203b54 <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0203a60:	0715                	addi	a4,a4,5
ffffffffc0203a62:	679c                	ld	a5,8(a5)
ffffffffc0203a64:	feb712e3          	bne	a4,a1,ffffffffc0203a48 <vmm_init+0xd8>
ffffffffc0203a68:	4a1d                	li	s4,7
ffffffffc0203a6a:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203a6c:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0203a70:	85a2                	mv	a1,s0
ffffffffc0203a72:	8526                	mv	a0,s1
ffffffffc0203a74:	bdbff0ef          	jal	ra,ffffffffc020364e <find_vma>
ffffffffc0203a78:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc0203a7a:	16050d63          	beqz	a0,ffffffffc0203bf4 <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0203a7e:	00140593          	addi	a1,s0,1
ffffffffc0203a82:	8526                	mv	a0,s1
ffffffffc0203a84:	bcbff0ef          	jal	ra,ffffffffc020364e <find_vma>
ffffffffc0203a88:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc0203a8a:	14050563          	beqz	a0,ffffffffc0203bd4 <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0203a8e:	85d2                	mv	a1,s4
ffffffffc0203a90:	8526                	mv	a0,s1
ffffffffc0203a92:	bbdff0ef          	jal	ra,ffffffffc020364e <find_vma>
        assert(vma3 == NULL);
ffffffffc0203a96:	16051f63          	bnez	a0,ffffffffc0203c14 <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc0203a9a:	00340593          	addi	a1,s0,3
ffffffffc0203a9e:	8526                	mv	a0,s1
ffffffffc0203aa0:	bafff0ef          	jal	ra,ffffffffc020364e <find_vma>
        assert(vma4 == NULL);
ffffffffc0203aa4:	1a051863          	bnez	a0,ffffffffc0203c54 <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc0203aa8:	00440593          	addi	a1,s0,4
ffffffffc0203aac:	8526                	mv	a0,s1
ffffffffc0203aae:	ba1ff0ef          	jal	ra,ffffffffc020364e <find_vma>
        assert(vma5 == NULL);
ffffffffc0203ab2:	18051163          	bnez	a0,ffffffffc0203c34 <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203ab6:	00893783          	ld	a5,8(s2)
ffffffffc0203aba:	0a879d63          	bne	a5,s0,ffffffffc0203b74 <vmm_init+0x204>
ffffffffc0203abe:	01093783          	ld	a5,16(s2)
ffffffffc0203ac2:	0b479963          	bne	a5,s4,ffffffffc0203b74 <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203ac6:	0089b783          	ld	a5,8(s3)
ffffffffc0203aca:	0c879563          	bne	a5,s0,ffffffffc0203b94 <vmm_init+0x224>
ffffffffc0203ace:	0109b783          	ld	a5,16(s3)
ffffffffc0203ad2:	0d479163          	bne	a5,s4,ffffffffc0203b94 <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203ad6:	0415                	addi	s0,s0,5
ffffffffc0203ad8:	0a15                	addi	s4,s4,5
ffffffffc0203ada:	f9541be3          	bne	s0,s5,ffffffffc0203a70 <vmm_init+0x100>
ffffffffc0203ade:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc0203ae0:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc0203ae2:	85a2                	mv	a1,s0
ffffffffc0203ae4:	8526                	mv	a0,s1
ffffffffc0203ae6:	b69ff0ef          	jal	ra,ffffffffc020364e <find_vma>
ffffffffc0203aea:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc0203aee:	c90d                	beqz	a0,ffffffffc0203b20 <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc0203af0:	6914                	ld	a3,16(a0)
ffffffffc0203af2:	6510                	ld	a2,8(a0)
ffffffffc0203af4:	00003517          	auipc	a0,0x3
ffffffffc0203af8:	51c50513          	addi	a0,a0,1308 # ffffffffc0207010 <default_pmm_manager+0x980>
ffffffffc0203afc:	e9cfc0ef          	jal	ra,ffffffffc0200198 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0203b00:	00003697          	auipc	a3,0x3
ffffffffc0203b04:	53868693          	addi	a3,a3,1336 # ffffffffc0207038 <default_pmm_manager+0x9a8>
ffffffffc0203b08:	00002617          	auipc	a2,0x2
ffffffffc0203b0c:	7d860613          	addi	a2,a2,2008 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203b10:	15900593          	li	a1,345
ffffffffc0203b14:	00003517          	auipc	a0,0x3
ffffffffc0203b18:	32450513          	addi	a0,a0,804 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203b1c:	977fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0203b20:	147d                	addi	s0,s0,-1
ffffffffc0203b22:	fd2410e3          	bne	s0,s2,ffffffffc0203ae2 <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc0203b26:	8526                	mv	a0,s1
ffffffffc0203b28:	c37ff0ef          	jal	ra,ffffffffc020375e <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0203b2c:	00003517          	auipc	a0,0x3
ffffffffc0203b30:	52450513          	addi	a0,a0,1316 # ffffffffc0207050 <default_pmm_manager+0x9c0>
ffffffffc0203b34:	e64fc0ef          	jal	ra,ffffffffc0200198 <cprintf>
}
ffffffffc0203b38:	7442                	ld	s0,48(sp)
ffffffffc0203b3a:	70e2                	ld	ra,56(sp)
ffffffffc0203b3c:	74a2                	ld	s1,40(sp)
ffffffffc0203b3e:	7902                	ld	s2,32(sp)
ffffffffc0203b40:	69e2                	ld	s3,24(sp)
ffffffffc0203b42:	6a42                	ld	s4,16(sp)
ffffffffc0203b44:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203b46:	00003517          	auipc	a0,0x3
ffffffffc0203b4a:	52a50513          	addi	a0,a0,1322 # ffffffffc0207070 <default_pmm_manager+0x9e0>
}
ffffffffc0203b4e:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203b50:	e48fc06f          	j	ffffffffc0200198 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203b54:	00003697          	auipc	a3,0x3
ffffffffc0203b58:	3d468693          	addi	a3,a3,980 # ffffffffc0206f28 <default_pmm_manager+0x898>
ffffffffc0203b5c:	00002617          	auipc	a2,0x2
ffffffffc0203b60:	78460613          	addi	a2,a2,1924 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203b64:	13d00593          	li	a1,317
ffffffffc0203b68:	00003517          	auipc	a0,0x3
ffffffffc0203b6c:	2d050513          	addi	a0,a0,720 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203b70:	923fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203b74:	00003697          	auipc	a3,0x3
ffffffffc0203b78:	43c68693          	addi	a3,a3,1084 # ffffffffc0206fb0 <default_pmm_manager+0x920>
ffffffffc0203b7c:	00002617          	auipc	a2,0x2
ffffffffc0203b80:	76460613          	addi	a2,a2,1892 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203b84:	14e00593          	li	a1,334
ffffffffc0203b88:	00003517          	auipc	a0,0x3
ffffffffc0203b8c:	2b050513          	addi	a0,a0,688 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203b90:	903fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203b94:	00003697          	auipc	a3,0x3
ffffffffc0203b98:	44c68693          	addi	a3,a3,1100 # ffffffffc0206fe0 <default_pmm_manager+0x950>
ffffffffc0203b9c:	00002617          	auipc	a2,0x2
ffffffffc0203ba0:	74460613          	addi	a2,a2,1860 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203ba4:	14f00593          	li	a1,335
ffffffffc0203ba8:	00003517          	auipc	a0,0x3
ffffffffc0203bac:	29050513          	addi	a0,a0,656 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203bb0:	8e3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc0203bb4:	00003697          	auipc	a3,0x3
ffffffffc0203bb8:	35c68693          	addi	a3,a3,860 # ffffffffc0206f10 <default_pmm_manager+0x880>
ffffffffc0203bbc:	00002617          	auipc	a2,0x2
ffffffffc0203bc0:	72460613          	addi	a2,a2,1828 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203bc4:	13b00593          	li	a1,315
ffffffffc0203bc8:	00003517          	auipc	a0,0x3
ffffffffc0203bcc:	27050513          	addi	a0,a0,624 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203bd0:	8c3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma2 != NULL);
ffffffffc0203bd4:	00003697          	auipc	a3,0x3
ffffffffc0203bd8:	39c68693          	addi	a3,a3,924 # ffffffffc0206f70 <default_pmm_manager+0x8e0>
ffffffffc0203bdc:	00002617          	auipc	a2,0x2
ffffffffc0203be0:	70460613          	addi	a2,a2,1796 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203be4:	14600593          	li	a1,326
ffffffffc0203be8:	00003517          	auipc	a0,0x3
ffffffffc0203bec:	25050513          	addi	a0,a0,592 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203bf0:	8a3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma1 != NULL);
ffffffffc0203bf4:	00003697          	auipc	a3,0x3
ffffffffc0203bf8:	36c68693          	addi	a3,a3,876 # ffffffffc0206f60 <default_pmm_manager+0x8d0>
ffffffffc0203bfc:	00002617          	auipc	a2,0x2
ffffffffc0203c00:	6e460613          	addi	a2,a2,1764 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203c04:	14400593          	li	a1,324
ffffffffc0203c08:	00003517          	auipc	a0,0x3
ffffffffc0203c0c:	23050513          	addi	a0,a0,560 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203c10:	883fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma3 == NULL);
ffffffffc0203c14:	00003697          	auipc	a3,0x3
ffffffffc0203c18:	36c68693          	addi	a3,a3,876 # ffffffffc0206f80 <default_pmm_manager+0x8f0>
ffffffffc0203c1c:	00002617          	auipc	a2,0x2
ffffffffc0203c20:	6c460613          	addi	a2,a2,1732 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203c24:	14800593          	li	a1,328
ffffffffc0203c28:	00003517          	auipc	a0,0x3
ffffffffc0203c2c:	21050513          	addi	a0,a0,528 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203c30:	863fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma5 == NULL);
ffffffffc0203c34:	00003697          	auipc	a3,0x3
ffffffffc0203c38:	36c68693          	addi	a3,a3,876 # ffffffffc0206fa0 <default_pmm_manager+0x910>
ffffffffc0203c3c:	00002617          	auipc	a2,0x2
ffffffffc0203c40:	6a460613          	addi	a2,a2,1700 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203c44:	14c00593          	li	a1,332
ffffffffc0203c48:	00003517          	auipc	a0,0x3
ffffffffc0203c4c:	1f050513          	addi	a0,a0,496 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203c50:	843fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma4 == NULL);
ffffffffc0203c54:	00003697          	auipc	a3,0x3
ffffffffc0203c58:	33c68693          	addi	a3,a3,828 # ffffffffc0206f90 <default_pmm_manager+0x900>
ffffffffc0203c5c:	00002617          	auipc	a2,0x2
ffffffffc0203c60:	68460613          	addi	a2,a2,1668 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203c64:	14a00593          	li	a1,330
ffffffffc0203c68:	00003517          	auipc	a0,0x3
ffffffffc0203c6c:	1d050513          	addi	a0,a0,464 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203c70:	823fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(mm != NULL);
ffffffffc0203c74:	00003697          	auipc	a3,0x3
ffffffffc0203c78:	24c68693          	addi	a3,a3,588 # ffffffffc0206ec0 <default_pmm_manager+0x830>
ffffffffc0203c7c:	00002617          	auipc	a2,0x2
ffffffffc0203c80:	66460613          	addi	a2,a2,1636 # ffffffffc02062e0 <commands+0x818>
ffffffffc0203c84:	12400593          	li	a1,292
ffffffffc0203c88:	00003517          	auipc	a0,0x3
ffffffffc0203c8c:	1b050513          	addi	a0,a0,432 # ffffffffc0206e38 <default_pmm_manager+0x7a8>
ffffffffc0203c90:	803fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203c94 <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0203c94:	7179                	addi	sp,sp,-48
ffffffffc0203c96:	f022                	sd	s0,32(sp)
ffffffffc0203c98:	f406                	sd	ra,40(sp)
ffffffffc0203c9a:	ec26                	sd	s1,24(sp)
ffffffffc0203c9c:	e84a                	sd	s2,16(sp)
ffffffffc0203c9e:	e44e                	sd	s3,8(sp)
ffffffffc0203ca0:	e052                	sd	s4,0(sp)
ffffffffc0203ca2:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc0203ca4:	c135                	beqz	a0,ffffffffc0203d08 <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc0203ca6:	002007b7          	lui	a5,0x200
ffffffffc0203caa:	04f5e663          	bltu	a1,a5,ffffffffc0203cf6 <user_mem_check+0x62>
ffffffffc0203cae:	00c584b3          	add	s1,a1,a2
ffffffffc0203cb2:	0495f263          	bgeu	a1,s1,ffffffffc0203cf6 <user_mem_check+0x62>
ffffffffc0203cb6:	4785                	li	a5,1
ffffffffc0203cb8:	07fe                	slli	a5,a5,0x1f
ffffffffc0203cba:	0297ee63          	bltu	a5,s1,ffffffffc0203cf6 <user_mem_check+0x62>
ffffffffc0203cbe:	892a                	mv	s2,a0
ffffffffc0203cc0:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203cc2:	6a05                	lui	s4,0x1
ffffffffc0203cc4:	a821                	j	ffffffffc0203cdc <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203cc6:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203cca:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203ccc:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203cce:	c685                	beqz	a3,ffffffffc0203cf6 <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203cd0:	c399                	beqz	a5,ffffffffc0203cd6 <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203cd2:	02e46263          	bltu	s0,a4,ffffffffc0203cf6 <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0203cd6:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc0203cd8:	04947663          	bgeu	s0,s1,ffffffffc0203d24 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc0203cdc:	85a2                	mv	a1,s0
ffffffffc0203cde:	854a                	mv	a0,s2
ffffffffc0203ce0:	96fff0ef          	jal	ra,ffffffffc020364e <find_vma>
ffffffffc0203ce4:	c909                	beqz	a0,ffffffffc0203cf6 <user_mem_check+0x62>
ffffffffc0203ce6:	6518                	ld	a4,8(a0)
ffffffffc0203ce8:	00e46763          	bltu	s0,a4,ffffffffc0203cf6 <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203cec:	4d1c                	lw	a5,24(a0)
ffffffffc0203cee:	fc099ce3          	bnez	s3,ffffffffc0203cc6 <user_mem_check+0x32>
ffffffffc0203cf2:	8b85                	andi	a5,a5,1
ffffffffc0203cf4:	f3ed                	bnez	a5,ffffffffc0203cd6 <user_mem_check+0x42>
            return 0;
ffffffffc0203cf6:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc0203cf8:	70a2                	ld	ra,40(sp)
ffffffffc0203cfa:	7402                	ld	s0,32(sp)
ffffffffc0203cfc:	64e2                	ld	s1,24(sp)
ffffffffc0203cfe:	6942                	ld	s2,16(sp)
ffffffffc0203d00:	69a2                	ld	s3,8(sp)
ffffffffc0203d02:	6a02                	ld	s4,0(sp)
ffffffffc0203d04:	6145                	addi	sp,sp,48
ffffffffc0203d06:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203d08:	c02007b7          	lui	a5,0xc0200
ffffffffc0203d0c:	4501                	li	a0,0
ffffffffc0203d0e:	fef5e5e3          	bltu	a1,a5,ffffffffc0203cf8 <user_mem_check+0x64>
ffffffffc0203d12:	962e                	add	a2,a2,a1
ffffffffc0203d14:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203cf8 <user_mem_check+0x64>
ffffffffc0203d18:	c8000537          	lui	a0,0xc8000
ffffffffc0203d1c:	0505                	addi	a0,a0,1
ffffffffc0203d1e:	00a63533          	sltu	a0,a2,a0
ffffffffc0203d22:	bfd9                	j	ffffffffc0203cf8 <user_mem_check+0x64>
        return 1;
ffffffffc0203d24:	4505                	li	a0,1
ffffffffc0203d26:	bfc9                	j	ffffffffc0203cf8 <user_mem_check+0x64>

ffffffffc0203d28 <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203d28:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203d2a:	9402                	jalr	s0

	jal do_exit
ffffffffc0203d2c:	580000ef          	jal	ra,ffffffffc02042ac <do_exit>

ffffffffc0203d30 <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203d30:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203d32:	14800513          	li	a0,328
{
ffffffffc0203d36:	e022                	sd	s0,0(sp)
ffffffffc0203d38:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203d3a:	e69fd0ef          	jal	ra,ffffffffc0201ba2 <kmalloc>
ffffffffc0203d3e:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203d40:	cd35                	beqz	a0,ffffffffc0203dbc <alloc_proc+0x8c>
         *       struct trapframe *tf;                       // Trap frame for current interrupt
         *       uintptr_t pgdir;                            // the base addr of Page Directroy Table(PDT)（页目录表的基地址）
         *       uint32_t flags;                             // Process flag
         *       char name[PROC_NAME_LEN + 1];               // Process name
         */
        proc->state = PROC_UNINIT;
ffffffffc0203d42:	57fd                	li	a5,-1
ffffffffc0203d44:	1782                	slli	a5,a5,0x20
ffffffffc0203d46:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203d48:	07000613          	li	a2,112
ffffffffc0203d4c:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc0203d4e:	00052423          	sw	zero,8(a0) # ffffffffc8000008 <end+0x7d39418>
        proc->kstack = 0;
ffffffffc0203d52:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203d56:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc0203d5a:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc0203d5e:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203d62:	03050513          	addi	a0,a0,48
ffffffffc0203d66:	2cb010ef          	jal	ra,ffffffffc0205830 <memset>
        proc->tf = NULL;
        proc->pgdir = boot_pgdir_pa;
ffffffffc0203d6a:	000c3797          	auipc	a5,0xc3
ffffffffc0203d6e:	e267b783          	ld	a5,-474(a5) # ffffffffc02c6b90 <boot_pgdir_pa>
ffffffffc0203d72:	f45c                	sd	a5,168(s0)
        proc->tf = NULL;
ffffffffc0203d74:	0a043023          	sd	zero,160(s0)
        proc->flags = 0;
ffffffffc0203d78:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN);
ffffffffc0203d7c:	463d                	li	a2,15
ffffffffc0203d7e:	4581                	li	a1,0
ffffffffc0203d80:	0b440513          	addi	a0,s0,180
ffffffffc0203d84:	2ad010ef          	jal	ra,ffffffffc0205830 <memset>
         *       skew_heap_entry_t lab6_run_pool;            // entry in the run pool (lab6 stride)
         *       uint32_t lab6_stride;                       // stride value (lab6 stride)
         *       uint32_t lab6_priority;                     // priority value (lab6 stride)
         */
        proc->rq = NULL;              // 初始化运行队列为空
        list_init(&(proc->run_link)); // 初始化运行队列的指针
ffffffffc0203d88:	11040793          	addi	a5,s0,272
        proc->wait_state = 0;
ffffffffc0203d8c:	0e042623          	sw	zero,236(s0)
        proc->cptr = NULL;
ffffffffc0203d90:	0e043823          	sd	zero,240(s0)
        proc->yptr = NULL;
ffffffffc0203d94:	0e043c23          	sd	zero,248(s0)
        proc->optr = NULL;
ffffffffc0203d98:	10043023          	sd	zero,256(s0)
        proc->rq = NULL;              // 初始化运行队列为空
ffffffffc0203d9c:	10043423          	sd	zero,264(s0)
    elm->prev = elm->next = elm;
ffffffffc0203da0:	10f43c23          	sd	a5,280(s0)
ffffffffc0203da4:	10f43823          	sd	a5,272(s0)
        proc->time_slice = 0;
ffffffffc0203da8:	12042023          	sw	zero,288(s0)
        proc->lab6_run_pool.left = NULL;
        proc->lab6_run_pool.right = NULL;
        proc->lab6_run_pool.parent = NULL;
ffffffffc0203dac:	12043423          	sd	zero,296(s0)
        proc->lab6_run_pool.left = NULL;
ffffffffc0203db0:	12043823          	sd	zero,304(s0)
        proc->lab6_run_pool.right = NULL;
ffffffffc0203db4:	12043c23          	sd	zero,312(s0)
        proc->lab6_stride = 0;
ffffffffc0203db8:	14043023          	sd	zero,320(s0)
        proc->lab6_priority = 0;
    }
    return proc;
}
ffffffffc0203dbc:	60a2                	ld	ra,8(sp)
ffffffffc0203dbe:	8522                	mv	a0,s0
ffffffffc0203dc0:	6402                	ld	s0,0(sp)
ffffffffc0203dc2:	0141                	addi	sp,sp,16
ffffffffc0203dc4:	8082                	ret

ffffffffc0203dc6 <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203dc6:	000c3797          	auipc	a5,0xc3
ffffffffc0203dca:	dfa7b783          	ld	a5,-518(a5) # ffffffffc02c6bc0 <current>
ffffffffc0203dce:	73c8                	ld	a0,160(a5)
ffffffffc0203dd0:	8eefd06f          	j	ffffffffc0200ebe <forkrets>

ffffffffc0203dd4 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203dd4:	6d14                	ld	a3,24(a0)
}

// put_pgdir - free the memory space of PDT
static void
put_pgdir(struct mm_struct *mm)
{
ffffffffc0203dd6:	1141                	addi	sp,sp,-16
ffffffffc0203dd8:	e406                	sd	ra,8(sp)
ffffffffc0203dda:	c02007b7          	lui	a5,0xc0200
ffffffffc0203dde:	02f6ee63          	bltu	a3,a5,ffffffffc0203e1a <put_pgdir+0x46>
ffffffffc0203de2:	000c3517          	auipc	a0,0xc3
ffffffffc0203de6:	dd653503          	ld	a0,-554(a0) # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc0203dea:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203dec:	82b1                	srli	a3,a3,0xc
ffffffffc0203dee:	000c3797          	auipc	a5,0xc3
ffffffffc0203df2:	db27b783          	ld	a5,-590(a5) # ffffffffc02c6ba0 <npage>
ffffffffc0203df6:	02f6fe63          	bgeu	a3,a5,ffffffffc0203e32 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203dfa:	00004517          	auipc	a0,0x4
ffffffffc0203dfe:	34653503          	ld	a0,838(a0) # ffffffffc0208140 <nbase>
    free_page(kva2page(mm->pgdir));
}
ffffffffc0203e02:	60a2                	ld	ra,8(sp)
ffffffffc0203e04:	8e89                	sub	a3,a3,a0
ffffffffc0203e06:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203e08:	000c3517          	auipc	a0,0xc3
ffffffffc0203e0c:	da053503          	ld	a0,-608(a0) # ffffffffc02c6ba8 <pages>
ffffffffc0203e10:	4585                	li	a1,1
ffffffffc0203e12:	9536                	add	a0,a0,a3
}
ffffffffc0203e14:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203e16:	fa9fd06f          	j	ffffffffc0201dbe <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203e1a:	00003617          	auipc	a2,0x3
ffffffffc0203e1e:	95660613          	addi	a2,a2,-1706 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc0203e22:	07700593          	li	a1,119
ffffffffc0203e26:	00003517          	auipc	a0,0x3
ffffffffc0203e2a:	8ca50513          	addi	a0,a0,-1846 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0203e2e:	e64fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203e32:	00003617          	auipc	a2,0x3
ffffffffc0203e36:	96660613          	addi	a2,a2,-1690 # ffffffffc0206798 <default_pmm_manager+0x108>
ffffffffc0203e3a:	06900593          	li	a1,105
ffffffffc0203e3e:	00003517          	auipc	a0,0x3
ffffffffc0203e42:	8b250513          	addi	a0,a0,-1870 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0203e46:	e4cfc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203e4a <proc_run>:
{
ffffffffc0203e4a:	7179                	addi	sp,sp,-48
ffffffffc0203e4c:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203e4e:	000c3917          	auipc	s2,0xc3
ffffffffc0203e52:	d7290913          	addi	s2,s2,-654 # ffffffffc02c6bc0 <current>
{
ffffffffc0203e56:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203e58:	00093483          	ld	s1,0(s2)
{
ffffffffc0203e5c:	f406                	sd	ra,40(sp)
ffffffffc0203e5e:	e84e                	sd	s3,16(sp)
    if (proc != current)
ffffffffc0203e60:	02a48863          	beq	s1,a0,ffffffffc0203e90 <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203e64:	100027f3          	csrr	a5,sstatus
ffffffffc0203e68:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203e6a:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203e6c:	ef9d                	bnez	a5,ffffffffc0203eaa <proc_run+0x60>
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203e6e:	755c                	ld	a5,168(a0)
ffffffffc0203e70:	577d                	li	a4,-1
ffffffffc0203e72:	177e                	slli	a4,a4,0x3f
ffffffffc0203e74:	83b1                	srli	a5,a5,0xc
            current = proc;
ffffffffc0203e76:	00a93023          	sd	a0,0(s2)
ffffffffc0203e7a:	8fd9                	or	a5,a5,a4
ffffffffc0203e7c:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(proc->context));
ffffffffc0203e80:	03050593          	addi	a1,a0,48
ffffffffc0203e84:	03048513          	addi	a0,s1,48
ffffffffc0203e88:	0c4010ef          	jal	ra,ffffffffc0204f4c <switch_to>
    if (flag)
ffffffffc0203e8c:	00099863          	bnez	s3,ffffffffc0203e9c <proc_run+0x52>
}
ffffffffc0203e90:	70a2                	ld	ra,40(sp)
ffffffffc0203e92:	7482                	ld	s1,32(sp)
ffffffffc0203e94:	6962                	ld	s2,24(sp)
ffffffffc0203e96:	69c2                	ld	s3,16(sp)
ffffffffc0203e98:	6145                	addi	sp,sp,48
ffffffffc0203e9a:	8082                	ret
ffffffffc0203e9c:	70a2                	ld	ra,40(sp)
ffffffffc0203e9e:	7482                	ld	s1,32(sp)
ffffffffc0203ea0:	6962                	ld	s2,24(sp)
ffffffffc0203ea2:	69c2                	ld	s3,16(sp)
ffffffffc0203ea4:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203ea6:	b03fc06f          	j	ffffffffc02009a8 <intr_enable>
ffffffffc0203eaa:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203eac:	b03fc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0203eb0:	6522                	ld	a0,8(sp)
ffffffffc0203eb2:	4985                	li	s3,1
ffffffffc0203eb4:	bf6d                	j	ffffffffc0203e6e <proc_run+0x24>

ffffffffc0203eb6 <do_fork>:
 * @clone_flags: used to guide how to clone the child process
 * @stack:       the parent's user stack pointer. if stack==0, It means to fork a kernel thread.
 * @tf:          the trapframe info, which will be copied to child process's proc->tf
 */
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
{
ffffffffc0203eb6:	7119                	addi	sp,sp,-128
ffffffffc0203eb8:	f0ca                	sd	s2,96(sp)
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS)
ffffffffc0203eba:	000c3917          	auipc	s2,0xc3
ffffffffc0203ebe:	d1e90913          	addi	s2,s2,-738 # ffffffffc02c6bd8 <nr_process>
ffffffffc0203ec2:	00092703          	lw	a4,0(s2)
{
ffffffffc0203ec6:	fc86                	sd	ra,120(sp)
ffffffffc0203ec8:	f8a2                	sd	s0,112(sp)
ffffffffc0203eca:	f4a6                	sd	s1,104(sp)
ffffffffc0203ecc:	ecce                	sd	s3,88(sp)
ffffffffc0203ece:	e8d2                	sd	s4,80(sp)
ffffffffc0203ed0:	e4d6                	sd	s5,72(sp)
ffffffffc0203ed2:	e0da                	sd	s6,64(sp)
ffffffffc0203ed4:	fc5e                	sd	s7,56(sp)
ffffffffc0203ed6:	f862                	sd	s8,48(sp)
ffffffffc0203ed8:	f466                	sd	s9,40(sp)
ffffffffc0203eda:	f06a                	sd	s10,32(sp)
ffffffffc0203edc:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203ede:	6785                	lui	a5,0x1
ffffffffc0203ee0:	2ef75c63          	bge	a4,a5,ffffffffc02041d8 <do_fork+0x322>
ffffffffc0203ee4:	8a2a                	mv	s4,a0
ffffffffc0203ee6:	89ae                	mv	s3,a1
ffffffffc0203ee8:	8432                	mv	s0,a2
     *    update step 1: set child proc's parent to current process, make sure current process's wait_state is 0
     *    update step 5: insert proc_struct into hash_list && proc_list, set the relation links of process
     */

         // 1. call alloc_proc to allocate a proc_struct
    if ((proc = alloc_proc()) == NULL) {
ffffffffc0203eea:	e47ff0ef          	jal	ra,ffffffffc0203d30 <alloc_proc>
ffffffffc0203eee:	84aa                	mv	s1,a0
ffffffffc0203ef0:	2c050863          	beqz	a0,ffffffffc02041c0 <do_fork+0x30a>
        goto fork_out;
    }
    // LAB5 update step 1: set parent and clear current wait_state
    proc->parent = current;
ffffffffc0203ef4:	000c3c17          	auipc	s8,0xc3
ffffffffc0203ef8:	cccc0c13          	addi	s8,s8,-820 # ffffffffc02c6bc0 <current>
ffffffffc0203efc:	000c3783          	ld	a5,0(s8)
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203f00:	4509                	li	a0,2
    proc->parent = current;
ffffffffc0203f02:	f09c                	sd	a5,32(s1)
    current->wait_state = 0;
ffffffffc0203f04:	0e07a623          	sw	zero,236(a5) # 10ec <_binary_obj___user_faultread_out_size-0x8e4c>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203f08:	e79fd0ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
    if (page != NULL)
ffffffffc0203f0c:	2a050763          	beqz	a0,ffffffffc02041ba <do_fork+0x304>
    return page - pages + nbase;
ffffffffc0203f10:	000c3a97          	auipc	s5,0xc3
ffffffffc0203f14:	c98a8a93          	addi	s5,s5,-872 # ffffffffc02c6ba8 <pages>
ffffffffc0203f18:	000ab683          	ld	a3,0(s5)
ffffffffc0203f1c:	00004b17          	auipc	s6,0x4
ffffffffc0203f20:	224b0b13          	addi	s6,s6,548 # ffffffffc0208140 <nbase>
ffffffffc0203f24:	000b3783          	ld	a5,0(s6)
ffffffffc0203f28:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc0203f2c:	000c3b97          	auipc	s7,0xc3
ffffffffc0203f30:	c74b8b93          	addi	s7,s7,-908 # ffffffffc02c6ba0 <npage>
    return page - pages + nbase;
ffffffffc0203f34:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0203f36:	5dfd                	li	s11,-1
ffffffffc0203f38:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc0203f3c:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0203f3e:	00cddd93          	srli	s11,s11,0xc
ffffffffc0203f42:	01b6f633          	and	a2,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0203f46:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203f48:	2ce67563          	bgeu	a2,a4,ffffffffc0204212 <do_fork+0x35c>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc0203f4c:	000c3603          	ld	a2,0(s8)
ffffffffc0203f50:	000c3c17          	auipc	s8,0xc3
ffffffffc0203f54:	c68c0c13          	addi	s8,s8,-920 # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc0203f58:	000c3703          	ld	a4,0(s8)
ffffffffc0203f5c:	02863d03          	ld	s10,40(a2)
ffffffffc0203f60:	e43e                	sd	a5,8(sp)
ffffffffc0203f62:	96ba                	add	a3,a3,a4
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0203f64:	e894                	sd	a3,16(s1)
    if (oldmm == NULL)
ffffffffc0203f66:	020d0863          	beqz	s10,ffffffffc0203f96 <do_fork+0xe0>
    if (clone_flags & CLONE_VM)
ffffffffc0203f6a:	100a7a13          	andi	s4,s4,256
ffffffffc0203f6e:	180a0863          	beqz	s4,ffffffffc02040fe <do_fork+0x248>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc0203f72:	030d2703          	lw	a4,48(s10)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203f76:	018d3783          	ld	a5,24(s10)
ffffffffc0203f7a:	c02006b7          	lui	a3,0xc0200
ffffffffc0203f7e:	2705                	addiw	a4,a4,1
ffffffffc0203f80:	02ed2823          	sw	a4,48(s10)
    proc->mm = mm;
ffffffffc0203f84:	03a4b423          	sd	s10,40(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203f88:	2ad7e163          	bltu	a5,a3,ffffffffc020422a <do_fork+0x374>
ffffffffc0203f8c:	000c3703          	ld	a4,0(s8)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203f90:	6894                	ld	a3,16(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203f92:	8f99                	sub	a5,a5,a4
ffffffffc0203f94:	f4dc                	sd	a5,168(s1)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203f96:	6789                	lui	a5,0x2
ffffffffc0203f98:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x8058>
ffffffffc0203f9c:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc0203f9e:	8622                	mv	a2,s0
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203fa0:	f0d4                	sd	a3,160(s1)
    *(proc->tf) = *tf;
ffffffffc0203fa2:	87b6                	mv	a5,a3
ffffffffc0203fa4:	12040893          	addi	a7,s0,288
ffffffffc0203fa8:	00063803          	ld	a6,0(a2)
ffffffffc0203fac:	6608                	ld	a0,8(a2)
ffffffffc0203fae:	6a0c                	ld	a1,16(a2)
ffffffffc0203fb0:	6e18                	ld	a4,24(a2)
ffffffffc0203fb2:	0107b023          	sd	a6,0(a5)
ffffffffc0203fb6:	e788                	sd	a0,8(a5)
ffffffffc0203fb8:	eb8c                	sd	a1,16(a5)
ffffffffc0203fba:	ef98                	sd	a4,24(a5)
ffffffffc0203fbc:	02060613          	addi	a2,a2,32
ffffffffc0203fc0:	02078793          	addi	a5,a5,32
ffffffffc0203fc4:	ff1612e3          	bne	a2,a7,ffffffffc0203fa8 <do_fork+0xf2>
    proc->tf->gpr.a0 = 0;
ffffffffc0203fc8:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0203fcc:	12098763          	beqz	s3,ffffffffc02040fa <do_fork+0x244>
    if (++last_pid >= MAX_PID)
ffffffffc0203fd0:	000be817          	auipc	a6,0xbe
ffffffffc0203fd4:	73880813          	addi	a6,a6,1848 # ffffffffc02c2708 <last_pid.1>
ffffffffc0203fd8:	00082783          	lw	a5,0(a6)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0203fdc:	0136b823          	sd	s3,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203fe0:	00000717          	auipc	a4,0x0
ffffffffc0203fe4:	de670713          	addi	a4,a4,-538 # ffffffffc0203dc6 <forkret>
    if (++last_pid >= MAX_PID)
ffffffffc0203fe8:	0017851b          	addiw	a0,a5,1
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203fec:	f898                	sd	a4,48(s1)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc0203fee:	fc94                	sd	a3,56(s1)
    if (++last_pid >= MAX_PID)
ffffffffc0203ff0:	00a82023          	sw	a0,0(a6)
ffffffffc0203ff4:	6789                	lui	a5,0x2
ffffffffc0203ff6:	08f55b63          	bge	a0,a5,ffffffffc020408c <do_fork+0x1d6>
    if (last_pid >= next_safe)
ffffffffc0203ffa:	000be317          	auipc	t1,0xbe
ffffffffc0203ffe:	71230313          	addi	t1,t1,1810 # ffffffffc02c270c <next_safe.0>
ffffffffc0204002:	00032783          	lw	a5,0(t1)
ffffffffc0204006:	000c3417          	auipc	s0,0xc3
ffffffffc020400a:	b2240413          	addi	s0,s0,-1246 # ffffffffc02c6b28 <proc_list>
ffffffffc020400e:	08f55763          	bge	a0,a5,ffffffffc020409c <do_fork+0x1e6>
    // 4. call copy_thread to setup tf & context in proc_struct
    // 这里的stack初始值为0，表示创建内核线程
    copy_thread(proc, stack, tf);

    // 5. insert proc_struct into hash_list && proc_list, and set relation links
    proc->pid = get_pid();
ffffffffc0204012:	c0c8                	sw	a0,4(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204014:	45a9                	li	a1,10
ffffffffc0204016:	2501                	sext.w	a0,a0
ffffffffc0204018:	372010ef          	jal	ra,ffffffffc020538a <hash32>
ffffffffc020401c:	02051793          	slli	a5,a0,0x20
ffffffffc0204020:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204024:	000bf797          	auipc	a5,0xbf
ffffffffc0204028:	b0478793          	addi	a5,a5,-1276 # ffffffffc02c2b28 <hash_list>
ffffffffc020402c:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc020402e:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204030:	7094                	ld	a3,32(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204032:	0d848793          	addi	a5,s1,216
    prev->next = next->prev = elm;
ffffffffc0204036:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc0204038:	6410                	ld	a2,8(s0)
    prev->next = next->prev = elm;
ffffffffc020403a:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020403c:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc020403e:	0c848793          	addi	a5,s1,200
    elm->next = next;
ffffffffc0204042:	f0ec                	sd	a1,224(s1)
    elm->prev = prev;
ffffffffc0204044:	ece8                	sd	a0,216(s1)
    prev->next = next->prev = elm;
ffffffffc0204046:	e21c                	sd	a5,0(a2)
ffffffffc0204048:	e41c                	sd	a5,8(s0)
    elm->next = next;
ffffffffc020404a:	e8f0                	sd	a2,208(s1)
    elm->prev = prev;
ffffffffc020404c:	e4e0                	sd	s0,200(s1)
    proc->yptr = NULL;
ffffffffc020404e:	0e04bc23          	sd	zero,248(s1)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204052:	10e4b023          	sd	a4,256(s1)
ffffffffc0204056:	c311                	beqz	a4,ffffffffc020405a <do_fork+0x1a4>
        proc->optr->yptr = proc;
ffffffffc0204058:	ff64                	sd	s1,248(a4)
    nr_process++;
ffffffffc020405a:	00092783          	lw	a5,0(s2)
    hash_proc(proc);
    set_links(proc);

    // 6. call wakeup_proc to make the new child process RUNNABLE
    wakeup_proc(proc);
ffffffffc020405e:	8526                	mv	a0,s1
    proc->parent->cptr = proc;
ffffffffc0204060:	fae4                	sd	s1,240(a3)
    nr_process++;
ffffffffc0204062:	2785                	addiw	a5,a5,1
ffffffffc0204064:	00f92023          	sw	a5,0(s2)
    wakeup_proc(proc);
ffffffffc0204068:	0b0010ef          	jal	ra,ffffffffc0205118 <wakeup_proc>

    // 7. set ret vaule using child proc's pid
    ret = proc->pid;
ffffffffc020406c:	40c8                	lw	a0,4(s1)
bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}
ffffffffc020406e:	70e6                	ld	ra,120(sp)
ffffffffc0204070:	7446                	ld	s0,112(sp)
ffffffffc0204072:	74a6                	ld	s1,104(sp)
ffffffffc0204074:	7906                	ld	s2,96(sp)
ffffffffc0204076:	69e6                	ld	s3,88(sp)
ffffffffc0204078:	6a46                	ld	s4,80(sp)
ffffffffc020407a:	6aa6                	ld	s5,72(sp)
ffffffffc020407c:	6b06                	ld	s6,64(sp)
ffffffffc020407e:	7be2                	ld	s7,56(sp)
ffffffffc0204080:	7c42                	ld	s8,48(sp)
ffffffffc0204082:	7ca2                	ld	s9,40(sp)
ffffffffc0204084:	7d02                	ld	s10,32(sp)
ffffffffc0204086:	6de2                	ld	s11,24(sp)
ffffffffc0204088:	6109                	addi	sp,sp,128
ffffffffc020408a:	8082                	ret
        last_pid = 1;
ffffffffc020408c:	4785                	li	a5,1
ffffffffc020408e:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc0204092:	4505                	li	a0,1
ffffffffc0204094:	000be317          	auipc	t1,0xbe
ffffffffc0204098:	67830313          	addi	t1,t1,1656 # ffffffffc02c270c <next_safe.0>
    return listelm->next;
ffffffffc020409c:	000c3417          	auipc	s0,0xc3
ffffffffc02040a0:	a8c40413          	addi	s0,s0,-1396 # ffffffffc02c6b28 <proc_list>
ffffffffc02040a4:	00843e03          	ld	t3,8(s0)
        next_safe = MAX_PID;
ffffffffc02040a8:	6789                	lui	a5,0x2
ffffffffc02040aa:	00f32023          	sw	a5,0(t1)
ffffffffc02040ae:	86aa                	mv	a3,a0
ffffffffc02040b0:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc02040b2:	6e89                	lui	t4,0x2
ffffffffc02040b4:	108e0d63          	beq	t3,s0,ffffffffc02041ce <do_fork+0x318>
ffffffffc02040b8:	88ae                	mv	a7,a1
ffffffffc02040ba:	87f2                	mv	a5,t3
ffffffffc02040bc:	6609                	lui	a2,0x2
ffffffffc02040be:	a811                	j	ffffffffc02040d2 <do_fork+0x21c>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc02040c0:	00e6d663          	bge	a3,a4,ffffffffc02040cc <do_fork+0x216>
ffffffffc02040c4:	00c75463          	bge	a4,a2,ffffffffc02040cc <do_fork+0x216>
ffffffffc02040c8:	863a                	mv	a2,a4
ffffffffc02040ca:	4885                	li	a7,1
ffffffffc02040cc:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc02040ce:	00878d63          	beq	a5,s0,ffffffffc02040e8 <do_fork+0x232>
            if (proc->pid == last_pid)
ffffffffc02040d2:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x7ffc>
ffffffffc02040d6:	fed715e3          	bne	a4,a3,ffffffffc02040c0 <do_fork+0x20a>
                if (++last_pid >= next_safe)
ffffffffc02040da:	2685                	addiw	a3,a3,1
ffffffffc02040dc:	0ec6d463          	bge	a3,a2,ffffffffc02041c4 <do_fork+0x30e>
ffffffffc02040e0:	679c                	ld	a5,8(a5)
ffffffffc02040e2:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc02040e4:	fe8797e3          	bne	a5,s0,ffffffffc02040d2 <do_fork+0x21c>
ffffffffc02040e8:	c581                	beqz	a1,ffffffffc02040f0 <do_fork+0x23a>
ffffffffc02040ea:	00d82023          	sw	a3,0(a6)
ffffffffc02040ee:	8536                	mv	a0,a3
ffffffffc02040f0:	f20881e3          	beqz	a7,ffffffffc0204012 <do_fork+0x15c>
ffffffffc02040f4:	00c32023          	sw	a2,0(t1)
ffffffffc02040f8:	bf29                	j	ffffffffc0204012 <do_fork+0x15c>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02040fa:	89b6                	mv	s3,a3
ffffffffc02040fc:	bdd1                	j	ffffffffc0203fd0 <do_fork+0x11a>
    if ((mm = mm_create()) == NULL)
ffffffffc02040fe:	d20ff0ef          	jal	ra,ffffffffc020361e <mm_create>
ffffffffc0204102:	8caa                	mv	s9,a0
ffffffffc0204104:	c159                	beqz	a0,ffffffffc020418a <do_fork+0x2d4>
    if ((page = alloc_page()) == NULL)
ffffffffc0204106:	4505                	li	a0,1
ffffffffc0204108:	c79fd0ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc020410c:	cd25                	beqz	a0,ffffffffc0204184 <do_fork+0x2ce>
    return page - pages + nbase;
ffffffffc020410e:	000ab683          	ld	a3,0(s5)
ffffffffc0204112:	67a2                	ld	a5,8(sp)
    return KADDR(page2pa(page));
ffffffffc0204114:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc0204118:	40d506b3          	sub	a3,a0,a3
ffffffffc020411c:	8699                	srai	a3,a3,0x6
ffffffffc020411e:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204120:	01b6fdb3          	and	s11,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0204124:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204126:	0eedf663          	bgeu	s11,a4,ffffffffc0204212 <do_fork+0x35c>
ffffffffc020412a:	000c3a03          	ld	s4,0(s8)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc020412e:	6605                	lui	a2,0x1
ffffffffc0204130:	000c3597          	auipc	a1,0xc3
ffffffffc0204134:	a685b583          	ld	a1,-1432(a1) # ffffffffc02c6b98 <boot_pgdir_va>
ffffffffc0204138:	9a36                	add	s4,s4,a3
ffffffffc020413a:	8552                	mv	a0,s4
ffffffffc020413c:	706010ef          	jal	ra,ffffffffc0205842 <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc0204140:	038d0d93          	addi	s11,s10,56
    mm->pgdir = pgdir;
ffffffffc0204144:	014cbc23          	sd	s4,24(s9)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0204148:	4785                	li	a5,1
ffffffffc020414a:	40fdb7af          	amoor.d	a5,a5,(s11)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc020414e:	8b85                	andi	a5,a5,1
ffffffffc0204150:	4a05                	li	s4,1
ffffffffc0204152:	c799                	beqz	a5,ffffffffc0204160 <do_fork+0x2aa>
    {
        schedule();
ffffffffc0204154:	076010ef          	jal	ra,ffffffffc02051ca <schedule>
ffffffffc0204158:	414db7af          	amoor.d	a5,s4,(s11)
    while (!try_lock(lock))
ffffffffc020415c:	8b85                	andi	a5,a5,1
ffffffffc020415e:	fbfd                	bnez	a5,ffffffffc0204154 <do_fork+0x29e>
        ret = dup_mmap(mm, oldmm);
ffffffffc0204160:	85ea                	mv	a1,s10
ffffffffc0204162:	8566                	mv	a0,s9
ffffffffc0204164:	efcff0ef          	jal	ra,ffffffffc0203860 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0204168:	57f9                	li	a5,-2
ffffffffc020416a:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc020416e:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc0204170:	cbad                	beqz	a5,ffffffffc02041e2 <do_fork+0x32c>
good_mm:
ffffffffc0204172:	8d66                	mv	s10,s9
    if (ret != 0)
ffffffffc0204174:	de050fe3          	beqz	a0,ffffffffc0203f72 <do_fork+0xbc>
    exit_mmap(mm);
ffffffffc0204178:	8566                	mv	a0,s9
ffffffffc020417a:	f80ff0ef          	jal	ra,ffffffffc02038fa <exit_mmap>
    put_pgdir(mm);
ffffffffc020417e:	8566                	mv	a0,s9
ffffffffc0204180:	c55ff0ef          	jal	ra,ffffffffc0203dd4 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204184:	8566                	mv	a0,s9
ffffffffc0204186:	dd8ff0ef          	jal	ra,ffffffffc020375e <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020418a:	6894                	ld	a3,16(s1)
    return pa2page(PADDR(kva));
ffffffffc020418c:	c02007b7          	lui	a5,0xc0200
ffffffffc0204190:	0af6ea63          	bltu	a3,a5,ffffffffc0204244 <do_fork+0x38e>
ffffffffc0204194:	000c3783          	ld	a5,0(s8)
    if (PPN(pa) >= npage)
ffffffffc0204198:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc020419c:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage)
ffffffffc02041a0:	83b1                	srli	a5,a5,0xc
ffffffffc02041a2:	04e7fc63          	bgeu	a5,a4,ffffffffc02041fa <do_fork+0x344>
    return &pages[PPN(pa) - nbase];
ffffffffc02041a6:	000b3703          	ld	a4,0(s6)
ffffffffc02041aa:	000ab503          	ld	a0,0(s5)
ffffffffc02041ae:	4589                	li	a1,2
ffffffffc02041b0:	8f99                	sub	a5,a5,a4
ffffffffc02041b2:	079a                	slli	a5,a5,0x6
ffffffffc02041b4:	953e                	add	a0,a0,a5
ffffffffc02041b6:	c09fd0ef          	jal	ra,ffffffffc0201dbe <free_pages>
    kfree(proc);
ffffffffc02041ba:	8526                	mv	a0,s1
ffffffffc02041bc:	a97fd0ef          	jal	ra,ffffffffc0201c52 <kfree>
    ret = -E_NO_MEM;
ffffffffc02041c0:	5571                	li	a0,-4
    return ret;
ffffffffc02041c2:	b575                	j	ffffffffc020406e <do_fork+0x1b8>
                    if (last_pid >= MAX_PID)
ffffffffc02041c4:	01d6c363          	blt	a3,t4,ffffffffc02041ca <do_fork+0x314>
                        last_pid = 1;
ffffffffc02041c8:	4685                	li	a3,1
                    goto repeat;
ffffffffc02041ca:	4585                	li	a1,1
ffffffffc02041cc:	b5e5                	j	ffffffffc02040b4 <do_fork+0x1fe>
ffffffffc02041ce:	c599                	beqz	a1,ffffffffc02041dc <do_fork+0x326>
ffffffffc02041d0:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc02041d4:	8536                	mv	a0,a3
ffffffffc02041d6:	bd35                	j	ffffffffc0204012 <do_fork+0x15c>
    int ret = -E_NO_FREE_PROC;
ffffffffc02041d8:	556d                	li	a0,-5
ffffffffc02041da:	bd51                	j	ffffffffc020406e <do_fork+0x1b8>
    return last_pid;
ffffffffc02041dc:	00082503          	lw	a0,0(a6)
ffffffffc02041e0:	bd0d                	j	ffffffffc0204012 <do_fork+0x15c>
    {
        panic("Unlock failed.\n");
ffffffffc02041e2:	00003617          	auipc	a2,0x3
ffffffffc02041e6:	eb660613          	addi	a2,a2,-330 # ffffffffc0207098 <default_pmm_manager+0xa08>
ffffffffc02041ea:	04000593          	li	a1,64
ffffffffc02041ee:	00003517          	auipc	a0,0x3
ffffffffc02041f2:	eba50513          	addi	a0,a0,-326 # ffffffffc02070a8 <default_pmm_manager+0xa18>
ffffffffc02041f6:	a9cfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02041fa:	00002617          	auipc	a2,0x2
ffffffffc02041fe:	59e60613          	addi	a2,a2,1438 # ffffffffc0206798 <default_pmm_manager+0x108>
ffffffffc0204202:	06900593          	li	a1,105
ffffffffc0204206:	00002517          	auipc	a0,0x2
ffffffffc020420a:	4ea50513          	addi	a0,a0,1258 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc020420e:	a84fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc0204212:	00002617          	auipc	a2,0x2
ffffffffc0204216:	4b660613          	addi	a2,a2,1206 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc020421a:	07100593          	li	a1,113
ffffffffc020421e:	00002517          	auipc	a0,0x2
ffffffffc0204222:	4d250513          	addi	a0,a0,1234 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0204226:	a6cfc0ef          	jal	ra,ffffffffc0200492 <__panic>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc020422a:	86be                	mv	a3,a5
ffffffffc020422c:	00002617          	auipc	a2,0x2
ffffffffc0204230:	54460613          	addi	a2,a2,1348 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc0204234:	19f00593          	li	a1,415
ffffffffc0204238:	00003517          	auipc	a0,0x3
ffffffffc020423c:	e8850513          	addi	a0,a0,-376 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204240:	a52fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0204244:	00002617          	auipc	a2,0x2
ffffffffc0204248:	52c60613          	addi	a2,a2,1324 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc020424c:	07700593          	li	a1,119
ffffffffc0204250:	00002517          	auipc	a0,0x2
ffffffffc0204254:	4a050513          	addi	a0,a0,1184 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0204258:	a3afc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020425c <kernel_thread>:
{
ffffffffc020425c:	7129                	addi	sp,sp,-320
ffffffffc020425e:	fa22                	sd	s0,304(sp)
ffffffffc0204260:	f626                	sd	s1,296(sp)
ffffffffc0204262:	f24a                	sd	s2,288(sp)
ffffffffc0204264:	84ae                	mv	s1,a1
ffffffffc0204266:	892a                	mv	s2,a0
ffffffffc0204268:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020426a:	4581                	li	a1,0
ffffffffc020426c:	12000613          	li	a2,288
ffffffffc0204270:	850a                	mv	a0,sp
{
ffffffffc0204272:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0204274:	5bc010ef          	jal	ra,ffffffffc0205830 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc0204278:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc020427a:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc020427c:	100027f3          	csrr	a5,sstatus
ffffffffc0204280:	edd7f793          	andi	a5,a5,-291
ffffffffc0204284:	1207e793          	ori	a5,a5,288
ffffffffc0204288:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020428a:	860a                	mv	a2,sp
ffffffffc020428c:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0204290:	00000797          	auipc	a5,0x0
ffffffffc0204294:	a9878793          	addi	a5,a5,-1384 # ffffffffc0203d28 <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204298:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020429a:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020429c:	c1bff0ef          	jal	ra,ffffffffc0203eb6 <do_fork>
}
ffffffffc02042a0:	70f2                	ld	ra,312(sp)
ffffffffc02042a2:	7452                	ld	s0,304(sp)
ffffffffc02042a4:	74b2                	ld	s1,296(sp)
ffffffffc02042a6:	7912                	ld	s2,288(sp)
ffffffffc02042a8:	6131                	addi	sp,sp,320
ffffffffc02042aa:	8082                	ret

ffffffffc02042ac <do_exit>:
// do_exit - called by sys_exit
//   1. call exit_mmap & put_pgdir & mm_destroy to free the almost all memory space of process
//   2. set process' state as PROC_ZOMBIE, then call wakeup_proc(parent) to ask parent reclaim itself.
//   3. call scheduler to switch to other process
int do_exit(int error_code)
{
ffffffffc02042ac:	7179                	addi	sp,sp,-48
ffffffffc02042ae:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc02042b0:	000c3417          	auipc	s0,0xc3
ffffffffc02042b4:	91040413          	addi	s0,s0,-1776 # ffffffffc02c6bc0 <current>
ffffffffc02042b8:	601c                	ld	a5,0(s0)
{
ffffffffc02042ba:	f406                	sd	ra,40(sp)
ffffffffc02042bc:	ec26                	sd	s1,24(sp)
ffffffffc02042be:	e84a                	sd	s2,16(sp)
ffffffffc02042c0:	e44e                	sd	s3,8(sp)
ffffffffc02042c2:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc02042c4:	000c3717          	auipc	a4,0xc3
ffffffffc02042c8:	90473703          	ld	a4,-1788(a4) # ffffffffc02c6bc8 <idleproc>
ffffffffc02042cc:	0ce78c63          	beq	a5,a4,ffffffffc02043a4 <do_exit+0xf8>
    {
        panic("idleproc exit.\n");
    }
    if (current == initproc)
ffffffffc02042d0:	000c3497          	auipc	s1,0xc3
ffffffffc02042d4:	90048493          	addi	s1,s1,-1792 # ffffffffc02c6bd0 <initproc>
ffffffffc02042d8:	6098                	ld	a4,0(s1)
ffffffffc02042da:	0ee78b63          	beq	a5,a4,ffffffffc02043d0 <do_exit+0x124>
    {
        panic("initproc exit.\n");
    }
    struct mm_struct *mm = current->mm;
ffffffffc02042de:	0287b983          	ld	s3,40(a5)
ffffffffc02042e2:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc02042e4:	02098663          	beqz	s3,ffffffffc0204310 <do_exit+0x64>
ffffffffc02042e8:	000c3797          	auipc	a5,0xc3
ffffffffc02042ec:	8a87b783          	ld	a5,-1880(a5) # ffffffffc02c6b90 <boot_pgdir_pa>
ffffffffc02042f0:	577d                	li	a4,-1
ffffffffc02042f2:	177e                	slli	a4,a4,0x3f
ffffffffc02042f4:	83b1                	srli	a5,a5,0xc
ffffffffc02042f6:	8fd9                	or	a5,a5,a4
ffffffffc02042f8:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc02042fc:	0309a783          	lw	a5,48(s3)
ffffffffc0204300:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204304:	02e9a823          	sw	a4,48(s3)
    {
        lsatp(boot_pgdir_pa);
        if (mm_count_dec(mm) == 0)
ffffffffc0204308:	cb55                	beqz	a4,ffffffffc02043bc <do_exit+0x110>
        {
            exit_mmap(mm);
            put_pgdir(mm);
            mm_destroy(mm);
        }
        current->mm = NULL;
ffffffffc020430a:	601c                	ld	a5,0(s0)
ffffffffc020430c:	0207b423          	sd	zero,40(a5)
    }
    current->state = PROC_ZOMBIE;
ffffffffc0204310:	601c                	ld	a5,0(s0)
ffffffffc0204312:	470d                	li	a4,3
ffffffffc0204314:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc0204316:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020431a:	100027f3          	csrr	a5,sstatus
ffffffffc020431e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204320:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204322:	e3f9                	bnez	a5,ffffffffc02043e8 <do_exit+0x13c>
    bool intr_flag;
    struct proc_struct *proc;
    local_intr_save(intr_flag);
    {
        proc = current->parent;
ffffffffc0204324:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc0204326:	800007b7          	lui	a5,0x80000
ffffffffc020432a:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc020432c:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc020432e:	0ec52703          	lw	a4,236(a0)
ffffffffc0204332:	0af70f63          	beq	a4,a5,ffffffffc02043f0 <do_exit+0x144>
        {
            wakeup_proc(proc);
        }
        while (current->cptr != NULL)
ffffffffc0204336:	6018                	ld	a4,0(s0)
ffffffffc0204338:	7b7c                	ld	a5,240(a4)
ffffffffc020433a:	c3a1                	beqz	a5,ffffffffc020437a <do_exit+0xce>
            }
            proc->parent = initproc;
            initproc->cptr = proc;
            if (proc->state == PROC_ZOMBIE)
            {
                if (initproc->wait_state == WT_CHILD)
ffffffffc020433c:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204340:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204342:	0985                	addi	s3,s3,1
ffffffffc0204344:	a021                	j	ffffffffc020434c <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc0204346:	6018                	ld	a4,0(s0)
ffffffffc0204348:	7b7c                	ld	a5,240(a4)
ffffffffc020434a:	cb85                	beqz	a5,ffffffffc020437a <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc020434c:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_matrix_out_size+0xffffffff7fff39f0>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204350:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc0204352:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204354:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc0204356:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc020435a:	10e7b023          	sd	a4,256(a5)
ffffffffc020435e:	c311                	beqz	a4,ffffffffc0204362 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc0204360:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204362:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0204364:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0204366:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204368:	fd271fe3          	bne	a4,s2,ffffffffc0204346 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc020436c:	0ec52783          	lw	a5,236(a0)
ffffffffc0204370:	fd379be3          	bne	a5,s3,ffffffffc0204346 <do_exit+0x9a>
                {
                    wakeup_proc(initproc);
ffffffffc0204374:	5a5000ef          	jal	ra,ffffffffc0205118 <wakeup_proc>
ffffffffc0204378:	b7f9                	j	ffffffffc0204346 <do_exit+0x9a>
    if (flag)
ffffffffc020437a:	020a1263          	bnez	s4,ffffffffc020439e <do_exit+0xf2>
                }
            }
        }
    }
    local_intr_restore(intr_flag);
    schedule();
ffffffffc020437e:	64d000ef          	jal	ra,ffffffffc02051ca <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0204382:	601c                	ld	a5,0(s0)
ffffffffc0204384:	00003617          	auipc	a2,0x3
ffffffffc0204388:	d7460613          	addi	a2,a2,-652 # ffffffffc02070f8 <default_pmm_manager+0xa68>
ffffffffc020438c:	25100593          	li	a1,593
ffffffffc0204390:	43d4                	lw	a3,4(a5)
ffffffffc0204392:	00003517          	auipc	a0,0x3
ffffffffc0204396:	d2e50513          	addi	a0,a0,-722 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc020439a:	8f8fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        intr_enable();
ffffffffc020439e:	e0afc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02043a2:	bff1                	j	ffffffffc020437e <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc02043a4:	00003617          	auipc	a2,0x3
ffffffffc02043a8:	d3460613          	addi	a2,a2,-716 # ffffffffc02070d8 <default_pmm_manager+0xa48>
ffffffffc02043ac:	21d00593          	li	a1,541
ffffffffc02043b0:	00003517          	auipc	a0,0x3
ffffffffc02043b4:	d1050513          	addi	a0,a0,-752 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc02043b8:	8dafc0ef          	jal	ra,ffffffffc0200492 <__panic>
            exit_mmap(mm);
ffffffffc02043bc:	854e                	mv	a0,s3
ffffffffc02043be:	d3cff0ef          	jal	ra,ffffffffc02038fa <exit_mmap>
            put_pgdir(mm);
ffffffffc02043c2:	854e                	mv	a0,s3
ffffffffc02043c4:	a11ff0ef          	jal	ra,ffffffffc0203dd4 <put_pgdir>
            mm_destroy(mm);
ffffffffc02043c8:	854e                	mv	a0,s3
ffffffffc02043ca:	b94ff0ef          	jal	ra,ffffffffc020375e <mm_destroy>
ffffffffc02043ce:	bf35                	j	ffffffffc020430a <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc02043d0:	00003617          	auipc	a2,0x3
ffffffffc02043d4:	d1860613          	addi	a2,a2,-744 # ffffffffc02070e8 <default_pmm_manager+0xa58>
ffffffffc02043d8:	22100593          	li	a1,545
ffffffffc02043dc:	00003517          	auipc	a0,0x3
ffffffffc02043e0:	ce450513          	addi	a0,a0,-796 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc02043e4:	8aefc0ef          	jal	ra,ffffffffc0200492 <__panic>
        intr_disable();
ffffffffc02043e8:	dc6fc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc02043ec:	4a05                	li	s4,1
ffffffffc02043ee:	bf1d                	j	ffffffffc0204324 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc02043f0:	529000ef          	jal	ra,ffffffffc0205118 <wakeup_proc>
ffffffffc02043f4:	b789                	j	ffffffffc0204336 <do_exit+0x8a>

ffffffffc02043f6 <do_wait.part.0>:
}

// do_wait - wait one OR any children with PROC_ZOMBIE state, and free memory space of kernel stack
//         - proc struct of this child.
// NOTE: only after do_wait function, all resources of the child proces are free.
int do_wait(int pid, int *code_store)
ffffffffc02043f6:	715d                	addi	sp,sp,-80
ffffffffc02043f8:	f84a                	sd	s2,48(sp)
ffffffffc02043fa:	f44e                	sd	s3,40(sp)
        }
    }
    if (haskid)
    {
        current->state = PROC_SLEEPING;
        current->wait_state = WT_CHILD;
ffffffffc02043fc:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc0204400:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc0204402:	fc26                	sd	s1,56(sp)
ffffffffc0204404:	f052                	sd	s4,32(sp)
ffffffffc0204406:	ec56                	sd	s5,24(sp)
ffffffffc0204408:	e85a                	sd	s6,16(sp)
ffffffffc020440a:	e45e                	sd	s7,8(sp)
ffffffffc020440c:	e486                	sd	ra,72(sp)
ffffffffc020440e:	e0a2                	sd	s0,64(sp)
ffffffffc0204410:	84aa                	mv	s1,a0
ffffffffc0204412:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc0204414:	000c2b97          	auipc	s7,0xc2
ffffffffc0204418:	7acb8b93          	addi	s7,s7,1964 # ffffffffc02c6bc0 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc020441c:	00050b1b          	sext.w	s6,a0
ffffffffc0204420:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0204424:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc0204426:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc0204428:	ccbd                	beqz	s1,ffffffffc02044a6 <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc020442a:	0359e863          	bltu	s3,s5,ffffffffc020445a <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020442e:	45a9                	li	a1,10
ffffffffc0204430:	855a                	mv	a0,s6
ffffffffc0204432:	759000ef          	jal	ra,ffffffffc020538a <hash32>
ffffffffc0204436:	02051793          	slli	a5,a0,0x20
ffffffffc020443a:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020443e:	000be797          	auipc	a5,0xbe
ffffffffc0204442:	6ea78793          	addi	a5,a5,1770 # ffffffffc02c2b28 <hash_list>
ffffffffc0204446:	953e                	add	a0,a0,a5
ffffffffc0204448:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc020444a:	a029                	j	ffffffffc0204454 <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc020444c:	f2c42783          	lw	a5,-212(s0)
ffffffffc0204450:	02978163          	beq	a5,s1,ffffffffc0204472 <do_wait.part.0+0x7c>
ffffffffc0204454:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc0204456:	fe851be3          	bne	a0,s0,ffffffffc020444c <do_wait.part.0+0x56>
        {
            do_exit(-E_KILLED);
        }
        goto repeat;
    }
    return -E_BAD_PROC;
ffffffffc020445a:	5579                	li	a0,-2
    }
    local_intr_restore(intr_flag);
    put_kstack(proc);
    kfree(proc);
    return 0;
}
ffffffffc020445c:	60a6                	ld	ra,72(sp)
ffffffffc020445e:	6406                	ld	s0,64(sp)
ffffffffc0204460:	74e2                	ld	s1,56(sp)
ffffffffc0204462:	7942                	ld	s2,48(sp)
ffffffffc0204464:	79a2                	ld	s3,40(sp)
ffffffffc0204466:	7a02                	ld	s4,32(sp)
ffffffffc0204468:	6ae2                	ld	s5,24(sp)
ffffffffc020446a:	6b42                	ld	s6,16(sp)
ffffffffc020446c:	6ba2                	ld	s7,8(sp)
ffffffffc020446e:	6161                	addi	sp,sp,80
ffffffffc0204470:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc0204472:	000bb683          	ld	a3,0(s7)
ffffffffc0204476:	f4843783          	ld	a5,-184(s0)
ffffffffc020447a:	fed790e3          	bne	a5,a3,ffffffffc020445a <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc020447e:	f2842703          	lw	a4,-216(s0)
ffffffffc0204482:	478d                	li	a5,3
ffffffffc0204484:	0ef70b63          	beq	a4,a5,ffffffffc020457a <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc0204488:	4785                	li	a5,1
ffffffffc020448a:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc020448c:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc0204490:	53b000ef          	jal	ra,ffffffffc02051ca <schedule>
        if (current->flags & PF_EXITING)
ffffffffc0204494:	000bb783          	ld	a5,0(s7)
ffffffffc0204498:	0b07a783          	lw	a5,176(a5)
ffffffffc020449c:	8b85                	andi	a5,a5,1
ffffffffc020449e:	d7c9                	beqz	a5,ffffffffc0204428 <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc02044a0:	555d                	li	a0,-9
ffffffffc02044a2:	e0bff0ef          	jal	ra,ffffffffc02042ac <do_exit>
        proc = current->cptr;
ffffffffc02044a6:	000bb683          	ld	a3,0(s7)
ffffffffc02044aa:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc02044ac:	d45d                	beqz	s0,ffffffffc020445a <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044ae:	470d                	li	a4,3
ffffffffc02044b0:	a021                	j	ffffffffc02044b8 <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc02044b2:	10043403          	ld	s0,256(s0)
ffffffffc02044b6:	d869                	beqz	s0,ffffffffc0204488 <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044b8:	401c                	lw	a5,0(s0)
ffffffffc02044ba:	fee79ce3          	bne	a5,a4,ffffffffc02044b2 <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc02044be:	000c2797          	auipc	a5,0xc2
ffffffffc02044c2:	70a7b783          	ld	a5,1802(a5) # ffffffffc02c6bc8 <idleproc>
ffffffffc02044c6:	0c878963          	beq	a5,s0,ffffffffc0204598 <do_wait.part.0+0x1a2>
ffffffffc02044ca:	000c2797          	auipc	a5,0xc2
ffffffffc02044ce:	7067b783          	ld	a5,1798(a5) # ffffffffc02c6bd0 <initproc>
ffffffffc02044d2:	0cf40363          	beq	s0,a5,ffffffffc0204598 <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc02044d6:	000a0663          	beqz	s4,ffffffffc02044e2 <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc02044da:	0e842783          	lw	a5,232(s0)
ffffffffc02044de:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f38>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02044e2:	100027f3          	csrr	a5,sstatus
ffffffffc02044e6:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044e8:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02044ea:	e7c1                	bnez	a5,ffffffffc0204572 <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc02044ec:	6c70                	ld	a2,216(s0)
ffffffffc02044ee:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc02044f0:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc02044f4:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc02044f6:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc02044f8:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02044fa:	6470                	ld	a2,200(s0)
ffffffffc02044fc:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc02044fe:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204500:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc0204502:	c319                	beqz	a4,ffffffffc0204508 <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc0204504:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc0204506:	7c7c                	ld	a5,248(s0)
ffffffffc0204508:	c3b5                	beqz	a5,ffffffffc020456c <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc020450a:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc020450e:	000c2717          	auipc	a4,0xc2
ffffffffc0204512:	6ca70713          	addi	a4,a4,1738 # ffffffffc02c6bd8 <nr_process>
ffffffffc0204516:	431c                	lw	a5,0(a4)
ffffffffc0204518:	37fd                	addiw	a5,a5,-1
ffffffffc020451a:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc020451c:	e5a9                	bnez	a1,ffffffffc0204566 <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020451e:	6814                	ld	a3,16(s0)
ffffffffc0204520:	c02007b7          	lui	a5,0xc0200
ffffffffc0204524:	04f6ee63          	bltu	a3,a5,ffffffffc0204580 <do_wait.part.0+0x18a>
ffffffffc0204528:	000c2797          	auipc	a5,0xc2
ffffffffc020452c:	6907b783          	ld	a5,1680(a5) # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc0204530:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc0204532:	82b1                	srli	a3,a3,0xc
ffffffffc0204534:	000c2797          	auipc	a5,0xc2
ffffffffc0204538:	66c7b783          	ld	a5,1644(a5) # ffffffffc02c6ba0 <npage>
ffffffffc020453c:	06f6fa63          	bgeu	a3,a5,ffffffffc02045b0 <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc0204540:	00004517          	auipc	a0,0x4
ffffffffc0204544:	c0053503          	ld	a0,-1024(a0) # ffffffffc0208140 <nbase>
ffffffffc0204548:	8e89                	sub	a3,a3,a0
ffffffffc020454a:	069a                	slli	a3,a3,0x6
ffffffffc020454c:	000c2517          	auipc	a0,0xc2
ffffffffc0204550:	65c53503          	ld	a0,1628(a0) # ffffffffc02c6ba8 <pages>
ffffffffc0204554:	9536                	add	a0,a0,a3
ffffffffc0204556:	4589                	li	a1,2
ffffffffc0204558:	867fd0ef          	jal	ra,ffffffffc0201dbe <free_pages>
    kfree(proc);
ffffffffc020455c:	8522                	mv	a0,s0
ffffffffc020455e:	ef4fd0ef          	jal	ra,ffffffffc0201c52 <kfree>
    return 0;
ffffffffc0204562:	4501                	li	a0,0
ffffffffc0204564:	bde5                	j	ffffffffc020445c <do_wait.part.0+0x66>
        intr_enable();
ffffffffc0204566:	c42fc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020456a:	bf55                	j	ffffffffc020451e <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc020456c:	701c                	ld	a5,32(s0)
ffffffffc020456e:	fbf8                	sd	a4,240(a5)
ffffffffc0204570:	bf79                	j	ffffffffc020450e <do_wait.part.0+0x118>
        intr_disable();
ffffffffc0204572:	c3cfc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0204576:	4585                	li	a1,1
ffffffffc0204578:	bf95                	j	ffffffffc02044ec <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc020457a:	f2840413          	addi	s0,s0,-216
ffffffffc020457e:	b781                	j	ffffffffc02044be <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc0204580:	00002617          	auipc	a2,0x2
ffffffffc0204584:	1f060613          	addi	a2,a2,496 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc0204588:	07700593          	li	a1,119
ffffffffc020458c:	00002517          	auipc	a0,0x2
ffffffffc0204590:	16450513          	addi	a0,a0,356 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0204594:	efffb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc0204598:	00003617          	auipc	a2,0x3
ffffffffc020459c:	b8060613          	addi	a2,a2,-1152 # ffffffffc0207118 <default_pmm_manager+0xa88>
ffffffffc02045a0:	37300593          	li	a1,883
ffffffffc02045a4:	00003517          	auipc	a0,0x3
ffffffffc02045a8:	b1c50513          	addi	a0,a0,-1252 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc02045ac:	ee7fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02045b0:	00002617          	auipc	a2,0x2
ffffffffc02045b4:	1e860613          	addi	a2,a2,488 # ffffffffc0206798 <default_pmm_manager+0x108>
ffffffffc02045b8:	06900593          	li	a1,105
ffffffffc02045bc:	00002517          	auipc	a0,0x2
ffffffffc02045c0:	13450513          	addi	a0,a0,308 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc02045c4:	ecffb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02045c8 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc02045c8:	1141                	addi	sp,sp,-16
ffffffffc02045ca:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc02045cc:	833fd0ef          	jal	ra,ffffffffc0201dfe <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc02045d0:	dcefd0ef          	jal	ra,ffffffffc0201b9e <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc02045d4:	4601                	li	a2,0
ffffffffc02045d6:	4581                	li	a1,0
ffffffffc02045d8:	00000517          	auipc	a0,0x0
ffffffffc02045dc:	62850513          	addi	a0,a0,1576 # ffffffffc0204c00 <user_main>
ffffffffc02045e0:	c7dff0ef          	jal	ra,ffffffffc020425c <kernel_thread>
    if (pid <= 0)
ffffffffc02045e4:	00a04563          	bgtz	a0,ffffffffc02045ee <init_main+0x26>
ffffffffc02045e8:	a071                	j	ffffffffc0204674 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
ffffffffc02045ea:	3e1000ef          	jal	ra,ffffffffc02051ca <schedule>
    if (code_store != NULL)
ffffffffc02045ee:	4581                	li	a1,0
ffffffffc02045f0:	4501                	li	a0,0
ffffffffc02045f2:	e05ff0ef          	jal	ra,ffffffffc02043f6 <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc02045f6:	d975                	beqz	a0,ffffffffc02045ea <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc02045f8:	00003517          	auipc	a0,0x3
ffffffffc02045fc:	b6050513          	addi	a0,a0,-1184 # ffffffffc0207158 <default_pmm_manager+0xac8>
ffffffffc0204600:	b99fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204604:	000c2797          	auipc	a5,0xc2
ffffffffc0204608:	5cc7b783          	ld	a5,1484(a5) # ffffffffc02c6bd0 <initproc>
ffffffffc020460c:	7bf8                	ld	a4,240(a5)
ffffffffc020460e:	e339                	bnez	a4,ffffffffc0204654 <init_main+0x8c>
ffffffffc0204610:	7ff8                	ld	a4,248(a5)
ffffffffc0204612:	e329                	bnez	a4,ffffffffc0204654 <init_main+0x8c>
ffffffffc0204614:	1007b703          	ld	a4,256(a5)
ffffffffc0204618:	ef15                	bnez	a4,ffffffffc0204654 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc020461a:	000c2697          	auipc	a3,0xc2
ffffffffc020461e:	5be6a683          	lw	a3,1470(a3) # ffffffffc02c6bd8 <nr_process>
ffffffffc0204622:	4709                	li	a4,2
ffffffffc0204624:	0ae69463          	bne	a3,a4,ffffffffc02046cc <init_main+0x104>
    return listelm->next;
ffffffffc0204628:	000c2697          	auipc	a3,0xc2
ffffffffc020462c:	50068693          	addi	a3,a3,1280 # ffffffffc02c6b28 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204630:	6698                	ld	a4,8(a3)
ffffffffc0204632:	0c878793          	addi	a5,a5,200
ffffffffc0204636:	06f71b63          	bne	a4,a5,ffffffffc02046ac <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc020463a:	629c                	ld	a5,0(a3)
ffffffffc020463c:	04f71863          	bne	a4,a5,ffffffffc020468c <init_main+0xc4>

    cprintf("init check memory pass.\n");
ffffffffc0204640:	00003517          	auipc	a0,0x3
ffffffffc0204644:	c0050513          	addi	a0,a0,-1024 # ffffffffc0207240 <default_pmm_manager+0xbb0>
ffffffffc0204648:	b51fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return 0;
}
ffffffffc020464c:	60a2                	ld	ra,8(sp)
ffffffffc020464e:	4501                	li	a0,0
ffffffffc0204650:	0141                	addi	sp,sp,16
ffffffffc0204652:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204654:	00003697          	auipc	a3,0x3
ffffffffc0204658:	b2c68693          	addi	a3,a3,-1236 # ffffffffc0207180 <default_pmm_manager+0xaf0>
ffffffffc020465c:	00002617          	auipc	a2,0x2
ffffffffc0204660:	c8460613          	addi	a2,a2,-892 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204664:	3df00593          	li	a1,991
ffffffffc0204668:	00003517          	auipc	a0,0x3
ffffffffc020466c:	a5850513          	addi	a0,a0,-1448 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204670:	e23fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("create user_main failed.\n");
ffffffffc0204674:	00003617          	auipc	a2,0x3
ffffffffc0204678:	ac460613          	addi	a2,a2,-1340 # ffffffffc0207138 <default_pmm_manager+0xaa8>
ffffffffc020467c:	3d600593          	li	a1,982
ffffffffc0204680:	00003517          	auipc	a0,0x3
ffffffffc0204684:	a4050513          	addi	a0,a0,-1472 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204688:	e0bfb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc020468c:	00003697          	auipc	a3,0x3
ffffffffc0204690:	b8468693          	addi	a3,a3,-1148 # ffffffffc0207210 <default_pmm_manager+0xb80>
ffffffffc0204694:	00002617          	auipc	a2,0x2
ffffffffc0204698:	c4c60613          	addi	a2,a2,-948 # ffffffffc02062e0 <commands+0x818>
ffffffffc020469c:	3e200593          	li	a1,994
ffffffffc02046a0:	00003517          	auipc	a0,0x3
ffffffffc02046a4:	a2050513          	addi	a0,a0,-1504 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc02046a8:	debfb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc02046ac:	00003697          	auipc	a3,0x3
ffffffffc02046b0:	b3468693          	addi	a3,a3,-1228 # ffffffffc02071e0 <default_pmm_manager+0xb50>
ffffffffc02046b4:	00002617          	auipc	a2,0x2
ffffffffc02046b8:	c2c60613          	addi	a2,a2,-980 # ffffffffc02062e0 <commands+0x818>
ffffffffc02046bc:	3e100593          	li	a1,993
ffffffffc02046c0:	00003517          	auipc	a0,0x3
ffffffffc02046c4:	a0050513          	addi	a0,a0,-1536 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc02046c8:	dcbfb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_process == 2);
ffffffffc02046cc:	00003697          	auipc	a3,0x3
ffffffffc02046d0:	b0468693          	addi	a3,a3,-1276 # ffffffffc02071d0 <default_pmm_manager+0xb40>
ffffffffc02046d4:	00002617          	auipc	a2,0x2
ffffffffc02046d8:	c0c60613          	addi	a2,a2,-1012 # ffffffffc02062e0 <commands+0x818>
ffffffffc02046dc:	3e000593          	li	a1,992
ffffffffc02046e0:	00003517          	auipc	a0,0x3
ffffffffc02046e4:	9e050513          	addi	a0,a0,-1568 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc02046e8:	dabfb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02046ec <do_execve>:
{
ffffffffc02046ec:	7171                	addi	sp,sp,-176
ffffffffc02046ee:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc02046f0:	000c2d97          	auipc	s11,0xc2
ffffffffc02046f4:	4d0d8d93          	addi	s11,s11,1232 # ffffffffc02c6bc0 <current>
ffffffffc02046f8:	000db783          	ld	a5,0(s11)
{
ffffffffc02046fc:	e54e                	sd	s3,136(sp)
ffffffffc02046fe:	ed26                	sd	s1,152(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0204700:	0287b983          	ld	s3,40(a5)
{
ffffffffc0204704:	e94a                	sd	s2,144(sp)
ffffffffc0204706:	f4de                	sd	s7,104(sp)
ffffffffc0204708:	892a                	mv	s2,a0
ffffffffc020470a:	8bb2                	mv	s7,a2
ffffffffc020470c:	84ae                	mv	s1,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc020470e:	862e                	mv	a2,a1
ffffffffc0204710:	4681                	li	a3,0
ffffffffc0204712:	85aa                	mv	a1,a0
ffffffffc0204714:	854e                	mv	a0,s3
{
ffffffffc0204716:	f506                	sd	ra,168(sp)
ffffffffc0204718:	f122                	sd	s0,160(sp)
ffffffffc020471a:	e152                	sd	s4,128(sp)
ffffffffc020471c:	fcd6                	sd	s5,120(sp)
ffffffffc020471e:	f8da                	sd	s6,112(sp)
ffffffffc0204720:	f0e2                	sd	s8,96(sp)
ffffffffc0204722:	ece6                	sd	s9,88(sp)
ffffffffc0204724:	e8ea                	sd	s10,80(sp)
ffffffffc0204726:	f05e                	sd	s7,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc0204728:	d6cff0ef          	jal	ra,ffffffffc0203c94 <user_mem_check>
ffffffffc020472c:	40050a63          	beqz	a0,ffffffffc0204b40 <do_execve+0x454>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0204730:	4641                	li	a2,16
ffffffffc0204732:	4581                	li	a1,0
ffffffffc0204734:	1808                	addi	a0,sp,48
ffffffffc0204736:	0fa010ef          	jal	ra,ffffffffc0205830 <memset>
    memcpy(local_name, name, len);
ffffffffc020473a:	47bd                	li	a5,15
ffffffffc020473c:	8626                	mv	a2,s1
ffffffffc020473e:	1e97e263          	bltu	a5,s1,ffffffffc0204922 <do_execve+0x236>
ffffffffc0204742:	85ca                	mv	a1,s2
ffffffffc0204744:	1808                	addi	a0,sp,48
ffffffffc0204746:	0fc010ef          	jal	ra,ffffffffc0205842 <memcpy>
    if (mm != NULL)
ffffffffc020474a:	1e098363          	beqz	s3,ffffffffc0204930 <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc020474e:	00002517          	auipc	a0,0x2
ffffffffc0204752:	77250513          	addi	a0,a0,1906 # ffffffffc0206ec0 <default_pmm_manager+0x830>
ffffffffc0204756:	a7bfb0ef          	jal	ra,ffffffffc02001d0 <cputs>
ffffffffc020475a:	000c2797          	auipc	a5,0xc2
ffffffffc020475e:	4367b783          	ld	a5,1078(a5) # ffffffffc02c6b90 <boot_pgdir_pa>
ffffffffc0204762:	577d                	li	a4,-1
ffffffffc0204764:	177e                	slli	a4,a4,0x3f
ffffffffc0204766:	83b1                	srli	a5,a5,0xc
ffffffffc0204768:	8fd9                	or	a5,a5,a4
ffffffffc020476a:	18079073          	csrw	satp,a5
ffffffffc020476e:	0309a783          	lw	a5,48(s3) # 2030 <_binary_obj___user_faultread_out_size-0x7f08>
ffffffffc0204772:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204776:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc020477a:	2c070463          	beqz	a4,ffffffffc0204a42 <do_execve+0x356>
        current->mm = NULL;
ffffffffc020477e:	000db783          	ld	a5,0(s11)
ffffffffc0204782:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc0204786:	e99fe0ef          	jal	ra,ffffffffc020361e <mm_create>
ffffffffc020478a:	84aa                	mv	s1,a0
ffffffffc020478c:	1c050d63          	beqz	a0,ffffffffc0204966 <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc0204790:	4505                	li	a0,1
ffffffffc0204792:	deefd0ef          	jal	ra,ffffffffc0201d80 <alloc_pages>
ffffffffc0204796:	3a050963          	beqz	a0,ffffffffc0204b48 <do_execve+0x45c>
    return page - pages + nbase;
ffffffffc020479a:	000c2c97          	auipc	s9,0xc2
ffffffffc020479e:	40ec8c93          	addi	s9,s9,1038 # ffffffffc02c6ba8 <pages>
ffffffffc02047a2:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc02047a6:	000c2c17          	auipc	s8,0xc2
ffffffffc02047aa:	3fac0c13          	addi	s8,s8,1018 # ffffffffc02c6ba0 <npage>
    return page - pages + nbase;
ffffffffc02047ae:	00004717          	auipc	a4,0x4
ffffffffc02047b2:	99273703          	ld	a4,-1646(a4) # ffffffffc0208140 <nbase>
ffffffffc02047b6:	40d506b3          	sub	a3,a0,a3
ffffffffc02047ba:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02047bc:	5afd                	li	s5,-1
ffffffffc02047be:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc02047c2:	96ba                	add	a3,a3,a4
ffffffffc02047c4:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc02047c6:	00cad713          	srli	a4,s5,0xc
ffffffffc02047ca:	ec3a                	sd	a4,24(sp)
ffffffffc02047cc:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc02047ce:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02047d0:	38f77063          	bgeu	a4,a5,ffffffffc0204b50 <do_execve+0x464>
ffffffffc02047d4:	000c2b17          	auipc	s6,0xc2
ffffffffc02047d8:	3e4b0b13          	addi	s6,s6,996 # ffffffffc02c6bb8 <va_pa_offset>
ffffffffc02047dc:	000b3903          	ld	s2,0(s6)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc02047e0:	6605                	lui	a2,0x1
ffffffffc02047e2:	000c2597          	auipc	a1,0xc2
ffffffffc02047e6:	3b65b583          	ld	a1,950(a1) # ffffffffc02c6b98 <boot_pgdir_va>
ffffffffc02047ea:	9936                	add	s2,s2,a3
ffffffffc02047ec:	854a                	mv	a0,s2
ffffffffc02047ee:	054010ef          	jal	ra,ffffffffc0205842 <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02047f2:	7782                	ld	a5,32(sp)
ffffffffc02047f4:	4398                	lw	a4,0(a5)
ffffffffc02047f6:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc02047fa:	0124bc23          	sd	s2,24(s1)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02047fe:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_matrix_out_size+0x464b7e6f>
ffffffffc0204802:	14f71863          	bne	a4,a5,ffffffffc0204952 <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204806:	7682                	ld	a3,32(sp)
ffffffffc0204808:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc020480c:	0206b983          	ld	s3,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204810:	00371793          	slli	a5,a4,0x3
ffffffffc0204814:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204816:	99b6                	add	s3,s3,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204818:	078e                	slli	a5,a5,0x3
ffffffffc020481a:	97ce                	add	a5,a5,s3
ffffffffc020481c:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc020481e:	00f9fc63          	bgeu	s3,a5,ffffffffc0204836 <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc0204822:	0009a783          	lw	a5,0(s3)
ffffffffc0204826:	4705                	li	a4,1
ffffffffc0204828:	14e78163          	beq	a5,a4,ffffffffc020496a <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc020482c:	77a2                	ld	a5,40(sp)
ffffffffc020482e:	03898993          	addi	s3,s3,56
ffffffffc0204832:	fef9e8e3          	bltu	s3,a5,ffffffffc0204822 <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc0204836:	4701                	li	a4,0
ffffffffc0204838:	46ad                	li	a3,11
ffffffffc020483a:	00100637          	lui	a2,0x100
ffffffffc020483e:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204842:	8526                	mv	a0,s1
ffffffffc0204844:	f6dfe0ef          	jal	ra,ffffffffc02037b0 <mm_map>
ffffffffc0204848:	8a2a                	mv	s4,a0
ffffffffc020484a:	1e051263          	bnez	a0,ffffffffc0204a2e <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc020484e:	6c88                	ld	a0,24(s1)
ffffffffc0204850:	467d                	li	a2,31
ffffffffc0204852:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204856:	ce3fe0ef          	jal	ra,ffffffffc0203538 <pgdir_alloc_page>
ffffffffc020485a:	38050363          	beqz	a0,ffffffffc0204be0 <do_execve+0x4f4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc020485e:	6c88                	ld	a0,24(s1)
ffffffffc0204860:	467d                	li	a2,31
ffffffffc0204862:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0204866:	cd3fe0ef          	jal	ra,ffffffffc0203538 <pgdir_alloc_page>
ffffffffc020486a:	34050b63          	beqz	a0,ffffffffc0204bc0 <do_execve+0x4d4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc020486e:	6c88                	ld	a0,24(s1)
ffffffffc0204870:	467d                	li	a2,31
ffffffffc0204872:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0204876:	cc3fe0ef          	jal	ra,ffffffffc0203538 <pgdir_alloc_page>
ffffffffc020487a:	32050363          	beqz	a0,ffffffffc0204ba0 <do_execve+0x4b4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc020487e:	6c88                	ld	a0,24(s1)
ffffffffc0204880:	467d                	li	a2,31
ffffffffc0204882:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0204886:	cb3fe0ef          	jal	ra,ffffffffc0203538 <pgdir_alloc_page>
ffffffffc020488a:	2e050b63          	beqz	a0,ffffffffc0204b80 <do_execve+0x494>
    mm->mm_count += 1;
ffffffffc020488e:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0204890:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204894:	6c94                	ld	a3,24(s1)
ffffffffc0204896:	2785                	addiw	a5,a5,1
ffffffffc0204898:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc020489a:	f604                	sd	s1,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc020489c:	c02007b7          	lui	a5,0xc0200
ffffffffc02048a0:	2cf6e463          	bltu	a3,a5,ffffffffc0204b68 <do_execve+0x47c>
ffffffffc02048a4:	000b3783          	ld	a5,0(s6)
ffffffffc02048a8:	577d                	li	a4,-1
ffffffffc02048aa:	177e                	slli	a4,a4,0x3f
ffffffffc02048ac:	8e9d                	sub	a3,a3,a5
ffffffffc02048ae:	00c6d793          	srli	a5,a3,0xc
ffffffffc02048b2:	f654                	sd	a3,168(a2)
ffffffffc02048b4:	8fd9                	or	a5,a5,a4
ffffffffc02048b6:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc02048ba:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02048bc:	4581                	li	a1,0
ffffffffc02048be:	12000613          	li	a2,288
ffffffffc02048c2:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc02048c4:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02048c8:	769000ef          	jal	ra,ffffffffc0205830 <memset>
    tf->epc = elf->e_entry;
ffffffffc02048cc:	7782                	ld	a5,32(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048ce:	000db903          	ld	s2,0(s11)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02048d2:	edf4f493          	andi	s1,s1,-289
    tf->epc = elf->e_entry;
ffffffffc02048d6:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;
ffffffffc02048d8:	4785                	li	a5,1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048da:	0b490913          	addi	s2,s2,180 # ffffffff800000b4 <_binary_obj___user_matrix_out_size+0xffffffff7fff39a4>
    tf->gpr.sp = USTACKTOP;
ffffffffc02048de:	07fe                	slli	a5,a5,0x1f
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02048e0:	0204e493          	ori	s1,s1,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048e4:	4641                	li	a2,16
ffffffffc02048e6:	4581                	li	a1,0
    tf->gpr.sp = USTACKTOP;
ffffffffc02048e8:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc02048ea:	10e43423          	sd	a4,264(s0)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02048ee:	10943023          	sd	s1,256(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048f2:	854a                	mv	a0,s2
ffffffffc02048f4:	73d000ef          	jal	ra,ffffffffc0205830 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc02048f8:	463d                	li	a2,15
ffffffffc02048fa:	180c                	addi	a1,sp,48
ffffffffc02048fc:	854a                	mv	a0,s2
ffffffffc02048fe:	745000ef          	jal	ra,ffffffffc0205842 <memcpy>
}
ffffffffc0204902:	70aa                	ld	ra,168(sp)
ffffffffc0204904:	740a                	ld	s0,160(sp)
ffffffffc0204906:	64ea                	ld	s1,152(sp)
ffffffffc0204908:	694a                	ld	s2,144(sp)
ffffffffc020490a:	69aa                	ld	s3,136(sp)
ffffffffc020490c:	7ae6                	ld	s5,120(sp)
ffffffffc020490e:	7b46                	ld	s6,112(sp)
ffffffffc0204910:	7ba6                	ld	s7,104(sp)
ffffffffc0204912:	7c06                	ld	s8,96(sp)
ffffffffc0204914:	6ce6                	ld	s9,88(sp)
ffffffffc0204916:	6d46                	ld	s10,80(sp)
ffffffffc0204918:	6da6                	ld	s11,72(sp)
ffffffffc020491a:	8552                	mv	a0,s4
ffffffffc020491c:	6a0a                	ld	s4,128(sp)
ffffffffc020491e:	614d                	addi	sp,sp,176
ffffffffc0204920:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204922:	463d                	li	a2,15
ffffffffc0204924:	85ca                	mv	a1,s2
ffffffffc0204926:	1808                	addi	a0,sp,48
ffffffffc0204928:	71b000ef          	jal	ra,ffffffffc0205842 <memcpy>
    if (mm != NULL)
ffffffffc020492c:	e20991e3          	bnez	s3,ffffffffc020474e <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204930:	000db783          	ld	a5,0(s11)
ffffffffc0204934:	779c                	ld	a5,40(a5)
ffffffffc0204936:	e40788e3          	beqz	a5,ffffffffc0204786 <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc020493a:	00003617          	auipc	a2,0x3
ffffffffc020493e:	92660613          	addi	a2,a2,-1754 # ffffffffc0207260 <default_pmm_manager+0xbd0>
ffffffffc0204942:	25d00593          	li	a1,605
ffffffffc0204946:	00002517          	auipc	a0,0x2
ffffffffc020494a:	77a50513          	addi	a0,a0,1914 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc020494e:	b45fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    put_pgdir(mm);
ffffffffc0204952:	8526                	mv	a0,s1
ffffffffc0204954:	c80ff0ef          	jal	ra,ffffffffc0203dd4 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204958:	8526                	mv	a0,s1
ffffffffc020495a:	e05fe0ef          	jal	ra,ffffffffc020375e <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc020495e:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0204960:	8552                	mv	a0,s4
ffffffffc0204962:	94bff0ef          	jal	ra,ffffffffc02042ac <do_exit>
    int ret = -E_NO_MEM;
ffffffffc0204966:	5a71                	li	s4,-4
ffffffffc0204968:	bfe5                	j	ffffffffc0204960 <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc020496a:	0289b603          	ld	a2,40(s3)
ffffffffc020496e:	0209b783          	ld	a5,32(s3)
ffffffffc0204972:	1cf66d63          	bltu	a2,a5,ffffffffc0204b4c <do_execve+0x460>
        if (ph->p_flags & ELF_PF_X)
ffffffffc0204976:	0049a783          	lw	a5,4(s3)
ffffffffc020497a:	0017f693          	andi	a3,a5,1
ffffffffc020497e:	c291                	beqz	a3,ffffffffc0204982 <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204980:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204982:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204986:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204988:	e779                	bnez	a4,ffffffffc0204a56 <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc020498a:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc020498c:	c781                	beqz	a5,ffffffffc0204994 <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc020498e:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204992:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204994:	0026f793          	andi	a5,a3,2
ffffffffc0204998:	e3f1                	bnez	a5,ffffffffc0204a5c <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc020499a:	0046f793          	andi	a5,a3,4
ffffffffc020499e:	c399                	beqz	a5,ffffffffc02049a4 <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc02049a0:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc02049a4:	0109b583          	ld	a1,16(s3)
ffffffffc02049a8:	4701                	li	a4,0
ffffffffc02049aa:	8526                	mv	a0,s1
ffffffffc02049ac:	e05fe0ef          	jal	ra,ffffffffc02037b0 <mm_map>
ffffffffc02049b0:	8a2a                	mv	s4,a0
ffffffffc02049b2:	ed35                	bnez	a0,ffffffffc0204a2e <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc02049b4:	0109bb83          	ld	s7,16(s3)
ffffffffc02049b8:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc02049ba:	0209ba03          	ld	s4,32(s3)
        unsigned char *from = binary + ph->p_offset;
ffffffffc02049be:	0089b903          	ld	s2,8(s3)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc02049c2:	00fbfab3          	and	s5,s7,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc02049c6:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc02049c8:	9a5e                	add	s4,s4,s7
        unsigned char *from = binary + ph->p_offset;
ffffffffc02049ca:	993e                	add	s2,s2,a5
        while (start < end)
ffffffffc02049cc:	054be963          	bltu	s7,s4,ffffffffc0204a1e <do_execve+0x332>
ffffffffc02049d0:	aa95                	j	ffffffffc0204b44 <do_execve+0x458>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc02049d2:	6785                	lui	a5,0x1
ffffffffc02049d4:	415b8533          	sub	a0,s7,s5
ffffffffc02049d8:	9abe                	add	s5,s5,a5
ffffffffc02049da:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc02049de:	015a7463          	bgeu	s4,s5,ffffffffc02049e6 <do_execve+0x2fa>
                size -= la - end;
ffffffffc02049e2:	417a0633          	sub	a2,s4,s7
    return page - pages + nbase;
ffffffffc02049e6:	000cb683          	ld	a3,0(s9)
ffffffffc02049ea:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc02049ec:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc02049f0:	40d406b3          	sub	a3,s0,a3
ffffffffc02049f4:	8699                	srai	a3,a3,0x6
ffffffffc02049f6:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02049f8:	67e2                	ld	a5,24(sp)
ffffffffc02049fa:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc02049fe:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204a00:	14b87863          	bgeu	a6,a1,ffffffffc0204b50 <do_execve+0x464>
ffffffffc0204a04:	000b3803          	ld	a6,0(s6)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204a08:	85ca                	mv	a1,s2
            start += size, from += size;
ffffffffc0204a0a:	9bb2                	add	s7,s7,a2
ffffffffc0204a0c:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204a0e:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204a10:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204a12:	631000ef          	jal	ra,ffffffffc0205842 <memcpy>
            start += size, from += size;
ffffffffc0204a16:	6622                	ld	a2,8(sp)
ffffffffc0204a18:	9932                	add	s2,s2,a2
        while (start < end)
ffffffffc0204a1a:	054bf363          	bgeu	s7,s4,ffffffffc0204a60 <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204a1e:	6c88                	ld	a0,24(s1)
ffffffffc0204a20:	866a                	mv	a2,s10
ffffffffc0204a22:	85d6                	mv	a1,s5
ffffffffc0204a24:	b15fe0ef          	jal	ra,ffffffffc0203538 <pgdir_alloc_page>
ffffffffc0204a28:	842a                	mv	s0,a0
ffffffffc0204a2a:	f545                	bnez	a0,ffffffffc02049d2 <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204a2c:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204a2e:	8526                	mv	a0,s1
ffffffffc0204a30:	ecbfe0ef          	jal	ra,ffffffffc02038fa <exit_mmap>
    put_pgdir(mm);
ffffffffc0204a34:	8526                	mv	a0,s1
ffffffffc0204a36:	b9eff0ef          	jal	ra,ffffffffc0203dd4 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204a3a:	8526                	mv	a0,s1
ffffffffc0204a3c:	d23fe0ef          	jal	ra,ffffffffc020375e <mm_destroy>
    return ret;
ffffffffc0204a40:	b705                	j	ffffffffc0204960 <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204a42:	854e                	mv	a0,s3
ffffffffc0204a44:	eb7fe0ef          	jal	ra,ffffffffc02038fa <exit_mmap>
            put_pgdir(mm);
ffffffffc0204a48:	854e                	mv	a0,s3
ffffffffc0204a4a:	b8aff0ef          	jal	ra,ffffffffc0203dd4 <put_pgdir>
            mm_destroy(mm);
ffffffffc0204a4e:	854e                	mv	a0,s3
ffffffffc0204a50:	d0ffe0ef          	jal	ra,ffffffffc020375e <mm_destroy>
ffffffffc0204a54:	b32d                	j	ffffffffc020477e <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204a56:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a5a:	fb95                	bnez	a5,ffffffffc020498e <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204a5c:	4d5d                	li	s10,23
ffffffffc0204a5e:	bf35                	j	ffffffffc020499a <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204a60:	0109b683          	ld	a3,16(s3)
ffffffffc0204a64:	0289b903          	ld	s2,40(s3)
ffffffffc0204a68:	9936                	add	s2,s2,a3
        if (start < la)
ffffffffc0204a6a:	075bfd63          	bgeu	s7,s5,ffffffffc0204ae4 <do_execve+0x3f8>
            if (start == end)
ffffffffc0204a6e:	db790fe3          	beq	s2,s7,ffffffffc020482c <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204a72:	6785                	lui	a5,0x1
ffffffffc0204a74:	00fb8533          	add	a0,s7,a5
ffffffffc0204a78:	41550533          	sub	a0,a0,s5
                size -= la - end;
ffffffffc0204a7c:	41790a33          	sub	s4,s2,s7
            if (end < la)
ffffffffc0204a80:	0b597d63          	bgeu	s2,s5,ffffffffc0204b3a <do_execve+0x44e>
    return page - pages + nbase;
ffffffffc0204a84:	000cb683          	ld	a3,0(s9)
ffffffffc0204a88:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204a8a:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204a8e:	40d406b3          	sub	a3,s0,a3
ffffffffc0204a92:	8699                	srai	a3,a3,0x6
ffffffffc0204a94:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204a96:	67e2                	ld	a5,24(sp)
ffffffffc0204a98:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204a9c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204a9e:	0ac5f963          	bgeu	a1,a2,ffffffffc0204b50 <do_execve+0x464>
ffffffffc0204aa2:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204aa6:	8652                	mv	a2,s4
ffffffffc0204aa8:	4581                	li	a1,0
ffffffffc0204aaa:	96c2                	add	a3,a3,a6
ffffffffc0204aac:	9536                	add	a0,a0,a3
ffffffffc0204aae:	583000ef          	jal	ra,ffffffffc0205830 <memset>
            start += size;
ffffffffc0204ab2:	017a0733          	add	a4,s4,s7
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204ab6:	03597463          	bgeu	s2,s5,ffffffffc0204ade <do_execve+0x3f2>
ffffffffc0204aba:	d6e909e3          	beq	s2,a4,ffffffffc020482c <do_execve+0x140>
ffffffffc0204abe:	00002697          	auipc	a3,0x2
ffffffffc0204ac2:	7ca68693          	addi	a3,a3,1994 # ffffffffc0207288 <default_pmm_manager+0xbf8>
ffffffffc0204ac6:	00002617          	auipc	a2,0x2
ffffffffc0204aca:	81a60613          	addi	a2,a2,-2022 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204ace:	2c600593          	li	a1,710
ffffffffc0204ad2:	00002517          	auipc	a0,0x2
ffffffffc0204ad6:	5ee50513          	addi	a0,a0,1518 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204ada:	9b9fb0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0204ade:	ff5710e3          	bne	a4,s5,ffffffffc0204abe <do_execve+0x3d2>
ffffffffc0204ae2:	8bd6                	mv	s7,s5
        while (start < end)
ffffffffc0204ae4:	d52bf4e3          	bgeu	s7,s2,ffffffffc020482c <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204ae8:	6c88                	ld	a0,24(s1)
ffffffffc0204aea:	866a                	mv	a2,s10
ffffffffc0204aec:	85d6                	mv	a1,s5
ffffffffc0204aee:	a4bfe0ef          	jal	ra,ffffffffc0203538 <pgdir_alloc_page>
ffffffffc0204af2:	842a                	mv	s0,a0
ffffffffc0204af4:	dd05                	beqz	a0,ffffffffc0204a2c <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204af6:	6785                	lui	a5,0x1
ffffffffc0204af8:	415b8533          	sub	a0,s7,s5
ffffffffc0204afc:	9abe                	add	s5,s5,a5
ffffffffc0204afe:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204b02:	01597463          	bgeu	s2,s5,ffffffffc0204b0a <do_execve+0x41e>
                size -= la - end;
ffffffffc0204b06:	41790633          	sub	a2,s2,s7
    return page - pages + nbase;
ffffffffc0204b0a:	000cb683          	ld	a3,0(s9)
ffffffffc0204b0e:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b10:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204b14:	40d406b3          	sub	a3,s0,a3
ffffffffc0204b18:	8699                	srai	a3,a3,0x6
ffffffffc0204b1a:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b1c:	67e2                	ld	a5,24(sp)
ffffffffc0204b1e:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b22:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b24:	02b87663          	bgeu	a6,a1,ffffffffc0204b50 <do_execve+0x464>
ffffffffc0204b28:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204b2c:	4581                	li	a1,0
            start += size;
ffffffffc0204b2e:	9bb2                	add	s7,s7,a2
ffffffffc0204b30:	96c2                	add	a3,a3,a6
            memset(page2kva(page) + off, 0, size);
ffffffffc0204b32:	9536                	add	a0,a0,a3
ffffffffc0204b34:	4fd000ef          	jal	ra,ffffffffc0205830 <memset>
ffffffffc0204b38:	b775                	j	ffffffffc0204ae4 <do_execve+0x3f8>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204b3a:	417a8a33          	sub	s4,s5,s7
ffffffffc0204b3e:	b799                	j	ffffffffc0204a84 <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204b40:	5a75                	li	s4,-3
ffffffffc0204b42:	b3c1                	j	ffffffffc0204902 <do_execve+0x216>
        while (start < end)
ffffffffc0204b44:	86de                	mv	a3,s7
ffffffffc0204b46:	bf39                	j	ffffffffc0204a64 <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204b48:	5a71                	li	s4,-4
ffffffffc0204b4a:	bdc5                	j	ffffffffc0204a3a <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204b4c:	5a61                	li	s4,-8
ffffffffc0204b4e:	b5c5                	j	ffffffffc0204a2e <do_execve+0x342>
ffffffffc0204b50:	00002617          	auipc	a2,0x2
ffffffffc0204b54:	b7860613          	addi	a2,a2,-1160 # ffffffffc02066c8 <default_pmm_manager+0x38>
ffffffffc0204b58:	07100593          	li	a1,113
ffffffffc0204b5c:	00002517          	auipc	a0,0x2
ffffffffc0204b60:	b9450513          	addi	a0,a0,-1132 # ffffffffc02066f0 <default_pmm_manager+0x60>
ffffffffc0204b64:	92ffb0ef          	jal	ra,ffffffffc0200492 <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204b68:	00002617          	auipc	a2,0x2
ffffffffc0204b6c:	c0860613          	addi	a2,a2,-1016 # ffffffffc0206770 <default_pmm_manager+0xe0>
ffffffffc0204b70:	2e500593          	li	a1,741
ffffffffc0204b74:	00002517          	auipc	a0,0x2
ffffffffc0204b78:	54c50513          	addi	a0,a0,1356 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204b7c:	917fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204b80:	00003697          	auipc	a3,0x3
ffffffffc0204b84:	82068693          	addi	a3,a3,-2016 # ffffffffc02073a0 <default_pmm_manager+0xd10>
ffffffffc0204b88:	00001617          	auipc	a2,0x1
ffffffffc0204b8c:	75860613          	addi	a2,a2,1880 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204b90:	2e000593          	li	a1,736
ffffffffc0204b94:	00002517          	auipc	a0,0x2
ffffffffc0204b98:	52c50513          	addi	a0,a0,1324 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204b9c:	8f7fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204ba0:	00002697          	auipc	a3,0x2
ffffffffc0204ba4:	7b868693          	addi	a3,a3,1976 # ffffffffc0207358 <default_pmm_manager+0xcc8>
ffffffffc0204ba8:	00001617          	auipc	a2,0x1
ffffffffc0204bac:	73860613          	addi	a2,a2,1848 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204bb0:	2df00593          	li	a1,735
ffffffffc0204bb4:	00002517          	auipc	a0,0x2
ffffffffc0204bb8:	50c50513          	addi	a0,a0,1292 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204bbc:	8d7fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204bc0:	00002697          	auipc	a3,0x2
ffffffffc0204bc4:	75068693          	addi	a3,a3,1872 # ffffffffc0207310 <default_pmm_manager+0xc80>
ffffffffc0204bc8:	00001617          	auipc	a2,0x1
ffffffffc0204bcc:	71860613          	addi	a2,a2,1816 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204bd0:	2de00593          	li	a1,734
ffffffffc0204bd4:	00002517          	auipc	a0,0x2
ffffffffc0204bd8:	4ec50513          	addi	a0,a0,1260 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204bdc:	8b7fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204be0:	00002697          	auipc	a3,0x2
ffffffffc0204be4:	6e868693          	addi	a3,a3,1768 # ffffffffc02072c8 <default_pmm_manager+0xc38>
ffffffffc0204be8:	00001617          	auipc	a2,0x1
ffffffffc0204bec:	6f860613          	addi	a2,a2,1784 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204bf0:	2dd00593          	li	a1,733
ffffffffc0204bf4:	00002517          	auipc	a0,0x2
ffffffffc0204bf8:	4cc50513          	addi	a0,a0,1228 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204bfc:	897fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204c00 <user_main>:
{
ffffffffc0204c00:	1101                	addi	sp,sp,-32
ffffffffc0204c02:	e04a                	sd	s2,0(sp)
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0204c04:	000c2917          	auipc	s2,0xc2
ffffffffc0204c08:	fbc90913          	addi	s2,s2,-68 # ffffffffc02c6bc0 <current>
ffffffffc0204c0c:	00093783          	ld	a5,0(s2)
ffffffffc0204c10:	00002617          	auipc	a2,0x2
ffffffffc0204c14:	7d860613          	addi	a2,a2,2008 # ffffffffc02073e8 <default_pmm_manager+0xd58>
ffffffffc0204c18:	00002517          	auipc	a0,0x2
ffffffffc0204c1c:	7e050513          	addi	a0,a0,2016 # ffffffffc02073f8 <default_pmm_manager+0xd68>
ffffffffc0204c20:	43cc                	lw	a1,4(a5)
{
ffffffffc0204c22:	ec06                	sd	ra,24(sp)
ffffffffc0204c24:	e822                	sd	s0,16(sp)
ffffffffc0204c26:	e426                	sd	s1,8(sp)
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
ffffffffc0204c28:	d70fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    size_t len = strlen(name);
ffffffffc0204c2c:	00002517          	auipc	a0,0x2
ffffffffc0204c30:	7bc50513          	addi	a0,a0,1980 # ffffffffc02073e8 <default_pmm_manager+0xd58>
ffffffffc0204c34:	35b000ef          	jal	ra,ffffffffc020578e <strlen>
    struct trapframe *old_tf = current->tf;
ffffffffc0204c38:	00093783          	ld	a5,0(s2)
    size_t len = strlen(name);
ffffffffc0204c3c:	84aa                	mv	s1,a0
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204c3e:	12000613          	li	a2,288
    struct trapframe *new_tf = (struct trapframe *)(current->kstack + KSTACKSIZE - sizeof(struct trapframe));
ffffffffc0204c42:	6b80                	ld	s0,16(a5)
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204c44:	73cc                	ld	a1,160(a5)
    struct trapframe *new_tf = (struct trapframe *)(current->kstack + KSTACKSIZE - sizeof(struct trapframe));
ffffffffc0204c46:	6789                	lui	a5,0x2
ffffffffc0204c48:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x8058>
ffffffffc0204c4c:	943e                	add	s0,s0,a5
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204c4e:	8522                	mv	a0,s0
ffffffffc0204c50:	3f3000ef          	jal	ra,ffffffffc0205842 <memcpy>
    current->tf = new_tf;
ffffffffc0204c54:	00093783          	ld	a5,0(s2)
    ret = do_execve(name, len, binary, size);
ffffffffc0204c58:	3fe07697          	auipc	a3,0x3fe07
ffffffffc0204c5c:	ae868693          	addi	a3,a3,-1304 # b740 <_binary_obj___user_priority_out_size>
ffffffffc0204c60:	0007d617          	auipc	a2,0x7d
ffffffffc0204c64:	0a860613          	addi	a2,a2,168 # ffffffffc0281d08 <_binary_obj___user_priority_out_start>
    current->tf = new_tf;
ffffffffc0204c68:	f3c0                	sd	s0,160(a5)
    ret = do_execve(name, len, binary, size);
ffffffffc0204c6a:	85a6                	mv	a1,s1
ffffffffc0204c6c:	00002517          	auipc	a0,0x2
ffffffffc0204c70:	77c50513          	addi	a0,a0,1916 # ffffffffc02073e8 <default_pmm_manager+0xd58>
ffffffffc0204c74:	a79ff0ef          	jal	ra,ffffffffc02046ec <do_execve>
    asm volatile(
ffffffffc0204c78:	8122                	mv	sp,s0
ffffffffc0204c7a:	9eafc06f          	j	ffffffffc0200e64 <__trapret>
    panic("user_main execve failed.\n");
ffffffffc0204c7e:	00002617          	auipc	a2,0x2
ffffffffc0204c82:	7a260613          	addi	a2,a2,1954 # ffffffffc0207420 <default_pmm_manager+0xd90>
ffffffffc0204c86:	3c900593          	li	a1,969
ffffffffc0204c8a:	00002517          	auipc	a0,0x2
ffffffffc0204c8e:	43650513          	addi	a0,a0,1078 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204c92:	801fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204c96 <do_yield>:
    current->need_resched = 1;
ffffffffc0204c96:	000c2797          	auipc	a5,0xc2
ffffffffc0204c9a:	f2a7b783          	ld	a5,-214(a5) # ffffffffc02c6bc0 <current>
ffffffffc0204c9e:	4705                	li	a4,1
ffffffffc0204ca0:	ef98                	sd	a4,24(a5)
}
ffffffffc0204ca2:	4501                	li	a0,0
ffffffffc0204ca4:	8082                	ret

ffffffffc0204ca6 <do_wait>:
{
ffffffffc0204ca6:	1101                	addi	sp,sp,-32
ffffffffc0204ca8:	e822                	sd	s0,16(sp)
ffffffffc0204caa:	e426                	sd	s1,8(sp)
ffffffffc0204cac:	ec06                	sd	ra,24(sp)
ffffffffc0204cae:	842e                	mv	s0,a1
ffffffffc0204cb0:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204cb2:	c999                	beqz	a1,ffffffffc0204cc8 <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204cb4:	000c2797          	auipc	a5,0xc2
ffffffffc0204cb8:	f0c7b783          	ld	a5,-244(a5) # ffffffffc02c6bc0 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204cbc:	7788                	ld	a0,40(a5)
ffffffffc0204cbe:	4685                	li	a3,1
ffffffffc0204cc0:	4611                	li	a2,4
ffffffffc0204cc2:	fd3fe0ef          	jal	ra,ffffffffc0203c94 <user_mem_check>
ffffffffc0204cc6:	c909                	beqz	a0,ffffffffc0204cd8 <do_wait+0x32>
ffffffffc0204cc8:	85a2                	mv	a1,s0
}
ffffffffc0204cca:	6442                	ld	s0,16(sp)
ffffffffc0204ccc:	60e2                	ld	ra,24(sp)
ffffffffc0204cce:	8526                	mv	a0,s1
ffffffffc0204cd0:	64a2                	ld	s1,8(sp)
ffffffffc0204cd2:	6105                	addi	sp,sp,32
ffffffffc0204cd4:	f22ff06f          	j	ffffffffc02043f6 <do_wait.part.0>
ffffffffc0204cd8:	60e2                	ld	ra,24(sp)
ffffffffc0204cda:	6442                	ld	s0,16(sp)
ffffffffc0204cdc:	64a2                	ld	s1,8(sp)
ffffffffc0204cde:	5575                	li	a0,-3
ffffffffc0204ce0:	6105                	addi	sp,sp,32
ffffffffc0204ce2:	8082                	ret

ffffffffc0204ce4 <do_kill>:
{
ffffffffc0204ce4:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204ce6:	6789                	lui	a5,0x2
{
ffffffffc0204ce8:	e406                	sd	ra,8(sp)
ffffffffc0204cea:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204cec:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204cf0:	17f9                	addi	a5,a5,-2
ffffffffc0204cf2:	02e7e963          	bltu	a5,a4,ffffffffc0204d24 <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204cf6:	842a                	mv	s0,a0
ffffffffc0204cf8:	45a9                	li	a1,10
ffffffffc0204cfa:	2501                	sext.w	a0,a0
ffffffffc0204cfc:	68e000ef          	jal	ra,ffffffffc020538a <hash32>
ffffffffc0204d00:	02051793          	slli	a5,a0,0x20
ffffffffc0204d04:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204d08:	000be797          	auipc	a5,0xbe
ffffffffc0204d0c:	e2078793          	addi	a5,a5,-480 # ffffffffc02c2b28 <hash_list>
ffffffffc0204d10:	953e                	add	a0,a0,a5
ffffffffc0204d12:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204d14:	a029                	j	ffffffffc0204d1e <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204d16:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204d1a:	00870b63          	beq	a4,s0,ffffffffc0204d30 <do_kill+0x4c>
ffffffffc0204d1e:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204d20:	fef51be3          	bne	a0,a5,ffffffffc0204d16 <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204d24:	5475                	li	s0,-3
}
ffffffffc0204d26:	60a2                	ld	ra,8(sp)
ffffffffc0204d28:	8522                	mv	a0,s0
ffffffffc0204d2a:	6402                	ld	s0,0(sp)
ffffffffc0204d2c:	0141                	addi	sp,sp,16
ffffffffc0204d2e:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204d30:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204d34:	00177693          	andi	a3,a4,1
ffffffffc0204d38:	e295                	bnez	a3,ffffffffc0204d5c <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204d3a:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204d3c:	00176713          	ori	a4,a4,1
ffffffffc0204d40:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204d44:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204d46:	fe06d0e3          	bgez	a3,ffffffffc0204d26 <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204d4a:	f2878513          	addi	a0,a5,-216
ffffffffc0204d4e:	3ca000ef          	jal	ra,ffffffffc0205118 <wakeup_proc>
}
ffffffffc0204d52:	60a2                	ld	ra,8(sp)
ffffffffc0204d54:	8522                	mv	a0,s0
ffffffffc0204d56:	6402                	ld	s0,0(sp)
ffffffffc0204d58:	0141                	addi	sp,sp,16
ffffffffc0204d5a:	8082                	ret
        return -E_KILLED;
ffffffffc0204d5c:	545d                	li	s0,-9
ffffffffc0204d5e:	b7e1                	j	ffffffffc0204d26 <do_kill+0x42>

ffffffffc0204d60 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204d60:	1101                	addi	sp,sp,-32
ffffffffc0204d62:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204d64:	000c2797          	auipc	a5,0xc2
ffffffffc0204d68:	dc478793          	addi	a5,a5,-572 # ffffffffc02c6b28 <proc_list>
ffffffffc0204d6c:	ec06                	sd	ra,24(sp)
ffffffffc0204d6e:	e822                	sd	s0,16(sp)
ffffffffc0204d70:	e04a                	sd	s2,0(sp)
ffffffffc0204d72:	000be497          	auipc	s1,0xbe
ffffffffc0204d76:	db648493          	addi	s1,s1,-586 # ffffffffc02c2b28 <hash_list>
ffffffffc0204d7a:	e79c                	sd	a5,8(a5)
ffffffffc0204d7c:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204d7e:	000c2717          	auipc	a4,0xc2
ffffffffc0204d82:	daa70713          	addi	a4,a4,-598 # ffffffffc02c6b28 <proc_list>
ffffffffc0204d86:	87a6                	mv	a5,s1
ffffffffc0204d88:	e79c                	sd	a5,8(a5)
ffffffffc0204d8a:	e39c                	sd	a5,0(a5)
ffffffffc0204d8c:	07c1                	addi	a5,a5,16
ffffffffc0204d8e:	fef71de3          	bne	a4,a5,ffffffffc0204d88 <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204d92:	f9ffe0ef          	jal	ra,ffffffffc0203d30 <alloc_proc>
ffffffffc0204d96:	000c2917          	auipc	s2,0xc2
ffffffffc0204d9a:	e3290913          	addi	s2,s2,-462 # ffffffffc02c6bc8 <idleproc>
ffffffffc0204d9e:	00a93023          	sd	a0,0(s2)
ffffffffc0204da2:	0e050f63          	beqz	a0,ffffffffc0204ea0 <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204da6:	4789                	li	a5,2
ffffffffc0204da8:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204daa:	00004797          	auipc	a5,0x4
ffffffffc0204dae:	25678793          	addi	a5,a5,598 # ffffffffc0209000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204db2:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204db6:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204db8:	4785                	li	a5,1
ffffffffc0204dba:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204dbc:	4641                	li	a2,16
ffffffffc0204dbe:	4581                	li	a1,0
ffffffffc0204dc0:	8522                	mv	a0,s0
ffffffffc0204dc2:	26f000ef          	jal	ra,ffffffffc0205830 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204dc6:	463d                	li	a2,15
ffffffffc0204dc8:	00002597          	auipc	a1,0x2
ffffffffc0204dcc:	69058593          	addi	a1,a1,1680 # ffffffffc0207458 <default_pmm_manager+0xdc8>
ffffffffc0204dd0:	8522                	mv	a0,s0
ffffffffc0204dd2:	271000ef          	jal	ra,ffffffffc0205842 <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204dd6:	000c2717          	auipc	a4,0xc2
ffffffffc0204dda:	e0270713          	addi	a4,a4,-510 # ffffffffc02c6bd8 <nr_process>
ffffffffc0204dde:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204de0:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204de4:	4601                	li	a2,0
    nr_process++;
ffffffffc0204de6:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204de8:	4581                	li	a1,0
ffffffffc0204dea:	fffff517          	auipc	a0,0xfffff
ffffffffc0204dee:	7de50513          	addi	a0,a0,2014 # ffffffffc02045c8 <init_main>
    nr_process++;
ffffffffc0204df2:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204df4:	000c2797          	auipc	a5,0xc2
ffffffffc0204df8:	dcd7b623          	sd	a3,-564(a5) # ffffffffc02c6bc0 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204dfc:	c60ff0ef          	jal	ra,ffffffffc020425c <kernel_thread>
ffffffffc0204e00:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204e02:	08a05363          	blez	a0,ffffffffc0204e88 <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204e06:	6789                	lui	a5,0x2
ffffffffc0204e08:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204e0c:	17f9                	addi	a5,a5,-2
ffffffffc0204e0e:	2501                	sext.w	a0,a0
ffffffffc0204e10:	02e7e363          	bltu	a5,a4,ffffffffc0204e36 <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204e14:	45a9                	li	a1,10
ffffffffc0204e16:	574000ef          	jal	ra,ffffffffc020538a <hash32>
ffffffffc0204e1a:	02051793          	slli	a5,a0,0x20
ffffffffc0204e1e:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204e22:	96a6                	add	a3,a3,s1
ffffffffc0204e24:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204e26:	a029                	j	ffffffffc0204e30 <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204e28:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x800c>
ffffffffc0204e2c:	04870b63          	beq	a4,s0,ffffffffc0204e82 <proc_init+0x122>
    return listelm->next;
ffffffffc0204e30:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204e32:	fef69be3          	bne	a3,a5,ffffffffc0204e28 <proc_init+0xc8>
    return NULL;
ffffffffc0204e36:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e38:	0b478493          	addi	s1,a5,180
ffffffffc0204e3c:	4641                	li	a2,16
ffffffffc0204e3e:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204e40:	000c2417          	auipc	s0,0xc2
ffffffffc0204e44:	d9040413          	addi	s0,s0,-624 # ffffffffc02c6bd0 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e48:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204e4a:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e4c:	1e5000ef          	jal	ra,ffffffffc0205830 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204e50:	463d                	li	a2,15
ffffffffc0204e52:	00002597          	auipc	a1,0x2
ffffffffc0204e56:	62e58593          	addi	a1,a1,1582 # ffffffffc0207480 <default_pmm_manager+0xdf0>
ffffffffc0204e5a:	8526                	mv	a0,s1
ffffffffc0204e5c:	1e7000ef          	jal	ra,ffffffffc0205842 <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204e60:	00093783          	ld	a5,0(s2)
ffffffffc0204e64:	cbb5                	beqz	a5,ffffffffc0204ed8 <proc_init+0x178>
ffffffffc0204e66:	43dc                	lw	a5,4(a5)
ffffffffc0204e68:	eba5                	bnez	a5,ffffffffc0204ed8 <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204e6a:	601c                	ld	a5,0(s0)
ffffffffc0204e6c:	c7b1                	beqz	a5,ffffffffc0204eb8 <proc_init+0x158>
ffffffffc0204e6e:	43d8                	lw	a4,4(a5)
ffffffffc0204e70:	4785                	li	a5,1
ffffffffc0204e72:	04f71363          	bne	a4,a5,ffffffffc0204eb8 <proc_init+0x158>
}
ffffffffc0204e76:	60e2                	ld	ra,24(sp)
ffffffffc0204e78:	6442                	ld	s0,16(sp)
ffffffffc0204e7a:	64a2                	ld	s1,8(sp)
ffffffffc0204e7c:	6902                	ld	s2,0(sp)
ffffffffc0204e7e:	6105                	addi	sp,sp,32
ffffffffc0204e80:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204e82:	f2878793          	addi	a5,a5,-216
ffffffffc0204e86:	bf4d                	j	ffffffffc0204e38 <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204e88:	00002617          	auipc	a2,0x2
ffffffffc0204e8c:	5d860613          	addi	a2,a2,1496 # ffffffffc0207460 <default_pmm_manager+0xdd0>
ffffffffc0204e90:	40500593          	li	a1,1029
ffffffffc0204e94:	00002517          	auipc	a0,0x2
ffffffffc0204e98:	22c50513          	addi	a0,a0,556 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204e9c:	df6fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204ea0:	00002617          	auipc	a2,0x2
ffffffffc0204ea4:	5a060613          	addi	a2,a2,1440 # ffffffffc0207440 <default_pmm_manager+0xdb0>
ffffffffc0204ea8:	3f600593          	li	a1,1014
ffffffffc0204eac:	00002517          	auipc	a0,0x2
ffffffffc0204eb0:	21450513          	addi	a0,a0,532 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204eb4:	ddefb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204eb8:	00002697          	auipc	a3,0x2
ffffffffc0204ebc:	5f868693          	addi	a3,a3,1528 # ffffffffc02074b0 <default_pmm_manager+0xe20>
ffffffffc0204ec0:	00001617          	auipc	a2,0x1
ffffffffc0204ec4:	42060613          	addi	a2,a2,1056 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204ec8:	40c00593          	li	a1,1036
ffffffffc0204ecc:	00002517          	auipc	a0,0x2
ffffffffc0204ed0:	1f450513          	addi	a0,a0,500 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204ed4:	dbefb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204ed8:	00002697          	auipc	a3,0x2
ffffffffc0204edc:	5b068693          	addi	a3,a3,1456 # ffffffffc0207488 <default_pmm_manager+0xdf8>
ffffffffc0204ee0:	00001617          	auipc	a2,0x1
ffffffffc0204ee4:	40060613          	addi	a2,a2,1024 # ffffffffc02062e0 <commands+0x818>
ffffffffc0204ee8:	40b00593          	li	a1,1035
ffffffffc0204eec:	00002517          	auipc	a0,0x2
ffffffffc0204ef0:	1d450513          	addi	a0,a0,468 # ffffffffc02070c0 <default_pmm_manager+0xa30>
ffffffffc0204ef4:	d9efb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204ef8 <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204ef8:	1141                	addi	sp,sp,-16
ffffffffc0204efa:	e022                	sd	s0,0(sp)
ffffffffc0204efc:	e406                	sd	ra,8(sp)
ffffffffc0204efe:	000c2417          	auipc	s0,0xc2
ffffffffc0204f02:	cc240413          	addi	s0,s0,-830 # ffffffffc02c6bc0 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0204f06:	6018                	ld	a4,0(s0)
ffffffffc0204f08:	6f1c                	ld	a5,24(a4)
ffffffffc0204f0a:	dffd                	beqz	a5,ffffffffc0204f08 <cpu_idle+0x10>
        {
            schedule();
ffffffffc0204f0c:	2be000ef          	jal	ra,ffffffffc02051ca <schedule>
ffffffffc0204f10:	bfdd                	j	ffffffffc0204f06 <cpu_idle+0xe>

ffffffffc0204f12 <lab6_set_priority>:
        }
    }
}
// FOR LAB6, set the process's priority (bigger value will get more CPU time)
void lab6_set_priority(uint32_t priority)
{
ffffffffc0204f12:	1141                	addi	sp,sp,-16
ffffffffc0204f14:	e022                	sd	s0,0(sp)
    cprintf("set priority to %d\n", priority);
ffffffffc0204f16:	85aa                	mv	a1,a0
{
ffffffffc0204f18:	842a                	mv	s0,a0
    cprintf("set priority to %d\n", priority);
ffffffffc0204f1a:	00002517          	auipc	a0,0x2
ffffffffc0204f1e:	5be50513          	addi	a0,a0,1470 # ffffffffc02074d8 <default_pmm_manager+0xe48>
{
ffffffffc0204f22:	e406                	sd	ra,8(sp)
    cprintf("set priority to %d\n", priority);
ffffffffc0204f24:	a74fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    if (priority == 0)
        current->lab6_priority = 1;
ffffffffc0204f28:	000c2797          	auipc	a5,0xc2
ffffffffc0204f2c:	c987b783          	ld	a5,-872(a5) # ffffffffc02c6bc0 <current>
    if (priority == 0)
ffffffffc0204f30:	e801                	bnez	s0,ffffffffc0204f40 <lab6_set_priority+0x2e>
    else
        current->lab6_priority = priority;
}
ffffffffc0204f32:	60a2                	ld	ra,8(sp)
ffffffffc0204f34:	6402                	ld	s0,0(sp)
        current->lab6_priority = 1;
ffffffffc0204f36:	4705                	li	a4,1
ffffffffc0204f38:	14e7a223          	sw	a4,324(a5)
}
ffffffffc0204f3c:	0141                	addi	sp,sp,16
ffffffffc0204f3e:	8082                	ret
ffffffffc0204f40:	60a2                	ld	ra,8(sp)
        current->lab6_priority = priority;
ffffffffc0204f42:	1487a223          	sw	s0,324(a5)
}
ffffffffc0204f46:	6402                	ld	s0,0(sp)
ffffffffc0204f48:	0141                	addi	sp,sp,16
ffffffffc0204f4a:	8082                	ret

ffffffffc0204f4c <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0204f4c:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0204f50:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0204f54:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0204f56:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0204f58:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0204f5c:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0204f60:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0204f64:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0204f68:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0204f6c:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0204f70:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0204f74:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0204f78:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0204f7c:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0204f80:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0204f84:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0204f88:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0204f8a:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0204f8c:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0204f90:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0204f94:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0204f98:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0204f9c:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0204fa0:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0204fa4:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0204fa8:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0204fac:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0204fb0:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0204fb4:	8082                	ret

ffffffffc0204fb6 <RR_init>:
    elm->prev = elm->next = elm;
ffffffffc0204fb6:	e508                	sd	a0,8(a0)
ffffffffc0204fb8:	e108                	sd	a0,0(a0)
static void
RR_init(struct run_queue *rq)
{
    // LAB6: YOUR CODE 2310648 2313892
    list_init(&(rq->run_list));
    rq->proc_num = 0;
ffffffffc0204fba:	00052823          	sw	zero,16(a0)
}
ffffffffc0204fbe:	8082                	ret

ffffffffc0204fc0 <RR_pick_next>:
    return listelm->next;
ffffffffc0204fc0:	651c                	ld	a5,8(a0)
static struct proc_struct *
RR_pick_next(struct run_queue *rq)
{
    // LAB6: YOUR CODE 2310648 2313892
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
ffffffffc0204fc2:	00f50563          	beq	a0,a5,ffffffffc0204fcc <RR_pick_next+0xc>
        return le2proc(le, run_link);
ffffffffc0204fc6:	ef078513          	addi	a0,a5,-272
ffffffffc0204fca:	8082                	ret
    }
    return NULL;
ffffffffc0204fcc:	4501                	li	a0,0
}
ffffffffc0204fce:	8082                	ret

ffffffffc0204fd0 <RR_proc_tick>:
 */
static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: YOUR CODE 2310648 2313892
    if (proc->time_slice > 0) {
ffffffffc0204fd0:	1205a783          	lw	a5,288(a1)
ffffffffc0204fd4:	00f05563          	blez	a5,ffffffffc0204fde <RR_proc_tick+0xe>
        proc->time_slice --;
ffffffffc0204fd8:	37fd                	addiw	a5,a5,-1
ffffffffc0204fda:	12f5a023          	sw	a5,288(a1)
    }
    if (proc->time_slice == 0) {
ffffffffc0204fde:	e399                	bnez	a5,ffffffffc0204fe4 <RR_proc_tick+0x14>
        proc->need_resched = 1;
ffffffffc0204fe0:	4785                	li	a5,1
ffffffffc0204fe2:	ed9c                	sd	a5,24(a1)
    }
}
ffffffffc0204fe4:	8082                	ret

ffffffffc0204fe6 <RR_dequeue>:
    return list->next == list;
ffffffffc0204fe6:	1185b703          	ld	a4,280(a1)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc0204fea:	11058793          	addi	a5,a1,272
ffffffffc0204fee:	02e78363          	beq	a5,a4,ffffffffc0205014 <RR_dequeue+0x2e>
ffffffffc0204ff2:	1085b683          	ld	a3,264(a1)
ffffffffc0204ff6:	00a69f63          	bne	a3,a0,ffffffffc0205014 <RR_dequeue+0x2e>
    __list_del(listelm->prev, listelm->next);
ffffffffc0204ffa:	1105b503          	ld	a0,272(a1)
    rq->proc_num --;
ffffffffc0204ffe:	4a90                	lw	a2,16(a3)
    prev->next = next;
ffffffffc0205000:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc0205002:	e308                	sd	a0,0(a4)
    elm->prev = elm->next = elm;
ffffffffc0205004:	10f5bc23          	sd	a5,280(a1)
ffffffffc0205008:	10f5b823          	sd	a5,272(a1)
ffffffffc020500c:	fff6079b          	addiw	a5,a2,-1
ffffffffc0205010:	ca9c                	sw	a5,16(a3)
ffffffffc0205012:	8082                	ret
{
ffffffffc0205014:	1141                	addi	sp,sp,-16
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc0205016:	00002697          	auipc	a3,0x2
ffffffffc020501a:	4da68693          	addi	a3,a3,1242 # ffffffffc02074f0 <default_pmm_manager+0xe60>
ffffffffc020501e:	00001617          	auipc	a2,0x1
ffffffffc0205022:	2c260613          	addi	a2,a2,706 # ffffffffc02062e0 <commands+0x818>
ffffffffc0205026:	03c00593          	li	a1,60
ffffffffc020502a:	00002517          	auipc	a0,0x2
ffffffffc020502e:	4fe50513          	addi	a0,a0,1278 # ffffffffc0207528 <default_pmm_manager+0xe98>
{
ffffffffc0205032:	e406                	sd	ra,8(sp)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc0205034:	c5efb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0205038 <RR_enqueue>:
    assert(list_empty(&(proc->run_link)));
ffffffffc0205038:	1185b703          	ld	a4,280(a1)
ffffffffc020503c:	11058793          	addi	a5,a1,272
ffffffffc0205040:	02e79d63          	bne	a5,a4,ffffffffc020507a <RR_enqueue+0x42>
    __list_add(elm, listelm->prev, listelm);
ffffffffc0205044:	6118                	ld	a4,0(a0)
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
ffffffffc0205046:	1205a683          	lw	a3,288(a1)
    prev->next = next->prev = elm;
ffffffffc020504a:	e11c                	sd	a5,0(a0)
ffffffffc020504c:	e71c                	sd	a5,8(a4)
    elm->next = next;
ffffffffc020504e:	10a5bc23          	sd	a0,280(a1)
    elm->prev = prev;
ffffffffc0205052:	10e5b823          	sd	a4,272(a1)
ffffffffc0205056:	495c                	lw	a5,20(a0)
ffffffffc0205058:	ea89                	bnez	a3,ffffffffc020506a <RR_enqueue+0x32>
        proc->time_slice = rq->max_time_slice;
ffffffffc020505a:	12f5a023          	sw	a5,288(a1)
    rq->proc_num ++;
ffffffffc020505e:	491c                	lw	a5,16(a0)
    proc->rq = rq;
ffffffffc0205060:	10a5b423          	sd	a0,264(a1)
    rq->proc_num ++;
ffffffffc0205064:	2785                	addiw	a5,a5,1
ffffffffc0205066:	c91c                	sw	a5,16(a0)
ffffffffc0205068:	8082                	ret
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
ffffffffc020506a:	fed7c8e3          	blt	a5,a3,ffffffffc020505a <RR_enqueue+0x22>
    rq->proc_num ++;
ffffffffc020506e:	491c                	lw	a5,16(a0)
    proc->rq = rq;
ffffffffc0205070:	10a5b423          	sd	a0,264(a1)
    rq->proc_num ++;
ffffffffc0205074:	2785                	addiw	a5,a5,1
ffffffffc0205076:	c91c                	sw	a5,16(a0)
ffffffffc0205078:	8082                	ret
{
ffffffffc020507a:	1141                	addi	sp,sp,-16
    assert(list_empty(&(proc->run_link)));
ffffffffc020507c:	00002697          	auipc	a3,0x2
ffffffffc0205080:	4cc68693          	addi	a3,a3,1228 # ffffffffc0207548 <default_pmm_manager+0xeb8>
ffffffffc0205084:	00001617          	auipc	a2,0x1
ffffffffc0205088:	25c60613          	addi	a2,a2,604 # ffffffffc02062e0 <commands+0x818>
ffffffffc020508c:	02800593          	li	a1,40
ffffffffc0205090:	00002517          	auipc	a0,0x2
ffffffffc0205094:	49850513          	addi	a0,a0,1176 # ffffffffc0207528 <default_pmm_manager+0xe98>
{
ffffffffc0205098:	e406                	sd	ra,8(sp)
    assert(list_empty(&(proc->run_link)));
ffffffffc020509a:	bf8fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020509e <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void sched_class_proc_tick(struct proc_struct *proc)
{
    if (proc != idleproc)
ffffffffc020509e:	000c2797          	auipc	a5,0xc2
ffffffffc02050a2:	b2a7b783          	ld	a5,-1238(a5) # ffffffffc02c6bc8 <idleproc>
{
ffffffffc02050a6:	85aa                	mv	a1,a0
    if (proc != idleproc)
ffffffffc02050a8:	00a78c63          	beq	a5,a0,ffffffffc02050c0 <sched_class_proc_tick+0x22>
    {
        sched_class->proc_tick(rq, proc);
ffffffffc02050ac:	000c2797          	auipc	a5,0xc2
ffffffffc02050b0:	b3c7b783          	ld	a5,-1220(a5) # ffffffffc02c6be8 <sched_class>
ffffffffc02050b4:	779c                	ld	a5,40(a5)
ffffffffc02050b6:	000c2517          	auipc	a0,0xc2
ffffffffc02050ba:	b2a53503          	ld	a0,-1238(a0) # ffffffffc02c6be0 <rq>
ffffffffc02050be:	8782                	jr	a5
    }
    else
    {
        proc->need_resched = 1;
ffffffffc02050c0:	4705                	li	a4,1
ffffffffc02050c2:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc02050c4:	8082                	ret

ffffffffc02050c6 <sched_init>:

static struct run_queue __rq;

void sched_init(void)
{
ffffffffc02050c6:	1141                	addi	sp,sp,-16
    list_init(&timer_list);

    sched_class = &default_sched_class;
ffffffffc02050c8:	000bd717          	auipc	a4,0xbd
ffffffffc02050cc:	60870713          	addi	a4,a4,1544 # ffffffffc02c26d0 <default_sched_class>
{
ffffffffc02050d0:	e022                	sd	s0,0(sp)
ffffffffc02050d2:	e406                	sd	ra,8(sp)
    elm->prev = elm->next = elm;
ffffffffc02050d4:	000c2797          	auipc	a5,0xc2
ffffffffc02050d8:	a8478793          	addi	a5,a5,-1404 # ffffffffc02c6b58 <timer_list>

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc02050dc:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc02050de:	000c2517          	auipc	a0,0xc2
ffffffffc02050e2:	a5a50513          	addi	a0,a0,-1446 # ffffffffc02c6b38 <__rq>
ffffffffc02050e6:	e79c                	sd	a5,8(a5)
ffffffffc02050e8:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc02050ea:	4795                	li	a5,5
ffffffffc02050ec:	c95c                	sw	a5,20(a0)
    sched_class = &default_sched_class;
ffffffffc02050ee:	000c2417          	auipc	s0,0xc2
ffffffffc02050f2:	afa40413          	addi	s0,s0,-1286 # ffffffffc02c6be8 <sched_class>
    rq = &__rq;
ffffffffc02050f6:	000c2797          	auipc	a5,0xc2
ffffffffc02050fa:	aea7b523          	sd	a0,-1302(a5) # ffffffffc02c6be0 <rq>
    sched_class = &default_sched_class;
ffffffffc02050fe:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc0205100:	9682                	jalr	a3

    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0205102:	601c                	ld	a5,0(s0)
}
ffffffffc0205104:	6402                	ld	s0,0(sp)
ffffffffc0205106:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0205108:	638c                	ld	a1,0(a5)
ffffffffc020510a:	00002517          	auipc	a0,0x2
ffffffffc020510e:	46e50513          	addi	a0,a0,1134 # ffffffffc0207578 <default_pmm_manager+0xee8>
}
ffffffffc0205112:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0205114:	884fb06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0205118 <wakeup_proc>:

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205118:	4118                	lw	a4,0(a0)
{
ffffffffc020511a:	1101                	addi	sp,sp,-32
ffffffffc020511c:	ec06                	sd	ra,24(sp)
ffffffffc020511e:	e822                	sd	s0,16(sp)
ffffffffc0205120:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205122:	478d                	li	a5,3
ffffffffc0205124:	08f70363          	beq	a4,a5,ffffffffc02051aa <wakeup_proc+0x92>
ffffffffc0205128:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020512a:	100027f3          	csrr	a5,sstatus
ffffffffc020512e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0205130:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205132:	e7bd                	bnez	a5,ffffffffc02051a0 <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc0205134:	4789                	li	a5,2
ffffffffc0205136:	04f70863          	beq	a4,a5,ffffffffc0205186 <wakeup_proc+0x6e>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc020513a:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc020513c:	0e042623          	sw	zero,236(s0)
            if (proc != current)
ffffffffc0205140:	000c2797          	auipc	a5,0xc2
ffffffffc0205144:	a807b783          	ld	a5,-1408(a5) # ffffffffc02c6bc0 <current>
ffffffffc0205148:	02878363          	beq	a5,s0,ffffffffc020516e <wakeup_proc+0x56>
    if (proc != idleproc)
ffffffffc020514c:	000c2797          	auipc	a5,0xc2
ffffffffc0205150:	a7c7b783          	ld	a5,-1412(a5) # ffffffffc02c6bc8 <idleproc>
ffffffffc0205154:	00f40d63          	beq	s0,a5,ffffffffc020516e <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc0205158:	000c2797          	auipc	a5,0xc2
ffffffffc020515c:	a907b783          	ld	a5,-1392(a5) # ffffffffc02c6be8 <sched_class>
ffffffffc0205160:	6b9c                	ld	a5,16(a5)
ffffffffc0205162:	85a2                	mv	a1,s0
ffffffffc0205164:	000c2517          	auipc	a0,0xc2
ffffffffc0205168:	a7c53503          	ld	a0,-1412(a0) # ffffffffc02c6be0 <rq>
ffffffffc020516c:	9782                	jalr	a5
    if (flag)
ffffffffc020516e:	e491                	bnez	s1,ffffffffc020517a <wakeup_proc+0x62>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0205170:	60e2                	ld	ra,24(sp)
ffffffffc0205172:	6442                	ld	s0,16(sp)
ffffffffc0205174:	64a2                	ld	s1,8(sp)
ffffffffc0205176:	6105                	addi	sp,sp,32
ffffffffc0205178:	8082                	ret
ffffffffc020517a:	6442                	ld	s0,16(sp)
ffffffffc020517c:	60e2                	ld	ra,24(sp)
ffffffffc020517e:	64a2                	ld	s1,8(sp)
ffffffffc0205180:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0205182:	827fb06f          	j	ffffffffc02009a8 <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0205186:	00002617          	auipc	a2,0x2
ffffffffc020518a:	44260613          	addi	a2,a2,1090 # ffffffffc02075c8 <default_pmm_manager+0xf38>
ffffffffc020518e:	05100593          	li	a1,81
ffffffffc0205192:	00002517          	auipc	a0,0x2
ffffffffc0205196:	41e50513          	addi	a0,a0,1054 # ffffffffc02075b0 <default_pmm_manager+0xf20>
ffffffffc020519a:	b60fb0ef          	jal	ra,ffffffffc02004fa <__warn>
ffffffffc020519e:	bfc1                	j	ffffffffc020516e <wakeup_proc+0x56>
        intr_disable();
ffffffffc02051a0:	80ffb0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc02051a4:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc02051a6:	4485                	li	s1,1
ffffffffc02051a8:	b771                	j	ffffffffc0205134 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02051aa:	00002697          	auipc	a3,0x2
ffffffffc02051ae:	3e668693          	addi	a3,a3,998 # ffffffffc0207590 <default_pmm_manager+0xf00>
ffffffffc02051b2:	00001617          	auipc	a2,0x1
ffffffffc02051b6:	12e60613          	addi	a2,a2,302 # ffffffffc02062e0 <commands+0x818>
ffffffffc02051ba:	04200593          	li	a1,66
ffffffffc02051be:	00002517          	auipc	a0,0x2
ffffffffc02051c2:	3f250513          	addi	a0,a0,1010 # ffffffffc02075b0 <default_pmm_manager+0xf20>
ffffffffc02051c6:	accfb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02051ca <schedule>:

void schedule(void)
{
ffffffffc02051ca:	7179                	addi	sp,sp,-48
ffffffffc02051cc:	f406                	sd	ra,40(sp)
ffffffffc02051ce:	f022                	sd	s0,32(sp)
ffffffffc02051d0:	ec26                	sd	s1,24(sp)
ffffffffc02051d2:	e84a                	sd	s2,16(sp)
ffffffffc02051d4:	e44e                	sd	s3,8(sp)
ffffffffc02051d6:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02051d8:	100027f3          	csrr	a5,sstatus
ffffffffc02051dc:	8b89                	andi	a5,a5,2
ffffffffc02051de:	4a01                	li	s4,0
ffffffffc02051e0:	e3cd                	bnez	a5,ffffffffc0205282 <schedule+0xb8>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc02051e2:	000c2497          	auipc	s1,0xc2
ffffffffc02051e6:	9de48493          	addi	s1,s1,-1570 # ffffffffc02c6bc0 <current>
ffffffffc02051ea:	608c                	ld	a1,0(s1)
        sched_class->enqueue(rq, proc);
ffffffffc02051ec:	000c2997          	auipc	s3,0xc2
ffffffffc02051f0:	9fc98993          	addi	s3,s3,-1540 # ffffffffc02c6be8 <sched_class>
ffffffffc02051f4:	000c2917          	auipc	s2,0xc2
ffffffffc02051f8:	9ec90913          	addi	s2,s2,-1556 # ffffffffc02c6be0 <rq>
        if (current->state == PROC_RUNNABLE)
ffffffffc02051fc:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc02051fe:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE)
ffffffffc0205202:	4709                	li	a4,2
        sched_class->enqueue(rq, proc);
ffffffffc0205204:	0009b783          	ld	a5,0(s3)
ffffffffc0205208:	00093503          	ld	a0,0(s2)
        if (current->state == PROC_RUNNABLE)
ffffffffc020520c:	04e68e63          	beq	a3,a4,ffffffffc0205268 <schedule+0x9e>
    return sched_class->pick_next(rq);
ffffffffc0205210:	739c                	ld	a5,32(a5)
ffffffffc0205212:	9782                	jalr	a5
ffffffffc0205214:	842a                	mv	s0,a0
        {
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL)
ffffffffc0205216:	c521                	beqz	a0,ffffffffc020525e <schedule+0x94>
    sched_class->dequeue(rq, proc);
ffffffffc0205218:	0009b783          	ld	a5,0(s3)
ffffffffc020521c:	00093503          	ld	a0,0(s2)
ffffffffc0205220:	85a2                	mv	a1,s0
ffffffffc0205222:	6f9c                	ld	a5,24(a5)
ffffffffc0205224:	9782                	jalr	a5
        }
        if (next == NULL)
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc0205226:	441c                	lw	a5,8(s0)
        if (next != current)
ffffffffc0205228:	6098                	ld	a4,0(s1)
        next->runs++;
ffffffffc020522a:	2785                	addiw	a5,a5,1
ffffffffc020522c:	c41c                	sw	a5,8(s0)
        if (next != current)
ffffffffc020522e:	00870563          	beq	a4,s0,ffffffffc0205238 <schedule+0x6e>
        {
            proc_run(next);
ffffffffc0205232:	8522                	mv	a0,s0
ffffffffc0205234:	c17fe0ef          	jal	ra,ffffffffc0203e4a <proc_run>
    if (flag)
ffffffffc0205238:	000a1a63          	bnez	s4,ffffffffc020524c <schedule+0x82>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc020523c:	70a2                	ld	ra,40(sp)
ffffffffc020523e:	7402                	ld	s0,32(sp)
ffffffffc0205240:	64e2                	ld	s1,24(sp)
ffffffffc0205242:	6942                	ld	s2,16(sp)
ffffffffc0205244:	69a2                	ld	s3,8(sp)
ffffffffc0205246:	6a02                	ld	s4,0(sp)
ffffffffc0205248:	6145                	addi	sp,sp,48
ffffffffc020524a:	8082                	ret
ffffffffc020524c:	7402                	ld	s0,32(sp)
ffffffffc020524e:	70a2                	ld	ra,40(sp)
ffffffffc0205250:	64e2                	ld	s1,24(sp)
ffffffffc0205252:	6942                	ld	s2,16(sp)
ffffffffc0205254:	69a2                	ld	s3,8(sp)
ffffffffc0205256:	6a02                	ld	s4,0(sp)
ffffffffc0205258:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc020525a:	f4efb06f          	j	ffffffffc02009a8 <intr_enable>
            next = idleproc;
ffffffffc020525e:	000c2417          	auipc	s0,0xc2
ffffffffc0205262:	96a43403          	ld	s0,-1686(s0) # ffffffffc02c6bc8 <idleproc>
ffffffffc0205266:	b7c1                	j	ffffffffc0205226 <schedule+0x5c>
    if (proc != idleproc)
ffffffffc0205268:	000c2717          	auipc	a4,0xc2
ffffffffc020526c:	96073703          	ld	a4,-1696(a4) # ffffffffc02c6bc8 <idleproc>
ffffffffc0205270:	fae580e3          	beq	a1,a4,ffffffffc0205210 <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc0205274:	6b9c                	ld	a5,16(a5)
ffffffffc0205276:	9782                	jalr	a5
    return sched_class->pick_next(rq);
ffffffffc0205278:	0009b783          	ld	a5,0(s3)
ffffffffc020527c:	00093503          	ld	a0,0(s2)
ffffffffc0205280:	bf41                	j	ffffffffc0205210 <schedule+0x46>
        intr_disable();
ffffffffc0205282:	f2cfb0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0205286:	4a05                	li	s4,1
ffffffffc0205288:	bfa9                	j	ffffffffc02051e2 <schedule+0x18>

ffffffffc020528a <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc020528a:	000c2797          	auipc	a5,0xc2
ffffffffc020528e:	9367b783          	ld	a5,-1738(a5) # ffffffffc02c6bc0 <current>
}
ffffffffc0205292:	43c8                	lw	a0,4(a5)
ffffffffc0205294:	8082                	ret

ffffffffc0205296 <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc0205296:	4501                	li	a0,0
ffffffffc0205298:	8082                	ret

ffffffffc020529a <sys_gettime>:
static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc020529a:	000c2797          	auipc	a5,0xc2
ffffffffc020529e:	8d67b783          	ld	a5,-1834(a5) # ffffffffc02c6b70 <ticks>
ffffffffc02052a2:	0027951b          	slliw	a0,a5,0x2
ffffffffc02052a6:	9d3d                	addw	a0,a0,a5
}
ffffffffc02052a8:	0015151b          	slliw	a0,a0,0x1
ffffffffc02052ac:	8082                	ret

ffffffffc02052ae <sys_lab6_set_priority>:
static int sys_lab6_set_priority(uint64_t arg[]){
    uint64_t priority = (uint64_t)arg[0];
    lab6_set_priority(priority);
ffffffffc02052ae:	4108                	lw	a0,0(a0)
static int sys_lab6_set_priority(uint64_t arg[]){
ffffffffc02052b0:	1141                	addi	sp,sp,-16
ffffffffc02052b2:	e406                	sd	ra,8(sp)
    lab6_set_priority(priority);
ffffffffc02052b4:	c5fff0ef          	jal	ra,ffffffffc0204f12 <lab6_set_priority>
    return 0;
}
ffffffffc02052b8:	60a2                	ld	ra,8(sp)
ffffffffc02052ba:	4501                	li	a0,0
ffffffffc02052bc:	0141                	addi	sp,sp,16
ffffffffc02052be:	8082                	ret

ffffffffc02052c0 <sys_putc>:
    cputchar(c);
ffffffffc02052c0:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc02052c2:	1141                	addi	sp,sp,-16
ffffffffc02052c4:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc02052c6:	f09fa0ef          	jal	ra,ffffffffc02001ce <cputchar>
}
ffffffffc02052ca:	60a2                	ld	ra,8(sp)
ffffffffc02052cc:	4501                	li	a0,0
ffffffffc02052ce:	0141                	addi	sp,sp,16
ffffffffc02052d0:	8082                	ret

ffffffffc02052d2 <sys_kill>:
    return do_kill(pid);
ffffffffc02052d2:	4108                	lw	a0,0(a0)
ffffffffc02052d4:	a11ff06f          	j	ffffffffc0204ce4 <do_kill>

ffffffffc02052d8 <sys_yield>:
    return do_yield();
ffffffffc02052d8:	9bfff06f          	j	ffffffffc0204c96 <do_yield>

ffffffffc02052dc <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc02052dc:	6d14                	ld	a3,24(a0)
ffffffffc02052de:	6910                	ld	a2,16(a0)
ffffffffc02052e0:	650c                	ld	a1,8(a0)
ffffffffc02052e2:	6108                	ld	a0,0(a0)
ffffffffc02052e4:	c08ff06f          	j	ffffffffc02046ec <do_execve>

ffffffffc02052e8 <sys_wait>:
    return do_wait(pid, store);
ffffffffc02052e8:	650c                	ld	a1,8(a0)
ffffffffc02052ea:	4108                	lw	a0,0(a0)
ffffffffc02052ec:	9bbff06f          	j	ffffffffc0204ca6 <do_wait>

ffffffffc02052f0 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc02052f0:	000c2797          	auipc	a5,0xc2
ffffffffc02052f4:	8d07b783          	ld	a5,-1840(a5) # ffffffffc02c6bc0 <current>
ffffffffc02052f8:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc02052fa:	4501                	li	a0,0
ffffffffc02052fc:	6a0c                	ld	a1,16(a2)
ffffffffc02052fe:	bb9fe06f          	j	ffffffffc0203eb6 <do_fork>

ffffffffc0205302 <sys_exit>:
    return do_exit(error_code);
ffffffffc0205302:	4108                	lw	a0,0(a0)
ffffffffc0205304:	fa9fe06f          	j	ffffffffc02042ac <do_exit>

ffffffffc0205308 <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc0205308:	715d                	addi	sp,sp,-80
ffffffffc020530a:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc020530c:	000c2497          	auipc	s1,0xc2
ffffffffc0205310:	8b448493          	addi	s1,s1,-1868 # ffffffffc02c6bc0 <current>
ffffffffc0205314:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc0205316:	e0a2                	sd	s0,64(sp)
ffffffffc0205318:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc020531a:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc020531c:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc020531e:	0ff00793          	li	a5,255
    int num = tf->gpr.a0;
ffffffffc0205322:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0205326:	0327ee63          	bltu	a5,s2,ffffffffc0205362 <syscall+0x5a>
        if (syscalls[num] != NULL) {
ffffffffc020532a:	00391713          	slli	a4,s2,0x3
ffffffffc020532e:	00002797          	auipc	a5,0x2
ffffffffc0205332:	30278793          	addi	a5,a5,770 # ffffffffc0207630 <syscalls>
ffffffffc0205336:	97ba                	add	a5,a5,a4
ffffffffc0205338:	639c                	ld	a5,0(a5)
ffffffffc020533a:	c785                	beqz	a5,ffffffffc0205362 <syscall+0x5a>
            arg[0] = tf->gpr.a1;
ffffffffc020533c:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc020533e:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc0205340:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc0205342:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc0205344:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc0205346:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc0205348:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc020534a:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc020534c:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc020534e:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc0205350:	0028                	addi	a0,sp,8
ffffffffc0205352:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc0205354:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc0205356:	e828                	sd	a0,80(s0)
}
ffffffffc0205358:	6406                	ld	s0,64(sp)
ffffffffc020535a:	74e2                	ld	s1,56(sp)
ffffffffc020535c:	7942                	ld	s2,48(sp)
ffffffffc020535e:	6161                	addi	sp,sp,80
ffffffffc0205360:	8082                	ret
    print_trapframe(tf);
ffffffffc0205362:	8522                	mv	a0,s0
ffffffffc0205364:	83bfb0ef          	jal	ra,ffffffffc0200b9e <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc0205368:	609c                	ld	a5,0(s1)
ffffffffc020536a:	86ca                	mv	a3,s2
ffffffffc020536c:	00002617          	auipc	a2,0x2
ffffffffc0205370:	27c60613          	addi	a2,a2,636 # ffffffffc02075e8 <default_pmm_manager+0xf58>
ffffffffc0205374:	43d8                	lw	a4,4(a5)
ffffffffc0205376:	06c00593          	li	a1,108
ffffffffc020537a:	0b478793          	addi	a5,a5,180
ffffffffc020537e:	00002517          	auipc	a0,0x2
ffffffffc0205382:	29a50513          	addi	a0,a0,666 # ffffffffc0207618 <default_pmm_manager+0xf88>
ffffffffc0205386:	90cfb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020538a <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc020538a:	9e3707b7          	lui	a5,0x9e370
ffffffffc020538e:	2785                	addiw	a5,a5,1
ffffffffc0205390:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc0205394:	02000793          	li	a5,32
ffffffffc0205398:	9f8d                	subw	a5,a5,a1
}
ffffffffc020539a:	00f5553b          	srlw	a0,a0,a5
ffffffffc020539e:	8082                	ret

ffffffffc02053a0 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02053a0:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02053a4:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02053a6:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02053aa:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc02053ac:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02053b0:	f022                	sd	s0,32(sp)
ffffffffc02053b2:	ec26                	sd	s1,24(sp)
ffffffffc02053b4:	e84a                	sd	s2,16(sp)
ffffffffc02053b6:	f406                	sd	ra,40(sp)
ffffffffc02053b8:	e44e                	sd	s3,8(sp)
ffffffffc02053ba:	84aa                	mv	s1,a0
ffffffffc02053bc:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc02053be:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc02053c2:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc02053c4:	03067e63          	bgeu	a2,a6,ffffffffc0205400 <printnum+0x60>
ffffffffc02053c8:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc02053ca:	00805763          	blez	s0,ffffffffc02053d8 <printnum+0x38>
ffffffffc02053ce:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc02053d0:	85ca                	mv	a1,s2
ffffffffc02053d2:	854e                	mv	a0,s3
ffffffffc02053d4:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc02053d6:	fc65                	bnez	s0,ffffffffc02053ce <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02053d8:	1a02                	slli	s4,s4,0x20
ffffffffc02053da:	00003797          	auipc	a5,0x3
ffffffffc02053de:	a5678793          	addi	a5,a5,-1450 # ffffffffc0207e30 <syscalls+0x800>
ffffffffc02053e2:	020a5a13          	srli	s4,s4,0x20
ffffffffc02053e6:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc02053e8:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02053ea:	000a4503          	lbu	a0,0(s4)
}
ffffffffc02053ee:	70a2                	ld	ra,40(sp)
ffffffffc02053f0:	69a2                	ld	s3,8(sp)
ffffffffc02053f2:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02053f4:	85ca                	mv	a1,s2
ffffffffc02053f6:	87a6                	mv	a5,s1
}
ffffffffc02053f8:	6942                	ld	s2,16(sp)
ffffffffc02053fa:	64e2                	ld	s1,24(sp)
ffffffffc02053fc:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc02053fe:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0205400:	03065633          	divu	a2,a2,a6
ffffffffc0205404:	8722                	mv	a4,s0
ffffffffc0205406:	f9bff0ef          	jal	ra,ffffffffc02053a0 <printnum>
ffffffffc020540a:	b7f9                	j	ffffffffc02053d8 <printnum+0x38>

ffffffffc020540c <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc020540c:	7119                	addi	sp,sp,-128
ffffffffc020540e:	f4a6                	sd	s1,104(sp)
ffffffffc0205410:	f0ca                	sd	s2,96(sp)
ffffffffc0205412:	ecce                	sd	s3,88(sp)
ffffffffc0205414:	e8d2                	sd	s4,80(sp)
ffffffffc0205416:	e4d6                	sd	s5,72(sp)
ffffffffc0205418:	e0da                	sd	s6,64(sp)
ffffffffc020541a:	fc5e                	sd	s7,56(sp)
ffffffffc020541c:	f06a                	sd	s10,32(sp)
ffffffffc020541e:	fc86                	sd	ra,120(sp)
ffffffffc0205420:	f8a2                	sd	s0,112(sp)
ffffffffc0205422:	f862                	sd	s8,48(sp)
ffffffffc0205424:	f466                	sd	s9,40(sp)
ffffffffc0205426:	ec6e                	sd	s11,24(sp)
ffffffffc0205428:	892a                	mv	s2,a0
ffffffffc020542a:	84ae                	mv	s1,a1
ffffffffc020542c:	8d32                	mv	s10,a2
ffffffffc020542e:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205430:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0205434:	5b7d                	li	s6,-1
ffffffffc0205436:	00003a97          	auipc	s5,0x3
ffffffffc020543a:	a26a8a93          	addi	s5,s5,-1498 # ffffffffc0207e5c <syscalls+0x82c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc020543e:	00003b97          	auipc	s7,0x3
ffffffffc0205442:	c3ab8b93          	addi	s7,s7,-966 # ffffffffc0208078 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205446:	000d4503          	lbu	a0,0(s10)
ffffffffc020544a:	001d0413          	addi	s0,s10,1
ffffffffc020544e:	01350a63          	beq	a0,s3,ffffffffc0205462 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0205452:	c121                	beqz	a0,ffffffffc0205492 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0205454:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205456:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0205458:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020545a:	fff44503          	lbu	a0,-1(s0)
ffffffffc020545e:	ff351ae3          	bne	a0,s3,ffffffffc0205452 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205462:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0205466:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc020546a:	4c81                	li	s9,0
ffffffffc020546c:	4881                	li	a7,0
        width = precision = -1;
ffffffffc020546e:	5c7d                	li	s8,-1
ffffffffc0205470:	5dfd                	li	s11,-1
ffffffffc0205472:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0205476:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205478:	fdd6059b          	addiw	a1,a2,-35
ffffffffc020547c:	0ff5f593          	zext.b	a1,a1
ffffffffc0205480:	00140d13          	addi	s10,s0,1
ffffffffc0205484:	04b56263          	bltu	a0,a1,ffffffffc02054c8 <vprintfmt+0xbc>
ffffffffc0205488:	058a                	slli	a1,a1,0x2
ffffffffc020548a:	95d6                	add	a1,a1,s5
ffffffffc020548c:	4194                	lw	a3,0(a1)
ffffffffc020548e:	96d6                	add	a3,a3,s5
ffffffffc0205490:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0205492:	70e6                	ld	ra,120(sp)
ffffffffc0205494:	7446                	ld	s0,112(sp)
ffffffffc0205496:	74a6                	ld	s1,104(sp)
ffffffffc0205498:	7906                	ld	s2,96(sp)
ffffffffc020549a:	69e6                	ld	s3,88(sp)
ffffffffc020549c:	6a46                	ld	s4,80(sp)
ffffffffc020549e:	6aa6                	ld	s5,72(sp)
ffffffffc02054a0:	6b06                	ld	s6,64(sp)
ffffffffc02054a2:	7be2                	ld	s7,56(sp)
ffffffffc02054a4:	7c42                	ld	s8,48(sp)
ffffffffc02054a6:	7ca2                	ld	s9,40(sp)
ffffffffc02054a8:	7d02                	ld	s10,32(sp)
ffffffffc02054aa:	6de2                	ld	s11,24(sp)
ffffffffc02054ac:	6109                	addi	sp,sp,128
ffffffffc02054ae:	8082                	ret
            padc = '0';
ffffffffc02054b0:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc02054b2:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054b6:	846a                	mv	s0,s10
ffffffffc02054b8:	00140d13          	addi	s10,s0,1
ffffffffc02054bc:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02054c0:	0ff5f593          	zext.b	a1,a1
ffffffffc02054c4:	fcb572e3          	bgeu	a0,a1,ffffffffc0205488 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc02054c8:	85a6                	mv	a1,s1
ffffffffc02054ca:	02500513          	li	a0,37
ffffffffc02054ce:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc02054d0:	fff44783          	lbu	a5,-1(s0)
ffffffffc02054d4:	8d22                	mv	s10,s0
ffffffffc02054d6:	f73788e3          	beq	a5,s3,ffffffffc0205446 <vprintfmt+0x3a>
ffffffffc02054da:	ffed4783          	lbu	a5,-2(s10)
ffffffffc02054de:	1d7d                	addi	s10,s10,-1
ffffffffc02054e0:	ff379de3          	bne	a5,s3,ffffffffc02054da <vprintfmt+0xce>
ffffffffc02054e4:	b78d                	j	ffffffffc0205446 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc02054e6:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc02054ea:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054ee:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc02054f0:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc02054f4:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc02054f8:	02d86463          	bltu	a6,a3,ffffffffc0205520 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc02054fc:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0205500:	002c169b          	slliw	a3,s8,0x2
ffffffffc0205504:	0186873b          	addw	a4,a3,s8
ffffffffc0205508:	0017171b          	slliw	a4,a4,0x1
ffffffffc020550c:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc020550e:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0205512:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0205514:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0205518:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc020551c:	fed870e3          	bgeu	a6,a3,ffffffffc02054fc <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0205520:	f40ddce3          	bgez	s11,ffffffffc0205478 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0205524:	8de2                	mv	s11,s8
ffffffffc0205526:	5c7d                	li	s8,-1
ffffffffc0205528:	bf81                	j	ffffffffc0205478 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc020552a:	fffdc693          	not	a3,s11
ffffffffc020552e:	96fd                	srai	a3,a3,0x3f
ffffffffc0205530:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205534:	00144603          	lbu	a2,1(s0)
ffffffffc0205538:	2d81                	sext.w	s11,s11
ffffffffc020553a:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020553c:	bf35                	j	ffffffffc0205478 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc020553e:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205542:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0205546:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205548:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc020554a:	bfd9                	j	ffffffffc0205520 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc020554c:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020554e:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205552:	01174463          	blt	a4,a7,ffffffffc020555a <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0205556:	1a088e63          	beqz	a7,ffffffffc0205712 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc020555a:	000a3603          	ld	a2,0(s4)
ffffffffc020555e:	46c1                	li	a3,16
ffffffffc0205560:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0205562:	2781                	sext.w	a5,a5
ffffffffc0205564:	876e                	mv	a4,s11
ffffffffc0205566:	85a6                	mv	a1,s1
ffffffffc0205568:	854a                	mv	a0,s2
ffffffffc020556a:	e37ff0ef          	jal	ra,ffffffffc02053a0 <printnum>
            break;
ffffffffc020556e:	bde1                	j	ffffffffc0205446 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0205570:	000a2503          	lw	a0,0(s4)
ffffffffc0205574:	85a6                	mv	a1,s1
ffffffffc0205576:	0a21                	addi	s4,s4,8
ffffffffc0205578:	9902                	jalr	s2
            break;
ffffffffc020557a:	b5f1                	j	ffffffffc0205446 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020557c:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020557e:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205582:	01174463          	blt	a4,a7,ffffffffc020558a <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0205586:	18088163          	beqz	a7,ffffffffc0205708 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc020558a:	000a3603          	ld	a2,0(s4)
ffffffffc020558e:	46a9                	li	a3,10
ffffffffc0205590:	8a2e                	mv	s4,a1
ffffffffc0205592:	bfc1                	j	ffffffffc0205562 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205594:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0205598:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020559a:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc020559c:	bdf1                	j	ffffffffc0205478 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc020559e:	85a6                	mv	a1,s1
ffffffffc02055a0:	02500513          	li	a0,37
ffffffffc02055a4:	9902                	jalr	s2
            break;
ffffffffc02055a6:	b545                	j	ffffffffc0205446 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02055a8:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc02055ac:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02055ae:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02055b0:	b5e1                	j	ffffffffc0205478 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc02055b2:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02055b4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02055b8:	01174463          	blt	a4,a7,ffffffffc02055c0 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc02055bc:	14088163          	beqz	a7,ffffffffc02056fe <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc02055c0:	000a3603          	ld	a2,0(s4)
ffffffffc02055c4:	46a1                	li	a3,8
ffffffffc02055c6:	8a2e                	mv	s4,a1
ffffffffc02055c8:	bf69                	j	ffffffffc0205562 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc02055ca:	03000513          	li	a0,48
ffffffffc02055ce:	85a6                	mv	a1,s1
ffffffffc02055d0:	e03e                	sd	a5,0(sp)
ffffffffc02055d2:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc02055d4:	85a6                	mv	a1,s1
ffffffffc02055d6:	07800513          	li	a0,120
ffffffffc02055da:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02055dc:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc02055de:	6782                	ld	a5,0(sp)
ffffffffc02055e0:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc02055e2:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc02055e6:	bfb5                	j	ffffffffc0205562 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02055e8:	000a3403          	ld	s0,0(s4)
ffffffffc02055ec:	008a0713          	addi	a4,s4,8
ffffffffc02055f0:	e03a                	sd	a4,0(sp)
ffffffffc02055f2:	14040263          	beqz	s0,ffffffffc0205736 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc02055f6:	0fb05763          	blez	s11,ffffffffc02056e4 <vprintfmt+0x2d8>
ffffffffc02055fa:	02d00693          	li	a3,45
ffffffffc02055fe:	0cd79163          	bne	a5,a3,ffffffffc02056c0 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205602:	00044783          	lbu	a5,0(s0)
ffffffffc0205606:	0007851b          	sext.w	a0,a5
ffffffffc020560a:	cf85                	beqz	a5,ffffffffc0205642 <vprintfmt+0x236>
ffffffffc020560c:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205610:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205614:	000c4563          	bltz	s8,ffffffffc020561e <vprintfmt+0x212>
ffffffffc0205618:	3c7d                	addiw	s8,s8,-1
ffffffffc020561a:	036c0263          	beq	s8,s6,ffffffffc020563e <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc020561e:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205620:	0e0c8e63          	beqz	s9,ffffffffc020571c <vprintfmt+0x310>
ffffffffc0205624:	3781                	addiw	a5,a5,-32
ffffffffc0205626:	0ef47b63          	bgeu	s0,a5,ffffffffc020571c <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc020562a:	03f00513          	li	a0,63
ffffffffc020562e:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205630:	000a4783          	lbu	a5,0(s4)
ffffffffc0205634:	3dfd                	addiw	s11,s11,-1
ffffffffc0205636:	0a05                	addi	s4,s4,1
ffffffffc0205638:	0007851b          	sext.w	a0,a5
ffffffffc020563c:	ffe1                	bnez	a5,ffffffffc0205614 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc020563e:	01b05963          	blez	s11,ffffffffc0205650 <vprintfmt+0x244>
ffffffffc0205642:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0205644:	85a6                	mv	a1,s1
ffffffffc0205646:	02000513          	li	a0,32
ffffffffc020564a:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc020564c:	fe0d9be3          	bnez	s11,ffffffffc0205642 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0205650:	6a02                	ld	s4,0(sp)
ffffffffc0205652:	bbd5                	j	ffffffffc0205446 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0205654:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205656:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc020565a:	01174463          	blt	a4,a7,ffffffffc0205662 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc020565e:	08088d63          	beqz	a7,ffffffffc02056f8 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0205662:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0205666:	0a044d63          	bltz	s0,ffffffffc0205720 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc020566a:	8622                	mv	a2,s0
ffffffffc020566c:	8a66                	mv	s4,s9
ffffffffc020566e:	46a9                	li	a3,10
ffffffffc0205670:	bdcd                	j	ffffffffc0205562 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0205672:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205676:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc0205678:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc020567a:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc020567e:	8fb5                	xor	a5,a5,a3
ffffffffc0205680:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205684:	02d74163          	blt	a4,a3,ffffffffc02056a6 <vprintfmt+0x29a>
ffffffffc0205688:	00369793          	slli	a5,a3,0x3
ffffffffc020568c:	97de                	add	a5,a5,s7
ffffffffc020568e:	639c                	ld	a5,0(a5)
ffffffffc0205690:	cb99                	beqz	a5,ffffffffc02056a6 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0205692:	86be                	mv	a3,a5
ffffffffc0205694:	00000617          	auipc	a2,0x0
ffffffffc0205698:	1f460613          	addi	a2,a2,500 # ffffffffc0205888 <etext+0x2e>
ffffffffc020569c:	85a6                	mv	a1,s1
ffffffffc020569e:	854a                	mv	a0,s2
ffffffffc02056a0:	0ce000ef          	jal	ra,ffffffffc020576e <printfmt>
ffffffffc02056a4:	b34d                	j	ffffffffc0205446 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc02056a6:	00002617          	auipc	a2,0x2
ffffffffc02056aa:	7aa60613          	addi	a2,a2,1962 # ffffffffc0207e50 <syscalls+0x820>
ffffffffc02056ae:	85a6                	mv	a1,s1
ffffffffc02056b0:	854a                	mv	a0,s2
ffffffffc02056b2:	0bc000ef          	jal	ra,ffffffffc020576e <printfmt>
ffffffffc02056b6:	bb41                	j	ffffffffc0205446 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc02056b8:	00002417          	auipc	s0,0x2
ffffffffc02056bc:	79040413          	addi	s0,s0,1936 # ffffffffc0207e48 <syscalls+0x818>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02056c0:	85e2                	mv	a1,s8
ffffffffc02056c2:	8522                	mv	a0,s0
ffffffffc02056c4:	e43e                	sd	a5,8(sp)
ffffffffc02056c6:	0e2000ef          	jal	ra,ffffffffc02057a8 <strnlen>
ffffffffc02056ca:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02056ce:	01b05b63          	blez	s11,ffffffffc02056e4 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc02056d2:	67a2                	ld	a5,8(sp)
ffffffffc02056d4:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02056d8:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc02056da:	85a6                	mv	a1,s1
ffffffffc02056dc:	8552                	mv	a0,s4
ffffffffc02056de:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc02056e0:	fe0d9ce3          	bnez	s11,ffffffffc02056d8 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02056e4:	00044783          	lbu	a5,0(s0)
ffffffffc02056e8:	00140a13          	addi	s4,s0,1
ffffffffc02056ec:	0007851b          	sext.w	a0,a5
ffffffffc02056f0:	d3a5                	beqz	a5,ffffffffc0205650 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02056f2:	05e00413          	li	s0,94
ffffffffc02056f6:	bf39                	j	ffffffffc0205614 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc02056f8:	000a2403          	lw	s0,0(s4)
ffffffffc02056fc:	b7ad                	j	ffffffffc0205666 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc02056fe:	000a6603          	lwu	a2,0(s4)
ffffffffc0205702:	46a1                	li	a3,8
ffffffffc0205704:	8a2e                	mv	s4,a1
ffffffffc0205706:	bdb1                	j	ffffffffc0205562 <vprintfmt+0x156>
ffffffffc0205708:	000a6603          	lwu	a2,0(s4)
ffffffffc020570c:	46a9                	li	a3,10
ffffffffc020570e:	8a2e                	mv	s4,a1
ffffffffc0205710:	bd89                	j	ffffffffc0205562 <vprintfmt+0x156>
ffffffffc0205712:	000a6603          	lwu	a2,0(s4)
ffffffffc0205716:	46c1                	li	a3,16
ffffffffc0205718:	8a2e                	mv	s4,a1
ffffffffc020571a:	b5a1                	j	ffffffffc0205562 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc020571c:	9902                	jalr	s2
ffffffffc020571e:	bf09                	j	ffffffffc0205630 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0205720:	85a6                	mv	a1,s1
ffffffffc0205722:	02d00513          	li	a0,45
ffffffffc0205726:	e03e                	sd	a5,0(sp)
ffffffffc0205728:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc020572a:	6782                	ld	a5,0(sp)
ffffffffc020572c:	8a66                	mv	s4,s9
ffffffffc020572e:	40800633          	neg	a2,s0
ffffffffc0205732:	46a9                	li	a3,10
ffffffffc0205734:	b53d                	j	ffffffffc0205562 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0205736:	03b05163          	blez	s11,ffffffffc0205758 <vprintfmt+0x34c>
ffffffffc020573a:	02d00693          	li	a3,45
ffffffffc020573e:	f6d79de3          	bne	a5,a3,ffffffffc02056b8 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0205742:	00002417          	auipc	s0,0x2
ffffffffc0205746:	70640413          	addi	s0,s0,1798 # ffffffffc0207e48 <syscalls+0x818>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020574a:	02800793          	li	a5,40
ffffffffc020574e:	02800513          	li	a0,40
ffffffffc0205752:	00140a13          	addi	s4,s0,1
ffffffffc0205756:	bd6d                	j	ffffffffc0205610 <vprintfmt+0x204>
ffffffffc0205758:	00002a17          	auipc	s4,0x2
ffffffffc020575c:	6f1a0a13          	addi	s4,s4,1777 # ffffffffc0207e49 <syscalls+0x819>
ffffffffc0205760:	02800513          	li	a0,40
ffffffffc0205764:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205768:	05e00413          	li	s0,94
ffffffffc020576c:	b565                	j	ffffffffc0205614 <vprintfmt+0x208>

ffffffffc020576e <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc020576e:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0205770:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0205774:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0205776:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0205778:	ec06                	sd	ra,24(sp)
ffffffffc020577a:	f83a                	sd	a4,48(sp)
ffffffffc020577c:	fc3e                	sd	a5,56(sp)
ffffffffc020577e:	e0c2                	sd	a6,64(sp)
ffffffffc0205780:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0205782:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0205784:	c89ff0ef          	jal	ra,ffffffffc020540c <vprintfmt>
}
ffffffffc0205788:	60e2                	ld	ra,24(sp)
ffffffffc020578a:	6161                	addi	sp,sp,80
ffffffffc020578c:	8082                	ret

ffffffffc020578e <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc020578e:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0205792:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0205794:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0205796:	cb81                	beqz	a5,ffffffffc02057a6 <strlen+0x18>
        cnt ++;
ffffffffc0205798:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc020579a:	00a707b3          	add	a5,a4,a0
ffffffffc020579e:	0007c783          	lbu	a5,0(a5)
ffffffffc02057a2:	fbfd                	bnez	a5,ffffffffc0205798 <strlen+0xa>
ffffffffc02057a4:	8082                	ret
    }
    return cnt;
}
ffffffffc02057a6:	8082                	ret

ffffffffc02057a8 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc02057a8:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc02057aa:	e589                	bnez	a1,ffffffffc02057b4 <strnlen+0xc>
ffffffffc02057ac:	a811                	j	ffffffffc02057c0 <strnlen+0x18>
        cnt ++;
ffffffffc02057ae:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc02057b0:	00f58863          	beq	a1,a5,ffffffffc02057c0 <strnlen+0x18>
ffffffffc02057b4:	00f50733          	add	a4,a0,a5
ffffffffc02057b8:	00074703          	lbu	a4,0(a4)
ffffffffc02057bc:	fb6d                	bnez	a4,ffffffffc02057ae <strnlen+0x6>
ffffffffc02057be:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc02057c0:	852e                	mv	a0,a1
ffffffffc02057c2:	8082                	ret

ffffffffc02057c4 <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc02057c4:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc02057c6:	0005c703          	lbu	a4,0(a1)
ffffffffc02057ca:	0785                	addi	a5,a5,1
ffffffffc02057cc:	0585                	addi	a1,a1,1
ffffffffc02057ce:	fee78fa3          	sb	a4,-1(a5)
ffffffffc02057d2:	fb75                	bnez	a4,ffffffffc02057c6 <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc02057d4:	8082                	ret

ffffffffc02057d6 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02057d6:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02057da:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02057de:	cb89                	beqz	a5,ffffffffc02057f0 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc02057e0:	0505                	addi	a0,a0,1
ffffffffc02057e2:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc02057e4:	fee789e3          	beq	a5,a4,ffffffffc02057d6 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc02057e8:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc02057ec:	9d19                	subw	a0,a0,a4
ffffffffc02057ee:	8082                	ret
ffffffffc02057f0:	4501                	li	a0,0
ffffffffc02057f2:	bfed                	j	ffffffffc02057ec <strcmp+0x16>

ffffffffc02057f4 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02057f4:	c20d                	beqz	a2,ffffffffc0205816 <strncmp+0x22>
ffffffffc02057f6:	962e                	add	a2,a2,a1
ffffffffc02057f8:	a031                	j	ffffffffc0205804 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc02057fa:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc02057fc:	00e79a63          	bne	a5,a4,ffffffffc0205810 <strncmp+0x1c>
ffffffffc0205800:	00b60b63          	beq	a2,a1,ffffffffc0205816 <strncmp+0x22>
ffffffffc0205804:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0205808:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020580a:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020580e:	f7f5                	bnez	a5,ffffffffc02057fa <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205810:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0205814:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205816:	4501                	li	a0,0
ffffffffc0205818:	8082                	ret

ffffffffc020581a <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc020581a:	00054783          	lbu	a5,0(a0)
ffffffffc020581e:	c799                	beqz	a5,ffffffffc020582c <strchr+0x12>
        if (*s == c) {
ffffffffc0205820:	00f58763          	beq	a1,a5,ffffffffc020582e <strchr+0x14>
    while (*s != '\0') {
ffffffffc0205824:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0205828:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc020582a:	fbfd                	bnez	a5,ffffffffc0205820 <strchr+0x6>
    }
    return NULL;
ffffffffc020582c:	4501                	li	a0,0
}
ffffffffc020582e:	8082                	ret

ffffffffc0205830 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0205830:	ca01                	beqz	a2,ffffffffc0205840 <memset+0x10>
ffffffffc0205832:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0205834:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0205836:	0785                	addi	a5,a5,1
ffffffffc0205838:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc020583c:	fec79de3          	bne	a5,a2,ffffffffc0205836 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0205840:	8082                	ret

ffffffffc0205842 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0205842:	ca19                	beqz	a2,ffffffffc0205858 <memcpy+0x16>
ffffffffc0205844:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc0205846:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc0205848:	0005c703          	lbu	a4,0(a1)
ffffffffc020584c:	0585                	addi	a1,a1,1
ffffffffc020584e:	0785                	addi	a5,a5,1
ffffffffc0205850:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc0205854:	fec59ae3          	bne	a1,a2,ffffffffc0205848 <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc0205858:	8082                	ret
