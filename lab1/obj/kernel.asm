
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <kern_entry>:
#include <memlayout.h>

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    la sp, bootstacktop
    80200000:	00003117          	auipc	sp,0x3
    80200004:	00010113          	mv	sp,sp

    tail kern_init
    80200008:	a009                	j	8020000a <kern_init>

000000008020000a <kern_init>:
#include <sbi.h>
int kern_init(void) __attribute__((noreturn));

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
    8020000a:	00003517          	auipc	a0,0x3
    8020000e:	ffe50513          	addi	a0,a0,-2 # 80203008 <edata>
    80200012:	00003617          	auipc	a2,0x3
    80200016:	ff660613          	addi	a2,a2,-10 # 80203008 <edata>
int kern_init(void) {
    8020001a:	1141                	addi	sp,sp,-16 # 80202ff0 <bootstack+0x1ff0>
    memset(edata, 0, end - edata);
    8020001c:	4581                	li	a1,0
    8020001e:	8e09                	sub	a2,a2,a0
int kern_init(void) {
    80200020:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
    80200022:	46e000ef          	jal	80200490 <memset>

    const char *message = "(THU.CST) os is loading ...\n";
    cprintf("%s\n\n", message);
    80200026:	00000597          	auipc	a1,0x0
    8020002a:	48258593          	addi	a1,a1,1154 # 802004a8 <memset+0x18>
    8020002e:	00000517          	auipc	a0,0x0
    80200032:	49a50513          	addi	a0,a0,1178 # 802004c8 <memset+0x38>
    80200036:	01e000ef          	jal	80200054 <cprintf>
   while (1)
    8020003a:	a001                	j	8020003a <kern_init+0x30>

000000008020003c <cputch>:

/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void cputch(int c, int *cnt) {
    8020003c:	1101                	addi	sp,sp,-32
    8020003e:	ec06                	sd	ra,24(sp)
    80200040:	e42e                	sd	a1,8(sp)
    cons_putc(c);
    80200042:	046000ef          	jal	80200088 <cons_putc>
    (*cnt)++;
    80200046:	65a2                	ld	a1,8(sp)
}
    80200048:	60e2                	ld	ra,24(sp)
    (*cnt)++;
    8020004a:	419c                	lw	a5,0(a1)
    8020004c:	2785                	addiw	a5,a5,1
    8020004e:	c19c                	sw	a5,0(a1)
}
    80200050:	6105                	addi	sp,sp,32
    80200052:	8082                	ret

0000000080200054 <cprintf>:
 * cprintf - formats a string and writes it to stdout
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...) {
    80200054:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
    80200056:	02810313          	addi	t1,sp,40
int cprintf(const char *fmt, ...) {
    8020005a:	f42e                	sd	a1,40(sp)
    8020005c:	f832                	sd	a2,48(sp)
    8020005e:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
    80200060:	862a                	mv	a2,a0
    80200062:	004c                	addi	a1,sp,4
    80200064:	00000517          	auipc	a0,0x0
    80200068:	fd850513          	addi	a0,a0,-40 # 8020003c <cputch>
    8020006c:	869a                	mv	a3,t1
int cprintf(const char *fmt, ...) {
    8020006e:	ec06                	sd	ra,24(sp)
    80200070:	e0ba                	sd	a4,64(sp)
    80200072:	e4be                	sd	a5,72(sp)
    80200074:	e8c2                	sd	a6,80(sp)
    80200076:	ecc6                	sd	a7,88(sp)
    int cnt = 0;
    80200078:	c202                	sw	zero,4(sp)
    va_start(ap, fmt);
    8020007a:	e41a                	sd	t1,8(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
    8020007c:	078000ef          	jal	802000f4 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
    80200080:	60e2                	ld	ra,24(sp)
    80200082:	4512                	lw	a0,4(sp)
    80200084:	6125                	addi	sp,sp,96
    80200086:	8082                	ret

0000000080200088 <cons_putc>:

/* cons_init - initializes the console devices */
void cons_init(void) {}

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
    80200088:	0ff57513          	zext.b	a0,a0
    8020008c:	a6f9                	j	8020045a <sbi_console_putchar>

000000008020008e <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    8020008e:	7179                	addi	sp,sp,-48
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
    80200090:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
    80200094:	f022                	sd	s0,32(sp)
    80200096:	ec26                	sd	s1,24(sp)
    80200098:	e84a                	sd	s2,16(sp)
    8020009a:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
    8020009c:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
    802000a0:	f406                	sd	ra,40(sp)
    unsigned mod = do_div(result, base);
    802000a2:	03067a33          	remu	s4,a2,a6
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
    802000a6:	fff7041b          	addiw	s0,a4,-1
        unsigned long long num, unsigned base, int width, int padc) {
    802000aa:	84aa                	mv	s1,a0
    802000ac:	892e                	mv	s2,a1
    if (num >= base) {
    802000ae:	03067d63          	bgeu	a2,a6,802000e8 <printnum+0x5a>
    802000b2:	e44e                	sd	s3,8(sp)
    802000b4:	89be                	mv	s3,a5
        while (-- width > 0)
    802000b6:	4785                	li	a5,1
    802000b8:	00e7d763          	bge	a5,a4,802000c6 <printnum+0x38>
            putch(padc, putdat);
    802000bc:	85ca                	mv	a1,s2
    802000be:	854e                	mv	a0,s3
        while (-- width > 0)
    802000c0:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
    802000c2:	9482                	jalr	s1
        while (-- width > 0)
    802000c4:	fc65                	bnez	s0,802000bc <printnum+0x2e>
    802000c6:	69a2                	ld	s3,8(sp)
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
    802000c8:	00000797          	auipc	a5,0x0
    802000cc:	40878793          	addi	a5,a5,1032 # 802004d0 <memset+0x40>
    802000d0:	97d2                	add	a5,a5,s4
}
    802000d2:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
    802000d4:	0007c503          	lbu	a0,0(a5)
}
    802000d8:	70a2                	ld	ra,40(sp)
    802000da:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
    802000dc:	85ca                	mv	a1,s2
    802000de:	87a6                	mv	a5,s1
}
    802000e0:	6942                	ld	s2,16(sp)
    802000e2:	64e2                	ld	s1,24(sp)
    802000e4:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
    802000e6:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
    802000e8:	03065633          	divu	a2,a2,a6
    802000ec:	8722                	mv	a4,s0
    802000ee:	fa1ff0ef          	jal	8020008e <printnum>
    802000f2:	bfd9                	j	802000c8 <printnum+0x3a>

00000000802000f4 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
    802000f4:	7119                	addi	sp,sp,-128
    802000f6:	f4a6                	sd	s1,104(sp)
    802000f8:	f0ca                	sd	s2,96(sp)
    802000fa:	ecce                	sd	s3,88(sp)
    802000fc:	e8d2                	sd	s4,80(sp)
    802000fe:	e4d6                	sd	s5,72(sp)
    80200100:	e0da                	sd	s6,64(sp)
    80200102:	f862                	sd	s8,48(sp)
    80200104:	fc86                	sd	ra,120(sp)
    80200106:	f8a2                	sd	s0,112(sp)
    80200108:	fc5e                	sd	s7,56(sp)
    8020010a:	f466                	sd	s9,40(sp)
    8020010c:	f06a                	sd	s10,32(sp)
    8020010e:	ec6e                	sd	s11,24(sp)
    80200110:	84aa                	mv	s1,a0
    80200112:	8c32                	mv	s8,a2
    80200114:	8a36                	mv	s4,a3
    80200116:	892e                	mv	s2,a1
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
    80200118:	02500993          	li	s3,37
        char padc = ' ';
        width = precision = -1;
        lflag = altflag = 0;

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
    8020011c:	05500b13          	li	s6,85
    80200120:	00000a97          	auipc	s5,0x0
    80200124:	464a8a93          	addi	s5,s5,1124 # 80200584 <memset+0xf4>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
    80200128:	000c4503          	lbu	a0,0(s8)
    8020012c:	001c0413          	addi	s0,s8,1
    80200130:	01350a63          	beq	a0,s3,80200144 <vprintfmt+0x50>
            if (ch == '\0') {
    80200134:	cd0d                	beqz	a0,8020016e <vprintfmt+0x7a>
            putch(ch, putdat);
    80200136:	85ca                	mv	a1,s2
    80200138:	9482                	jalr	s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
    8020013a:	00044503          	lbu	a0,0(s0)
    8020013e:	0405                	addi	s0,s0,1
    80200140:	ff351ae3          	bne	a0,s3,80200134 <vprintfmt+0x40>
        width = precision = -1;
    80200144:	5cfd                	li	s9,-1
    80200146:	8d66                	mv	s10,s9
        char padc = ' ';
    80200148:	02000d93          	li	s11,32
        lflag = altflag = 0;
    8020014c:	4b81                	li	s7,0
    8020014e:	4781                	li	a5,0
        switch (ch = *(unsigned char *)fmt ++) {
    80200150:	00044683          	lbu	a3,0(s0)
    80200154:	00140c13          	addi	s8,s0,1
    80200158:	fdd6859b          	addiw	a1,a3,-35
    8020015c:	0ff5f593          	zext.b	a1,a1
    80200160:	02bb6663          	bltu	s6,a1,8020018c <vprintfmt+0x98>
    80200164:	058a                	slli	a1,a1,0x2
    80200166:	95d6                	add	a1,a1,s5
    80200168:	4198                	lw	a4,0(a1)
    8020016a:	9756                	add	a4,a4,s5
    8020016c:	8702                	jr	a4
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
    8020016e:	70e6                	ld	ra,120(sp)
    80200170:	7446                	ld	s0,112(sp)
    80200172:	74a6                	ld	s1,104(sp)
    80200174:	7906                	ld	s2,96(sp)
    80200176:	69e6                	ld	s3,88(sp)
    80200178:	6a46                	ld	s4,80(sp)
    8020017a:	6aa6                	ld	s5,72(sp)
    8020017c:	6b06                	ld	s6,64(sp)
    8020017e:	7be2                	ld	s7,56(sp)
    80200180:	7c42                	ld	s8,48(sp)
    80200182:	7ca2                	ld	s9,40(sp)
    80200184:	7d02                	ld	s10,32(sp)
    80200186:	6de2                	ld	s11,24(sp)
    80200188:	6109                	addi	sp,sp,128
    8020018a:	8082                	ret
            putch('%', putdat);
    8020018c:	85ca                	mv	a1,s2
    8020018e:	02500513          	li	a0,37
    80200192:	9482                	jalr	s1
            for (fmt --; fmt[-1] != '%'; fmt --)
    80200194:	fff44783          	lbu	a5,-1(s0)
    80200198:	02500713          	li	a4,37
    8020019c:	8c22                	mv	s8,s0
    8020019e:	f8e785e3          	beq	a5,a4,80200128 <vprintfmt+0x34>
    802001a2:	ffec4783          	lbu	a5,-2(s8)
    802001a6:	1c7d                	addi	s8,s8,-1
    802001a8:	fee79de3          	bne	a5,a4,802001a2 <vprintfmt+0xae>
    802001ac:	bfb5                	j	80200128 <vprintfmt+0x34>
                ch = *fmt;
    802001ae:	00144603          	lbu	a2,1(s0)
                if (ch < '0' || ch > '9') {
    802001b2:	4525                	li	a0,9
                precision = precision * 10 + ch - '0';
    802001b4:	fd068c9b          	addiw	s9,a3,-48
                if (ch < '0' || ch > '9') {
    802001b8:	fd06071b          	addiw	a4,a2,-48
    802001bc:	24e56a63          	bltu	a0,a4,80200410 <vprintfmt+0x31c>
                ch = *fmt;
    802001c0:	2601                	sext.w	a2,a2
        switch (ch = *(unsigned char *)fmt ++) {
    802001c2:	8462                	mv	s0,s8
                precision = precision * 10 + ch - '0';
    802001c4:	002c971b          	slliw	a4,s9,0x2
                ch = *fmt;
    802001c8:	00144683          	lbu	a3,1(s0)
                precision = precision * 10 + ch - '0';
    802001cc:	0197073b          	addw	a4,a4,s9
    802001d0:	0017171b          	slliw	a4,a4,0x1
    802001d4:	9f31                	addw	a4,a4,a2
                if (ch < '0' || ch > '9') {
    802001d6:	fd06859b          	addiw	a1,a3,-48
            for (precision = 0; ; ++ fmt) {
    802001da:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
    802001dc:	fd070c9b          	addiw	s9,a4,-48
                ch = *fmt;
    802001e0:	0006861b          	sext.w	a2,a3
                if (ch < '0' || ch > '9') {
    802001e4:	feb570e3          	bgeu	a0,a1,802001c4 <vprintfmt+0xd0>
            if (width < 0)
    802001e8:	f60d54e3          	bgez	s10,80200150 <vprintfmt+0x5c>
                width = precision, precision = -1;
    802001ec:	8d66                	mv	s10,s9
    802001ee:	5cfd                	li	s9,-1
    802001f0:	b785                	j	80200150 <vprintfmt+0x5c>
        switch (ch = *(unsigned char *)fmt ++) {
    802001f2:	8db6                	mv	s11,a3
    802001f4:	8462                	mv	s0,s8
    802001f6:	bfa9                	j	80200150 <vprintfmt+0x5c>
    802001f8:	8462                	mv	s0,s8
            altflag = 1;
    802001fa:	4b85                	li	s7,1
            goto reswitch;
    802001fc:	bf91                	j	80200150 <vprintfmt+0x5c>
    if (lflag >= 2) {
    802001fe:	4705                	li	a4,1
            precision = va_arg(ap, int);
    80200200:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
    80200204:	00f74463          	blt	a4,a5,8020020c <vprintfmt+0x118>
    else if (lflag) {
    80200208:	1a078763          	beqz	a5,802003b6 <vprintfmt+0x2c2>
        return va_arg(*ap, unsigned long);
    8020020c:	000a3603          	ld	a2,0(s4)
    80200210:	46c1                	li	a3,16
    80200212:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
    80200214:	000d879b          	sext.w	a5,s11
    80200218:	876a                	mv	a4,s10
    8020021a:	85ca                	mv	a1,s2
    8020021c:	8526                	mv	a0,s1
    8020021e:	e71ff0ef          	jal	8020008e <printnum>
            break;
    80200222:	b719                	j	80200128 <vprintfmt+0x34>
            putch(va_arg(ap, int), putdat);
    80200224:	000a2503          	lw	a0,0(s4)
    80200228:	85ca                	mv	a1,s2
    8020022a:	0a21                	addi	s4,s4,8
    8020022c:	9482                	jalr	s1
            break;
    8020022e:	bded                	j	80200128 <vprintfmt+0x34>
    if (lflag >= 2) {
    80200230:	4705                	li	a4,1
            precision = va_arg(ap, int);
    80200232:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
    80200236:	00f74463          	blt	a4,a5,8020023e <vprintfmt+0x14a>
    else if (lflag) {
    8020023a:	16078963          	beqz	a5,802003ac <vprintfmt+0x2b8>
        return va_arg(*ap, unsigned long);
    8020023e:	000a3603          	ld	a2,0(s4)
    80200242:	46a9                	li	a3,10
    80200244:	8a2e                	mv	s4,a1
    80200246:	b7f9                	j	80200214 <vprintfmt+0x120>
            putch('0', putdat);
    80200248:	85ca                	mv	a1,s2
    8020024a:	03000513          	li	a0,48
    8020024e:	9482                	jalr	s1
            putch('x', putdat);
    80200250:	85ca                	mv	a1,s2
    80200252:	07800513          	li	a0,120
    80200256:	9482                	jalr	s1
            num = (unsigned long long)va_arg(ap, void *);
    80200258:	000a3603          	ld	a2,0(s4)
            goto number;
    8020025c:	46c1                	li	a3,16
            num = (unsigned long long)va_arg(ap, void *);
    8020025e:	0a21                	addi	s4,s4,8
            goto number;
    80200260:	bf55                	j	80200214 <vprintfmt+0x120>
            putch(ch, putdat);
    80200262:	85ca                	mv	a1,s2
    80200264:	02500513          	li	a0,37
    80200268:	9482                	jalr	s1
            break;
    8020026a:	bd7d                	j	80200128 <vprintfmt+0x34>
            precision = va_arg(ap, int);
    8020026c:	000a2c83          	lw	s9,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
    80200270:	8462                	mv	s0,s8
            precision = va_arg(ap, int);
    80200272:	0a21                	addi	s4,s4,8
            goto process_precision;
    80200274:	bf95                	j	802001e8 <vprintfmt+0xf4>
    if (lflag >= 2) {
    80200276:	4705                	li	a4,1
            precision = va_arg(ap, int);
    80200278:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
    8020027c:	00f74463          	blt	a4,a5,80200284 <vprintfmt+0x190>
    else if (lflag) {
    80200280:	12078163          	beqz	a5,802003a2 <vprintfmt+0x2ae>
        return va_arg(*ap, unsigned long);
    80200284:	000a3603          	ld	a2,0(s4)
    80200288:	46a1                	li	a3,8
    8020028a:	8a2e                	mv	s4,a1
    8020028c:	b761                	j	80200214 <vprintfmt+0x120>
            if (width < 0)
    8020028e:	876a                	mv	a4,s10
    80200290:	000d5363          	bgez	s10,80200296 <vprintfmt+0x1a2>
    80200294:	4701                	li	a4,0
    80200296:	00070d1b          	sext.w	s10,a4
        switch (ch = *(unsigned char *)fmt ++) {
    8020029a:	8462                	mv	s0,s8
            goto reswitch;
    8020029c:	bd55                	j	80200150 <vprintfmt+0x5c>
            if (width > 0 && padc != '-') {
    8020029e:	000d841b          	sext.w	s0,s11
    802002a2:	fd340793          	addi	a5,s0,-45
    802002a6:	00f037b3          	snez	a5,a5
    802002aa:	01a02733          	sgtz	a4,s10
            if ((p = va_arg(ap, char *)) == NULL) {
    802002ae:	000a3d83          	ld	s11,0(s4)
            if (width > 0 && padc != '-') {
    802002b2:	8f7d                	and	a4,a4,a5
            if ((p = va_arg(ap, char *)) == NULL) {
    802002b4:	008a0793          	addi	a5,s4,8
    802002b8:	e43e                	sd	a5,8(sp)
    802002ba:	100d8c63          	beqz	s11,802003d2 <vprintfmt+0x2de>
            if (width > 0 && padc != '-') {
    802002be:	12071363          	bnez	a4,802003e4 <vprintfmt+0x2f0>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    802002c2:	000dc783          	lbu	a5,0(s11)
    802002c6:	0007851b          	sext.w	a0,a5
    802002ca:	c78d                	beqz	a5,802002f4 <vprintfmt+0x200>
    802002cc:	0d85                	addi	s11,s11,1
    802002ce:	547d                	li	s0,-1
                if (altflag && (ch < ' ' || ch > '~')) {
    802002d0:	05e00a13          	li	s4,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    802002d4:	000cc563          	bltz	s9,802002de <vprintfmt+0x1ea>
    802002d8:	3cfd                	addiw	s9,s9,-1
    802002da:	008c8d63          	beq	s9,s0,802002f4 <vprintfmt+0x200>
                if (altflag && (ch < ' ' || ch > '~')) {
    802002de:	020b9663          	bnez	s7,8020030a <vprintfmt+0x216>
                    putch(ch, putdat);
    802002e2:	85ca                	mv	a1,s2
    802002e4:	9482                	jalr	s1
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    802002e6:	000dc783          	lbu	a5,0(s11)
    802002ea:	0d85                	addi	s11,s11,1
    802002ec:	3d7d                	addiw	s10,s10,-1
    802002ee:	0007851b          	sext.w	a0,a5
    802002f2:	f3ed                	bnez	a5,802002d4 <vprintfmt+0x1e0>
            for (; width > 0; width --) {
    802002f4:	01a05963          	blez	s10,80200306 <vprintfmt+0x212>
                putch(' ', putdat);
    802002f8:	85ca                	mv	a1,s2
    802002fa:	02000513          	li	a0,32
            for (; width > 0; width --) {
    802002fe:	3d7d                	addiw	s10,s10,-1
                putch(' ', putdat);
    80200300:	9482                	jalr	s1
            for (; width > 0; width --) {
    80200302:	fe0d1be3          	bnez	s10,802002f8 <vprintfmt+0x204>
            if ((p = va_arg(ap, char *)) == NULL) {
    80200306:	6a22                	ld	s4,8(sp)
    80200308:	b505                	j	80200128 <vprintfmt+0x34>
                if (altflag && (ch < ' ' || ch > '~')) {
    8020030a:	3781                	addiw	a5,a5,-32
    8020030c:	fcfa7be3          	bgeu	s4,a5,802002e2 <vprintfmt+0x1ee>
                    putch('?', putdat);
    80200310:	03f00513          	li	a0,63
    80200314:	85ca                	mv	a1,s2
    80200316:	9482                	jalr	s1
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    80200318:	000dc783          	lbu	a5,0(s11)
    8020031c:	0d85                	addi	s11,s11,1
    8020031e:	3d7d                	addiw	s10,s10,-1
    80200320:	0007851b          	sext.w	a0,a5
    80200324:	dbe1                	beqz	a5,802002f4 <vprintfmt+0x200>
    80200326:	fa0cd9e3          	bgez	s9,802002d8 <vprintfmt+0x1e4>
    8020032a:	b7c5                	j	8020030a <vprintfmt+0x216>
            if (err < 0) {
    8020032c:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
    80200330:	4619                	li	a2,6
            err = va_arg(ap, int);
    80200332:	0a21                	addi	s4,s4,8
            if (err < 0) {
    80200334:	41f7d71b          	sraiw	a4,a5,0x1f
    80200338:	8fb9                	xor	a5,a5,a4
    8020033a:	40e786bb          	subw	a3,a5,a4
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
    8020033e:	02d64563          	blt	a2,a3,80200368 <vprintfmt+0x274>
    80200342:	00000797          	auipc	a5,0x0
    80200346:	39e78793          	addi	a5,a5,926 # 802006e0 <error_string>
    8020034a:	00369713          	slli	a4,a3,0x3
    8020034e:	97ba                	add	a5,a5,a4
    80200350:	639c                	ld	a5,0(a5)
    80200352:	cb99                	beqz	a5,80200368 <vprintfmt+0x274>
                printfmt(putch, putdat, "%s", p);
    80200354:	86be                	mv	a3,a5
    80200356:	00000617          	auipc	a2,0x0
    8020035a:	1aa60613          	addi	a2,a2,426 # 80200500 <memset+0x70>
    8020035e:	85ca                	mv	a1,s2
    80200360:	8526                	mv	a0,s1
    80200362:	0d8000ef          	jal	8020043a <printfmt>
    80200366:	b3c9                	j	80200128 <vprintfmt+0x34>
                printfmt(putch, putdat, "error %d", err);
    80200368:	00000617          	auipc	a2,0x0
    8020036c:	18860613          	addi	a2,a2,392 # 802004f0 <memset+0x60>
    80200370:	85ca                	mv	a1,s2
    80200372:	8526                	mv	a0,s1
    80200374:	0c6000ef          	jal	8020043a <printfmt>
    80200378:	bb45                	j	80200128 <vprintfmt+0x34>
    if (lflag >= 2) {
    8020037a:	4705                	li	a4,1
            precision = va_arg(ap, int);
    8020037c:	008a0b93          	addi	s7,s4,8
    if (lflag >= 2) {
    80200380:	00f74363          	blt	a4,a5,80200386 <vprintfmt+0x292>
    else if (lflag) {
    80200384:	cf81                	beqz	a5,8020039c <vprintfmt+0x2a8>
        return va_arg(*ap, long);
    80200386:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
    8020038a:	02044b63          	bltz	s0,802003c0 <vprintfmt+0x2cc>
            num = getint(&ap, lflag);
    8020038e:	8622                	mv	a2,s0
    80200390:	8a5e                	mv	s4,s7
    80200392:	46a9                	li	a3,10
    80200394:	b541                	j	80200214 <vprintfmt+0x120>
            lflag ++;
    80200396:	2785                	addiw	a5,a5,1
        switch (ch = *(unsigned char *)fmt ++) {
    80200398:	8462                	mv	s0,s8
            goto reswitch;
    8020039a:	bb5d                	j	80200150 <vprintfmt+0x5c>
        return va_arg(*ap, int);
    8020039c:	000a2403          	lw	s0,0(s4)
    802003a0:	b7ed                	j	8020038a <vprintfmt+0x296>
        return va_arg(*ap, unsigned int);
    802003a2:	000a6603          	lwu	a2,0(s4)
    802003a6:	46a1                	li	a3,8
    802003a8:	8a2e                	mv	s4,a1
    802003aa:	b5ad                	j	80200214 <vprintfmt+0x120>
    802003ac:	000a6603          	lwu	a2,0(s4)
    802003b0:	46a9                	li	a3,10
    802003b2:	8a2e                	mv	s4,a1
    802003b4:	b585                	j	80200214 <vprintfmt+0x120>
    802003b6:	000a6603          	lwu	a2,0(s4)
    802003ba:	46c1                	li	a3,16
    802003bc:	8a2e                	mv	s4,a1
    802003be:	bd99                	j	80200214 <vprintfmt+0x120>
                putch('-', putdat);
    802003c0:	85ca                	mv	a1,s2
    802003c2:	02d00513          	li	a0,45
    802003c6:	9482                	jalr	s1
                num = -(long long)num;
    802003c8:	40800633          	neg	a2,s0
    802003cc:	8a5e                	mv	s4,s7
    802003ce:	46a9                	li	a3,10
    802003d0:	b591                	j	80200214 <vprintfmt+0x120>
            if (width > 0 && padc != '-') {
    802003d2:	e329                	bnez	a4,80200414 <vprintfmt+0x320>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    802003d4:	02800793          	li	a5,40
    802003d8:	853e                	mv	a0,a5
    802003da:	00000d97          	auipc	s11,0x0
    802003de:	10fd8d93          	addi	s11,s11,271 # 802004e9 <memset+0x59>
    802003e2:	b5f5                	j	802002ce <vprintfmt+0x1da>
                for (width -= strnlen(p, precision); width > 0; width --) {
    802003e4:	85e6                	mv	a1,s9
    802003e6:	856e                	mv	a0,s11
    802003e8:	08c000ef          	jal	80200474 <strnlen>
    802003ec:	40ad0d3b          	subw	s10,s10,a0
    802003f0:	01a05863          	blez	s10,80200400 <vprintfmt+0x30c>
                    putch(padc, putdat);
    802003f4:	85ca                	mv	a1,s2
    802003f6:	8522                	mv	a0,s0
                for (width -= strnlen(p, precision); width > 0; width --) {
    802003f8:	3d7d                	addiw	s10,s10,-1
                    putch(padc, putdat);
    802003fa:	9482                	jalr	s1
                for (width -= strnlen(p, precision); width > 0; width --) {
    802003fc:	fe0d1ce3          	bnez	s10,802003f4 <vprintfmt+0x300>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    80200400:	000dc783          	lbu	a5,0(s11)
    80200404:	0007851b          	sext.w	a0,a5
    80200408:	ec0792e3          	bnez	a5,802002cc <vprintfmt+0x1d8>
            if ((p = va_arg(ap, char *)) == NULL) {
    8020040c:	6a22                	ld	s4,8(sp)
    8020040e:	bb29                	j	80200128 <vprintfmt+0x34>
        switch (ch = *(unsigned char *)fmt ++) {
    80200410:	8462                	mv	s0,s8
    80200412:	bbd9                	j	802001e8 <vprintfmt+0xf4>
                for (width -= strnlen(p, precision); width > 0; width --) {
    80200414:	85e6                	mv	a1,s9
    80200416:	00000517          	auipc	a0,0x0
    8020041a:	0d250513          	addi	a0,a0,210 # 802004e8 <memset+0x58>
    8020041e:	056000ef          	jal	80200474 <strnlen>
    80200422:	40ad0d3b          	subw	s10,s10,a0
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    80200426:	02800793          	li	a5,40
                p = "(null)";
    8020042a:	00000d97          	auipc	s11,0x0
    8020042e:	0bed8d93          	addi	s11,s11,190 # 802004e8 <memset+0x58>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    80200432:	853e                	mv	a0,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
    80200434:	fda040e3          	bgtz	s10,802003f4 <vprintfmt+0x300>
    80200438:	bd51                	j	802002cc <vprintfmt+0x1d8>

000000008020043a <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
    8020043a:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
    8020043c:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
    80200440:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
    80200442:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
    80200444:	ec06                	sd	ra,24(sp)
    80200446:	f83a                	sd	a4,48(sp)
    80200448:	fc3e                	sd	a5,56(sp)
    8020044a:	e0c2                	sd	a6,64(sp)
    8020044c:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
    8020044e:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
    80200450:	ca5ff0ef          	jal	802000f4 <vprintfmt>
}
    80200454:	60e2                	ld	ra,24(sp)
    80200456:	6161                	addi	sp,sp,80
    80200458:	8082                	ret

000000008020045a <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
    8020045a:	00003717          	auipc	a4,0x3
    8020045e:	ba673703          	ld	a4,-1114(a4) # 80203000 <SBI_CONSOLE_PUTCHAR>
    80200462:	4781                	li	a5,0
    80200464:	88ba                	mv	a7,a4
    80200466:	852a                	mv	a0,a0
    80200468:	85be                	mv	a1,a5
    8020046a:	863e                	mv	a2,a5
    8020046c:	00000073          	ecall
    80200470:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
    80200472:	8082                	ret

0000000080200474 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    80200474:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
    80200476:	e589                	bnez	a1,80200480 <strnlen+0xc>
    80200478:	a811                	j	8020048c <strnlen+0x18>
        cnt ++;
    8020047a:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
    8020047c:	00f58863          	beq	a1,a5,8020048c <strnlen+0x18>
    80200480:	00f50733          	add	a4,a0,a5
    80200484:	00074703          	lbu	a4,0(a4)
    80200488:	fb6d                	bnez	a4,8020047a <strnlen+0x6>
    8020048a:	85be                	mv	a1,a5
    }
    return cnt;
}
    8020048c:	852e                	mv	a0,a1
    8020048e:	8082                	ret

0000000080200490 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
    80200490:	ca01                	beqz	a2,802004a0 <memset+0x10>
    80200492:	962a                	add	a2,a2,a0
    char *p = s;
    80200494:	87aa                	mv	a5,a0
        *p ++ = c;
    80200496:	0785                	addi	a5,a5,1
    80200498:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
    8020049c:	fef61de3          	bne	a2,a5,80200496 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
    802004a0:	8082                	ret
