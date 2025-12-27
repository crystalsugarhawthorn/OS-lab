
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	1ee0b0ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	25658593          	addi	a1,a1,598 # ffffffffc020b2c0 <etext+0x6>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	26e50513          	addi	a0,a0,622 # ffffffffc020b2e0 <etext+0x26>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	409020ef          	jal	ra,ffffffffc0202c8e <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	635030ef          	jal	ra,ffffffffc0203ec6 <vmm_init>
ffffffffc0200096:	753060ef          	jal	ra,ffffffffc0206fe8 <sched_init>
ffffffffc020009a:	359060ef          	jal	ra,ffffffffc0206bf2 <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	066050ef          	jal	ra,ffffffffc0205108 <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	511060ef          	jal	ra,ffffffffc0206dbe <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000b517          	auipc	a0,0xb
ffffffffc02000cc:	22050513          	addi	a0,a0,544 # ffffffffc020b2e8 <etext+0x2e>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00091b97          	auipc	s7,0x91
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0291060 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00091517          	auipc	a0,0x91
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0291060 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	4290a0ef          	jal	ra,ffffffffc020adc2 <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	3ed0a0ef          	jal	ra,ffffffffc020adc2 <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	7af0a0ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	587010ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	08c0b0ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000b517          	auipc	a0,0xb
ffffffffc0200232:	0c250513          	addi	a0,a0,194 # ffffffffc020b2f0 <etext+0x36>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	0cc50513          	addi	a0,a0,204 # ffffffffc020b310 <etext+0x56>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	06a58593          	addi	a1,a1,106 # ffffffffc020b2ba <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	0d850513          	addi	a0,a0,216 # ffffffffc020b330 <etext+0x76>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	0e450513          	addi	a0,a0,228 # ffffffffc020b350 <etext+0x96>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	0f050513          	addi	a0,a0,240 # ffffffffc020b370 <etext+0xb6>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00097597          	auipc	a1,0x97
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	0e250513          	addi	a0,a0,226 # ffffffffc020b390 <etext+0xd6>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	10460613          	addi	a2,a2,260 # ffffffffc020b3c0 <etext+0x106>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	11050513          	addi	a0,a0,272 # ffffffffc020b3d8 <etext+0x11e>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	11860613          	addi	a2,a2,280 # ffffffffc020b3f0 <etext+0x136>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	13058593          	addi	a1,a1,304 # ffffffffc020b410 <etext+0x156>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	13050513          	addi	a0,a0,304 # ffffffffc020b418 <etext+0x15e>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	13260613          	addi	a2,a2,306 # ffffffffc020b428 <etext+0x16e>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	15258593          	addi	a1,a1,338 # ffffffffc020b450 <etext+0x196>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	11250513          	addi	a0,a0,274 # ffffffffc020b418 <etext+0x15e>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	14e60613          	addi	a2,a2,334 # ffffffffc020b460 <etext+0x1a6>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	16658593          	addi	a1,a1,358 # ffffffffc020b480 <etext+0x1c6>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	0f650513          	addi	a0,a0,246 # ffffffffc020b418 <etext+0x15e>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	13450513          	addi	a0,a0,308 # ffffffffc020b490 <etext+0x1d6>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000b517          	auipc	a0,0xb
ffffffffc0200382:	13a50513          	addi	a0,a0,314 # ffffffffc020b4b8 <etext+0x1fe>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	194c0c13          	addi	s8,s8,404 # ffffffffc020b528 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	14490913          	addi	s2,s2,324 # ffffffffc020b4e0 <etext+0x226>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	14448493          	addi	s1,s1,324 # ffffffffc020b4e8 <etext+0x22e>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	142b0b13          	addi	s6,s6,322 # ffffffffc020b4f0 <etext+0x236>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	05aa0a13          	addi	s4,s4,90 # ffffffffc020b410 <etext+0x156>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000bd17          	auipc	s10,0xb
ffffffffc02003dc:	150d0d13          	addi	s10,s10,336 # ffffffffc020b528 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	6110a0ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	5fd0a0ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	6030a0ef          	jal	ra,ffffffffc020b23a <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	5c50a0ef          	jal	ra,ffffffffc020b23a <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000b517          	auipc	a0,0xb
ffffffffc0200494:	08050513          	addi	a0,a0,128 # ffffffffc020b510 <etext+0x256>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00096317          	auipc	t1,0x96
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0296868 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000b517          	auipc	a0,0xb
ffffffffc02004d0:	0a450513          	addi	a0,a0,164 # ffffffffc020b570 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	36e50513          	addi	a0,a0,878 # ffffffffc020c850 <default_pmm_manager+0x630>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000b517          	auipc	a0,0xb
ffffffffc020051a:	07a50513          	addi	a0,a0,122 # ffffffffc020b590 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000c517          	auipc	a0,0xc
ffffffffc020053a:	31a50513          	addi	a0,a0,794 # ffffffffc020c850 <default_pmm_manager+0x630>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000b517          	auipc	a0,0xb
ffffffffc020056c:	04850513          	addi	a0,a0,72 # ffffffffc020b5b0 <commands+0x88>
ffffffffc0200570:	00096797          	auipc	a5,0x96
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0296870 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00091697          	auipc	a3,0x91
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0291460 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00091797          	auipc	a5,0x91
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0291664 <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00091797          	auipc	a5,0x91
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0291660 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000b517          	auipc	a0,0xb
ffffffffc02006b2:	f2250513          	addi	a0,a0,-222 # ffffffffc020b5d0 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00014597          	auipc	a1,0x14
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02006dc:	0000b517          	auipc	a0,0xb
ffffffffc02006e0:	f0450513          	addi	a0,a0,-252 # ffffffffc020b5e0 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	efe50513          	addi	a0,a0,-258 # ffffffffc020b5f0 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	f0650513          	addi	a0,a0,-250 # ffffffffc020b608 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000b917          	auipc	s2,0xb
ffffffffc02007c0:	e9c90913          	addi	s2,s2,-356 # ffffffffc020b658 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	e8648493          	addi	s1,s1,-378 # ffffffffc020b650 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000b517          	auipc	a0,0xb
ffffffffc0200822:	eb250513          	addi	a0,a0,-334 # ffffffffc020b6d0 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	ede50513          	addi	a0,a0,-290 # ffffffffc020b708 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000b517          	auipc	a0,0xb
ffffffffc020086e:	dbe50513          	addi	a0,a0,-578 # ffffffffc020b628 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	1370a0ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	18f0a0ef          	jal	ra,ffffffffc020b214 <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	0db0a0ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	d3050513          	addi	a0,a0,-720 # ffffffffc020b660 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000b517          	auipc	a0,0xb
ffffffffc0200a02:	c8250513          	addi	a0,a0,-894 # ffffffffc020b680 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	c8850513          	addi	a0,a0,-888 # ffffffffc020b698 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	c9650513          	addi	a0,a0,-874 # ffffffffc020b6b8 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	cda50513          	addi	a0,a0,-806 # ffffffffc020b708 <commands+0x1e0>
ffffffffc0200a36:	00096797          	auipc	a5,0x96
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200a3e:	00096797          	auipc	a5,0x96
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00096517          	auipc	a0,0x96
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00096517          	auipc	a0,0x96
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00091597          	auipc	a1,0x91
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00091797          	auipc	a5,0x91
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0291668 <ide_devices>
ffffffffc0200a72:	00091797          	auipc	a5,0x91
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a7a:	00091797          	auipc	a5,0x91
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200a82:	00091797          	auipc	a5,0x91
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0291758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00091417          	auipc	s0,0x91
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0291668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00091597          	auipc	a1,0x91
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000b697          	auipc	a3,0xb
ffffffffc0200abc:	c6868693          	addi	a3,a3,-920 # ffffffffc020b720 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	c7860613          	addi	a2,a2,-904 # ffffffffc020b738 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	c8650513          	addi	a0,a0,-890 # ffffffffc020b750 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	c9268693          	addi	a3,a3,-878 # ffffffffc020b768 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	c5a60613          	addi	a2,a2,-934 # ffffffffc020b738 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	c6850513          	addi	a0,a0,-920 # ffffffffc020b750 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00091797          	auipc	a5,0x91
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0291668 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00091797          	auipc	a5,0x91
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0291668 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00091817          	auipc	a6,0x91
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0291668 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000b697          	auipc	a3,0xb
ffffffffc0200b9a:	bea68693          	addi	a3,a3,-1046 # ffffffffc020b780 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	b9a60613          	addi	a2,a2,-1126 # ffffffffc020b738 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	ba650513          	addi	a0,a0,-1114 # ffffffffc020b750 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	bf268693          	addi	a3,a3,-1038 # ffffffffc020b7a8 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	b7a60613          	addi	a2,a2,-1158 # ffffffffc020b738 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	b8650513          	addi	a0,a0,-1146 # ffffffffc020b750 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00091817          	auipc	a6,0x91
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0291668 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000b697          	auipc	a3,0xb
ffffffffc0200c30:	b5468693          	addi	a3,a3,-1196 # ffffffffc020b780 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	b0460613          	addi	a2,a2,-1276 # ffffffffc020b738 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	b1050513          	addi	a0,a0,-1264 # ffffffffc020b750 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	b5c68693          	addi	a3,a3,-1188 # ffffffffc020b7a8 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	ae460613          	addi	a2,a2,-1308 # ffffffffc020b738 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	af050513          	addi	a0,a0,-1296 # ffffffffc020b750 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	60a0a0ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	5e00a0ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	56c0a0ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	00090617          	auipc	a2,0x90
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0291010 <arena>
ffffffffc0200cf8:	0001b917          	auipc	s2,0x1b
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000b517          	auipc	a0,0xb
ffffffffc0200d16:	aee50513          	addi	a0,a0,-1298 # ffffffffc020b800 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000b597          	auipc	a1,0xb
ffffffffc0200d38:	b2458593          	addi	a1,a1,-1244 # ffffffffc020b858 <commands+0x330>
ffffffffc0200d3c:	4a80a0ef          	jal	ra,ffffffffc020b1e4 <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001b617          	auipc	a2,0x1b
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00013917          	auipc	s2,0x13
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000b517          	auipc	a0,0xb
ffffffffc0200d80:	a6c50513          	addi	a0,a0,-1428 # ffffffffc020b7e8 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	a9e60613          	addi	a2,a2,-1378 # ffffffffc020b828 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	aaa50513          	addi	a0,a0,-1366 # ffffffffc020b840 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e0 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000b517          	auipc	a0,0xb
ffffffffc0200dc8:	aa450513          	addi	a0,a0,-1372 # ffffffffc020b868 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	aac50513          	addi	a0,a0,-1364 # ffffffffc020b880 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	ab650513          	addi	a0,a0,-1354 # ffffffffc020b898 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	ac050513          	addi	a0,a0,-1344 # ffffffffc020b8b0 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	aca50513          	addi	a0,a0,-1334 # ffffffffc020b8c8 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	ad450513          	addi	a0,a0,-1324 # ffffffffc020b8e0 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	ade50513          	addi	a0,a0,-1314 # ffffffffc020b8f8 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	ae850513          	addi	a0,a0,-1304 # ffffffffc020b910 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	af250513          	addi	a0,a0,-1294 # ffffffffc020b928 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	afc50513          	addi	a0,a0,-1284 # ffffffffc020b940 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	b0650513          	addi	a0,a0,-1274 # ffffffffc020b958 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	b1050513          	addi	a0,a0,-1264 # ffffffffc020b970 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	b1a50513          	addi	a0,a0,-1254 # ffffffffc020b988 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	b2450513          	addi	a0,a0,-1244 # ffffffffc020b9a0 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	b2e50513          	addi	a0,a0,-1234 # ffffffffc020b9b8 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	b3850513          	addi	a0,a0,-1224 # ffffffffc020b9d0 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	b4250513          	addi	a0,a0,-1214 # ffffffffc020b9e8 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	b4c50513          	addi	a0,a0,-1204 # ffffffffc020ba00 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	b5650513          	addi	a0,a0,-1194 # ffffffffc020ba18 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	b6050513          	addi	a0,a0,-1184 # ffffffffc020ba30 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	b6a50513          	addi	a0,a0,-1174 # ffffffffc020ba48 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	b7450513          	addi	a0,a0,-1164 # ffffffffc020ba60 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	b7e50513          	addi	a0,a0,-1154 # ffffffffc020ba78 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	b8850513          	addi	a0,a0,-1144 # ffffffffc020ba90 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	b9250513          	addi	a0,a0,-1134 # ffffffffc020baa8 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	b9c50513          	addi	a0,a0,-1124 # ffffffffc020bac0 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	ba650513          	addi	a0,a0,-1114 # ffffffffc020bad8 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	bb050513          	addi	a0,a0,-1104 # ffffffffc020baf0 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	bba50513          	addi	a0,a0,-1094 # ffffffffc020bb08 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	bc450513          	addi	a0,a0,-1084 # ffffffffc020bb20 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	bce50513          	addi	a0,a0,-1074 # ffffffffc020bb38 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	bd450513          	addi	a0,a0,-1068 # ffffffffc020bb50 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	bd650513          	addi	a0,a0,-1066 # ffffffffc020bb68 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	bd650513          	addi	a0,a0,-1066 # ffffffffc020bb80 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	bde50513          	addi	a0,a0,-1058 # ffffffffc020bb98 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	be650513          	addi	a0,a0,-1050 # ffffffffc020bbb0 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	be250513          	addi	a0,a0,-1054 # ffffffffc020bbc0 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000b717          	auipc	a4,0xb
ffffffffc0200ffe:	c7e70713          	addi	a4,a4,-898 # ffffffffc020bc78 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000b517          	auipc	a0,0xb
ffffffffc0201010:	c2c50513          	addi	a0,a0,-980 # ffffffffc020bc38 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000b517          	auipc	a0,0xb
ffffffffc020101c:	c0050513          	addi	a0,a0,-1024 # ffffffffc020bc18 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000b517          	auipc	a0,0xb
ffffffffc0201028:	bb450513          	addi	a0,a0,-1100 # ffffffffc020bbd8 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000b517          	auipc	a0,0xb
ffffffffc0201034:	bc850513          	addi	a0,a0,-1080 # ffffffffc020bbf8 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00096717          	auipc	a4,0x96
ffffffffc0201048:	82c70713          	addi	a4,a4,-2004 # ffffffffc0296870 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	2a6060ef          	jal	ra,ffffffffc02072f8 <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	16b0706f          	j	ffffffffc02089c8 <dev_stdin_write>
ffffffffc0201062:	0000b517          	auipc	a0,0xb
ffffffffc0201066:	bf650513          	addi	a0,a0,-1034 # ffffffffc020bc58 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0af76b63          	bltu	a4,a5,ffffffffc0201134 <exception_handler+0xc4>
ffffffffc0201082:	0000b717          	auipc	a4,0xb
ffffffffc0201086:	db670713          	addi	a4,a4,-586 # ffffffffc020be38 <commands+0x910>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000b517          	auipc	a0,0xb
ffffffffc0201098:	cfc50513          	addi	a0,a0,-772 # ffffffffc020bd90 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	45e0606f          	j	ffffffffc020750e <syscall>
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	cfc50513          	addi	a0,a0,-772 # ffffffffc020bdb0 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000b517          	auipc	a0,0xb
ffffffffc02010ca:	d0a50513          	addi	a0,a0,-758 # ffffffffc020bdd0 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000b517          	auipc	a0,0xb
ffffffffc02010d4:	d2050513          	addi	a0,a0,-736 # ffffffffc020bdf0 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000b517          	auipc	a0,0xb
ffffffffc02010de:	d2e50513          	addi	a0,a0,-722 # ffffffffc020be08 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000b517          	auipc	a0,0xb
ffffffffc02010e8:	d3c50513          	addi	a0,a0,-708 # ffffffffc020be20 <commands+0x8f8>
ffffffffc02010ec:	bfc1                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010ee:	0000b517          	auipc	a0,0xb
ffffffffc02010f2:	bba50513          	addi	a0,a0,-1094 # ffffffffc020bca8 <commands+0x780>
ffffffffc02010f6:	b7d9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010f8:	0000b517          	auipc	a0,0xb
ffffffffc02010fc:	bd050513          	addi	a0,a0,-1072 # ffffffffc020bcc8 <commands+0x7a0>
ffffffffc0201100:	bf75                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201102:	0000b517          	auipc	a0,0xb
ffffffffc0201106:	be650513          	addi	a0,a0,-1050 # ffffffffc020bce8 <commands+0x7c0>
ffffffffc020110a:	bf4d                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020110c:	0000b517          	auipc	a0,0xb
ffffffffc0201110:	bf450513          	addi	a0,a0,-1036 # ffffffffc020bd00 <commands+0x7d8>
ffffffffc0201114:	b765                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201116:	0000b517          	auipc	a0,0xb
ffffffffc020111a:	bfa50513          	addi	a0,a0,-1030 # ffffffffc020bd10 <commands+0x7e8>
ffffffffc020111e:	bf79                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201120:	0000b517          	auipc	a0,0xb
ffffffffc0201124:	c1050513          	addi	a0,a0,-1008 # ffffffffc020bd30 <commands+0x808>
ffffffffc0201128:	bf51                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112a:	0000b517          	auipc	a0,0xb
ffffffffc020112e:	c4e50513          	addi	a0,a0,-946 # ffffffffc020bd78 <commands+0x850>
ffffffffc0201132:	b769                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201134:	8522                	mv	a0,s0
ffffffffc0201136:	6402                	ld	s0,0(sp)
ffffffffc0201138:	60a2                	ld	ra,8(sp)
ffffffffc020113a:	0141                	addi	sp,sp,16
ffffffffc020113c:	b5b9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc020113e:	0000b617          	auipc	a2,0xb
ffffffffc0201142:	c0a60613          	addi	a2,a2,-1014 # ffffffffc020bd48 <commands+0x820>
ffffffffc0201146:	0b100593          	li	a1,177
ffffffffc020114a:	0000b517          	auipc	a0,0xb
ffffffffc020114e:	c1650513          	addi	a0,a0,-1002 # ffffffffc020bd60 <commands+0x838>
ffffffffc0201152:	b4cff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201156 <trap>:
ffffffffc0201156:	1101                	addi	sp,sp,-32
ffffffffc0201158:	e822                	sd	s0,16(sp)
ffffffffc020115a:	00095417          	auipc	s0,0x95
ffffffffc020115e:	76640413          	addi	s0,s0,1894 # ffffffffc02968c0 <current>
ffffffffc0201162:	6018                	ld	a4,0(s0)
ffffffffc0201164:	ec06                	sd	ra,24(sp)
ffffffffc0201166:	e426                	sd	s1,8(sp)
ffffffffc0201168:	e04a                	sd	s2,0(sp)
ffffffffc020116a:	11853683          	ld	a3,280(a0)
ffffffffc020116e:	cf1d                	beqz	a4,ffffffffc02011ac <trap+0x56>
ffffffffc0201170:	10053483          	ld	s1,256(a0)
ffffffffc0201174:	0a073903          	ld	s2,160(a4)
ffffffffc0201178:	f348                	sd	a0,160(a4)
ffffffffc020117a:	1004f493          	andi	s1,s1,256
ffffffffc020117e:	0206c463          	bltz	a3,ffffffffc02011a6 <trap+0x50>
ffffffffc0201182:	eefff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc0201186:	601c                	ld	a5,0(s0)
ffffffffc0201188:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020118c:	e499                	bnez	s1,ffffffffc020119a <trap+0x44>
ffffffffc020118e:	0b07a703          	lw	a4,176(a5)
ffffffffc0201192:	8b05                	andi	a4,a4,1
ffffffffc0201194:	e329                	bnez	a4,ffffffffc02011d6 <trap+0x80>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	eb85                	bnez	a5,ffffffffc02011c8 <trap+0x72>
ffffffffc020119a:	60e2                	ld	ra,24(sp)
ffffffffc020119c:	6442                	ld	s0,16(sp)
ffffffffc020119e:	64a2                	ld	s1,8(sp)
ffffffffc02011a0:	6902                	ld	s2,0(sp)
ffffffffc02011a2:	6105                	addi	sp,sp,32
ffffffffc02011a4:	8082                	ret
ffffffffc02011a6:	e47ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011aa:	bff1                	j	ffffffffc0201186 <trap+0x30>
ffffffffc02011ac:	0006c863          	bltz	a3,ffffffffc02011bc <trap+0x66>
ffffffffc02011b0:	6442                	ld	s0,16(sp)
ffffffffc02011b2:	60e2                	ld	ra,24(sp)
ffffffffc02011b4:	64a2                	ld	s1,8(sp)
ffffffffc02011b6:	6902                	ld	s2,0(sp)
ffffffffc02011b8:	6105                	addi	sp,sp,32
ffffffffc02011ba:	bd5d                	j	ffffffffc0201070 <exception_handler>
ffffffffc02011bc:	6442                	ld	s0,16(sp)
ffffffffc02011be:	60e2                	ld	ra,24(sp)
ffffffffc02011c0:	64a2                	ld	s1,8(sp)
ffffffffc02011c2:	6902                	ld	s2,0(sp)
ffffffffc02011c4:	6105                	addi	sp,sp,32
ffffffffc02011c6:	b51d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011c8:	6442                	ld	s0,16(sp)
ffffffffc02011ca:	60e2                	ld	ra,24(sp)
ffffffffc02011cc:	64a2                	ld	s1,8(sp)
ffffffffc02011ce:	6902                	ld	s2,0(sp)
ffffffffc02011d0:	6105                	addi	sp,sp,32
ffffffffc02011d2:	71b0506f          	j	ffffffffc02070ec <schedule>
ffffffffc02011d6:	555d                	li	a0,-9
ffffffffc02011d8:	51b040ef          	jal	ra,ffffffffc0205ef2 <do_exit>
ffffffffc02011dc:	601c                	ld	a5,0(s0)
ffffffffc02011de:	bf65                	j	ffffffffc0201196 <trap+0x40>

ffffffffc02011e0 <__alltraps>:
ffffffffc02011e0:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e4:	00011463          	bnez	sp,ffffffffc02011ec <__alltraps+0xc>
ffffffffc02011e8:	14002173          	csrr	sp,sscratch
ffffffffc02011ec:	712d                	addi	sp,sp,-288
ffffffffc02011ee:	e002                	sd	zero,0(sp)
ffffffffc02011f0:	e406                	sd	ra,8(sp)
ffffffffc02011f2:	ec0e                	sd	gp,24(sp)
ffffffffc02011f4:	f012                	sd	tp,32(sp)
ffffffffc02011f6:	f416                	sd	t0,40(sp)
ffffffffc02011f8:	f81a                	sd	t1,48(sp)
ffffffffc02011fa:	fc1e                	sd	t2,56(sp)
ffffffffc02011fc:	e0a2                	sd	s0,64(sp)
ffffffffc02011fe:	e4a6                	sd	s1,72(sp)
ffffffffc0201200:	e8aa                	sd	a0,80(sp)
ffffffffc0201202:	ecae                	sd	a1,88(sp)
ffffffffc0201204:	f0b2                	sd	a2,96(sp)
ffffffffc0201206:	f4b6                	sd	a3,104(sp)
ffffffffc0201208:	f8ba                	sd	a4,112(sp)
ffffffffc020120a:	fcbe                	sd	a5,120(sp)
ffffffffc020120c:	e142                	sd	a6,128(sp)
ffffffffc020120e:	e546                	sd	a7,136(sp)
ffffffffc0201210:	e94a                	sd	s2,144(sp)
ffffffffc0201212:	ed4e                	sd	s3,152(sp)
ffffffffc0201214:	f152                	sd	s4,160(sp)
ffffffffc0201216:	f556                	sd	s5,168(sp)
ffffffffc0201218:	f95a                	sd	s6,176(sp)
ffffffffc020121a:	fd5e                	sd	s7,184(sp)
ffffffffc020121c:	e1e2                	sd	s8,192(sp)
ffffffffc020121e:	e5e6                	sd	s9,200(sp)
ffffffffc0201220:	e9ea                	sd	s10,208(sp)
ffffffffc0201222:	edee                	sd	s11,216(sp)
ffffffffc0201224:	f1f2                	sd	t3,224(sp)
ffffffffc0201226:	f5f6                	sd	t4,232(sp)
ffffffffc0201228:	f9fa                	sd	t5,240(sp)
ffffffffc020122a:	fdfe                	sd	t6,248(sp)
ffffffffc020122c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201230:	100024f3          	csrr	s1,sstatus
ffffffffc0201234:	14102973          	csrr	s2,sepc
ffffffffc0201238:	143029f3          	csrr	s3,stval
ffffffffc020123c:	14202a73          	csrr	s4,scause
ffffffffc0201240:	e822                	sd	s0,16(sp)
ffffffffc0201242:	e226                	sd	s1,256(sp)
ffffffffc0201244:	e64a                	sd	s2,264(sp)
ffffffffc0201246:	ea4e                	sd	s3,272(sp)
ffffffffc0201248:	ee52                	sd	s4,280(sp)
ffffffffc020124a:	850a                	mv	a0,sp
ffffffffc020124c:	f0bff0ef          	jal	ra,ffffffffc0201156 <trap>

ffffffffc0201250 <__trapret>:
ffffffffc0201250:	6492                	ld	s1,256(sp)
ffffffffc0201252:	6932                	ld	s2,264(sp)
ffffffffc0201254:	1004f413          	andi	s0,s1,256
ffffffffc0201258:	e401                	bnez	s0,ffffffffc0201260 <__trapret+0x10>
ffffffffc020125a:	1200                	addi	s0,sp,288
ffffffffc020125c:	14041073          	csrw	sscratch,s0
ffffffffc0201260:	10049073          	csrw	sstatus,s1
ffffffffc0201264:	14191073          	csrw	sepc,s2
ffffffffc0201268:	60a2                	ld	ra,8(sp)
ffffffffc020126a:	61e2                	ld	gp,24(sp)
ffffffffc020126c:	7202                	ld	tp,32(sp)
ffffffffc020126e:	72a2                	ld	t0,40(sp)
ffffffffc0201270:	7342                	ld	t1,48(sp)
ffffffffc0201272:	73e2                	ld	t2,56(sp)
ffffffffc0201274:	6406                	ld	s0,64(sp)
ffffffffc0201276:	64a6                	ld	s1,72(sp)
ffffffffc0201278:	6546                	ld	a0,80(sp)
ffffffffc020127a:	65e6                	ld	a1,88(sp)
ffffffffc020127c:	7606                	ld	a2,96(sp)
ffffffffc020127e:	76a6                	ld	a3,104(sp)
ffffffffc0201280:	7746                	ld	a4,112(sp)
ffffffffc0201282:	77e6                	ld	a5,120(sp)
ffffffffc0201284:	680a                	ld	a6,128(sp)
ffffffffc0201286:	68aa                	ld	a7,136(sp)
ffffffffc0201288:	694a                	ld	s2,144(sp)
ffffffffc020128a:	69ea                	ld	s3,152(sp)
ffffffffc020128c:	7a0a                	ld	s4,160(sp)
ffffffffc020128e:	7aaa                	ld	s5,168(sp)
ffffffffc0201290:	7b4a                	ld	s6,176(sp)
ffffffffc0201292:	7bea                	ld	s7,184(sp)
ffffffffc0201294:	6c0e                	ld	s8,192(sp)
ffffffffc0201296:	6cae                	ld	s9,200(sp)
ffffffffc0201298:	6d4e                	ld	s10,208(sp)
ffffffffc020129a:	6dee                	ld	s11,216(sp)
ffffffffc020129c:	7e0e                	ld	t3,224(sp)
ffffffffc020129e:	7eae                	ld	t4,232(sp)
ffffffffc02012a0:	7f4e                	ld	t5,240(sp)
ffffffffc02012a2:	7fee                	ld	t6,248(sp)
ffffffffc02012a4:	6142                	ld	sp,16(sp)
ffffffffc02012a6:	10200073          	sret

ffffffffc02012aa <forkrets>:
ffffffffc02012aa:	812a                	mv	sp,a0
ffffffffc02012ac:	b755                	j	ffffffffc0201250 <__trapret>

ffffffffc02012ae <default_init>:
ffffffffc02012ae:	00090797          	auipc	a5,0x90
ffffffffc02012b2:	4fa78793          	addi	a5,a5,1274 # ffffffffc02917a8 <free_area>
ffffffffc02012b6:	e79c                	sd	a5,8(a5)
ffffffffc02012b8:	e39c                	sd	a5,0(a5)
ffffffffc02012ba:	0007a823          	sw	zero,16(a5)
ffffffffc02012be:	8082                	ret

ffffffffc02012c0 <default_nr_free_pages>:
ffffffffc02012c0:	00090517          	auipc	a0,0x90
ffffffffc02012c4:	4f856503          	lwu	a0,1272(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <default_check>:
ffffffffc02012ca:	715d                	addi	sp,sp,-80
ffffffffc02012cc:	e0a2                	sd	s0,64(sp)
ffffffffc02012ce:	00090417          	auipc	s0,0x90
ffffffffc02012d2:	4da40413          	addi	s0,s0,1242 # ffffffffc02917a8 <free_area>
ffffffffc02012d6:	641c                	ld	a5,8(s0)
ffffffffc02012d8:	e486                	sd	ra,72(sp)
ffffffffc02012da:	fc26                	sd	s1,56(sp)
ffffffffc02012dc:	f84a                	sd	s2,48(sp)
ffffffffc02012de:	f44e                	sd	s3,40(sp)
ffffffffc02012e0:	f052                	sd	s4,32(sp)
ffffffffc02012e2:	ec56                	sd	s5,24(sp)
ffffffffc02012e4:	e85a                	sd	s6,16(sp)
ffffffffc02012e6:	e45e                	sd	s7,8(sp)
ffffffffc02012e8:	e062                	sd	s8,0(sp)
ffffffffc02012ea:	2a878d63          	beq	a5,s0,ffffffffc02015a4 <default_check+0x2da>
ffffffffc02012ee:	4481                	li	s1,0
ffffffffc02012f0:	4901                	li	s2,0
ffffffffc02012f2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012f6:	8b09                	andi	a4,a4,2
ffffffffc02012f8:	2a070a63          	beqz	a4,ffffffffc02015ac <default_check+0x2e2>
ffffffffc02012fc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201300:	679c                	ld	a5,8(a5)
ffffffffc0201302:	2905                	addiw	s2,s2,1
ffffffffc0201304:	9cb9                	addw	s1,s1,a4
ffffffffc0201306:	fe8796e3          	bne	a5,s0,ffffffffc02012f2 <default_check+0x28>
ffffffffc020130a:	89a6                	mv	s3,s1
ffffffffc020130c:	6df000ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0201310:	6f351e63          	bne	a0,s3,ffffffffc0201a0c <default_check+0x742>
ffffffffc0201314:	4505                	li	a0,1
ffffffffc0201316:	657000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020131a:	8aaa                	mv	s5,a0
ffffffffc020131c:	42050863          	beqz	a0,ffffffffc020174c <default_check+0x482>
ffffffffc0201320:	4505                	li	a0,1
ffffffffc0201322:	64b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201326:	89aa                	mv	s3,a0
ffffffffc0201328:	70050263          	beqz	a0,ffffffffc0201a2c <default_check+0x762>
ffffffffc020132c:	4505                	li	a0,1
ffffffffc020132e:	63f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201332:	8a2a                	mv	s4,a0
ffffffffc0201334:	48050c63          	beqz	a0,ffffffffc02017cc <default_check+0x502>
ffffffffc0201338:	293a8a63          	beq	s5,s3,ffffffffc02015cc <default_check+0x302>
ffffffffc020133c:	28aa8863          	beq	s5,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201340:	28a98663          	beq	s3,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201344:	000aa783          	lw	a5,0(s5)
ffffffffc0201348:	2a079263          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020134c:	0009a783          	lw	a5,0(s3)
ffffffffc0201350:	28079e63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc0201354:	411c                	lw	a5,0(a0)
ffffffffc0201356:	28079b63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020135a:	00095797          	auipc	a5,0x95
ffffffffc020135e:	54e7b783          	ld	a5,1358(a5) # ffffffffc02968a8 <pages>
ffffffffc0201362:	40fa8733          	sub	a4,s5,a5
ffffffffc0201366:	0000e617          	auipc	a2,0xe
ffffffffc020136a:	0aa63603          	ld	a2,170(a2) # ffffffffc020f410 <nbase>
ffffffffc020136e:	8719                	srai	a4,a4,0x6
ffffffffc0201370:	9732                	add	a4,a4,a2
ffffffffc0201372:	00095697          	auipc	a3,0x95
ffffffffc0201376:	52e6b683          	ld	a3,1326(a3) # ffffffffc02968a0 <npage>
ffffffffc020137a:	06b2                	slli	a3,a3,0xc
ffffffffc020137c:	0732                	slli	a4,a4,0xc
ffffffffc020137e:	28d77763          	bgeu	a4,a3,ffffffffc020160c <default_check+0x342>
ffffffffc0201382:	40f98733          	sub	a4,s3,a5
ffffffffc0201386:	8719                	srai	a4,a4,0x6
ffffffffc0201388:	9732                	add	a4,a4,a2
ffffffffc020138a:	0732                	slli	a4,a4,0xc
ffffffffc020138c:	4cd77063          	bgeu	a4,a3,ffffffffc020184c <default_check+0x582>
ffffffffc0201390:	40f507b3          	sub	a5,a0,a5
ffffffffc0201394:	8799                	srai	a5,a5,0x6
ffffffffc0201396:	97b2                	add	a5,a5,a2
ffffffffc0201398:	07b2                	slli	a5,a5,0xc
ffffffffc020139a:	30d7f963          	bgeu	a5,a3,ffffffffc02016ac <default_check+0x3e2>
ffffffffc020139e:	4505                	li	a0,1
ffffffffc02013a0:	00043c03          	ld	s8,0(s0)
ffffffffc02013a4:	00843b83          	ld	s7,8(s0)
ffffffffc02013a8:	01042b03          	lw	s6,16(s0)
ffffffffc02013ac:	e400                	sd	s0,8(s0)
ffffffffc02013ae:	e000                	sd	s0,0(s0)
ffffffffc02013b0:	00090797          	auipc	a5,0x90
ffffffffc02013b4:	4007a423          	sw	zero,1032(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02013b8:	5b5000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013bc:	2c051863          	bnez	a0,ffffffffc020168c <default_check+0x3c2>
ffffffffc02013c0:	4585                	li	a1,1
ffffffffc02013c2:	8556                	mv	a0,s5
ffffffffc02013c4:	5e7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013c8:	4585                	li	a1,1
ffffffffc02013ca:	854e                	mv	a0,s3
ffffffffc02013cc:	5df000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d0:	4585                	li	a1,1
ffffffffc02013d2:	8552                	mv	a0,s4
ffffffffc02013d4:	5d7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d8:	4818                	lw	a4,16(s0)
ffffffffc02013da:	478d                	li	a5,3
ffffffffc02013dc:	28f71863          	bne	a4,a5,ffffffffc020166c <default_check+0x3a2>
ffffffffc02013e0:	4505                	li	a0,1
ffffffffc02013e2:	58b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013e6:	89aa                	mv	s3,a0
ffffffffc02013e8:	26050263          	beqz	a0,ffffffffc020164c <default_check+0x382>
ffffffffc02013ec:	4505                	li	a0,1
ffffffffc02013ee:	57f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013f2:	8aaa                	mv	s5,a0
ffffffffc02013f4:	3a050c63          	beqz	a0,ffffffffc02017ac <default_check+0x4e2>
ffffffffc02013f8:	4505                	li	a0,1
ffffffffc02013fa:	573000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013fe:	8a2a                	mv	s4,a0
ffffffffc0201400:	38050663          	beqz	a0,ffffffffc020178c <default_check+0x4c2>
ffffffffc0201404:	4505                	li	a0,1
ffffffffc0201406:	567000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020140a:	36051163          	bnez	a0,ffffffffc020176c <default_check+0x4a2>
ffffffffc020140e:	4585                	li	a1,1
ffffffffc0201410:	854e                	mv	a0,s3
ffffffffc0201412:	599000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201416:	641c                	ld	a5,8(s0)
ffffffffc0201418:	20878a63          	beq	a5,s0,ffffffffc020162c <default_check+0x362>
ffffffffc020141c:	4505                	li	a0,1
ffffffffc020141e:	54f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201422:	30a99563          	bne	s3,a0,ffffffffc020172c <default_check+0x462>
ffffffffc0201426:	4505                	li	a0,1
ffffffffc0201428:	545000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020142c:	2e051063          	bnez	a0,ffffffffc020170c <default_check+0x442>
ffffffffc0201430:	481c                	lw	a5,16(s0)
ffffffffc0201432:	2a079d63          	bnez	a5,ffffffffc02016ec <default_check+0x422>
ffffffffc0201436:	854e                	mv	a0,s3
ffffffffc0201438:	4585                	li	a1,1
ffffffffc020143a:	01843023          	sd	s8,0(s0)
ffffffffc020143e:	01743423          	sd	s7,8(s0)
ffffffffc0201442:	01642823          	sw	s6,16(s0)
ffffffffc0201446:	565000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020144a:	4585                	li	a1,1
ffffffffc020144c:	8556                	mv	a0,s5
ffffffffc020144e:	55d000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201452:	4585                	li	a1,1
ffffffffc0201454:	8552                	mv	a0,s4
ffffffffc0201456:	555000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020145a:	4515                	li	a0,5
ffffffffc020145c:	511000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201460:	89aa                	mv	s3,a0
ffffffffc0201462:	26050563          	beqz	a0,ffffffffc02016cc <default_check+0x402>
ffffffffc0201466:	651c                	ld	a5,8(a0)
ffffffffc0201468:	8385                	srli	a5,a5,0x1
ffffffffc020146a:	8b85                	andi	a5,a5,1
ffffffffc020146c:	54079063          	bnez	a5,ffffffffc02019ac <default_check+0x6e2>
ffffffffc0201470:	4505                	li	a0,1
ffffffffc0201472:	00043b03          	ld	s6,0(s0)
ffffffffc0201476:	00843a83          	ld	s5,8(s0)
ffffffffc020147a:	e000                	sd	s0,0(s0)
ffffffffc020147c:	e400                	sd	s0,8(s0)
ffffffffc020147e:	4ef000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201482:	50051563          	bnez	a0,ffffffffc020198c <default_check+0x6c2>
ffffffffc0201486:	08098a13          	addi	s4,s3,128
ffffffffc020148a:	8552                	mv	a0,s4
ffffffffc020148c:	458d                	li	a1,3
ffffffffc020148e:	01042b83          	lw	s7,16(s0)
ffffffffc0201492:	00090797          	auipc	a5,0x90
ffffffffc0201496:	3207a323          	sw	zero,806(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020149a:	511000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020149e:	4511                	li	a0,4
ffffffffc02014a0:	4cd000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014a4:	4c051463          	bnez	a0,ffffffffc020196c <default_check+0x6a2>
ffffffffc02014a8:	0889b783          	ld	a5,136(s3)
ffffffffc02014ac:	8385                	srli	a5,a5,0x1
ffffffffc02014ae:	8b85                	andi	a5,a5,1
ffffffffc02014b0:	48078e63          	beqz	a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014b4:	0909a703          	lw	a4,144(s3)
ffffffffc02014b8:	478d                	li	a5,3
ffffffffc02014ba:	48f71963          	bne	a4,a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014be:	450d                	li	a0,3
ffffffffc02014c0:	4ad000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014c4:	8c2a                	mv	s8,a0
ffffffffc02014c6:	46050363          	beqz	a0,ffffffffc020192c <default_check+0x662>
ffffffffc02014ca:	4505                	li	a0,1
ffffffffc02014cc:	4a1000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014d0:	42051e63          	bnez	a0,ffffffffc020190c <default_check+0x642>
ffffffffc02014d4:	418a1c63          	bne	s4,s8,ffffffffc02018ec <default_check+0x622>
ffffffffc02014d8:	4585                	li	a1,1
ffffffffc02014da:	854e                	mv	a0,s3
ffffffffc02014dc:	4cf000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e0:	458d                	li	a1,3
ffffffffc02014e2:	8552                	mv	a0,s4
ffffffffc02014e4:	4c7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e8:	0089b783          	ld	a5,8(s3)
ffffffffc02014ec:	04098c13          	addi	s8,s3,64
ffffffffc02014f0:	8385                	srli	a5,a5,0x1
ffffffffc02014f2:	8b85                	andi	a5,a5,1
ffffffffc02014f4:	3c078c63          	beqz	a5,ffffffffc02018cc <default_check+0x602>
ffffffffc02014f8:	0109a703          	lw	a4,16(s3)
ffffffffc02014fc:	4785                	li	a5,1
ffffffffc02014fe:	3cf71763          	bne	a4,a5,ffffffffc02018cc <default_check+0x602>
ffffffffc0201502:	008a3783          	ld	a5,8(s4)
ffffffffc0201506:	8385                	srli	a5,a5,0x1
ffffffffc0201508:	8b85                	andi	a5,a5,1
ffffffffc020150a:	3a078163          	beqz	a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc020150e:	010a2703          	lw	a4,16(s4)
ffffffffc0201512:	478d                	li	a5,3
ffffffffc0201514:	38f71c63          	bne	a4,a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc0201518:	4505                	li	a0,1
ffffffffc020151a:	453000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020151e:	36a99763          	bne	s3,a0,ffffffffc020188c <default_check+0x5c2>
ffffffffc0201522:	4585                	li	a1,1
ffffffffc0201524:	487000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201528:	4509                	li	a0,2
ffffffffc020152a:	443000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020152e:	32aa1f63          	bne	s4,a0,ffffffffc020186c <default_check+0x5a2>
ffffffffc0201532:	4589                	li	a1,2
ffffffffc0201534:	477000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201538:	4585                	li	a1,1
ffffffffc020153a:	8562                	mv	a0,s8
ffffffffc020153c:	46f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201540:	4515                	li	a0,5
ffffffffc0201542:	42b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201546:	89aa                	mv	s3,a0
ffffffffc0201548:	48050263          	beqz	a0,ffffffffc02019cc <default_check+0x702>
ffffffffc020154c:	4505                	li	a0,1
ffffffffc020154e:	41f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201552:	2c051d63          	bnez	a0,ffffffffc020182c <default_check+0x562>
ffffffffc0201556:	481c                	lw	a5,16(s0)
ffffffffc0201558:	2a079a63          	bnez	a5,ffffffffc020180c <default_check+0x542>
ffffffffc020155c:	4595                	li	a1,5
ffffffffc020155e:	854e                	mv	a0,s3
ffffffffc0201560:	01742823          	sw	s7,16(s0)
ffffffffc0201564:	01643023          	sd	s6,0(s0)
ffffffffc0201568:	01543423          	sd	s5,8(s0)
ffffffffc020156c:	43f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201570:	641c                	ld	a5,8(s0)
ffffffffc0201572:	00878963          	beq	a5,s0,ffffffffc0201584 <default_check+0x2ba>
ffffffffc0201576:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157a:	679c                	ld	a5,8(a5)
ffffffffc020157c:	397d                	addiw	s2,s2,-1
ffffffffc020157e:	9c99                	subw	s1,s1,a4
ffffffffc0201580:	fe879be3          	bne	a5,s0,ffffffffc0201576 <default_check+0x2ac>
ffffffffc0201584:	26091463          	bnez	s2,ffffffffc02017ec <default_check+0x522>
ffffffffc0201588:	46049263          	bnez	s1,ffffffffc02019ec <default_check+0x722>
ffffffffc020158c:	60a6                	ld	ra,72(sp)
ffffffffc020158e:	6406                	ld	s0,64(sp)
ffffffffc0201590:	74e2                	ld	s1,56(sp)
ffffffffc0201592:	7942                	ld	s2,48(sp)
ffffffffc0201594:	79a2                	ld	s3,40(sp)
ffffffffc0201596:	7a02                	ld	s4,32(sp)
ffffffffc0201598:	6ae2                	ld	s5,24(sp)
ffffffffc020159a:	6b42                	ld	s6,16(sp)
ffffffffc020159c:	6ba2                	ld	s7,8(sp)
ffffffffc020159e:	6c02                	ld	s8,0(sp)
ffffffffc02015a0:	6161                	addi	sp,sp,80
ffffffffc02015a2:	8082                	ret
ffffffffc02015a4:	4981                	li	s3,0
ffffffffc02015a6:	4481                	li	s1,0
ffffffffc02015a8:	4901                	li	s2,0
ffffffffc02015aa:	b38d                	j	ffffffffc020130c <default_check+0x42>
ffffffffc02015ac:	0000b697          	auipc	a3,0xb
ffffffffc02015b0:	8cc68693          	addi	a3,a3,-1844 # ffffffffc020be78 <commands+0x950>
ffffffffc02015b4:	0000a617          	auipc	a2,0xa
ffffffffc02015b8:	18460613          	addi	a2,a2,388 # ffffffffc020b738 <commands+0x210>
ffffffffc02015bc:	0ef00593          	li	a1,239
ffffffffc02015c0:	0000b517          	auipc	a0,0xb
ffffffffc02015c4:	8c850513          	addi	a0,a0,-1848 # ffffffffc020be88 <commands+0x960>
ffffffffc02015c8:	ed7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015cc:	0000b697          	auipc	a3,0xb
ffffffffc02015d0:	95468693          	addi	a3,a3,-1708 # ffffffffc020bf20 <commands+0x9f8>
ffffffffc02015d4:	0000a617          	auipc	a2,0xa
ffffffffc02015d8:	16460613          	addi	a2,a2,356 # ffffffffc020b738 <commands+0x210>
ffffffffc02015dc:	0bc00593          	li	a1,188
ffffffffc02015e0:	0000b517          	auipc	a0,0xb
ffffffffc02015e4:	8a850513          	addi	a0,a0,-1880 # ffffffffc020be88 <commands+0x960>
ffffffffc02015e8:	eb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015ec:	0000b697          	auipc	a3,0xb
ffffffffc02015f0:	95c68693          	addi	a3,a3,-1700 # ffffffffc020bf48 <commands+0xa20>
ffffffffc02015f4:	0000a617          	auipc	a2,0xa
ffffffffc02015f8:	14460613          	addi	a2,a2,324 # ffffffffc020b738 <commands+0x210>
ffffffffc02015fc:	0bd00593          	li	a1,189
ffffffffc0201600:	0000b517          	auipc	a0,0xb
ffffffffc0201604:	88850513          	addi	a0,a0,-1912 # ffffffffc020be88 <commands+0x960>
ffffffffc0201608:	e97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020160c:	0000b697          	auipc	a3,0xb
ffffffffc0201610:	97c68693          	addi	a3,a3,-1668 # ffffffffc020bf88 <commands+0xa60>
ffffffffc0201614:	0000a617          	auipc	a2,0xa
ffffffffc0201618:	12460613          	addi	a2,a2,292 # ffffffffc020b738 <commands+0x210>
ffffffffc020161c:	0bf00593          	li	a1,191
ffffffffc0201620:	0000b517          	auipc	a0,0xb
ffffffffc0201624:	86850513          	addi	a0,a0,-1944 # ffffffffc020be88 <commands+0x960>
ffffffffc0201628:	e77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020162c:	0000b697          	auipc	a3,0xb
ffffffffc0201630:	9e468693          	addi	a3,a3,-1564 # ffffffffc020c010 <commands+0xae8>
ffffffffc0201634:	0000a617          	auipc	a2,0xa
ffffffffc0201638:	10460613          	addi	a2,a2,260 # ffffffffc020b738 <commands+0x210>
ffffffffc020163c:	0d800593          	li	a1,216
ffffffffc0201640:	0000b517          	auipc	a0,0xb
ffffffffc0201644:	84850513          	addi	a0,a0,-1976 # ffffffffc020be88 <commands+0x960>
ffffffffc0201648:	e57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020164c:	0000b697          	auipc	a3,0xb
ffffffffc0201650:	87468693          	addi	a3,a3,-1932 # ffffffffc020bec0 <commands+0x998>
ffffffffc0201654:	0000a617          	auipc	a2,0xa
ffffffffc0201658:	0e460613          	addi	a2,a2,228 # ffffffffc020b738 <commands+0x210>
ffffffffc020165c:	0d100593          	li	a1,209
ffffffffc0201660:	0000b517          	auipc	a0,0xb
ffffffffc0201664:	82850513          	addi	a0,a0,-2008 # ffffffffc020be88 <commands+0x960>
ffffffffc0201668:	e37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020166c:	0000b697          	auipc	a3,0xb
ffffffffc0201670:	99468693          	addi	a3,a3,-1644 # ffffffffc020c000 <commands+0xad8>
ffffffffc0201674:	0000a617          	auipc	a2,0xa
ffffffffc0201678:	0c460613          	addi	a2,a2,196 # ffffffffc020b738 <commands+0x210>
ffffffffc020167c:	0cf00593          	li	a1,207
ffffffffc0201680:	0000b517          	auipc	a0,0xb
ffffffffc0201684:	80850513          	addi	a0,a0,-2040 # ffffffffc020be88 <commands+0x960>
ffffffffc0201688:	e17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020168c:	0000b697          	auipc	a3,0xb
ffffffffc0201690:	95c68693          	addi	a3,a3,-1700 # ffffffffc020bfe8 <commands+0xac0>
ffffffffc0201694:	0000a617          	auipc	a2,0xa
ffffffffc0201698:	0a460613          	addi	a2,a2,164 # ffffffffc020b738 <commands+0x210>
ffffffffc020169c:	0ca00593          	li	a1,202
ffffffffc02016a0:	0000a517          	auipc	a0,0xa
ffffffffc02016a4:	7e850513          	addi	a0,a0,2024 # ffffffffc020be88 <commands+0x960>
ffffffffc02016a8:	df7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ac:	0000b697          	auipc	a3,0xb
ffffffffc02016b0:	91c68693          	addi	a3,a3,-1764 # ffffffffc020bfc8 <commands+0xaa0>
ffffffffc02016b4:	0000a617          	auipc	a2,0xa
ffffffffc02016b8:	08460613          	addi	a2,a2,132 # ffffffffc020b738 <commands+0x210>
ffffffffc02016bc:	0c100593          	li	a1,193
ffffffffc02016c0:	0000a517          	auipc	a0,0xa
ffffffffc02016c4:	7c850513          	addi	a0,a0,1992 # ffffffffc020be88 <commands+0x960>
ffffffffc02016c8:	dd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016cc:	0000b697          	auipc	a3,0xb
ffffffffc02016d0:	98c68693          	addi	a3,a3,-1652 # ffffffffc020c058 <commands+0xb30>
ffffffffc02016d4:	0000a617          	auipc	a2,0xa
ffffffffc02016d8:	06460613          	addi	a2,a2,100 # ffffffffc020b738 <commands+0x210>
ffffffffc02016dc:	0f700593          	li	a1,247
ffffffffc02016e0:	0000a517          	auipc	a0,0xa
ffffffffc02016e4:	7a850513          	addi	a0,a0,1960 # ffffffffc020be88 <commands+0x960>
ffffffffc02016e8:	db7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ec:	0000b697          	auipc	a3,0xb
ffffffffc02016f0:	95c68693          	addi	a3,a3,-1700 # ffffffffc020c048 <commands+0xb20>
ffffffffc02016f4:	0000a617          	auipc	a2,0xa
ffffffffc02016f8:	04460613          	addi	a2,a2,68 # ffffffffc020b738 <commands+0x210>
ffffffffc02016fc:	0de00593          	li	a1,222
ffffffffc0201700:	0000a517          	auipc	a0,0xa
ffffffffc0201704:	78850513          	addi	a0,a0,1928 # ffffffffc020be88 <commands+0x960>
ffffffffc0201708:	d97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020170c:	0000b697          	auipc	a3,0xb
ffffffffc0201710:	8dc68693          	addi	a3,a3,-1828 # ffffffffc020bfe8 <commands+0xac0>
ffffffffc0201714:	0000a617          	auipc	a2,0xa
ffffffffc0201718:	02460613          	addi	a2,a2,36 # ffffffffc020b738 <commands+0x210>
ffffffffc020171c:	0dc00593          	li	a1,220
ffffffffc0201720:	0000a517          	auipc	a0,0xa
ffffffffc0201724:	76850513          	addi	a0,a0,1896 # ffffffffc020be88 <commands+0x960>
ffffffffc0201728:	d77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020172c:	0000b697          	auipc	a3,0xb
ffffffffc0201730:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020c028 <commands+0xb00>
ffffffffc0201734:	0000a617          	auipc	a2,0xa
ffffffffc0201738:	00460613          	addi	a2,a2,4 # ffffffffc020b738 <commands+0x210>
ffffffffc020173c:	0db00593          	li	a1,219
ffffffffc0201740:	0000a517          	auipc	a0,0xa
ffffffffc0201744:	74850513          	addi	a0,a0,1864 # ffffffffc020be88 <commands+0x960>
ffffffffc0201748:	d57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020174c:	0000a697          	auipc	a3,0xa
ffffffffc0201750:	77468693          	addi	a3,a3,1908 # ffffffffc020bec0 <commands+0x998>
ffffffffc0201754:	0000a617          	auipc	a2,0xa
ffffffffc0201758:	fe460613          	addi	a2,a2,-28 # ffffffffc020b738 <commands+0x210>
ffffffffc020175c:	0b800593          	li	a1,184
ffffffffc0201760:	0000a517          	auipc	a0,0xa
ffffffffc0201764:	72850513          	addi	a0,a0,1832 # ffffffffc020be88 <commands+0x960>
ffffffffc0201768:	d37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020176c:	0000b697          	auipc	a3,0xb
ffffffffc0201770:	87c68693          	addi	a3,a3,-1924 # ffffffffc020bfe8 <commands+0xac0>
ffffffffc0201774:	0000a617          	auipc	a2,0xa
ffffffffc0201778:	fc460613          	addi	a2,a2,-60 # ffffffffc020b738 <commands+0x210>
ffffffffc020177c:	0d500593          	li	a1,213
ffffffffc0201780:	0000a517          	auipc	a0,0xa
ffffffffc0201784:	70850513          	addi	a0,a0,1800 # ffffffffc020be88 <commands+0x960>
ffffffffc0201788:	d17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020178c:	0000a697          	auipc	a3,0xa
ffffffffc0201790:	77468693          	addi	a3,a3,1908 # ffffffffc020bf00 <commands+0x9d8>
ffffffffc0201794:	0000a617          	auipc	a2,0xa
ffffffffc0201798:	fa460613          	addi	a2,a2,-92 # ffffffffc020b738 <commands+0x210>
ffffffffc020179c:	0d300593          	li	a1,211
ffffffffc02017a0:	0000a517          	auipc	a0,0xa
ffffffffc02017a4:	6e850513          	addi	a0,a0,1768 # ffffffffc020be88 <commands+0x960>
ffffffffc02017a8:	cf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ac:	0000a697          	auipc	a3,0xa
ffffffffc02017b0:	73468693          	addi	a3,a3,1844 # ffffffffc020bee0 <commands+0x9b8>
ffffffffc02017b4:	0000a617          	auipc	a2,0xa
ffffffffc02017b8:	f8460613          	addi	a2,a2,-124 # ffffffffc020b738 <commands+0x210>
ffffffffc02017bc:	0d200593          	li	a1,210
ffffffffc02017c0:	0000a517          	auipc	a0,0xa
ffffffffc02017c4:	6c850513          	addi	a0,a0,1736 # ffffffffc020be88 <commands+0x960>
ffffffffc02017c8:	cd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017cc:	0000a697          	auipc	a3,0xa
ffffffffc02017d0:	73468693          	addi	a3,a3,1844 # ffffffffc020bf00 <commands+0x9d8>
ffffffffc02017d4:	0000a617          	auipc	a2,0xa
ffffffffc02017d8:	f6460613          	addi	a2,a2,-156 # ffffffffc020b738 <commands+0x210>
ffffffffc02017dc:	0ba00593          	li	a1,186
ffffffffc02017e0:	0000a517          	auipc	a0,0xa
ffffffffc02017e4:	6a850513          	addi	a0,a0,1704 # ffffffffc020be88 <commands+0x960>
ffffffffc02017e8:	cb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ec:	0000b697          	auipc	a3,0xb
ffffffffc02017f0:	9bc68693          	addi	a3,a3,-1604 # ffffffffc020c1a8 <commands+0xc80>
ffffffffc02017f4:	0000a617          	auipc	a2,0xa
ffffffffc02017f8:	f4460613          	addi	a2,a2,-188 # ffffffffc020b738 <commands+0x210>
ffffffffc02017fc:	12400593          	li	a1,292
ffffffffc0201800:	0000a517          	auipc	a0,0xa
ffffffffc0201804:	68850513          	addi	a0,a0,1672 # ffffffffc020be88 <commands+0x960>
ffffffffc0201808:	c97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020180c:	0000b697          	auipc	a3,0xb
ffffffffc0201810:	83c68693          	addi	a3,a3,-1988 # ffffffffc020c048 <commands+0xb20>
ffffffffc0201814:	0000a617          	auipc	a2,0xa
ffffffffc0201818:	f2460613          	addi	a2,a2,-220 # ffffffffc020b738 <commands+0x210>
ffffffffc020181c:	11900593          	li	a1,281
ffffffffc0201820:	0000a517          	auipc	a0,0xa
ffffffffc0201824:	66850513          	addi	a0,a0,1640 # ffffffffc020be88 <commands+0x960>
ffffffffc0201828:	c77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020182c:	0000a697          	auipc	a3,0xa
ffffffffc0201830:	7bc68693          	addi	a3,a3,1980 # ffffffffc020bfe8 <commands+0xac0>
ffffffffc0201834:	0000a617          	auipc	a2,0xa
ffffffffc0201838:	f0460613          	addi	a2,a2,-252 # ffffffffc020b738 <commands+0x210>
ffffffffc020183c:	11700593          	li	a1,279
ffffffffc0201840:	0000a517          	auipc	a0,0xa
ffffffffc0201844:	64850513          	addi	a0,a0,1608 # ffffffffc020be88 <commands+0x960>
ffffffffc0201848:	c57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020184c:	0000a697          	auipc	a3,0xa
ffffffffc0201850:	75c68693          	addi	a3,a3,1884 # ffffffffc020bfa8 <commands+0xa80>
ffffffffc0201854:	0000a617          	auipc	a2,0xa
ffffffffc0201858:	ee460613          	addi	a2,a2,-284 # ffffffffc020b738 <commands+0x210>
ffffffffc020185c:	0c000593          	li	a1,192
ffffffffc0201860:	0000a517          	auipc	a0,0xa
ffffffffc0201864:	62850513          	addi	a0,a0,1576 # ffffffffc020be88 <commands+0x960>
ffffffffc0201868:	c37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020186c:	0000b697          	auipc	a3,0xb
ffffffffc0201870:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020c168 <commands+0xc40>
ffffffffc0201874:	0000a617          	auipc	a2,0xa
ffffffffc0201878:	ec460613          	addi	a2,a2,-316 # ffffffffc020b738 <commands+0x210>
ffffffffc020187c:	11100593          	li	a1,273
ffffffffc0201880:	0000a517          	auipc	a0,0xa
ffffffffc0201884:	60850513          	addi	a0,a0,1544 # ffffffffc020be88 <commands+0x960>
ffffffffc0201888:	c17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020188c:	0000b697          	auipc	a3,0xb
ffffffffc0201890:	8bc68693          	addi	a3,a3,-1860 # ffffffffc020c148 <commands+0xc20>
ffffffffc0201894:	0000a617          	auipc	a2,0xa
ffffffffc0201898:	ea460613          	addi	a2,a2,-348 # ffffffffc020b738 <commands+0x210>
ffffffffc020189c:	10f00593          	li	a1,271
ffffffffc02018a0:	0000a517          	auipc	a0,0xa
ffffffffc02018a4:	5e850513          	addi	a0,a0,1512 # ffffffffc020be88 <commands+0x960>
ffffffffc02018a8:	bf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ac:	0000b697          	auipc	a3,0xb
ffffffffc02018b0:	87468693          	addi	a3,a3,-1932 # ffffffffc020c120 <commands+0xbf8>
ffffffffc02018b4:	0000a617          	auipc	a2,0xa
ffffffffc02018b8:	e8460613          	addi	a2,a2,-380 # ffffffffc020b738 <commands+0x210>
ffffffffc02018bc:	10d00593          	li	a1,269
ffffffffc02018c0:	0000a517          	auipc	a0,0xa
ffffffffc02018c4:	5c850513          	addi	a0,a0,1480 # ffffffffc020be88 <commands+0x960>
ffffffffc02018c8:	bd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018cc:	0000b697          	auipc	a3,0xb
ffffffffc02018d0:	82c68693          	addi	a3,a3,-2004 # ffffffffc020c0f8 <commands+0xbd0>
ffffffffc02018d4:	0000a617          	auipc	a2,0xa
ffffffffc02018d8:	e6460613          	addi	a2,a2,-412 # ffffffffc020b738 <commands+0x210>
ffffffffc02018dc:	10c00593          	li	a1,268
ffffffffc02018e0:	0000a517          	auipc	a0,0xa
ffffffffc02018e4:	5a850513          	addi	a0,a0,1448 # ffffffffc020be88 <commands+0x960>
ffffffffc02018e8:	bb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ec:	0000a697          	auipc	a3,0xa
ffffffffc02018f0:	7fc68693          	addi	a3,a3,2044 # ffffffffc020c0e8 <commands+0xbc0>
ffffffffc02018f4:	0000a617          	auipc	a2,0xa
ffffffffc02018f8:	e4460613          	addi	a2,a2,-444 # ffffffffc020b738 <commands+0x210>
ffffffffc02018fc:	10700593          	li	a1,263
ffffffffc0201900:	0000a517          	auipc	a0,0xa
ffffffffc0201904:	58850513          	addi	a0,a0,1416 # ffffffffc020be88 <commands+0x960>
ffffffffc0201908:	b97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020190c:	0000a697          	auipc	a3,0xa
ffffffffc0201910:	6dc68693          	addi	a3,a3,1756 # ffffffffc020bfe8 <commands+0xac0>
ffffffffc0201914:	0000a617          	auipc	a2,0xa
ffffffffc0201918:	e2460613          	addi	a2,a2,-476 # ffffffffc020b738 <commands+0x210>
ffffffffc020191c:	10600593          	li	a1,262
ffffffffc0201920:	0000a517          	auipc	a0,0xa
ffffffffc0201924:	56850513          	addi	a0,a0,1384 # ffffffffc020be88 <commands+0x960>
ffffffffc0201928:	b77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020192c:	0000a697          	auipc	a3,0xa
ffffffffc0201930:	79c68693          	addi	a3,a3,1948 # ffffffffc020c0c8 <commands+0xba0>
ffffffffc0201934:	0000a617          	auipc	a2,0xa
ffffffffc0201938:	e0460613          	addi	a2,a2,-508 # ffffffffc020b738 <commands+0x210>
ffffffffc020193c:	10500593          	li	a1,261
ffffffffc0201940:	0000a517          	auipc	a0,0xa
ffffffffc0201944:	54850513          	addi	a0,a0,1352 # ffffffffc020be88 <commands+0x960>
ffffffffc0201948:	b57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020194c:	0000a697          	auipc	a3,0xa
ffffffffc0201950:	74c68693          	addi	a3,a3,1868 # ffffffffc020c098 <commands+0xb70>
ffffffffc0201954:	0000a617          	auipc	a2,0xa
ffffffffc0201958:	de460613          	addi	a2,a2,-540 # ffffffffc020b738 <commands+0x210>
ffffffffc020195c:	10400593          	li	a1,260
ffffffffc0201960:	0000a517          	auipc	a0,0xa
ffffffffc0201964:	52850513          	addi	a0,a0,1320 # ffffffffc020be88 <commands+0x960>
ffffffffc0201968:	b37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020196c:	0000a697          	auipc	a3,0xa
ffffffffc0201970:	71468693          	addi	a3,a3,1812 # ffffffffc020c080 <commands+0xb58>
ffffffffc0201974:	0000a617          	auipc	a2,0xa
ffffffffc0201978:	dc460613          	addi	a2,a2,-572 # ffffffffc020b738 <commands+0x210>
ffffffffc020197c:	10300593          	li	a1,259
ffffffffc0201980:	0000a517          	auipc	a0,0xa
ffffffffc0201984:	50850513          	addi	a0,a0,1288 # ffffffffc020be88 <commands+0x960>
ffffffffc0201988:	b17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020198c:	0000a697          	auipc	a3,0xa
ffffffffc0201990:	65c68693          	addi	a3,a3,1628 # ffffffffc020bfe8 <commands+0xac0>
ffffffffc0201994:	0000a617          	auipc	a2,0xa
ffffffffc0201998:	da460613          	addi	a2,a2,-604 # ffffffffc020b738 <commands+0x210>
ffffffffc020199c:	0fd00593          	li	a1,253
ffffffffc02019a0:	0000a517          	auipc	a0,0xa
ffffffffc02019a4:	4e850513          	addi	a0,a0,1256 # ffffffffc020be88 <commands+0x960>
ffffffffc02019a8:	af7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ac:	0000a697          	auipc	a3,0xa
ffffffffc02019b0:	6bc68693          	addi	a3,a3,1724 # ffffffffc020c068 <commands+0xb40>
ffffffffc02019b4:	0000a617          	auipc	a2,0xa
ffffffffc02019b8:	d8460613          	addi	a2,a2,-636 # ffffffffc020b738 <commands+0x210>
ffffffffc02019bc:	0f800593          	li	a1,248
ffffffffc02019c0:	0000a517          	auipc	a0,0xa
ffffffffc02019c4:	4c850513          	addi	a0,a0,1224 # ffffffffc020be88 <commands+0x960>
ffffffffc02019c8:	ad7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019cc:	0000a697          	auipc	a3,0xa
ffffffffc02019d0:	7bc68693          	addi	a3,a3,1980 # ffffffffc020c188 <commands+0xc60>
ffffffffc02019d4:	0000a617          	auipc	a2,0xa
ffffffffc02019d8:	d6460613          	addi	a2,a2,-668 # ffffffffc020b738 <commands+0x210>
ffffffffc02019dc:	11600593          	li	a1,278
ffffffffc02019e0:	0000a517          	auipc	a0,0xa
ffffffffc02019e4:	4a850513          	addi	a0,a0,1192 # ffffffffc020be88 <commands+0x960>
ffffffffc02019e8:	ab7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ec:	0000a697          	auipc	a3,0xa
ffffffffc02019f0:	7cc68693          	addi	a3,a3,1996 # ffffffffc020c1b8 <commands+0xc90>
ffffffffc02019f4:	0000a617          	auipc	a2,0xa
ffffffffc02019f8:	d4460613          	addi	a2,a2,-700 # ffffffffc020b738 <commands+0x210>
ffffffffc02019fc:	12500593          	li	a1,293
ffffffffc0201a00:	0000a517          	auipc	a0,0xa
ffffffffc0201a04:	48850513          	addi	a0,a0,1160 # ffffffffc020be88 <commands+0x960>
ffffffffc0201a08:	a97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a0c:	0000a697          	auipc	a3,0xa
ffffffffc0201a10:	49468693          	addi	a3,a3,1172 # ffffffffc020bea0 <commands+0x978>
ffffffffc0201a14:	0000a617          	auipc	a2,0xa
ffffffffc0201a18:	d2460613          	addi	a2,a2,-732 # ffffffffc020b738 <commands+0x210>
ffffffffc0201a1c:	0f200593          	li	a1,242
ffffffffc0201a20:	0000a517          	auipc	a0,0xa
ffffffffc0201a24:	46850513          	addi	a0,a0,1128 # ffffffffc020be88 <commands+0x960>
ffffffffc0201a28:	a77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a2c:	0000a697          	auipc	a3,0xa
ffffffffc0201a30:	4b468693          	addi	a3,a3,1204 # ffffffffc020bee0 <commands+0x9b8>
ffffffffc0201a34:	0000a617          	auipc	a2,0xa
ffffffffc0201a38:	d0460613          	addi	a2,a2,-764 # ffffffffc020b738 <commands+0x210>
ffffffffc0201a3c:	0b900593          	li	a1,185
ffffffffc0201a40:	0000a517          	auipc	a0,0xa
ffffffffc0201a44:	44850513          	addi	a0,a0,1096 # ffffffffc020be88 <commands+0x960>
ffffffffc0201a48:	a57fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a4c <default_free_pages>:
ffffffffc0201a4c:	1141                	addi	sp,sp,-16
ffffffffc0201a4e:	e406                	sd	ra,8(sp)
ffffffffc0201a50:	14058463          	beqz	a1,ffffffffc0201b98 <default_free_pages+0x14c>
ffffffffc0201a54:	00659693          	slli	a3,a1,0x6
ffffffffc0201a58:	96aa                	add	a3,a3,a0
ffffffffc0201a5a:	87aa                	mv	a5,a0
ffffffffc0201a5c:	02d50263          	beq	a0,a3,ffffffffc0201a80 <default_free_pages+0x34>
ffffffffc0201a60:	6798                	ld	a4,8(a5)
ffffffffc0201a62:	8b05                	andi	a4,a4,1
ffffffffc0201a64:	10071a63          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a68:	6798                	ld	a4,8(a5)
ffffffffc0201a6a:	8b09                	andi	a4,a4,2
ffffffffc0201a6c:	10071663          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a70:	0007b423          	sd	zero,8(a5)
ffffffffc0201a74:	0007a023          	sw	zero,0(a5)
ffffffffc0201a78:	04078793          	addi	a5,a5,64
ffffffffc0201a7c:	fed792e3          	bne	a5,a3,ffffffffc0201a60 <default_free_pages+0x14>
ffffffffc0201a80:	2581                	sext.w	a1,a1
ffffffffc0201a82:	c90c                	sw	a1,16(a0)
ffffffffc0201a84:	00850893          	addi	a7,a0,8
ffffffffc0201a88:	4789                	li	a5,2
ffffffffc0201a8a:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a8e:	00090697          	auipc	a3,0x90
ffffffffc0201a92:	d1a68693          	addi	a3,a3,-742 # ffffffffc02917a8 <free_area>
ffffffffc0201a96:	4a98                	lw	a4,16(a3)
ffffffffc0201a98:	669c                	ld	a5,8(a3)
ffffffffc0201a9a:	01850613          	addi	a2,a0,24
ffffffffc0201a9e:	9db9                	addw	a1,a1,a4
ffffffffc0201aa0:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa2:	0ad78463          	beq	a5,a3,ffffffffc0201b4a <default_free_pages+0xfe>
ffffffffc0201aa6:	fe878713          	addi	a4,a5,-24
ffffffffc0201aaa:	0006b803          	ld	a6,0(a3)
ffffffffc0201aae:	4581                	li	a1,0
ffffffffc0201ab0:	00e56a63          	bltu	a0,a4,ffffffffc0201ac4 <default_free_pages+0x78>
ffffffffc0201ab4:	6798                	ld	a4,8(a5)
ffffffffc0201ab6:	04d70c63          	beq	a4,a3,ffffffffc0201b0e <default_free_pages+0xc2>
ffffffffc0201aba:	87ba                	mv	a5,a4
ffffffffc0201abc:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac0:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab4 <default_free_pages+0x68>
ffffffffc0201ac4:	c199                	beqz	a1,ffffffffc0201aca <default_free_pages+0x7e>
ffffffffc0201ac6:	0106b023          	sd	a6,0(a3)
ffffffffc0201aca:	6398                	ld	a4,0(a5)
ffffffffc0201acc:	e390                	sd	a2,0(a5)
ffffffffc0201ace:	e710                	sd	a2,8(a4)
ffffffffc0201ad0:	f11c                	sd	a5,32(a0)
ffffffffc0201ad2:	ed18                	sd	a4,24(a0)
ffffffffc0201ad4:	00d70d63          	beq	a4,a3,ffffffffc0201aee <default_free_pages+0xa2>
ffffffffc0201ad8:	ff872583          	lw	a1,-8(a4)
ffffffffc0201adc:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae0:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae4:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201ae8:	97b2                	add	a5,a5,a2
ffffffffc0201aea:	02f50c63          	beq	a0,a5,ffffffffc0201b22 <default_free_pages+0xd6>
ffffffffc0201aee:	711c                	ld	a5,32(a0)
ffffffffc0201af0:	00d78c63          	beq	a5,a3,ffffffffc0201b08 <default_free_pages+0xbc>
ffffffffc0201af4:	4910                	lw	a2,16(a0)
ffffffffc0201af6:	fe878693          	addi	a3,a5,-24
ffffffffc0201afa:	02061593          	slli	a1,a2,0x20
ffffffffc0201afe:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b02:	972a                	add	a4,a4,a0
ffffffffc0201b04:	04e68a63          	beq	a3,a4,ffffffffc0201b58 <default_free_pages+0x10c>
ffffffffc0201b08:	60a2                	ld	ra,8(sp)
ffffffffc0201b0a:	0141                	addi	sp,sp,16
ffffffffc0201b0c:	8082                	ret
ffffffffc0201b0e:	e790                	sd	a2,8(a5)
ffffffffc0201b10:	f114                	sd	a3,32(a0)
ffffffffc0201b12:	6798                	ld	a4,8(a5)
ffffffffc0201b14:	ed1c                	sd	a5,24(a0)
ffffffffc0201b16:	02d70763          	beq	a4,a3,ffffffffc0201b44 <default_free_pages+0xf8>
ffffffffc0201b1a:	8832                	mv	a6,a2
ffffffffc0201b1c:	4585                	li	a1,1
ffffffffc0201b1e:	87ba                	mv	a5,a4
ffffffffc0201b20:	bf71                	j	ffffffffc0201abc <default_free_pages+0x70>
ffffffffc0201b22:	491c                	lw	a5,16(a0)
ffffffffc0201b24:	9dbd                	addw	a1,a1,a5
ffffffffc0201b26:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2a:	57f5                	li	a5,-3
ffffffffc0201b2c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b30:	01853803          	ld	a6,24(a0)
ffffffffc0201b34:	710c                	ld	a1,32(a0)
ffffffffc0201b36:	8532                	mv	a0,a2
ffffffffc0201b38:	00b83423          	sd	a1,8(a6)
ffffffffc0201b3c:	671c                	ld	a5,8(a4)
ffffffffc0201b3e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b42:	b77d                	j	ffffffffc0201af0 <default_free_pages+0xa4>
ffffffffc0201b44:	e290                	sd	a2,0(a3)
ffffffffc0201b46:	873e                	mv	a4,a5
ffffffffc0201b48:	bf41                	j	ffffffffc0201ad8 <default_free_pages+0x8c>
ffffffffc0201b4a:	60a2                	ld	ra,8(sp)
ffffffffc0201b4c:	e390                	sd	a2,0(a5)
ffffffffc0201b4e:	e790                	sd	a2,8(a5)
ffffffffc0201b50:	f11c                	sd	a5,32(a0)
ffffffffc0201b52:	ed1c                	sd	a5,24(a0)
ffffffffc0201b54:	0141                	addi	sp,sp,16
ffffffffc0201b56:	8082                	ret
ffffffffc0201b58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b5c:	ff078693          	addi	a3,a5,-16
ffffffffc0201b60:	9e39                	addw	a2,a2,a4
ffffffffc0201b62:	c910                	sw	a2,16(a0)
ffffffffc0201b64:	5775                	li	a4,-3
ffffffffc0201b66:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6a:	6398                	ld	a4,0(a5)
ffffffffc0201b6c:	679c                	ld	a5,8(a5)
ffffffffc0201b6e:	60a2                	ld	ra,8(sp)
ffffffffc0201b70:	e71c                	sd	a5,8(a4)
ffffffffc0201b72:	e398                	sd	a4,0(a5)
ffffffffc0201b74:	0141                	addi	sp,sp,16
ffffffffc0201b76:	8082                	ret
ffffffffc0201b78:	0000a697          	auipc	a3,0xa
ffffffffc0201b7c:	65868693          	addi	a3,a3,1624 # ffffffffc020c1d0 <commands+0xca8>
ffffffffc0201b80:	0000a617          	auipc	a2,0xa
ffffffffc0201b84:	bb860613          	addi	a2,a2,-1096 # ffffffffc020b738 <commands+0x210>
ffffffffc0201b88:	08200593          	li	a1,130
ffffffffc0201b8c:	0000a517          	auipc	a0,0xa
ffffffffc0201b90:	2fc50513          	addi	a0,a0,764 # ffffffffc020be88 <commands+0x960>
ffffffffc0201b94:	90bfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b98:	0000a697          	auipc	a3,0xa
ffffffffc0201b9c:	63068693          	addi	a3,a3,1584 # ffffffffc020c1c8 <commands+0xca0>
ffffffffc0201ba0:	0000a617          	auipc	a2,0xa
ffffffffc0201ba4:	b9860613          	addi	a2,a2,-1128 # ffffffffc020b738 <commands+0x210>
ffffffffc0201ba8:	07f00593          	li	a1,127
ffffffffc0201bac:	0000a517          	auipc	a0,0xa
ffffffffc0201bb0:	2dc50513          	addi	a0,a0,732 # ffffffffc020be88 <commands+0x960>
ffffffffc0201bb4:	8ebfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bb8 <default_alloc_pages>:
ffffffffc0201bb8:	c941                	beqz	a0,ffffffffc0201c48 <default_alloc_pages+0x90>
ffffffffc0201bba:	00090597          	auipc	a1,0x90
ffffffffc0201bbe:	bee58593          	addi	a1,a1,-1042 # ffffffffc02917a8 <free_area>
ffffffffc0201bc2:	0105a803          	lw	a6,16(a1)
ffffffffc0201bc6:	872a                	mv	a4,a0
ffffffffc0201bc8:	02081793          	slli	a5,a6,0x20
ffffffffc0201bcc:	9381                	srli	a5,a5,0x20
ffffffffc0201bce:	00a7ee63          	bltu	a5,a0,ffffffffc0201bea <default_alloc_pages+0x32>
ffffffffc0201bd2:	87ae                	mv	a5,a1
ffffffffc0201bd4:	a801                	j	ffffffffc0201be4 <default_alloc_pages+0x2c>
ffffffffc0201bd6:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bda:	02069613          	slli	a2,a3,0x20
ffffffffc0201bde:	9201                	srli	a2,a2,0x20
ffffffffc0201be0:	00e67763          	bgeu	a2,a4,ffffffffc0201bee <default_alloc_pages+0x36>
ffffffffc0201be4:	679c                	ld	a5,8(a5)
ffffffffc0201be6:	feb798e3          	bne	a5,a1,ffffffffc0201bd6 <default_alloc_pages+0x1e>
ffffffffc0201bea:	4501                	li	a0,0
ffffffffc0201bec:	8082                	ret
ffffffffc0201bee:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf2:	0087b303          	ld	t1,8(a5)
ffffffffc0201bf6:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfa:	00070e1b          	sext.w	t3,a4
ffffffffc0201bfe:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c02:	01133023          	sd	a7,0(t1)
ffffffffc0201c06:	02c77863          	bgeu	a4,a2,ffffffffc0201c36 <default_alloc_pages+0x7e>
ffffffffc0201c0a:	071a                	slli	a4,a4,0x6
ffffffffc0201c0c:	972a                	add	a4,a4,a0
ffffffffc0201c0e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c12:	cb14                	sw	a3,16(a4)
ffffffffc0201c14:	00870613          	addi	a2,a4,8
ffffffffc0201c18:	4689                	li	a3,2
ffffffffc0201c1a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c1e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c22:	01870613          	addi	a2,a4,24
ffffffffc0201c26:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2a:	e290                	sd	a2,0(a3)
ffffffffc0201c2c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c30:	f314                	sd	a3,32(a4)
ffffffffc0201c32:	01173c23          	sd	a7,24(a4)
ffffffffc0201c36:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c3e:	5775                	li	a4,-3
ffffffffc0201c40:	17c1                	addi	a5,a5,-16
ffffffffc0201c42:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c46:	8082                	ret
ffffffffc0201c48:	1141                	addi	sp,sp,-16
ffffffffc0201c4a:	0000a697          	auipc	a3,0xa
ffffffffc0201c4e:	57e68693          	addi	a3,a3,1406 # ffffffffc020c1c8 <commands+0xca0>
ffffffffc0201c52:	0000a617          	auipc	a2,0xa
ffffffffc0201c56:	ae660613          	addi	a2,a2,-1306 # ffffffffc020b738 <commands+0x210>
ffffffffc0201c5a:	06100593          	li	a1,97
ffffffffc0201c5e:	0000a517          	auipc	a0,0xa
ffffffffc0201c62:	22a50513          	addi	a0,a0,554 # ffffffffc020be88 <commands+0x960>
ffffffffc0201c66:	e406                	sd	ra,8(sp)
ffffffffc0201c68:	837fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c6c <default_init_memmap>:
ffffffffc0201c6c:	1141                	addi	sp,sp,-16
ffffffffc0201c6e:	e406                	sd	ra,8(sp)
ffffffffc0201c70:	c5f1                	beqz	a1,ffffffffc0201d3c <default_init_memmap+0xd0>
ffffffffc0201c72:	00659693          	slli	a3,a1,0x6
ffffffffc0201c76:	96aa                	add	a3,a3,a0
ffffffffc0201c78:	87aa                	mv	a5,a0
ffffffffc0201c7a:	00d50f63          	beq	a0,a3,ffffffffc0201c98 <default_init_memmap+0x2c>
ffffffffc0201c7e:	6798                	ld	a4,8(a5)
ffffffffc0201c80:	8b05                	andi	a4,a4,1
ffffffffc0201c82:	cf49                	beqz	a4,ffffffffc0201d1c <default_init_memmap+0xb0>
ffffffffc0201c84:	0007a823          	sw	zero,16(a5)
ffffffffc0201c88:	0007b423          	sd	zero,8(a5)
ffffffffc0201c8c:	0007a023          	sw	zero,0(a5)
ffffffffc0201c90:	04078793          	addi	a5,a5,64
ffffffffc0201c94:	fed795e3          	bne	a5,a3,ffffffffc0201c7e <default_init_memmap+0x12>
ffffffffc0201c98:	2581                	sext.w	a1,a1
ffffffffc0201c9a:	c90c                	sw	a1,16(a0)
ffffffffc0201c9c:	4789                	li	a5,2
ffffffffc0201c9e:	00850713          	addi	a4,a0,8
ffffffffc0201ca2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201ca6:	00090697          	auipc	a3,0x90
ffffffffc0201caa:	b0268693          	addi	a3,a3,-1278 # ffffffffc02917a8 <free_area>
ffffffffc0201cae:	4a98                	lw	a4,16(a3)
ffffffffc0201cb0:	669c                	ld	a5,8(a3)
ffffffffc0201cb2:	01850613          	addi	a2,a0,24
ffffffffc0201cb6:	9db9                	addw	a1,a1,a4
ffffffffc0201cb8:	ca8c                	sw	a1,16(a3)
ffffffffc0201cba:	04d78a63          	beq	a5,a3,ffffffffc0201d0e <default_init_memmap+0xa2>
ffffffffc0201cbe:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc2:	0006b803          	ld	a6,0(a3)
ffffffffc0201cc6:	4581                	li	a1,0
ffffffffc0201cc8:	00e56a63          	bltu	a0,a4,ffffffffc0201cdc <default_init_memmap+0x70>
ffffffffc0201ccc:	6798                	ld	a4,8(a5)
ffffffffc0201cce:	02d70263          	beq	a4,a3,ffffffffc0201cf2 <default_init_memmap+0x86>
ffffffffc0201cd2:	87ba                	mv	a5,a4
ffffffffc0201cd4:	fe878713          	addi	a4,a5,-24
ffffffffc0201cd8:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ccc <default_init_memmap+0x60>
ffffffffc0201cdc:	c199                	beqz	a1,ffffffffc0201ce2 <default_init_memmap+0x76>
ffffffffc0201cde:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce2:	6398                	ld	a4,0(a5)
ffffffffc0201ce4:	60a2                	ld	ra,8(sp)
ffffffffc0201ce6:	e390                	sd	a2,0(a5)
ffffffffc0201ce8:	e710                	sd	a2,8(a4)
ffffffffc0201cea:	f11c                	sd	a5,32(a0)
ffffffffc0201cec:	ed18                	sd	a4,24(a0)
ffffffffc0201cee:	0141                	addi	sp,sp,16
ffffffffc0201cf0:	8082                	ret
ffffffffc0201cf2:	e790                	sd	a2,8(a5)
ffffffffc0201cf4:	f114                	sd	a3,32(a0)
ffffffffc0201cf6:	6798                	ld	a4,8(a5)
ffffffffc0201cf8:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfa:	00d70663          	beq	a4,a3,ffffffffc0201d06 <default_init_memmap+0x9a>
ffffffffc0201cfe:	8832                	mv	a6,a2
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	87ba                	mv	a5,a4
ffffffffc0201d04:	bfc1                	j	ffffffffc0201cd4 <default_init_memmap+0x68>
ffffffffc0201d06:	60a2                	ld	ra,8(sp)
ffffffffc0201d08:	e290                	sd	a2,0(a3)
ffffffffc0201d0a:	0141                	addi	sp,sp,16
ffffffffc0201d0c:	8082                	ret
ffffffffc0201d0e:	60a2                	ld	ra,8(sp)
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e790                	sd	a2,8(a5)
ffffffffc0201d14:	f11c                	sd	a5,32(a0)
ffffffffc0201d16:	ed1c                	sd	a5,24(a0)
ffffffffc0201d18:	0141                	addi	sp,sp,16
ffffffffc0201d1a:	8082                	ret
ffffffffc0201d1c:	0000a697          	auipc	a3,0xa
ffffffffc0201d20:	4dc68693          	addi	a3,a3,1244 # ffffffffc020c1f8 <commands+0xcd0>
ffffffffc0201d24:	0000a617          	auipc	a2,0xa
ffffffffc0201d28:	a1460613          	addi	a2,a2,-1516 # ffffffffc020b738 <commands+0x210>
ffffffffc0201d2c:	04800593          	li	a1,72
ffffffffc0201d30:	0000a517          	auipc	a0,0xa
ffffffffc0201d34:	15850513          	addi	a0,a0,344 # ffffffffc020be88 <commands+0x960>
ffffffffc0201d38:	f66fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d3c:	0000a697          	auipc	a3,0xa
ffffffffc0201d40:	48c68693          	addi	a3,a3,1164 # ffffffffc020c1c8 <commands+0xca0>
ffffffffc0201d44:	0000a617          	auipc	a2,0xa
ffffffffc0201d48:	9f460613          	addi	a2,a2,-1548 # ffffffffc020b738 <commands+0x210>
ffffffffc0201d4c:	04500593          	li	a1,69
ffffffffc0201d50:	0000a517          	auipc	a0,0xa
ffffffffc0201d54:	13850513          	addi	a0,a0,312 # ffffffffc020be88 <commands+0x960>
ffffffffc0201d58:	f46fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d5c <slob_free>:
ffffffffc0201d5c:	c94d                	beqz	a0,ffffffffc0201e0e <slob_free+0xb2>
ffffffffc0201d5e:	1141                	addi	sp,sp,-16
ffffffffc0201d60:	e022                	sd	s0,0(sp)
ffffffffc0201d62:	e406                	sd	ra,8(sp)
ffffffffc0201d64:	842a                	mv	s0,a0
ffffffffc0201d66:	e9c1                	bnez	a1,ffffffffc0201df6 <slob_free+0x9a>
ffffffffc0201d68:	100027f3          	csrr	a5,sstatus
ffffffffc0201d6c:	8b89                	andi	a5,a5,2
ffffffffc0201d6e:	4501                	li	a0,0
ffffffffc0201d70:	ebd9                	bnez	a5,ffffffffc0201e06 <slob_free+0xaa>
ffffffffc0201d72:	0008f617          	auipc	a2,0x8f
ffffffffc0201d76:	2de60613          	addi	a2,a2,734 # ffffffffc0291050 <slobfree>
ffffffffc0201d7a:	621c                	ld	a5,0(a2)
ffffffffc0201d7c:	873e                	mv	a4,a5
ffffffffc0201d7e:	679c                	ld	a5,8(a5)
ffffffffc0201d80:	02877a63          	bgeu	a4,s0,ffffffffc0201db4 <slob_free+0x58>
ffffffffc0201d84:	00f46463          	bltu	s0,a5,ffffffffc0201d8c <slob_free+0x30>
ffffffffc0201d88:	fef76ae3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201d8c:	400c                	lw	a1,0(s0)
ffffffffc0201d8e:	00459693          	slli	a3,a1,0x4
ffffffffc0201d92:	96a2                	add	a3,a3,s0
ffffffffc0201d94:	02d78a63          	beq	a5,a3,ffffffffc0201dc8 <slob_free+0x6c>
ffffffffc0201d98:	4314                	lw	a3,0(a4)
ffffffffc0201d9a:	e41c                	sd	a5,8(s0)
ffffffffc0201d9c:	00469793          	slli	a5,a3,0x4
ffffffffc0201da0:	97ba                	add	a5,a5,a4
ffffffffc0201da2:	02f40e63          	beq	s0,a5,ffffffffc0201dde <slob_free+0x82>
ffffffffc0201da6:	e700                	sd	s0,8(a4)
ffffffffc0201da8:	e218                	sd	a4,0(a2)
ffffffffc0201daa:	e129                	bnez	a0,ffffffffc0201dec <slob_free+0x90>
ffffffffc0201dac:	60a2                	ld	ra,8(sp)
ffffffffc0201dae:	6402                	ld	s0,0(sp)
ffffffffc0201db0:	0141                	addi	sp,sp,16
ffffffffc0201db2:	8082                	ret
ffffffffc0201db4:	fcf764e3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201db8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201dbc:	400c                	lw	a1,0(s0)
ffffffffc0201dbe:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc2:	96a2                	add	a3,a3,s0
ffffffffc0201dc4:	fcd79ae3          	bne	a5,a3,ffffffffc0201d98 <slob_free+0x3c>
ffffffffc0201dc8:	4394                	lw	a3,0(a5)
ffffffffc0201dca:	679c                	ld	a5,8(a5)
ffffffffc0201dcc:	9db5                	addw	a1,a1,a3
ffffffffc0201dce:	c00c                	sw	a1,0(s0)
ffffffffc0201dd0:	4314                	lw	a3,0(a4)
ffffffffc0201dd2:	e41c                	sd	a5,8(s0)
ffffffffc0201dd4:	00469793          	slli	a5,a3,0x4
ffffffffc0201dd8:	97ba                	add	a5,a5,a4
ffffffffc0201dda:	fcf416e3          	bne	s0,a5,ffffffffc0201da6 <slob_free+0x4a>
ffffffffc0201dde:	401c                	lw	a5,0(s0)
ffffffffc0201de0:	640c                	ld	a1,8(s0)
ffffffffc0201de2:	e218                	sd	a4,0(a2)
ffffffffc0201de4:	9ebd                	addw	a3,a3,a5
ffffffffc0201de6:	c314                	sw	a3,0(a4)
ffffffffc0201de8:	e70c                	sd	a1,8(a4)
ffffffffc0201dea:	d169                	beqz	a0,ffffffffc0201dac <slob_free+0x50>
ffffffffc0201dec:	6402                	ld	s0,0(sp)
ffffffffc0201dee:	60a2                	ld	ra,8(sp)
ffffffffc0201df0:	0141                	addi	sp,sp,16
ffffffffc0201df2:	e7bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201df6:	25bd                	addiw	a1,a1,15
ffffffffc0201df8:	8191                	srli	a1,a1,0x4
ffffffffc0201dfa:	c10c                	sw	a1,0(a0)
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	d7bd                	beqz	a5,ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e06:	e6dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	b79d                	j	ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e0e:	8082                	ret

ffffffffc0201e10 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e10:	4785                	li	a5,1
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e18:	e406                	sd	ra,8(sp)
ffffffffc0201e1a:	352000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201e1e:	c91d                	beqz	a0,ffffffffc0201e54 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e20:	00095697          	auipc	a3,0x95
ffffffffc0201e24:	a886b683          	ld	a3,-1400(a3) # ffffffffc02968a8 <pages>
ffffffffc0201e28:	8d15                	sub	a0,a0,a3
ffffffffc0201e2a:	8519                	srai	a0,a0,0x6
ffffffffc0201e2c:	0000d697          	auipc	a3,0xd
ffffffffc0201e30:	5e46b683          	ld	a3,1508(a3) # ffffffffc020f410 <nbase>
ffffffffc0201e34:	9536                	add	a0,a0,a3
ffffffffc0201e36:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e3c:	00095717          	auipc	a4,0x95
ffffffffc0201e40:	a6473703          	ld	a4,-1436(a4) # ffffffffc02968a0 <npage>
ffffffffc0201e44:	0532                	slli	a0,a0,0xc
ffffffffc0201e46:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4a:	00095697          	auipc	a3,0x95
ffffffffc0201e4e:	a6e6b683          	ld	a3,-1426(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201e52:	9536                	add	a0,a0,a3
ffffffffc0201e54:	60a2                	ld	ra,8(sp)
ffffffffc0201e56:	0141                	addi	sp,sp,16
ffffffffc0201e58:	8082                	ret
ffffffffc0201e5a:	86aa                	mv	a3,a0
ffffffffc0201e5c:	0000a617          	auipc	a2,0xa
ffffffffc0201e60:	3fc60613          	addi	a2,a2,1020 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc0201e64:	07100593          	li	a1,113
ffffffffc0201e68:	0000a517          	auipc	a0,0xa
ffffffffc0201e6c:	41850513          	addi	a0,a0,1048 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0201e70:	e2efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e74 <slob_alloc.constprop.0>:
ffffffffc0201e74:	1101                	addi	sp,sp,-32
ffffffffc0201e76:	ec06                	sd	ra,24(sp)
ffffffffc0201e78:	e822                	sd	s0,16(sp)
ffffffffc0201e7a:	e426                	sd	s1,8(sp)
ffffffffc0201e7c:	e04a                	sd	s2,0(sp)
ffffffffc0201e7e:	01050713          	addi	a4,a0,16
ffffffffc0201e82:	6785                	lui	a5,0x1
ffffffffc0201e84:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4a <slob_alloc.constprop.0+0xd6>
ffffffffc0201e88:	00f50493          	addi	s1,a0,15
ffffffffc0201e8c:	8091                	srli	s1,s1,0x4
ffffffffc0201e8e:	2481                	sext.w	s1,s1
ffffffffc0201e90:	10002673          	csrr	a2,sstatus
ffffffffc0201e94:	8a09                	andi	a2,a2,2
ffffffffc0201e96:	e25d                	bnez	a2,ffffffffc0201f3c <slob_alloc.constprop.0+0xc8>
ffffffffc0201e98:	0008f917          	auipc	s2,0x8f
ffffffffc0201e9c:	1b890913          	addi	s2,s2,440 # ffffffffc0291050 <slobfree>
ffffffffc0201ea0:	00093683          	ld	a3,0(s2)
ffffffffc0201ea4:	669c                	ld	a5,8(a3)
ffffffffc0201ea6:	4398                	lw	a4,0(a5)
ffffffffc0201ea8:	08975e63          	bge	a4,s1,ffffffffc0201f44 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eac:	00f68b63          	beq	a3,a5,ffffffffc0201ec2 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb0:	6780                	ld	s0,8(a5)
ffffffffc0201eb2:	4018                	lw	a4,0(s0)
ffffffffc0201eb4:	02975a63          	bge	a4,s1,ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201eb8:	00093683          	ld	a3,0(s2)
ffffffffc0201ebc:	87a2                	mv	a5,s0
ffffffffc0201ebe:	fef699e3          	bne	a3,a5,ffffffffc0201eb0 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec2:	ee31                	bnez	a2,ffffffffc0201f1e <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec4:	4501                	li	a0,0
ffffffffc0201ec6:	f4bff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201eca:	842a                	mv	s0,a0
ffffffffc0201ecc:	cd05                	beqz	a0,ffffffffc0201f04 <slob_alloc.constprop.0+0x90>
ffffffffc0201ece:	6585                	lui	a1,0x1
ffffffffc0201ed0:	e8dff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc0201ed4:	10002673          	csrr	a2,sstatus
ffffffffc0201ed8:	8a09                	andi	a2,a2,2
ffffffffc0201eda:	ee05                	bnez	a2,ffffffffc0201f12 <slob_alloc.constprop.0+0x9e>
ffffffffc0201edc:	00093783          	ld	a5,0(s2)
ffffffffc0201ee0:	6780                	ld	s0,8(a5)
ffffffffc0201ee2:	4018                	lw	a4,0(s0)
ffffffffc0201ee4:	fc974ae3          	blt	a4,s1,ffffffffc0201eb8 <slob_alloc.constprop.0+0x44>
ffffffffc0201ee8:	04e48763          	beq	s1,a4,ffffffffc0201f36 <slob_alloc.constprop.0+0xc2>
ffffffffc0201eec:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef0:	96a2                	add	a3,a3,s0
ffffffffc0201ef2:	e794                	sd	a3,8(a5)
ffffffffc0201ef4:	640c                	ld	a1,8(s0)
ffffffffc0201ef6:	9f05                	subw	a4,a4,s1
ffffffffc0201ef8:	c298                	sw	a4,0(a3)
ffffffffc0201efa:	e68c                	sd	a1,8(a3)
ffffffffc0201efc:	c004                	sw	s1,0(s0)
ffffffffc0201efe:	00f93023          	sd	a5,0(s2)
ffffffffc0201f02:	e20d                	bnez	a2,ffffffffc0201f24 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f04:	60e2                	ld	ra,24(sp)
ffffffffc0201f06:	8522                	mv	a0,s0
ffffffffc0201f08:	6442                	ld	s0,16(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6902                	ld	s2,0(sp)
ffffffffc0201f0e:	6105                	addi	sp,sp,32
ffffffffc0201f10:	8082                	ret
ffffffffc0201f12:	d61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f16:	00093783          	ld	a5,0(s2)
ffffffffc0201f1a:	4605                	li	a2,1
ffffffffc0201f1c:	b7d1                	j	ffffffffc0201ee0 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f1e:	d4ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f22:	b74d                	j	ffffffffc0201ec4 <slob_alloc.constprop.0+0x50>
ffffffffc0201f24:	d49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	8522                	mv	a0,s0
ffffffffc0201f2c:	6442                	ld	s0,16(sp)
ffffffffc0201f2e:	64a2                	ld	s1,8(sp)
ffffffffc0201f30:	6902                	ld	s2,0(sp)
ffffffffc0201f32:	6105                	addi	sp,sp,32
ffffffffc0201f34:	8082                	ret
ffffffffc0201f36:	6418                	ld	a4,8(s0)
ffffffffc0201f38:	e798                	sd	a4,8(a5)
ffffffffc0201f3a:	b7d1                	j	ffffffffc0201efe <slob_alloc.constprop.0+0x8a>
ffffffffc0201f3c:	d37fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f40:	4605                	li	a2,1
ffffffffc0201f42:	bf99                	j	ffffffffc0201e98 <slob_alloc.constprop.0+0x24>
ffffffffc0201f44:	843e                	mv	s0,a5
ffffffffc0201f46:	87b6                	mv	a5,a3
ffffffffc0201f48:	b745                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201f4a:	0000a697          	auipc	a3,0xa
ffffffffc0201f4e:	34668693          	addi	a3,a3,838 # ffffffffc020c290 <default_pmm_manager+0x70>
ffffffffc0201f52:	00009617          	auipc	a2,0x9
ffffffffc0201f56:	7e660613          	addi	a2,a2,2022 # ffffffffc020b738 <commands+0x210>
ffffffffc0201f5a:	06300593          	li	a1,99
ffffffffc0201f5e:	0000a517          	auipc	a0,0xa
ffffffffc0201f62:	35250513          	addi	a0,a0,850 # ffffffffc020c2b0 <default_pmm_manager+0x90>
ffffffffc0201f66:	d38fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6a <kmalloc_init>:
ffffffffc0201f6a:	1141                	addi	sp,sp,-16
ffffffffc0201f6c:	0000a517          	auipc	a0,0xa
ffffffffc0201f70:	35c50513          	addi	a0,a0,860 # ffffffffc020c2c8 <default_pmm_manager+0xa8>
ffffffffc0201f74:	e406                	sd	ra,8(sp)
ffffffffc0201f76:	a30fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7a:	60a2                	ld	ra,8(sp)
ffffffffc0201f7c:	0000a517          	auipc	a0,0xa
ffffffffc0201f80:	36450513          	addi	a0,a0,868 # ffffffffc020c2e0 <default_pmm_manager+0xc0>
ffffffffc0201f84:	0141                	addi	sp,sp,16
ffffffffc0201f86:	a20fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8a <kallocated>:
ffffffffc0201f8a:	4501                	li	a0,0
ffffffffc0201f8c:	8082                	ret

ffffffffc0201f8e <kmalloc>:
ffffffffc0201f8e:	1101                	addi	sp,sp,-32
ffffffffc0201f90:	e04a                	sd	s2,0(sp)
ffffffffc0201f92:	6905                	lui	s2,0x1
ffffffffc0201f94:	e822                	sd	s0,16(sp)
ffffffffc0201f96:	ec06                	sd	ra,24(sp)
ffffffffc0201f98:	e426                	sd	s1,8(sp)
ffffffffc0201f9a:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201f9e:	842a                	mv	s0,a0
ffffffffc0201fa0:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff2 <kmalloc+0x64>
ffffffffc0201fa4:	4561                	li	a0,24
ffffffffc0201fa6:	ecfff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201faa:	84aa                	mv	s1,a0
ffffffffc0201fac:	c929                	beqz	a0,ffffffffc0201ffe <kmalloc+0x70>
ffffffffc0201fae:	0004079b          	sext.w	a5,s0
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	00f95763          	bge	s2,a5,ffffffffc0201fc2 <kmalloc+0x34>
ffffffffc0201fb8:	6705                	lui	a4,0x1
ffffffffc0201fba:	8785                	srai	a5,a5,0x1
ffffffffc0201fbc:	2505                	addiw	a0,a0,1
ffffffffc0201fbe:	fef74ee3          	blt	a4,a5,ffffffffc0201fba <kmalloc+0x2c>
ffffffffc0201fc2:	c088                	sw	a0,0(s1)
ffffffffc0201fc4:	e4dff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201fc8:	e488                	sd	a0,8(s1)
ffffffffc0201fca:	842a                	mv	s0,a0
ffffffffc0201fcc:	c525                	beqz	a0,ffffffffc0202034 <kmalloc+0xa6>
ffffffffc0201fce:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd2:	8b89                	andi	a5,a5,2
ffffffffc0201fd4:	ef8d                	bnez	a5,ffffffffc020200e <kmalloc+0x80>
ffffffffc0201fd6:	00095797          	auipc	a5,0x95
ffffffffc0201fda:	8b278793          	addi	a5,a5,-1870 # ffffffffc0296888 <bigblocks>
ffffffffc0201fde:	6398                	ld	a4,0(a5)
ffffffffc0201fe0:	e384                	sd	s1,0(a5)
ffffffffc0201fe2:	e898                	sd	a4,16(s1)
ffffffffc0201fe4:	60e2                	ld	ra,24(sp)
ffffffffc0201fe6:	8522                	mv	a0,s0
ffffffffc0201fe8:	6442                	ld	s0,16(sp)
ffffffffc0201fea:	64a2                	ld	s1,8(sp)
ffffffffc0201fec:	6902                	ld	s2,0(sp)
ffffffffc0201fee:	6105                	addi	sp,sp,32
ffffffffc0201ff0:	8082                	ret
ffffffffc0201ff2:	0541                	addi	a0,a0,16
ffffffffc0201ff4:	e81ff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201ff8:	01050413          	addi	s0,a0,16
ffffffffc0201ffc:	f565                	bnez	a0,ffffffffc0201fe4 <kmalloc+0x56>
ffffffffc0201ffe:	4401                	li	s0,0
ffffffffc0202000:	60e2                	ld	ra,24(sp)
ffffffffc0202002:	8522                	mv	a0,s0
ffffffffc0202004:	6442                	ld	s0,16(sp)
ffffffffc0202006:	64a2                	ld	s1,8(sp)
ffffffffc0202008:	6902                	ld	s2,0(sp)
ffffffffc020200a:	6105                	addi	sp,sp,32
ffffffffc020200c:	8082                	ret
ffffffffc020200e:	c65fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202012:	00095797          	auipc	a5,0x95
ffffffffc0202016:	87678793          	addi	a5,a5,-1930 # ffffffffc0296888 <bigblocks>
ffffffffc020201a:	6398                	ld	a4,0(a5)
ffffffffc020201c:	e384                	sd	s1,0(a5)
ffffffffc020201e:	e898                	sd	a4,16(s1)
ffffffffc0202020:	c4dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202024:	6480                	ld	s0,8(s1)
ffffffffc0202026:	60e2                	ld	ra,24(sp)
ffffffffc0202028:	64a2                	ld	s1,8(sp)
ffffffffc020202a:	8522                	mv	a0,s0
ffffffffc020202c:	6442                	ld	s0,16(sp)
ffffffffc020202e:	6902                	ld	s2,0(sp)
ffffffffc0202030:	6105                	addi	sp,sp,32
ffffffffc0202032:	8082                	ret
ffffffffc0202034:	45e1                	li	a1,24
ffffffffc0202036:	8526                	mv	a0,s1
ffffffffc0202038:	d25ff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc020203c:	b765                	j	ffffffffc0201fe4 <kmalloc+0x56>

ffffffffc020203e <kfree>:
ffffffffc020203e:	c169                	beqz	a0,ffffffffc0202100 <kfree+0xc2>
ffffffffc0202040:	1101                	addi	sp,sp,-32
ffffffffc0202042:	e822                	sd	s0,16(sp)
ffffffffc0202044:	ec06                	sd	ra,24(sp)
ffffffffc0202046:	e426                	sd	s1,8(sp)
ffffffffc0202048:	03451793          	slli	a5,a0,0x34
ffffffffc020204c:	842a                	mv	s0,a0
ffffffffc020204e:	e3d9                	bnez	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202050:	100027f3          	csrr	a5,sstatus
ffffffffc0202054:	8b89                	andi	a5,a5,2
ffffffffc0202056:	e7d9                	bnez	a5,ffffffffc02020e4 <kfree+0xa6>
ffffffffc0202058:	00095797          	auipc	a5,0x95
ffffffffc020205c:	8307b783          	ld	a5,-2000(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202060:	4601                	li	a2,0
ffffffffc0202062:	cbad                	beqz	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202064:	00095697          	auipc	a3,0x95
ffffffffc0202068:	82468693          	addi	a3,a3,-2012 # ffffffffc0296888 <bigblocks>
ffffffffc020206c:	a021                	j	ffffffffc0202074 <kfree+0x36>
ffffffffc020206e:	01048693          	addi	a3,s1,16
ffffffffc0202072:	c3a5                	beqz	a5,ffffffffc02020d2 <kfree+0x94>
ffffffffc0202074:	6798                	ld	a4,8(a5)
ffffffffc0202076:	84be                	mv	s1,a5
ffffffffc0202078:	6b9c                	ld	a5,16(a5)
ffffffffc020207a:	fe871ae3          	bne	a4,s0,ffffffffc020206e <kfree+0x30>
ffffffffc020207e:	e29c                	sd	a5,0(a3)
ffffffffc0202080:	ee2d                	bnez	a2,ffffffffc02020fa <kfree+0xbc>
ffffffffc0202082:	c02007b7          	lui	a5,0xc0200
ffffffffc0202086:	4098                	lw	a4,0(s1)
ffffffffc0202088:	08f46963          	bltu	s0,a5,ffffffffc020211a <kfree+0xdc>
ffffffffc020208c:	00095697          	auipc	a3,0x95
ffffffffc0202090:	82c6b683          	ld	a3,-2004(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202094:	8c15                	sub	s0,s0,a3
ffffffffc0202096:	8031                	srli	s0,s0,0xc
ffffffffc0202098:	00095797          	auipc	a5,0x95
ffffffffc020209c:	8087b783          	ld	a5,-2040(a5) # ffffffffc02968a0 <npage>
ffffffffc02020a0:	06f47163          	bgeu	s0,a5,ffffffffc0202102 <kfree+0xc4>
ffffffffc02020a4:	0000d517          	auipc	a0,0xd
ffffffffc02020a8:	36c53503          	ld	a0,876(a0) # ffffffffc020f410 <nbase>
ffffffffc02020ac:	8c09                	sub	s0,s0,a0
ffffffffc02020ae:	041a                	slli	s0,s0,0x6
ffffffffc02020b0:	00094517          	auipc	a0,0x94
ffffffffc02020b4:	7f853503          	ld	a0,2040(a0) # ffffffffc02968a8 <pages>
ffffffffc02020b8:	4585                	li	a1,1
ffffffffc02020ba:	9522                	add	a0,a0,s0
ffffffffc02020bc:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c0:	0ea000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02020c4:	6442                	ld	s0,16(sp)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8526                	mv	a0,s1
ffffffffc02020ca:	64a2                	ld	s1,8(sp)
ffffffffc02020cc:	45e1                	li	a1,24
ffffffffc02020ce:	6105                	addi	sp,sp,32
ffffffffc02020d0:	b171                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020d2:	e20d                	bnez	a2,ffffffffc02020f4 <kfree+0xb6>
ffffffffc02020d4:	ff040513          	addi	a0,s0,-16
ffffffffc02020d8:	6442                	ld	s0,16(sp)
ffffffffc02020da:	60e2                	ld	ra,24(sp)
ffffffffc02020dc:	64a2                	ld	s1,8(sp)
ffffffffc02020de:	4581                	li	a1,0
ffffffffc02020e0:	6105                	addi	sp,sp,32
ffffffffc02020e2:	b9ad                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020e4:	b8ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020e8:	00094797          	auipc	a5,0x94
ffffffffc02020ec:	7a07b783          	ld	a5,1952(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020f0:	4605                	li	a2,1
ffffffffc02020f2:	fbad                	bnez	a5,ffffffffc0202064 <kfree+0x26>
ffffffffc02020f4:	b79fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020f8:	bff1                	j	ffffffffc02020d4 <kfree+0x96>
ffffffffc02020fa:	b73fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fe:	b751                	j	ffffffffc0202082 <kfree+0x44>
ffffffffc0202100:	8082                	ret
ffffffffc0202102:	0000a617          	auipc	a2,0xa
ffffffffc0202106:	22660613          	addi	a2,a2,550 # ffffffffc020c328 <default_pmm_manager+0x108>
ffffffffc020210a:	06900593          	li	a1,105
ffffffffc020210e:	0000a517          	auipc	a0,0xa
ffffffffc0202112:	17250513          	addi	a0,a0,370 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0202116:	b88fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211a:	86a2                	mv	a3,s0
ffffffffc020211c:	0000a617          	auipc	a2,0xa
ffffffffc0202120:	1e460613          	addi	a2,a2,484 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0202124:	07700593          	li	a1,119
ffffffffc0202128:	0000a517          	auipc	a0,0xa
ffffffffc020212c:	15850513          	addi	a0,a0,344 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0202130:	b6efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202134 <pa2page.part.0>:
ffffffffc0202134:	1141                	addi	sp,sp,-16
ffffffffc0202136:	0000a617          	auipc	a2,0xa
ffffffffc020213a:	1f260613          	addi	a2,a2,498 # ffffffffc020c328 <default_pmm_manager+0x108>
ffffffffc020213e:	06900593          	li	a1,105
ffffffffc0202142:	0000a517          	auipc	a0,0xa
ffffffffc0202146:	13e50513          	addi	a0,a0,318 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc020214a:	e406                	sd	ra,8(sp)
ffffffffc020214c:	b52fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202150 <pte2page.part.0>:
ffffffffc0202150:	1141                	addi	sp,sp,-16
ffffffffc0202152:	0000a617          	auipc	a2,0xa
ffffffffc0202156:	1f660613          	addi	a2,a2,502 # ffffffffc020c348 <default_pmm_manager+0x128>
ffffffffc020215a:	07f00593          	li	a1,127
ffffffffc020215e:	0000a517          	auipc	a0,0xa
ffffffffc0202162:	12250513          	addi	a0,a0,290 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0202166:	e406                	sd	ra,8(sp)
ffffffffc0202168:	b36fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020216c <alloc_pages>:
ffffffffc020216c:	100027f3          	csrr	a5,sstatus
ffffffffc0202170:	8b89                	andi	a5,a5,2
ffffffffc0202172:	e799                	bnez	a5,ffffffffc0202180 <alloc_pages+0x14>
ffffffffc0202174:	00094797          	auipc	a5,0x94
ffffffffc0202178:	73c7b783          	ld	a5,1852(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020217c:	6f9c                	ld	a5,24(a5)
ffffffffc020217e:	8782                	jr	a5
ffffffffc0202180:	1141                	addi	sp,sp,-16
ffffffffc0202182:	e406                	sd	ra,8(sp)
ffffffffc0202184:	e022                	sd	s0,0(sp)
ffffffffc0202186:	842a                	mv	s0,a0
ffffffffc0202188:	aebfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020218c:	00094797          	auipc	a5,0x94
ffffffffc0202190:	7247b783          	ld	a5,1828(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202194:	6f9c                	ld	a5,24(a5)
ffffffffc0202196:	8522                	mv	a0,s0
ffffffffc0202198:	9782                	jalr	a5
ffffffffc020219a:	842a                	mv	s0,a0
ffffffffc020219c:	ad1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a0:	60a2                	ld	ra,8(sp)
ffffffffc02021a2:	8522                	mv	a0,s0
ffffffffc02021a4:	6402                	ld	s0,0(sp)
ffffffffc02021a6:	0141                	addi	sp,sp,16
ffffffffc02021a8:	8082                	ret

ffffffffc02021aa <free_pages>:
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <free_pages+0x14>
ffffffffc02021b2:	00094797          	auipc	a5,0x94
ffffffffc02021b6:	6fe7b783          	ld	a5,1790(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021ba:	739c                	ld	a5,32(a5)
ffffffffc02021bc:	8782                	jr	a5
ffffffffc02021be:	1101                	addi	sp,sp,-32
ffffffffc02021c0:	ec06                	sd	ra,24(sp)
ffffffffc02021c2:	e822                	sd	s0,16(sp)
ffffffffc02021c4:	e426                	sd	s1,8(sp)
ffffffffc02021c6:	842a                	mv	s0,a0
ffffffffc02021c8:	84ae                	mv	s1,a1
ffffffffc02021ca:	aa9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021ce:	00094797          	auipc	a5,0x94
ffffffffc02021d2:	6e27b783          	ld	a5,1762(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021d6:	739c                	ld	a5,32(a5)
ffffffffc02021d8:	85a6                	mv	a1,s1
ffffffffc02021da:	8522                	mv	a0,s0
ffffffffc02021dc:	9782                	jalr	a5
ffffffffc02021de:	6442                	ld	s0,16(sp)
ffffffffc02021e0:	60e2                	ld	ra,24(sp)
ffffffffc02021e2:	64a2                	ld	s1,8(sp)
ffffffffc02021e4:	6105                	addi	sp,sp,32
ffffffffc02021e6:	a87fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ea <nr_free_pages>:
ffffffffc02021ea:	100027f3          	csrr	a5,sstatus
ffffffffc02021ee:	8b89                	andi	a5,a5,2
ffffffffc02021f0:	e799                	bnez	a5,ffffffffc02021fe <nr_free_pages+0x14>
ffffffffc02021f2:	00094797          	auipc	a5,0x94
ffffffffc02021f6:	6be7b783          	ld	a5,1726(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021fa:	779c                	ld	a5,40(a5)
ffffffffc02021fc:	8782                	jr	a5
ffffffffc02021fe:	1141                	addi	sp,sp,-16
ffffffffc0202200:	e406                	sd	ra,8(sp)
ffffffffc0202202:	e022                	sd	s0,0(sp)
ffffffffc0202204:	a6ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202208:	00094797          	auipc	a5,0x94
ffffffffc020220c:	6a87b783          	ld	a5,1704(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202210:	779c                	ld	a5,40(a5)
ffffffffc0202212:	9782                	jalr	a5
ffffffffc0202214:	842a                	mv	s0,a0
ffffffffc0202216:	a57fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221a:	60a2                	ld	ra,8(sp)
ffffffffc020221c:	8522                	mv	a0,s0
ffffffffc020221e:	6402                	ld	s0,0(sp)
ffffffffc0202220:	0141                	addi	sp,sp,16
ffffffffc0202222:	8082                	ret

ffffffffc0202224 <get_pte>:
ffffffffc0202224:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202228:	1ff7f793          	andi	a5,a5,511
ffffffffc020222c:	7139                	addi	sp,sp,-64
ffffffffc020222e:	078e                	slli	a5,a5,0x3
ffffffffc0202230:	f426                	sd	s1,40(sp)
ffffffffc0202232:	00f504b3          	add	s1,a0,a5
ffffffffc0202236:	6094                	ld	a3,0(s1)
ffffffffc0202238:	f04a                	sd	s2,32(sp)
ffffffffc020223a:	ec4e                	sd	s3,24(sp)
ffffffffc020223c:	e852                	sd	s4,16(sp)
ffffffffc020223e:	fc06                	sd	ra,56(sp)
ffffffffc0202240:	f822                	sd	s0,48(sp)
ffffffffc0202242:	e456                	sd	s5,8(sp)
ffffffffc0202244:	e05a                	sd	s6,0(sp)
ffffffffc0202246:	0016f793          	andi	a5,a3,1
ffffffffc020224a:	892e                	mv	s2,a1
ffffffffc020224c:	8a32                	mv	s4,a2
ffffffffc020224e:	00094997          	auipc	s3,0x94
ffffffffc0202252:	65298993          	addi	s3,s3,1618 # ffffffffc02968a0 <npage>
ffffffffc0202256:	efbd                	bnez	a5,ffffffffc02022d4 <get_pte+0xb0>
ffffffffc0202258:	14060c63          	beqz	a2,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020225c:	100027f3          	csrr	a5,sstatus
ffffffffc0202260:	8b89                	andi	a5,a5,2
ffffffffc0202262:	14079963          	bnez	a5,ffffffffc02023b4 <get_pte+0x190>
ffffffffc0202266:	00094797          	auipc	a5,0x94
ffffffffc020226a:	64a7b783          	ld	a5,1610(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020226e:	6f9c                	ld	a5,24(a5)
ffffffffc0202270:	4505                	li	a0,1
ffffffffc0202272:	9782                	jalr	a5
ffffffffc0202274:	842a                	mv	s0,a0
ffffffffc0202276:	12040d63          	beqz	s0,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020227a:	00094b17          	auipc	s6,0x94
ffffffffc020227e:	62eb0b13          	addi	s6,s6,1582 # ffffffffc02968a8 <pages>
ffffffffc0202282:	000b3503          	ld	a0,0(s6)
ffffffffc0202286:	00080ab7          	lui	s5,0x80
ffffffffc020228a:	00094997          	auipc	s3,0x94
ffffffffc020228e:	61698993          	addi	s3,s3,1558 # ffffffffc02968a0 <npage>
ffffffffc0202292:	40a40533          	sub	a0,s0,a0
ffffffffc0202296:	8519                	srai	a0,a0,0x6
ffffffffc0202298:	9556                	add	a0,a0,s5
ffffffffc020229a:	0009b703          	ld	a4,0(s3)
ffffffffc020229e:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a2:	4685                	li	a3,1
ffffffffc02022a4:	c014                	sw	a3,0(s0)
ffffffffc02022a6:	83b1                	srli	a5,a5,0xc
ffffffffc02022a8:	0532                	slli	a0,a0,0xc
ffffffffc02022aa:	16e7f763          	bgeu	a5,a4,ffffffffc0202418 <get_pte+0x1f4>
ffffffffc02022ae:	00094797          	auipc	a5,0x94
ffffffffc02022b2:	60a7b783          	ld	a5,1546(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022b6:	6605                	lui	a2,0x1
ffffffffc02022b8:	4581                	li	a1,0
ffffffffc02022ba:	953e                	add	a0,a0,a5
ffffffffc02022bc:	795080ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc02022c0:	000b3683          	ld	a3,0(s6)
ffffffffc02022c4:	40d406b3          	sub	a3,s0,a3
ffffffffc02022c8:	8699                	srai	a3,a3,0x6
ffffffffc02022ca:	96d6                	add	a3,a3,s5
ffffffffc02022cc:	06aa                	slli	a3,a3,0xa
ffffffffc02022ce:	0116e693          	ori	a3,a3,17
ffffffffc02022d2:	e094                	sd	a3,0(s1)
ffffffffc02022d4:	77fd                	lui	a5,0xfffff
ffffffffc02022d6:	068a                	slli	a3,a3,0x2
ffffffffc02022d8:	0009b703          	ld	a4,0(s3)
ffffffffc02022dc:	8efd                	and	a3,a3,a5
ffffffffc02022de:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e2:	10e7ff63          	bgeu	a5,a4,ffffffffc0202400 <get_pte+0x1dc>
ffffffffc02022e6:	00094a97          	auipc	s5,0x94
ffffffffc02022ea:	5d2a8a93          	addi	s5,s5,1490 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022ee:	000ab403          	ld	s0,0(s5)
ffffffffc02022f2:	01595793          	srli	a5,s2,0x15
ffffffffc02022f6:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fa:	96a2                	add	a3,a3,s0
ffffffffc02022fc:	00379413          	slli	s0,a5,0x3
ffffffffc0202300:	9436                	add	s0,s0,a3
ffffffffc0202302:	6014                	ld	a3,0(s0)
ffffffffc0202304:	0016f793          	andi	a5,a3,1
ffffffffc0202308:	ebad                	bnez	a5,ffffffffc020237a <get_pte+0x156>
ffffffffc020230a:	0a0a0363          	beqz	s4,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020230e:	100027f3          	csrr	a5,sstatus
ffffffffc0202312:	8b89                	andi	a5,a5,2
ffffffffc0202314:	efcd                	bnez	a5,ffffffffc02023ce <get_pte+0x1aa>
ffffffffc0202316:	00094797          	auipc	a5,0x94
ffffffffc020231a:	59a7b783          	ld	a5,1434(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020231e:	6f9c                	ld	a5,24(a5)
ffffffffc0202320:	4505                	li	a0,1
ffffffffc0202322:	9782                	jalr	a5
ffffffffc0202324:	84aa                	mv	s1,a0
ffffffffc0202326:	c4c9                	beqz	s1,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc0202328:	00094b17          	auipc	s6,0x94
ffffffffc020232c:	580b0b13          	addi	s6,s6,1408 # ffffffffc02968a8 <pages>
ffffffffc0202330:	000b3503          	ld	a0,0(s6)
ffffffffc0202334:	00080a37          	lui	s4,0x80
ffffffffc0202338:	0009b703          	ld	a4,0(s3)
ffffffffc020233c:	40a48533          	sub	a0,s1,a0
ffffffffc0202340:	8519                	srai	a0,a0,0x6
ffffffffc0202342:	9552                	add	a0,a0,s4
ffffffffc0202344:	00c51793          	slli	a5,a0,0xc
ffffffffc0202348:	4685                	li	a3,1
ffffffffc020234a:	c094                	sw	a3,0(s1)
ffffffffc020234c:	83b1                	srli	a5,a5,0xc
ffffffffc020234e:	0532                	slli	a0,a0,0xc
ffffffffc0202350:	0ee7f163          	bgeu	a5,a4,ffffffffc0202432 <get_pte+0x20e>
ffffffffc0202354:	000ab783          	ld	a5,0(s5)
ffffffffc0202358:	6605                	lui	a2,0x1
ffffffffc020235a:	4581                	li	a1,0
ffffffffc020235c:	953e                	add	a0,a0,a5
ffffffffc020235e:	6f3080ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0202362:	000b3683          	ld	a3,0(s6)
ffffffffc0202366:	40d486b3          	sub	a3,s1,a3
ffffffffc020236a:	8699                	srai	a3,a3,0x6
ffffffffc020236c:	96d2                	add	a3,a3,s4
ffffffffc020236e:	06aa                	slli	a3,a3,0xa
ffffffffc0202370:	0116e693          	ori	a3,a3,17
ffffffffc0202374:	e014                	sd	a3,0(s0)
ffffffffc0202376:	0009b703          	ld	a4,0(s3)
ffffffffc020237a:	068a                	slli	a3,a3,0x2
ffffffffc020237c:	757d                	lui	a0,0xfffff
ffffffffc020237e:	8ee9                	and	a3,a3,a0
ffffffffc0202380:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202384:	06e7f263          	bgeu	a5,a4,ffffffffc02023e8 <get_pte+0x1c4>
ffffffffc0202388:	000ab503          	ld	a0,0(s5)
ffffffffc020238c:	00c95913          	srli	s2,s2,0xc
ffffffffc0202390:	1ff97913          	andi	s2,s2,511
ffffffffc0202394:	96aa                	add	a3,a3,a0
ffffffffc0202396:	00391513          	slli	a0,s2,0x3
ffffffffc020239a:	9536                	add	a0,a0,a3
ffffffffc020239c:	70e2                	ld	ra,56(sp)
ffffffffc020239e:	7442                	ld	s0,48(sp)
ffffffffc02023a0:	74a2                	ld	s1,40(sp)
ffffffffc02023a2:	7902                	ld	s2,32(sp)
ffffffffc02023a4:	69e2                	ld	s3,24(sp)
ffffffffc02023a6:	6a42                	ld	s4,16(sp)
ffffffffc02023a8:	6aa2                	ld	s5,8(sp)
ffffffffc02023aa:	6b02                	ld	s6,0(sp)
ffffffffc02023ac:	6121                	addi	sp,sp,64
ffffffffc02023ae:	8082                	ret
ffffffffc02023b0:	4501                	li	a0,0
ffffffffc02023b2:	b7ed                	j	ffffffffc020239c <get_pte+0x178>
ffffffffc02023b4:	8bffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023b8:	00094797          	auipc	a5,0x94
ffffffffc02023bc:	4f87b783          	ld	a5,1272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023c0:	6f9c                	ld	a5,24(a5)
ffffffffc02023c2:	4505                	li	a0,1
ffffffffc02023c4:	9782                	jalr	a5
ffffffffc02023c6:	842a                	mv	s0,a0
ffffffffc02023c8:	8a5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023cc:	b56d                	j	ffffffffc0202276 <get_pte+0x52>
ffffffffc02023ce:	8a5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d2:	00094797          	auipc	a5,0x94
ffffffffc02023d6:	4de7b783          	ld	a5,1246(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023da:	6f9c                	ld	a5,24(a5)
ffffffffc02023dc:	4505                	li	a0,1
ffffffffc02023de:	9782                	jalr	a5
ffffffffc02023e0:	84aa                	mv	s1,a0
ffffffffc02023e2:	88bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023e6:	b781                	j	ffffffffc0202326 <get_pte+0x102>
ffffffffc02023e8:	0000a617          	auipc	a2,0xa
ffffffffc02023ec:	e7060613          	addi	a2,a2,-400 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc02023f0:	13200593          	li	a1,306
ffffffffc02023f4:	0000a517          	auipc	a0,0xa
ffffffffc02023f8:	f7c50513          	addi	a0,a0,-132 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02023fc:	8a2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202400:	0000a617          	auipc	a2,0xa
ffffffffc0202404:	e5860613          	addi	a2,a2,-424 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc0202408:	12500593          	li	a1,293
ffffffffc020240c:	0000a517          	auipc	a0,0xa
ffffffffc0202410:	f6450513          	addi	a0,a0,-156 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0202414:	88afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202418:	86aa                	mv	a3,a0
ffffffffc020241a:	0000a617          	auipc	a2,0xa
ffffffffc020241e:	e3e60613          	addi	a2,a2,-450 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc0202422:	12100593          	li	a1,289
ffffffffc0202426:	0000a517          	auipc	a0,0xa
ffffffffc020242a:	f4a50513          	addi	a0,a0,-182 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020242e:	870fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202432:	86aa                	mv	a3,a0
ffffffffc0202434:	0000a617          	auipc	a2,0xa
ffffffffc0202438:	e2460613          	addi	a2,a2,-476 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc020243c:	12f00593          	li	a1,303
ffffffffc0202440:	0000a517          	auipc	a0,0xa
ffffffffc0202444:	f3050513          	addi	a0,a0,-208 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0202448:	856fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020244c <boot_map_segment>:
ffffffffc020244c:	6785                	lui	a5,0x1
ffffffffc020244e:	7139                	addi	sp,sp,-64
ffffffffc0202450:	00d5c833          	xor	a6,a1,a3
ffffffffc0202454:	17fd                	addi	a5,a5,-1
ffffffffc0202456:	fc06                	sd	ra,56(sp)
ffffffffc0202458:	f822                	sd	s0,48(sp)
ffffffffc020245a:	f426                	sd	s1,40(sp)
ffffffffc020245c:	f04a                	sd	s2,32(sp)
ffffffffc020245e:	ec4e                	sd	s3,24(sp)
ffffffffc0202460:	e852                	sd	s4,16(sp)
ffffffffc0202462:	e456                	sd	s5,8(sp)
ffffffffc0202464:	00f87833          	and	a6,a6,a5
ffffffffc0202468:	08081563          	bnez	a6,ffffffffc02024f2 <boot_map_segment+0xa6>
ffffffffc020246c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202470:	963e                	add	a2,a2,a5
ffffffffc0202472:	94b2                	add	s1,s1,a2
ffffffffc0202474:	797d                	lui	s2,0xfffff
ffffffffc0202476:	80b1                	srli	s1,s1,0xc
ffffffffc0202478:	0125f5b3          	and	a1,a1,s2
ffffffffc020247c:	0126f6b3          	and	a3,a3,s2
ffffffffc0202480:	c0a1                	beqz	s1,ffffffffc02024c0 <boot_map_segment+0x74>
ffffffffc0202482:	00176713          	ori	a4,a4,1
ffffffffc0202486:	04b2                	slli	s1,s1,0xc
ffffffffc0202488:	02071993          	slli	s3,a4,0x20
ffffffffc020248c:	8a2a                	mv	s4,a0
ffffffffc020248e:	842e                	mv	s0,a1
ffffffffc0202490:	94ae                	add	s1,s1,a1
ffffffffc0202492:	40b68933          	sub	s2,a3,a1
ffffffffc0202496:	0209d993          	srli	s3,s3,0x20
ffffffffc020249a:	6a85                	lui	s5,0x1
ffffffffc020249c:	4605                	li	a2,1
ffffffffc020249e:	85a2                	mv	a1,s0
ffffffffc02024a0:	8552                	mv	a0,s4
ffffffffc02024a2:	d83ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02024a6:	008907b3          	add	a5,s2,s0
ffffffffc02024aa:	c505                	beqz	a0,ffffffffc02024d2 <boot_map_segment+0x86>
ffffffffc02024ac:	83b1                	srli	a5,a5,0xc
ffffffffc02024ae:	07aa                	slli	a5,a5,0xa
ffffffffc02024b0:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b4:	0017e793          	ori	a5,a5,1
ffffffffc02024b8:	e11c                	sd	a5,0(a0)
ffffffffc02024ba:	9456                	add	s0,s0,s5
ffffffffc02024bc:	fe8490e3          	bne	s1,s0,ffffffffc020249c <boot_map_segment+0x50>
ffffffffc02024c0:	70e2                	ld	ra,56(sp)
ffffffffc02024c2:	7442                	ld	s0,48(sp)
ffffffffc02024c4:	74a2                	ld	s1,40(sp)
ffffffffc02024c6:	7902                	ld	s2,32(sp)
ffffffffc02024c8:	69e2                	ld	s3,24(sp)
ffffffffc02024ca:	6a42                	ld	s4,16(sp)
ffffffffc02024cc:	6aa2                	ld	s5,8(sp)
ffffffffc02024ce:	6121                	addi	sp,sp,64
ffffffffc02024d0:	8082                	ret
ffffffffc02024d2:	0000a697          	auipc	a3,0xa
ffffffffc02024d6:	ec668693          	addi	a3,a3,-314 # ffffffffc020c398 <default_pmm_manager+0x178>
ffffffffc02024da:	00009617          	auipc	a2,0x9
ffffffffc02024de:	25e60613          	addi	a2,a2,606 # ffffffffc020b738 <commands+0x210>
ffffffffc02024e2:	09c00593          	li	a1,156
ffffffffc02024e6:	0000a517          	auipc	a0,0xa
ffffffffc02024ea:	e8a50513          	addi	a0,a0,-374 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02024ee:	fb1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f2:	0000a697          	auipc	a3,0xa
ffffffffc02024f6:	e8e68693          	addi	a3,a3,-370 # ffffffffc020c380 <default_pmm_manager+0x160>
ffffffffc02024fa:	00009617          	auipc	a2,0x9
ffffffffc02024fe:	23e60613          	addi	a2,a2,574 # ffffffffc020b738 <commands+0x210>
ffffffffc0202502:	09500593          	li	a1,149
ffffffffc0202506:	0000a517          	auipc	a0,0xa
ffffffffc020250a:	e6a50513          	addi	a0,a0,-406 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020250e:	f91fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202512 <get_page>:
ffffffffc0202512:	1141                	addi	sp,sp,-16
ffffffffc0202514:	e022                	sd	s0,0(sp)
ffffffffc0202516:	8432                	mv	s0,a2
ffffffffc0202518:	4601                	li	a2,0
ffffffffc020251a:	e406                	sd	ra,8(sp)
ffffffffc020251c:	d09ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202520:	c011                	beqz	s0,ffffffffc0202524 <get_page+0x12>
ffffffffc0202522:	e008                	sd	a0,0(s0)
ffffffffc0202524:	c511                	beqz	a0,ffffffffc0202530 <get_page+0x1e>
ffffffffc0202526:	611c                	ld	a5,0(a0)
ffffffffc0202528:	4501                	li	a0,0
ffffffffc020252a:	0017f713          	andi	a4,a5,1
ffffffffc020252e:	e709                	bnez	a4,ffffffffc0202538 <get_page+0x26>
ffffffffc0202530:	60a2                	ld	ra,8(sp)
ffffffffc0202532:	6402                	ld	s0,0(sp)
ffffffffc0202534:	0141                	addi	sp,sp,16
ffffffffc0202536:	8082                	ret
ffffffffc0202538:	078a                	slli	a5,a5,0x2
ffffffffc020253a:	83b1                	srli	a5,a5,0xc
ffffffffc020253c:	00094717          	auipc	a4,0x94
ffffffffc0202540:	36473703          	ld	a4,868(a4) # ffffffffc02968a0 <npage>
ffffffffc0202544:	00e7ff63          	bgeu	a5,a4,ffffffffc0202562 <get_page+0x50>
ffffffffc0202548:	60a2                	ld	ra,8(sp)
ffffffffc020254a:	6402                	ld	s0,0(sp)
ffffffffc020254c:	fff80537          	lui	a0,0xfff80
ffffffffc0202550:	97aa                	add	a5,a5,a0
ffffffffc0202552:	079a                	slli	a5,a5,0x6
ffffffffc0202554:	00094517          	auipc	a0,0x94
ffffffffc0202558:	35453503          	ld	a0,852(a0) # ffffffffc02968a8 <pages>
ffffffffc020255c:	953e                	add	a0,a0,a5
ffffffffc020255e:	0141                	addi	sp,sp,16
ffffffffc0202560:	8082                	ret
ffffffffc0202562:	bd3ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202566 <unmap_range>:
ffffffffc0202566:	7159                	addi	sp,sp,-112
ffffffffc0202568:	00c5e7b3          	or	a5,a1,a2
ffffffffc020256c:	f486                	sd	ra,104(sp)
ffffffffc020256e:	f0a2                	sd	s0,96(sp)
ffffffffc0202570:	eca6                	sd	s1,88(sp)
ffffffffc0202572:	e8ca                	sd	s2,80(sp)
ffffffffc0202574:	e4ce                	sd	s3,72(sp)
ffffffffc0202576:	e0d2                	sd	s4,64(sp)
ffffffffc0202578:	fc56                	sd	s5,56(sp)
ffffffffc020257a:	f85a                	sd	s6,48(sp)
ffffffffc020257c:	f45e                	sd	s7,40(sp)
ffffffffc020257e:	f062                	sd	s8,32(sp)
ffffffffc0202580:	ec66                	sd	s9,24(sp)
ffffffffc0202582:	e86a                	sd	s10,16(sp)
ffffffffc0202584:	17d2                	slli	a5,a5,0x34
ffffffffc0202586:	e3ed                	bnez	a5,ffffffffc0202668 <unmap_range+0x102>
ffffffffc0202588:	002007b7          	lui	a5,0x200
ffffffffc020258c:	842e                	mv	s0,a1
ffffffffc020258e:	0ef5ed63          	bltu	a1,a5,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202592:	8932                	mv	s2,a2
ffffffffc0202594:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202598:	4785                	li	a5,1
ffffffffc020259a:	07fe                	slli	a5,a5,0x1f
ffffffffc020259c:	0ec7e663          	bltu	a5,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc02025a0:	89aa                	mv	s3,a0
ffffffffc02025a2:	6a05                	lui	s4,0x1
ffffffffc02025a4:	00094c97          	auipc	s9,0x94
ffffffffc02025a8:	2fcc8c93          	addi	s9,s9,764 # ffffffffc02968a0 <npage>
ffffffffc02025ac:	00094c17          	auipc	s8,0x94
ffffffffc02025b0:	2fcc0c13          	addi	s8,s8,764 # ffffffffc02968a8 <pages>
ffffffffc02025b4:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025b8:	00094d17          	auipc	s10,0x94
ffffffffc02025bc:	2f8d0d13          	addi	s10,s10,760 # ffffffffc02968b0 <pmm_manager>
ffffffffc02025c0:	00200b37          	lui	s6,0x200
ffffffffc02025c4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025c8:	4601                	li	a2,0
ffffffffc02025ca:	85a2                	mv	a1,s0
ffffffffc02025cc:	854e                	mv	a0,s3
ffffffffc02025ce:	c57ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02025d2:	84aa                	mv	s1,a0
ffffffffc02025d4:	cd29                	beqz	a0,ffffffffc020262e <unmap_range+0xc8>
ffffffffc02025d6:	611c                	ld	a5,0(a0)
ffffffffc02025d8:	e395                	bnez	a5,ffffffffc02025fc <unmap_range+0x96>
ffffffffc02025da:	9452                	add	s0,s0,s4
ffffffffc02025dc:	ff2466e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc02025e0:	70a6                	ld	ra,104(sp)
ffffffffc02025e2:	7406                	ld	s0,96(sp)
ffffffffc02025e4:	64e6                	ld	s1,88(sp)
ffffffffc02025e6:	6946                	ld	s2,80(sp)
ffffffffc02025e8:	69a6                	ld	s3,72(sp)
ffffffffc02025ea:	6a06                	ld	s4,64(sp)
ffffffffc02025ec:	7ae2                	ld	s5,56(sp)
ffffffffc02025ee:	7b42                	ld	s6,48(sp)
ffffffffc02025f0:	7ba2                	ld	s7,40(sp)
ffffffffc02025f2:	7c02                	ld	s8,32(sp)
ffffffffc02025f4:	6ce2                	ld	s9,24(sp)
ffffffffc02025f6:	6d42                	ld	s10,16(sp)
ffffffffc02025f8:	6165                	addi	sp,sp,112
ffffffffc02025fa:	8082                	ret
ffffffffc02025fc:	0017f713          	andi	a4,a5,1
ffffffffc0202600:	df69                	beqz	a4,ffffffffc02025da <unmap_range+0x74>
ffffffffc0202602:	000cb703          	ld	a4,0(s9)
ffffffffc0202606:	078a                	slli	a5,a5,0x2
ffffffffc0202608:	83b1                	srli	a5,a5,0xc
ffffffffc020260a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026a8 <unmap_range+0x142>
ffffffffc020260e:	000c3503          	ld	a0,0(s8)
ffffffffc0202612:	97de                	add	a5,a5,s7
ffffffffc0202614:	079a                	slli	a5,a5,0x6
ffffffffc0202616:	953e                	add	a0,a0,a5
ffffffffc0202618:	411c                	lw	a5,0(a0)
ffffffffc020261a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020261e:	c118                	sw	a4,0(a0)
ffffffffc0202620:	cf11                	beqz	a4,ffffffffc020263c <unmap_range+0xd6>
ffffffffc0202622:	0004b023          	sd	zero,0(s1)
ffffffffc0202626:	12040073          	sfence.vma	s0
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	bf45                	j	ffffffffc02025dc <unmap_range+0x76>
ffffffffc020262e:	945a                	add	s0,s0,s6
ffffffffc0202630:	01547433          	and	s0,s0,s5
ffffffffc0202634:	d455                	beqz	s0,ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc0202636:	f92469e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc020263a:	b75d                	j	ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc020263c:	100027f3          	csrr	a5,sstatus
ffffffffc0202640:	8b89                	andi	a5,a5,2
ffffffffc0202642:	e799                	bnez	a5,ffffffffc0202650 <unmap_range+0xea>
ffffffffc0202644:	000d3783          	ld	a5,0(s10)
ffffffffc0202648:	4585                	li	a1,1
ffffffffc020264a:	739c                	ld	a5,32(a5)
ffffffffc020264c:	9782                	jalr	a5
ffffffffc020264e:	bfd1                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202650:	e42a                	sd	a0,8(sp)
ffffffffc0202652:	e20fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202656:	000d3783          	ld	a5,0(s10)
ffffffffc020265a:	6522                	ld	a0,8(sp)
ffffffffc020265c:	4585                	li	a1,1
ffffffffc020265e:	739c                	ld	a5,32(a5)
ffffffffc0202660:	9782                	jalr	a5
ffffffffc0202662:	e0afe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202666:	bf75                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202668:	0000a697          	auipc	a3,0xa
ffffffffc020266c:	d4068693          	addi	a3,a3,-704 # ffffffffc020c3a8 <default_pmm_manager+0x188>
ffffffffc0202670:	00009617          	auipc	a2,0x9
ffffffffc0202674:	0c860613          	addi	a2,a2,200 # ffffffffc020b738 <commands+0x210>
ffffffffc0202678:	15a00593          	li	a1,346
ffffffffc020267c:	0000a517          	auipc	a0,0xa
ffffffffc0202680:	cf450513          	addi	a0,a0,-780 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0202684:	e1bfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202688:	0000a697          	auipc	a3,0xa
ffffffffc020268c:	d5068693          	addi	a3,a3,-688 # ffffffffc020c3d8 <default_pmm_manager+0x1b8>
ffffffffc0202690:	00009617          	auipc	a2,0x9
ffffffffc0202694:	0a860613          	addi	a2,a2,168 # ffffffffc020b738 <commands+0x210>
ffffffffc0202698:	15b00593          	li	a1,347
ffffffffc020269c:	0000a517          	auipc	a0,0xa
ffffffffc02026a0:	cd450513          	addi	a0,a0,-812 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02026a4:	dfbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026a8:	a8dff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02026ac <exit_range>:
ffffffffc02026ac:	7119                	addi	sp,sp,-128
ffffffffc02026ae:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b2:	fc86                	sd	ra,120(sp)
ffffffffc02026b4:	f8a2                	sd	s0,112(sp)
ffffffffc02026b6:	f4a6                	sd	s1,104(sp)
ffffffffc02026b8:	f0ca                	sd	s2,96(sp)
ffffffffc02026ba:	ecce                	sd	s3,88(sp)
ffffffffc02026bc:	e8d2                	sd	s4,80(sp)
ffffffffc02026be:	e4d6                	sd	s5,72(sp)
ffffffffc02026c0:	e0da                	sd	s6,64(sp)
ffffffffc02026c2:	fc5e                	sd	s7,56(sp)
ffffffffc02026c4:	f862                	sd	s8,48(sp)
ffffffffc02026c6:	f466                	sd	s9,40(sp)
ffffffffc02026c8:	f06a                	sd	s10,32(sp)
ffffffffc02026ca:	ec6e                	sd	s11,24(sp)
ffffffffc02026cc:	17d2                	slli	a5,a5,0x34
ffffffffc02026ce:	20079a63          	bnez	a5,ffffffffc02028e2 <exit_range+0x236>
ffffffffc02026d2:	002007b7          	lui	a5,0x200
ffffffffc02026d6:	24f5e463          	bltu	a1,a5,ffffffffc020291e <exit_range+0x272>
ffffffffc02026da:	8ab2                	mv	s5,a2
ffffffffc02026dc:	24c5f163          	bgeu	a1,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e0:	4785                	li	a5,1
ffffffffc02026e2:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e4:	22c7ed63          	bltu	a5,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e8:	c00009b7          	lui	s3,0xc0000
ffffffffc02026ec:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f0:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f4:	400007b7          	lui	a5,0x40000
ffffffffc02026f8:	5cfd                	li	s9,-1
ffffffffc02026fa:	8c2a                	mv	s8,a0
ffffffffc02026fc:	0125f933          	and	s2,a1,s2
ffffffffc0202700:	99be                	add	s3,s3,a5
ffffffffc0202702:	00094d17          	auipc	s10,0x94
ffffffffc0202706:	19ed0d13          	addi	s10,s10,414 # ffffffffc02968a0 <npage>
ffffffffc020270a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020270e:	00094717          	auipc	a4,0x94
ffffffffc0202712:	19a70713          	addi	a4,a4,410 # ffffffffc02968a8 <pages>
ffffffffc0202716:	00094d97          	auipc	s11,0x94
ffffffffc020271a:	19ad8d93          	addi	s11,s11,410 # ffffffffc02968b0 <pmm_manager>
ffffffffc020271e:	c0000437          	lui	s0,0xc0000
ffffffffc0202722:	944e                	add	s0,s0,s3
ffffffffc0202724:	8079                	srli	s0,s0,0x1e
ffffffffc0202726:	1ff47413          	andi	s0,s0,511
ffffffffc020272a:	040e                	slli	s0,s0,0x3
ffffffffc020272c:	9462                	add	s0,s0,s8
ffffffffc020272e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202732:	001a7793          	andi	a5,s4,1
ffffffffc0202736:	eb99                	bnez	a5,ffffffffc020274c <exit_range+0xa0>
ffffffffc0202738:	12098463          	beqz	s3,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc020273c:	400007b7          	lui	a5,0x40000
ffffffffc0202740:	97ce                	add	a5,a5,s3
ffffffffc0202742:	894e                	mv	s2,s3
ffffffffc0202744:	1159fe63          	bgeu	s3,s5,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc0202748:	89be                	mv	s3,a5
ffffffffc020274a:	bfd1                	j	ffffffffc020271e <exit_range+0x72>
ffffffffc020274c:	000d3783          	ld	a5,0(s10)
ffffffffc0202750:	0a0a                	slli	s4,s4,0x2
ffffffffc0202752:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202756:	1cfa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020275a:	fff80637          	lui	a2,0xfff80
ffffffffc020275e:	9652                	add	a2,a2,s4
ffffffffc0202760:	000806b7          	lui	a3,0x80
ffffffffc0202764:	96b2                	add	a3,a3,a2
ffffffffc0202766:	0196f5b3          	and	a1,a3,s9
ffffffffc020276a:	061a                	slli	a2,a2,0x6
ffffffffc020276c:	06b2                	slli	a3,a3,0xc
ffffffffc020276e:	18f5fa63          	bgeu	a1,a5,ffffffffc0202902 <exit_range+0x256>
ffffffffc0202772:	00094817          	auipc	a6,0x94
ffffffffc0202776:	14680813          	addi	a6,a6,326 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020277a:	00083b03          	ld	s6,0(a6)
ffffffffc020277e:	4b85                	li	s7,1
ffffffffc0202780:	fff80e37          	lui	t3,0xfff80
ffffffffc0202784:	9b36                	add	s6,s6,a3
ffffffffc0202786:	00080337          	lui	t1,0x80
ffffffffc020278a:	6885                	lui	a7,0x1
ffffffffc020278c:	a819                	j	ffffffffc02027a2 <exit_range+0xf6>
ffffffffc020278e:	4b81                	li	s7,0
ffffffffc0202790:	002007b7          	lui	a5,0x200
ffffffffc0202794:	993e                	add	s2,s2,a5
ffffffffc0202796:	08090c63          	beqz	s2,ffffffffc020282e <exit_range+0x182>
ffffffffc020279a:	09397a63          	bgeu	s2,s3,ffffffffc020282e <exit_range+0x182>
ffffffffc020279e:	0f597063          	bgeu	s2,s5,ffffffffc020287e <exit_range+0x1d2>
ffffffffc02027a2:	01595493          	srli	s1,s2,0x15
ffffffffc02027a6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027aa:	048e                	slli	s1,s1,0x3
ffffffffc02027ac:	94da                	add	s1,s1,s6
ffffffffc02027ae:	609c                	ld	a5,0(s1)
ffffffffc02027b0:	0017f693          	andi	a3,a5,1
ffffffffc02027b4:	dee9                	beqz	a3,ffffffffc020278e <exit_range+0xe2>
ffffffffc02027b6:	000d3583          	ld	a1,0(s10)
ffffffffc02027ba:	078a                	slli	a5,a5,0x2
ffffffffc02027bc:	83b1                	srli	a5,a5,0xc
ffffffffc02027be:	14b7fe63          	bgeu	a5,a1,ffffffffc020291a <exit_range+0x26e>
ffffffffc02027c2:	97f2                	add	a5,a5,t3
ffffffffc02027c4:	006786b3          	add	a3,a5,t1
ffffffffc02027c8:	0196feb3          	and	t4,a3,s9
ffffffffc02027cc:	00679513          	slli	a0,a5,0x6
ffffffffc02027d0:	06b2                	slli	a3,a3,0xc
ffffffffc02027d2:	12bef863          	bgeu	t4,a1,ffffffffc0202902 <exit_range+0x256>
ffffffffc02027d6:	00083783          	ld	a5,0(a6)
ffffffffc02027da:	96be                	add	a3,a3,a5
ffffffffc02027dc:	011685b3          	add	a1,a3,a7
ffffffffc02027e0:	629c                	ld	a5,0(a3)
ffffffffc02027e2:	8b85                	andi	a5,a5,1
ffffffffc02027e4:	f7d5                	bnez	a5,ffffffffc0202790 <exit_range+0xe4>
ffffffffc02027e6:	06a1                	addi	a3,a3,8
ffffffffc02027e8:	fed59ce3          	bne	a1,a3,ffffffffc02027e0 <exit_range+0x134>
ffffffffc02027ec:	631c                	ld	a5,0(a4)
ffffffffc02027ee:	953e                	add	a0,a0,a5
ffffffffc02027f0:	100027f3          	csrr	a5,sstatus
ffffffffc02027f4:	8b89                	andi	a5,a5,2
ffffffffc02027f6:	e7d9                	bnez	a5,ffffffffc0202884 <exit_range+0x1d8>
ffffffffc02027f8:	000db783          	ld	a5,0(s11)
ffffffffc02027fc:	4585                	li	a1,1
ffffffffc02027fe:	e032                	sd	a2,0(sp)
ffffffffc0202800:	739c                	ld	a5,32(a5)
ffffffffc0202802:	9782                	jalr	a5
ffffffffc0202804:	6602                	ld	a2,0(sp)
ffffffffc0202806:	00094817          	auipc	a6,0x94
ffffffffc020280a:	0b280813          	addi	a6,a6,178 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020280e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202812:	00080337          	lui	t1,0x80
ffffffffc0202816:	6885                	lui	a7,0x1
ffffffffc0202818:	00094717          	auipc	a4,0x94
ffffffffc020281c:	09070713          	addi	a4,a4,144 # ffffffffc02968a8 <pages>
ffffffffc0202820:	0004b023          	sd	zero,0(s1)
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	f60918e3          	bnez	s2,ffffffffc020279a <exit_range+0xee>
ffffffffc020282e:	f00b85e3          	beqz	s7,ffffffffc0202738 <exit_range+0x8c>
ffffffffc0202832:	000d3783          	ld	a5,0(s10)
ffffffffc0202836:	0efa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020283a:	6308                	ld	a0,0(a4)
ffffffffc020283c:	9532                	add	a0,a0,a2
ffffffffc020283e:	100027f3          	csrr	a5,sstatus
ffffffffc0202842:	8b89                	andi	a5,a5,2
ffffffffc0202844:	efad                	bnez	a5,ffffffffc02028be <exit_range+0x212>
ffffffffc0202846:	000db783          	ld	a5,0(s11)
ffffffffc020284a:	4585                	li	a1,1
ffffffffc020284c:	739c                	ld	a5,32(a5)
ffffffffc020284e:	9782                	jalr	a5
ffffffffc0202850:	00094717          	auipc	a4,0x94
ffffffffc0202854:	05870713          	addi	a4,a4,88 # ffffffffc02968a8 <pages>
ffffffffc0202858:	00043023          	sd	zero,0(s0)
ffffffffc020285c:	ee0990e3          	bnez	s3,ffffffffc020273c <exit_range+0x90>
ffffffffc0202860:	70e6                	ld	ra,120(sp)
ffffffffc0202862:	7446                	ld	s0,112(sp)
ffffffffc0202864:	74a6                	ld	s1,104(sp)
ffffffffc0202866:	7906                	ld	s2,96(sp)
ffffffffc0202868:	69e6                	ld	s3,88(sp)
ffffffffc020286a:	6a46                	ld	s4,80(sp)
ffffffffc020286c:	6aa6                	ld	s5,72(sp)
ffffffffc020286e:	6b06                	ld	s6,64(sp)
ffffffffc0202870:	7be2                	ld	s7,56(sp)
ffffffffc0202872:	7c42                	ld	s8,48(sp)
ffffffffc0202874:	7ca2                	ld	s9,40(sp)
ffffffffc0202876:	7d02                	ld	s10,32(sp)
ffffffffc0202878:	6de2                	ld	s11,24(sp)
ffffffffc020287a:	6109                	addi	sp,sp,128
ffffffffc020287c:	8082                	ret
ffffffffc020287e:	ea0b8fe3          	beqz	s7,ffffffffc020273c <exit_range+0x90>
ffffffffc0202882:	bf45                	j	ffffffffc0202832 <exit_range+0x186>
ffffffffc0202884:	e032                	sd	a2,0(sp)
ffffffffc0202886:	e42a                	sd	a0,8(sp)
ffffffffc0202888:	beafe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	6522                	ld	a0,8(sp)
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	bd4fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020289c:	6602                	ld	a2,0(sp)
ffffffffc020289e:	00094717          	auipc	a4,0x94
ffffffffc02028a2:	00a70713          	addi	a4,a4,10 # ffffffffc02968a8 <pages>
ffffffffc02028a6:	6885                	lui	a7,0x1
ffffffffc02028a8:	00080337          	lui	t1,0x80
ffffffffc02028ac:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b0:	00094817          	auipc	a6,0x94
ffffffffc02028b4:	00880813          	addi	a6,a6,8 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02028b8:	0004b023          	sd	zero,0(s1)
ffffffffc02028bc:	b7a5                	j	ffffffffc0202824 <exit_range+0x178>
ffffffffc02028be:	e02a                	sd	a0,0(sp)
ffffffffc02028c0:	bb2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c4:	000db783          	ld	a5,0(s11)
ffffffffc02028c8:	6502                	ld	a0,0(sp)
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	739c                	ld	a5,32(a5)
ffffffffc02028ce:	9782                	jalr	a5
ffffffffc02028d0:	b9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d4:	00094717          	auipc	a4,0x94
ffffffffc02028d8:	fd470713          	addi	a4,a4,-44 # ffffffffc02968a8 <pages>
ffffffffc02028dc:	00043023          	sd	zero,0(s0)
ffffffffc02028e0:	bfb5                	j	ffffffffc020285c <exit_range+0x1b0>
ffffffffc02028e2:	0000a697          	auipc	a3,0xa
ffffffffc02028e6:	ac668693          	addi	a3,a3,-1338 # ffffffffc020c3a8 <default_pmm_manager+0x188>
ffffffffc02028ea:	00009617          	auipc	a2,0x9
ffffffffc02028ee:	e4e60613          	addi	a2,a2,-434 # ffffffffc020b738 <commands+0x210>
ffffffffc02028f2:	16f00593          	li	a1,367
ffffffffc02028f6:	0000a517          	auipc	a0,0xa
ffffffffc02028fa:	a7a50513          	addi	a0,a0,-1414 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02028fe:	ba1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202902:	0000a617          	auipc	a2,0xa
ffffffffc0202906:	95660613          	addi	a2,a2,-1706 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc020290a:	07100593          	li	a1,113
ffffffffc020290e:	0000a517          	auipc	a0,0xa
ffffffffc0202912:	97250513          	addi	a0,a0,-1678 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0202916:	b89fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291a:	81bff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc020291e:	0000a697          	auipc	a3,0xa
ffffffffc0202922:	aba68693          	addi	a3,a3,-1350 # ffffffffc020c3d8 <default_pmm_manager+0x1b8>
ffffffffc0202926:	00009617          	auipc	a2,0x9
ffffffffc020292a:	e1260613          	addi	a2,a2,-494 # ffffffffc020b738 <commands+0x210>
ffffffffc020292e:	17000593          	li	a1,368
ffffffffc0202932:	0000a517          	auipc	a0,0xa
ffffffffc0202936:	a3e50513          	addi	a0,a0,-1474 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020293a:	b65fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020293e <copy_range>:
ffffffffc020293e:	7119                	addi	sp,sp,-128
ffffffffc0202940:	00d667b3          	or	a5,a2,a3
ffffffffc0202944:	fc86                	sd	ra,120(sp)
ffffffffc0202946:	f8a2                	sd	s0,112(sp)
ffffffffc0202948:	f4a6                	sd	s1,104(sp)
ffffffffc020294a:	f0ca                	sd	s2,96(sp)
ffffffffc020294c:	ecce                	sd	s3,88(sp)
ffffffffc020294e:	e8d2                	sd	s4,80(sp)
ffffffffc0202950:	e4d6                	sd	s5,72(sp)
ffffffffc0202952:	e0da                	sd	s6,64(sp)
ffffffffc0202954:	fc5e                	sd	s7,56(sp)
ffffffffc0202956:	f862                	sd	s8,48(sp)
ffffffffc0202958:	f466                	sd	s9,40(sp)
ffffffffc020295a:	f06a                	sd	s10,32(sp)
ffffffffc020295c:	ec6e                	sd	s11,24(sp)
ffffffffc020295e:	17d2                	slli	a5,a5,0x34
ffffffffc0202960:	16079e63          	bnez	a5,ffffffffc0202adc <copy_range+0x19e>
ffffffffc0202964:	002007b7          	lui	a5,0x200
ffffffffc0202968:	8db2                	mv	s11,a2
ffffffffc020296a:	12f66d63          	bltu	a2,a5,ffffffffc0202aa4 <copy_range+0x166>
ffffffffc020296e:	84b6                	mv	s1,a3
ffffffffc0202970:	12d67a63          	bgeu	a2,a3,ffffffffc0202aa4 <copy_range+0x166>
ffffffffc0202974:	4785                	li	a5,1
ffffffffc0202976:	07fe                	slli	a5,a5,0x1f
ffffffffc0202978:	12d7e663          	bltu	a5,a3,ffffffffc0202aa4 <copy_range+0x166>
ffffffffc020297c:	8a2a                	mv	s4,a0
ffffffffc020297e:	892e                	mv	s2,a1
ffffffffc0202980:	6985                	lui	s3,0x1
ffffffffc0202982:	00094c17          	auipc	s8,0x94
ffffffffc0202986:	f1ec0c13          	addi	s8,s8,-226 # ffffffffc02968a0 <npage>
ffffffffc020298a:	00094b97          	auipc	s7,0x94
ffffffffc020298e:	f1eb8b93          	addi	s7,s7,-226 # ffffffffc02968a8 <pages>
ffffffffc0202992:	fff80b37          	lui	s6,0xfff80
ffffffffc0202996:	00094a97          	auipc	s5,0x94
ffffffffc020299a:	f1aa8a93          	addi	s5,s5,-230 # ffffffffc02968b0 <pmm_manager>
ffffffffc020299e:	00200d37          	lui	s10,0x200
ffffffffc02029a2:	ffe00cb7          	lui	s9,0xffe00
ffffffffc02029a6:	4601                	li	a2,0
ffffffffc02029a8:	85ee                	mv	a1,s11
ffffffffc02029aa:	854a                	mv	a0,s2
ffffffffc02029ac:	879ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029b0:	842a                	mv	s0,a0
ffffffffc02029b2:	c559                	beqz	a0,ffffffffc0202a40 <copy_range+0x102>
ffffffffc02029b4:	611c                	ld	a5,0(a0)
ffffffffc02029b6:	8b85                	andi	a5,a5,1
ffffffffc02029b8:	e785                	bnez	a5,ffffffffc02029e0 <copy_range+0xa2>
ffffffffc02029ba:	9dce                	add	s11,s11,s3
ffffffffc02029bc:	fe9de5e3          	bltu	s11,s1,ffffffffc02029a6 <copy_range+0x68>
ffffffffc02029c0:	4501                	li	a0,0
ffffffffc02029c2:	70e6                	ld	ra,120(sp)
ffffffffc02029c4:	7446                	ld	s0,112(sp)
ffffffffc02029c6:	74a6                	ld	s1,104(sp)
ffffffffc02029c8:	7906                	ld	s2,96(sp)
ffffffffc02029ca:	69e6                	ld	s3,88(sp)
ffffffffc02029cc:	6a46                	ld	s4,80(sp)
ffffffffc02029ce:	6aa6                	ld	s5,72(sp)
ffffffffc02029d0:	6b06                	ld	s6,64(sp)
ffffffffc02029d2:	7be2                	ld	s7,56(sp)
ffffffffc02029d4:	7c42                	ld	s8,48(sp)
ffffffffc02029d6:	7ca2                	ld	s9,40(sp)
ffffffffc02029d8:	7d02                	ld	s10,32(sp)
ffffffffc02029da:	6de2                	ld	s11,24(sp)
ffffffffc02029dc:	6109                	addi	sp,sp,128
ffffffffc02029de:	8082                	ret
ffffffffc02029e0:	4605                	li	a2,1
ffffffffc02029e2:	85ee                	mv	a1,s11
ffffffffc02029e4:	8552                	mv	a0,s4
ffffffffc02029e6:	83fff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029ea:	cd3d                	beqz	a0,ffffffffc0202a68 <copy_range+0x12a>
ffffffffc02029ec:	601c                	ld	a5,0(s0)
ffffffffc02029ee:	0017f713          	andi	a4,a5,1
ffffffffc02029f2:	cb69                	beqz	a4,ffffffffc0202ac4 <copy_range+0x186>
ffffffffc02029f4:	000c3703          	ld	a4,0(s8)
ffffffffc02029f8:	078a                	slli	a5,a5,0x2
ffffffffc02029fa:	83b1                	srli	a5,a5,0xc
ffffffffc02029fc:	08e7f863          	bgeu	a5,a4,ffffffffc0202a8c <copy_range+0x14e>
ffffffffc0202a00:	000bb403          	ld	s0,0(s7)
ffffffffc0202a04:	97da                	add	a5,a5,s6
ffffffffc0202a06:	079a                	slli	a5,a5,0x6
ffffffffc0202a08:	943e                	add	s0,s0,a5
ffffffffc0202a0a:	100027f3          	csrr	a5,sstatus
ffffffffc0202a0e:	8b89                	andi	a5,a5,2
ffffffffc0202a10:	e3a1                	bnez	a5,ffffffffc0202a50 <copy_range+0x112>
ffffffffc0202a12:	000ab783          	ld	a5,0(s5)
ffffffffc0202a16:	4505                	li	a0,1
ffffffffc0202a18:	6f9c                	ld	a5,24(a5)
ffffffffc0202a1a:	9782                	jalr	a5
ffffffffc0202a1c:	c821                	beqz	s0,ffffffffc0202a6c <copy_range+0x12e>
ffffffffc0202a1e:	fd51                	bnez	a0,ffffffffc02029ba <copy_range+0x7c>
ffffffffc0202a20:	0000a697          	auipc	a3,0xa
ffffffffc0202a24:	9e068693          	addi	a3,a3,-1568 # ffffffffc020c400 <default_pmm_manager+0x1e0>
ffffffffc0202a28:	00009617          	auipc	a2,0x9
ffffffffc0202a2c:	d1060613          	addi	a2,a2,-752 # ffffffffc020b738 <commands+0x210>
ffffffffc0202a30:	1cf00593          	li	a1,463
ffffffffc0202a34:	0000a517          	auipc	a0,0xa
ffffffffc0202a38:	93c50513          	addi	a0,a0,-1732 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0202a3c:	a63fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202a40:	9dea                	add	s11,s11,s10
ffffffffc0202a42:	019dfdb3          	and	s11,s11,s9
ffffffffc0202a46:	f60d8de3          	beqz	s11,ffffffffc02029c0 <copy_range+0x82>
ffffffffc0202a4a:	f49deee3          	bltu	s11,s1,ffffffffc02029a6 <copy_range+0x68>
ffffffffc0202a4e:	bf8d                	j	ffffffffc02029c0 <copy_range+0x82>
ffffffffc0202a50:	a22fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202a54:	000ab783          	ld	a5,0(s5)
ffffffffc0202a58:	4505                	li	a0,1
ffffffffc0202a5a:	6f9c                	ld	a5,24(a5)
ffffffffc0202a5c:	9782                	jalr	a5
ffffffffc0202a5e:	e42a                	sd	a0,8(sp)
ffffffffc0202a60:	a0cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202a64:	6522                	ld	a0,8(sp)
ffffffffc0202a66:	bf5d                	j	ffffffffc0202a1c <copy_range+0xde>
ffffffffc0202a68:	5571                	li	a0,-4
ffffffffc0202a6a:	bfa1                	j	ffffffffc02029c2 <copy_range+0x84>
ffffffffc0202a6c:	0000a697          	auipc	a3,0xa
ffffffffc0202a70:	98468693          	addi	a3,a3,-1660 # ffffffffc020c3f0 <default_pmm_manager+0x1d0>
ffffffffc0202a74:	00009617          	auipc	a2,0x9
ffffffffc0202a78:	cc460613          	addi	a2,a2,-828 # ffffffffc020b738 <commands+0x210>
ffffffffc0202a7c:	1ce00593          	li	a1,462
ffffffffc0202a80:	0000a517          	auipc	a0,0xa
ffffffffc0202a84:	8f050513          	addi	a0,a0,-1808 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0202a88:	a17fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202a8c:	0000a617          	auipc	a2,0xa
ffffffffc0202a90:	89c60613          	addi	a2,a2,-1892 # ffffffffc020c328 <default_pmm_manager+0x108>
ffffffffc0202a94:	06900593          	li	a1,105
ffffffffc0202a98:	00009517          	auipc	a0,0x9
ffffffffc0202a9c:	7e850513          	addi	a0,a0,2024 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0202aa0:	9fffd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202aa4:	0000a697          	auipc	a3,0xa
ffffffffc0202aa8:	93468693          	addi	a3,a3,-1740 # ffffffffc020c3d8 <default_pmm_manager+0x1b8>
ffffffffc0202aac:	00009617          	auipc	a2,0x9
ffffffffc0202ab0:	c8c60613          	addi	a2,a2,-884 # ffffffffc020b738 <commands+0x210>
ffffffffc0202ab4:	1b600593          	li	a1,438
ffffffffc0202ab8:	0000a517          	auipc	a0,0xa
ffffffffc0202abc:	8b850513          	addi	a0,a0,-1864 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0202ac0:	9dffd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202ac4:	0000a617          	auipc	a2,0xa
ffffffffc0202ac8:	88460613          	addi	a2,a2,-1916 # ffffffffc020c348 <default_pmm_manager+0x128>
ffffffffc0202acc:	07f00593          	li	a1,127
ffffffffc0202ad0:	00009517          	auipc	a0,0x9
ffffffffc0202ad4:	7b050513          	addi	a0,a0,1968 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0202ad8:	9c7fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202adc:	0000a697          	auipc	a3,0xa
ffffffffc0202ae0:	8cc68693          	addi	a3,a3,-1844 # ffffffffc020c3a8 <default_pmm_manager+0x188>
ffffffffc0202ae4:	00009617          	auipc	a2,0x9
ffffffffc0202ae8:	c5460613          	addi	a2,a2,-940 # ffffffffc020b738 <commands+0x210>
ffffffffc0202aec:	1b500593          	li	a1,437
ffffffffc0202af0:	0000a517          	auipc	a0,0xa
ffffffffc0202af4:	88050513          	addi	a0,a0,-1920 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0202af8:	9a7fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202afc <page_remove>:
ffffffffc0202afc:	7179                	addi	sp,sp,-48
ffffffffc0202afe:	4601                	li	a2,0
ffffffffc0202b00:	ec26                	sd	s1,24(sp)
ffffffffc0202b02:	f406                	sd	ra,40(sp)
ffffffffc0202b04:	f022                	sd	s0,32(sp)
ffffffffc0202b06:	84ae                	mv	s1,a1
ffffffffc0202b08:	f1cff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202b0c:	c511                	beqz	a0,ffffffffc0202b18 <page_remove+0x1c>
ffffffffc0202b0e:	611c                	ld	a5,0(a0)
ffffffffc0202b10:	842a                	mv	s0,a0
ffffffffc0202b12:	0017f713          	andi	a4,a5,1
ffffffffc0202b16:	e711                	bnez	a4,ffffffffc0202b22 <page_remove+0x26>
ffffffffc0202b18:	70a2                	ld	ra,40(sp)
ffffffffc0202b1a:	7402                	ld	s0,32(sp)
ffffffffc0202b1c:	64e2                	ld	s1,24(sp)
ffffffffc0202b1e:	6145                	addi	sp,sp,48
ffffffffc0202b20:	8082                	ret
ffffffffc0202b22:	078a                	slli	a5,a5,0x2
ffffffffc0202b24:	83b1                	srli	a5,a5,0xc
ffffffffc0202b26:	00094717          	auipc	a4,0x94
ffffffffc0202b2a:	d7a73703          	ld	a4,-646(a4) # ffffffffc02968a0 <npage>
ffffffffc0202b2e:	06e7f363          	bgeu	a5,a4,ffffffffc0202b94 <page_remove+0x98>
ffffffffc0202b32:	fff80537          	lui	a0,0xfff80
ffffffffc0202b36:	97aa                	add	a5,a5,a0
ffffffffc0202b38:	079a                	slli	a5,a5,0x6
ffffffffc0202b3a:	00094517          	auipc	a0,0x94
ffffffffc0202b3e:	d6e53503          	ld	a0,-658(a0) # ffffffffc02968a8 <pages>
ffffffffc0202b42:	953e                	add	a0,a0,a5
ffffffffc0202b44:	411c                	lw	a5,0(a0)
ffffffffc0202b46:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202b4a:	c118                	sw	a4,0(a0)
ffffffffc0202b4c:	cb11                	beqz	a4,ffffffffc0202b60 <page_remove+0x64>
ffffffffc0202b4e:	00043023          	sd	zero,0(s0)
ffffffffc0202b52:	12048073          	sfence.vma	s1
ffffffffc0202b56:	70a2                	ld	ra,40(sp)
ffffffffc0202b58:	7402                	ld	s0,32(sp)
ffffffffc0202b5a:	64e2                	ld	s1,24(sp)
ffffffffc0202b5c:	6145                	addi	sp,sp,48
ffffffffc0202b5e:	8082                	ret
ffffffffc0202b60:	100027f3          	csrr	a5,sstatus
ffffffffc0202b64:	8b89                	andi	a5,a5,2
ffffffffc0202b66:	eb89                	bnez	a5,ffffffffc0202b78 <page_remove+0x7c>
ffffffffc0202b68:	00094797          	auipc	a5,0x94
ffffffffc0202b6c:	d487b783          	ld	a5,-696(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b70:	739c                	ld	a5,32(a5)
ffffffffc0202b72:	4585                	li	a1,1
ffffffffc0202b74:	9782                	jalr	a5
ffffffffc0202b76:	bfe1                	j	ffffffffc0202b4e <page_remove+0x52>
ffffffffc0202b78:	e42a                	sd	a0,8(sp)
ffffffffc0202b7a:	8f8fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202b7e:	00094797          	auipc	a5,0x94
ffffffffc0202b82:	d327b783          	ld	a5,-718(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b86:	739c                	ld	a5,32(a5)
ffffffffc0202b88:	6522                	ld	a0,8(sp)
ffffffffc0202b8a:	4585                	li	a1,1
ffffffffc0202b8c:	9782                	jalr	a5
ffffffffc0202b8e:	8defe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202b92:	bf75                	j	ffffffffc0202b4e <page_remove+0x52>
ffffffffc0202b94:	da0ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202b98 <page_insert>:
ffffffffc0202b98:	7139                	addi	sp,sp,-64
ffffffffc0202b9a:	e852                	sd	s4,16(sp)
ffffffffc0202b9c:	8a32                	mv	s4,a2
ffffffffc0202b9e:	f822                	sd	s0,48(sp)
ffffffffc0202ba0:	4605                	li	a2,1
ffffffffc0202ba2:	842e                	mv	s0,a1
ffffffffc0202ba4:	85d2                	mv	a1,s4
ffffffffc0202ba6:	f426                	sd	s1,40(sp)
ffffffffc0202ba8:	fc06                	sd	ra,56(sp)
ffffffffc0202baa:	f04a                	sd	s2,32(sp)
ffffffffc0202bac:	ec4e                	sd	s3,24(sp)
ffffffffc0202bae:	e456                	sd	s5,8(sp)
ffffffffc0202bb0:	84b6                	mv	s1,a3
ffffffffc0202bb2:	e72ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202bb6:	c961                	beqz	a0,ffffffffc0202c86 <page_insert+0xee>
ffffffffc0202bb8:	4014                	lw	a3,0(s0)
ffffffffc0202bba:	611c                	ld	a5,0(a0)
ffffffffc0202bbc:	89aa                	mv	s3,a0
ffffffffc0202bbe:	0016871b          	addiw	a4,a3,1
ffffffffc0202bc2:	c018                	sw	a4,0(s0)
ffffffffc0202bc4:	0017f713          	andi	a4,a5,1
ffffffffc0202bc8:	ef05                	bnez	a4,ffffffffc0202c00 <page_insert+0x68>
ffffffffc0202bca:	00094717          	auipc	a4,0x94
ffffffffc0202bce:	cde73703          	ld	a4,-802(a4) # ffffffffc02968a8 <pages>
ffffffffc0202bd2:	8c19                	sub	s0,s0,a4
ffffffffc0202bd4:	000807b7          	lui	a5,0x80
ffffffffc0202bd8:	8419                	srai	s0,s0,0x6
ffffffffc0202bda:	943e                	add	s0,s0,a5
ffffffffc0202bdc:	042a                	slli	s0,s0,0xa
ffffffffc0202bde:	8cc1                	or	s1,s1,s0
ffffffffc0202be0:	0014e493          	ori	s1,s1,1
ffffffffc0202be4:	0099b023          	sd	s1,0(s3) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202be8:	120a0073          	sfence.vma	s4
ffffffffc0202bec:	4501                	li	a0,0
ffffffffc0202bee:	70e2                	ld	ra,56(sp)
ffffffffc0202bf0:	7442                	ld	s0,48(sp)
ffffffffc0202bf2:	74a2                	ld	s1,40(sp)
ffffffffc0202bf4:	7902                	ld	s2,32(sp)
ffffffffc0202bf6:	69e2                	ld	s3,24(sp)
ffffffffc0202bf8:	6a42                	ld	s4,16(sp)
ffffffffc0202bfa:	6aa2                	ld	s5,8(sp)
ffffffffc0202bfc:	6121                	addi	sp,sp,64
ffffffffc0202bfe:	8082                	ret
ffffffffc0202c00:	078a                	slli	a5,a5,0x2
ffffffffc0202c02:	83b1                	srli	a5,a5,0xc
ffffffffc0202c04:	00094717          	auipc	a4,0x94
ffffffffc0202c08:	c9c73703          	ld	a4,-868(a4) # ffffffffc02968a0 <npage>
ffffffffc0202c0c:	06e7ff63          	bgeu	a5,a4,ffffffffc0202c8a <page_insert+0xf2>
ffffffffc0202c10:	00094a97          	auipc	s5,0x94
ffffffffc0202c14:	c98a8a93          	addi	s5,s5,-872 # ffffffffc02968a8 <pages>
ffffffffc0202c18:	000ab703          	ld	a4,0(s5)
ffffffffc0202c1c:	fff80937          	lui	s2,0xfff80
ffffffffc0202c20:	993e                	add	s2,s2,a5
ffffffffc0202c22:	091a                	slli	s2,s2,0x6
ffffffffc0202c24:	993a                	add	s2,s2,a4
ffffffffc0202c26:	01240c63          	beq	s0,s2,ffffffffc0202c3e <page_insert+0xa6>
ffffffffc0202c2a:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202c2e:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202c32:	00d92023          	sw	a3,0(s2)
ffffffffc0202c36:	c691                	beqz	a3,ffffffffc0202c42 <page_insert+0xaa>
ffffffffc0202c38:	120a0073          	sfence.vma	s4
ffffffffc0202c3c:	bf59                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c3e:	c014                	sw	a3,0(s0)
ffffffffc0202c40:	bf49                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c42:	100027f3          	csrr	a5,sstatus
ffffffffc0202c46:	8b89                	andi	a5,a5,2
ffffffffc0202c48:	ef91                	bnez	a5,ffffffffc0202c64 <page_insert+0xcc>
ffffffffc0202c4a:	00094797          	auipc	a5,0x94
ffffffffc0202c4e:	c667b783          	ld	a5,-922(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202c52:	739c                	ld	a5,32(a5)
ffffffffc0202c54:	4585                	li	a1,1
ffffffffc0202c56:	854a                	mv	a0,s2
ffffffffc0202c58:	9782                	jalr	a5
ffffffffc0202c5a:	000ab703          	ld	a4,0(s5)
ffffffffc0202c5e:	120a0073          	sfence.vma	s4
ffffffffc0202c62:	bf85                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c64:	80efe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202c68:	00094797          	auipc	a5,0x94
ffffffffc0202c6c:	c487b783          	ld	a5,-952(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202c70:	739c                	ld	a5,32(a5)
ffffffffc0202c72:	4585                	li	a1,1
ffffffffc0202c74:	854a                	mv	a0,s2
ffffffffc0202c76:	9782                	jalr	a5
ffffffffc0202c78:	ff5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202c7c:	000ab703          	ld	a4,0(s5)
ffffffffc0202c80:	120a0073          	sfence.vma	s4
ffffffffc0202c84:	b7b9                	j	ffffffffc0202bd2 <page_insert+0x3a>
ffffffffc0202c86:	5571                	li	a0,-4
ffffffffc0202c88:	b79d                	j	ffffffffc0202bee <page_insert+0x56>
ffffffffc0202c8a:	caaff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202c8e <pmm_init>:
ffffffffc0202c8e:	00009797          	auipc	a5,0x9
ffffffffc0202c92:	59278793          	addi	a5,a5,1426 # ffffffffc020c220 <default_pmm_manager>
ffffffffc0202c96:	638c                	ld	a1,0(a5)
ffffffffc0202c98:	7159                	addi	sp,sp,-112
ffffffffc0202c9a:	f85a                	sd	s6,48(sp)
ffffffffc0202c9c:	00009517          	auipc	a0,0x9
ffffffffc0202ca0:	77450513          	addi	a0,a0,1908 # ffffffffc020c410 <default_pmm_manager+0x1f0>
ffffffffc0202ca4:	00094b17          	auipc	s6,0x94
ffffffffc0202ca8:	c0cb0b13          	addi	s6,s6,-1012 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202cac:	f486                	sd	ra,104(sp)
ffffffffc0202cae:	e8ca                	sd	s2,80(sp)
ffffffffc0202cb0:	e4ce                	sd	s3,72(sp)
ffffffffc0202cb2:	f0a2                	sd	s0,96(sp)
ffffffffc0202cb4:	eca6                	sd	s1,88(sp)
ffffffffc0202cb6:	e0d2                	sd	s4,64(sp)
ffffffffc0202cb8:	fc56                	sd	s5,56(sp)
ffffffffc0202cba:	f45e                	sd	s7,40(sp)
ffffffffc0202cbc:	f062                	sd	s8,32(sp)
ffffffffc0202cbe:	ec66                	sd	s9,24(sp)
ffffffffc0202cc0:	00fb3023          	sd	a5,0(s6)
ffffffffc0202cc4:	ce2fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc8:	000b3783          	ld	a5,0(s6)
ffffffffc0202ccc:	00094997          	auipc	s3,0x94
ffffffffc0202cd0:	bec98993          	addi	s3,s3,-1044 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202cd4:	679c                	ld	a5,8(a5)
ffffffffc0202cd6:	9782                	jalr	a5
ffffffffc0202cd8:	57f5                	li	a5,-3
ffffffffc0202cda:	07fa                	slli	a5,a5,0x1e
ffffffffc0202cdc:	00f9b023          	sd	a5,0(s3)
ffffffffc0202ce0:	d69fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202ce4:	892a                	mv	s2,a0
ffffffffc0202ce6:	d6dfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202cea:	280502e3          	beqz	a0,ffffffffc020376e <pmm_init+0xae0>
ffffffffc0202cee:	84aa                	mv	s1,a0
ffffffffc0202cf0:	00009517          	auipc	a0,0x9
ffffffffc0202cf4:	75850513          	addi	a0,a0,1880 # ffffffffc020c448 <default_pmm_manager+0x228>
ffffffffc0202cf8:	caefd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cfc:	00990433          	add	s0,s2,s1
ffffffffc0202d00:	fff40693          	addi	a3,s0,-1
ffffffffc0202d04:	864a                	mv	a2,s2
ffffffffc0202d06:	85a6                	mv	a1,s1
ffffffffc0202d08:	00009517          	auipc	a0,0x9
ffffffffc0202d0c:	75850513          	addi	a0,a0,1880 # ffffffffc020c460 <default_pmm_manager+0x240>
ffffffffc0202d10:	c96fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202d14:	c8000737          	lui	a4,0xc8000
ffffffffc0202d18:	87a2                	mv	a5,s0
ffffffffc0202d1a:	5e876e63          	bltu	a4,s0,ffffffffc0203316 <pmm_init+0x688>
ffffffffc0202d1e:	757d                	lui	a0,0xfffff
ffffffffc0202d20:	00095617          	auipc	a2,0x95
ffffffffc0202d24:	bef60613          	addi	a2,a2,-1041 # ffffffffc029790f <end+0xfff>
ffffffffc0202d28:	8e69                	and	a2,a2,a0
ffffffffc0202d2a:	00094497          	auipc	s1,0x94
ffffffffc0202d2e:	b7648493          	addi	s1,s1,-1162 # ffffffffc02968a0 <npage>
ffffffffc0202d32:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202d36:	00094b97          	auipc	s7,0x94
ffffffffc0202d3a:	b72b8b93          	addi	s7,s7,-1166 # ffffffffc02968a8 <pages>
ffffffffc0202d3e:	e088                	sd	a0,0(s1)
ffffffffc0202d40:	00cbb023          	sd	a2,0(s7)
ffffffffc0202d44:	000807b7          	lui	a5,0x80
ffffffffc0202d48:	86b2                	mv	a3,a2
ffffffffc0202d4a:	02f50863          	beq	a0,a5,ffffffffc0202d7a <pmm_init+0xec>
ffffffffc0202d4e:	4781                	li	a5,0
ffffffffc0202d50:	4585                	li	a1,1
ffffffffc0202d52:	fff806b7          	lui	a3,0xfff80
ffffffffc0202d56:	00679513          	slli	a0,a5,0x6
ffffffffc0202d5a:	9532                	add	a0,a0,a2
ffffffffc0202d5c:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202d60:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202d64:	6088                	ld	a0,0(s1)
ffffffffc0202d66:	0785                	addi	a5,a5,1
ffffffffc0202d68:	000bb603          	ld	a2,0(s7)
ffffffffc0202d6c:	00d50733          	add	a4,a0,a3
ffffffffc0202d70:	fee7e3e3          	bltu	a5,a4,ffffffffc0202d56 <pmm_init+0xc8>
ffffffffc0202d74:	071a                	slli	a4,a4,0x6
ffffffffc0202d76:	00e606b3          	add	a3,a2,a4
ffffffffc0202d7a:	c02007b7          	lui	a5,0xc0200
ffffffffc0202d7e:	3af6eae3          	bltu	a3,a5,ffffffffc0203932 <pmm_init+0xca4>
ffffffffc0202d82:	0009b583          	ld	a1,0(s3)
ffffffffc0202d86:	77fd                	lui	a5,0xfffff
ffffffffc0202d88:	8c7d                	and	s0,s0,a5
ffffffffc0202d8a:	8e8d                	sub	a3,a3,a1
ffffffffc0202d8c:	5e86e363          	bltu	a3,s0,ffffffffc0203372 <pmm_init+0x6e4>
ffffffffc0202d90:	00009517          	auipc	a0,0x9
ffffffffc0202d94:	6f850513          	addi	a0,a0,1784 # ffffffffc020c488 <default_pmm_manager+0x268>
ffffffffc0202d98:	c0efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202d9c:	000b3783          	ld	a5,0(s6)
ffffffffc0202da0:	7b9c                	ld	a5,48(a5)
ffffffffc0202da2:	9782                	jalr	a5
ffffffffc0202da4:	00009517          	auipc	a0,0x9
ffffffffc0202da8:	6fc50513          	addi	a0,a0,1788 # ffffffffc020c4a0 <default_pmm_manager+0x280>
ffffffffc0202dac:	bfafd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202db0:	100027f3          	csrr	a5,sstatus
ffffffffc0202db4:	8b89                	andi	a5,a5,2
ffffffffc0202db6:	5a079363          	bnez	a5,ffffffffc020335c <pmm_init+0x6ce>
ffffffffc0202dba:	000b3783          	ld	a5,0(s6)
ffffffffc0202dbe:	4505                	li	a0,1
ffffffffc0202dc0:	6f9c                	ld	a5,24(a5)
ffffffffc0202dc2:	9782                	jalr	a5
ffffffffc0202dc4:	842a                	mv	s0,a0
ffffffffc0202dc6:	180408e3          	beqz	s0,ffffffffc0203756 <pmm_init+0xac8>
ffffffffc0202dca:	000bb683          	ld	a3,0(s7)
ffffffffc0202dce:	5a7d                	li	s4,-1
ffffffffc0202dd0:	6098                	ld	a4,0(s1)
ffffffffc0202dd2:	40d406b3          	sub	a3,s0,a3
ffffffffc0202dd6:	8699                	srai	a3,a3,0x6
ffffffffc0202dd8:	00080437          	lui	s0,0x80
ffffffffc0202ddc:	96a2                	add	a3,a3,s0
ffffffffc0202dde:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202de2:	8ff5                	and	a5,a5,a3
ffffffffc0202de4:	06b2                	slli	a3,a3,0xc
ffffffffc0202de6:	30e7fde3          	bgeu	a5,a4,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc0202dea:	0009b403          	ld	s0,0(s3)
ffffffffc0202dee:	6605                	lui	a2,0x1
ffffffffc0202df0:	4581                	li	a1,0
ffffffffc0202df2:	9436                	add	s0,s0,a3
ffffffffc0202df4:	8522                	mv	a0,s0
ffffffffc0202df6:	45a080ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0202dfa:	0009b683          	ld	a3,0(s3)
ffffffffc0202dfe:	77fd                	lui	a5,0xfffff
ffffffffc0202e00:	00009917          	auipc	s2,0x9
ffffffffc0202e04:	4b990913          	addi	s2,s2,1209 # ffffffffc020c2b9 <default_pmm_manager+0x99>
ffffffffc0202e08:	00f97933          	and	s2,s2,a5
ffffffffc0202e0c:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202e10:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202e14:	964a                	add	a2,a2,s2
ffffffffc0202e16:	4729                	li	a4,10
ffffffffc0202e18:	40da86b3          	sub	a3,s5,a3
ffffffffc0202e1c:	c02005b7          	lui	a1,0xc0200
ffffffffc0202e20:	8522                	mv	a0,s0
ffffffffc0202e22:	e2aff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202e26:	c8000637          	lui	a2,0xc8000
ffffffffc0202e2a:	41260633          	sub	a2,a2,s2
ffffffffc0202e2e:	3f596ce3          	bltu	s2,s5,ffffffffc0203a26 <pmm_init+0xd98>
ffffffffc0202e32:	0009b683          	ld	a3,0(s3)
ffffffffc0202e36:	85ca                	mv	a1,s2
ffffffffc0202e38:	4719                	li	a4,6
ffffffffc0202e3a:	40d906b3          	sub	a3,s2,a3
ffffffffc0202e3e:	8522                	mv	a0,s0
ffffffffc0202e40:	00094917          	auipc	s2,0x94
ffffffffc0202e44:	a5890913          	addi	s2,s2,-1448 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202e48:	e04ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202e4c:	00893023          	sd	s0,0(s2)
ffffffffc0202e50:	2d5464e3          	bltu	s0,s5,ffffffffc0203918 <pmm_init+0xc8a>
ffffffffc0202e54:	0009b783          	ld	a5,0(s3)
ffffffffc0202e58:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202e5a:	8c1d                	sub	s0,s0,a5
ffffffffc0202e5c:	00c45793          	srli	a5,s0,0xc
ffffffffc0202e60:	00094717          	auipc	a4,0x94
ffffffffc0202e64:	a2873823          	sd	s0,-1488(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202e68:	0147ea33          	or	s4,a5,s4
ffffffffc0202e6c:	180a1073          	csrw	satp,s4
ffffffffc0202e70:	12000073          	sfence.vma
ffffffffc0202e74:	00009517          	auipc	a0,0x9
ffffffffc0202e78:	66c50513          	addi	a0,a0,1644 # ffffffffc020c4e0 <default_pmm_manager+0x2c0>
ffffffffc0202e7c:	b2afd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202e80:	0000e717          	auipc	a4,0xe
ffffffffc0202e84:	18070713          	addi	a4,a4,384 # ffffffffc0211000 <bootstack>
ffffffffc0202e88:	0000e797          	auipc	a5,0xe
ffffffffc0202e8c:	17878793          	addi	a5,a5,376 # ffffffffc0211000 <bootstack>
ffffffffc0202e90:	5cf70d63          	beq	a4,a5,ffffffffc020346a <pmm_init+0x7dc>
ffffffffc0202e94:	100027f3          	csrr	a5,sstatus
ffffffffc0202e98:	8b89                	andi	a5,a5,2
ffffffffc0202e9a:	4a079763          	bnez	a5,ffffffffc0203348 <pmm_init+0x6ba>
ffffffffc0202e9e:	000b3783          	ld	a5,0(s6)
ffffffffc0202ea2:	779c                	ld	a5,40(a5)
ffffffffc0202ea4:	9782                	jalr	a5
ffffffffc0202ea6:	842a                	mv	s0,a0
ffffffffc0202ea8:	6098                	ld	a4,0(s1)
ffffffffc0202eaa:	c80007b7          	lui	a5,0xc8000
ffffffffc0202eae:	83b1                	srli	a5,a5,0xc
ffffffffc0202eb0:	08e7e3e3          	bltu	a5,a4,ffffffffc0203736 <pmm_init+0xaa8>
ffffffffc0202eb4:	00093503          	ld	a0,0(s2)
ffffffffc0202eb8:	04050fe3          	beqz	a0,ffffffffc0203716 <pmm_init+0xa88>
ffffffffc0202ebc:	03451793          	slli	a5,a0,0x34
ffffffffc0202ec0:	04079be3          	bnez	a5,ffffffffc0203716 <pmm_init+0xa88>
ffffffffc0202ec4:	4601                	li	a2,0
ffffffffc0202ec6:	4581                	li	a1,0
ffffffffc0202ec8:	e4aff0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0202ecc:	2e0511e3          	bnez	a0,ffffffffc02039ae <pmm_init+0xd20>
ffffffffc0202ed0:	100027f3          	csrr	a5,sstatus
ffffffffc0202ed4:	8b89                	andi	a5,a5,2
ffffffffc0202ed6:	44079e63          	bnez	a5,ffffffffc0203332 <pmm_init+0x6a4>
ffffffffc0202eda:	000b3783          	ld	a5,0(s6)
ffffffffc0202ede:	4505                	li	a0,1
ffffffffc0202ee0:	6f9c                	ld	a5,24(a5)
ffffffffc0202ee2:	9782                	jalr	a5
ffffffffc0202ee4:	8a2a                	mv	s4,a0
ffffffffc0202ee6:	00093503          	ld	a0,0(s2)
ffffffffc0202eea:	4681                	li	a3,0
ffffffffc0202eec:	4601                	li	a2,0
ffffffffc0202eee:	85d2                	mv	a1,s4
ffffffffc0202ef0:	ca9ff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0202ef4:	26051be3          	bnez	a0,ffffffffc020396a <pmm_init+0xcdc>
ffffffffc0202ef8:	00093503          	ld	a0,0(s2)
ffffffffc0202efc:	4601                	li	a2,0
ffffffffc0202efe:	4581                	li	a1,0
ffffffffc0202f00:	b24ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202f04:	280505e3          	beqz	a0,ffffffffc020398e <pmm_init+0xd00>
ffffffffc0202f08:	611c                	ld	a5,0(a0)
ffffffffc0202f0a:	0017f713          	andi	a4,a5,1
ffffffffc0202f0e:	26070ee3          	beqz	a4,ffffffffc020398a <pmm_init+0xcfc>
ffffffffc0202f12:	6098                	ld	a4,0(s1)
ffffffffc0202f14:	078a                	slli	a5,a5,0x2
ffffffffc0202f16:	83b1                	srli	a5,a5,0xc
ffffffffc0202f18:	62e7f363          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0202f1c:	000bb683          	ld	a3,0(s7)
ffffffffc0202f20:	fff80637          	lui	a2,0xfff80
ffffffffc0202f24:	97b2                	add	a5,a5,a2
ffffffffc0202f26:	079a                	slli	a5,a5,0x6
ffffffffc0202f28:	97b6                	add	a5,a5,a3
ffffffffc0202f2a:	2afa12e3          	bne	s4,a5,ffffffffc02039ce <pmm_init+0xd40>
ffffffffc0202f2e:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202f32:	4785                	li	a5,1
ffffffffc0202f34:	2cf699e3          	bne	a3,a5,ffffffffc0203a06 <pmm_init+0xd78>
ffffffffc0202f38:	00093503          	ld	a0,0(s2)
ffffffffc0202f3c:	77fd                	lui	a5,0xfffff
ffffffffc0202f3e:	6114                	ld	a3,0(a0)
ffffffffc0202f40:	068a                	slli	a3,a3,0x2
ffffffffc0202f42:	8efd                	and	a3,a3,a5
ffffffffc0202f44:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202f48:	2ae673e3          	bgeu	a2,a4,ffffffffc02039ee <pmm_init+0xd60>
ffffffffc0202f4c:	0009bc03          	ld	s8,0(s3)
ffffffffc0202f50:	96e2                	add	a3,a3,s8
ffffffffc0202f52:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202f56:	0a8a                	slli	s5,s5,0x2
ffffffffc0202f58:	00fafab3          	and	s5,s5,a5
ffffffffc0202f5c:	00cad793          	srli	a5,s5,0xc
ffffffffc0202f60:	06e7f3e3          	bgeu	a5,a4,ffffffffc02037c6 <pmm_init+0xb38>
ffffffffc0202f64:	4601                	li	a2,0
ffffffffc0202f66:	6585                	lui	a1,0x1
ffffffffc0202f68:	9ae2                	add	s5,s5,s8
ffffffffc0202f6a:	abaff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202f6e:	0aa1                	addi	s5,s5,8
ffffffffc0202f70:	03551be3          	bne	a0,s5,ffffffffc02037a6 <pmm_init+0xb18>
ffffffffc0202f74:	100027f3          	csrr	a5,sstatus
ffffffffc0202f78:	8b89                	andi	a5,a5,2
ffffffffc0202f7a:	3a079163          	bnez	a5,ffffffffc020331c <pmm_init+0x68e>
ffffffffc0202f7e:	000b3783          	ld	a5,0(s6)
ffffffffc0202f82:	4505                	li	a0,1
ffffffffc0202f84:	6f9c                	ld	a5,24(a5)
ffffffffc0202f86:	9782                	jalr	a5
ffffffffc0202f88:	8c2a                	mv	s8,a0
ffffffffc0202f8a:	00093503          	ld	a0,0(s2)
ffffffffc0202f8e:	46d1                	li	a3,20
ffffffffc0202f90:	6605                	lui	a2,0x1
ffffffffc0202f92:	85e2                	mv	a1,s8
ffffffffc0202f94:	c05ff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0202f98:	1a0519e3          	bnez	a0,ffffffffc020394a <pmm_init+0xcbc>
ffffffffc0202f9c:	00093503          	ld	a0,0(s2)
ffffffffc0202fa0:	4601                	li	a2,0
ffffffffc0202fa2:	6585                	lui	a1,0x1
ffffffffc0202fa4:	a80ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202fa8:	10050ce3          	beqz	a0,ffffffffc02038c0 <pmm_init+0xc32>
ffffffffc0202fac:	611c                	ld	a5,0(a0)
ffffffffc0202fae:	0107f713          	andi	a4,a5,16
ffffffffc0202fb2:	0e0707e3          	beqz	a4,ffffffffc02038a0 <pmm_init+0xc12>
ffffffffc0202fb6:	8b91                	andi	a5,a5,4
ffffffffc0202fb8:	0c0784e3          	beqz	a5,ffffffffc0203880 <pmm_init+0xbf2>
ffffffffc0202fbc:	00093503          	ld	a0,0(s2)
ffffffffc0202fc0:	611c                	ld	a5,0(a0)
ffffffffc0202fc2:	8bc1                	andi	a5,a5,16
ffffffffc0202fc4:	08078ee3          	beqz	a5,ffffffffc0203860 <pmm_init+0xbd2>
ffffffffc0202fc8:	000c2703          	lw	a4,0(s8)
ffffffffc0202fcc:	4785                	li	a5,1
ffffffffc0202fce:	06f719e3          	bne	a4,a5,ffffffffc0203840 <pmm_init+0xbb2>
ffffffffc0202fd2:	4681                	li	a3,0
ffffffffc0202fd4:	6605                	lui	a2,0x1
ffffffffc0202fd6:	85d2                	mv	a1,s4
ffffffffc0202fd8:	bc1ff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0202fdc:	040512e3          	bnez	a0,ffffffffc0203820 <pmm_init+0xb92>
ffffffffc0202fe0:	000a2703          	lw	a4,0(s4)
ffffffffc0202fe4:	4789                	li	a5,2
ffffffffc0202fe6:	00f71de3          	bne	a4,a5,ffffffffc0203800 <pmm_init+0xb72>
ffffffffc0202fea:	000c2783          	lw	a5,0(s8)
ffffffffc0202fee:	7e079963          	bnez	a5,ffffffffc02037e0 <pmm_init+0xb52>
ffffffffc0202ff2:	00093503          	ld	a0,0(s2)
ffffffffc0202ff6:	4601                	li	a2,0
ffffffffc0202ff8:	6585                	lui	a1,0x1
ffffffffc0202ffa:	a2aff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202ffe:	54050263          	beqz	a0,ffffffffc0203542 <pmm_init+0x8b4>
ffffffffc0203002:	6118                	ld	a4,0(a0)
ffffffffc0203004:	00177793          	andi	a5,a4,1
ffffffffc0203008:	180781e3          	beqz	a5,ffffffffc020398a <pmm_init+0xcfc>
ffffffffc020300c:	6094                	ld	a3,0(s1)
ffffffffc020300e:	00271793          	slli	a5,a4,0x2
ffffffffc0203012:	83b1                	srli	a5,a5,0xc
ffffffffc0203014:	52d7f563          	bgeu	a5,a3,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203018:	000bb683          	ld	a3,0(s7)
ffffffffc020301c:	fff80ab7          	lui	s5,0xfff80
ffffffffc0203020:	97d6                	add	a5,a5,s5
ffffffffc0203022:	079a                	slli	a5,a5,0x6
ffffffffc0203024:	97b6                	add	a5,a5,a3
ffffffffc0203026:	58fa1e63          	bne	s4,a5,ffffffffc02035c2 <pmm_init+0x934>
ffffffffc020302a:	8b41                	andi	a4,a4,16
ffffffffc020302c:	56071b63          	bnez	a4,ffffffffc02035a2 <pmm_init+0x914>
ffffffffc0203030:	00093503          	ld	a0,0(s2)
ffffffffc0203034:	4581                	li	a1,0
ffffffffc0203036:	ac7ff0ef          	jal	ra,ffffffffc0202afc <page_remove>
ffffffffc020303a:	000a2c83          	lw	s9,0(s4)
ffffffffc020303e:	4785                	li	a5,1
ffffffffc0203040:	5cfc9163          	bne	s9,a5,ffffffffc0203602 <pmm_init+0x974>
ffffffffc0203044:	000c2783          	lw	a5,0(s8)
ffffffffc0203048:	58079d63          	bnez	a5,ffffffffc02035e2 <pmm_init+0x954>
ffffffffc020304c:	00093503          	ld	a0,0(s2)
ffffffffc0203050:	6585                	lui	a1,0x1
ffffffffc0203052:	aabff0ef          	jal	ra,ffffffffc0202afc <page_remove>
ffffffffc0203056:	000a2783          	lw	a5,0(s4)
ffffffffc020305a:	200793e3          	bnez	a5,ffffffffc0203a60 <pmm_init+0xdd2>
ffffffffc020305e:	000c2783          	lw	a5,0(s8)
ffffffffc0203062:	1c079fe3          	bnez	a5,ffffffffc0203a40 <pmm_init+0xdb2>
ffffffffc0203066:	00093a03          	ld	s4,0(s2)
ffffffffc020306a:	608c                	ld	a1,0(s1)
ffffffffc020306c:	000a3683          	ld	a3,0(s4)
ffffffffc0203070:	068a                	slli	a3,a3,0x2
ffffffffc0203072:	82b1                	srli	a3,a3,0xc
ffffffffc0203074:	4cb6f563          	bgeu	a3,a1,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203078:	000bb503          	ld	a0,0(s7)
ffffffffc020307c:	96d6                	add	a3,a3,s5
ffffffffc020307e:	069a                	slli	a3,a3,0x6
ffffffffc0203080:	00d507b3          	add	a5,a0,a3
ffffffffc0203084:	439c                	lw	a5,0(a5)
ffffffffc0203086:	4f979e63          	bne	a5,s9,ffffffffc0203582 <pmm_init+0x8f4>
ffffffffc020308a:	8699                	srai	a3,a3,0x6
ffffffffc020308c:	00080637          	lui	a2,0x80
ffffffffc0203090:	96b2                	add	a3,a3,a2
ffffffffc0203092:	00c69713          	slli	a4,a3,0xc
ffffffffc0203096:	8331                	srli	a4,a4,0xc
ffffffffc0203098:	06b2                	slli	a3,a3,0xc
ffffffffc020309a:	06b773e3          	bgeu	a4,a1,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc020309e:	0009b703          	ld	a4,0(s3)
ffffffffc02030a2:	96ba                	add	a3,a3,a4
ffffffffc02030a4:	629c                	ld	a5,0(a3)
ffffffffc02030a6:	078a                	slli	a5,a5,0x2
ffffffffc02030a8:	83b1                	srli	a5,a5,0xc
ffffffffc02030aa:	48b7fa63          	bgeu	a5,a1,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc02030ae:	8f91                	sub	a5,a5,a2
ffffffffc02030b0:	079a                	slli	a5,a5,0x6
ffffffffc02030b2:	953e                	add	a0,a0,a5
ffffffffc02030b4:	100027f3          	csrr	a5,sstatus
ffffffffc02030b8:	8b89                	andi	a5,a5,2
ffffffffc02030ba:	32079463          	bnez	a5,ffffffffc02033e2 <pmm_init+0x754>
ffffffffc02030be:	000b3783          	ld	a5,0(s6)
ffffffffc02030c2:	4585                	li	a1,1
ffffffffc02030c4:	739c                	ld	a5,32(a5)
ffffffffc02030c6:	9782                	jalr	a5
ffffffffc02030c8:	000a3783          	ld	a5,0(s4)
ffffffffc02030cc:	6098                	ld	a4,0(s1)
ffffffffc02030ce:	078a                	slli	a5,a5,0x2
ffffffffc02030d0:	83b1                	srli	a5,a5,0xc
ffffffffc02030d2:	46e7f663          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc02030d6:	000bb503          	ld	a0,0(s7)
ffffffffc02030da:	fff80737          	lui	a4,0xfff80
ffffffffc02030de:	97ba                	add	a5,a5,a4
ffffffffc02030e0:	079a                	slli	a5,a5,0x6
ffffffffc02030e2:	953e                	add	a0,a0,a5
ffffffffc02030e4:	100027f3          	csrr	a5,sstatus
ffffffffc02030e8:	8b89                	andi	a5,a5,2
ffffffffc02030ea:	2e079063          	bnez	a5,ffffffffc02033ca <pmm_init+0x73c>
ffffffffc02030ee:	000b3783          	ld	a5,0(s6)
ffffffffc02030f2:	4585                	li	a1,1
ffffffffc02030f4:	739c                	ld	a5,32(a5)
ffffffffc02030f6:	9782                	jalr	a5
ffffffffc02030f8:	00093783          	ld	a5,0(s2)
ffffffffc02030fc:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203100:	12000073          	sfence.vma
ffffffffc0203104:	100027f3          	csrr	a5,sstatus
ffffffffc0203108:	8b89                	andi	a5,a5,2
ffffffffc020310a:	2a079663          	bnez	a5,ffffffffc02033b6 <pmm_init+0x728>
ffffffffc020310e:	000b3783          	ld	a5,0(s6)
ffffffffc0203112:	779c                	ld	a5,40(a5)
ffffffffc0203114:	9782                	jalr	a5
ffffffffc0203116:	8a2a                	mv	s4,a0
ffffffffc0203118:	7d441463          	bne	s0,s4,ffffffffc02038e0 <pmm_init+0xc52>
ffffffffc020311c:	00009517          	auipc	a0,0x9
ffffffffc0203120:	71c50513          	addi	a0,a0,1820 # ffffffffc020c838 <default_pmm_manager+0x618>
ffffffffc0203124:	882fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203128:	100027f3          	csrr	a5,sstatus
ffffffffc020312c:	8b89                	andi	a5,a5,2
ffffffffc020312e:	26079a63          	bnez	a5,ffffffffc02033a2 <pmm_init+0x714>
ffffffffc0203132:	000b3783          	ld	a5,0(s6)
ffffffffc0203136:	779c                	ld	a5,40(a5)
ffffffffc0203138:	9782                	jalr	a5
ffffffffc020313a:	8c2a                	mv	s8,a0
ffffffffc020313c:	6098                	ld	a4,0(s1)
ffffffffc020313e:	c0200437          	lui	s0,0xc0200
ffffffffc0203142:	7afd                	lui	s5,0xfffff
ffffffffc0203144:	00c71793          	slli	a5,a4,0xc
ffffffffc0203148:	6a05                	lui	s4,0x1
ffffffffc020314a:	02f47c63          	bgeu	s0,a5,ffffffffc0203182 <pmm_init+0x4f4>
ffffffffc020314e:	00c45793          	srli	a5,s0,0xc
ffffffffc0203152:	00093503          	ld	a0,0(s2)
ffffffffc0203156:	3ae7f763          	bgeu	a5,a4,ffffffffc0203504 <pmm_init+0x876>
ffffffffc020315a:	0009b583          	ld	a1,0(s3)
ffffffffc020315e:	4601                	li	a2,0
ffffffffc0203160:	95a2                	add	a1,a1,s0
ffffffffc0203162:	8c2ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0203166:	36050f63          	beqz	a0,ffffffffc02034e4 <pmm_init+0x856>
ffffffffc020316a:	611c                	ld	a5,0(a0)
ffffffffc020316c:	078a                	slli	a5,a5,0x2
ffffffffc020316e:	0157f7b3          	and	a5,a5,s5
ffffffffc0203172:	3a879663          	bne	a5,s0,ffffffffc020351e <pmm_init+0x890>
ffffffffc0203176:	6098                	ld	a4,0(s1)
ffffffffc0203178:	9452                	add	s0,s0,s4
ffffffffc020317a:	00c71793          	slli	a5,a4,0xc
ffffffffc020317e:	fcf468e3          	bltu	s0,a5,ffffffffc020314e <pmm_init+0x4c0>
ffffffffc0203182:	00093783          	ld	a5,0(s2)
ffffffffc0203186:	639c                	ld	a5,0(a5)
ffffffffc0203188:	48079d63          	bnez	a5,ffffffffc0203622 <pmm_init+0x994>
ffffffffc020318c:	100027f3          	csrr	a5,sstatus
ffffffffc0203190:	8b89                	andi	a5,a5,2
ffffffffc0203192:	26079463          	bnez	a5,ffffffffc02033fa <pmm_init+0x76c>
ffffffffc0203196:	000b3783          	ld	a5,0(s6)
ffffffffc020319a:	4505                	li	a0,1
ffffffffc020319c:	6f9c                	ld	a5,24(a5)
ffffffffc020319e:	9782                	jalr	a5
ffffffffc02031a0:	8a2a                	mv	s4,a0
ffffffffc02031a2:	00093503          	ld	a0,0(s2)
ffffffffc02031a6:	4699                	li	a3,6
ffffffffc02031a8:	10000613          	li	a2,256
ffffffffc02031ac:	85d2                	mv	a1,s4
ffffffffc02031ae:	9ebff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc02031b2:	4a051863          	bnez	a0,ffffffffc0203662 <pmm_init+0x9d4>
ffffffffc02031b6:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc02031ba:	4785                	li	a5,1
ffffffffc02031bc:	48f71363          	bne	a4,a5,ffffffffc0203642 <pmm_init+0x9b4>
ffffffffc02031c0:	00093503          	ld	a0,0(s2)
ffffffffc02031c4:	6405                	lui	s0,0x1
ffffffffc02031c6:	4699                	li	a3,6
ffffffffc02031c8:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc02031cc:	85d2                	mv	a1,s4
ffffffffc02031ce:	9cbff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc02031d2:	38051863          	bnez	a0,ffffffffc0203562 <pmm_init+0x8d4>
ffffffffc02031d6:	000a2703          	lw	a4,0(s4)
ffffffffc02031da:	4789                	li	a5,2
ffffffffc02031dc:	4ef71363          	bne	a4,a5,ffffffffc02036c2 <pmm_init+0xa34>
ffffffffc02031e0:	00009597          	auipc	a1,0x9
ffffffffc02031e4:	7a058593          	addi	a1,a1,1952 # ffffffffc020c980 <default_pmm_manager+0x760>
ffffffffc02031e8:	10000513          	li	a0,256
ffffffffc02031ec:	7f9070ef          	jal	ra,ffffffffc020b1e4 <strcpy>
ffffffffc02031f0:	10040593          	addi	a1,s0,256
ffffffffc02031f4:	10000513          	li	a0,256
ffffffffc02031f8:	7ff070ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc02031fc:	4a051363          	bnez	a0,ffffffffc02036a2 <pmm_init+0xa14>
ffffffffc0203200:	000bb683          	ld	a3,0(s7)
ffffffffc0203204:	00080737          	lui	a4,0x80
ffffffffc0203208:	547d                	li	s0,-1
ffffffffc020320a:	40da06b3          	sub	a3,s4,a3
ffffffffc020320e:	8699                	srai	a3,a3,0x6
ffffffffc0203210:	609c                	ld	a5,0(s1)
ffffffffc0203212:	96ba                	add	a3,a3,a4
ffffffffc0203214:	8031                	srli	s0,s0,0xc
ffffffffc0203216:	0086f733          	and	a4,a3,s0
ffffffffc020321a:	06b2                	slli	a3,a3,0xc
ffffffffc020321c:	6ef77263          	bgeu	a4,a5,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc0203220:	0009b783          	ld	a5,0(s3)
ffffffffc0203224:	10000513          	li	a0,256
ffffffffc0203228:	96be                	add	a3,a3,a5
ffffffffc020322a:	10068023          	sb	zero,256(a3)
ffffffffc020322e:	781070ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc0203232:	44051863          	bnez	a0,ffffffffc0203682 <pmm_init+0x9f4>
ffffffffc0203236:	00093a83          	ld	s5,0(s2)
ffffffffc020323a:	609c                	ld	a5,0(s1)
ffffffffc020323c:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203240:	068a                	slli	a3,a3,0x2
ffffffffc0203242:	82b1                	srli	a3,a3,0xc
ffffffffc0203244:	2ef6fd63          	bgeu	a3,a5,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203248:	8c75                	and	s0,s0,a3
ffffffffc020324a:	06b2                	slli	a3,a3,0xc
ffffffffc020324c:	6af47a63          	bgeu	s0,a5,ffffffffc0203900 <pmm_init+0xc72>
ffffffffc0203250:	0009b403          	ld	s0,0(s3)
ffffffffc0203254:	9436                	add	s0,s0,a3
ffffffffc0203256:	100027f3          	csrr	a5,sstatus
ffffffffc020325a:	8b89                	andi	a5,a5,2
ffffffffc020325c:	1e079c63          	bnez	a5,ffffffffc0203454 <pmm_init+0x7c6>
ffffffffc0203260:	000b3783          	ld	a5,0(s6)
ffffffffc0203264:	4585                	li	a1,1
ffffffffc0203266:	8552                	mv	a0,s4
ffffffffc0203268:	739c                	ld	a5,32(a5)
ffffffffc020326a:	9782                	jalr	a5
ffffffffc020326c:	601c                	ld	a5,0(s0)
ffffffffc020326e:	6098                	ld	a4,0(s1)
ffffffffc0203270:	078a                	slli	a5,a5,0x2
ffffffffc0203272:	83b1                	srli	a5,a5,0xc
ffffffffc0203274:	2ce7f563          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203278:	000bb503          	ld	a0,0(s7)
ffffffffc020327c:	fff80737          	lui	a4,0xfff80
ffffffffc0203280:	97ba                	add	a5,a5,a4
ffffffffc0203282:	079a                	slli	a5,a5,0x6
ffffffffc0203284:	953e                	add	a0,a0,a5
ffffffffc0203286:	100027f3          	csrr	a5,sstatus
ffffffffc020328a:	8b89                	andi	a5,a5,2
ffffffffc020328c:	1a079863          	bnez	a5,ffffffffc020343c <pmm_init+0x7ae>
ffffffffc0203290:	000b3783          	ld	a5,0(s6)
ffffffffc0203294:	4585                	li	a1,1
ffffffffc0203296:	739c                	ld	a5,32(a5)
ffffffffc0203298:	9782                	jalr	a5
ffffffffc020329a:	000ab783          	ld	a5,0(s5)
ffffffffc020329e:	6098                	ld	a4,0(s1)
ffffffffc02032a0:	078a                	slli	a5,a5,0x2
ffffffffc02032a2:	83b1                	srli	a5,a5,0xc
ffffffffc02032a4:	28e7fd63          	bgeu	a5,a4,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc02032a8:	000bb503          	ld	a0,0(s7)
ffffffffc02032ac:	fff80737          	lui	a4,0xfff80
ffffffffc02032b0:	97ba                	add	a5,a5,a4
ffffffffc02032b2:	079a                	slli	a5,a5,0x6
ffffffffc02032b4:	953e                	add	a0,a0,a5
ffffffffc02032b6:	100027f3          	csrr	a5,sstatus
ffffffffc02032ba:	8b89                	andi	a5,a5,2
ffffffffc02032bc:	16079463          	bnez	a5,ffffffffc0203424 <pmm_init+0x796>
ffffffffc02032c0:	000b3783          	ld	a5,0(s6)
ffffffffc02032c4:	4585                	li	a1,1
ffffffffc02032c6:	739c                	ld	a5,32(a5)
ffffffffc02032c8:	9782                	jalr	a5
ffffffffc02032ca:	00093783          	ld	a5,0(s2)
ffffffffc02032ce:	0007b023          	sd	zero,0(a5)
ffffffffc02032d2:	12000073          	sfence.vma
ffffffffc02032d6:	100027f3          	csrr	a5,sstatus
ffffffffc02032da:	8b89                	andi	a5,a5,2
ffffffffc02032dc:	12079a63          	bnez	a5,ffffffffc0203410 <pmm_init+0x782>
ffffffffc02032e0:	000b3783          	ld	a5,0(s6)
ffffffffc02032e4:	779c                	ld	a5,40(a5)
ffffffffc02032e6:	9782                	jalr	a5
ffffffffc02032e8:	842a                	mv	s0,a0
ffffffffc02032ea:	488c1e63          	bne	s8,s0,ffffffffc0203786 <pmm_init+0xaf8>
ffffffffc02032ee:	00009517          	auipc	a0,0x9
ffffffffc02032f2:	70a50513          	addi	a0,a0,1802 # ffffffffc020c9f8 <default_pmm_manager+0x7d8>
ffffffffc02032f6:	eb1fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02032fa:	7406                	ld	s0,96(sp)
ffffffffc02032fc:	70a6                	ld	ra,104(sp)
ffffffffc02032fe:	64e6                	ld	s1,88(sp)
ffffffffc0203300:	6946                	ld	s2,80(sp)
ffffffffc0203302:	69a6                	ld	s3,72(sp)
ffffffffc0203304:	6a06                	ld	s4,64(sp)
ffffffffc0203306:	7ae2                	ld	s5,56(sp)
ffffffffc0203308:	7b42                	ld	s6,48(sp)
ffffffffc020330a:	7ba2                	ld	s7,40(sp)
ffffffffc020330c:	7c02                	ld	s8,32(sp)
ffffffffc020330e:	6ce2                	ld	s9,24(sp)
ffffffffc0203310:	6165                	addi	sp,sp,112
ffffffffc0203312:	c59fe06f          	j	ffffffffc0201f6a <kmalloc_init>
ffffffffc0203316:	c80007b7          	lui	a5,0xc8000
ffffffffc020331a:	b411                	j	ffffffffc0202d1e <pmm_init+0x90>
ffffffffc020331c:	957fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203320:	000b3783          	ld	a5,0(s6)
ffffffffc0203324:	4505                	li	a0,1
ffffffffc0203326:	6f9c                	ld	a5,24(a5)
ffffffffc0203328:	9782                	jalr	a5
ffffffffc020332a:	8c2a                	mv	s8,a0
ffffffffc020332c:	941fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203330:	b9a9                	j	ffffffffc0202f8a <pmm_init+0x2fc>
ffffffffc0203332:	941fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203336:	000b3783          	ld	a5,0(s6)
ffffffffc020333a:	4505                	li	a0,1
ffffffffc020333c:	6f9c                	ld	a5,24(a5)
ffffffffc020333e:	9782                	jalr	a5
ffffffffc0203340:	8a2a                	mv	s4,a0
ffffffffc0203342:	92bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203346:	b645                	j	ffffffffc0202ee6 <pmm_init+0x258>
ffffffffc0203348:	92bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020334c:	000b3783          	ld	a5,0(s6)
ffffffffc0203350:	779c                	ld	a5,40(a5)
ffffffffc0203352:	9782                	jalr	a5
ffffffffc0203354:	842a                	mv	s0,a0
ffffffffc0203356:	917fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020335a:	b6b9                	j	ffffffffc0202ea8 <pmm_init+0x21a>
ffffffffc020335c:	917fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203360:	000b3783          	ld	a5,0(s6)
ffffffffc0203364:	4505                	li	a0,1
ffffffffc0203366:	6f9c                	ld	a5,24(a5)
ffffffffc0203368:	9782                	jalr	a5
ffffffffc020336a:	842a                	mv	s0,a0
ffffffffc020336c:	901fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203370:	bc99                	j	ffffffffc0202dc6 <pmm_init+0x138>
ffffffffc0203372:	6705                	lui	a4,0x1
ffffffffc0203374:	177d                	addi	a4,a4,-1
ffffffffc0203376:	96ba                	add	a3,a3,a4
ffffffffc0203378:	8ff5                	and	a5,a5,a3
ffffffffc020337a:	00c7d713          	srli	a4,a5,0xc
ffffffffc020337e:	1ca77063          	bgeu	a4,a0,ffffffffc020353e <pmm_init+0x8b0>
ffffffffc0203382:	000b3683          	ld	a3,0(s6)
ffffffffc0203386:	fff80537          	lui	a0,0xfff80
ffffffffc020338a:	972a                	add	a4,a4,a0
ffffffffc020338c:	6a94                	ld	a3,16(a3)
ffffffffc020338e:	8c1d                	sub	s0,s0,a5
ffffffffc0203390:	00671513          	slli	a0,a4,0x6
ffffffffc0203394:	00c45593          	srli	a1,s0,0xc
ffffffffc0203398:	9532                	add	a0,a0,a2
ffffffffc020339a:	9682                	jalr	a3
ffffffffc020339c:	0009b583          	ld	a1,0(s3)
ffffffffc02033a0:	bac5                	j	ffffffffc0202d90 <pmm_init+0x102>
ffffffffc02033a2:	8d1fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033a6:	000b3783          	ld	a5,0(s6)
ffffffffc02033aa:	779c                	ld	a5,40(a5)
ffffffffc02033ac:	9782                	jalr	a5
ffffffffc02033ae:	8c2a                	mv	s8,a0
ffffffffc02033b0:	8bdfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033b4:	b361                	j	ffffffffc020313c <pmm_init+0x4ae>
ffffffffc02033b6:	8bdfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033ba:	000b3783          	ld	a5,0(s6)
ffffffffc02033be:	779c                	ld	a5,40(a5)
ffffffffc02033c0:	9782                	jalr	a5
ffffffffc02033c2:	8a2a                	mv	s4,a0
ffffffffc02033c4:	8a9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033c8:	bb81                	j	ffffffffc0203118 <pmm_init+0x48a>
ffffffffc02033ca:	e42a                	sd	a0,8(sp)
ffffffffc02033cc:	8a7fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033d0:	000b3783          	ld	a5,0(s6)
ffffffffc02033d4:	6522                	ld	a0,8(sp)
ffffffffc02033d6:	4585                	li	a1,1
ffffffffc02033d8:	739c                	ld	a5,32(a5)
ffffffffc02033da:	9782                	jalr	a5
ffffffffc02033dc:	891fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033e0:	bb21                	j	ffffffffc02030f8 <pmm_init+0x46a>
ffffffffc02033e2:	e42a                	sd	a0,8(sp)
ffffffffc02033e4:	88ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033e8:	000b3783          	ld	a5,0(s6)
ffffffffc02033ec:	6522                	ld	a0,8(sp)
ffffffffc02033ee:	4585                	li	a1,1
ffffffffc02033f0:	739c                	ld	a5,32(a5)
ffffffffc02033f2:	9782                	jalr	a5
ffffffffc02033f4:	879fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02033f8:	b9c1                	j	ffffffffc02030c8 <pmm_init+0x43a>
ffffffffc02033fa:	879fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02033fe:	000b3783          	ld	a5,0(s6)
ffffffffc0203402:	4505                	li	a0,1
ffffffffc0203404:	6f9c                	ld	a5,24(a5)
ffffffffc0203406:	9782                	jalr	a5
ffffffffc0203408:	8a2a                	mv	s4,a0
ffffffffc020340a:	863fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020340e:	bb51                	j	ffffffffc02031a2 <pmm_init+0x514>
ffffffffc0203410:	863fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203414:	000b3783          	ld	a5,0(s6)
ffffffffc0203418:	779c                	ld	a5,40(a5)
ffffffffc020341a:	9782                	jalr	a5
ffffffffc020341c:	842a                	mv	s0,a0
ffffffffc020341e:	84ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203422:	b5e1                	j	ffffffffc02032ea <pmm_init+0x65c>
ffffffffc0203424:	e42a                	sd	a0,8(sp)
ffffffffc0203426:	84dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020342a:	000b3783          	ld	a5,0(s6)
ffffffffc020342e:	6522                	ld	a0,8(sp)
ffffffffc0203430:	4585                	li	a1,1
ffffffffc0203432:	739c                	ld	a5,32(a5)
ffffffffc0203434:	9782                	jalr	a5
ffffffffc0203436:	837fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020343a:	bd41                	j	ffffffffc02032ca <pmm_init+0x63c>
ffffffffc020343c:	e42a                	sd	a0,8(sp)
ffffffffc020343e:	835fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203442:	000b3783          	ld	a5,0(s6)
ffffffffc0203446:	6522                	ld	a0,8(sp)
ffffffffc0203448:	4585                	li	a1,1
ffffffffc020344a:	739c                	ld	a5,32(a5)
ffffffffc020344c:	9782                	jalr	a5
ffffffffc020344e:	81ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203452:	b5a1                	j	ffffffffc020329a <pmm_init+0x60c>
ffffffffc0203454:	81ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203458:	000b3783          	ld	a5,0(s6)
ffffffffc020345c:	4585                	li	a1,1
ffffffffc020345e:	8552                	mv	a0,s4
ffffffffc0203460:	739c                	ld	a5,32(a5)
ffffffffc0203462:	9782                	jalr	a5
ffffffffc0203464:	809fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203468:	b511                	j	ffffffffc020326c <pmm_init+0x5de>
ffffffffc020346a:	00010417          	auipc	s0,0x10
ffffffffc020346e:	b9640413          	addi	s0,s0,-1130 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc0203472:	00010797          	auipc	a5,0x10
ffffffffc0203476:	b8e78793          	addi	a5,a5,-1138 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc020347a:	a0f41de3          	bne	s0,a5,ffffffffc0202e94 <pmm_init+0x206>
ffffffffc020347e:	4581                	li	a1,0
ffffffffc0203480:	6605                	lui	a2,0x1
ffffffffc0203482:	8522                	mv	a0,s0
ffffffffc0203484:	5cd070ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0203488:	0000d597          	auipc	a1,0xd
ffffffffc020348c:	b7858593          	addi	a1,a1,-1160 # ffffffffc0210000 <bootstackguard>
ffffffffc0203490:	0000e797          	auipc	a5,0xe
ffffffffc0203494:	b60787a3          	sb	zero,-1169(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc0203498:	0000d797          	auipc	a5,0xd
ffffffffc020349c:	b6078423          	sb	zero,-1176(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc02034a0:	00093503          	ld	a0,0(s2)
ffffffffc02034a4:	2555ec63          	bltu	a1,s5,ffffffffc02036fc <pmm_init+0xa6e>
ffffffffc02034a8:	0009b683          	ld	a3,0(s3)
ffffffffc02034ac:	4701                	li	a4,0
ffffffffc02034ae:	6605                	lui	a2,0x1
ffffffffc02034b0:	40d586b3          	sub	a3,a1,a3
ffffffffc02034b4:	f99fe0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02034b8:	00093503          	ld	a0,0(s2)
ffffffffc02034bc:	23546363          	bltu	s0,s5,ffffffffc02036e2 <pmm_init+0xa54>
ffffffffc02034c0:	0009b683          	ld	a3,0(s3)
ffffffffc02034c4:	4701                	li	a4,0
ffffffffc02034c6:	6605                	lui	a2,0x1
ffffffffc02034c8:	40d406b3          	sub	a3,s0,a3
ffffffffc02034cc:	85a2                	mv	a1,s0
ffffffffc02034ce:	f7ffe0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02034d2:	12000073          	sfence.vma
ffffffffc02034d6:	00009517          	auipc	a0,0x9
ffffffffc02034da:	03250513          	addi	a0,a0,50 # ffffffffc020c508 <default_pmm_manager+0x2e8>
ffffffffc02034de:	cc9fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02034e2:	ba4d                	j	ffffffffc0202e94 <pmm_init+0x206>
ffffffffc02034e4:	00009697          	auipc	a3,0x9
ffffffffc02034e8:	37468693          	addi	a3,a3,884 # ffffffffc020c858 <default_pmm_manager+0x638>
ffffffffc02034ec:	00008617          	auipc	a2,0x8
ffffffffc02034f0:	24c60613          	addi	a2,a2,588 # ffffffffc020b738 <commands+0x210>
ffffffffc02034f4:	28500593          	li	a1,645
ffffffffc02034f8:	00009517          	auipc	a0,0x9
ffffffffc02034fc:	e7850513          	addi	a0,a0,-392 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203500:	f9ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203504:	86a2                	mv	a3,s0
ffffffffc0203506:	00009617          	auipc	a2,0x9
ffffffffc020350a:	d5260613          	addi	a2,a2,-686 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc020350e:	28500593          	li	a1,645
ffffffffc0203512:	00009517          	auipc	a0,0x9
ffffffffc0203516:	e5e50513          	addi	a0,a0,-418 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020351a:	f85fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020351e:	00009697          	auipc	a3,0x9
ffffffffc0203522:	37a68693          	addi	a3,a3,890 # ffffffffc020c898 <default_pmm_manager+0x678>
ffffffffc0203526:	00008617          	auipc	a2,0x8
ffffffffc020352a:	21260613          	addi	a2,a2,530 # ffffffffc020b738 <commands+0x210>
ffffffffc020352e:	28600593          	li	a1,646
ffffffffc0203532:	00009517          	auipc	a0,0x9
ffffffffc0203536:	e3e50513          	addi	a0,a0,-450 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020353a:	f65fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020353e:	bf7fe0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc0203542:	00009697          	auipc	a3,0x9
ffffffffc0203546:	17e68693          	addi	a3,a3,382 # ffffffffc020c6c0 <default_pmm_manager+0x4a0>
ffffffffc020354a:	00008617          	auipc	a2,0x8
ffffffffc020354e:	1ee60613          	addi	a2,a2,494 # ffffffffc020b738 <commands+0x210>
ffffffffc0203552:	26200593          	li	a1,610
ffffffffc0203556:	00009517          	auipc	a0,0x9
ffffffffc020355a:	e1a50513          	addi	a0,a0,-486 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020355e:	f41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203562:	00009697          	auipc	a3,0x9
ffffffffc0203566:	3be68693          	addi	a3,a3,958 # ffffffffc020c920 <default_pmm_manager+0x700>
ffffffffc020356a:	00008617          	auipc	a2,0x8
ffffffffc020356e:	1ce60613          	addi	a2,a2,462 # ffffffffc020b738 <commands+0x210>
ffffffffc0203572:	28f00593          	li	a1,655
ffffffffc0203576:	00009517          	auipc	a0,0x9
ffffffffc020357a:	dfa50513          	addi	a0,a0,-518 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020357e:	f21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203582:	00009697          	auipc	a3,0x9
ffffffffc0203586:	25e68693          	addi	a3,a3,606 # ffffffffc020c7e0 <default_pmm_manager+0x5c0>
ffffffffc020358a:	00008617          	auipc	a2,0x8
ffffffffc020358e:	1ae60613          	addi	a2,a2,430 # ffffffffc020b738 <commands+0x210>
ffffffffc0203592:	26e00593          	li	a1,622
ffffffffc0203596:	00009517          	auipc	a0,0x9
ffffffffc020359a:	dda50513          	addi	a0,a0,-550 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020359e:	f01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035a2:	00009697          	auipc	a3,0x9
ffffffffc02035a6:	20e68693          	addi	a3,a3,526 # ffffffffc020c7b0 <default_pmm_manager+0x590>
ffffffffc02035aa:	00008617          	auipc	a2,0x8
ffffffffc02035ae:	18e60613          	addi	a2,a2,398 # ffffffffc020b738 <commands+0x210>
ffffffffc02035b2:	26400593          	li	a1,612
ffffffffc02035b6:	00009517          	auipc	a0,0x9
ffffffffc02035ba:	dba50513          	addi	a0,a0,-582 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02035be:	ee1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c2:	00009697          	auipc	a3,0x9
ffffffffc02035c6:	05e68693          	addi	a3,a3,94 # ffffffffc020c620 <default_pmm_manager+0x400>
ffffffffc02035ca:	00008617          	auipc	a2,0x8
ffffffffc02035ce:	16e60613          	addi	a2,a2,366 # ffffffffc020b738 <commands+0x210>
ffffffffc02035d2:	26300593          	li	a1,611
ffffffffc02035d6:	00009517          	auipc	a0,0x9
ffffffffc02035da:	d9a50513          	addi	a0,a0,-614 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02035de:	ec1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e2:	00009697          	auipc	a3,0x9
ffffffffc02035e6:	1b668693          	addi	a3,a3,438 # ffffffffc020c798 <default_pmm_manager+0x578>
ffffffffc02035ea:	00008617          	auipc	a2,0x8
ffffffffc02035ee:	14e60613          	addi	a2,a2,334 # ffffffffc020b738 <commands+0x210>
ffffffffc02035f2:	26800593          	li	a1,616
ffffffffc02035f6:	00009517          	auipc	a0,0x9
ffffffffc02035fa:	d7a50513          	addi	a0,a0,-646 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02035fe:	ea1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203602:	00009697          	auipc	a3,0x9
ffffffffc0203606:	03668693          	addi	a3,a3,54 # ffffffffc020c638 <default_pmm_manager+0x418>
ffffffffc020360a:	00008617          	auipc	a2,0x8
ffffffffc020360e:	12e60613          	addi	a2,a2,302 # ffffffffc020b738 <commands+0x210>
ffffffffc0203612:	26700593          	li	a1,615
ffffffffc0203616:	00009517          	auipc	a0,0x9
ffffffffc020361a:	d5a50513          	addi	a0,a0,-678 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020361e:	e81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203622:	00009697          	auipc	a3,0x9
ffffffffc0203626:	28e68693          	addi	a3,a3,654 # ffffffffc020c8b0 <default_pmm_manager+0x690>
ffffffffc020362a:	00008617          	auipc	a2,0x8
ffffffffc020362e:	10e60613          	addi	a2,a2,270 # ffffffffc020b738 <commands+0x210>
ffffffffc0203632:	28900593          	li	a1,649
ffffffffc0203636:	00009517          	auipc	a0,0x9
ffffffffc020363a:	d3a50513          	addi	a0,a0,-710 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020363e:	e61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203642:	00009697          	auipc	a3,0x9
ffffffffc0203646:	2c668693          	addi	a3,a3,710 # ffffffffc020c908 <default_pmm_manager+0x6e8>
ffffffffc020364a:	00008617          	auipc	a2,0x8
ffffffffc020364e:	0ee60613          	addi	a2,a2,238 # ffffffffc020b738 <commands+0x210>
ffffffffc0203652:	28e00593          	li	a1,654
ffffffffc0203656:	00009517          	auipc	a0,0x9
ffffffffc020365a:	d1a50513          	addi	a0,a0,-742 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020365e:	e41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203662:	00009697          	auipc	a3,0x9
ffffffffc0203666:	26668693          	addi	a3,a3,614 # ffffffffc020c8c8 <default_pmm_manager+0x6a8>
ffffffffc020366a:	00008617          	auipc	a2,0x8
ffffffffc020366e:	0ce60613          	addi	a2,a2,206 # ffffffffc020b738 <commands+0x210>
ffffffffc0203672:	28d00593          	li	a1,653
ffffffffc0203676:	00009517          	auipc	a0,0x9
ffffffffc020367a:	cfa50513          	addi	a0,a0,-774 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020367e:	e21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203682:	00009697          	auipc	a3,0x9
ffffffffc0203686:	34e68693          	addi	a3,a3,846 # ffffffffc020c9d0 <default_pmm_manager+0x7b0>
ffffffffc020368a:	00008617          	auipc	a2,0x8
ffffffffc020368e:	0ae60613          	addi	a2,a2,174 # ffffffffc020b738 <commands+0x210>
ffffffffc0203692:	29700593          	li	a1,663
ffffffffc0203696:	00009517          	auipc	a0,0x9
ffffffffc020369a:	cda50513          	addi	a0,a0,-806 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020369e:	e01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a2:	00009697          	auipc	a3,0x9
ffffffffc02036a6:	2f668693          	addi	a3,a3,758 # ffffffffc020c998 <default_pmm_manager+0x778>
ffffffffc02036aa:	00008617          	auipc	a2,0x8
ffffffffc02036ae:	08e60613          	addi	a2,a2,142 # ffffffffc020b738 <commands+0x210>
ffffffffc02036b2:	29400593          	li	a1,660
ffffffffc02036b6:	00009517          	auipc	a0,0x9
ffffffffc02036ba:	cba50513          	addi	a0,a0,-838 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02036be:	de1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c2:	00009697          	auipc	a3,0x9
ffffffffc02036c6:	2a668693          	addi	a3,a3,678 # ffffffffc020c968 <default_pmm_manager+0x748>
ffffffffc02036ca:	00008617          	auipc	a2,0x8
ffffffffc02036ce:	06e60613          	addi	a2,a2,110 # ffffffffc020b738 <commands+0x210>
ffffffffc02036d2:	29000593          	li	a1,656
ffffffffc02036d6:	00009517          	auipc	a0,0x9
ffffffffc02036da:	c9a50513          	addi	a0,a0,-870 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02036de:	dc1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e2:	86a2                	mv	a3,s0
ffffffffc02036e4:	00009617          	auipc	a2,0x9
ffffffffc02036e8:	c1c60613          	addi	a2,a2,-996 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc02036ec:	0dc00593          	li	a1,220
ffffffffc02036f0:	00009517          	auipc	a0,0x9
ffffffffc02036f4:	c8050513          	addi	a0,a0,-896 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02036f8:	da7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036fc:	86ae                	mv	a3,a1
ffffffffc02036fe:	00009617          	auipc	a2,0x9
ffffffffc0203702:	c0260613          	addi	a2,a2,-1022 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0203706:	0db00593          	li	a1,219
ffffffffc020370a:	00009517          	auipc	a0,0x9
ffffffffc020370e:	c6650513          	addi	a0,a0,-922 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203712:	d8dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203716:	00009697          	auipc	a3,0x9
ffffffffc020371a:	e3a68693          	addi	a3,a3,-454 # ffffffffc020c550 <default_pmm_manager+0x330>
ffffffffc020371e:	00008617          	auipc	a2,0x8
ffffffffc0203722:	01a60613          	addi	a2,a2,26 # ffffffffc020b738 <commands+0x210>
ffffffffc0203726:	24700593          	li	a1,583
ffffffffc020372a:	00009517          	auipc	a0,0x9
ffffffffc020372e:	c4650513          	addi	a0,a0,-954 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203732:	d6dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203736:	00009697          	auipc	a3,0x9
ffffffffc020373a:	dfa68693          	addi	a3,a3,-518 # ffffffffc020c530 <default_pmm_manager+0x310>
ffffffffc020373e:	00008617          	auipc	a2,0x8
ffffffffc0203742:	ffa60613          	addi	a2,a2,-6 # ffffffffc020b738 <commands+0x210>
ffffffffc0203746:	24600593          	li	a1,582
ffffffffc020374a:	00009517          	auipc	a0,0x9
ffffffffc020374e:	c2650513          	addi	a0,a0,-986 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203752:	d4dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203756:	00009617          	auipc	a2,0x9
ffffffffc020375a:	d6a60613          	addi	a2,a2,-662 # ffffffffc020c4c0 <default_pmm_manager+0x2a0>
ffffffffc020375e:	0aa00593          	li	a1,170
ffffffffc0203762:	00009517          	auipc	a0,0x9
ffffffffc0203766:	c0e50513          	addi	a0,a0,-1010 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020376a:	d35fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020376e:	00009617          	auipc	a2,0x9
ffffffffc0203772:	cba60613          	addi	a2,a2,-838 # ffffffffc020c428 <default_pmm_manager+0x208>
ffffffffc0203776:	06500593          	li	a1,101
ffffffffc020377a:	00009517          	auipc	a0,0x9
ffffffffc020377e:	bf650513          	addi	a0,a0,-1034 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203782:	d1dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203786:	00009697          	auipc	a3,0x9
ffffffffc020378a:	08a68693          	addi	a3,a3,138 # ffffffffc020c810 <default_pmm_manager+0x5f0>
ffffffffc020378e:	00008617          	auipc	a2,0x8
ffffffffc0203792:	faa60613          	addi	a2,a2,-86 # ffffffffc020b738 <commands+0x210>
ffffffffc0203796:	2a000593          	li	a1,672
ffffffffc020379a:	00009517          	auipc	a0,0x9
ffffffffc020379e:	bd650513          	addi	a0,a0,-1066 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02037a2:	cfdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037a6:	00009697          	auipc	a3,0x9
ffffffffc02037aa:	eaa68693          	addi	a3,a3,-342 # ffffffffc020c650 <default_pmm_manager+0x430>
ffffffffc02037ae:	00008617          	auipc	a2,0x8
ffffffffc02037b2:	f8a60613          	addi	a2,a2,-118 # ffffffffc020b738 <commands+0x210>
ffffffffc02037b6:	25500593          	li	a1,597
ffffffffc02037ba:	00009517          	auipc	a0,0x9
ffffffffc02037be:	bb650513          	addi	a0,a0,-1098 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02037c2:	cddfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037c6:	86d6                	mv	a3,s5
ffffffffc02037c8:	00009617          	auipc	a2,0x9
ffffffffc02037cc:	a9060613          	addi	a2,a2,-1392 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc02037d0:	25400593          	li	a1,596
ffffffffc02037d4:	00009517          	auipc	a0,0x9
ffffffffc02037d8:	b9c50513          	addi	a0,a0,-1124 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02037dc:	cc3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037e0:	00009697          	auipc	a3,0x9
ffffffffc02037e4:	fb868693          	addi	a3,a3,-72 # ffffffffc020c798 <default_pmm_manager+0x578>
ffffffffc02037e8:	00008617          	auipc	a2,0x8
ffffffffc02037ec:	f5060613          	addi	a2,a2,-176 # ffffffffc020b738 <commands+0x210>
ffffffffc02037f0:	26100593          	li	a1,609
ffffffffc02037f4:	00009517          	auipc	a0,0x9
ffffffffc02037f8:	b7c50513          	addi	a0,a0,-1156 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02037fc:	ca3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203800:	00009697          	auipc	a3,0x9
ffffffffc0203804:	f8068693          	addi	a3,a3,-128 # ffffffffc020c780 <default_pmm_manager+0x560>
ffffffffc0203808:	00008617          	auipc	a2,0x8
ffffffffc020380c:	f3060613          	addi	a2,a2,-208 # ffffffffc020b738 <commands+0x210>
ffffffffc0203810:	26000593          	li	a1,608
ffffffffc0203814:	00009517          	auipc	a0,0x9
ffffffffc0203818:	b5c50513          	addi	a0,a0,-1188 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020381c:	c83fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203820:	00009697          	auipc	a3,0x9
ffffffffc0203824:	f3068693          	addi	a3,a3,-208 # ffffffffc020c750 <default_pmm_manager+0x530>
ffffffffc0203828:	00008617          	auipc	a2,0x8
ffffffffc020382c:	f1060613          	addi	a2,a2,-240 # ffffffffc020b738 <commands+0x210>
ffffffffc0203830:	25f00593          	li	a1,607
ffffffffc0203834:	00009517          	auipc	a0,0x9
ffffffffc0203838:	b3c50513          	addi	a0,a0,-1220 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020383c:	c63fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203840:	00009697          	auipc	a3,0x9
ffffffffc0203844:	ef868693          	addi	a3,a3,-264 # ffffffffc020c738 <default_pmm_manager+0x518>
ffffffffc0203848:	00008617          	auipc	a2,0x8
ffffffffc020384c:	ef060613          	addi	a2,a2,-272 # ffffffffc020b738 <commands+0x210>
ffffffffc0203850:	25d00593          	li	a1,605
ffffffffc0203854:	00009517          	auipc	a0,0x9
ffffffffc0203858:	b1c50513          	addi	a0,a0,-1252 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020385c:	c43fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203860:	00009697          	auipc	a3,0x9
ffffffffc0203864:	eb868693          	addi	a3,a3,-328 # ffffffffc020c718 <default_pmm_manager+0x4f8>
ffffffffc0203868:	00008617          	auipc	a2,0x8
ffffffffc020386c:	ed060613          	addi	a2,a2,-304 # ffffffffc020b738 <commands+0x210>
ffffffffc0203870:	25c00593          	li	a1,604
ffffffffc0203874:	00009517          	auipc	a0,0x9
ffffffffc0203878:	afc50513          	addi	a0,a0,-1284 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020387c:	c23fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203880:	00009697          	auipc	a3,0x9
ffffffffc0203884:	e8868693          	addi	a3,a3,-376 # ffffffffc020c708 <default_pmm_manager+0x4e8>
ffffffffc0203888:	00008617          	auipc	a2,0x8
ffffffffc020388c:	eb060613          	addi	a2,a2,-336 # ffffffffc020b738 <commands+0x210>
ffffffffc0203890:	25b00593          	li	a1,603
ffffffffc0203894:	00009517          	auipc	a0,0x9
ffffffffc0203898:	adc50513          	addi	a0,a0,-1316 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020389c:	c03fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a0:	00009697          	auipc	a3,0x9
ffffffffc02038a4:	e5868693          	addi	a3,a3,-424 # ffffffffc020c6f8 <default_pmm_manager+0x4d8>
ffffffffc02038a8:	00008617          	auipc	a2,0x8
ffffffffc02038ac:	e9060613          	addi	a2,a2,-368 # ffffffffc020b738 <commands+0x210>
ffffffffc02038b0:	25a00593          	li	a1,602
ffffffffc02038b4:	00009517          	auipc	a0,0x9
ffffffffc02038b8:	abc50513          	addi	a0,a0,-1348 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02038bc:	be3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038c0:	00009697          	auipc	a3,0x9
ffffffffc02038c4:	e0068693          	addi	a3,a3,-512 # ffffffffc020c6c0 <default_pmm_manager+0x4a0>
ffffffffc02038c8:	00008617          	auipc	a2,0x8
ffffffffc02038cc:	e7060613          	addi	a2,a2,-400 # ffffffffc020b738 <commands+0x210>
ffffffffc02038d0:	25900593          	li	a1,601
ffffffffc02038d4:	00009517          	auipc	a0,0x9
ffffffffc02038d8:	a9c50513          	addi	a0,a0,-1380 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02038dc:	bc3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038e0:	00009697          	auipc	a3,0x9
ffffffffc02038e4:	f3068693          	addi	a3,a3,-208 # ffffffffc020c810 <default_pmm_manager+0x5f0>
ffffffffc02038e8:	00008617          	auipc	a2,0x8
ffffffffc02038ec:	e5060613          	addi	a2,a2,-432 # ffffffffc020b738 <commands+0x210>
ffffffffc02038f0:	27600593          	li	a1,630
ffffffffc02038f4:	00009517          	auipc	a0,0x9
ffffffffc02038f8:	a7c50513          	addi	a0,a0,-1412 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02038fc:	ba3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203900:	00009617          	auipc	a2,0x9
ffffffffc0203904:	95860613          	addi	a2,a2,-1704 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc0203908:	07100593          	li	a1,113
ffffffffc020390c:	00009517          	auipc	a0,0x9
ffffffffc0203910:	97450513          	addi	a0,a0,-1676 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0203914:	b8bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203918:	86a2                	mv	a3,s0
ffffffffc020391a:	00009617          	auipc	a2,0x9
ffffffffc020391e:	9e660613          	addi	a2,a2,-1562 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0203922:	0ca00593          	li	a1,202
ffffffffc0203926:	00009517          	auipc	a0,0x9
ffffffffc020392a:	a4a50513          	addi	a0,a0,-1462 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc020392e:	b71fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203932:	00009617          	auipc	a2,0x9
ffffffffc0203936:	9ce60613          	addi	a2,a2,-1586 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc020393a:	08100593          	li	a1,129
ffffffffc020393e:	00009517          	auipc	a0,0x9
ffffffffc0203942:	a3250513          	addi	a0,a0,-1486 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203946:	b59fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020394a:	00009697          	auipc	a3,0x9
ffffffffc020394e:	d3668693          	addi	a3,a3,-714 # ffffffffc020c680 <default_pmm_manager+0x460>
ffffffffc0203952:	00008617          	auipc	a2,0x8
ffffffffc0203956:	de660613          	addi	a2,a2,-538 # ffffffffc020b738 <commands+0x210>
ffffffffc020395a:	25800593          	li	a1,600
ffffffffc020395e:	00009517          	auipc	a0,0x9
ffffffffc0203962:	a1250513          	addi	a0,a0,-1518 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203966:	b39fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020396a:	00009697          	auipc	a3,0x9
ffffffffc020396e:	c5668693          	addi	a3,a3,-938 # ffffffffc020c5c0 <default_pmm_manager+0x3a0>
ffffffffc0203972:	00008617          	auipc	a2,0x8
ffffffffc0203976:	dc660613          	addi	a2,a2,-570 # ffffffffc020b738 <commands+0x210>
ffffffffc020397a:	24c00593          	li	a1,588
ffffffffc020397e:	00009517          	auipc	a0,0x9
ffffffffc0203982:	9f250513          	addi	a0,a0,-1550 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203986:	b19fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020398a:	fc6fe0ef          	jal	ra,ffffffffc0202150 <pte2page.part.0>
ffffffffc020398e:	00009697          	auipc	a3,0x9
ffffffffc0203992:	c6268693          	addi	a3,a3,-926 # ffffffffc020c5f0 <default_pmm_manager+0x3d0>
ffffffffc0203996:	00008617          	auipc	a2,0x8
ffffffffc020399a:	da260613          	addi	a2,a2,-606 # ffffffffc020b738 <commands+0x210>
ffffffffc020399e:	24f00593          	li	a1,591
ffffffffc02039a2:	00009517          	auipc	a0,0x9
ffffffffc02039a6:	9ce50513          	addi	a0,a0,-1586 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02039aa:	af5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039ae:	00009697          	auipc	a3,0x9
ffffffffc02039b2:	be268693          	addi	a3,a3,-1054 # ffffffffc020c590 <default_pmm_manager+0x370>
ffffffffc02039b6:	00008617          	auipc	a2,0x8
ffffffffc02039ba:	d8260613          	addi	a2,a2,-638 # ffffffffc020b738 <commands+0x210>
ffffffffc02039be:	24800593          	li	a1,584
ffffffffc02039c2:	00009517          	auipc	a0,0x9
ffffffffc02039c6:	9ae50513          	addi	a0,a0,-1618 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02039ca:	ad5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039ce:	00009697          	auipc	a3,0x9
ffffffffc02039d2:	c5268693          	addi	a3,a3,-942 # ffffffffc020c620 <default_pmm_manager+0x400>
ffffffffc02039d6:	00008617          	auipc	a2,0x8
ffffffffc02039da:	d6260613          	addi	a2,a2,-670 # ffffffffc020b738 <commands+0x210>
ffffffffc02039de:	25000593          	li	a1,592
ffffffffc02039e2:	00009517          	auipc	a0,0x9
ffffffffc02039e6:	98e50513          	addi	a0,a0,-1650 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc02039ea:	ab5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039ee:	00009617          	auipc	a2,0x9
ffffffffc02039f2:	86a60613          	addi	a2,a2,-1942 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc02039f6:	25300593          	li	a1,595
ffffffffc02039fa:	00009517          	auipc	a0,0x9
ffffffffc02039fe:	97650513          	addi	a0,a0,-1674 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203a02:	a9dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a06:	00009697          	auipc	a3,0x9
ffffffffc0203a0a:	c3268693          	addi	a3,a3,-974 # ffffffffc020c638 <default_pmm_manager+0x418>
ffffffffc0203a0e:	00008617          	auipc	a2,0x8
ffffffffc0203a12:	d2a60613          	addi	a2,a2,-726 # ffffffffc020b738 <commands+0x210>
ffffffffc0203a16:	25100593          	li	a1,593
ffffffffc0203a1a:	00009517          	auipc	a0,0x9
ffffffffc0203a1e:	95650513          	addi	a0,a0,-1706 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203a22:	a7dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a26:	86ca                	mv	a3,s2
ffffffffc0203a28:	00009617          	auipc	a2,0x9
ffffffffc0203a2c:	8d860613          	addi	a2,a2,-1832 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0203a30:	0c600593          	li	a1,198
ffffffffc0203a34:	00009517          	auipc	a0,0x9
ffffffffc0203a38:	93c50513          	addi	a0,a0,-1732 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203a3c:	a63fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a40:	00009697          	auipc	a3,0x9
ffffffffc0203a44:	d5868693          	addi	a3,a3,-680 # ffffffffc020c798 <default_pmm_manager+0x578>
ffffffffc0203a48:	00008617          	auipc	a2,0x8
ffffffffc0203a4c:	cf060613          	addi	a2,a2,-784 # ffffffffc020b738 <commands+0x210>
ffffffffc0203a50:	26c00593          	li	a1,620
ffffffffc0203a54:	00009517          	auipc	a0,0x9
ffffffffc0203a58:	91c50513          	addi	a0,a0,-1764 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203a5c:	a43fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a60:	00009697          	auipc	a3,0x9
ffffffffc0203a64:	d6868693          	addi	a3,a3,-664 # ffffffffc020c7c8 <default_pmm_manager+0x5a8>
ffffffffc0203a68:	00008617          	auipc	a2,0x8
ffffffffc0203a6c:	cd060613          	addi	a2,a2,-816 # ffffffffc020b738 <commands+0x210>
ffffffffc0203a70:	26b00593          	li	a1,619
ffffffffc0203a74:	00009517          	auipc	a0,0x9
ffffffffc0203a78:	8fc50513          	addi	a0,a0,-1796 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203a7c:	a23fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203a80 <pgdir_alloc_page>:
ffffffffc0203a80:	7179                	addi	sp,sp,-48
ffffffffc0203a82:	ec26                	sd	s1,24(sp)
ffffffffc0203a84:	e84a                	sd	s2,16(sp)
ffffffffc0203a86:	e052                	sd	s4,0(sp)
ffffffffc0203a88:	f406                	sd	ra,40(sp)
ffffffffc0203a8a:	f022                	sd	s0,32(sp)
ffffffffc0203a8c:	e44e                	sd	s3,8(sp)
ffffffffc0203a8e:	8a2a                	mv	s4,a0
ffffffffc0203a90:	84ae                	mv	s1,a1
ffffffffc0203a92:	8932                	mv	s2,a2
ffffffffc0203a94:	100027f3          	csrr	a5,sstatus
ffffffffc0203a98:	8b89                	andi	a5,a5,2
ffffffffc0203a9a:	00093997          	auipc	s3,0x93
ffffffffc0203a9e:	e1698993          	addi	s3,s3,-490 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203aa2:	ef8d                	bnez	a5,ffffffffc0203adc <pgdir_alloc_page+0x5c>
ffffffffc0203aa4:	0009b783          	ld	a5,0(s3)
ffffffffc0203aa8:	4505                	li	a0,1
ffffffffc0203aaa:	6f9c                	ld	a5,24(a5)
ffffffffc0203aac:	9782                	jalr	a5
ffffffffc0203aae:	842a                	mv	s0,a0
ffffffffc0203ab0:	cc09                	beqz	s0,ffffffffc0203aca <pgdir_alloc_page+0x4a>
ffffffffc0203ab2:	86ca                	mv	a3,s2
ffffffffc0203ab4:	8626                	mv	a2,s1
ffffffffc0203ab6:	85a2                	mv	a1,s0
ffffffffc0203ab8:	8552                	mv	a0,s4
ffffffffc0203aba:	8deff0ef          	jal	ra,ffffffffc0202b98 <page_insert>
ffffffffc0203abe:	e915                	bnez	a0,ffffffffc0203af2 <pgdir_alloc_page+0x72>
ffffffffc0203ac0:	4018                	lw	a4,0(s0)
ffffffffc0203ac2:	fc04                	sd	s1,56(s0)
ffffffffc0203ac4:	4785                	li	a5,1
ffffffffc0203ac6:	04f71e63          	bne	a4,a5,ffffffffc0203b22 <pgdir_alloc_page+0xa2>
ffffffffc0203aca:	70a2                	ld	ra,40(sp)
ffffffffc0203acc:	8522                	mv	a0,s0
ffffffffc0203ace:	7402                	ld	s0,32(sp)
ffffffffc0203ad0:	64e2                	ld	s1,24(sp)
ffffffffc0203ad2:	6942                	ld	s2,16(sp)
ffffffffc0203ad4:	69a2                	ld	s3,8(sp)
ffffffffc0203ad6:	6a02                	ld	s4,0(sp)
ffffffffc0203ad8:	6145                	addi	sp,sp,48
ffffffffc0203ada:	8082                	ret
ffffffffc0203adc:	996fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203ae0:	0009b783          	ld	a5,0(s3)
ffffffffc0203ae4:	4505                	li	a0,1
ffffffffc0203ae6:	6f9c                	ld	a5,24(a5)
ffffffffc0203ae8:	9782                	jalr	a5
ffffffffc0203aea:	842a                	mv	s0,a0
ffffffffc0203aec:	980fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203af0:	b7c1                	j	ffffffffc0203ab0 <pgdir_alloc_page+0x30>
ffffffffc0203af2:	100027f3          	csrr	a5,sstatus
ffffffffc0203af6:	8b89                	andi	a5,a5,2
ffffffffc0203af8:	eb89                	bnez	a5,ffffffffc0203b0a <pgdir_alloc_page+0x8a>
ffffffffc0203afa:	0009b783          	ld	a5,0(s3)
ffffffffc0203afe:	8522                	mv	a0,s0
ffffffffc0203b00:	4585                	li	a1,1
ffffffffc0203b02:	739c                	ld	a5,32(a5)
ffffffffc0203b04:	4401                	li	s0,0
ffffffffc0203b06:	9782                	jalr	a5
ffffffffc0203b08:	b7c9                	j	ffffffffc0203aca <pgdir_alloc_page+0x4a>
ffffffffc0203b0a:	968fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203b0e:	0009b783          	ld	a5,0(s3)
ffffffffc0203b12:	8522                	mv	a0,s0
ffffffffc0203b14:	4585                	li	a1,1
ffffffffc0203b16:	739c                	ld	a5,32(a5)
ffffffffc0203b18:	4401                	li	s0,0
ffffffffc0203b1a:	9782                	jalr	a5
ffffffffc0203b1c:	950fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203b20:	b76d                	j	ffffffffc0203aca <pgdir_alloc_page+0x4a>
ffffffffc0203b22:	00009697          	auipc	a3,0x9
ffffffffc0203b26:	ef668693          	addi	a3,a3,-266 # ffffffffc020ca18 <default_pmm_manager+0x7f8>
ffffffffc0203b2a:	00008617          	auipc	a2,0x8
ffffffffc0203b2e:	c0e60613          	addi	a2,a2,-1010 # ffffffffc020b738 <commands+0x210>
ffffffffc0203b32:	22d00593          	li	a1,557
ffffffffc0203b36:	00009517          	auipc	a0,0x9
ffffffffc0203b3a:	83a50513          	addi	a0,a0,-1990 # ffffffffc020c370 <default_pmm_manager+0x150>
ffffffffc0203b3e:	961fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b42 <check_vma_overlap.part.0>:
ffffffffc0203b42:	1141                	addi	sp,sp,-16
ffffffffc0203b44:	00009697          	auipc	a3,0x9
ffffffffc0203b48:	eec68693          	addi	a3,a3,-276 # ffffffffc020ca30 <default_pmm_manager+0x810>
ffffffffc0203b4c:	00008617          	auipc	a2,0x8
ffffffffc0203b50:	bec60613          	addi	a2,a2,-1044 # ffffffffc020b738 <commands+0x210>
ffffffffc0203b54:	07400593          	li	a1,116
ffffffffc0203b58:	00009517          	auipc	a0,0x9
ffffffffc0203b5c:	ef850513          	addi	a0,a0,-264 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203b60:	e406                	sd	ra,8(sp)
ffffffffc0203b62:	93dfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b66 <mm_create>:
ffffffffc0203b66:	1141                	addi	sp,sp,-16
ffffffffc0203b68:	05800513          	li	a0,88
ffffffffc0203b6c:	e022                	sd	s0,0(sp)
ffffffffc0203b6e:	e406                	sd	ra,8(sp)
ffffffffc0203b70:	c1efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203b74:	842a                	mv	s0,a0
ffffffffc0203b76:	c115                	beqz	a0,ffffffffc0203b9a <mm_create+0x34>
ffffffffc0203b78:	e408                	sd	a0,8(s0)
ffffffffc0203b7a:	e008                	sd	a0,0(s0)
ffffffffc0203b7c:	00053823          	sd	zero,16(a0)
ffffffffc0203b80:	00053c23          	sd	zero,24(a0)
ffffffffc0203b84:	02052023          	sw	zero,32(a0)
ffffffffc0203b88:	02053423          	sd	zero,40(a0)
ffffffffc0203b8c:	02052823          	sw	zero,48(a0)
ffffffffc0203b90:	4585                	li	a1,1
ffffffffc0203b92:	03850513          	addi	a0,a0,56
ffffffffc0203b96:	123000ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0203b9a:	60a2                	ld	ra,8(sp)
ffffffffc0203b9c:	8522                	mv	a0,s0
ffffffffc0203b9e:	6402                	ld	s0,0(sp)
ffffffffc0203ba0:	0141                	addi	sp,sp,16
ffffffffc0203ba2:	8082                	ret

ffffffffc0203ba4 <find_vma>:
ffffffffc0203ba4:	86aa                	mv	a3,a0
ffffffffc0203ba6:	c505                	beqz	a0,ffffffffc0203bce <find_vma+0x2a>
ffffffffc0203ba8:	6908                	ld	a0,16(a0)
ffffffffc0203baa:	c501                	beqz	a0,ffffffffc0203bb2 <find_vma+0xe>
ffffffffc0203bac:	651c                	ld	a5,8(a0)
ffffffffc0203bae:	02f5f263          	bgeu	a1,a5,ffffffffc0203bd2 <find_vma+0x2e>
ffffffffc0203bb2:	669c                	ld	a5,8(a3)
ffffffffc0203bb4:	00f68d63          	beq	a3,a5,ffffffffc0203bce <find_vma+0x2a>
ffffffffc0203bb8:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203bbc:	00e5e663          	bltu	a1,a4,ffffffffc0203bc8 <find_vma+0x24>
ffffffffc0203bc0:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203bc4:	00e5ec63          	bltu	a1,a4,ffffffffc0203bdc <find_vma+0x38>
ffffffffc0203bc8:	679c                	ld	a5,8(a5)
ffffffffc0203bca:	fef697e3          	bne	a3,a5,ffffffffc0203bb8 <find_vma+0x14>
ffffffffc0203bce:	4501                	li	a0,0
ffffffffc0203bd0:	8082                	ret
ffffffffc0203bd2:	691c                	ld	a5,16(a0)
ffffffffc0203bd4:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203bb2 <find_vma+0xe>
ffffffffc0203bd8:	ea88                	sd	a0,16(a3)
ffffffffc0203bda:	8082                	ret
ffffffffc0203bdc:	fe078513          	addi	a0,a5,-32
ffffffffc0203be0:	ea88                	sd	a0,16(a3)
ffffffffc0203be2:	8082                	ret

ffffffffc0203be4 <insert_vma_struct>:
ffffffffc0203be4:	6590                	ld	a2,8(a1)
ffffffffc0203be6:	0105b803          	ld	a6,16(a1)
ffffffffc0203bea:	1141                	addi	sp,sp,-16
ffffffffc0203bec:	e406                	sd	ra,8(sp)
ffffffffc0203bee:	87aa                	mv	a5,a0
ffffffffc0203bf0:	01066763          	bltu	a2,a6,ffffffffc0203bfe <insert_vma_struct+0x1a>
ffffffffc0203bf4:	a085                	j	ffffffffc0203c54 <insert_vma_struct+0x70>
ffffffffc0203bf6:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203bfa:	04e66863          	bltu	a2,a4,ffffffffc0203c4a <insert_vma_struct+0x66>
ffffffffc0203bfe:	86be                	mv	a3,a5
ffffffffc0203c00:	679c                	ld	a5,8(a5)
ffffffffc0203c02:	fef51ae3          	bne	a0,a5,ffffffffc0203bf6 <insert_vma_struct+0x12>
ffffffffc0203c06:	02a68463          	beq	a3,a0,ffffffffc0203c2e <insert_vma_struct+0x4a>
ffffffffc0203c0a:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203c0e:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203c12:	08e8f163          	bgeu	a7,a4,ffffffffc0203c94 <insert_vma_struct+0xb0>
ffffffffc0203c16:	04e66f63          	bltu	a2,a4,ffffffffc0203c74 <insert_vma_struct+0x90>
ffffffffc0203c1a:	00f50a63          	beq	a0,a5,ffffffffc0203c2e <insert_vma_struct+0x4a>
ffffffffc0203c1e:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203c22:	05076963          	bltu	a4,a6,ffffffffc0203c74 <insert_vma_struct+0x90>
ffffffffc0203c26:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203c2a:	02c77363          	bgeu	a4,a2,ffffffffc0203c50 <insert_vma_struct+0x6c>
ffffffffc0203c2e:	5118                	lw	a4,32(a0)
ffffffffc0203c30:	e188                	sd	a0,0(a1)
ffffffffc0203c32:	02058613          	addi	a2,a1,32
ffffffffc0203c36:	e390                	sd	a2,0(a5)
ffffffffc0203c38:	e690                	sd	a2,8(a3)
ffffffffc0203c3a:	60a2                	ld	ra,8(sp)
ffffffffc0203c3c:	f59c                	sd	a5,40(a1)
ffffffffc0203c3e:	f194                	sd	a3,32(a1)
ffffffffc0203c40:	0017079b          	addiw	a5,a4,1
ffffffffc0203c44:	d11c                	sw	a5,32(a0)
ffffffffc0203c46:	0141                	addi	sp,sp,16
ffffffffc0203c48:	8082                	ret
ffffffffc0203c4a:	fca690e3          	bne	a3,a0,ffffffffc0203c0a <insert_vma_struct+0x26>
ffffffffc0203c4e:	bfd1                	j	ffffffffc0203c22 <insert_vma_struct+0x3e>
ffffffffc0203c50:	ef3ff0ef          	jal	ra,ffffffffc0203b42 <check_vma_overlap.part.0>
ffffffffc0203c54:	00009697          	auipc	a3,0x9
ffffffffc0203c58:	e0c68693          	addi	a3,a3,-500 # ffffffffc020ca60 <default_pmm_manager+0x840>
ffffffffc0203c5c:	00008617          	auipc	a2,0x8
ffffffffc0203c60:	adc60613          	addi	a2,a2,-1316 # ffffffffc020b738 <commands+0x210>
ffffffffc0203c64:	07a00593          	li	a1,122
ffffffffc0203c68:	00009517          	auipc	a0,0x9
ffffffffc0203c6c:	de850513          	addi	a0,a0,-536 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203c70:	82ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203c74:	00009697          	auipc	a3,0x9
ffffffffc0203c78:	e2c68693          	addi	a3,a3,-468 # ffffffffc020caa0 <default_pmm_manager+0x880>
ffffffffc0203c7c:	00008617          	auipc	a2,0x8
ffffffffc0203c80:	abc60613          	addi	a2,a2,-1348 # ffffffffc020b738 <commands+0x210>
ffffffffc0203c84:	07300593          	li	a1,115
ffffffffc0203c88:	00009517          	auipc	a0,0x9
ffffffffc0203c8c:	dc850513          	addi	a0,a0,-568 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203c90:	80ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203c94:	00009697          	auipc	a3,0x9
ffffffffc0203c98:	dec68693          	addi	a3,a3,-532 # ffffffffc020ca80 <default_pmm_manager+0x860>
ffffffffc0203c9c:	00008617          	auipc	a2,0x8
ffffffffc0203ca0:	a9c60613          	addi	a2,a2,-1380 # ffffffffc020b738 <commands+0x210>
ffffffffc0203ca4:	07200593          	li	a1,114
ffffffffc0203ca8:	00009517          	auipc	a0,0x9
ffffffffc0203cac:	da850513          	addi	a0,a0,-600 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203cb0:	feefc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203cb4 <mm_destroy>:
ffffffffc0203cb4:	591c                	lw	a5,48(a0)
ffffffffc0203cb6:	1141                	addi	sp,sp,-16
ffffffffc0203cb8:	e406                	sd	ra,8(sp)
ffffffffc0203cba:	e022                	sd	s0,0(sp)
ffffffffc0203cbc:	e78d                	bnez	a5,ffffffffc0203ce6 <mm_destroy+0x32>
ffffffffc0203cbe:	842a                	mv	s0,a0
ffffffffc0203cc0:	6508                	ld	a0,8(a0)
ffffffffc0203cc2:	00a40c63          	beq	s0,a0,ffffffffc0203cda <mm_destroy+0x26>
ffffffffc0203cc6:	6118                	ld	a4,0(a0)
ffffffffc0203cc8:	651c                	ld	a5,8(a0)
ffffffffc0203cca:	1501                	addi	a0,a0,-32
ffffffffc0203ccc:	e71c                	sd	a5,8(a4)
ffffffffc0203cce:	e398                	sd	a4,0(a5)
ffffffffc0203cd0:	b6efe0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0203cd4:	6408                	ld	a0,8(s0)
ffffffffc0203cd6:	fea418e3          	bne	s0,a0,ffffffffc0203cc6 <mm_destroy+0x12>
ffffffffc0203cda:	8522                	mv	a0,s0
ffffffffc0203cdc:	6402                	ld	s0,0(sp)
ffffffffc0203cde:	60a2                	ld	ra,8(sp)
ffffffffc0203ce0:	0141                	addi	sp,sp,16
ffffffffc0203ce2:	b5cfe06f          	j	ffffffffc020203e <kfree>
ffffffffc0203ce6:	00009697          	auipc	a3,0x9
ffffffffc0203cea:	dda68693          	addi	a3,a3,-550 # ffffffffc020cac0 <default_pmm_manager+0x8a0>
ffffffffc0203cee:	00008617          	auipc	a2,0x8
ffffffffc0203cf2:	a4a60613          	addi	a2,a2,-1462 # ffffffffc020b738 <commands+0x210>
ffffffffc0203cf6:	09e00593          	li	a1,158
ffffffffc0203cfa:	00009517          	auipc	a0,0x9
ffffffffc0203cfe:	d5650513          	addi	a0,a0,-682 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203d02:	f9cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d06 <mm_map>:
ffffffffc0203d06:	7139                	addi	sp,sp,-64
ffffffffc0203d08:	f822                	sd	s0,48(sp)
ffffffffc0203d0a:	6405                	lui	s0,0x1
ffffffffc0203d0c:	147d                	addi	s0,s0,-1
ffffffffc0203d0e:	77fd                	lui	a5,0xfffff
ffffffffc0203d10:	9622                	add	a2,a2,s0
ffffffffc0203d12:	962e                	add	a2,a2,a1
ffffffffc0203d14:	f426                	sd	s1,40(sp)
ffffffffc0203d16:	fc06                	sd	ra,56(sp)
ffffffffc0203d18:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203d1c:	f04a                	sd	s2,32(sp)
ffffffffc0203d1e:	ec4e                	sd	s3,24(sp)
ffffffffc0203d20:	e852                	sd	s4,16(sp)
ffffffffc0203d22:	e456                	sd	s5,8(sp)
ffffffffc0203d24:	002005b7          	lui	a1,0x200
ffffffffc0203d28:	00f67433          	and	s0,a2,a5
ffffffffc0203d2c:	06b4e363          	bltu	s1,a1,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d30:	0684f163          	bgeu	s1,s0,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d34:	4785                	li	a5,1
ffffffffc0203d36:	07fe                	slli	a5,a5,0x1f
ffffffffc0203d38:	0487ed63          	bltu	a5,s0,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d3c:	89aa                	mv	s3,a0
ffffffffc0203d3e:	cd21                	beqz	a0,ffffffffc0203d96 <mm_map+0x90>
ffffffffc0203d40:	85a6                	mv	a1,s1
ffffffffc0203d42:	8ab6                	mv	s5,a3
ffffffffc0203d44:	8a3a                	mv	s4,a4
ffffffffc0203d46:	e5fff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203d4a:	c501                	beqz	a0,ffffffffc0203d52 <mm_map+0x4c>
ffffffffc0203d4c:	651c                	ld	a5,8(a0)
ffffffffc0203d4e:	0487e263          	bltu	a5,s0,ffffffffc0203d92 <mm_map+0x8c>
ffffffffc0203d52:	03000513          	li	a0,48
ffffffffc0203d56:	a38fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203d5a:	892a                	mv	s2,a0
ffffffffc0203d5c:	5571                	li	a0,-4
ffffffffc0203d5e:	02090163          	beqz	s2,ffffffffc0203d80 <mm_map+0x7a>
ffffffffc0203d62:	854e                	mv	a0,s3
ffffffffc0203d64:	00993423          	sd	s1,8(s2)
ffffffffc0203d68:	00893823          	sd	s0,16(s2)
ffffffffc0203d6c:	01592c23          	sw	s5,24(s2)
ffffffffc0203d70:	85ca                	mv	a1,s2
ffffffffc0203d72:	e73ff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203d76:	4501                	li	a0,0
ffffffffc0203d78:	000a0463          	beqz	s4,ffffffffc0203d80 <mm_map+0x7a>
ffffffffc0203d7c:	012a3023          	sd	s2,0(s4)
ffffffffc0203d80:	70e2                	ld	ra,56(sp)
ffffffffc0203d82:	7442                	ld	s0,48(sp)
ffffffffc0203d84:	74a2                	ld	s1,40(sp)
ffffffffc0203d86:	7902                	ld	s2,32(sp)
ffffffffc0203d88:	69e2                	ld	s3,24(sp)
ffffffffc0203d8a:	6a42                	ld	s4,16(sp)
ffffffffc0203d8c:	6aa2                	ld	s5,8(sp)
ffffffffc0203d8e:	6121                	addi	sp,sp,64
ffffffffc0203d90:	8082                	ret
ffffffffc0203d92:	5575                	li	a0,-3
ffffffffc0203d94:	b7f5                	j	ffffffffc0203d80 <mm_map+0x7a>
ffffffffc0203d96:	00009697          	auipc	a3,0x9
ffffffffc0203d9a:	d4268693          	addi	a3,a3,-702 # ffffffffc020cad8 <default_pmm_manager+0x8b8>
ffffffffc0203d9e:	00008617          	auipc	a2,0x8
ffffffffc0203da2:	99a60613          	addi	a2,a2,-1638 # ffffffffc020b738 <commands+0x210>
ffffffffc0203da6:	0b300593          	li	a1,179
ffffffffc0203daa:	00009517          	auipc	a0,0x9
ffffffffc0203dae:	ca650513          	addi	a0,a0,-858 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203db2:	eecfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203db6 <dup_mmap>:
ffffffffc0203db6:	7139                	addi	sp,sp,-64
ffffffffc0203db8:	fc06                	sd	ra,56(sp)
ffffffffc0203dba:	f822                	sd	s0,48(sp)
ffffffffc0203dbc:	f426                	sd	s1,40(sp)
ffffffffc0203dbe:	f04a                	sd	s2,32(sp)
ffffffffc0203dc0:	ec4e                	sd	s3,24(sp)
ffffffffc0203dc2:	e852                	sd	s4,16(sp)
ffffffffc0203dc4:	e456                	sd	s5,8(sp)
ffffffffc0203dc6:	c52d                	beqz	a0,ffffffffc0203e30 <dup_mmap+0x7a>
ffffffffc0203dc8:	892a                	mv	s2,a0
ffffffffc0203dca:	84ae                	mv	s1,a1
ffffffffc0203dcc:	842e                	mv	s0,a1
ffffffffc0203dce:	e595                	bnez	a1,ffffffffc0203dfa <dup_mmap+0x44>
ffffffffc0203dd0:	a085                	j	ffffffffc0203e30 <dup_mmap+0x7a>
ffffffffc0203dd2:	854a                	mv	a0,s2
ffffffffc0203dd4:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203dd8:	0145b823          	sd	s4,16(a1)
ffffffffc0203ddc:	0135ac23          	sw	s3,24(a1)
ffffffffc0203de0:	e05ff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203de4:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203de8:	fe843603          	ld	a2,-24(s0)
ffffffffc0203dec:	6c8c                	ld	a1,24(s1)
ffffffffc0203dee:	01893503          	ld	a0,24(s2)
ffffffffc0203df2:	4701                	li	a4,0
ffffffffc0203df4:	b4bfe0ef          	jal	ra,ffffffffc020293e <copy_range>
ffffffffc0203df8:	e105                	bnez	a0,ffffffffc0203e18 <dup_mmap+0x62>
ffffffffc0203dfa:	6000                	ld	s0,0(s0)
ffffffffc0203dfc:	02848863          	beq	s1,s0,ffffffffc0203e2c <dup_mmap+0x76>
ffffffffc0203e00:	03000513          	li	a0,48
ffffffffc0203e04:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203e08:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203e0c:	ff842983          	lw	s3,-8(s0)
ffffffffc0203e10:	97efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203e14:	85aa                	mv	a1,a0
ffffffffc0203e16:	fd55                	bnez	a0,ffffffffc0203dd2 <dup_mmap+0x1c>
ffffffffc0203e18:	5571                	li	a0,-4
ffffffffc0203e1a:	70e2                	ld	ra,56(sp)
ffffffffc0203e1c:	7442                	ld	s0,48(sp)
ffffffffc0203e1e:	74a2                	ld	s1,40(sp)
ffffffffc0203e20:	7902                	ld	s2,32(sp)
ffffffffc0203e22:	69e2                	ld	s3,24(sp)
ffffffffc0203e24:	6a42                	ld	s4,16(sp)
ffffffffc0203e26:	6aa2                	ld	s5,8(sp)
ffffffffc0203e28:	6121                	addi	sp,sp,64
ffffffffc0203e2a:	8082                	ret
ffffffffc0203e2c:	4501                	li	a0,0
ffffffffc0203e2e:	b7f5                	j	ffffffffc0203e1a <dup_mmap+0x64>
ffffffffc0203e30:	00009697          	auipc	a3,0x9
ffffffffc0203e34:	cb868693          	addi	a3,a3,-840 # ffffffffc020cae8 <default_pmm_manager+0x8c8>
ffffffffc0203e38:	00008617          	auipc	a2,0x8
ffffffffc0203e3c:	90060613          	addi	a2,a2,-1792 # ffffffffc020b738 <commands+0x210>
ffffffffc0203e40:	0cf00593          	li	a1,207
ffffffffc0203e44:	00009517          	auipc	a0,0x9
ffffffffc0203e48:	c0c50513          	addi	a0,a0,-1012 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203e4c:	e52fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203e50 <exit_mmap>:
ffffffffc0203e50:	1101                	addi	sp,sp,-32
ffffffffc0203e52:	ec06                	sd	ra,24(sp)
ffffffffc0203e54:	e822                	sd	s0,16(sp)
ffffffffc0203e56:	e426                	sd	s1,8(sp)
ffffffffc0203e58:	e04a                	sd	s2,0(sp)
ffffffffc0203e5a:	c531                	beqz	a0,ffffffffc0203ea6 <exit_mmap+0x56>
ffffffffc0203e5c:	591c                	lw	a5,48(a0)
ffffffffc0203e5e:	84aa                	mv	s1,a0
ffffffffc0203e60:	e3b9                	bnez	a5,ffffffffc0203ea6 <exit_mmap+0x56>
ffffffffc0203e62:	6500                	ld	s0,8(a0)
ffffffffc0203e64:	01853903          	ld	s2,24(a0)
ffffffffc0203e68:	02850663          	beq	a0,s0,ffffffffc0203e94 <exit_mmap+0x44>
ffffffffc0203e6c:	ff043603          	ld	a2,-16(s0)
ffffffffc0203e70:	fe843583          	ld	a1,-24(s0)
ffffffffc0203e74:	854a                	mv	a0,s2
ffffffffc0203e76:	ef0fe0ef          	jal	ra,ffffffffc0202566 <unmap_range>
ffffffffc0203e7a:	6400                	ld	s0,8(s0)
ffffffffc0203e7c:	fe8498e3          	bne	s1,s0,ffffffffc0203e6c <exit_mmap+0x1c>
ffffffffc0203e80:	6400                	ld	s0,8(s0)
ffffffffc0203e82:	00848c63          	beq	s1,s0,ffffffffc0203e9a <exit_mmap+0x4a>
ffffffffc0203e86:	ff043603          	ld	a2,-16(s0)
ffffffffc0203e8a:	fe843583          	ld	a1,-24(s0)
ffffffffc0203e8e:	854a                	mv	a0,s2
ffffffffc0203e90:	81dfe0ef          	jal	ra,ffffffffc02026ac <exit_range>
ffffffffc0203e94:	6400                	ld	s0,8(s0)
ffffffffc0203e96:	fe8498e3          	bne	s1,s0,ffffffffc0203e86 <exit_mmap+0x36>
ffffffffc0203e9a:	60e2                	ld	ra,24(sp)
ffffffffc0203e9c:	6442                	ld	s0,16(sp)
ffffffffc0203e9e:	64a2                	ld	s1,8(sp)
ffffffffc0203ea0:	6902                	ld	s2,0(sp)
ffffffffc0203ea2:	6105                	addi	sp,sp,32
ffffffffc0203ea4:	8082                	ret
ffffffffc0203ea6:	00009697          	auipc	a3,0x9
ffffffffc0203eaa:	c6268693          	addi	a3,a3,-926 # ffffffffc020cb08 <default_pmm_manager+0x8e8>
ffffffffc0203eae:	00008617          	auipc	a2,0x8
ffffffffc0203eb2:	88a60613          	addi	a2,a2,-1910 # ffffffffc020b738 <commands+0x210>
ffffffffc0203eb6:	0e800593          	li	a1,232
ffffffffc0203eba:	00009517          	auipc	a0,0x9
ffffffffc0203ebe:	b9650513          	addi	a0,a0,-1130 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203ec2:	ddcfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ec6 <vmm_init>:
ffffffffc0203ec6:	7139                	addi	sp,sp,-64
ffffffffc0203ec8:	05800513          	li	a0,88
ffffffffc0203ecc:	fc06                	sd	ra,56(sp)
ffffffffc0203ece:	f822                	sd	s0,48(sp)
ffffffffc0203ed0:	f426                	sd	s1,40(sp)
ffffffffc0203ed2:	f04a                	sd	s2,32(sp)
ffffffffc0203ed4:	ec4e                	sd	s3,24(sp)
ffffffffc0203ed6:	e852                	sd	s4,16(sp)
ffffffffc0203ed8:	e456                	sd	s5,8(sp)
ffffffffc0203eda:	8b4fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203ede:	2e050963          	beqz	a0,ffffffffc02041d0 <vmm_init+0x30a>
ffffffffc0203ee2:	e508                	sd	a0,8(a0)
ffffffffc0203ee4:	e108                	sd	a0,0(a0)
ffffffffc0203ee6:	00053823          	sd	zero,16(a0)
ffffffffc0203eea:	00053c23          	sd	zero,24(a0)
ffffffffc0203eee:	02052023          	sw	zero,32(a0)
ffffffffc0203ef2:	02053423          	sd	zero,40(a0)
ffffffffc0203ef6:	02052823          	sw	zero,48(a0)
ffffffffc0203efa:	84aa                	mv	s1,a0
ffffffffc0203efc:	4585                	li	a1,1
ffffffffc0203efe:	03850513          	addi	a0,a0,56
ffffffffc0203f02:	5b6000ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0203f06:	03200413          	li	s0,50
ffffffffc0203f0a:	a811                	j	ffffffffc0203f1e <vmm_init+0x58>
ffffffffc0203f0c:	e500                	sd	s0,8(a0)
ffffffffc0203f0e:	e91c                	sd	a5,16(a0)
ffffffffc0203f10:	00052c23          	sw	zero,24(a0)
ffffffffc0203f14:	146d                	addi	s0,s0,-5
ffffffffc0203f16:	8526                	mv	a0,s1
ffffffffc0203f18:	ccdff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203f1c:	c80d                	beqz	s0,ffffffffc0203f4e <vmm_init+0x88>
ffffffffc0203f1e:	03000513          	li	a0,48
ffffffffc0203f22:	86cfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203f26:	85aa                	mv	a1,a0
ffffffffc0203f28:	00240793          	addi	a5,s0,2
ffffffffc0203f2c:	f165                	bnez	a0,ffffffffc0203f0c <vmm_init+0x46>
ffffffffc0203f2e:	00009697          	auipc	a3,0x9
ffffffffc0203f32:	d7268693          	addi	a3,a3,-654 # ffffffffc020cca0 <default_pmm_manager+0xa80>
ffffffffc0203f36:	00008617          	auipc	a2,0x8
ffffffffc0203f3a:	80260613          	addi	a2,a2,-2046 # ffffffffc020b738 <commands+0x210>
ffffffffc0203f3e:	12c00593          	li	a1,300
ffffffffc0203f42:	00009517          	auipc	a0,0x9
ffffffffc0203f46:	b0e50513          	addi	a0,a0,-1266 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203f4a:	d54fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203f4e:	03700413          	li	s0,55
ffffffffc0203f52:	1f900913          	li	s2,505
ffffffffc0203f56:	a819                	j	ffffffffc0203f6c <vmm_init+0xa6>
ffffffffc0203f58:	e500                	sd	s0,8(a0)
ffffffffc0203f5a:	e91c                	sd	a5,16(a0)
ffffffffc0203f5c:	00052c23          	sw	zero,24(a0)
ffffffffc0203f60:	0415                	addi	s0,s0,5
ffffffffc0203f62:	8526                	mv	a0,s1
ffffffffc0203f64:	c81ff0ef          	jal	ra,ffffffffc0203be4 <insert_vma_struct>
ffffffffc0203f68:	03240a63          	beq	s0,s2,ffffffffc0203f9c <vmm_init+0xd6>
ffffffffc0203f6c:	03000513          	li	a0,48
ffffffffc0203f70:	81efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203f74:	85aa                	mv	a1,a0
ffffffffc0203f76:	00240793          	addi	a5,s0,2
ffffffffc0203f7a:	fd79                	bnez	a0,ffffffffc0203f58 <vmm_init+0x92>
ffffffffc0203f7c:	00009697          	auipc	a3,0x9
ffffffffc0203f80:	d2468693          	addi	a3,a3,-732 # ffffffffc020cca0 <default_pmm_manager+0xa80>
ffffffffc0203f84:	00007617          	auipc	a2,0x7
ffffffffc0203f88:	7b460613          	addi	a2,a2,1972 # ffffffffc020b738 <commands+0x210>
ffffffffc0203f8c:	13300593          	li	a1,307
ffffffffc0203f90:	00009517          	auipc	a0,0x9
ffffffffc0203f94:	ac050513          	addi	a0,a0,-1344 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0203f98:	d06fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203f9c:	649c                	ld	a5,8(s1)
ffffffffc0203f9e:	471d                	li	a4,7
ffffffffc0203fa0:	1fb00593          	li	a1,507
ffffffffc0203fa4:	16f48663          	beq	s1,a5,ffffffffc0204110 <vmm_init+0x24a>
ffffffffc0203fa8:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc0203fac:	ffe70693          	addi	a3,a4,-2 # ffe <_binary_bin_swap_img_size-0x6d02>
ffffffffc0203fb0:	10d61063          	bne	a2,a3,ffffffffc02040b0 <vmm_init+0x1ea>
ffffffffc0203fb4:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203fb8:	0ed71c63          	bne	a4,a3,ffffffffc02040b0 <vmm_init+0x1ea>
ffffffffc0203fbc:	0715                	addi	a4,a4,5
ffffffffc0203fbe:	679c                	ld	a5,8(a5)
ffffffffc0203fc0:	feb712e3          	bne	a4,a1,ffffffffc0203fa4 <vmm_init+0xde>
ffffffffc0203fc4:	4a1d                	li	s4,7
ffffffffc0203fc6:	4415                	li	s0,5
ffffffffc0203fc8:	1f900a93          	li	s5,505
ffffffffc0203fcc:	85a2                	mv	a1,s0
ffffffffc0203fce:	8526                	mv	a0,s1
ffffffffc0203fd0:	bd5ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203fd4:	892a                	mv	s2,a0
ffffffffc0203fd6:	16050d63          	beqz	a0,ffffffffc0204150 <vmm_init+0x28a>
ffffffffc0203fda:	00140593          	addi	a1,s0,1
ffffffffc0203fde:	8526                	mv	a0,s1
ffffffffc0203fe0:	bc5ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203fe4:	89aa                	mv	s3,a0
ffffffffc0203fe6:	14050563          	beqz	a0,ffffffffc0204130 <vmm_init+0x26a>
ffffffffc0203fea:	85d2                	mv	a1,s4
ffffffffc0203fec:	8526                	mv	a0,s1
ffffffffc0203fee:	bb7ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0203ff2:	16051f63          	bnez	a0,ffffffffc0204170 <vmm_init+0x2aa>
ffffffffc0203ff6:	00340593          	addi	a1,s0,3
ffffffffc0203ffa:	8526                	mv	a0,s1
ffffffffc0203ffc:	ba9ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0204000:	1a051863          	bnez	a0,ffffffffc02041b0 <vmm_init+0x2ea>
ffffffffc0204004:	00440593          	addi	a1,s0,4
ffffffffc0204008:	8526                	mv	a0,s1
ffffffffc020400a:	b9bff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc020400e:	18051163          	bnez	a0,ffffffffc0204190 <vmm_init+0x2ca>
ffffffffc0204012:	00893783          	ld	a5,8(s2)
ffffffffc0204016:	0a879d63          	bne	a5,s0,ffffffffc02040d0 <vmm_init+0x20a>
ffffffffc020401a:	01093783          	ld	a5,16(s2)
ffffffffc020401e:	0b479963          	bne	a5,s4,ffffffffc02040d0 <vmm_init+0x20a>
ffffffffc0204022:	0089b783          	ld	a5,8(s3)
ffffffffc0204026:	0c879563          	bne	a5,s0,ffffffffc02040f0 <vmm_init+0x22a>
ffffffffc020402a:	0109b783          	ld	a5,16(s3)
ffffffffc020402e:	0d479163          	bne	a5,s4,ffffffffc02040f0 <vmm_init+0x22a>
ffffffffc0204032:	0415                	addi	s0,s0,5
ffffffffc0204034:	0a15                	addi	s4,s4,5
ffffffffc0204036:	f9541be3          	bne	s0,s5,ffffffffc0203fcc <vmm_init+0x106>
ffffffffc020403a:	4411                	li	s0,4
ffffffffc020403c:	597d                	li	s2,-1
ffffffffc020403e:	85a2                	mv	a1,s0
ffffffffc0204040:	8526                	mv	a0,s1
ffffffffc0204042:	b63ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0204046:	0004059b          	sext.w	a1,s0
ffffffffc020404a:	c90d                	beqz	a0,ffffffffc020407c <vmm_init+0x1b6>
ffffffffc020404c:	6914                	ld	a3,16(a0)
ffffffffc020404e:	6510                	ld	a2,8(a0)
ffffffffc0204050:	00009517          	auipc	a0,0x9
ffffffffc0204054:	bd850513          	addi	a0,a0,-1064 # ffffffffc020cc28 <default_pmm_manager+0xa08>
ffffffffc0204058:	94efc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020405c:	00009697          	auipc	a3,0x9
ffffffffc0204060:	bf468693          	addi	a3,a3,-1036 # ffffffffc020cc50 <default_pmm_manager+0xa30>
ffffffffc0204064:	00007617          	auipc	a2,0x7
ffffffffc0204068:	6d460613          	addi	a2,a2,1748 # ffffffffc020b738 <commands+0x210>
ffffffffc020406c:	15900593          	li	a1,345
ffffffffc0204070:	00009517          	auipc	a0,0x9
ffffffffc0204074:	9e050513          	addi	a0,a0,-1568 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc0204078:	c26fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020407c:	147d                	addi	s0,s0,-1
ffffffffc020407e:	fd2410e3          	bne	s0,s2,ffffffffc020403e <vmm_init+0x178>
ffffffffc0204082:	8526                	mv	a0,s1
ffffffffc0204084:	c31ff0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0204088:	00009517          	auipc	a0,0x9
ffffffffc020408c:	be050513          	addi	a0,a0,-1056 # ffffffffc020cc68 <default_pmm_manager+0xa48>
ffffffffc0204090:	916fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204094:	7442                	ld	s0,48(sp)
ffffffffc0204096:	70e2                	ld	ra,56(sp)
ffffffffc0204098:	74a2                	ld	s1,40(sp)
ffffffffc020409a:	7902                	ld	s2,32(sp)
ffffffffc020409c:	69e2                	ld	s3,24(sp)
ffffffffc020409e:	6a42                	ld	s4,16(sp)
ffffffffc02040a0:	6aa2                	ld	s5,8(sp)
ffffffffc02040a2:	00009517          	auipc	a0,0x9
ffffffffc02040a6:	be650513          	addi	a0,a0,-1050 # ffffffffc020cc88 <default_pmm_manager+0xa68>
ffffffffc02040aa:	6121                	addi	sp,sp,64
ffffffffc02040ac:	8fafc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02040b0:	00009697          	auipc	a3,0x9
ffffffffc02040b4:	a9068693          	addi	a3,a3,-1392 # ffffffffc020cb40 <default_pmm_manager+0x920>
ffffffffc02040b8:	00007617          	auipc	a2,0x7
ffffffffc02040bc:	68060613          	addi	a2,a2,1664 # ffffffffc020b738 <commands+0x210>
ffffffffc02040c0:	13d00593          	li	a1,317
ffffffffc02040c4:	00009517          	auipc	a0,0x9
ffffffffc02040c8:	98c50513          	addi	a0,a0,-1652 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc02040cc:	bd2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040d0:	00009697          	auipc	a3,0x9
ffffffffc02040d4:	af868693          	addi	a3,a3,-1288 # ffffffffc020cbc8 <default_pmm_manager+0x9a8>
ffffffffc02040d8:	00007617          	auipc	a2,0x7
ffffffffc02040dc:	66060613          	addi	a2,a2,1632 # ffffffffc020b738 <commands+0x210>
ffffffffc02040e0:	14e00593          	li	a1,334
ffffffffc02040e4:	00009517          	auipc	a0,0x9
ffffffffc02040e8:	96c50513          	addi	a0,a0,-1684 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc02040ec:	bb2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040f0:	00009697          	auipc	a3,0x9
ffffffffc02040f4:	b0868693          	addi	a3,a3,-1272 # ffffffffc020cbf8 <default_pmm_manager+0x9d8>
ffffffffc02040f8:	00007617          	auipc	a2,0x7
ffffffffc02040fc:	64060613          	addi	a2,a2,1600 # ffffffffc020b738 <commands+0x210>
ffffffffc0204100:	14f00593          	li	a1,335
ffffffffc0204104:	00009517          	auipc	a0,0x9
ffffffffc0204108:	94c50513          	addi	a0,a0,-1716 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc020410c:	b92fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204110:	00009697          	auipc	a3,0x9
ffffffffc0204114:	a1868693          	addi	a3,a3,-1512 # ffffffffc020cb28 <default_pmm_manager+0x908>
ffffffffc0204118:	00007617          	auipc	a2,0x7
ffffffffc020411c:	62060613          	addi	a2,a2,1568 # ffffffffc020b738 <commands+0x210>
ffffffffc0204120:	13b00593          	li	a1,315
ffffffffc0204124:	00009517          	auipc	a0,0x9
ffffffffc0204128:	92c50513          	addi	a0,a0,-1748 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc020412c:	b72fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204130:	00009697          	auipc	a3,0x9
ffffffffc0204134:	a5868693          	addi	a3,a3,-1448 # ffffffffc020cb88 <default_pmm_manager+0x968>
ffffffffc0204138:	00007617          	auipc	a2,0x7
ffffffffc020413c:	60060613          	addi	a2,a2,1536 # ffffffffc020b738 <commands+0x210>
ffffffffc0204140:	14600593          	li	a1,326
ffffffffc0204144:	00009517          	auipc	a0,0x9
ffffffffc0204148:	90c50513          	addi	a0,a0,-1780 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc020414c:	b52fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204150:	00009697          	auipc	a3,0x9
ffffffffc0204154:	a2868693          	addi	a3,a3,-1496 # ffffffffc020cb78 <default_pmm_manager+0x958>
ffffffffc0204158:	00007617          	auipc	a2,0x7
ffffffffc020415c:	5e060613          	addi	a2,a2,1504 # ffffffffc020b738 <commands+0x210>
ffffffffc0204160:	14400593          	li	a1,324
ffffffffc0204164:	00009517          	auipc	a0,0x9
ffffffffc0204168:	8ec50513          	addi	a0,a0,-1812 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc020416c:	b32fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204170:	00009697          	auipc	a3,0x9
ffffffffc0204174:	a2868693          	addi	a3,a3,-1496 # ffffffffc020cb98 <default_pmm_manager+0x978>
ffffffffc0204178:	00007617          	auipc	a2,0x7
ffffffffc020417c:	5c060613          	addi	a2,a2,1472 # ffffffffc020b738 <commands+0x210>
ffffffffc0204180:	14800593          	li	a1,328
ffffffffc0204184:	00009517          	auipc	a0,0x9
ffffffffc0204188:	8cc50513          	addi	a0,a0,-1844 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc020418c:	b12fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204190:	00009697          	auipc	a3,0x9
ffffffffc0204194:	a2868693          	addi	a3,a3,-1496 # ffffffffc020cbb8 <default_pmm_manager+0x998>
ffffffffc0204198:	00007617          	auipc	a2,0x7
ffffffffc020419c:	5a060613          	addi	a2,a2,1440 # ffffffffc020b738 <commands+0x210>
ffffffffc02041a0:	14c00593          	li	a1,332
ffffffffc02041a4:	00009517          	auipc	a0,0x9
ffffffffc02041a8:	8ac50513          	addi	a0,a0,-1876 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc02041ac:	af2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b0:	00009697          	auipc	a3,0x9
ffffffffc02041b4:	9f868693          	addi	a3,a3,-1544 # ffffffffc020cba8 <default_pmm_manager+0x988>
ffffffffc02041b8:	00007617          	auipc	a2,0x7
ffffffffc02041bc:	58060613          	addi	a2,a2,1408 # ffffffffc020b738 <commands+0x210>
ffffffffc02041c0:	14a00593          	li	a1,330
ffffffffc02041c4:	00009517          	auipc	a0,0x9
ffffffffc02041c8:	88c50513          	addi	a0,a0,-1908 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc02041cc:	ad2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041d0:	00009697          	auipc	a3,0x9
ffffffffc02041d4:	90868693          	addi	a3,a3,-1784 # ffffffffc020cad8 <default_pmm_manager+0x8b8>
ffffffffc02041d8:	00007617          	auipc	a2,0x7
ffffffffc02041dc:	56060613          	addi	a2,a2,1376 # ffffffffc020b738 <commands+0x210>
ffffffffc02041e0:	12400593          	li	a1,292
ffffffffc02041e4:	00009517          	auipc	a0,0x9
ffffffffc02041e8:	86c50513          	addi	a0,a0,-1940 # ffffffffc020ca50 <default_pmm_manager+0x830>
ffffffffc02041ec:	ab2fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02041f0 <user_mem_check>:
ffffffffc02041f0:	7179                	addi	sp,sp,-48
ffffffffc02041f2:	f022                	sd	s0,32(sp)
ffffffffc02041f4:	f406                	sd	ra,40(sp)
ffffffffc02041f6:	ec26                	sd	s1,24(sp)
ffffffffc02041f8:	e84a                	sd	s2,16(sp)
ffffffffc02041fa:	e44e                	sd	s3,8(sp)
ffffffffc02041fc:	e052                	sd	s4,0(sp)
ffffffffc02041fe:	842e                	mv	s0,a1
ffffffffc0204200:	c135                	beqz	a0,ffffffffc0204264 <user_mem_check+0x74>
ffffffffc0204202:	002007b7          	lui	a5,0x200
ffffffffc0204206:	04f5e663          	bltu	a1,a5,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc020420a:	00c584b3          	add	s1,a1,a2
ffffffffc020420e:	0495f263          	bgeu	a1,s1,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204212:	4785                	li	a5,1
ffffffffc0204214:	07fe                	slli	a5,a5,0x1f
ffffffffc0204216:	0297ee63          	bltu	a5,s1,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc020421a:	892a                	mv	s2,a0
ffffffffc020421c:	89b6                	mv	s3,a3
ffffffffc020421e:	6a05                	lui	s4,0x1
ffffffffc0204220:	a821                	j	ffffffffc0204238 <user_mem_check+0x48>
ffffffffc0204222:	0027f693          	andi	a3,a5,2
ffffffffc0204226:	9752                	add	a4,a4,s4
ffffffffc0204228:	8ba1                	andi	a5,a5,8
ffffffffc020422a:	c685                	beqz	a3,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc020422c:	c399                	beqz	a5,ffffffffc0204232 <user_mem_check+0x42>
ffffffffc020422e:	02e46263          	bltu	s0,a4,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204232:	6900                	ld	s0,16(a0)
ffffffffc0204234:	04947663          	bgeu	s0,s1,ffffffffc0204280 <user_mem_check+0x90>
ffffffffc0204238:	85a2                	mv	a1,s0
ffffffffc020423a:	854a                	mv	a0,s2
ffffffffc020423c:	969ff0ef          	jal	ra,ffffffffc0203ba4 <find_vma>
ffffffffc0204240:	c909                	beqz	a0,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204242:	6518                	ld	a4,8(a0)
ffffffffc0204244:	00e46763          	bltu	s0,a4,ffffffffc0204252 <user_mem_check+0x62>
ffffffffc0204248:	4d1c                	lw	a5,24(a0)
ffffffffc020424a:	fc099ce3          	bnez	s3,ffffffffc0204222 <user_mem_check+0x32>
ffffffffc020424e:	8b85                	andi	a5,a5,1
ffffffffc0204250:	f3ed                	bnez	a5,ffffffffc0204232 <user_mem_check+0x42>
ffffffffc0204252:	4501                	li	a0,0
ffffffffc0204254:	70a2                	ld	ra,40(sp)
ffffffffc0204256:	7402                	ld	s0,32(sp)
ffffffffc0204258:	64e2                	ld	s1,24(sp)
ffffffffc020425a:	6942                	ld	s2,16(sp)
ffffffffc020425c:	69a2                	ld	s3,8(sp)
ffffffffc020425e:	6a02                	ld	s4,0(sp)
ffffffffc0204260:	6145                	addi	sp,sp,48
ffffffffc0204262:	8082                	ret
ffffffffc0204264:	c02007b7          	lui	a5,0xc0200
ffffffffc0204268:	4501                	li	a0,0
ffffffffc020426a:	fef5e5e3          	bltu	a1,a5,ffffffffc0204254 <user_mem_check+0x64>
ffffffffc020426e:	962e                	add	a2,a2,a1
ffffffffc0204270:	fec5f2e3          	bgeu	a1,a2,ffffffffc0204254 <user_mem_check+0x64>
ffffffffc0204274:	c8000537          	lui	a0,0xc8000
ffffffffc0204278:	0505                	addi	a0,a0,1
ffffffffc020427a:	00a63533          	sltu	a0,a2,a0
ffffffffc020427e:	bfd9                	j	ffffffffc0204254 <user_mem_check+0x64>
ffffffffc0204280:	4505                	li	a0,1
ffffffffc0204282:	bfc9                	j	ffffffffc0204254 <user_mem_check+0x64>

ffffffffc0204284 <copy_from_user>:
ffffffffc0204284:	1101                	addi	sp,sp,-32
ffffffffc0204286:	e822                	sd	s0,16(sp)
ffffffffc0204288:	e426                	sd	s1,8(sp)
ffffffffc020428a:	8432                	mv	s0,a2
ffffffffc020428c:	84b6                	mv	s1,a3
ffffffffc020428e:	e04a                	sd	s2,0(sp)
ffffffffc0204290:	86ba                	mv	a3,a4
ffffffffc0204292:	892e                	mv	s2,a1
ffffffffc0204294:	8626                	mv	a2,s1
ffffffffc0204296:	85a2                	mv	a1,s0
ffffffffc0204298:	ec06                	sd	ra,24(sp)
ffffffffc020429a:	f57ff0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc020429e:	c519                	beqz	a0,ffffffffc02042ac <copy_from_user+0x28>
ffffffffc02042a0:	8626                	mv	a2,s1
ffffffffc02042a2:	85a2                	mv	a1,s0
ffffffffc02042a4:	854a                	mv	a0,s2
ffffffffc02042a6:	7fd060ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc02042aa:	4505                	li	a0,1
ffffffffc02042ac:	60e2                	ld	ra,24(sp)
ffffffffc02042ae:	6442                	ld	s0,16(sp)
ffffffffc02042b0:	64a2                	ld	s1,8(sp)
ffffffffc02042b2:	6902                	ld	s2,0(sp)
ffffffffc02042b4:	6105                	addi	sp,sp,32
ffffffffc02042b6:	8082                	ret

ffffffffc02042b8 <copy_to_user>:
ffffffffc02042b8:	1101                	addi	sp,sp,-32
ffffffffc02042ba:	e822                	sd	s0,16(sp)
ffffffffc02042bc:	8436                	mv	s0,a3
ffffffffc02042be:	e04a                	sd	s2,0(sp)
ffffffffc02042c0:	4685                	li	a3,1
ffffffffc02042c2:	8932                	mv	s2,a2
ffffffffc02042c4:	8622                	mv	a2,s0
ffffffffc02042c6:	e426                	sd	s1,8(sp)
ffffffffc02042c8:	ec06                	sd	ra,24(sp)
ffffffffc02042ca:	84ae                	mv	s1,a1
ffffffffc02042cc:	f25ff0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc02042d0:	c519                	beqz	a0,ffffffffc02042de <copy_to_user+0x26>
ffffffffc02042d2:	8622                	mv	a2,s0
ffffffffc02042d4:	85ca                	mv	a1,s2
ffffffffc02042d6:	8526                	mv	a0,s1
ffffffffc02042d8:	7cb060ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc02042dc:	4505                	li	a0,1
ffffffffc02042de:	60e2                	ld	ra,24(sp)
ffffffffc02042e0:	6442                	ld	s0,16(sp)
ffffffffc02042e2:	64a2                	ld	s1,8(sp)
ffffffffc02042e4:	6902                	ld	s2,0(sp)
ffffffffc02042e6:	6105                	addi	sp,sp,32
ffffffffc02042e8:	8082                	ret

ffffffffc02042ea <copy_string>:
ffffffffc02042ea:	7139                	addi	sp,sp,-64
ffffffffc02042ec:	ec4e                	sd	s3,24(sp)
ffffffffc02042ee:	6985                	lui	s3,0x1
ffffffffc02042f0:	99b2                	add	s3,s3,a2
ffffffffc02042f2:	77fd                	lui	a5,0xfffff
ffffffffc02042f4:	00f9f9b3          	and	s3,s3,a5
ffffffffc02042f8:	f426                	sd	s1,40(sp)
ffffffffc02042fa:	f04a                	sd	s2,32(sp)
ffffffffc02042fc:	e852                	sd	s4,16(sp)
ffffffffc02042fe:	e456                	sd	s5,8(sp)
ffffffffc0204300:	fc06                	sd	ra,56(sp)
ffffffffc0204302:	f822                	sd	s0,48(sp)
ffffffffc0204304:	84b2                	mv	s1,a2
ffffffffc0204306:	8aaa                	mv	s5,a0
ffffffffc0204308:	8a2e                	mv	s4,a1
ffffffffc020430a:	8936                	mv	s2,a3
ffffffffc020430c:	40c989b3          	sub	s3,s3,a2
ffffffffc0204310:	a015                	j	ffffffffc0204334 <copy_string+0x4a>
ffffffffc0204312:	6b7060ef          	jal	ra,ffffffffc020b1c8 <strnlen>
ffffffffc0204316:	87aa                	mv	a5,a0
ffffffffc0204318:	85a6                	mv	a1,s1
ffffffffc020431a:	8552                	mv	a0,s4
ffffffffc020431c:	8622                	mv	a2,s0
ffffffffc020431e:	0487e363          	bltu	a5,s0,ffffffffc0204364 <copy_string+0x7a>
ffffffffc0204322:	0329f763          	bgeu	s3,s2,ffffffffc0204350 <copy_string+0x66>
ffffffffc0204326:	77d060ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc020432a:	9a22                	add	s4,s4,s0
ffffffffc020432c:	94a2                	add	s1,s1,s0
ffffffffc020432e:	40890933          	sub	s2,s2,s0
ffffffffc0204332:	6985                	lui	s3,0x1
ffffffffc0204334:	4681                	li	a3,0
ffffffffc0204336:	85a6                	mv	a1,s1
ffffffffc0204338:	8556                	mv	a0,s5
ffffffffc020433a:	844a                	mv	s0,s2
ffffffffc020433c:	0129f363          	bgeu	s3,s2,ffffffffc0204342 <copy_string+0x58>
ffffffffc0204340:	844e                	mv	s0,s3
ffffffffc0204342:	8622                	mv	a2,s0
ffffffffc0204344:	eadff0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc0204348:	87aa                	mv	a5,a0
ffffffffc020434a:	85a2                	mv	a1,s0
ffffffffc020434c:	8526                	mv	a0,s1
ffffffffc020434e:	f3f1                	bnez	a5,ffffffffc0204312 <copy_string+0x28>
ffffffffc0204350:	4501                	li	a0,0
ffffffffc0204352:	70e2                	ld	ra,56(sp)
ffffffffc0204354:	7442                	ld	s0,48(sp)
ffffffffc0204356:	74a2                	ld	s1,40(sp)
ffffffffc0204358:	7902                	ld	s2,32(sp)
ffffffffc020435a:	69e2                	ld	s3,24(sp)
ffffffffc020435c:	6a42                	ld	s4,16(sp)
ffffffffc020435e:	6aa2                	ld	s5,8(sp)
ffffffffc0204360:	6121                	addi	sp,sp,64
ffffffffc0204362:	8082                	ret
ffffffffc0204364:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc0204368:	73b060ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc020436c:	4505                	li	a0,1
ffffffffc020436e:	b7d5                	j	ffffffffc0204352 <copy_string+0x68>

ffffffffc0204370 <__down.constprop.0>:
ffffffffc0204370:	715d                	addi	sp,sp,-80
ffffffffc0204372:	e0a2                	sd	s0,64(sp)
ffffffffc0204374:	e486                	sd	ra,72(sp)
ffffffffc0204376:	fc26                	sd	s1,56(sp)
ffffffffc0204378:	842a                	mv	s0,a0
ffffffffc020437a:	100027f3          	csrr	a5,sstatus
ffffffffc020437e:	8b89                	andi	a5,a5,2
ffffffffc0204380:	ebb1                	bnez	a5,ffffffffc02043d4 <__down.constprop.0+0x64>
ffffffffc0204382:	411c                	lw	a5,0(a0)
ffffffffc0204384:	00f05a63          	blez	a5,ffffffffc0204398 <__down.constprop.0+0x28>
ffffffffc0204388:	37fd                	addiw	a5,a5,-1
ffffffffc020438a:	c11c                	sw	a5,0(a0)
ffffffffc020438c:	4501                	li	a0,0
ffffffffc020438e:	60a6                	ld	ra,72(sp)
ffffffffc0204390:	6406                	ld	s0,64(sp)
ffffffffc0204392:	74e2                	ld	s1,56(sp)
ffffffffc0204394:	6161                	addi	sp,sp,80
ffffffffc0204396:	8082                	ret
ffffffffc0204398:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc020439c:	0024                	addi	s1,sp,8
ffffffffc020439e:	10000613          	li	a2,256
ffffffffc02043a2:	85a6                	mv	a1,s1
ffffffffc02043a4:	8522                	mv	a0,s0
ffffffffc02043a6:	2d8000ef          	jal	ra,ffffffffc020467e <wait_current_set>
ffffffffc02043aa:	543020ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc02043ae:	100027f3          	csrr	a5,sstatus
ffffffffc02043b2:	8b89                	andi	a5,a5,2
ffffffffc02043b4:	efb9                	bnez	a5,ffffffffc0204412 <__down.constprop.0+0xa2>
ffffffffc02043b6:	8526                	mv	a0,s1
ffffffffc02043b8:	19c000ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc02043bc:	e531                	bnez	a0,ffffffffc0204408 <__down.constprop.0+0x98>
ffffffffc02043be:	4542                	lw	a0,16(sp)
ffffffffc02043c0:	10000793          	li	a5,256
ffffffffc02043c4:	fcf515e3          	bne	a0,a5,ffffffffc020438e <__down.constprop.0+0x1e>
ffffffffc02043c8:	60a6                	ld	ra,72(sp)
ffffffffc02043ca:	6406                	ld	s0,64(sp)
ffffffffc02043cc:	74e2                	ld	s1,56(sp)
ffffffffc02043ce:	4501                	li	a0,0
ffffffffc02043d0:	6161                	addi	sp,sp,80
ffffffffc02043d2:	8082                	ret
ffffffffc02043d4:	89ffc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02043d8:	401c                	lw	a5,0(s0)
ffffffffc02043da:	00f05c63          	blez	a5,ffffffffc02043f2 <__down.constprop.0+0x82>
ffffffffc02043de:	37fd                	addiw	a5,a5,-1
ffffffffc02043e0:	c01c                	sw	a5,0(s0)
ffffffffc02043e2:	88bfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02043e6:	60a6                	ld	ra,72(sp)
ffffffffc02043e8:	6406                	ld	s0,64(sp)
ffffffffc02043ea:	74e2                	ld	s1,56(sp)
ffffffffc02043ec:	4501                	li	a0,0
ffffffffc02043ee:	6161                	addi	sp,sp,80
ffffffffc02043f0:	8082                	ret
ffffffffc02043f2:	0421                	addi	s0,s0,8
ffffffffc02043f4:	0024                	addi	s1,sp,8
ffffffffc02043f6:	10000613          	li	a2,256
ffffffffc02043fa:	85a6                	mv	a1,s1
ffffffffc02043fc:	8522                	mv	a0,s0
ffffffffc02043fe:	280000ef          	jal	ra,ffffffffc020467e <wait_current_set>
ffffffffc0204402:	86bfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204406:	b755                	j	ffffffffc02043aa <__down.constprop.0+0x3a>
ffffffffc0204408:	85a6                	mv	a1,s1
ffffffffc020440a:	8522                	mv	a0,s0
ffffffffc020440c:	0ee000ef          	jal	ra,ffffffffc02044fa <wait_queue_del>
ffffffffc0204410:	b77d                	j	ffffffffc02043be <__down.constprop.0+0x4e>
ffffffffc0204412:	861fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204416:	8526                	mv	a0,s1
ffffffffc0204418:	13c000ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc020441c:	e501                	bnez	a0,ffffffffc0204424 <__down.constprop.0+0xb4>
ffffffffc020441e:	84ffc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204422:	bf71                	j	ffffffffc02043be <__down.constprop.0+0x4e>
ffffffffc0204424:	85a6                	mv	a1,s1
ffffffffc0204426:	8522                	mv	a0,s0
ffffffffc0204428:	0d2000ef          	jal	ra,ffffffffc02044fa <wait_queue_del>
ffffffffc020442c:	bfcd                	j	ffffffffc020441e <__down.constprop.0+0xae>

ffffffffc020442e <__up.constprop.0>:
ffffffffc020442e:	1101                	addi	sp,sp,-32
ffffffffc0204430:	e822                	sd	s0,16(sp)
ffffffffc0204432:	ec06                	sd	ra,24(sp)
ffffffffc0204434:	e426                	sd	s1,8(sp)
ffffffffc0204436:	e04a                	sd	s2,0(sp)
ffffffffc0204438:	842a                	mv	s0,a0
ffffffffc020443a:	100027f3          	csrr	a5,sstatus
ffffffffc020443e:	8b89                	andi	a5,a5,2
ffffffffc0204440:	4901                	li	s2,0
ffffffffc0204442:	eba1                	bnez	a5,ffffffffc0204492 <__up.constprop.0+0x64>
ffffffffc0204444:	00840493          	addi	s1,s0,8
ffffffffc0204448:	8526                	mv	a0,s1
ffffffffc020444a:	0ee000ef          	jal	ra,ffffffffc0204538 <wait_queue_first>
ffffffffc020444e:	85aa                	mv	a1,a0
ffffffffc0204450:	cd0d                	beqz	a0,ffffffffc020448a <__up.constprop.0+0x5c>
ffffffffc0204452:	6118                	ld	a4,0(a0)
ffffffffc0204454:	10000793          	li	a5,256
ffffffffc0204458:	0ec72703          	lw	a4,236(a4)
ffffffffc020445c:	02f71f63          	bne	a4,a5,ffffffffc020449a <__up.constprop.0+0x6c>
ffffffffc0204460:	4685                	li	a3,1
ffffffffc0204462:	10000613          	li	a2,256
ffffffffc0204466:	8526                	mv	a0,s1
ffffffffc0204468:	0fa000ef          	jal	ra,ffffffffc0204562 <wakeup_wait>
ffffffffc020446c:	00091863          	bnez	s2,ffffffffc020447c <__up.constprop.0+0x4e>
ffffffffc0204470:	60e2                	ld	ra,24(sp)
ffffffffc0204472:	6442                	ld	s0,16(sp)
ffffffffc0204474:	64a2                	ld	s1,8(sp)
ffffffffc0204476:	6902                	ld	s2,0(sp)
ffffffffc0204478:	6105                	addi	sp,sp,32
ffffffffc020447a:	8082                	ret
ffffffffc020447c:	6442                	ld	s0,16(sp)
ffffffffc020447e:	60e2                	ld	ra,24(sp)
ffffffffc0204480:	64a2                	ld	s1,8(sp)
ffffffffc0204482:	6902                	ld	s2,0(sp)
ffffffffc0204484:	6105                	addi	sp,sp,32
ffffffffc0204486:	fe6fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020448a:	401c                	lw	a5,0(s0)
ffffffffc020448c:	2785                	addiw	a5,a5,1
ffffffffc020448e:	c01c                	sw	a5,0(s0)
ffffffffc0204490:	bff1                	j	ffffffffc020446c <__up.constprop.0+0x3e>
ffffffffc0204492:	fe0fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204496:	4905                	li	s2,1
ffffffffc0204498:	b775                	j	ffffffffc0204444 <__up.constprop.0+0x16>
ffffffffc020449a:	00009697          	auipc	a3,0x9
ffffffffc020449e:	81668693          	addi	a3,a3,-2026 # ffffffffc020ccb0 <default_pmm_manager+0xa90>
ffffffffc02044a2:	00007617          	auipc	a2,0x7
ffffffffc02044a6:	29660613          	addi	a2,a2,662 # ffffffffc020b738 <commands+0x210>
ffffffffc02044aa:	45e5                	li	a1,25
ffffffffc02044ac:	00009517          	auipc	a0,0x9
ffffffffc02044b0:	82c50513          	addi	a0,a0,-2004 # ffffffffc020ccd8 <default_pmm_manager+0xab8>
ffffffffc02044b4:	febfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02044b8 <sem_init>:
ffffffffc02044b8:	c10c                	sw	a1,0(a0)
ffffffffc02044ba:	0521                	addi	a0,a0,8
ffffffffc02044bc:	a825                	j	ffffffffc02044f4 <wait_queue_init>

ffffffffc02044be <up>:
ffffffffc02044be:	f71ff06f          	j	ffffffffc020442e <__up.constprop.0>

ffffffffc02044c2 <down>:
ffffffffc02044c2:	1141                	addi	sp,sp,-16
ffffffffc02044c4:	e406                	sd	ra,8(sp)
ffffffffc02044c6:	eabff0ef          	jal	ra,ffffffffc0204370 <__down.constprop.0>
ffffffffc02044ca:	2501                	sext.w	a0,a0
ffffffffc02044cc:	e501                	bnez	a0,ffffffffc02044d4 <down+0x12>
ffffffffc02044ce:	60a2                	ld	ra,8(sp)
ffffffffc02044d0:	0141                	addi	sp,sp,16
ffffffffc02044d2:	8082                	ret
ffffffffc02044d4:	00009697          	auipc	a3,0x9
ffffffffc02044d8:	81468693          	addi	a3,a3,-2028 # ffffffffc020cce8 <default_pmm_manager+0xac8>
ffffffffc02044dc:	00007617          	auipc	a2,0x7
ffffffffc02044e0:	25c60613          	addi	a2,a2,604 # ffffffffc020b738 <commands+0x210>
ffffffffc02044e4:	04000593          	li	a1,64
ffffffffc02044e8:	00008517          	auipc	a0,0x8
ffffffffc02044ec:	7f050513          	addi	a0,a0,2032 # ffffffffc020ccd8 <default_pmm_manager+0xab8>
ffffffffc02044f0:	faffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02044f4 <wait_queue_init>:
ffffffffc02044f4:	e508                	sd	a0,8(a0)
ffffffffc02044f6:	e108                	sd	a0,0(a0)
ffffffffc02044f8:	8082                	ret

ffffffffc02044fa <wait_queue_del>:
ffffffffc02044fa:	7198                	ld	a4,32(a1)
ffffffffc02044fc:	01858793          	addi	a5,a1,24
ffffffffc0204500:	00e78b63          	beq	a5,a4,ffffffffc0204516 <wait_queue_del+0x1c>
ffffffffc0204504:	6994                	ld	a3,16(a1)
ffffffffc0204506:	00a69863          	bne	a3,a0,ffffffffc0204516 <wait_queue_del+0x1c>
ffffffffc020450a:	6d94                	ld	a3,24(a1)
ffffffffc020450c:	e698                	sd	a4,8(a3)
ffffffffc020450e:	e314                	sd	a3,0(a4)
ffffffffc0204510:	f19c                	sd	a5,32(a1)
ffffffffc0204512:	ed9c                	sd	a5,24(a1)
ffffffffc0204514:	8082                	ret
ffffffffc0204516:	1141                	addi	sp,sp,-16
ffffffffc0204518:	00009697          	auipc	a3,0x9
ffffffffc020451c:	83068693          	addi	a3,a3,-2000 # ffffffffc020cd48 <default_pmm_manager+0xb28>
ffffffffc0204520:	00007617          	auipc	a2,0x7
ffffffffc0204524:	21860613          	addi	a2,a2,536 # ffffffffc020b738 <commands+0x210>
ffffffffc0204528:	45f1                	li	a1,28
ffffffffc020452a:	00009517          	auipc	a0,0x9
ffffffffc020452e:	80650513          	addi	a0,a0,-2042 # ffffffffc020cd30 <default_pmm_manager+0xb10>
ffffffffc0204532:	e406                	sd	ra,8(sp)
ffffffffc0204534:	f6bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204538 <wait_queue_first>:
ffffffffc0204538:	651c                	ld	a5,8(a0)
ffffffffc020453a:	00f50563          	beq	a0,a5,ffffffffc0204544 <wait_queue_first+0xc>
ffffffffc020453e:	fe878513          	addi	a0,a5,-24
ffffffffc0204542:	8082                	ret
ffffffffc0204544:	4501                	li	a0,0
ffffffffc0204546:	8082                	ret

ffffffffc0204548 <wait_queue_empty>:
ffffffffc0204548:	651c                	ld	a5,8(a0)
ffffffffc020454a:	40a78533          	sub	a0,a5,a0
ffffffffc020454e:	00153513          	seqz	a0,a0
ffffffffc0204552:	8082                	ret

ffffffffc0204554 <wait_in_queue>:
ffffffffc0204554:	711c                	ld	a5,32(a0)
ffffffffc0204556:	0561                	addi	a0,a0,24
ffffffffc0204558:	40a78533          	sub	a0,a5,a0
ffffffffc020455c:	00a03533          	snez	a0,a0
ffffffffc0204560:	8082                	ret

ffffffffc0204562 <wakeup_wait>:
ffffffffc0204562:	e689                	bnez	a3,ffffffffc020456c <wakeup_wait+0xa>
ffffffffc0204564:	6188                	ld	a0,0(a1)
ffffffffc0204566:	c590                	sw	a2,8(a1)
ffffffffc0204568:	2d30206f          	j	ffffffffc020703a <wakeup_proc>
ffffffffc020456c:	7198                	ld	a4,32(a1)
ffffffffc020456e:	01858793          	addi	a5,a1,24
ffffffffc0204572:	00e78e63          	beq	a5,a4,ffffffffc020458e <wakeup_wait+0x2c>
ffffffffc0204576:	6994                	ld	a3,16(a1)
ffffffffc0204578:	00d51b63          	bne	a0,a3,ffffffffc020458e <wakeup_wait+0x2c>
ffffffffc020457c:	6d94                	ld	a3,24(a1)
ffffffffc020457e:	6188                	ld	a0,0(a1)
ffffffffc0204580:	e698                	sd	a4,8(a3)
ffffffffc0204582:	e314                	sd	a3,0(a4)
ffffffffc0204584:	f19c                	sd	a5,32(a1)
ffffffffc0204586:	ed9c                	sd	a5,24(a1)
ffffffffc0204588:	c590                	sw	a2,8(a1)
ffffffffc020458a:	2b10206f          	j	ffffffffc020703a <wakeup_proc>
ffffffffc020458e:	1141                	addi	sp,sp,-16
ffffffffc0204590:	00008697          	auipc	a3,0x8
ffffffffc0204594:	7b868693          	addi	a3,a3,1976 # ffffffffc020cd48 <default_pmm_manager+0xb28>
ffffffffc0204598:	00007617          	auipc	a2,0x7
ffffffffc020459c:	1a060613          	addi	a2,a2,416 # ffffffffc020b738 <commands+0x210>
ffffffffc02045a0:	45f1                	li	a1,28
ffffffffc02045a2:	00008517          	auipc	a0,0x8
ffffffffc02045a6:	78e50513          	addi	a0,a0,1934 # ffffffffc020cd30 <default_pmm_manager+0xb10>
ffffffffc02045aa:	e406                	sd	ra,8(sp)
ffffffffc02045ac:	ef3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045b0 <wakeup_queue>:
ffffffffc02045b0:	651c                	ld	a5,8(a0)
ffffffffc02045b2:	0ca78563          	beq	a5,a0,ffffffffc020467c <wakeup_queue+0xcc>
ffffffffc02045b6:	1101                	addi	sp,sp,-32
ffffffffc02045b8:	e822                	sd	s0,16(sp)
ffffffffc02045ba:	e426                	sd	s1,8(sp)
ffffffffc02045bc:	e04a                	sd	s2,0(sp)
ffffffffc02045be:	ec06                	sd	ra,24(sp)
ffffffffc02045c0:	84aa                	mv	s1,a0
ffffffffc02045c2:	892e                	mv	s2,a1
ffffffffc02045c4:	fe878413          	addi	s0,a5,-24
ffffffffc02045c8:	e23d                	bnez	a2,ffffffffc020462e <wakeup_queue+0x7e>
ffffffffc02045ca:	6008                	ld	a0,0(s0)
ffffffffc02045cc:	01242423          	sw	s2,8(s0)
ffffffffc02045d0:	26b020ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc02045d4:	701c                	ld	a5,32(s0)
ffffffffc02045d6:	01840713          	addi	a4,s0,24
ffffffffc02045da:	02e78463          	beq	a5,a4,ffffffffc0204602 <wakeup_queue+0x52>
ffffffffc02045de:	6818                	ld	a4,16(s0)
ffffffffc02045e0:	02e49163          	bne	s1,a4,ffffffffc0204602 <wakeup_queue+0x52>
ffffffffc02045e4:	02f48f63          	beq	s1,a5,ffffffffc0204622 <wakeup_queue+0x72>
ffffffffc02045e8:	fe87b503          	ld	a0,-24(a5)
ffffffffc02045ec:	ff27a823          	sw	s2,-16(a5)
ffffffffc02045f0:	fe878413          	addi	s0,a5,-24
ffffffffc02045f4:	247020ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc02045f8:	701c                	ld	a5,32(s0)
ffffffffc02045fa:	01840713          	addi	a4,s0,24
ffffffffc02045fe:	fee790e3          	bne	a5,a4,ffffffffc02045de <wakeup_queue+0x2e>
ffffffffc0204602:	00008697          	auipc	a3,0x8
ffffffffc0204606:	74668693          	addi	a3,a3,1862 # ffffffffc020cd48 <default_pmm_manager+0xb28>
ffffffffc020460a:	00007617          	auipc	a2,0x7
ffffffffc020460e:	12e60613          	addi	a2,a2,302 # ffffffffc020b738 <commands+0x210>
ffffffffc0204612:	02200593          	li	a1,34
ffffffffc0204616:	00008517          	auipc	a0,0x8
ffffffffc020461a:	71a50513          	addi	a0,a0,1818 # ffffffffc020cd30 <default_pmm_manager+0xb10>
ffffffffc020461e:	e81fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204622:	60e2                	ld	ra,24(sp)
ffffffffc0204624:	6442                	ld	s0,16(sp)
ffffffffc0204626:	64a2                	ld	s1,8(sp)
ffffffffc0204628:	6902                	ld	s2,0(sp)
ffffffffc020462a:	6105                	addi	sp,sp,32
ffffffffc020462c:	8082                	ret
ffffffffc020462e:	6798                	ld	a4,8(a5)
ffffffffc0204630:	02f70763          	beq	a4,a5,ffffffffc020465e <wakeup_queue+0xae>
ffffffffc0204634:	6814                	ld	a3,16(s0)
ffffffffc0204636:	02d49463          	bne	s1,a3,ffffffffc020465e <wakeup_queue+0xae>
ffffffffc020463a:	6c14                	ld	a3,24(s0)
ffffffffc020463c:	6008                	ld	a0,0(s0)
ffffffffc020463e:	e698                	sd	a4,8(a3)
ffffffffc0204640:	e314                	sd	a3,0(a4)
ffffffffc0204642:	f01c                	sd	a5,32(s0)
ffffffffc0204644:	ec1c                	sd	a5,24(s0)
ffffffffc0204646:	01242423          	sw	s2,8(s0)
ffffffffc020464a:	1f1020ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc020464e:	6480                	ld	s0,8(s1)
ffffffffc0204650:	fc8489e3          	beq	s1,s0,ffffffffc0204622 <wakeup_queue+0x72>
ffffffffc0204654:	6418                	ld	a4,8(s0)
ffffffffc0204656:	87a2                	mv	a5,s0
ffffffffc0204658:	1421                	addi	s0,s0,-24
ffffffffc020465a:	fce79de3          	bne	a5,a4,ffffffffc0204634 <wakeup_queue+0x84>
ffffffffc020465e:	00008697          	auipc	a3,0x8
ffffffffc0204662:	6ea68693          	addi	a3,a3,1770 # ffffffffc020cd48 <default_pmm_manager+0xb28>
ffffffffc0204666:	00007617          	auipc	a2,0x7
ffffffffc020466a:	0d260613          	addi	a2,a2,210 # ffffffffc020b738 <commands+0x210>
ffffffffc020466e:	45f1                	li	a1,28
ffffffffc0204670:	00008517          	auipc	a0,0x8
ffffffffc0204674:	6c050513          	addi	a0,a0,1728 # ffffffffc020cd30 <default_pmm_manager+0xb10>
ffffffffc0204678:	e27fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020467c:	8082                	ret

ffffffffc020467e <wait_current_set>:
ffffffffc020467e:	00092797          	auipc	a5,0x92
ffffffffc0204682:	2427b783          	ld	a5,578(a5) # ffffffffc02968c0 <current>
ffffffffc0204686:	c39d                	beqz	a5,ffffffffc02046ac <wait_current_set+0x2e>
ffffffffc0204688:	01858713          	addi	a4,a1,24
ffffffffc020468c:	800006b7          	lui	a3,0x80000
ffffffffc0204690:	ed98                	sd	a4,24(a1)
ffffffffc0204692:	e19c                	sd	a5,0(a1)
ffffffffc0204694:	c594                	sw	a3,8(a1)
ffffffffc0204696:	4685                	li	a3,1
ffffffffc0204698:	c394                	sw	a3,0(a5)
ffffffffc020469a:	0ec7a623          	sw	a2,236(a5)
ffffffffc020469e:	611c                	ld	a5,0(a0)
ffffffffc02046a0:	e988                	sd	a0,16(a1)
ffffffffc02046a2:	e118                	sd	a4,0(a0)
ffffffffc02046a4:	e798                	sd	a4,8(a5)
ffffffffc02046a6:	f188                	sd	a0,32(a1)
ffffffffc02046a8:	ed9c                	sd	a5,24(a1)
ffffffffc02046aa:	8082                	ret
ffffffffc02046ac:	1141                	addi	sp,sp,-16
ffffffffc02046ae:	00008697          	auipc	a3,0x8
ffffffffc02046b2:	6da68693          	addi	a3,a3,1754 # ffffffffc020cd88 <default_pmm_manager+0xb68>
ffffffffc02046b6:	00007617          	auipc	a2,0x7
ffffffffc02046ba:	08260613          	addi	a2,a2,130 # ffffffffc020b738 <commands+0x210>
ffffffffc02046be:	07400593          	li	a1,116
ffffffffc02046c2:	00008517          	auipc	a0,0x8
ffffffffc02046c6:	66e50513          	addi	a0,a0,1646 # ffffffffc020cd30 <default_pmm_manager+0xb10>
ffffffffc02046ca:	e406                	sd	ra,8(sp)
ffffffffc02046cc:	dd3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046d0 <get_fd_array.part.0>:
ffffffffc02046d0:	1141                	addi	sp,sp,-16
ffffffffc02046d2:	00008697          	auipc	a3,0x8
ffffffffc02046d6:	6c668693          	addi	a3,a3,1734 # ffffffffc020cd98 <default_pmm_manager+0xb78>
ffffffffc02046da:	00007617          	auipc	a2,0x7
ffffffffc02046de:	05e60613          	addi	a2,a2,94 # ffffffffc020b738 <commands+0x210>
ffffffffc02046e2:	45d1                	li	a1,20
ffffffffc02046e4:	00008517          	auipc	a0,0x8
ffffffffc02046e8:	6e450513          	addi	a0,a0,1764 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc02046ec:	e406                	sd	ra,8(sp)
ffffffffc02046ee:	db1fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046f2 <fd_array_alloc>:
ffffffffc02046f2:	00092797          	auipc	a5,0x92
ffffffffc02046f6:	1ce7b783          	ld	a5,462(a5) # ffffffffc02968c0 <current>
ffffffffc02046fa:	1487b783          	ld	a5,328(a5)
ffffffffc02046fe:	1141                	addi	sp,sp,-16
ffffffffc0204700:	e406                	sd	ra,8(sp)
ffffffffc0204702:	c3a5                	beqz	a5,ffffffffc0204762 <fd_array_alloc+0x70>
ffffffffc0204704:	4b98                	lw	a4,16(a5)
ffffffffc0204706:	04e05e63          	blez	a4,ffffffffc0204762 <fd_array_alloc+0x70>
ffffffffc020470a:	775d                	lui	a4,0xffff7
ffffffffc020470c:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204710:	679c                	ld	a5,8(a5)
ffffffffc0204712:	02e50863          	beq	a0,a4,ffffffffc0204742 <fd_array_alloc+0x50>
ffffffffc0204716:	04700713          	li	a4,71
ffffffffc020471a:	04a76263          	bltu	a4,a0,ffffffffc020475e <fd_array_alloc+0x6c>
ffffffffc020471e:	00351713          	slli	a4,a0,0x3
ffffffffc0204722:	40a70533          	sub	a0,a4,a0
ffffffffc0204726:	050e                	slli	a0,a0,0x3
ffffffffc0204728:	97aa                	add	a5,a5,a0
ffffffffc020472a:	4398                	lw	a4,0(a5)
ffffffffc020472c:	e71d                	bnez	a4,ffffffffc020475a <fd_array_alloc+0x68>
ffffffffc020472e:	5b88                	lw	a0,48(a5)
ffffffffc0204730:	e91d                	bnez	a0,ffffffffc0204766 <fd_array_alloc+0x74>
ffffffffc0204732:	4705                	li	a4,1
ffffffffc0204734:	c398                	sw	a4,0(a5)
ffffffffc0204736:	0207b423          	sd	zero,40(a5)
ffffffffc020473a:	e19c                	sd	a5,0(a1)
ffffffffc020473c:	60a2                	ld	ra,8(sp)
ffffffffc020473e:	0141                	addi	sp,sp,16
ffffffffc0204740:	8082                	ret
ffffffffc0204742:	6685                	lui	a3,0x1
ffffffffc0204744:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204748:	96be                	add	a3,a3,a5
ffffffffc020474a:	4398                	lw	a4,0(a5)
ffffffffc020474c:	d36d                	beqz	a4,ffffffffc020472e <fd_array_alloc+0x3c>
ffffffffc020474e:	03878793          	addi	a5,a5,56
ffffffffc0204752:	fef69ce3          	bne	a3,a5,ffffffffc020474a <fd_array_alloc+0x58>
ffffffffc0204756:	5529                	li	a0,-22
ffffffffc0204758:	b7d5                	j	ffffffffc020473c <fd_array_alloc+0x4a>
ffffffffc020475a:	5545                	li	a0,-15
ffffffffc020475c:	b7c5                	j	ffffffffc020473c <fd_array_alloc+0x4a>
ffffffffc020475e:	5575                	li	a0,-3
ffffffffc0204760:	bff1                	j	ffffffffc020473c <fd_array_alloc+0x4a>
ffffffffc0204762:	f6fff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204766:	00008697          	auipc	a3,0x8
ffffffffc020476a:	67268693          	addi	a3,a3,1650 # ffffffffc020cdd8 <default_pmm_manager+0xbb8>
ffffffffc020476e:	00007617          	auipc	a2,0x7
ffffffffc0204772:	fca60613          	addi	a2,a2,-54 # ffffffffc020b738 <commands+0x210>
ffffffffc0204776:	03b00593          	li	a1,59
ffffffffc020477a:	00008517          	auipc	a0,0x8
ffffffffc020477e:	64e50513          	addi	a0,a0,1614 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204782:	d1dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204786 <fd_array_free>:
ffffffffc0204786:	411c                	lw	a5,0(a0)
ffffffffc0204788:	1141                	addi	sp,sp,-16
ffffffffc020478a:	e022                	sd	s0,0(sp)
ffffffffc020478c:	e406                	sd	ra,8(sp)
ffffffffc020478e:	4705                	li	a4,1
ffffffffc0204790:	842a                	mv	s0,a0
ffffffffc0204792:	04e78063          	beq	a5,a4,ffffffffc02047d2 <fd_array_free+0x4c>
ffffffffc0204796:	470d                	li	a4,3
ffffffffc0204798:	04e79563          	bne	a5,a4,ffffffffc02047e2 <fd_array_free+0x5c>
ffffffffc020479c:	591c                	lw	a5,48(a0)
ffffffffc020479e:	c38d                	beqz	a5,ffffffffc02047c0 <fd_array_free+0x3a>
ffffffffc02047a0:	00008697          	auipc	a3,0x8
ffffffffc02047a4:	63868693          	addi	a3,a3,1592 # ffffffffc020cdd8 <default_pmm_manager+0xbb8>
ffffffffc02047a8:	00007617          	auipc	a2,0x7
ffffffffc02047ac:	f9060613          	addi	a2,a2,-112 # ffffffffc020b738 <commands+0x210>
ffffffffc02047b0:	04500593          	li	a1,69
ffffffffc02047b4:	00008517          	auipc	a0,0x8
ffffffffc02047b8:	61450513          	addi	a0,a0,1556 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc02047bc:	ce3fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02047c0:	7408                	ld	a0,40(s0)
ffffffffc02047c2:	6ee030ef          	jal	ra,ffffffffc0207eb0 <vfs_close>
ffffffffc02047c6:	60a2                	ld	ra,8(sp)
ffffffffc02047c8:	00042023          	sw	zero,0(s0)
ffffffffc02047cc:	6402                	ld	s0,0(sp)
ffffffffc02047ce:	0141                	addi	sp,sp,16
ffffffffc02047d0:	8082                	ret
ffffffffc02047d2:	591c                	lw	a5,48(a0)
ffffffffc02047d4:	f7f1                	bnez	a5,ffffffffc02047a0 <fd_array_free+0x1a>
ffffffffc02047d6:	60a2                	ld	ra,8(sp)
ffffffffc02047d8:	00042023          	sw	zero,0(s0)
ffffffffc02047dc:	6402                	ld	s0,0(sp)
ffffffffc02047de:	0141                	addi	sp,sp,16
ffffffffc02047e0:	8082                	ret
ffffffffc02047e2:	00008697          	auipc	a3,0x8
ffffffffc02047e6:	62e68693          	addi	a3,a3,1582 # ffffffffc020ce10 <default_pmm_manager+0xbf0>
ffffffffc02047ea:	00007617          	auipc	a2,0x7
ffffffffc02047ee:	f4e60613          	addi	a2,a2,-178 # ffffffffc020b738 <commands+0x210>
ffffffffc02047f2:	04400593          	li	a1,68
ffffffffc02047f6:	00008517          	auipc	a0,0x8
ffffffffc02047fa:	5d250513          	addi	a0,a0,1490 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc02047fe:	ca1fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204802 <fd_array_release>:
ffffffffc0204802:	4118                	lw	a4,0(a0)
ffffffffc0204804:	1141                	addi	sp,sp,-16
ffffffffc0204806:	e406                	sd	ra,8(sp)
ffffffffc0204808:	4685                	li	a3,1
ffffffffc020480a:	3779                	addiw	a4,a4,-2
ffffffffc020480c:	04e6e063          	bltu	a3,a4,ffffffffc020484c <fd_array_release+0x4a>
ffffffffc0204810:	5918                	lw	a4,48(a0)
ffffffffc0204812:	00e05d63          	blez	a4,ffffffffc020482c <fd_array_release+0x2a>
ffffffffc0204816:	fff7069b          	addiw	a3,a4,-1
ffffffffc020481a:	d914                	sw	a3,48(a0)
ffffffffc020481c:	c681                	beqz	a3,ffffffffc0204824 <fd_array_release+0x22>
ffffffffc020481e:	60a2                	ld	ra,8(sp)
ffffffffc0204820:	0141                	addi	sp,sp,16
ffffffffc0204822:	8082                	ret
ffffffffc0204824:	60a2                	ld	ra,8(sp)
ffffffffc0204826:	0141                	addi	sp,sp,16
ffffffffc0204828:	f5fff06f          	j	ffffffffc0204786 <fd_array_free>
ffffffffc020482c:	00008697          	auipc	a3,0x8
ffffffffc0204830:	65468693          	addi	a3,a3,1620 # ffffffffc020ce80 <default_pmm_manager+0xc60>
ffffffffc0204834:	00007617          	auipc	a2,0x7
ffffffffc0204838:	f0460613          	addi	a2,a2,-252 # ffffffffc020b738 <commands+0x210>
ffffffffc020483c:	05600593          	li	a1,86
ffffffffc0204840:	00008517          	auipc	a0,0x8
ffffffffc0204844:	58850513          	addi	a0,a0,1416 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204848:	c57fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020484c:	00008697          	auipc	a3,0x8
ffffffffc0204850:	5fc68693          	addi	a3,a3,1532 # ffffffffc020ce48 <default_pmm_manager+0xc28>
ffffffffc0204854:	00007617          	auipc	a2,0x7
ffffffffc0204858:	ee460613          	addi	a2,a2,-284 # ffffffffc020b738 <commands+0x210>
ffffffffc020485c:	05500593          	li	a1,85
ffffffffc0204860:	00008517          	auipc	a0,0x8
ffffffffc0204864:	56850513          	addi	a0,a0,1384 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204868:	c37fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020486c <fd_array_open.part.0>:
ffffffffc020486c:	1141                	addi	sp,sp,-16
ffffffffc020486e:	00008697          	auipc	a3,0x8
ffffffffc0204872:	62a68693          	addi	a3,a3,1578 # ffffffffc020ce98 <default_pmm_manager+0xc78>
ffffffffc0204876:	00007617          	auipc	a2,0x7
ffffffffc020487a:	ec260613          	addi	a2,a2,-318 # ffffffffc020b738 <commands+0x210>
ffffffffc020487e:	05f00593          	li	a1,95
ffffffffc0204882:	00008517          	auipc	a0,0x8
ffffffffc0204886:	54650513          	addi	a0,a0,1350 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc020488a:	e406                	sd	ra,8(sp)
ffffffffc020488c:	c13fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204890 <fd_array_init>:
ffffffffc0204890:	4781                	li	a5,0
ffffffffc0204892:	04800713          	li	a4,72
ffffffffc0204896:	cd1c                	sw	a5,24(a0)
ffffffffc0204898:	02052823          	sw	zero,48(a0)
ffffffffc020489c:	00052023          	sw	zero,0(a0)
ffffffffc02048a0:	2785                	addiw	a5,a5,1
ffffffffc02048a2:	03850513          	addi	a0,a0,56
ffffffffc02048a6:	fee798e3          	bne	a5,a4,ffffffffc0204896 <fd_array_init+0x6>
ffffffffc02048aa:	8082                	ret

ffffffffc02048ac <fd_array_close>:
ffffffffc02048ac:	4118                	lw	a4,0(a0)
ffffffffc02048ae:	1141                	addi	sp,sp,-16
ffffffffc02048b0:	e406                	sd	ra,8(sp)
ffffffffc02048b2:	e022                	sd	s0,0(sp)
ffffffffc02048b4:	4789                	li	a5,2
ffffffffc02048b6:	04f71a63          	bne	a4,a5,ffffffffc020490a <fd_array_close+0x5e>
ffffffffc02048ba:	591c                	lw	a5,48(a0)
ffffffffc02048bc:	842a                	mv	s0,a0
ffffffffc02048be:	02f05663          	blez	a5,ffffffffc02048ea <fd_array_close+0x3e>
ffffffffc02048c2:	37fd                	addiw	a5,a5,-1
ffffffffc02048c4:	470d                	li	a4,3
ffffffffc02048c6:	c118                	sw	a4,0(a0)
ffffffffc02048c8:	d91c                	sw	a5,48(a0)
ffffffffc02048ca:	0007871b          	sext.w	a4,a5
ffffffffc02048ce:	c709                	beqz	a4,ffffffffc02048d8 <fd_array_close+0x2c>
ffffffffc02048d0:	60a2                	ld	ra,8(sp)
ffffffffc02048d2:	6402                	ld	s0,0(sp)
ffffffffc02048d4:	0141                	addi	sp,sp,16
ffffffffc02048d6:	8082                	ret
ffffffffc02048d8:	7508                	ld	a0,40(a0)
ffffffffc02048da:	5d6030ef          	jal	ra,ffffffffc0207eb0 <vfs_close>
ffffffffc02048de:	60a2                	ld	ra,8(sp)
ffffffffc02048e0:	00042023          	sw	zero,0(s0)
ffffffffc02048e4:	6402                	ld	s0,0(sp)
ffffffffc02048e6:	0141                	addi	sp,sp,16
ffffffffc02048e8:	8082                	ret
ffffffffc02048ea:	00008697          	auipc	a3,0x8
ffffffffc02048ee:	59668693          	addi	a3,a3,1430 # ffffffffc020ce80 <default_pmm_manager+0xc60>
ffffffffc02048f2:	00007617          	auipc	a2,0x7
ffffffffc02048f6:	e4660613          	addi	a2,a2,-442 # ffffffffc020b738 <commands+0x210>
ffffffffc02048fa:	06800593          	li	a1,104
ffffffffc02048fe:	00008517          	auipc	a0,0x8
ffffffffc0204902:	4ca50513          	addi	a0,a0,1226 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204906:	b99fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020490a:	00008697          	auipc	a3,0x8
ffffffffc020490e:	4e668693          	addi	a3,a3,1254 # ffffffffc020cdf0 <default_pmm_manager+0xbd0>
ffffffffc0204912:	00007617          	auipc	a2,0x7
ffffffffc0204916:	e2660613          	addi	a2,a2,-474 # ffffffffc020b738 <commands+0x210>
ffffffffc020491a:	06700593          	li	a1,103
ffffffffc020491e:	00008517          	auipc	a0,0x8
ffffffffc0204922:	4aa50513          	addi	a0,a0,1194 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204926:	b79fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020492a <fd_array_dup>:
ffffffffc020492a:	7179                	addi	sp,sp,-48
ffffffffc020492c:	e84a                	sd	s2,16(sp)
ffffffffc020492e:	00052903          	lw	s2,0(a0)
ffffffffc0204932:	f406                	sd	ra,40(sp)
ffffffffc0204934:	f022                	sd	s0,32(sp)
ffffffffc0204936:	ec26                	sd	s1,24(sp)
ffffffffc0204938:	e44e                	sd	s3,8(sp)
ffffffffc020493a:	4785                	li	a5,1
ffffffffc020493c:	04f91663          	bne	s2,a5,ffffffffc0204988 <fd_array_dup+0x5e>
ffffffffc0204940:	0005a983          	lw	s3,0(a1)
ffffffffc0204944:	4789                	li	a5,2
ffffffffc0204946:	04f99163          	bne	s3,a5,ffffffffc0204988 <fd_array_dup+0x5e>
ffffffffc020494a:	7584                	ld	s1,40(a1)
ffffffffc020494c:	699c                	ld	a5,16(a1)
ffffffffc020494e:	7194                	ld	a3,32(a1)
ffffffffc0204950:	6598                	ld	a4,8(a1)
ffffffffc0204952:	842a                	mv	s0,a0
ffffffffc0204954:	e91c                	sd	a5,16(a0)
ffffffffc0204956:	f114                	sd	a3,32(a0)
ffffffffc0204958:	e518                	sd	a4,8(a0)
ffffffffc020495a:	8526                	mv	a0,s1
ffffffffc020495c:	4b3020ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc0204960:	8526                	mv	a0,s1
ffffffffc0204962:	4b9020ef          	jal	ra,ffffffffc020761a <inode_open_inc>
ffffffffc0204966:	401c                	lw	a5,0(s0)
ffffffffc0204968:	f404                	sd	s1,40(s0)
ffffffffc020496a:	03279f63          	bne	a5,s2,ffffffffc02049a8 <fd_array_dup+0x7e>
ffffffffc020496e:	cc8d                	beqz	s1,ffffffffc02049a8 <fd_array_dup+0x7e>
ffffffffc0204970:	581c                	lw	a5,48(s0)
ffffffffc0204972:	01342023          	sw	s3,0(s0)
ffffffffc0204976:	70a2                	ld	ra,40(sp)
ffffffffc0204978:	2785                	addiw	a5,a5,1
ffffffffc020497a:	d81c                	sw	a5,48(s0)
ffffffffc020497c:	7402                	ld	s0,32(sp)
ffffffffc020497e:	64e2                	ld	s1,24(sp)
ffffffffc0204980:	6942                	ld	s2,16(sp)
ffffffffc0204982:	69a2                	ld	s3,8(sp)
ffffffffc0204984:	6145                	addi	sp,sp,48
ffffffffc0204986:	8082                	ret
ffffffffc0204988:	00008697          	auipc	a3,0x8
ffffffffc020498c:	54068693          	addi	a3,a3,1344 # ffffffffc020cec8 <default_pmm_manager+0xca8>
ffffffffc0204990:	00007617          	auipc	a2,0x7
ffffffffc0204994:	da860613          	addi	a2,a2,-600 # ffffffffc020b738 <commands+0x210>
ffffffffc0204998:	07300593          	li	a1,115
ffffffffc020499c:	00008517          	auipc	a0,0x8
ffffffffc02049a0:	42c50513          	addi	a0,a0,1068 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc02049a4:	afbfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02049a8:	ec5ff0ef          	jal	ra,ffffffffc020486c <fd_array_open.part.0>

ffffffffc02049ac <file_testfd>:
ffffffffc02049ac:	04700793          	li	a5,71
ffffffffc02049b0:	04a7e263          	bltu	a5,a0,ffffffffc02049f4 <file_testfd+0x48>
ffffffffc02049b4:	00092797          	auipc	a5,0x92
ffffffffc02049b8:	f0c7b783          	ld	a5,-244(a5) # ffffffffc02968c0 <current>
ffffffffc02049bc:	1487b783          	ld	a5,328(a5)
ffffffffc02049c0:	cf85                	beqz	a5,ffffffffc02049f8 <file_testfd+0x4c>
ffffffffc02049c2:	4b98                	lw	a4,16(a5)
ffffffffc02049c4:	02e05a63          	blez	a4,ffffffffc02049f8 <file_testfd+0x4c>
ffffffffc02049c8:	6798                	ld	a4,8(a5)
ffffffffc02049ca:	00351793          	slli	a5,a0,0x3
ffffffffc02049ce:	8f89                	sub	a5,a5,a0
ffffffffc02049d0:	078e                	slli	a5,a5,0x3
ffffffffc02049d2:	97ba                	add	a5,a5,a4
ffffffffc02049d4:	4394                	lw	a3,0(a5)
ffffffffc02049d6:	4709                	li	a4,2
ffffffffc02049d8:	00e69e63          	bne	a3,a4,ffffffffc02049f4 <file_testfd+0x48>
ffffffffc02049dc:	4f98                	lw	a4,24(a5)
ffffffffc02049de:	00a71b63          	bne	a4,a0,ffffffffc02049f4 <file_testfd+0x48>
ffffffffc02049e2:	c199                	beqz	a1,ffffffffc02049e8 <file_testfd+0x3c>
ffffffffc02049e4:	6788                	ld	a0,8(a5)
ffffffffc02049e6:	c901                	beqz	a0,ffffffffc02049f6 <file_testfd+0x4a>
ffffffffc02049e8:	4505                	li	a0,1
ffffffffc02049ea:	c611                	beqz	a2,ffffffffc02049f6 <file_testfd+0x4a>
ffffffffc02049ec:	6b88                	ld	a0,16(a5)
ffffffffc02049ee:	00a03533          	snez	a0,a0
ffffffffc02049f2:	8082                	ret
ffffffffc02049f4:	4501                	li	a0,0
ffffffffc02049f6:	8082                	ret
ffffffffc02049f8:	1141                	addi	sp,sp,-16
ffffffffc02049fa:	e406                	sd	ra,8(sp)
ffffffffc02049fc:	cd5ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204a00 <file_open>:
ffffffffc0204a00:	711d                	addi	sp,sp,-96
ffffffffc0204a02:	ec86                	sd	ra,88(sp)
ffffffffc0204a04:	e8a2                	sd	s0,80(sp)
ffffffffc0204a06:	e4a6                	sd	s1,72(sp)
ffffffffc0204a08:	e0ca                	sd	s2,64(sp)
ffffffffc0204a0a:	fc4e                	sd	s3,56(sp)
ffffffffc0204a0c:	f852                	sd	s4,48(sp)
ffffffffc0204a0e:	0035f793          	andi	a5,a1,3
ffffffffc0204a12:	470d                	li	a4,3
ffffffffc0204a14:	0ce78163          	beq	a5,a4,ffffffffc0204ad6 <file_open+0xd6>
ffffffffc0204a18:	078e                	slli	a5,a5,0x3
ffffffffc0204a1a:	00008717          	auipc	a4,0x8
ffffffffc0204a1e:	71e70713          	addi	a4,a4,1822 # ffffffffc020d138 <CSWTCH.79>
ffffffffc0204a22:	892a                	mv	s2,a0
ffffffffc0204a24:	00008697          	auipc	a3,0x8
ffffffffc0204a28:	6fc68693          	addi	a3,a3,1788 # ffffffffc020d120 <CSWTCH.78>
ffffffffc0204a2c:	755d                	lui	a0,0xffff7
ffffffffc0204a2e:	96be                	add	a3,a3,a5
ffffffffc0204a30:	84ae                	mv	s1,a1
ffffffffc0204a32:	97ba                	add	a5,a5,a4
ffffffffc0204a34:	858a                	mv	a1,sp
ffffffffc0204a36:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204a3a:	0006ba03          	ld	s4,0(a3)
ffffffffc0204a3e:	0007b983          	ld	s3,0(a5)
ffffffffc0204a42:	cb1ff0ef          	jal	ra,ffffffffc02046f2 <fd_array_alloc>
ffffffffc0204a46:	842a                	mv	s0,a0
ffffffffc0204a48:	c911                	beqz	a0,ffffffffc0204a5c <file_open+0x5c>
ffffffffc0204a4a:	60e6                	ld	ra,88(sp)
ffffffffc0204a4c:	8522                	mv	a0,s0
ffffffffc0204a4e:	6446                	ld	s0,80(sp)
ffffffffc0204a50:	64a6                	ld	s1,72(sp)
ffffffffc0204a52:	6906                	ld	s2,64(sp)
ffffffffc0204a54:	79e2                	ld	s3,56(sp)
ffffffffc0204a56:	7a42                	ld	s4,48(sp)
ffffffffc0204a58:	6125                	addi	sp,sp,96
ffffffffc0204a5a:	8082                	ret
ffffffffc0204a5c:	0030                	addi	a2,sp,8
ffffffffc0204a5e:	85a6                	mv	a1,s1
ffffffffc0204a60:	854a                	mv	a0,s2
ffffffffc0204a62:	2a8030ef          	jal	ra,ffffffffc0207d0a <vfs_open>
ffffffffc0204a66:	842a                	mv	s0,a0
ffffffffc0204a68:	e13d                	bnez	a0,ffffffffc0204ace <file_open+0xce>
ffffffffc0204a6a:	6782                	ld	a5,0(sp)
ffffffffc0204a6c:	0204f493          	andi	s1,s1,32
ffffffffc0204a70:	6422                	ld	s0,8(sp)
ffffffffc0204a72:	0207b023          	sd	zero,32(a5)
ffffffffc0204a76:	c885                	beqz	s1,ffffffffc0204aa6 <file_open+0xa6>
ffffffffc0204a78:	c03d                	beqz	s0,ffffffffc0204ade <file_open+0xde>
ffffffffc0204a7a:	783c                	ld	a5,112(s0)
ffffffffc0204a7c:	c3ad                	beqz	a5,ffffffffc0204ade <file_open+0xde>
ffffffffc0204a7e:	779c                	ld	a5,40(a5)
ffffffffc0204a80:	cfb9                	beqz	a5,ffffffffc0204ade <file_open+0xde>
ffffffffc0204a82:	8522                	mv	a0,s0
ffffffffc0204a84:	00008597          	auipc	a1,0x8
ffffffffc0204a88:	4cc58593          	addi	a1,a1,1228 # ffffffffc020cf50 <default_pmm_manager+0xd30>
ffffffffc0204a8c:	39b020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0204a90:	783c                	ld	a5,112(s0)
ffffffffc0204a92:	6522                	ld	a0,8(sp)
ffffffffc0204a94:	080c                	addi	a1,sp,16
ffffffffc0204a96:	779c                	ld	a5,40(a5)
ffffffffc0204a98:	9782                	jalr	a5
ffffffffc0204a9a:	842a                	mv	s0,a0
ffffffffc0204a9c:	e515                	bnez	a0,ffffffffc0204ac8 <file_open+0xc8>
ffffffffc0204a9e:	6782                	ld	a5,0(sp)
ffffffffc0204aa0:	7722                	ld	a4,40(sp)
ffffffffc0204aa2:	6422                	ld	s0,8(sp)
ffffffffc0204aa4:	f398                	sd	a4,32(a5)
ffffffffc0204aa6:	4394                	lw	a3,0(a5)
ffffffffc0204aa8:	f780                	sd	s0,40(a5)
ffffffffc0204aaa:	0147b423          	sd	s4,8(a5)
ffffffffc0204aae:	0137b823          	sd	s3,16(a5)
ffffffffc0204ab2:	4705                	li	a4,1
ffffffffc0204ab4:	02e69363          	bne	a3,a4,ffffffffc0204ada <file_open+0xda>
ffffffffc0204ab8:	c00d                	beqz	s0,ffffffffc0204ada <file_open+0xda>
ffffffffc0204aba:	5b98                	lw	a4,48(a5)
ffffffffc0204abc:	4689                	li	a3,2
ffffffffc0204abe:	4f80                	lw	s0,24(a5)
ffffffffc0204ac0:	2705                	addiw	a4,a4,1
ffffffffc0204ac2:	c394                	sw	a3,0(a5)
ffffffffc0204ac4:	db98                	sw	a4,48(a5)
ffffffffc0204ac6:	b751                	j	ffffffffc0204a4a <file_open+0x4a>
ffffffffc0204ac8:	6522                	ld	a0,8(sp)
ffffffffc0204aca:	3e6030ef          	jal	ra,ffffffffc0207eb0 <vfs_close>
ffffffffc0204ace:	6502                	ld	a0,0(sp)
ffffffffc0204ad0:	cb7ff0ef          	jal	ra,ffffffffc0204786 <fd_array_free>
ffffffffc0204ad4:	bf9d                	j	ffffffffc0204a4a <file_open+0x4a>
ffffffffc0204ad6:	5475                	li	s0,-3
ffffffffc0204ad8:	bf8d                	j	ffffffffc0204a4a <file_open+0x4a>
ffffffffc0204ada:	d93ff0ef          	jal	ra,ffffffffc020486c <fd_array_open.part.0>
ffffffffc0204ade:	00008697          	auipc	a3,0x8
ffffffffc0204ae2:	42268693          	addi	a3,a3,1058 # ffffffffc020cf00 <default_pmm_manager+0xce0>
ffffffffc0204ae6:	00007617          	auipc	a2,0x7
ffffffffc0204aea:	c5260613          	addi	a2,a2,-942 # ffffffffc020b738 <commands+0x210>
ffffffffc0204aee:	0b500593          	li	a1,181
ffffffffc0204af2:	00008517          	auipc	a0,0x8
ffffffffc0204af6:	2d650513          	addi	a0,a0,726 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204afa:	9a5fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204afe <file_close>:
ffffffffc0204afe:	04700713          	li	a4,71
ffffffffc0204b02:	04a76563          	bltu	a4,a0,ffffffffc0204b4c <file_close+0x4e>
ffffffffc0204b06:	00092717          	auipc	a4,0x92
ffffffffc0204b0a:	dba73703          	ld	a4,-582(a4) # ffffffffc02968c0 <current>
ffffffffc0204b0e:	14873703          	ld	a4,328(a4)
ffffffffc0204b12:	1141                	addi	sp,sp,-16
ffffffffc0204b14:	e406                	sd	ra,8(sp)
ffffffffc0204b16:	cf0d                	beqz	a4,ffffffffc0204b50 <file_close+0x52>
ffffffffc0204b18:	4b14                	lw	a3,16(a4)
ffffffffc0204b1a:	02d05b63          	blez	a3,ffffffffc0204b50 <file_close+0x52>
ffffffffc0204b1e:	6718                	ld	a4,8(a4)
ffffffffc0204b20:	87aa                	mv	a5,a0
ffffffffc0204b22:	050e                	slli	a0,a0,0x3
ffffffffc0204b24:	8d1d                	sub	a0,a0,a5
ffffffffc0204b26:	050e                	slli	a0,a0,0x3
ffffffffc0204b28:	953a                	add	a0,a0,a4
ffffffffc0204b2a:	4114                	lw	a3,0(a0)
ffffffffc0204b2c:	4709                	li	a4,2
ffffffffc0204b2e:	00e69b63          	bne	a3,a4,ffffffffc0204b44 <file_close+0x46>
ffffffffc0204b32:	4d18                	lw	a4,24(a0)
ffffffffc0204b34:	00f71863          	bne	a4,a5,ffffffffc0204b44 <file_close+0x46>
ffffffffc0204b38:	d75ff0ef          	jal	ra,ffffffffc02048ac <fd_array_close>
ffffffffc0204b3c:	60a2                	ld	ra,8(sp)
ffffffffc0204b3e:	4501                	li	a0,0
ffffffffc0204b40:	0141                	addi	sp,sp,16
ffffffffc0204b42:	8082                	ret
ffffffffc0204b44:	60a2                	ld	ra,8(sp)
ffffffffc0204b46:	5575                	li	a0,-3
ffffffffc0204b48:	0141                	addi	sp,sp,16
ffffffffc0204b4a:	8082                	ret
ffffffffc0204b4c:	5575                	li	a0,-3
ffffffffc0204b4e:	8082                	ret
ffffffffc0204b50:	b81ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204b54 <file_read>:
ffffffffc0204b54:	715d                	addi	sp,sp,-80
ffffffffc0204b56:	e486                	sd	ra,72(sp)
ffffffffc0204b58:	e0a2                	sd	s0,64(sp)
ffffffffc0204b5a:	fc26                	sd	s1,56(sp)
ffffffffc0204b5c:	f84a                	sd	s2,48(sp)
ffffffffc0204b5e:	f44e                	sd	s3,40(sp)
ffffffffc0204b60:	f052                	sd	s4,32(sp)
ffffffffc0204b62:	0006b023          	sd	zero,0(a3)
ffffffffc0204b66:	04700793          	li	a5,71
ffffffffc0204b6a:	0aa7e463          	bltu	a5,a0,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204b6e:	00092797          	auipc	a5,0x92
ffffffffc0204b72:	d527b783          	ld	a5,-686(a5) # ffffffffc02968c0 <current>
ffffffffc0204b76:	1487b783          	ld	a5,328(a5)
ffffffffc0204b7a:	cfd1                	beqz	a5,ffffffffc0204c16 <file_read+0xc2>
ffffffffc0204b7c:	4b98                	lw	a4,16(a5)
ffffffffc0204b7e:	08e05c63          	blez	a4,ffffffffc0204c16 <file_read+0xc2>
ffffffffc0204b82:	6780                	ld	s0,8(a5)
ffffffffc0204b84:	00351793          	slli	a5,a0,0x3
ffffffffc0204b88:	8f89                	sub	a5,a5,a0
ffffffffc0204b8a:	078e                	slli	a5,a5,0x3
ffffffffc0204b8c:	943e                	add	s0,s0,a5
ffffffffc0204b8e:	00042983          	lw	s3,0(s0)
ffffffffc0204b92:	4789                	li	a5,2
ffffffffc0204b94:	06f99f63          	bne	s3,a5,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204b98:	4c1c                	lw	a5,24(s0)
ffffffffc0204b9a:	06a79c63          	bne	a5,a0,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204b9e:	641c                	ld	a5,8(s0)
ffffffffc0204ba0:	cbad                	beqz	a5,ffffffffc0204c12 <file_read+0xbe>
ffffffffc0204ba2:	581c                	lw	a5,48(s0)
ffffffffc0204ba4:	8a36                	mv	s4,a3
ffffffffc0204ba6:	7014                	ld	a3,32(s0)
ffffffffc0204ba8:	2785                	addiw	a5,a5,1
ffffffffc0204baa:	850a                	mv	a0,sp
ffffffffc0204bac:	d81c                	sw	a5,48(s0)
ffffffffc0204bae:	792000ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0204bb2:	02843903          	ld	s2,40(s0)
ffffffffc0204bb6:	84aa                	mv	s1,a0
ffffffffc0204bb8:	06090163          	beqz	s2,ffffffffc0204c1a <file_read+0xc6>
ffffffffc0204bbc:	07093783          	ld	a5,112(s2)
ffffffffc0204bc0:	cfa9                	beqz	a5,ffffffffc0204c1a <file_read+0xc6>
ffffffffc0204bc2:	6f9c                	ld	a5,24(a5)
ffffffffc0204bc4:	cbb9                	beqz	a5,ffffffffc0204c1a <file_read+0xc6>
ffffffffc0204bc6:	00008597          	auipc	a1,0x8
ffffffffc0204bca:	3e258593          	addi	a1,a1,994 # ffffffffc020cfa8 <default_pmm_manager+0xd88>
ffffffffc0204bce:	854a                	mv	a0,s2
ffffffffc0204bd0:	257020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0204bd4:	07093783          	ld	a5,112(s2)
ffffffffc0204bd8:	7408                	ld	a0,40(s0)
ffffffffc0204bda:	85a6                	mv	a1,s1
ffffffffc0204bdc:	6f9c                	ld	a5,24(a5)
ffffffffc0204bde:	9782                	jalr	a5
ffffffffc0204be0:	689c                	ld	a5,16(s1)
ffffffffc0204be2:	6c94                	ld	a3,24(s1)
ffffffffc0204be4:	4018                	lw	a4,0(s0)
ffffffffc0204be6:	84aa                	mv	s1,a0
ffffffffc0204be8:	8f95                	sub	a5,a5,a3
ffffffffc0204bea:	03370063          	beq	a4,s3,ffffffffc0204c0a <file_read+0xb6>
ffffffffc0204bee:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204bf2:	8522                	mv	a0,s0
ffffffffc0204bf4:	c0fff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204bf8:	60a6                	ld	ra,72(sp)
ffffffffc0204bfa:	6406                	ld	s0,64(sp)
ffffffffc0204bfc:	7942                	ld	s2,48(sp)
ffffffffc0204bfe:	79a2                	ld	s3,40(sp)
ffffffffc0204c00:	7a02                	ld	s4,32(sp)
ffffffffc0204c02:	8526                	mv	a0,s1
ffffffffc0204c04:	74e2                	ld	s1,56(sp)
ffffffffc0204c06:	6161                	addi	sp,sp,80
ffffffffc0204c08:	8082                	ret
ffffffffc0204c0a:	7018                	ld	a4,32(s0)
ffffffffc0204c0c:	973e                	add	a4,a4,a5
ffffffffc0204c0e:	f018                	sd	a4,32(s0)
ffffffffc0204c10:	bff9                	j	ffffffffc0204bee <file_read+0x9a>
ffffffffc0204c12:	54f5                	li	s1,-3
ffffffffc0204c14:	b7d5                	j	ffffffffc0204bf8 <file_read+0xa4>
ffffffffc0204c16:	abbff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204c1a:	00008697          	auipc	a3,0x8
ffffffffc0204c1e:	33e68693          	addi	a3,a3,830 # ffffffffc020cf58 <default_pmm_manager+0xd38>
ffffffffc0204c22:	00007617          	auipc	a2,0x7
ffffffffc0204c26:	b1660613          	addi	a2,a2,-1258 # ffffffffc020b738 <commands+0x210>
ffffffffc0204c2a:	0de00593          	li	a1,222
ffffffffc0204c2e:	00008517          	auipc	a0,0x8
ffffffffc0204c32:	19a50513          	addi	a0,a0,410 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204c36:	869fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204c3a <file_write>:
ffffffffc0204c3a:	715d                	addi	sp,sp,-80
ffffffffc0204c3c:	e486                	sd	ra,72(sp)
ffffffffc0204c3e:	e0a2                	sd	s0,64(sp)
ffffffffc0204c40:	fc26                	sd	s1,56(sp)
ffffffffc0204c42:	f84a                	sd	s2,48(sp)
ffffffffc0204c44:	f44e                	sd	s3,40(sp)
ffffffffc0204c46:	f052                	sd	s4,32(sp)
ffffffffc0204c48:	0006b023          	sd	zero,0(a3)
ffffffffc0204c4c:	04700793          	li	a5,71
ffffffffc0204c50:	0aa7e463          	bltu	a5,a0,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c54:	00092797          	auipc	a5,0x92
ffffffffc0204c58:	c6c7b783          	ld	a5,-916(a5) # ffffffffc02968c0 <current>
ffffffffc0204c5c:	1487b783          	ld	a5,328(a5)
ffffffffc0204c60:	cfd1                	beqz	a5,ffffffffc0204cfc <file_write+0xc2>
ffffffffc0204c62:	4b98                	lw	a4,16(a5)
ffffffffc0204c64:	08e05c63          	blez	a4,ffffffffc0204cfc <file_write+0xc2>
ffffffffc0204c68:	6780                	ld	s0,8(a5)
ffffffffc0204c6a:	00351793          	slli	a5,a0,0x3
ffffffffc0204c6e:	8f89                	sub	a5,a5,a0
ffffffffc0204c70:	078e                	slli	a5,a5,0x3
ffffffffc0204c72:	943e                	add	s0,s0,a5
ffffffffc0204c74:	00042983          	lw	s3,0(s0)
ffffffffc0204c78:	4789                	li	a5,2
ffffffffc0204c7a:	06f99f63          	bne	s3,a5,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c7e:	4c1c                	lw	a5,24(s0)
ffffffffc0204c80:	06a79c63          	bne	a5,a0,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c84:	681c                	ld	a5,16(s0)
ffffffffc0204c86:	cbad                	beqz	a5,ffffffffc0204cf8 <file_write+0xbe>
ffffffffc0204c88:	581c                	lw	a5,48(s0)
ffffffffc0204c8a:	8a36                	mv	s4,a3
ffffffffc0204c8c:	7014                	ld	a3,32(s0)
ffffffffc0204c8e:	2785                	addiw	a5,a5,1
ffffffffc0204c90:	850a                	mv	a0,sp
ffffffffc0204c92:	d81c                	sw	a5,48(s0)
ffffffffc0204c94:	6ac000ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0204c98:	02843903          	ld	s2,40(s0)
ffffffffc0204c9c:	84aa                	mv	s1,a0
ffffffffc0204c9e:	06090163          	beqz	s2,ffffffffc0204d00 <file_write+0xc6>
ffffffffc0204ca2:	07093783          	ld	a5,112(s2)
ffffffffc0204ca6:	cfa9                	beqz	a5,ffffffffc0204d00 <file_write+0xc6>
ffffffffc0204ca8:	739c                	ld	a5,32(a5)
ffffffffc0204caa:	cbb9                	beqz	a5,ffffffffc0204d00 <file_write+0xc6>
ffffffffc0204cac:	00008597          	auipc	a1,0x8
ffffffffc0204cb0:	35458593          	addi	a1,a1,852 # ffffffffc020d000 <default_pmm_manager+0xde0>
ffffffffc0204cb4:	854a                	mv	a0,s2
ffffffffc0204cb6:	171020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0204cba:	07093783          	ld	a5,112(s2)
ffffffffc0204cbe:	7408                	ld	a0,40(s0)
ffffffffc0204cc0:	85a6                	mv	a1,s1
ffffffffc0204cc2:	739c                	ld	a5,32(a5)
ffffffffc0204cc4:	9782                	jalr	a5
ffffffffc0204cc6:	689c                	ld	a5,16(s1)
ffffffffc0204cc8:	6c94                	ld	a3,24(s1)
ffffffffc0204cca:	4018                	lw	a4,0(s0)
ffffffffc0204ccc:	84aa                	mv	s1,a0
ffffffffc0204cce:	8f95                	sub	a5,a5,a3
ffffffffc0204cd0:	03370063          	beq	a4,s3,ffffffffc0204cf0 <file_write+0xb6>
ffffffffc0204cd4:	00fa3023          	sd	a5,0(s4)
ffffffffc0204cd8:	8522                	mv	a0,s0
ffffffffc0204cda:	b29ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204cde:	60a6                	ld	ra,72(sp)
ffffffffc0204ce0:	6406                	ld	s0,64(sp)
ffffffffc0204ce2:	7942                	ld	s2,48(sp)
ffffffffc0204ce4:	79a2                	ld	s3,40(sp)
ffffffffc0204ce6:	7a02                	ld	s4,32(sp)
ffffffffc0204ce8:	8526                	mv	a0,s1
ffffffffc0204cea:	74e2                	ld	s1,56(sp)
ffffffffc0204cec:	6161                	addi	sp,sp,80
ffffffffc0204cee:	8082                	ret
ffffffffc0204cf0:	7018                	ld	a4,32(s0)
ffffffffc0204cf2:	973e                	add	a4,a4,a5
ffffffffc0204cf4:	f018                	sd	a4,32(s0)
ffffffffc0204cf6:	bff9                	j	ffffffffc0204cd4 <file_write+0x9a>
ffffffffc0204cf8:	54f5                	li	s1,-3
ffffffffc0204cfa:	b7d5                	j	ffffffffc0204cde <file_write+0xa4>
ffffffffc0204cfc:	9d5ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204d00:	00008697          	auipc	a3,0x8
ffffffffc0204d04:	2b068693          	addi	a3,a3,688 # ffffffffc020cfb0 <default_pmm_manager+0xd90>
ffffffffc0204d08:	00007617          	auipc	a2,0x7
ffffffffc0204d0c:	a3060613          	addi	a2,a2,-1488 # ffffffffc020b738 <commands+0x210>
ffffffffc0204d10:	0f800593          	li	a1,248
ffffffffc0204d14:	00008517          	auipc	a0,0x8
ffffffffc0204d18:	0b450513          	addi	a0,a0,180 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204d1c:	f82fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204d20 <file_seek>:
ffffffffc0204d20:	7139                	addi	sp,sp,-64
ffffffffc0204d22:	fc06                	sd	ra,56(sp)
ffffffffc0204d24:	f822                	sd	s0,48(sp)
ffffffffc0204d26:	f426                	sd	s1,40(sp)
ffffffffc0204d28:	f04a                	sd	s2,32(sp)
ffffffffc0204d2a:	04700793          	li	a5,71
ffffffffc0204d2e:	08a7e863          	bltu	a5,a0,ffffffffc0204dbe <file_seek+0x9e>
ffffffffc0204d32:	00092797          	auipc	a5,0x92
ffffffffc0204d36:	b8e7b783          	ld	a5,-1138(a5) # ffffffffc02968c0 <current>
ffffffffc0204d3a:	1487b783          	ld	a5,328(a5)
ffffffffc0204d3e:	cfdd                	beqz	a5,ffffffffc0204dfc <file_seek+0xdc>
ffffffffc0204d40:	4b98                	lw	a4,16(a5)
ffffffffc0204d42:	0ae05d63          	blez	a4,ffffffffc0204dfc <file_seek+0xdc>
ffffffffc0204d46:	6780                	ld	s0,8(a5)
ffffffffc0204d48:	00351793          	slli	a5,a0,0x3
ffffffffc0204d4c:	8f89                	sub	a5,a5,a0
ffffffffc0204d4e:	078e                	slli	a5,a5,0x3
ffffffffc0204d50:	943e                	add	s0,s0,a5
ffffffffc0204d52:	4018                	lw	a4,0(s0)
ffffffffc0204d54:	4789                	li	a5,2
ffffffffc0204d56:	06f71463          	bne	a4,a5,ffffffffc0204dbe <file_seek+0x9e>
ffffffffc0204d5a:	4c1c                	lw	a5,24(s0)
ffffffffc0204d5c:	06a79163          	bne	a5,a0,ffffffffc0204dbe <file_seek+0x9e>
ffffffffc0204d60:	581c                	lw	a5,48(s0)
ffffffffc0204d62:	4685                	li	a3,1
ffffffffc0204d64:	892e                	mv	s2,a1
ffffffffc0204d66:	2785                	addiw	a5,a5,1
ffffffffc0204d68:	d81c                	sw	a5,48(s0)
ffffffffc0204d6a:	02d60063          	beq	a2,a3,ffffffffc0204d8a <file_seek+0x6a>
ffffffffc0204d6e:	06e60063          	beq	a2,a4,ffffffffc0204dce <file_seek+0xae>
ffffffffc0204d72:	54f5                	li	s1,-3
ffffffffc0204d74:	ce11                	beqz	a2,ffffffffc0204d90 <file_seek+0x70>
ffffffffc0204d76:	8522                	mv	a0,s0
ffffffffc0204d78:	a8bff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204d7c:	70e2                	ld	ra,56(sp)
ffffffffc0204d7e:	7442                	ld	s0,48(sp)
ffffffffc0204d80:	7902                	ld	s2,32(sp)
ffffffffc0204d82:	8526                	mv	a0,s1
ffffffffc0204d84:	74a2                	ld	s1,40(sp)
ffffffffc0204d86:	6121                	addi	sp,sp,64
ffffffffc0204d88:	8082                	ret
ffffffffc0204d8a:	701c                	ld	a5,32(s0)
ffffffffc0204d8c:	00f58933          	add	s2,a1,a5
ffffffffc0204d90:	7404                	ld	s1,40(s0)
ffffffffc0204d92:	c4bd                	beqz	s1,ffffffffc0204e00 <file_seek+0xe0>
ffffffffc0204d94:	78bc                	ld	a5,112(s1)
ffffffffc0204d96:	c7ad                	beqz	a5,ffffffffc0204e00 <file_seek+0xe0>
ffffffffc0204d98:	6fbc                	ld	a5,88(a5)
ffffffffc0204d9a:	c3bd                	beqz	a5,ffffffffc0204e00 <file_seek+0xe0>
ffffffffc0204d9c:	8526                	mv	a0,s1
ffffffffc0204d9e:	00008597          	auipc	a1,0x8
ffffffffc0204da2:	2ba58593          	addi	a1,a1,698 # ffffffffc020d058 <default_pmm_manager+0xe38>
ffffffffc0204da6:	081020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0204daa:	78bc                	ld	a5,112(s1)
ffffffffc0204dac:	7408                	ld	a0,40(s0)
ffffffffc0204dae:	85ca                	mv	a1,s2
ffffffffc0204db0:	6fbc                	ld	a5,88(a5)
ffffffffc0204db2:	9782                	jalr	a5
ffffffffc0204db4:	84aa                	mv	s1,a0
ffffffffc0204db6:	f161                	bnez	a0,ffffffffc0204d76 <file_seek+0x56>
ffffffffc0204db8:	03243023          	sd	s2,32(s0)
ffffffffc0204dbc:	bf6d                	j	ffffffffc0204d76 <file_seek+0x56>
ffffffffc0204dbe:	70e2                	ld	ra,56(sp)
ffffffffc0204dc0:	7442                	ld	s0,48(sp)
ffffffffc0204dc2:	54f5                	li	s1,-3
ffffffffc0204dc4:	7902                	ld	s2,32(sp)
ffffffffc0204dc6:	8526                	mv	a0,s1
ffffffffc0204dc8:	74a2                	ld	s1,40(sp)
ffffffffc0204dca:	6121                	addi	sp,sp,64
ffffffffc0204dcc:	8082                	ret
ffffffffc0204dce:	7404                	ld	s1,40(s0)
ffffffffc0204dd0:	c8a1                	beqz	s1,ffffffffc0204e20 <file_seek+0x100>
ffffffffc0204dd2:	78bc                	ld	a5,112(s1)
ffffffffc0204dd4:	c7b1                	beqz	a5,ffffffffc0204e20 <file_seek+0x100>
ffffffffc0204dd6:	779c                	ld	a5,40(a5)
ffffffffc0204dd8:	c7a1                	beqz	a5,ffffffffc0204e20 <file_seek+0x100>
ffffffffc0204dda:	8526                	mv	a0,s1
ffffffffc0204ddc:	00008597          	auipc	a1,0x8
ffffffffc0204de0:	17458593          	addi	a1,a1,372 # ffffffffc020cf50 <default_pmm_manager+0xd30>
ffffffffc0204de4:	043020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0204de8:	78bc                	ld	a5,112(s1)
ffffffffc0204dea:	7408                	ld	a0,40(s0)
ffffffffc0204dec:	858a                	mv	a1,sp
ffffffffc0204dee:	779c                	ld	a5,40(a5)
ffffffffc0204df0:	9782                	jalr	a5
ffffffffc0204df2:	84aa                	mv	s1,a0
ffffffffc0204df4:	f149                	bnez	a0,ffffffffc0204d76 <file_seek+0x56>
ffffffffc0204df6:	67e2                	ld	a5,24(sp)
ffffffffc0204df8:	993e                	add	s2,s2,a5
ffffffffc0204dfa:	bf59                	j	ffffffffc0204d90 <file_seek+0x70>
ffffffffc0204dfc:	8d5ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>
ffffffffc0204e00:	00008697          	auipc	a3,0x8
ffffffffc0204e04:	20868693          	addi	a3,a3,520 # ffffffffc020d008 <default_pmm_manager+0xde8>
ffffffffc0204e08:	00007617          	auipc	a2,0x7
ffffffffc0204e0c:	93060613          	addi	a2,a2,-1744 # ffffffffc020b738 <commands+0x210>
ffffffffc0204e10:	11a00593          	li	a1,282
ffffffffc0204e14:	00008517          	auipc	a0,0x8
ffffffffc0204e18:	fb450513          	addi	a0,a0,-76 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204e1c:	e82fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204e20:	00008697          	auipc	a3,0x8
ffffffffc0204e24:	0e068693          	addi	a3,a3,224 # ffffffffc020cf00 <default_pmm_manager+0xce0>
ffffffffc0204e28:	00007617          	auipc	a2,0x7
ffffffffc0204e2c:	91060613          	addi	a2,a2,-1776 # ffffffffc020b738 <commands+0x210>
ffffffffc0204e30:	11200593          	li	a1,274
ffffffffc0204e34:	00008517          	auipc	a0,0x8
ffffffffc0204e38:	f9450513          	addi	a0,a0,-108 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204e3c:	e62fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204e40 <file_fstat>:
ffffffffc0204e40:	1101                	addi	sp,sp,-32
ffffffffc0204e42:	ec06                	sd	ra,24(sp)
ffffffffc0204e44:	e822                	sd	s0,16(sp)
ffffffffc0204e46:	e426                	sd	s1,8(sp)
ffffffffc0204e48:	e04a                	sd	s2,0(sp)
ffffffffc0204e4a:	04700793          	li	a5,71
ffffffffc0204e4e:	06a7ef63          	bltu	a5,a0,ffffffffc0204ecc <file_fstat+0x8c>
ffffffffc0204e52:	00092797          	auipc	a5,0x92
ffffffffc0204e56:	a6e7b783          	ld	a5,-1426(a5) # ffffffffc02968c0 <current>
ffffffffc0204e5a:	1487b783          	ld	a5,328(a5)
ffffffffc0204e5e:	cfd9                	beqz	a5,ffffffffc0204efc <file_fstat+0xbc>
ffffffffc0204e60:	4b98                	lw	a4,16(a5)
ffffffffc0204e62:	08e05d63          	blez	a4,ffffffffc0204efc <file_fstat+0xbc>
ffffffffc0204e66:	6780                	ld	s0,8(a5)
ffffffffc0204e68:	00351793          	slli	a5,a0,0x3
ffffffffc0204e6c:	8f89                	sub	a5,a5,a0
ffffffffc0204e6e:	078e                	slli	a5,a5,0x3
ffffffffc0204e70:	943e                	add	s0,s0,a5
ffffffffc0204e72:	4018                	lw	a4,0(s0)
ffffffffc0204e74:	4789                	li	a5,2
ffffffffc0204e76:	04f71b63          	bne	a4,a5,ffffffffc0204ecc <file_fstat+0x8c>
ffffffffc0204e7a:	4c1c                	lw	a5,24(s0)
ffffffffc0204e7c:	04a79863          	bne	a5,a0,ffffffffc0204ecc <file_fstat+0x8c>
ffffffffc0204e80:	581c                	lw	a5,48(s0)
ffffffffc0204e82:	02843903          	ld	s2,40(s0)
ffffffffc0204e86:	2785                	addiw	a5,a5,1
ffffffffc0204e88:	d81c                	sw	a5,48(s0)
ffffffffc0204e8a:	04090963          	beqz	s2,ffffffffc0204edc <file_fstat+0x9c>
ffffffffc0204e8e:	07093783          	ld	a5,112(s2)
ffffffffc0204e92:	c7a9                	beqz	a5,ffffffffc0204edc <file_fstat+0x9c>
ffffffffc0204e94:	779c                	ld	a5,40(a5)
ffffffffc0204e96:	c3b9                	beqz	a5,ffffffffc0204edc <file_fstat+0x9c>
ffffffffc0204e98:	84ae                	mv	s1,a1
ffffffffc0204e9a:	854a                	mv	a0,s2
ffffffffc0204e9c:	00008597          	auipc	a1,0x8
ffffffffc0204ea0:	0b458593          	addi	a1,a1,180 # ffffffffc020cf50 <default_pmm_manager+0xd30>
ffffffffc0204ea4:	782020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0204ea8:	07093783          	ld	a5,112(s2)
ffffffffc0204eac:	7408                	ld	a0,40(s0)
ffffffffc0204eae:	85a6                	mv	a1,s1
ffffffffc0204eb0:	779c                	ld	a5,40(a5)
ffffffffc0204eb2:	9782                	jalr	a5
ffffffffc0204eb4:	87aa                	mv	a5,a0
ffffffffc0204eb6:	8522                	mv	a0,s0
ffffffffc0204eb8:	843e                	mv	s0,a5
ffffffffc0204eba:	949ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204ebe:	60e2                	ld	ra,24(sp)
ffffffffc0204ec0:	8522                	mv	a0,s0
ffffffffc0204ec2:	6442                	ld	s0,16(sp)
ffffffffc0204ec4:	64a2                	ld	s1,8(sp)
ffffffffc0204ec6:	6902                	ld	s2,0(sp)
ffffffffc0204ec8:	6105                	addi	sp,sp,32
ffffffffc0204eca:	8082                	ret
ffffffffc0204ecc:	5475                	li	s0,-3
ffffffffc0204ece:	60e2                	ld	ra,24(sp)
ffffffffc0204ed0:	8522                	mv	a0,s0
ffffffffc0204ed2:	6442                	ld	s0,16(sp)
ffffffffc0204ed4:	64a2                	ld	s1,8(sp)
ffffffffc0204ed6:	6902                	ld	s2,0(sp)
ffffffffc0204ed8:	6105                	addi	sp,sp,32
ffffffffc0204eda:	8082                	ret
ffffffffc0204edc:	00008697          	auipc	a3,0x8
ffffffffc0204ee0:	02468693          	addi	a3,a3,36 # ffffffffc020cf00 <default_pmm_manager+0xce0>
ffffffffc0204ee4:	00007617          	auipc	a2,0x7
ffffffffc0204ee8:	85460613          	addi	a2,a2,-1964 # ffffffffc020b738 <commands+0x210>
ffffffffc0204eec:	12c00593          	li	a1,300
ffffffffc0204ef0:	00008517          	auipc	a0,0x8
ffffffffc0204ef4:	ed850513          	addi	a0,a0,-296 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204ef8:	da6fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204efc:	fd4ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204f00 <file_fsync>:
ffffffffc0204f00:	1101                	addi	sp,sp,-32
ffffffffc0204f02:	ec06                	sd	ra,24(sp)
ffffffffc0204f04:	e822                	sd	s0,16(sp)
ffffffffc0204f06:	e426                	sd	s1,8(sp)
ffffffffc0204f08:	04700793          	li	a5,71
ffffffffc0204f0c:	06a7e863          	bltu	a5,a0,ffffffffc0204f7c <file_fsync+0x7c>
ffffffffc0204f10:	00092797          	auipc	a5,0x92
ffffffffc0204f14:	9b07b783          	ld	a5,-1616(a5) # ffffffffc02968c0 <current>
ffffffffc0204f18:	1487b783          	ld	a5,328(a5)
ffffffffc0204f1c:	c7d9                	beqz	a5,ffffffffc0204faa <file_fsync+0xaa>
ffffffffc0204f1e:	4b98                	lw	a4,16(a5)
ffffffffc0204f20:	08e05563          	blez	a4,ffffffffc0204faa <file_fsync+0xaa>
ffffffffc0204f24:	6780                	ld	s0,8(a5)
ffffffffc0204f26:	00351793          	slli	a5,a0,0x3
ffffffffc0204f2a:	8f89                	sub	a5,a5,a0
ffffffffc0204f2c:	078e                	slli	a5,a5,0x3
ffffffffc0204f2e:	943e                	add	s0,s0,a5
ffffffffc0204f30:	4018                	lw	a4,0(s0)
ffffffffc0204f32:	4789                	li	a5,2
ffffffffc0204f34:	04f71463          	bne	a4,a5,ffffffffc0204f7c <file_fsync+0x7c>
ffffffffc0204f38:	4c1c                	lw	a5,24(s0)
ffffffffc0204f3a:	04a79163          	bne	a5,a0,ffffffffc0204f7c <file_fsync+0x7c>
ffffffffc0204f3e:	581c                	lw	a5,48(s0)
ffffffffc0204f40:	7404                	ld	s1,40(s0)
ffffffffc0204f42:	2785                	addiw	a5,a5,1
ffffffffc0204f44:	d81c                	sw	a5,48(s0)
ffffffffc0204f46:	c0b1                	beqz	s1,ffffffffc0204f8a <file_fsync+0x8a>
ffffffffc0204f48:	78bc                	ld	a5,112(s1)
ffffffffc0204f4a:	c3a1                	beqz	a5,ffffffffc0204f8a <file_fsync+0x8a>
ffffffffc0204f4c:	7b9c                	ld	a5,48(a5)
ffffffffc0204f4e:	cf95                	beqz	a5,ffffffffc0204f8a <file_fsync+0x8a>
ffffffffc0204f50:	00008597          	auipc	a1,0x8
ffffffffc0204f54:	16058593          	addi	a1,a1,352 # ffffffffc020d0b0 <default_pmm_manager+0xe90>
ffffffffc0204f58:	8526                	mv	a0,s1
ffffffffc0204f5a:	6cc020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0204f5e:	78bc                	ld	a5,112(s1)
ffffffffc0204f60:	7408                	ld	a0,40(s0)
ffffffffc0204f62:	7b9c                	ld	a5,48(a5)
ffffffffc0204f64:	9782                	jalr	a5
ffffffffc0204f66:	87aa                	mv	a5,a0
ffffffffc0204f68:	8522                	mv	a0,s0
ffffffffc0204f6a:	843e                	mv	s0,a5
ffffffffc0204f6c:	897ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc0204f70:	60e2                	ld	ra,24(sp)
ffffffffc0204f72:	8522                	mv	a0,s0
ffffffffc0204f74:	6442                	ld	s0,16(sp)
ffffffffc0204f76:	64a2                	ld	s1,8(sp)
ffffffffc0204f78:	6105                	addi	sp,sp,32
ffffffffc0204f7a:	8082                	ret
ffffffffc0204f7c:	5475                	li	s0,-3
ffffffffc0204f7e:	60e2                	ld	ra,24(sp)
ffffffffc0204f80:	8522                	mv	a0,s0
ffffffffc0204f82:	6442                	ld	s0,16(sp)
ffffffffc0204f84:	64a2                	ld	s1,8(sp)
ffffffffc0204f86:	6105                	addi	sp,sp,32
ffffffffc0204f88:	8082                	ret
ffffffffc0204f8a:	00008697          	auipc	a3,0x8
ffffffffc0204f8e:	0d668693          	addi	a3,a3,214 # ffffffffc020d060 <default_pmm_manager+0xe40>
ffffffffc0204f92:	00006617          	auipc	a2,0x6
ffffffffc0204f96:	7a660613          	addi	a2,a2,1958 # ffffffffc020b738 <commands+0x210>
ffffffffc0204f9a:	13a00593          	li	a1,314
ffffffffc0204f9e:	00008517          	auipc	a0,0x8
ffffffffc0204fa2:	e2a50513          	addi	a0,a0,-470 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc0204fa6:	cf8fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204faa:	f26ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0204fae <file_getdirentry>:
ffffffffc0204fae:	715d                	addi	sp,sp,-80
ffffffffc0204fb0:	e486                	sd	ra,72(sp)
ffffffffc0204fb2:	e0a2                	sd	s0,64(sp)
ffffffffc0204fb4:	fc26                	sd	s1,56(sp)
ffffffffc0204fb6:	f84a                	sd	s2,48(sp)
ffffffffc0204fb8:	f44e                	sd	s3,40(sp)
ffffffffc0204fba:	04700793          	li	a5,71
ffffffffc0204fbe:	0aa7e063          	bltu	a5,a0,ffffffffc020505e <file_getdirentry+0xb0>
ffffffffc0204fc2:	00092797          	auipc	a5,0x92
ffffffffc0204fc6:	8fe7b783          	ld	a5,-1794(a5) # ffffffffc02968c0 <current>
ffffffffc0204fca:	1487b783          	ld	a5,328(a5)
ffffffffc0204fce:	c3e9                	beqz	a5,ffffffffc0205090 <file_getdirentry+0xe2>
ffffffffc0204fd0:	4b98                	lw	a4,16(a5)
ffffffffc0204fd2:	0ae05f63          	blez	a4,ffffffffc0205090 <file_getdirentry+0xe2>
ffffffffc0204fd6:	6780                	ld	s0,8(a5)
ffffffffc0204fd8:	00351793          	slli	a5,a0,0x3
ffffffffc0204fdc:	8f89                	sub	a5,a5,a0
ffffffffc0204fde:	078e                	slli	a5,a5,0x3
ffffffffc0204fe0:	943e                	add	s0,s0,a5
ffffffffc0204fe2:	4018                	lw	a4,0(s0)
ffffffffc0204fe4:	4789                	li	a5,2
ffffffffc0204fe6:	06f71c63          	bne	a4,a5,ffffffffc020505e <file_getdirentry+0xb0>
ffffffffc0204fea:	4c1c                	lw	a5,24(s0)
ffffffffc0204fec:	06a79963          	bne	a5,a0,ffffffffc020505e <file_getdirentry+0xb0>
ffffffffc0204ff0:	581c                	lw	a5,48(s0)
ffffffffc0204ff2:	6194                	ld	a3,0(a1)
ffffffffc0204ff4:	84ae                	mv	s1,a1
ffffffffc0204ff6:	2785                	addiw	a5,a5,1
ffffffffc0204ff8:	10000613          	li	a2,256
ffffffffc0204ffc:	d81c                	sw	a5,48(s0)
ffffffffc0204ffe:	05a1                	addi	a1,a1,8
ffffffffc0205000:	850a                	mv	a0,sp
ffffffffc0205002:	33e000ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0205006:	02843983          	ld	s3,40(s0)
ffffffffc020500a:	892a                	mv	s2,a0
ffffffffc020500c:	06098263          	beqz	s3,ffffffffc0205070 <file_getdirentry+0xc2>
ffffffffc0205010:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc0205014:	cfb1                	beqz	a5,ffffffffc0205070 <file_getdirentry+0xc2>
ffffffffc0205016:	63bc                	ld	a5,64(a5)
ffffffffc0205018:	cfa1                	beqz	a5,ffffffffc0205070 <file_getdirentry+0xc2>
ffffffffc020501a:	854e                	mv	a0,s3
ffffffffc020501c:	00008597          	auipc	a1,0x8
ffffffffc0205020:	0f458593          	addi	a1,a1,244 # ffffffffc020d110 <default_pmm_manager+0xef0>
ffffffffc0205024:	602020ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0205028:	0709b783          	ld	a5,112(s3)
ffffffffc020502c:	7408                	ld	a0,40(s0)
ffffffffc020502e:	85ca                	mv	a1,s2
ffffffffc0205030:	63bc                	ld	a5,64(a5)
ffffffffc0205032:	9782                	jalr	a5
ffffffffc0205034:	89aa                	mv	s3,a0
ffffffffc0205036:	e909                	bnez	a0,ffffffffc0205048 <file_getdirentry+0x9a>
ffffffffc0205038:	609c                	ld	a5,0(s1)
ffffffffc020503a:	01093683          	ld	a3,16(s2)
ffffffffc020503e:	01893703          	ld	a4,24(s2)
ffffffffc0205042:	97b6                	add	a5,a5,a3
ffffffffc0205044:	8f99                	sub	a5,a5,a4
ffffffffc0205046:	e09c                	sd	a5,0(s1)
ffffffffc0205048:	8522                	mv	a0,s0
ffffffffc020504a:	fb8ff0ef          	jal	ra,ffffffffc0204802 <fd_array_release>
ffffffffc020504e:	60a6                	ld	ra,72(sp)
ffffffffc0205050:	6406                	ld	s0,64(sp)
ffffffffc0205052:	74e2                	ld	s1,56(sp)
ffffffffc0205054:	7942                	ld	s2,48(sp)
ffffffffc0205056:	854e                	mv	a0,s3
ffffffffc0205058:	79a2                	ld	s3,40(sp)
ffffffffc020505a:	6161                	addi	sp,sp,80
ffffffffc020505c:	8082                	ret
ffffffffc020505e:	60a6                	ld	ra,72(sp)
ffffffffc0205060:	6406                	ld	s0,64(sp)
ffffffffc0205062:	59f5                	li	s3,-3
ffffffffc0205064:	74e2                	ld	s1,56(sp)
ffffffffc0205066:	7942                	ld	s2,48(sp)
ffffffffc0205068:	854e                	mv	a0,s3
ffffffffc020506a:	79a2                	ld	s3,40(sp)
ffffffffc020506c:	6161                	addi	sp,sp,80
ffffffffc020506e:	8082                	ret
ffffffffc0205070:	00008697          	auipc	a3,0x8
ffffffffc0205074:	04868693          	addi	a3,a3,72 # ffffffffc020d0b8 <default_pmm_manager+0xe98>
ffffffffc0205078:	00006617          	auipc	a2,0x6
ffffffffc020507c:	6c060613          	addi	a2,a2,1728 # ffffffffc020b738 <commands+0x210>
ffffffffc0205080:	14a00593          	li	a1,330
ffffffffc0205084:	00008517          	auipc	a0,0x8
ffffffffc0205088:	d4450513          	addi	a0,a0,-700 # ffffffffc020cdc8 <default_pmm_manager+0xba8>
ffffffffc020508c:	c12fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205090:	e40ff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0205094 <file_dup>:
ffffffffc0205094:	04700713          	li	a4,71
ffffffffc0205098:	06a76463          	bltu	a4,a0,ffffffffc0205100 <file_dup+0x6c>
ffffffffc020509c:	00092717          	auipc	a4,0x92
ffffffffc02050a0:	82473703          	ld	a4,-2012(a4) # ffffffffc02968c0 <current>
ffffffffc02050a4:	14873703          	ld	a4,328(a4)
ffffffffc02050a8:	1101                	addi	sp,sp,-32
ffffffffc02050aa:	ec06                	sd	ra,24(sp)
ffffffffc02050ac:	e822                	sd	s0,16(sp)
ffffffffc02050ae:	cb39                	beqz	a4,ffffffffc0205104 <file_dup+0x70>
ffffffffc02050b0:	4b14                	lw	a3,16(a4)
ffffffffc02050b2:	04d05963          	blez	a3,ffffffffc0205104 <file_dup+0x70>
ffffffffc02050b6:	6700                	ld	s0,8(a4)
ffffffffc02050b8:	00351713          	slli	a4,a0,0x3
ffffffffc02050bc:	8f09                	sub	a4,a4,a0
ffffffffc02050be:	070e                	slli	a4,a4,0x3
ffffffffc02050c0:	943a                	add	s0,s0,a4
ffffffffc02050c2:	4014                	lw	a3,0(s0)
ffffffffc02050c4:	4709                	li	a4,2
ffffffffc02050c6:	02e69863          	bne	a3,a4,ffffffffc02050f6 <file_dup+0x62>
ffffffffc02050ca:	4c18                	lw	a4,24(s0)
ffffffffc02050cc:	02a71563          	bne	a4,a0,ffffffffc02050f6 <file_dup+0x62>
ffffffffc02050d0:	852e                	mv	a0,a1
ffffffffc02050d2:	002c                	addi	a1,sp,8
ffffffffc02050d4:	e1eff0ef          	jal	ra,ffffffffc02046f2 <fd_array_alloc>
ffffffffc02050d8:	c509                	beqz	a0,ffffffffc02050e2 <file_dup+0x4e>
ffffffffc02050da:	60e2                	ld	ra,24(sp)
ffffffffc02050dc:	6442                	ld	s0,16(sp)
ffffffffc02050de:	6105                	addi	sp,sp,32
ffffffffc02050e0:	8082                	ret
ffffffffc02050e2:	6522                	ld	a0,8(sp)
ffffffffc02050e4:	85a2                	mv	a1,s0
ffffffffc02050e6:	845ff0ef          	jal	ra,ffffffffc020492a <fd_array_dup>
ffffffffc02050ea:	67a2                	ld	a5,8(sp)
ffffffffc02050ec:	60e2                	ld	ra,24(sp)
ffffffffc02050ee:	6442                	ld	s0,16(sp)
ffffffffc02050f0:	4f88                	lw	a0,24(a5)
ffffffffc02050f2:	6105                	addi	sp,sp,32
ffffffffc02050f4:	8082                	ret
ffffffffc02050f6:	60e2                	ld	ra,24(sp)
ffffffffc02050f8:	6442                	ld	s0,16(sp)
ffffffffc02050fa:	5575                	li	a0,-3
ffffffffc02050fc:	6105                	addi	sp,sp,32
ffffffffc02050fe:	8082                	ret
ffffffffc0205100:	5575                	li	a0,-3
ffffffffc0205102:	8082                	ret
ffffffffc0205104:	dccff0ef          	jal	ra,ffffffffc02046d0 <get_fd_array.part.0>

ffffffffc0205108 <fs_init>:
ffffffffc0205108:	1141                	addi	sp,sp,-16
ffffffffc020510a:	e406                	sd	ra,8(sp)
ffffffffc020510c:	738020ef          	jal	ra,ffffffffc0207844 <vfs_init>
ffffffffc0205110:	410030ef          	jal	ra,ffffffffc0208520 <dev_init>
ffffffffc0205114:	60a2                	ld	ra,8(sp)
ffffffffc0205116:	0141                	addi	sp,sp,16
ffffffffc0205118:	5610306f          	j	ffffffffc0208e78 <sfs_init>

ffffffffc020511c <fs_cleanup>:
ffffffffc020511c:	17b0206f          	j	ffffffffc0207a96 <vfs_cleanup>

ffffffffc0205120 <lock_files>:
ffffffffc0205120:	0561                	addi	a0,a0,24
ffffffffc0205122:	ba0ff06f          	j	ffffffffc02044c2 <down>

ffffffffc0205126 <unlock_files>:
ffffffffc0205126:	0561                	addi	a0,a0,24
ffffffffc0205128:	b96ff06f          	j	ffffffffc02044be <up>

ffffffffc020512c <files_create>:
ffffffffc020512c:	1141                	addi	sp,sp,-16
ffffffffc020512e:	6505                	lui	a0,0x1
ffffffffc0205130:	e022                	sd	s0,0(sp)
ffffffffc0205132:	e406                	sd	ra,8(sp)
ffffffffc0205134:	e5bfc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205138:	842a                	mv	s0,a0
ffffffffc020513a:	cd19                	beqz	a0,ffffffffc0205158 <files_create+0x2c>
ffffffffc020513c:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc0205140:	00043023          	sd	zero,0(s0)
ffffffffc0205144:	0561                	addi	a0,a0,24
ffffffffc0205146:	e41c                	sd	a5,8(s0)
ffffffffc0205148:	00042823          	sw	zero,16(s0)
ffffffffc020514c:	4585                	li	a1,1
ffffffffc020514e:	b6aff0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0205152:	6408                	ld	a0,8(s0)
ffffffffc0205154:	f3cff0ef          	jal	ra,ffffffffc0204890 <fd_array_init>
ffffffffc0205158:	60a2                	ld	ra,8(sp)
ffffffffc020515a:	8522                	mv	a0,s0
ffffffffc020515c:	6402                	ld	s0,0(sp)
ffffffffc020515e:	0141                	addi	sp,sp,16
ffffffffc0205160:	8082                	ret

ffffffffc0205162 <files_destroy>:
ffffffffc0205162:	7179                	addi	sp,sp,-48
ffffffffc0205164:	f406                	sd	ra,40(sp)
ffffffffc0205166:	f022                	sd	s0,32(sp)
ffffffffc0205168:	ec26                	sd	s1,24(sp)
ffffffffc020516a:	e84a                	sd	s2,16(sp)
ffffffffc020516c:	e44e                	sd	s3,8(sp)
ffffffffc020516e:	c52d                	beqz	a0,ffffffffc02051d8 <files_destroy+0x76>
ffffffffc0205170:	491c                	lw	a5,16(a0)
ffffffffc0205172:	89aa                	mv	s3,a0
ffffffffc0205174:	e3b5                	bnez	a5,ffffffffc02051d8 <files_destroy+0x76>
ffffffffc0205176:	6108                	ld	a0,0(a0)
ffffffffc0205178:	c119                	beqz	a0,ffffffffc020517e <files_destroy+0x1c>
ffffffffc020517a:	562020ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020517e:	0089b403          	ld	s0,8(s3)
ffffffffc0205182:	6485                	lui	s1,0x1
ffffffffc0205184:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205188:	94a2                	add	s1,s1,s0
ffffffffc020518a:	4909                	li	s2,2
ffffffffc020518c:	401c                	lw	a5,0(s0)
ffffffffc020518e:	03278063          	beq	a5,s2,ffffffffc02051ae <files_destroy+0x4c>
ffffffffc0205192:	e39d                	bnez	a5,ffffffffc02051b8 <files_destroy+0x56>
ffffffffc0205194:	03840413          	addi	s0,s0,56
ffffffffc0205198:	fe849ae3          	bne	s1,s0,ffffffffc020518c <files_destroy+0x2a>
ffffffffc020519c:	7402                	ld	s0,32(sp)
ffffffffc020519e:	70a2                	ld	ra,40(sp)
ffffffffc02051a0:	64e2                	ld	s1,24(sp)
ffffffffc02051a2:	6942                	ld	s2,16(sp)
ffffffffc02051a4:	854e                	mv	a0,s3
ffffffffc02051a6:	69a2                	ld	s3,8(sp)
ffffffffc02051a8:	6145                	addi	sp,sp,48
ffffffffc02051aa:	e95fc06f          	j	ffffffffc020203e <kfree>
ffffffffc02051ae:	8522                	mv	a0,s0
ffffffffc02051b0:	efcff0ef          	jal	ra,ffffffffc02048ac <fd_array_close>
ffffffffc02051b4:	401c                	lw	a5,0(s0)
ffffffffc02051b6:	bff1                	j	ffffffffc0205192 <files_destroy+0x30>
ffffffffc02051b8:	00008697          	auipc	a3,0x8
ffffffffc02051bc:	fd868693          	addi	a3,a3,-40 # ffffffffc020d190 <CSWTCH.79+0x58>
ffffffffc02051c0:	00006617          	auipc	a2,0x6
ffffffffc02051c4:	57860613          	addi	a2,a2,1400 # ffffffffc020b738 <commands+0x210>
ffffffffc02051c8:	03d00593          	li	a1,61
ffffffffc02051cc:	00008517          	auipc	a0,0x8
ffffffffc02051d0:	fb450513          	addi	a0,a0,-76 # ffffffffc020d180 <CSWTCH.79+0x48>
ffffffffc02051d4:	acafb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02051d8:	00008697          	auipc	a3,0x8
ffffffffc02051dc:	f7868693          	addi	a3,a3,-136 # ffffffffc020d150 <CSWTCH.79+0x18>
ffffffffc02051e0:	00006617          	auipc	a2,0x6
ffffffffc02051e4:	55860613          	addi	a2,a2,1368 # ffffffffc020b738 <commands+0x210>
ffffffffc02051e8:	03300593          	li	a1,51
ffffffffc02051ec:	00008517          	auipc	a0,0x8
ffffffffc02051f0:	f9450513          	addi	a0,a0,-108 # ffffffffc020d180 <CSWTCH.79+0x48>
ffffffffc02051f4:	aaafb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02051f8 <files_closeall>:
ffffffffc02051f8:	1101                	addi	sp,sp,-32
ffffffffc02051fa:	ec06                	sd	ra,24(sp)
ffffffffc02051fc:	e822                	sd	s0,16(sp)
ffffffffc02051fe:	e426                	sd	s1,8(sp)
ffffffffc0205200:	e04a                	sd	s2,0(sp)
ffffffffc0205202:	c129                	beqz	a0,ffffffffc0205244 <files_closeall+0x4c>
ffffffffc0205204:	491c                	lw	a5,16(a0)
ffffffffc0205206:	02f05f63          	blez	a5,ffffffffc0205244 <files_closeall+0x4c>
ffffffffc020520a:	6504                	ld	s1,8(a0)
ffffffffc020520c:	6785                	lui	a5,0x1
ffffffffc020520e:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205212:	07048413          	addi	s0,s1,112
ffffffffc0205216:	4909                	li	s2,2
ffffffffc0205218:	94be                	add	s1,s1,a5
ffffffffc020521a:	a029                	j	ffffffffc0205224 <files_closeall+0x2c>
ffffffffc020521c:	03840413          	addi	s0,s0,56
ffffffffc0205220:	00848c63          	beq	s1,s0,ffffffffc0205238 <files_closeall+0x40>
ffffffffc0205224:	401c                	lw	a5,0(s0)
ffffffffc0205226:	ff279be3          	bne	a5,s2,ffffffffc020521c <files_closeall+0x24>
ffffffffc020522a:	8522                	mv	a0,s0
ffffffffc020522c:	03840413          	addi	s0,s0,56
ffffffffc0205230:	e7cff0ef          	jal	ra,ffffffffc02048ac <fd_array_close>
ffffffffc0205234:	fe8498e3          	bne	s1,s0,ffffffffc0205224 <files_closeall+0x2c>
ffffffffc0205238:	60e2                	ld	ra,24(sp)
ffffffffc020523a:	6442                	ld	s0,16(sp)
ffffffffc020523c:	64a2                	ld	s1,8(sp)
ffffffffc020523e:	6902                	ld	s2,0(sp)
ffffffffc0205240:	6105                	addi	sp,sp,32
ffffffffc0205242:	8082                	ret
ffffffffc0205244:	00008697          	auipc	a3,0x8
ffffffffc0205248:	b5468693          	addi	a3,a3,-1196 # ffffffffc020cd98 <default_pmm_manager+0xb78>
ffffffffc020524c:	00006617          	auipc	a2,0x6
ffffffffc0205250:	4ec60613          	addi	a2,a2,1260 # ffffffffc020b738 <commands+0x210>
ffffffffc0205254:	04500593          	li	a1,69
ffffffffc0205258:	00008517          	auipc	a0,0x8
ffffffffc020525c:	f2850513          	addi	a0,a0,-216 # ffffffffc020d180 <CSWTCH.79+0x48>
ffffffffc0205260:	a3efb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205264 <dup_files>:
ffffffffc0205264:	7179                	addi	sp,sp,-48
ffffffffc0205266:	f406                	sd	ra,40(sp)
ffffffffc0205268:	f022                	sd	s0,32(sp)
ffffffffc020526a:	ec26                	sd	s1,24(sp)
ffffffffc020526c:	e84a                	sd	s2,16(sp)
ffffffffc020526e:	e44e                	sd	s3,8(sp)
ffffffffc0205270:	e052                	sd	s4,0(sp)
ffffffffc0205272:	c52d                	beqz	a0,ffffffffc02052dc <dup_files+0x78>
ffffffffc0205274:	842e                	mv	s0,a1
ffffffffc0205276:	c1bd                	beqz	a1,ffffffffc02052dc <dup_files+0x78>
ffffffffc0205278:	491c                	lw	a5,16(a0)
ffffffffc020527a:	84aa                	mv	s1,a0
ffffffffc020527c:	e3c1                	bnez	a5,ffffffffc02052fc <dup_files+0x98>
ffffffffc020527e:	499c                	lw	a5,16(a1)
ffffffffc0205280:	06f05e63          	blez	a5,ffffffffc02052fc <dup_files+0x98>
ffffffffc0205284:	6188                	ld	a0,0(a1)
ffffffffc0205286:	e088                	sd	a0,0(s1)
ffffffffc0205288:	c119                	beqz	a0,ffffffffc020528e <dup_files+0x2a>
ffffffffc020528a:	384020ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc020528e:	6400                	ld	s0,8(s0)
ffffffffc0205290:	6905                	lui	s2,0x1
ffffffffc0205292:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205296:	6484                	ld	s1,8(s1)
ffffffffc0205298:	9922                	add	s2,s2,s0
ffffffffc020529a:	4989                	li	s3,2
ffffffffc020529c:	4a05                	li	s4,1
ffffffffc020529e:	a039                	j	ffffffffc02052ac <dup_files+0x48>
ffffffffc02052a0:	03840413          	addi	s0,s0,56
ffffffffc02052a4:	03848493          	addi	s1,s1,56
ffffffffc02052a8:	02890163          	beq	s2,s0,ffffffffc02052ca <dup_files+0x66>
ffffffffc02052ac:	401c                	lw	a5,0(s0)
ffffffffc02052ae:	ff3799e3          	bne	a5,s3,ffffffffc02052a0 <dup_files+0x3c>
ffffffffc02052b2:	0144a023          	sw	s4,0(s1)
ffffffffc02052b6:	85a2                	mv	a1,s0
ffffffffc02052b8:	8526                	mv	a0,s1
ffffffffc02052ba:	03840413          	addi	s0,s0,56
ffffffffc02052be:	e6cff0ef          	jal	ra,ffffffffc020492a <fd_array_dup>
ffffffffc02052c2:	03848493          	addi	s1,s1,56
ffffffffc02052c6:	fe8913e3          	bne	s2,s0,ffffffffc02052ac <dup_files+0x48>
ffffffffc02052ca:	70a2                	ld	ra,40(sp)
ffffffffc02052cc:	7402                	ld	s0,32(sp)
ffffffffc02052ce:	64e2                	ld	s1,24(sp)
ffffffffc02052d0:	6942                	ld	s2,16(sp)
ffffffffc02052d2:	69a2                	ld	s3,8(sp)
ffffffffc02052d4:	6a02                	ld	s4,0(sp)
ffffffffc02052d6:	4501                	li	a0,0
ffffffffc02052d8:	6145                	addi	sp,sp,48
ffffffffc02052da:	8082                	ret
ffffffffc02052dc:	00008697          	auipc	a3,0x8
ffffffffc02052e0:	80c68693          	addi	a3,a3,-2036 # ffffffffc020cae8 <default_pmm_manager+0x8c8>
ffffffffc02052e4:	00006617          	auipc	a2,0x6
ffffffffc02052e8:	45460613          	addi	a2,a2,1108 # ffffffffc020b738 <commands+0x210>
ffffffffc02052ec:	05300593          	li	a1,83
ffffffffc02052f0:	00008517          	auipc	a0,0x8
ffffffffc02052f4:	e9050513          	addi	a0,a0,-368 # ffffffffc020d180 <CSWTCH.79+0x48>
ffffffffc02052f8:	9a6fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02052fc:	00008697          	auipc	a3,0x8
ffffffffc0205300:	eac68693          	addi	a3,a3,-340 # ffffffffc020d1a8 <CSWTCH.79+0x70>
ffffffffc0205304:	00006617          	auipc	a2,0x6
ffffffffc0205308:	43460613          	addi	a2,a2,1076 # ffffffffc020b738 <commands+0x210>
ffffffffc020530c:	05400593          	li	a1,84
ffffffffc0205310:	00008517          	auipc	a0,0x8
ffffffffc0205314:	e7050513          	addi	a0,a0,-400 # ffffffffc020d180 <CSWTCH.79+0x48>
ffffffffc0205318:	986fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020531c <iobuf_skip.part.0>:
ffffffffc020531c:	1141                	addi	sp,sp,-16
ffffffffc020531e:	00008697          	auipc	a3,0x8
ffffffffc0205322:	eba68693          	addi	a3,a3,-326 # ffffffffc020d1d8 <CSWTCH.79+0xa0>
ffffffffc0205326:	00006617          	auipc	a2,0x6
ffffffffc020532a:	41260613          	addi	a2,a2,1042 # ffffffffc020b738 <commands+0x210>
ffffffffc020532e:	04a00593          	li	a1,74
ffffffffc0205332:	00008517          	auipc	a0,0x8
ffffffffc0205336:	ebe50513          	addi	a0,a0,-322 # ffffffffc020d1f0 <CSWTCH.79+0xb8>
ffffffffc020533a:	e406                	sd	ra,8(sp)
ffffffffc020533c:	962fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205340 <iobuf_init>:
ffffffffc0205340:	e10c                	sd	a1,0(a0)
ffffffffc0205342:	e514                	sd	a3,8(a0)
ffffffffc0205344:	ed10                	sd	a2,24(a0)
ffffffffc0205346:	e910                	sd	a2,16(a0)
ffffffffc0205348:	8082                	ret

ffffffffc020534a <iobuf_move>:
ffffffffc020534a:	7179                	addi	sp,sp,-48
ffffffffc020534c:	ec26                	sd	s1,24(sp)
ffffffffc020534e:	6d04                	ld	s1,24(a0)
ffffffffc0205350:	f022                	sd	s0,32(sp)
ffffffffc0205352:	e84a                	sd	s2,16(sp)
ffffffffc0205354:	e44e                	sd	s3,8(sp)
ffffffffc0205356:	f406                	sd	ra,40(sp)
ffffffffc0205358:	842a                	mv	s0,a0
ffffffffc020535a:	8932                	mv	s2,a2
ffffffffc020535c:	852e                	mv	a0,a1
ffffffffc020535e:	89ba                	mv	s3,a4
ffffffffc0205360:	00967363          	bgeu	a2,s1,ffffffffc0205366 <iobuf_move+0x1c>
ffffffffc0205364:	84b2                	mv	s1,a2
ffffffffc0205366:	c495                	beqz	s1,ffffffffc0205392 <iobuf_move+0x48>
ffffffffc0205368:	600c                	ld	a1,0(s0)
ffffffffc020536a:	c681                	beqz	a3,ffffffffc0205372 <iobuf_move+0x28>
ffffffffc020536c:	87ae                	mv	a5,a1
ffffffffc020536e:	85aa                	mv	a1,a0
ffffffffc0205370:	853e                	mv	a0,a5
ffffffffc0205372:	8626                	mv	a2,s1
ffffffffc0205374:	6ef050ef          	jal	ra,ffffffffc020b262 <memmove>
ffffffffc0205378:	6c1c                	ld	a5,24(s0)
ffffffffc020537a:	0297ea63          	bltu	a5,s1,ffffffffc02053ae <iobuf_move+0x64>
ffffffffc020537e:	6014                	ld	a3,0(s0)
ffffffffc0205380:	6418                	ld	a4,8(s0)
ffffffffc0205382:	8f85                	sub	a5,a5,s1
ffffffffc0205384:	96a6                	add	a3,a3,s1
ffffffffc0205386:	9726                	add	a4,a4,s1
ffffffffc0205388:	e014                	sd	a3,0(s0)
ffffffffc020538a:	e418                	sd	a4,8(s0)
ffffffffc020538c:	ec1c                	sd	a5,24(s0)
ffffffffc020538e:	40990933          	sub	s2,s2,s1
ffffffffc0205392:	00098463          	beqz	s3,ffffffffc020539a <iobuf_move+0x50>
ffffffffc0205396:	0099b023          	sd	s1,0(s3)
ffffffffc020539a:	4501                	li	a0,0
ffffffffc020539c:	00091b63          	bnez	s2,ffffffffc02053b2 <iobuf_move+0x68>
ffffffffc02053a0:	70a2                	ld	ra,40(sp)
ffffffffc02053a2:	7402                	ld	s0,32(sp)
ffffffffc02053a4:	64e2                	ld	s1,24(sp)
ffffffffc02053a6:	6942                	ld	s2,16(sp)
ffffffffc02053a8:	69a2                	ld	s3,8(sp)
ffffffffc02053aa:	6145                	addi	sp,sp,48
ffffffffc02053ac:	8082                	ret
ffffffffc02053ae:	f6fff0ef          	jal	ra,ffffffffc020531c <iobuf_skip.part.0>
ffffffffc02053b2:	5571                	li	a0,-4
ffffffffc02053b4:	b7f5                	j	ffffffffc02053a0 <iobuf_move+0x56>

ffffffffc02053b6 <iobuf_skip>:
ffffffffc02053b6:	6d1c                	ld	a5,24(a0)
ffffffffc02053b8:	00b7eb63          	bltu	a5,a1,ffffffffc02053ce <iobuf_skip+0x18>
ffffffffc02053bc:	6114                	ld	a3,0(a0)
ffffffffc02053be:	6518                	ld	a4,8(a0)
ffffffffc02053c0:	8f8d                	sub	a5,a5,a1
ffffffffc02053c2:	96ae                	add	a3,a3,a1
ffffffffc02053c4:	95ba                	add	a1,a1,a4
ffffffffc02053c6:	e114                	sd	a3,0(a0)
ffffffffc02053c8:	e50c                	sd	a1,8(a0)
ffffffffc02053ca:	ed1c                	sd	a5,24(a0)
ffffffffc02053cc:	8082                	ret
ffffffffc02053ce:	1141                	addi	sp,sp,-16
ffffffffc02053d0:	e406                	sd	ra,8(sp)
ffffffffc02053d2:	f4bff0ef          	jal	ra,ffffffffc020531c <iobuf_skip.part.0>

ffffffffc02053d6 <copy_path>:
ffffffffc02053d6:	7139                	addi	sp,sp,-64
ffffffffc02053d8:	f04a                	sd	s2,32(sp)
ffffffffc02053da:	00091917          	auipc	s2,0x91
ffffffffc02053de:	4e690913          	addi	s2,s2,1254 # ffffffffc02968c0 <current>
ffffffffc02053e2:	00093703          	ld	a4,0(s2)
ffffffffc02053e6:	ec4e                	sd	s3,24(sp)
ffffffffc02053e8:	89aa                	mv	s3,a0
ffffffffc02053ea:	6505                	lui	a0,0x1
ffffffffc02053ec:	f426                	sd	s1,40(sp)
ffffffffc02053ee:	e852                	sd	s4,16(sp)
ffffffffc02053f0:	fc06                	sd	ra,56(sp)
ffffffffc02053f2:	f822                	sd	s0,48(sp)
ffffffffc02053f4:	e456                	sd	s5,8(sp)
ffffffffc02053f6:	02873a03          	ld	s4,40(a4)
ffffffffc02053fa:	84ae                	mv	s1,a1
ffffffffc02053fc:	b93fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205400:	c141                	beqz	a0,ffffffffc0205480 <copy_path+0xaa>
ffffffffc0205402:	842a                	mv	s0,a0
ffffffffc0205404:	040a0563          	beqz	s4,ffffffffc020544e <copy_path+0x78>
ffffffffc0205408:	038a0a93          	addi	s5,s4,56
ffffffffc020540c:	8556                	mv	a0,s5
ffffffffc020540e:	8b4ff0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205412:	00093783          	ld	a5,0(s2)
ffffffffc0205416:	cba1                	beqz	a5,ffffffffc0205466 <copy_path+0x90>
ffffffffc0205418:	43dc                	lw	a5,4(a5)
ffffffffc020541a:	6685                	lui	a3,0x1
ffffffffc020541c:	8626                	mv	a2,s1
ffffffffc020541e:	04fa2823          	sw	a5,80(s4)
ffffffffc0205422:	85a2                	mv	a1,s0
ffffffffc0205424:	8552                	mv	a0,s4
ffffffffc0205426:	ec5fe0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc020542a:	c529                	beqz	a0,ffffffffc0205474 <copy_path+0x9e>
ffffffffc020542c:	8556                	mv	a0,s5
ffffffffc020542e:	890ff0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205432:	040a2823          	sw	zero,80(s4)
ffffffffc0205436:	0089b023          	sd	s0,0(s3)
ffffffffc020543a:	4501                	li	a0,0
ffffffffc020543c:	70e2                	ld	ra,56(sp)
ffffffffc020543e:	7442                	ld	s0,48(sp)
ffffffffc0205440:	74a2                	ld	s1,40(sp)
ffffffffc0205442:	7902                	ld	s2,32(sp)
ffffffffc0205444:	69e2                	ld	s3,24(sp)
ffffffffc0205446:	6a42                	ld	s4,16(sp)
ffffffffc0205448:	6aa2                	ld	s5,8(sp)
ffffffffc020544a:	6121                	addi	sp,sp,64
ffffffffc020544c:	8082                	ret
ffffffffc020544e:	85aa                	mv	a1,a0
ffffffffc0205450:	6685                	lui	a3,0x1
ffffffffc0205452:	8626                	mv	a2,s1
ffffffffc0205454:	4501                	li	a0,0
ffffffffc0205456:	e95fe0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc020545a:	fd71                	bnez	a0,ffffffffc0205436 <copy_path+0x60>
ffffffffc020545c:	8522                	mv	a0,s0
ffffffffc020545e:	be1fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205462:	5575                	li	a0,-3
ffffffffc0205464:	bfe1                	j	ffffffffc020543c <copy_path+0x66>
ffffffffc0205466:	6685                	lui	a3,0x1
ffffffffc0205468:	8626                	mv	a2,s1
ffffffffc020546a:	85a2                	mv	a1,s0
ffffffffc020546c:	8552                	mv	a0,s4
ffffffffc020546e:	e7dfe0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc0205472:	fd4d                	bnez	a0,ffffffffc020542c <copy_path+0x56>
ffffffffc0205474:	8556                	mv	a0,s5
ffffffffc0205476:	848ff0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020547a:	040a2823          	sw	zero,80(s4)
ffffffffc020547e:	bff9                	j	ffffffffc020545c <copy_path+0x86>
ffffffffc0205480:	5571                	li	a0,-4
ffffffffc0205482:	bf6d                	j	ffffffffc020543c <copy_path+0x66>

ffffffffc0205484 <sysfile_open>:
ffffffffc0205484:	7179                	addi	sp,sp,-48
ffffffffc0205486:	872a                	mv	a4,a0
ffffffffc0205488:	ec26                	sd	s1,24(sp)
ffffffffc020548a:	0028                	addi	a0,sp,8
ffffffffc020548c:	84ae                	mv	s1,a1
ffffffffc020548e:	85ba                	mv	a1,a4
ffffffffc0205490:	f022                	sd	s0,32(sp)
ffffffffc0205492:	f406                	sd	ra,40(sp)
ffffffffc0205494:	f43ff0ef          	jal	ra,ffffffffc02053d6 <copy_path>
ffffffffc0205498:	842a                	mv	s0,a0
ffffffffc020549a:	e909                	bnez	a0,ffffffffc02054ac <sysfile_open+0x28>
ffffffffc020549c:	6522                	ld	a0,8(sp)
ffffffffc020549e:	85a6                	mv	a1,s1
ffffffffc02054a0:	d60ff0ef          	jal	ra,ffffffffc0204a00 <file_open>
ffffffffc02054a4:	842a                	mv	s0,a0
ffffffffc02054a6:	6522                	ld	a0,8(sp)
ffffffffc02054a8:	b97fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02054ac:	70a2                	ld	ra,40(sp)
ffffffffc02054ae:	8522                	mv	a0,s0
ffffffffc02054b0:	7402                	ld	s0,32(sp)
ffffffffc02054b2:	64e2                	ld	s1,24(sp)
ffffffffc02054b4:	6145                	addi	sp,sp,48
ffffffffc02054b6:	8082                	ret

ffffffffc02054b8 <sysfile_close>:
ffffffffc02054b8:	e46ff06f          	j	ffffffffc0204afe <file_close>

ffffffffc02054bc <sysfile_read>:
ffffffffc02054bc:	7159                	addi	sp,sp,-112
ffffffffc02054be:	f0a2                	sd	s0,96(sp)
ffffffffc02054c0:	f486                	sd	ra,104(sp)
ffffffffc02054c2:	eca6                	sd	s1,88(sp)
ffffffffc02054c4:	e8ca                	sd	s2,80(sp)
ffffffffc02054c6:	e4ce                	sd	s3,72(sp)
ffffffffc02054c8:	e0d2                	sd	s4,64(sp)
ffffffffc02054ca:	fc56                	sd	s5,56(sp)
ffffffffc02054cc:	f85a                	sd	s6,48(sp)
ffffffffc02054ce:	f45e                	sd	s7,40(sp)
ffffffffc02054d0:	f062                	sd	s8,32(sp)
ffffffffc02054d2:	ec66                	sd	s9,24(sp)
ffffffffc02054d4:	4401                	li	s0,0
ffffffffc02054d6:	ee19                	bnez	a2,ffffffffc02054f4 <sysfile_read+0x38>
ffffffffc02054d8:	70a6                	ld	ra,104(sp)
ffffffffc02054da:	8522                	mv	a0,s0
ffffffffc02054dc:	7406                	ld	s0,96(sp)
ffffffffc02054de:	64e6                	ld	s1,88(sp)
ffffffffc02054e0:	6946                	ld	s2,80(sp)
ffffffffc02054e2:	69a6                	ld	s3,72(sp)
ffffffffc02054e4:	6a06                	ld	s4,64(sp)
ffffffffc02054e6:	7ae2                	ld	s5,56(sp)
ffffffffc02054e8:	7b42                	ld	s6,48(sp)
ffffffffc02054ea:	7ba2                	ld	s7,40(sp)
ffffffffc02054ec:	7c02                	ld	s8,32(sp)
ffffffffc02054ee:	6ce2                	ld	s9,24(sp)
ffffffffc02054f0:	6165                	addi	sp,sp,112
ffffffffc02054f2:	8082                	ret
ffffffffc02054f4:	00091c97          	auipc	s9,0x91
ffffffffc02054f8:	3ccc8c93          	addi	s9,s9,972 # ffffffffc02968c0 <current>
ffffffffc02054fc:	000cb783          	ld	a5,0(s9)
ffffffffc0205500:	84b2                	mv	s1,a2
ffffffffc0205502:	8b2e                	mv	s6,a1
ffffffffc0205504:	4601                	li	a2,0
ffffffffc0205506:	4585                	li	a1,1
ffffffffc0205508:	0287b903          	ld	s2,40(a5)
ffffffffc020550c:	8aaa                	mv	s5,a0
ffffffffc020550e:	c9eff0ef          	jal	ra,ffffffffc02049ac <file_testfd>
ffffffffc0205512:	c959                	beqz	a0,ffffffffc02055a8 <sysfile_read+0xec>
ffffffffc0205514:	6505                	lui	a0,0x1
ffffffffc0205516:	a79fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020551a:	89aa                	mv	s3,a0
ffffffffc020551c:	c941                	beqz	a0,ffffffffc02055ac <sysfile_read+0xf0>
ffffffffc020551e:	4b81                	li	s7,0
ffffffffc0205520:	6a05                	lui	s4,0x1
ffffffffc0205522:	03890c13          	addi	s8,s2,56
ffffffffc0205526:	0744ec63          	bltu	s1,s4,ffffffffc020559e <sysfile_read+0xe2>
ffffffffc020552a:	e452                	sd	s4,8(sp)
ffffffffc020552c:	6605                	lui	a2,0x1
ffffffffc020552e:	0034                	addi	a3,sp,8
ffffffffc0205530:	85ce                	mv	a1,s3
ffffffffc0205532:	8556                	mv	a0,s5
ffffffffc0205534:	e20ff0ef          	jal	ra,ffffffffc0204b54 <file_read>
ffffffffc0205538:	66a2                	ld	a3,8(sp)
ffffffffc020553a:	842a                	mv	s0,a0
ffffffffc020553c:	ca9d                	beqz	a3,ffffffffc0205572 <sysfile_read+0xb6>
ffffffffc020553e:	00090c63          	beqz	s2,ffffffffc0205556 <sysfile_read+0x9a>
ffffffffc0205542:	8562                	mv	a0,s8
ffffffffc0205544:	f7ffe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205548:	000cb783          	ld	a5,0(s9)
ffffffffc020554c:	cfa1                	beqz	a5,ffffffffc02055a4 <sysfile_read+0xe8>
ffffffffc020554e:	43dc                	lw	a5,4(a5)
ffffffffc0205550:	66a2                	ld	a3,8(sp)
ffffffffc0205552:	04f92823          	sw	a5,80(s2)
ffffffffc0205556:	864e                	mv	a2,s3
ffffffffc0205558:	85da                	mv	a1,s6
ffffffffc020555a:	854a                	mv	a0,s2
ffffffffc020555c:	d5dfe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc0205560:	c50d                	beqz	a0,ffffffffc020558a <sysfile_read+0xce>
ffffffffc0205562:	67a2                	ld	a5,8(sp)
ffffffffc0205564:	04f4e663          	bltu	s1,a5,ffffffffc02055b0 <sysfile_read+0xf4>
ffffffffc0205568:	9b3e                	add	s6,s6,a5
ffffffffc020556a:	8c9d                	sub	s1,s1,a5
ffffffffc020556c:	9bbe                	add	s7,s7,a5
ffffffffc020556e:	02091263          	bnez	s2,ffffffffc0205592 <sysfile_read+0xd6>
ffffffffc0205572:	e401                	bnez	s0,ffffffffc020557a <sysfile_read+0xbe>
ffffffffc0205574:	67a2                	ld	a5,8(sp)
ffffffffc0205576:	c391                	beqz	a5,ffffffffc020557a <sysfile_read+0xbe>
ffffffffc0205578:	f4dd                	bnez	s1,ffffffffc0205526 <sysfile_read+0x6a>
ffffffffc020557a:	854e                	mv	a0,s3
ffffffffc020557c:	ac3fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205580:	f40b8ce3          	beqz	s7,ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc0205584:	000b841b          	sext.w	s0,s7
ffffffffc0205588:	bf81                	j	ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc020558a:	e011                	bnez	s0,ffffffffc020558e <sysfile_read+0xd2>
ffffffffc020558c:	5475                	li	s0,-3
ffffffffc020558e:	fe0906e3          	beqz	s2,ffffffffc020557a <sysfile_read+0xbe>
ffffffffc0205592:	8562                	mv	a0,s8
ffffffffc0205594:	f2bfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205598:	04092823          	sw	zero,80(s2)
ffffffffc020559c:	bfd9                	j	ffffffffc0205572 <sysfile_read+0xb6>
ffffffffc020559e:	e426                	sd	s1,8(sp)
ffffffffc02055a0:	8626                	mv	a2,s1
ffffffffc02055a2:	b771                	j	ffffffffc020552e <sysfile_read+0x72>
ffffffffc02055a4:	66a2                	ld	a3,8(sp)
ffffffffc02055a6:	bf45                	j	ffffffffc0205556 <sysfile_read+0x9a>
ffffffffc02055a8:	5475                	li	s0,-3
ffffffffc02055aa:	b73d                	j	ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc02055ac:	5471                	li	s0,-4
ffffffffc02055ae:	b72d                	j	ffffffffc02054d8 <sysfile_read+0x1c>
ffffffffc02055b0:	00008697          	auipc	a3,0x8
ffffffffc02055b4:	c5068693          	addi	a3,a3,-944 # ffffffffc020d200 <CSWTCH.79+0xc8>
ffffffffc02055b8:	00006617          	auipc	a2,0x6
ffffffffc02055bc:	18060613          	addi	a2,a2,384 # ffffffffc020b738 <commands+0x210>
ffffffffc02055c0:	05500593          	li	a1,85
ffffffffc02055c4:	00008517          	auipc	a0,0x8
ffffffffc02055c8:	c4c50513          	addi	a0,a0,-948 # ffffffffc020d210 <CSWTCH.79+0xd8>
ffffffffc02055cc:	ed3fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02055d0 <sysfile_write>:
ffffffffc02055d0:	7159                	addi	sp,sp,-112
ffffffffc02055d2:	e8ca                	sd	s2,80(sp)
ffffffffc02055d4:	f486                	sd	ra,104(sp)
ffffffffc02055d6:	f0a2                	sd	s0,96(sp)
ffffffffc02055d8:	eca6                	sd	s1,88(sp)
ffffffffc02055da:	e4ce                	sd	s3,72(sp)
ffffffffc02055dc:	e0d2                	sd	s4,64(sp)
ffffffffc02055de:	fc56                	sd	s5,56(sp)
ffffffffc02055e0:	f85a                	sd	s6,48(sp)
ffffffffc02055e2:	f45e                	sd	s7,40(sp)
ffffffffc02055e4:	f062                	sd	s8,32(sp)
ffffffffc02055e6:	ec66                	sd	s9,24(sp)
ffffffffc02055e8:	4901                	li	s2,0
ffffffffc02055ea:	ee19                	bnez	a2,ffffffffc0205608 <sysfile_write+0x38>
ffffffffc02055ec:	70a6                	ld	ra,104(sp)
ffffffffc02055ee:	7406                	ld	s0,96(sp)
ffffffffc02055f0:	64e6                	ld	s1,88(sp)
ffffffffc02055f2:	69a6                	ld	s3,72(sp)
ffffffffc02055f4:	6a06                	ld	s4,64(sp)
ffffffffc02055f6:	7ae2                	ld	s5,56(sp)
ffffffffc02055f8:	7b42                	ld	s6,48(sp)
ffffffffc02055fa:	7ba2                	ld	s7,40(sp)
ffffffffc02055fc:	7c02                	ld	s8,32(sp)
ffffffffc02055fe:	6ce2                	ld	s9,24(sp)
ffffffffc0205600:	854a                	mv	a0,s2
ffffffffc0205602:	6946                	ld	s2,80(sp)
ffffffffc0205604:	6165                	addi	sp,sp,112
ffffffffc0205606:	8082                	ret
ffffffffc0205608:	00091c17          	auipc	s8,0x91
ffffffffc020560c:	2b8c0c13          	addi	s8,s8,696 # ffffffffc02968c0 <current>
ffffffffc0205610:	000c3783          	ld	a5,0(s8)
ffffffffc0205614:	8432                	mv	s0,a2
ffffffffc0205616:	89ae                	mv	s3,a1
ffffffffc0205618:	4605                	li	a2,1
ffffffffc020561a:	4581                	li	a1,0
ffffffffc020561c:	7784                	ld	s1,40(a5)
ffffffffc020561e:	8baa                	mv	s7,a0
ffffffffc0205620:	b8cff0ef          	jal	ra,ffffffffc02049ac <file_testfd>
ffffffffc0205624:	cd59                	beqz	a0,ffffffffc02056c2 <sysfile_write+0xf2>
ffffffffc0205626:	6505                	lui	a0,0x1
ffffffffc0205628:	967fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020562c:	8a2a                	mv	s4,a0
ffffffffc020562e:	cd41                	beqz	a0,ffffffffc02056c6 <sysfile_write+0xf6>
ffffffffc0205630:	4c81                	li	s9,0
ffffffffc0205632:	6a85                	lui	s5,0x1
ffffffffc0205634:	03848b13          	addi	s6,s1,56
ffffffffc0205638:	05546a63          	bltu	s0,s5,ffffffffc020568c <sysfile_write+0xbc>
ffffffffc020563c:	e456                	sd	s5,8(sp)
ffffffffc020563e:	c8a9                	beqz	s1,ffffffffc0205690 <sysfile_write+0xc0>
ffffffffc0205640:	855a                	mv	a0,s6
ffffffffc0205642:	e81fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205646:	000c3783          	ld	a5,0(s8)
ffffffffc020564a:	c399                	beqz	a5,ffffffffc0205650 <sysfile_write+0x80>
ffffffffc020564c:	43dc                	lw	a5,4(a5)
ffffffffc020564e:	c8bc                	sw	a5,80(s1)
ffffffffc0205650:	66a2                	ld	a3,8(sp)
ffffffffc0205652:	4701                	li	a4,0
ffffffffc0205654:	864e                	mv	a2,s3
ffffffffc0205656:	85d2                	mv	a1,s4
ffffffffc0205658:	8526                	mv	a0,s1
ffffffffc020565a:	c2bfe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc020565e:	c139                	beqz	a0,ffffffffc02056a4 <sysfile_write+0xd4>
ffffffffc0205660:	855a                	mv	a0,s6
ffffffffc0205662:	e5dfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205666:	0404a823          	sw	zero,80(s1)
ffffffffc020566a:	6622                	ld	a2,8(sp)
ffffffffc020566c:	0034                	addi	a3,sp,8
ffffffffc020566e:	85d2                	mv	a1,s4
ffffffffc0205670:	855e                	mv	a0,s7
ffffffffc0205672:	dc8ff0ef          	jal	ra,ffffffffc0204c3a <file_write>
ffffffffc0205676:	67a2                	ld	a5,8(sp)
ffffffffc0205678:	892a                	mv	s2,a0
ffffffffc020567a:	ef85                	bnez	a5,ffffffffc02056b2 <sysfile_write+0xe2>
ffffffffc020567c:	8552                	mv	a0,s4
ffffffffc020567e:	9c1fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205682:	f60c85e3          	beqz	s9,ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc0205686:	000c891b          	sext.w	s2,s9
ffffffffc020568a:	b78d                	j	ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc020568c:	e422                	sd	s0,8(sp)
ffffffffc020568e:	f8cd                	bnez	s1,ffffffffc0205640 <sysfile_write+0x70>
ffffffffc0205690:	66a2                	ld	a3,8(sp)
ffffffffc0205692:	4701                	li	a4,0
ffffffffc0205694:	864e                	mv	a2,s3
ffffffffc0205696:	85d2                	mv	a1,s4
ffffffffc0205698:	4501                	li	a0,0
ffffffffc020569a:	bebfe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc020569e:	f571                	bnez	a0,ffffffffc020566a <sysfile_write+0x9a>
ffffffffc02056a0:	5975                	li	s2,-3
ffffffffc02056a2:	bfe9                	j	ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056a4:	855a                	mv	a0,s6
ffffffffc02056a6:	e19fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02056aa:	5975                	li	s2,-3
ffffffffc02056ac:	0404a823          	sw	zero,80(s1)
ffffffffc02056b0:	b7f1                	j	ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056b2:	00f46c63          	bltu	s0,a5,ffffffffc02056ca <sysfile_write+0xfa>
ffffffffc02056b6:	99be                	add	s3,s3,a5
ffffffffc02056b8:	8c1d                	sub	s0,s0,a5
ffffffffc02056ba:	9cbe                	add	s9,s9,a5
ffffffffc02056bc:	f161                	bnez	a0,ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056be:	fc2d                	bnez	s0,ffffffffc0205638 <sysfile_write+0x68>
ffffffffc02056c0:	bf75                	j	ffffffffc020567c <sysfile_write+0xac>
ffffffffc02056c2:	5975                	li	s2,-3
ffffffffc02056c4:	b725                	j	ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc02056c6:	5971                	li	s2,-4
ffffffffc02056c8:	b715                	j	ffffffffc02055ec <sysfile_write+0x1c>
ffffffffc02056ca:	00008697          	auipc	a3,0x8
ffffffffc02056ce:	b3668693          	addi	a3,a3,-1226 # ffffffffc020d200 <CSWTCH.79+0xc8>
ffffffffc02056d2:	00006617          	auipc	a2,0x6
ffffffffc02056d6:	06660613          	addi	a2,a2,102 # ffffffffc020b738 <commands+0x210>
ffffffffc02056da:	08a00593          	li	a1,138
ffffffffc02056de:	00008517          	auipc	a0,0x8
ffffffffc02056e2:	b3250513          	addi	a0,a0,-1230 # ffffffffc020d210 <CSWTCH.79+0xd8>
ffffffffc02056e6:	db9fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02056ea <sysfile_seek>:
ffffffffc02056ea:	e36ff06f          	j	ffffffffc0204d20 <file_seek>

ffffffffc02056ee <sysfile_fstat>:
ffffffffc02056ee:	715d                	addi	sp,sp,-80
ffffffffc02056f0:	f44e                	sd	s3,40(sp)
ffffffffc02056f2:	00091997          	auipc	s3,0x91
ffffffffc02056f6:	1ce98993          	addi	s3,s3,462 # ffffffffc02968c0 <current>
ffffffffc02056fa:	0009b703          	ld	a4,0(s3)
ffffffffc02056fe:	fc26                	sd	s1,56(sp)
ffffffffc0205700:	84ae                	mv	s1,a1
ffffffffc0205702:	858a                	mv	a1,sp
ffffffffc0205704:	e0a2                	sd	s0,64(sp)
ffffffffc0205706:	f84a                	sd	s2,48(sp)
ffffffffc0205708:	e486                	sd	ra,72(sp)
ffffffffc020570a:	02873903          	ld	s2,40(a4)
ffffffffc020570e:	f052                	sd	s4,32(sp)
ffffffffc0205710:	f30ff0ef          	jal	ra,ffffffffc0204e40 <file_fstat>
ffffffffc0205714:	842a                	mv	s0,a0
ffffffffc0205716:	e91d                	bnez	a0,ffffffffc020574c <sysfile_fstat+0x5e>
ffffffffc0205718:	04090363          	beqz	s2,ffffffffc020575e <sysfile_fstat+0x70>
ffffffffc020571c:	03890a13          	addi	s4,s2,56
ffffffffc0205720:	8552                	mv	a0,s4
ffffffffc0205722:	da1fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205726:	0009b783          	ld	a5,0(s3)
ffffffffc020572a:	c3b9                	beqz	a5,ffffffffc0205770 <sysfile_fstat+0x82>
ffffffffc020572c:	43dc                	lw	a5,4(a5)
ffffffffc020572e:	02000693          	li	a3,32
ffffffffc0205732:	860a                	mv	a2,sp
ffffffffc0205734:	04f92823          	sw	a5,80(s2)
ffffffffc0205738:	85a6                	mv	a1,s1
ffffffffc020573a:	854a                	mv	a0,s2
ffffffffc020573c:	b7dfe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc0205740:	c121                	beqz	a0,ffffffffc0205780 <sysfile_fstat+0x92>
ffffffffc0205742:	8552                	mv	a0,s4
ffffffffc0205744:	d7bfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205748:	04092823          	sw	zero,80(s2)
ffffffffc020574c:	60a6                	ld	ra,72(sp)
ffffffffc020574e:	8522                	mv	a0,s0
ffffffffc0205750:	6406                	ld	s0,64(sp)
ffffffffc0205752:	74e2                	ld	s1,56(sp)
ffffffffc0205754:	7942                	ld	s2,48(sp)
ffffffffc0205756:	79a2                	ld	s3,40(sp)
ffffffffc0205758:	7a02                	ld	s4,32(sp)
ffffffffc020575a:	6161                	addi	sp,sp,80
ffffffffc020575c:	8082                	ret
ffffffffc020575e:	02000693          	li	a3,32
ffffffffc0205762:	860a                	mv	a2,sp
ffffffffc0205764:	85a6                	mv	a1,s1
ffffffffc0205766:	b53fe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc020576a:	f16d                	bnez	a0,ffffffffc020574c <sysfile_fstat+0x5e>
ffffffffc020576c:	5475                	li	s0,-3
ffffffffc020576e:	bff9                	j	ffffffffc020574c <sysfile_fstat+0x5e>
ffffffffc0205770:	02000693          	li	a3,32
ffffffffc0205774:	860a                	mv	a2,sp
ffffffffc0205776:	85a6                	mv	a1,s1
ffffffffc0205778:	854a                	mv	a0,s2
ffffffffc020577a:	b3ffe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc020577e:	f171                	bnez	a0,ffffffffc0205742 <sysfile_fstat+0x54>
ffffffffc0205780:	8552                	mv	a0,s4
ffffffffc0205782:	d3dfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205786:	5475                	li	s0,-3
ffffffffc0205788:	04092823          	sw	zero,80(s2)
ffffffffc020578c:	b7c1                	j	ffffffffc020574c <sysfile_fstat+0x5e>

ffffffffc020578e <sysfile_fsync>:
ffffffffc020578e:	f72ff06f          	j	ffffffffc0204f00 <file_fsync>

ffffffffc0205792 <sysfile_getcwd>:
ffffffffc0205792:	715d                	addi	sp,sp,-80
ffffffffc0205794:	f44e                	sd	s3,40(sp)
ffffffffc0205796:	00091997          	auipc	s3,0x91
ffffffffc020579a:	12a98993          	addi	s3,s3,298 # ffffffffc02968c0 <current>
ffffffffc020579e:	0009b783          	ld	a5,0(s3)
ffffffffc02057a2:	f84a                	sd	s2,48(sp)
ffffffffc02057a4:	e486                	sd	ra,72(sp)
ffffffffc02057a6:	e0a2                	sd	s0,64(sp)
ffffffffc02057a8:	fc26                	sd	s1,56(sp)
ffffffffc02057aa:	f052                	sd	s4,32(sp)
ffffffffc02057ac:	0287b903          	ld	s2,40(a5)
ffffffffc02057b0:	cda9                	beqz	a1,ffffffffc020580a <sysfile_getcwd+0x78>
ffffffffc02057b2:	842e                	mv	s0,a1
ffffffffc02057b4:	84aa                	mv	s1,a0
ffffffffc02057b6:	04090363          	beqz	s2,ffffffffc02057fc <sysfile_getcwd+0x6a>
ffffffffc02057ba:	03890a13          	addi	s4,s2,56
ffffffffc02057be:	8552                	mv	a0,s4
ffffffffc02057c0:	d03fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02057c4:	0009b783          	ld	a5,0(s3)
ffffffffc02057c8:	c781                	beqz	a5,ffffffffc02057d0 <sysfile_getcwd+0x3e>
ffffffffc02057ca:	43dc                	lw	a5,4(a5)
ffffffffc02057cc:	04f92823          	sw	a5,80(s2)
ffffffffc02057d0:	4685                	li	a3,1
ffffffffc02057d2:	8622                	mv	a2,s0
ffffffffc02057d4:	85a6                	mv	a1,s1
ffffffffc02057d6:	854a                	mv	a0,s2
ffffffffc02057d8:	a19fe0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc02057dc:	e90d                	bnez	a0,ffffffffc020580e <sysfile_getcwd+0x7c>
ffffffffc02057de:	5475                	li	s0,-3
ffffffffc02057e0:	8552                	mv	a0,s4
ffffffffc02057e2:	cddfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02057e6:	04092823          	sw	zero,80(s2)
ffffffffc02057ea:	60a6                	ld	ra,72(sp)
ffffffffc02057ec:	8522                	mv	a0,s0
ffffffffc02057ee:	6406                	ld	s0,64(sp)
ffffffffc02057f0:	74e2                	ld	s1,56(sp)
ffffffffc02057f2:	7942                	ld	s2,48(sp)
ffffffffc02057f4:	79a2                	ld	s3,40(sp)
ffffffffc02057f6:	7a02                	ld	s4,32(sp)
ffffffffc02057f8:	6161                	addi	sp,sp,80
ffffffffc02057fa:	8082                	ret
ffffffffc02057fc:	862e                	mv	a2,a1
ffffffffc02057fe:	4685                	li	a3,1
ffffffffc0205800:	85aa                	mv	a1,a0
ffffffffc0205802:	4501                	li	a0,0
ffffffffc0205804:	9edfe0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc0205808:	ed09                	bnez	a0,ffffffffc0205822 <sysfile_getcwd+0x90>
ffffffffc020580a:	5475                	li	s0,-3
ffffffffc020580c:	bff9                	j	ffffffffc02057ea <sysfile_getcwd+0x58>
ffffffffc020580e:	8622                	mv	a2,s0
ffffffffc0205810:	4681                	li	a3,0
ffffffffc0205812:	85a6                	mv	a1,s1
ffffffffc0205814:	850a                	mv	a0,sp
ffffffffc0205816:	b2bff0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc020581a:	1b3020ef          	jal	ra,ffffffffc02081cc <vfs_getcwd>
ffffffffc020581e:	842a                	mv	s0,a0
ffffffffc0205820:	b7c1                	j	ffffffffc02057e0 <sysfile_getcwd+0x4e>
ffffffffc0205822:	8622                	mv	a2,s0
ffffffffc0205824:	4681                	li	a3,0
ffffffffc0205826:	85a6                	mv	a1,s1
ffffffffc0205828:	850a                	mv	a0,sp
ffffffffc020582a:	b17ff0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc020582e:	19f020ef          	jal	ra,ffffffffc02081cc <vfs_getcwd>
ffffffffc0205832:	842a                	mv	s0,a0
ffffffffc0205834:	bf5d                	j	ffffffffc02057ea <sysfile_getcwd+0x58>

ffffffffc0205836 <sysfile_getdirentry>:
ffffffffc0205836:	7139                	addi	sp,sp,-64
ffffffffc0205838:	e852                	sd	s4,16(sp)
ffffffffc020583a:	00091a17          	auipc	s4,0x91
ffffffffc020583e:	086a0a13          	addi	s4,s4,134 # ffffffffc02968c0 <current>
ffffffffc0205842:	000a3703          	ld	a4,0(s4)
ffffffffc0205846:	ec4e                	sd	s3,24(sp)
ffffffffc0205848:	89aa                	mv	s3,a0
ffffffffc020584a:	10800513          	li	a0,264
ffffffffc020584e:	f426                	sd	s1,40(sp)
ffffffffc0205850:	f04a                	sd	s2,32(sp)
ffffffffc0205852:	fc06                	sd	ra,56(sp)
ffffffffc0205854:	f822                	sd	s0,48(sp)
ffffffffc0205856:	e456                	sd	s5,8(sp)
ffffffffc0205858:	7704                	ld	s1,40(a4)
ffffffffc020585a:	892e                	mv	s2,a1
ffffffffc020585c:	f32fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205860:	c169                	beqz	a0,ffffffffc0205922 <sysfile_getdirentry+0xec>
ffffffffc0205862:	842a                	mv	s0,a0
ffffffffc0205864:	c8c1                	beqz	s1,ffffffffc02058f4 <sysfile_getdirentry+0xbe>
ffffffffc0205866:	03848a93          	addi	s5,s1,56
ffffffffc020586a:	8556                	mv	a0,s5
ffffffffc020586c:	c57fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205870:	000a3783          	ld	a5,0(s4)
ffffffffc0205874:	c399                	beqz	a5,ffffffffc020587a <sysfile_getdirentry+0x44>
ffffffffc0205876:	43dc                	lw	a5,4(a5)
ffffffffc0205878:	c8bc                	sw	a5,80(s1)
ffffffffc020587a:	4705                	li	a4,1
ffffffffc020587c:	46a1                	li	a3,8
ffffffffc020587e:	864a                	mv	a2,s2
ffffffffc0205880:	85a2                	mv	a1,s0
ffffffffc0205882:	8526                	mv	a0,s1
ffffffffc0205884:	a01fe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc0205888:	e505                	bnez	a0,ffffffffc02058b0 <sysfile_getdirentry+0x7a>
ffffffffc020588a:	8556                	mv	a0,s5
ffffffffc020588c:	c33fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205890:	59f5                	li	s3,-3
ffffffffc0205892:	0404a823          	sw	zero,80(s1)
ffffffffc0205896:	8522                	mv	a0,s0
ffffffffc0205898:	fa6fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020589c:	70e2                	ld	ra,56(sp)
ffffffffc020589e:	7442                	ld	s0,48(sp)
ffffffffc02058a0:	74a2                	ld	s1,40(sp)
ffffffffc02058a2:	7902                	ld	s2,32(sp)
ffffffffc02058a4:	6a42                	ld	s4,16(sp)
ffffffffc02058a6:	6aa2                	ld	s5,8(sp)
ffffffffc02058a8:	854e                	mv	a0,s3
ffffffffc02058aa:	69e2                	ld	s3,24(sp)
ffffffffc02058ac:	6121                	addi	sp,sp,64
ffffffffc02058ae:	8082                	ret
ffffffffc02058b0:	8556                	mv	a0,s5
ffffffffc02058b2:	c0dfe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02058b6:	854e                	mv	a0,s3
ffffffffc02058b8:	85a2                	mv	a1,s0
ffffffffc02058ba:	0404a823          	sw	zero,80(s1)
ffffffffc02058be:	ef0ff0ef          	jal	ra,ffffffffc0204fae <file_getdirentry>
ffffffffc02058c2:	89aa                	mv	s3,a0
ffffffffc02058c4:	f969                	bnez	a0,ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc02058c6:	8556                	mv	a0,s5
ffffffffc02058c8:	bfbfe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02058cc:	000a3783          	ld	a5,0(s4)
ffffffffc02058d0:	c399                	beqz	a5,ffffffffc02058d6 <sysfile_getdirentry+0xa0>
ffffffffc02058d2:	43dc                	lw	a5,4(a5)
ffffffffc02058d4:	c8bc                	sw	a5,80(s1)
ffffffffc02058d6:	10800693          	li	a3,264
ffffffffc02058da:	8622                	mv	a2,s0
ffffffffc02058dc:	85ca                	mv	a1,s2
ffffffffc02058de:	8526                	mv	a0,s1
ffffffffc02058e0:	9d9fe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc02058e4:	e111                	bnez	a0,ffffffffc02058e8 <sysfile_getdirentry+0xb2>
ffffffffc02058e6:	59f5                	li	s3,-3
ffffffffc02058e8:	8556                	mv	a0,s5
ffffffffc02058ea:	bd5fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02058ee:	0404a823          	sw	zero,80(s1)
ffffffffc02058f2:	b755                	j	ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc02058f4:	85aa                	mv	a1,a0
ffffffffc02058f6:	4705                	li	a4,1
ffffffffc02058f8:	46a1                	li	a3,8
ffffffffc02058fa:	864a                	mv	a2,s2
ffffffffc02058fc:	4501                	li	a0,0
ffffffffc02058fe:	987fe0ef          	jal	ra,ffffffffc0204284 <copy_from_user>
ffffffffc0205902:	cd11                	beqz	a0,ffffffffc020591e <sysfile_getdirentry+0xe8>
ffffffffc0205904:	854e                	mv	a0,s3
ffffffffc0205906:	85a2                	mv	a1,s0
ffffffffc0205908:	ea6ff0ef          	jal	ra,ffffffffc0204fae <file_getdirentry>
ffffffffc020590c:	89aa                	mv	s3,a0
ffffffffc020590e:	f541                	bnez	a0,ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc0205910:	10800693          	li	a3,264
ffffffffc0205914:	8622                	mv	a2,s0
ffffffffc0205916:	85ca                	mv	a1,s2
ffffffffc0205918:	9a1fe0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc020591c:	fd2d                	bnez	a0,ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc020591e:	59f5                	li	s3,-3
ffffffffc0205920:	bf9d                	j	ffffffffc0205896 <sysfile_getdirentry+0x60>
ffffffffc0205922:	59f1                	li	s3,-4
ffffffffc0205924:	bfa5                	j	ffffffffc020589c <sysfile_getdirentry+0x66>

ffffffffc0205926 <sysfile_dup>:
ffffffffc0205926:	f6eff06f          	j	ffffffffc0205094 <file_dup>

ffffffffc020592a <kernel_thread_entry>:
ffffffffc020592a:	8526                	mv	a0,s1
ffffffffc020592c:	9402                	jalr	s0
ffffffffc020592e:	5c4000ef          	jal	ra,ffffffffc0205ef2 <do_exit>

ffffffffc0205932 <alloc_proc>:
ffffffffc0205932:	1141                	addi	sp,sp,-16
ffffffffc0205934:	15000513          	li	a0,336
ffffffffc0205938:	e022                	sd	s0,0(sp)
ffffffffc020593a:	e406                	sd	ra,8(sp)
ffffffffc020593c:	e52fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205940:	842a                	mv	s0,a0
ffffffffc0205942:	c141                	beqz	a0,ffffffffc02059c2 <alloc_proc+0x90>
ffffffffc0205944:	57fd                	li	a5,-1
ffffffffc0205946:	1782                	slli	a5,a5,0x20
ffffffffc0205948:	e11c                	sd	a5,0(a0)
ffffffffc020594a:	07000613          	li	a2,112
ffffffffc020594e:	4581                	li	a1,0
ffffffffc0205950:	00052423          	sw	zero,8(a0)
ffffffffc0205954:	00053823          	sd	zero,16(a0)
ffffffffc0205958:	00053c23          	sd	zero,24(a0)
ffffffffc020595c:	02053023          	sd	zero,32(a0)
ffffffffc0205960:	02053423          	sd	zero,40(a0)
ffffffffc0205964:	03050513          	addi	a0,a0,48
ffffffffc0205968:	0e9050ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc020596c:	00091797          	auipc	a5,0x91
ffffffffc0205970:	f247b783          	ld	a5,-220(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205974:	f45c                	sd	a5,168(s0)
ffffffffc0205976:	0a043023          	sd	zero,160(s0)
ffffffffc020597a:	0a042823          	sw	zero,176(s0)
ffffffffc020597e:	463d                	li	a2,15
ffffffffc0205980:	4581                	li	a1,0
ffffffffc0205982:	0b440513          	addi	a0,s0,180
ffffffffc0205986:	0cb050ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc020598a:	11040793          	addi	a5,s0,272
ffffffffc020598e:	0e042623          	sw	zero,236(s0)
ffffffffc0205992:	0e043c23          	sd	zero,248(s0)
ffffffffc0205996:	10043023          	sd	zero,256(s0)
ffffffffc020599a:	0e043823          	sd	zero,240(s0)
ffffffffc020599e:	10043423          	sd	zero,264(s0)
ffffffffc02059a2:	10f43c23          	sd	a5,280(s0)
ffffffffc02059a6:	10f43823          	sd	a5,272(s0)
ffffffffc02059aa:	12042023          	sw	zero,288(s0)
ffffffffc02059ae:	12043423          	sd	zero,296(s0)
ffffffffc02059b2:	12043823          	sd	zero,304(s0)
ffffffffc02059b6:	12043c23          	sd	zero,312(s0)
ffffffffc02059ba:	14043023          	sd	zero,320(s0)
ffffffffc02059be:	14043423          	sd	zero,328(s0)
ffffffffc02059c2:	60a2                	ld	ra,8(sp)
ffffffffc02059c4:	8522                	mv	a0,s0
ffffffffc02059c6:	6402                	ld	s0,0(sp)
ffffffffc02059c8:	0141                	addi	sp,sp,16
ffffffffc02059ca:	8082                	ret

ffffffffc02059cc <forkret>:
ffffffffc02059cc:	00091797          	auipc	a5,0x91
ffffffffc02059d0:	ef47b783          	ld	a5,-268(a5) # ffffffffc02968c0 <current>
ffffffffc02059d4:	73c8                	ld	a0,160(a5)
ffffffffc02059d6:	8d5fb06f          	j	ffffffffc02012aa <forkrets>

ffffffffc02059da <pa2page.part.0>:
ffffffffc02059da:	1141                	addi	sp,sp,-16
ffffffffc02059dc:	00007617          	auipc	a2,0x7
ffffffffc02059e0:	94c60613          	addi	a2,a2,-1716 # ffffffffc020c328 <default_pmm_manager+0x108>
ffffffffc02059e4:	06900593          	li	a1,105
ffffffffc02059e8:	00007517          	auipc	a0,0x7
ffffffffc02059ec:	89850513          	addi	a0,a0,-1896 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc02059f0:	e406                	sd	ra,8(sp)
ffffffffc02059f2:	aadfa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02059f6 <put_pgdir.isra.0>:
ffffffffc02059f6:	1141                	addi	sp,sp,-16
ffffffffc02059f8:	e406                	sd	ra,8(sp)
ffffffffc02059fa:	c02007b7          	lui	a5,0xc0200
ffffffffc02059fe:	02f56e63          	bltu	a0,a5,ffffffffc0205a3a <put_pgdir.isra.0+0x44>
ffffffffc0205a02:	00091697          	auipc	a3,0x91
ffffffffc0205a06:	eb66b683          	ld	a3,-330(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205a0a:	8d15                	sub	a0,a0,a3
ffffffffc0205a0c:	8131                	srli	a0,a0,0xc
ffffffffc0205a0e:	00091797          	auipc	a5,0x91
ffffffffc0205a12:	e927b783          	ld	a5,-366(a5) # ffffffffc02968a0 <npage>
ffffffffc0205a16:	02f57f63          	bgeu	a0,a5,ffffffffc0205a54 <put_pgdir.isra.0+0x5e>
ffffffffc0205a1a:	0000a697          	auipc	a3,0xa
ffffffffc0205a1e:	9f66b683          	ld	a3,-1546(a3) # ffffffffc020f410 <nbase>
ffffffffc0205a22:	60a2                	ld	ra,8(sp)
ffffffffc0205a24:	8d15                	sub	a0,a0,a3
ffffffffc0205a26:	00091797          	auipc	a5,0x91
ffffffffc0205a2a:	e827b783          	ld	a5,-382(a5) # ffffffffc02968a8 <pages>
ffffffffc0205a2e:	051a                	slli	a0,a0,0x6
ffffffffc0205a30:	4585                	li	a1,1
ffffffffc0205a32:	953e                	add	a0,a0,a5
ffffffffc0205a34:	0141                	addi	sp,sp,16
ffffffffc0205a36:	f74fc06f          	j	ffffffffc02021aa <free_pages>
ffffffffc0205a3a:	86aa                	mv	a3,a0
ffffffffc0205a3c:	00007617          	auipc	a2,0x7
ffffffffc0205a40:	8c460613          	addi	a2,a2,-1852 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0205a44:	07700593          	li	a1,119
ffffffffc0205a48:	00007517          	auipc	a0,0x7
ffffffffc0205a4c:	83850513          	addi	a0,a0,-1992 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0205a50:	a4ffa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205a54:	f87ff0ef          	jal	ra,ffffffffc02059da <pa2page.part.0>

ffffffffc0205a58 <proc_run>:
ffffffffc0205a58:	7179                	addi	sp,sp,-48
ffffffffc0205a5a:	ec4a                	sd	s2,24(sp)
ffffffffc0205a5c:	00091917          	auipc	s2,0x91
ffffffffc0205a60:	e6490913          	addi	s2,s2,-412 # ffffffffc02968c0 <current>
ffffffffc0205a64:	f026                	sd	s1,32(sp)
ffffffffc0205a66:	00093483          	ld	s1,0(s2)
ffffffffc0205a6a:	f406                	sd	ra,40(sp)
ffffffffc0205a6c:	e84e                	sd	s3,16(sp)
ffffffffc0205a6e:	02a48a63          	beq	s1,a0,ffffffffc0205aa2 <proc_run+0x4a>
ffffffffc0205a72:	100027f3          	csrr	a5,sstatus
ffffffffc0205a76:	8b89                	andi	a5,a5,2
ffffffffc0205a78:	4981                	li	s3,0
ffffffffc0205a7a:	e3a9                	bnez	a5,ffffffffc0205abc <proc_run+0x64>
ffffffffc0205a7c:	755c                	ld	a5,168(a0)
ffffffffc0205a7e:	577d                	li	a4,-1
ffffffffc0205a80:	177e                	slli	a4,a4,0x3f
ffffffffc0205a82:	83b1                	srli	a5,a5,0xc
ffffffffc0205a84:	00a93023          	sd	a0,0(s2)
ffffffffc0205a88:	8fd9                	or	a5,a5,a4
ffffffffc0205a8a:	18079073          	csrw	satp,a5
ffffffffc0205a8e:	12000073          	sfence.vma
ffffffffc0205a92:	03050593          	addi	a1,a0,48
ffffffffc0205a96:	03048513          	addi	a0,s1,48
ffffffffc0205a9a:	3fc010ef          	jal	ra,ffffffffc0206e96 <switch_to>
ffffffffc0205a9e:	00099863          	bnez	s3,ffffffffc0205aae <proc_run+0x56>
ffffffffc0205aa2:	70a2                	ld	ra,40(sp)
ffffffffc0205aa4:	7482                	ld	s1,32(sp)
ffffffffc0205aa6:	6962                	ld	s2,24(sp)
ffffffffc0205aa8:	69c2                	ld	s3,16(sp)
ffffffffc0205aaa:	6145                	addi	sp,sp,48
ffffffffc0205aac:	8082                	ret
ffffffffc0205aae:	70a2                	ld	ra,40(sp)
ffffffffc0205ab0:	7482                	ld	s1,32(sp)
ffffffffc0205ab2:	6962                	ld	s2,24(sp)
ffffffffc0205ab4:	69c2                	ld	s3,16(sp)
ffffffffc0205ab6:	6145                	addi	sp,sp,48
ffffffffc0205ab8:	9b4fb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205abc:	e42a                	sd	a0,8(sp)
ffffffffc0205abe:	9b4fb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205ac2:	6522                	ld	a0,8(sp)
ffffffffc0205ac4:	4985                	li	s3,1
ffffffffc0205ac6:	bf5d                	j	ffffffffc0205a7c <proc_run+0x24>

ffffffffc0205ac8 <do_fork>:
ffffffffc0205ac8:	7119                	addi	sp,sp,-128
ffffffffc0205aca:	ecce                	sd	s3,88(sp)
ffffffffc0205acc:	00091997          	auipc	s3,0x91
ffffffffc0205ad0:	e0c98993          	addi	s3,s3,-500 # ffffffffc02968d8 <nr_process>
ffffffffc0205ad4:	0009a703          	lw	a4,0(s3)
ffffffffc0205ad8:	fc86                	sd	ra,120(sp)
ffffffffc0205ada:	f8a2                	sd	s0,112(sp)
ffffffffc0205adc:	f4a6                	sd	s1,104(sp)
ffffffffc0205ade:	f0ca                	sd	s2,96(sp)
ffffffffc0205ae0:	e8d2                	sd	s4,80(sp)
ffffffffc0205ae2:	e4d6                	sd	s5,72(sp)
ffffffffc0205ae4:	e0da                	sd	s6,64(sp)
ffffffffc0205ae6:	fc5e                	sd	s7,56(sp)
ffffffffc0205ae8:	f862                	sd	s8,48(sp)
ffffffffc0205aea:	f466                	sd	s9,40(sp)
ffffffffc0205aec:	f06a                	sd	s10,32(sp)
ffffffffc0205aee:	ec6e                	sd	s11,24(sp)
ffffffffc0205af0:	6785                	lui	a5,0x1
ffffffffc0205af2:	32f75163          	bge	a4,a5,ffffffffc0205e14 <do_fork+0x34c>
ffffffffc0205af6:	892a                	mv	s2,a0
ffffffffc0205af8:	8a2e                	mv	s4,a1
ffffffffc0205afa:	8432                	mv	s0,a2
ffffffffc0205afc:	e37ff0ef          	jal	ra,ffffffffc0205932 <alloc_proc>
ffffffffc0205b00:	84aa                	mv	s1,a0
ffffffffc0205b02:	26050963          	beqz	a0,ffffffffc0205d74 <do_fork+0x2ac>
ffffffffc0205b06:	00091d97          	auipc	s11,0x91
ffffffffc0205b0a:	dbad8d93          	addi	s11,s11,-582 # ffffffffc02968c0 <current>
ffffffffc0205b0e:	000db783          	ld	a5,0(s11)
ffffffffc0205b12:	4509                	li	a0,2
ffffffffc0205b14:	f09c                	sd	a5,32(s1)
ffffffffc0205b16:	0e07a623          	sw	zero,236(a5) # 10ec <_binary_bin_swap_img_size-0x6c14>
ffffffffc0205b1a:	e52fc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205b1e:	24050863          	beqz	a0,ffffffffc0205d6e <do_fork+0x2a6>
ffffffffc0205b22:	00091b97          	auipc	s7,0x91
ffffffffc0205b26:	d86b8b93          	addi	s7,s7,-634 # ffffffffc02968a8 <pages>
ffffffffc0205b2a:	000bb683          	ld	a3,0(s7)
ffffffffc0205b2e:	00091b17          	auipc	s6,0x91
ffffffffc0205b32:	d72b0b13          	addi	s6,s6,-654 # ffffffffc02968a0 <npage>
ffffffffc0205b36:	0000aa97          	auipc	s5,0xa
ffffffffc0205b3a:	8daaba83          	ld	s5,-1830(s5) # ffffffffc020f410 <nbase>
ffffffffc0205b3e:	40d506b3          	sub	a3,a0,a3
ffffffffc0205b42:	8699                	srai	a3,a3,0x6
ffffffffc0205b44:	5cfd                	li	s9,-1
ffffffffc0205b46:	000b3783          	ld	a5,0(s6)
ffffffffc0205b4a:	96d6                	add	a3,a3,s5
ffffffffc0205b4c:	00ccdc93          	srli	s9,s9,0xc
ffffffffc0205b50:	0196f733          	and	a4,a3,s9
ffffffffc0205b54:	06b2                	slli	a3,a3,0xc
ffffffffc0205b56:	32f77a63          	bgeu	a4,a5,ffffffffc0205e8a <do_fork+0x3c2>
ffffffffc0205b5a:	000db883          	ld	a7,0(s11)
ffffffffc0205b5e:	00091c17          	auipc	s8,0x91
ffffffffc0205b62:	d5ac0c13          	addi	s8,s8,-678 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205b66:	000c3703          	ld	a4,0(s8)
ffffffffc0205b6a:	0288bd03          	ld	s10,40(a7) # 1028 <_binary_bin_swap_img_size-0x6cd8>
ffffffffc0205b6e:	96ba                	add	a3,a3,a4
ffffffffc0205b70:	e894                	sd	a3,16(s1)
ffffffffc0205b72:	020d0a63          	beqz	s10,ffffffffc0205ba6 <do_fork+0xde>
ffffffffc0205b76:	10097713          	andi	a4,s2,256
ffffffffc0205b7a:	1e070f63          	beqz	a4,ffffffffc0205d78 <do_fork+0x2b0>
ffffffffc0205b7e:	030d2683          	lw	a3,48(s10) # 200030 <_binary_bin_sfs_img_size+0x18ad30>
ffffffffc0205b82:	018d3703          	ld	a4,24(s10)
ffffffffc0205b86:	c0200637          	lui	a2,0xc0200
ffffffffc0205b8a:	2685                	addiw	a3,a3,1
ffffffffc0205b8c:	02dd2823          	sw	a3,48(s10)
ffffffffc0205b90:	03a4b423          	sd	s10,40(s1)
ffffffffc0205b94:	2ac76063          	bltu	a4,a2,ffffffffc0205e34 <do_fork+0x36c>
ffffffffc0205b98:	000c3783          	ld	a5,0(s8)
ffffffffc0205b9c:	000db883          	ld	a7,0(s11)
ffffffffc0205ba0:	6894                	ld	a3,16(s1)
ffffffffc0205ba2:	8f1d                	sub	a4,a4,a5
ffffffffc0205ba4:	f4d8                	sd	a4,168(s1)
ffffffffc0205ba6:	6789                	lui	a5,0x2
ffffffffc0205ba8:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205bac:	96be                	add	a3,a3,a5
ffffffffc0205bae:	f0d4                	sd	a3,160(s1)
ffffffffc0205bb0:	87b6                	mv	a5,a3
ffffffffc0205bb2:	12040813          	addi	a6,s0,288
ffffffffc0205bb6:	6008                	ld	a0,0(s0)
ffffffffc0205bb8:	640c                	ld	a1,8(s0)
ffffffffc0205bba:	6810                	ld	a2,16(s0)
ffffffffc0205bbc:	6c18                	ld	a4,24(s0)
ffffffffc0205bbe:	e388                	sd	a0,0(a5)
ffffffffc0205bc0:	e78c                	sd	a1,8(a5)
ffffffffc0205bc2:	eb90                	sd	a2,16(a5)
ffffffffc0205bc4:	ef98                	sd	a4,24(a5)
ffffffffc0205bc6:	02040413          	addi	s0,s0,32
ffffffffc0205bca:	02078793          	addi	a5,a5,32
ffffffffc0205bce:	ff0414e3          	bne	s0,a6,ffffffffc0205bb6 <do_fork+0xee>
ffffffffc0205bd2:	0406b823          	sd	zero,80(a3)
ffffffffc0205bd6:	140a0663          	beqz	s4,ffffffffc0205d22 <do_fork+0x25a>
ffffffffc0205bda:	1488b403          	ld	s0,328(a7)
ffffffffc0205bde:	00000797          	auipc	a5,0x0
ffffffffc0205be2:	dee78793          	addi	a5,a5,-530 # ffffffffc02059cc <forkret>
ffffffffc0205be6:	0146b823          	sd	s4,16(a3)
ffffffffc0205bea:	f89c                	sd	a5,48(s1)
ffffffffc0205bec:	fc94                	sd	a3,56(s1)
ffffffffc0205bee:	26040e63          	beqz	s0,ffffffffc0205e6a <do_fork+0x3a2>
ffffffffc0205bf2:	00b95913          	srli	s2,s2,0xb
ffffffffc0205bf6:	00197913          	andi	s2,s2,1
ffffffffc0205bfa:	12090663          	beqz	s2,ffffffffc0205d26 <do_fork+0x25e>
ffffffffc0205bfe:	4818                	lw	a4,16(s0)
ffffffffc0205c00:	0008b817          	auipc	a6,0x8b
ffffffffc0205c04:	45880813          	addi	a6,a6,1112 # ffffffffc0291058 <last_pid.1>
ffffffffc0205c08:	00082783          	lw	a5,0(a6)
ffffffffc0205c0c:	2705                	addiw	a4,a4,1
ffffffffc0205c0e:	c818                	sw	a4,16(s0)
ffffffffc0205c10:	0017851b          	addiw	a0,a5,1
ffffffffc0205c14:	1484b423          	sd	s0,328(s1)
ffffffffc0205c18:	00a82023          	sw	a0,0(a6)
ffffffffc0205c1c:	6789                	lui	a5,0x2
ffffffffc0205c1e:	08f55b63          	bge	a0,a5,ffffffffc0205cb4 <do_fork+0x1ec>
ffffffffc0205c22:	0008b317          	auipc	t1,0x8b
ffffffffc0205c26:	43a30313          	addi	t1,t1,1082 # ffffffffc029105c <next_safe.0>
ffffffffc0205c2a:	00032783          	lw	a5,0(t1)
ffffffffc0205c2e:	00090417          	auipc	s0,0x90
ffffffffc0205c32:	b9240413          	addi	s0,s0,-1134 # ffffffffc02957c0 <proc_list>
ffffffffc0205c36:	08f55763          	bge	a0,a5,ffffffffc0205cc4 <do_fork+0x1fc>
ffffffffc0205c3a:	c0c8                	sw	a0,4(s1)
ffffffffc0205c3c:	45a9                	li	a1,10
ffffffffc0205c3e:	2501                	sext.w	a0,a0
ffffffffc0205c40:	0dc050ef          	jal	ra,ffffffffc020ad1c <hash32>
ffffffffc0205c44:	02051793          	slli	a5,a0,0x20
ffffffffc0205c48:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205c4c:	0008c797          	auipc	a5,0x8c
ffffffffc0205c50:	b7478793          	addi	a5,a5,-1164 # ffffffffc02917c0 <hash_list>
ffffffffc0205c54:	953e                	add	a0,a0,a5
ffffffffc0205c56:	650c                	ld	a1,8(a0)
ffffffffc0205c58:	7094                	ld	a3,32(s1)
ffffffffc0205c5a:	0d848793          	addi	a5,s1,216
ffffffffc0205c5e:	e19c                	sd	a5,0(a1)
ffffffffc0205c60:	6410                	ld	a2,8(s0)
ffffffffc0205c62:	e51c                	sd	a5,8(a0)
ffffffffc0205c64:	7af8                	ld	a4,240(a3)
ffffffffc0205c66:	0c848793          	addi	a5,s1,200
ffffffffc0205c6a:	f0ec                	sd	a1,224(s1)
ffffffffc0205c6c:	ece8                	sd	a0,216(s1)
ffffffffc0205c6e:	e21c                	sd	a5,0(a2)
ffffffffc0205c70:	e41c                	sd	a5,8(s0)
ffffffffc0205c72:	e8f0                	sd	a2,208(s1)
ffffffffc0205c74:	e4e0                	sd	s0,200(s1)
ffffffffc0205c76:	0e04bc23          	sd	zero,248(s1)
ffffffffc0205c7a:	10e4b023          	sd	a4,256(s1)
ffffffffc0205c7e:	c311                	beqz	a4,ffffffffc0205c82 <do_fork+0x1ba>
ffffffffc0205c80:	ff64                	sd	s1,248(a4)
ffffffffc0205c82:	0009a783          	lw	a5,0(s3)
ffffffffc0205c86:	8526                	mv	a0,s1
ffffffffc0205c88:	fae4                	sd	s1,240(a3)
ffffffffc0205c8a:	2785                	addiw	a5,a5,1
ffffffffc0205c8c:	00f9a023          	sw	a5,0(s3)
ffffffffc0205c90:	3aa010ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc0205c94:	40c8                	lw	a0,4(s1)
ffffffffc0205c96:	70e6                	ld	ra,120(sp)
ffffffffc0205c98:	7446                	ld	s0,112(sp)
ffffffffc0205c9a:	74a6                	ld	s1,104(sp)
ffffffffc0205c9c:	7906                	ld	s2,96(sp)
ffffffffc0205c9e:	69e6                	ld	s3,88(sp)
ffffffffc0205ca0:	6a46                	ld	s4,80(sp)
ffffffffc0205ca2:	6aa6                	ld	s5,72(sp)
ffffffffc0205ca4:	6b06                	ld	s6,64(sp)
ffffffffc0205ca6:	7be2                	ld	s7,56(sp)
ffffffffc0205ca8:	7c42                	ld	s8,48(sp)
ffffffffc0205caa:	7ca2                	ld	s9,40(sp)
ffffffffc0205cac:	7d02                	ld	s10,32(sp)
ffffffffc0205cae:	6de2                	ld	s11,24(sp)
ffffffffc0205cb0:	6109                	addi	sp,sp,128
ffffffffc0205cb2:	8082                	ret
ffffffffc0205cb4:	4785                	li	a5,1
ffffffffc0205cb6:	00f82023          	sw	a5,0(a6)
ffffffffc0205cba:	4505                	li	a0,1
ffffffffc0205cbc:	0008b317          	auipc	t1,0x8b
ffffffffc0205cc0:	3a030313          	addi	t1,t1,928 # ffffffffc029105c <next_safe.0>
ffffffffc0205cc4:	00090417          	auipc	s0,0x90
ffffffffc0205cc8:	afc40413          	addi	s0,s0,-1284 # ffffffffc02957c0 <proc_list>
ffffffffc0205ccc:	00843e03          	ld	t3,8(s0)
ffffffffc0205cd0:	6789                	lui	a5,0x2
ffffffffc0205cd2:	00f32023          	sw	a5,0(t1)
ffffffffc0205cd6:	86aa                	mv	a3,a0
ffffffffc0205cd8:	4581                	li	a1,0
ffffffffc0205cda:	6e89                	lui	t4,0x2
ffffffffc0205cdc:	128e0763          	beq	t3,s0,ffffffffc0205e0a <do_fork+0x342>
ffffffffc0205ce0:	88ae                	mv	a7,a1
ffffffffc0205ce2:	87f2                	mv	a5,t3
ffffffffc0205ce4:	6609                	lui	a2,0x2
ffffffffc0205ce6:	a811                	j	ffffffffc0205cfa <do_fork+0x232>
ffffffffc0205ce8:	00e6d663          	bge	a3,a4,ffffffffc0205cf4 <do_fork+0x22c>
ffffffffc0205cec:	00c75463          	bge	a4,a2,ffffffffc0205cf4 <do_fork+0x22c>
ffffffffc0205cf0:	863a                	mv	a2,a4
ffffffffc0205cf2:	4885                	li	a7,1
ffffffffc0205cf4:	679c                	ld	a5,8(a5)
ffffffffc0205cf6:	00878d63          	beq	a5,s0,ffffffffc0205d10 <do_fork+0x248>
ffffffffc0205cfa:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205cfe:	fed715e3          	bne	a4,a3,ffffffffc0205ce8 <do_fork+0x220>
ffffffffc0205d02:	2685                	addiw	a3,a3,1
ffffffffc0205d04:	0ec6da63          	bge	a3,a2,ffffffffc0205df8 <do_fork+0x330>
ffffffffc0205d08:	679c                	ld	a5,8(a5)
ffffffffc0205d0a:	4585                	li	a1,1
ffffffffc0205d0c:	fe8797e3          	bne	a5,s0,ffffffffc0205cfa <do_fork+0x232>
ffffffffc0205d10:	c581                	beqz	a1,ffffffffc0205d18 <do_fork+0x250>
ffffffffc0205d12:	00d82023          	sw	a3,0(a6)
ffffffffc0205d16:	8536                	mv	a0,a3
ffffffffc0205d18:	f20881e3          	beqz	a7,ffffffffc0205c3a <do_fork+0x172>
ffffffffc0205d1c:	00c32023          	sw	a2,0(t1)
ffffffffc0205d20:	bf29                	j	ffffffffc0205c3a <do_fork+0x172>
ffffffffc0205d22:	8a36                	mv	s4,a3
ffffffffc0205d24:	bd5d                	j	ffffffffc0205bda <do_fork+0x112>
ffffffffc0205d26:	c06ff0ef          	jal	ra,ffffffffc020512c <files_create>
ffffffffc0205d2a:	892a                	mv	s2,a0
ffffffffc0205d2c:	c911                	beqz	a0,ffffffffc0205d40 <do_fork+0x278>
ffffffffc0205d2e:	85a2                	mv	a1,s0
ffffffffc0205d30:	d34ff0ef          	jal	ra,ffffffffc0205264 <dup_files>
ffffffffc0205d34:	844a                	mv	s0,s2
ffffffffc0205d36:	ec0504e3          	beqz	a0,ffffffffc0205bfe <do_fork+0x136>
ffffffffc0205d3a:	854a                	mv	a0,s2
ffffffffc0205d3c:	c26ff0ef          	jal	ra,ffffffffc0205162 <files_destroy>
ffffffffc0205d40:	6894                	ld	a3,16(s1)
ffffffffc0205d42:	c02007b7          	lui	a5,0xc0200
ffffffffc0205d46:	10f6e463          	bltu	a3,a5,ffffffffc0205e4e <do_fork+0x386>
ffffffffc0205d4a:	000c3783          	ld	a5,0(s8)
ffffffffc0205d4e:	000b3703          	ld	a4,0(s6)
ffffffffc0205d52:	40f687b3          	sub	a5,a3,a5
ffffffffc0205d56:	83b1                	srli	a5,a5,0xc
ffffffffc0205d58:	10e7f763          	bgeu	a5,a4,ffffffffc0205e66 <do_fork+0x39e>
ffffffffc0205d5c:	000bb503          	ld	a0,0(s7)
ffffffffc0205d60:	415787b3          	sub	a5,a5,s5
ffffffffc0205d64:	079a                	slli	a5,a5,0x6
ffffffffc0205d66:	4589                	li	a1,2
ffffffffc0205d68:	953e                	add	a0,a0,a5
ffffffffc0205d6a:	c40fc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205d6e:	8526                	mv	a0,s1
ffffffffc0205d70:	acefc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205d74:	5571                	li	a0,-4
ffffffffc0205d76:	b705                	j	ffffffffc0205c96 <do_fork+0x1ce>
ffffffffc0205d78:	deffd0ef          	jal	ra,ffffffffc0203b66 <mm_create>
ffffffffc0205d7c:	e02a                	sd	a0,0(sp)
ffffffffc0205d7e:	d169                	beqz	a0,ffffffffc0205d40 <do_fork+0x278>
ffffffffc0205d80:	4505                	li	a0,1
ffffffffc0205d82:	beafc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205d86:	cd35                	beqz	a0,ffffffffc0205e02 <do_fork+0x33a>
ffffffffc0205d88:	000bb683          	ld	a3,0(s7)
ffffffffc0205d8c:	000b3703          	ld	a4,0(s6)
ffffffffc0205d90:	40d506b3          	sub	a3,a0,a3
ffffffffc0205d94:	8699                	srai	a3,a3,0x6
ffffffffc0205d96:	96d6                	add	a3,a3,s5
ffffffffc0205d98:	0196fcb3          	and	s9,a3,s9
ffffffffc0205d9c:	06b2                	slli	a3,a3,0xc
ffffffffc0205d9e:	0eecf663          	bgeu	s9,a4,ffffffffc0205e8a <do_fork+0x3c2>
ffffffffc0205da2:	000c3c83          	ld	s9,0(s8)
ffffffffc0205da6:	6605                	lui	a2,0x1
ffffffffc0205da8:	00091597          	auipc	a1,0x91
ffffffffc0205dac:	af05b583          	ld	a1,-1296(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205db0:	9cb6                	add	s9,s9,a3
ffffffffc0205db2:	8566                	mv	a0,s9
ffffffffc0205db4:	4ee050ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0205db8:	6782                	ld	a5,0(sp)
ffffffffc0205dba:	038d0713          	addi	a4,s10,56
ffffffffc0205dbe:	853a                	mv	a0,a4
ffffffffc0205dc0:	0197bc23          	sd	s9,24(a5) # ffffffffc0200018 <kern_entry+0x18>
ffffffffc0205dc4:	e43a                	sd	a4,8(sp)
ffffffffc0205dc6:	efcfe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0205dca:	000db683          	ld	a3,0(s11)
ffffffffc0205dce:	6722                	ld	a4,8(sp)
ffffffffc0205dd0:	c681                	beqz	a3,ffffffffc0205dd8 <do_fork+0x310>
ffffffffc0205dd2:	42d4                	lw	a3,4(a3)
ffffffffc0205dd4:	04dd2823          	sw	a3,80(s10)
ffffffffc0205dd8:	6502                	ld	a0,0(sp)
ffffffffc0205dda:	85ea                	mv	a1,s10
ffffffffc0205ddc:	e43a                	sd	a4,8(sp)
ffffffffc0205dde:	fd9fd0ef          	jal	ra,ffffffffc0203db6 <dup_mmap>
ffffffffc0205de2:	6722                	ld	a4,8(sp)
ffffffffc0205de4:	8caa                	mv	s9,a0
ffffffffc0205de6:	853a                	mv	a0,a4
ffffffffc0205de8:	ed6fe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0205dec:	040d2823          	sw	zero,80(s10)
ffffffffc0205df0:	020c9763          	bnez	s9,ffffffffc0205e1e <do_fork+0x356>
ffffffffc0205df4:	6d02                	ld	s10,0(sp)
ffffffffc0205df6:	b361                	j	ffffffffc0205b7e <do_fork+0xb6>
ffffffffc0205df8:	01d6c363          	blt	a3,t4,ffffffffc0205dfe <do_fork+0x336>
ffffffffc0205dfc:	4685                	li	a3,1
ffffffffc0205dfe:	4585                	li	a1,1
ffffffffc0205e00:	bdf1                	j	ffffffffc0205cdc <do_fork+0x214>
ffffffffc0205e02:	6502                	ld	a0,0(sp)
ffffffffc0205e04:	eb1fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0205e08:	bf25                	j	ffffffffc0205d40 <do_fork+0x278>
ffffffffc0205e0a:	c599                	beqz	a1,ffffffffc0205e18 <do_fork+0x350>
ffffffffc0205e0c:	00d82023          	sw	a3,0(a6)
ffffffffc0205e10:	8536                	mv	a0,a3
ffffffffc0205e12:	b525                	j	ffffffffc0205c3a <do_fork+0x172>
ffffffffc0205e14:	556d                	li	a0,-5
ffffffffc0205e16:	b541                	j	ffffffffc0205c96 <do_fork+0x1ce>
ffffffffc0205e18:	00082503          	lw	a0,0(a6)
ffffffffc0205e1c:	bd39                	j	ffffffffc0205c3a <do_fork+0x172>
ffffffffc0205e1e:	6402                	ld	s0,0(sp)
ffffffffc0205e20:	8522                	mv	a0,s0
ffffffffc0205e22:	82efe0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc0205e26:	6c08                	ld	a0,24(s0)
ffffffffc0205e28:	bcfff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0205e2c:	8522                	mv	a0,s0
ffffffffc0205e2e:	e87fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0205e32:	b739                	j	ffffffffc0205d40 <do_fork+0x278>
ffffffffc0205e34:	86ba                	mv	a3,a4
ffffffffc0205e36:	00006617          	auipc	a2,0x6
ffffffffc0205e3a:	4ca60613          	addi	a2,a2,1226 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0205e3e:	1b700593          	li	a1,439
ffffffffc0205e42:	00007517          	auipc	a0,0x7
ffffffffc0205e46:	3e650513          	addi	a0,a0,998 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0205e4a:	e54fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205e4e:	00006617          	auipc	a2,0x6
ffffffffc0205e52:	4b260613          	addi	a2,a2,1202 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0205e56:	07700593          	li	a1,119
ffffffffc0205e5a:	00006517          	auipc	a0,0x6
ffffffffc0205e5e:	42650513          	addi	a0,a0,1062 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0205e62:	e3cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205e66:	b75ff0ef          	jal	ra,ffffffffc02059da <pa2page.part.0>
ffffffffc0205e6a:	00007697          	auipc	a3,0x7
ffffffffc0205e6e:	3d668693          	addi	a3,a3,982 # ffffffffc020d240 <CSWTCH.79+0x108>
ffffffffc0205e72:	00006617          	auipc	a2,0x6
ffffffffc0205e76:	8c660613          	addi	a2,a2,-1850 # ffffffffc020b738 <commands+0x210>
ffffffffc0205e7a:	1d700593          	li	a1,471
ffffffffc0205e7e:	00007517          	auipc	a0,0x7
ffffffffc0205e82:	3aa50513          	addi	a0,a0,938 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0205e86:	e18fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205e8a:	00006617          	auipc	a2,0x6
ffffffffc0205e8e:	3ce60613          	addi	a2,a2,974 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc0205e92:	07100593          	li	a1,113
ffffffffc0205e96:	00006517          	auipc	a0,0x6
ffffffffc0205e9a:	3ea50513          	addi	a0,a0,1002 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0205e9e:	e00fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205ea2 <kernel_thread>:
ffffffffc0205ea2:	7129                	addi	sp,sp,-320
ffffffffc0205ea4:	fa22                	sd	s0,304(sp)
ffffffffc0205ea6:	f626                	sd	s1,296(sp)
ffffffffc0205ea8:	f24a                	sd	s2,288(sp)
ffffffffc0205eaa:	84ae                	mv	s1,a1
ffffffffc0205eac:	892a                	mv	s2,a0
ffffffffc0205eae:	8432                	mv	s0,a2
ffffffffc0205eb0:	4581                	li	a1,0
ffffffffc0205eb2:	12000613          	li	a2,288
ffffffffc0205eb6:	850a                	mv	a0,sp
ffffffffc0205eb8:	fe06                	sd	ra,312(sp)
ffffffffc0205eba:	396050ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0205ebe:	e0ca                	sd	s2,64(sp)
ffffffffc0205ec0:	e4a6                	sd	s1,72(sp)
ffffffffc0205ec2:	100027f3          	csrr	a5,sstatus
ffffffffc0205ec6:	edd7f793          	andi	a5,a5,-291
ffffffffc0205eca:	1207e793          	ori	a5,a5,288
ffffffffc0205ece:	e23e                	sd	a5,256(sp)
ffffffffc0205ed0:	860a                	mv	a2,sp
ffffffffc0205ed2:	10046513          	ori	a0,s0,256
ffffffffc0205ed6:	00000797          	auipc	a5,0x0
ffffffffc0205eda:	a5478793          	addi	a5,a5,-1452 # ffffffffc020592a <kernel_thread_entry>
ffffffffc0205ede:	4581                	li	a1,0
ffffffffc0205ee0:	e63e                	sd	a5,264(sp)
ffffffffc0205ee2:	be7ff0ef          	jal	ra,ffffffffc0205ac8 <do_fork>
ffffffffc0205ee6:	70f2                	ld	ra,312(sp)
ffffffffc0205ee8:	7452                	ld	s0,304(sp)
ffffffffc0205eea:	74b2                	ld	s1,296(sp)
ffffffffc0205eec:	7912                	ld	s2,288(sp)
ffffffffc0205eee:	6131                	addi	sp,sp,320
ffffffffc0205ef0:	8082                	ret

ffffffffc0205ef2 <do_exit>:
ffffffffc0205ef2:	7179                	addi	sp,sp,-48
ffffffffc0205ef4:	f022                	sd	s0,32(sp)
ffffffffc0205ef6:	00091417          	auipc	s0,0x91
ffffffffc0205efa:	9ca40413          	addi	s0,s0,-1590 # ffffffffc02968c0 <current>
ffffffffc0205efe:	601c                	ld	a5,0(s0)
ffffffffc0205f00:	f406                	sd	ra,40(sp)
ffffffffc0205f02:	ec26                	sd	s1,24(sp)
ffffffffc0205f04:	e84a                	sd	s2,16(sp)
ffffffffc0205f06:	e44e                	sd	s3,8(sp)
ffffffffc0205f08:	e052                	sd	s4,0(sp)
ffffffffc0205f0a:	00091717          	auipc	a4,0x91
ffffffffc0205f0e:	9be73703          	ld	a4,-1602(a4) # ffffffffc02968c8 <idleproc>
ffffffffc0205f12:	0ee78763          	beq	a5,a4,ffffffffc0206000 <do_exit+0x10e>
ffffffffc0205f16:	00091497          	auipc	s1,0x91
ffffffffc0205f1a:	9ba48493          	addi	s1,s1,-1606 # ffffffffc02968d0 <initproc>
ffffffffc0205f1e:	6098                	ld	a4,0(s1)
ffffffffc0205f20:	10e78763          	beq	a5,a4,ffffffffc020602e <do_exit+0x13c>
ffffffffc0205f24:	0287b983          	ld	s3,40(a5)
ffffffffc0205f28:	892a                	mv	s2,a0
ffffffffc0205f2a:	02098e63          	beqz	s3,ffffffffc0205f66 <do_exit+0x74>
ffffffffc0205f2e:	00091797          	auipc	a5,0x91
ffffffffc0205f32:	9627b783          	ld	a5,-1694(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205f36:	577d                	li	a4,-1
ffffffffc0205f38:	177e                	slli	a4,a4,0x3f
ffffffffc0205f3a:	83b1                	srli	a5,a5,0xc
ffffffffc0205f3c:	8fd9                	or	a5,a5,a4
ffffffffc0205f3e:	18079073          	csrw	satp,a5
ffffffffc0205f42:	0309a783          	lw	a5,48(s3)
ffffffffc0205f46:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205f4a:	02e9a823          	sw	a4,48(s3)
ffffffffc0205f4e:	c769                	beqz	a4,ffffffffc0206018 <do_exit+0x126>
ffffffffc0205f50:	601c                	ld	a5,0(s0)
ffffffffc0205f52:	1487b503          	ld	a0,328(a5)
ffffffffc0205f56:	0207b423          	sd	zero,40(a5)
ffffffffc0205f5a:	c511                	beqz	a0,ffffffffc0205f66 <do_exit+0x74>
ffffffffc0205f5c:	491c                	lw	a5,16(a0)
ffffffffc0205f5e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205f62:	c918                	sw	a4,16(a0)
ffffffffc0205f64:	cb59                	beqz	a4,ffffffffc0205ffa <do_exit+0x108>
ffffffffc0205f66:	601c                	ld	a5,0(s0)
ffffffffc0205f68:	470d                	li	a4,3
ffffffffc0205f6a:	c398                	sw	a4,0(a5)
ffffffffc0205f6c:	0f27a423          	sw	s2,232(a5)
ffffffffc0205f70:	100027f3          	csrr	a5,sstatus
ffffffffc0205f74:	8b89                	andi	a5,a5,2
ffffffffc0205f76:	4a01                	li	s4,0
ffffffffc0205f78:	e7f9                	bnez	a5,ffffffffc0206046 <do_exit+0x154>
ffffffffc0205f7a:	6018                	ld	a4,0(s0)
ffffffffc0205f7c:	800007b7          	lui	a5,0x80000
ffffffffc0205f80:	0785                	addi	a5,a5,1
ffffffffc0205f82:	7308                	ld	a0,32(a4)
ffffffffc0205f84:	0ec52703          	lw	a4,236(a0)
ffffffffc0205f88:	0cf70363          	beq	a4,a5,ffffffffc020604e <do_exit+0x15c>
ffffffffc0205f8c:	6018                	ld	a4,0(s0)
ffffffffc0205f8e:	7b7c                	ld	a5,240(a4)
ffffffffc0205f90:	c3a1                	beqz	a5,ffffffffc0205fd0 <do_exit+0xde>
ffffffffc0205f92:	800009b7          	lui	s3,0x80000
ffffffffc0205f96:	490d                	li	s2,3
ffffffffc0205f98:	0985                	addi	s3,s3,1
ffffffffc0205f9a:	a021                	j	ffffffffc0205fa2 <do_exit+0xb0>
ffffffffc0205f9c:	6018                	ld	a4,0(s0)
ffffffffc0205f9e:	7b7c                	ld	a5,240(a4)
ffffffffc0205fa0:	cb85                	beqz	a5,ffffffffc0205fd0 <do_exit+0xde>
ffffffffc0205fa2:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc0205fa6:	6088                	ld	a0,0(s1)
ffffffffc0205fa8:	fb74                	sd	a3,240(a4)
ffffffffc0205faa:	7978                	ld	a4,240(a0)
ffffffffc0205fac:	0e07bc23          	sd	zero,248(a5)
ffffffffc0205fb0:	10e7b023          	sd	a4,256(a5)
ffffffffc0205fb4:	c311                	beqz	a4,ffffffffc0205fb8 <do_exit+0xc6>
ffffffffc0205fb6:	ff7c                	sd	a5,248(a4)
ffffffffc0205fb8:	4398                	lw	a4,0(a5)
ffffffffc0205fba:	f388                	sd	a0,32(a5)
ffffffffc0205fbc:	f97c                	sd	a5,240(a0)
ffffffffc0205fbe:	fd271fe3          	bne	a4,s2,ffffffffc0205f9c <do_exit+0xaa>
ffffffffc0205fc2:	0ec52783          	lw	a5,236(a0)
ffffffffc0205fc6:	fd379be3          	bne	a5,s3,ffffffffc0205f9c <do_exit+0xaa>
ffffffffc0205fca:	070010ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc0205fce:	b7f9                	j	ffffffffc0205f9c <do_exit+0xaa>
ffffffffc0205fd0:	020a1263          	bnez	s4,ffffffffc0205ff4 <do_exit+0x102>
ffffffffc0205fd4:	118010ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc0205fd8:	601c                	ld	a5,0(s0)
ffffffffc0205fda:	00007617          	auipc	a2,0x7
ffffffffc0205fde:	29e60613          	addi	a2,a2,670 # ffffffffc020d278 <CSWTCH.79+0x140>
ffffffffc0205fe2:	29d00593          	li	a1,669
ffffffffc0205fe6:	43d4                	lw	a3,4(a5)
ffffffffc0205fe8:	00007517          	auipc	a0,0x7
ffffffffc0205fec:	24050513          	addi	a0,a0,576 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0205ff0:	caefa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205ff4:	c79fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0205ff8:	bff1                	j	ffffffffc0205fd4 <do_exit+0xe2>
ffffffffc0205ffa:	968ff0ef          	jal	ra,ffffffffc0205162 <files_destroy>
ffffffffc0205ffe:	b7a5                	j	ffffffffc0205f66 <do_exit+0x74>
ffffffffc0206000:	00007617          	auipc	a2,0x7
ffffffffc0206004:	25860613          	addi	a2,a2,600 # ffffffffc020d258 <CSWTCH.79+0x120>
ffffffffc0206008:	26800593          	li	a1,616
ffffffffc020600c:	00007517          	auipc	a0,0x7
ffffffffc0206010:	21c50513          	addi	a0,a0,540 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206014:	c8afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206018:	854e                	mv	a0,s3
ffffffffc020601a:	e37fd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc020601e:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc0206022:	9d5ff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0206026:	854e                	mv	a0,s3
ffffffffc0206028:	c8dfd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc020602c:	b715                	j	ffffffffc0205f50 <do_exit+0x5e>
ffffffffc020602e:	00007617          	auipc	a2,0x7
ffffffffc0206032:	23a60613          	addi	a2,a2,570 # ffffffffc020d268 <CSWTCH.79+0x130>
ffffffffc0206036:	26c00593          	li	a1,620
ffffffffc020603a:	00007517          	auipc	a0,0x7
ffffffffc020603e:	1ee50513          	addi	a0,a0,494 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206042:	c5cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206046:	c2dfa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020604a:	4a05                	li	s4,1
ffffffffc020604c:	b73d                	j	ffffffffc0205f7a <do_exit+0x88>
ffffffffc020604e:	7ed000ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc0206052:	bf2d                	j	ffffffffc0205f8c <do_exit+0x9a>

ffffffffc0206054 <do_wait.part.0>:
ffffffffc0206054:	715d                	addi	sp,sp,-80
ffffffffc0206056:	f84a                	sd	s2,48(sp)
ffffffffc0206058:	f44e                	sd	s3,40(sp)
ffffffffc020605a:	80000937          	lui	s2,0x80000
ffffffffc020605e:	6989                	lui	s3,0x2
ffffffffc0206060:	fc26                	sd	s1,56(sp)
ffffffffc0206062:	f052                	sd	s4,32(sp)
ffffffffc0206064:	ec56                	sd	s5,24(sp)
ffffffffc0206066:	e85a                	sd	s6,16(sp)
ffffffffc0206068:	e45e                	sd	s7,8(sp)
ffffffffc020606a:	e486                	sd	ra,72(sp)
ffffffffc020606c:	e0a2                	sd	s0,64(sp)
ffffffffc020606e:	84aa                	mv	s1,a0
ffffffffc0206070:	8a2e                	mv	s4,a1
ffffffffc0206072:	00091b97          	auipc	s7,0x91
ffffffffc0206076:	84eb8b93          	addi	s7,s7,-1970 # ffffffffc02968c0 <current>
ffffffffc020607a:	00050b1b          	sext.w	s6,a0
ffffffffc020607e:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0206082:	19f9                	addi	s3,s3,-2
ffffffffc0206084:	0905                	addi	s2,s2,1
ffffffffc0206086:	ccbd                	beqz	s1,ffffffffc0206104 <do_wait.part.0+0xb0>
ffffffffc0206088:	0359e863          	bltu	s3,s5,ffffffffc02060b8 <do_wait.part.0+0x64>
ffffffffc020608c:	45a9                	li	a1,10
ffffffffc020608e:	855a                	mv	a0,s6
ffffffffc0206090:	48d040ef          	jal	ra,ffffffffc020ad1c <hash32>
ffffffffc0206094:	02051793          	slli	a5,a0,0x20
ffffffffc0206098:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020609c:	0008b797          	auipc	a5,0x8b
ffffffffc02060a0:	72478793          	addi	a5,a5,1828 # ffffffffc02917c0 <hash_list>
ffffffffc02060a4:	953e                	add	a0,a0,a5
ffffffffc02060a6:	842a                	mv	s0,a0
ffffffffc02060a8:	a029                	j	ffffffffc02060b2 <do_wait.part.0+0x5e>
ffffffffc02060aa:	f2c42783          	lw	a5,-212(s0)
ffffffffc02060ae:	02978163          	beq	a5,s1,ffffffffc02060d0 <do_wait.part.0+0x7c>
ffffffffc02060b2:	6400                	ld	s0,8(s0)
ffffffffc02060b4:	fe851be3          	bne	a0,s0,ffffffffc02060aa <do_wait.part.0+0x56>
ffffffffc02060b8:	5579                	li	a0,-2
ffffffffc02060ba:	60a6                	ld	ra,72(sp)
ffffffffc02060bc:	6406                	ld	s0,64(sp)
ffffffffc02060be:	74e2                	ld	s1,56(sp)
ffffffffc02060c0:	7942                	ld	s2,48(sp)
ffffffffc02060c2:	79a2                	ld	s3,40(sp)
ffffffffc02060c4:	7a02                	ld	s4,32(sp)
ffffffffc02060c6:	6ae2                	ld	s5,24(sp)
ffffffffc02060c8:	6b42                	ld	s6,16(sp)
ffffffffc02060ca:	6ba2                	ld	s7,8(sp)
ffffffffc02060cc:	6161                	addi	sp,sp,80
ffffffffc02060ce:	8082                	ret
ffffffffc02060d0:	000bb683          	ld	a3,0(s7)
ffffffffc02060d4:	f4843783          	ld	a5,-184(s0)
ffffffffc02060d8:	fed790e3          	bne	a5,a3,ffffffffc02060b8 <do_wait.part.0+0x64>
ffffffffc02060dc:	f2842703          	lw	a4,-216(s0)
ffffffffc02060e0:	478d                	li	a5,3
ffffffffc02060e2:	0ef70b63          	beq	a4,a5,ffffffffc02061d8 <do_wait.part.0+0x184>
ffffffffc02060e6:	4785                	li	a5,1
ffffffffc02060e8:	c29c                	sw	a5,0(a3)
ffffffffc02060ea:	0f26a623          	sw	s2,236(a3)
ffffffffc02060ee:	7ff000ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc02060f2:	000bb783          	ld	a5,0(s7)
ffffffffc02060f6:	0b07a783          	lw	a5,176(a5)
ffffffffc02060fa:	8b85                	andi	a5,a5,1
ffffffffc02060fc:	d7c9                	beqz	a5,ffffffffc0206086 <do_wait.part.0+0x32>
ffffffffc02060fe:	555d                	li	a0,-9
ffffffffc0206100:	df3ff0ef          	jal	ra,ffffffffc0205ef2 <do_exit>
ffffffffc0206104:	000bb683          	ld	a3,0(s7)
ffffffffc0206108:	7ae0                	ld	s0,240(a3)
ffffffffc020610a:	d45d                	beqz	s0,ffffffffc02060b8 <do_wait.part.0+0x64>
ffffffffc020610c:	470d                	li	a4,3
ffffffffc020610e:	a021                	j	ffffffffc0206116 <do_wait.part.0+0xc2>
ffffffffc0206110:	10043403          	ld	s0,256(s0)
ffffffffc0206114:	d869                	beqz	s0,ffffffffc02060e6 <do_wait.part.0+0x92>
ffffffffc0206116:	401c                	lw	a5,0(s0)
ffffffffc0206118:	fee79ce3          	bne	a5,a4,ffffffffc0206110 <do_wait.part.0+0xbc>
ffffffffc020611c:	00090797          	auipc	a5,0x90
ffffffffc0206120:	7ac7b783          	ld	a5,1964(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0206124:	0c878963          	beq	a5,s0,ffffffffc02061f6 <do_wait.part.0+0x1a2>
ffffffffc0206128:	00090797          	auipc	a5,0x90
ffffffffc020612c:	7a87b783          	ld	a5,1960(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206130:	0cf40363          	beq	s0,a5,ffffffffc02061f6 <do_wait.part.0+0x1a2>
ffffffffc0206134:	000a0663          	beqz	s4,ffffffffc0206140 <do_wait.part.0+0xec>
ffffffffc0206138:	0e842783          	lw	a5,232(s0)
ffffffffc020613c:	00fa2023          	sw	a5,0(s4)
ffffffffc0206140:	100027f3          	csrr	a5,sstatus
ffffffffc0206144:	8b89                	andi	a5,a5,2
ffffffffc0206146:	4581                	li	a1,0
ffffffffc0206148:	e7c1                	bnez	a5,ffffffffc02061d0 <do_wait.part.0+0x17c>
ffffffffc020614a:	6c70                	ld	a2,216(s0)
ffffffffc020614c:	7074                	ld	a3,224(s0)
ffffffffc020614e:	10043703          	ld	a4,256(s0)
ffffffffc0206152:	7c7c                	ld	a5,248(s0)
ffffffffc0206154:	e614                	sd	a3,8(a2)
ffffffffc0206156:	e290                	sd	a2,0(a3)
ffffffffc0206158:	6470                	ld	a2,200(s0)
ffffffffc020615a:	6874                	ld	a3,208(s0)
ffffffffc020615c:	e614                	sd	a3,8(a2)
ffffffffc020615e:	e290                	sd	a2,0(a3)
ffffffffc0206160:	c319                	beqz	a4,ffffffffc0206166 <do_wait.part.0+0x112>
ffffffffc0206162:	ff7c                	sd	a5,248(a4)
ffffffffc0206164:	7c7c                	ld	a5,248(s0)
ffffffffc0206166:	c3b5                	beqz	a5,ffffffffc02061ca <do_wait.part.0+0x176>
ffffffffc0206168:	10e7b023          	sd	a4,256(a5)
ffffffffc020616c:	00090717          	auipc	a4,0x90
ffffffffc0206170:	76c70713          	addi	a4,a4,1900 # ffffffffc02968d8 <nr_process>
ffffffffc0206174:	431c                	lw	a5,0(a4)
ffffffffc0206176:	37fd                	addiw	a5,a5,-1
ffffffffc0206178:	c31c                	sw	a5,0(a4)
ffffffffc020617a:	e5a9                	bnez	a1,ffffffffc02061c4 <do_wait.part.0+0x170>
ffffffffc020617c:	6814                	ld	a3,16(s0)
ffffffffc020617e:	c02007b7          	lui	a5,0xc0200
ffffffffc0206182:	04f6ee63          	bltu	a3,a5,ffffffffc02061de <do_wait.part.0+0x18a>
ffffffffc0206186:	00090797          	auipc	a5,0x90
ffffffffc020618a:	7327b783          	ld	a5,1842(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc020618e:	8e9d                	sub	a3,a3,a5
ffffffffc0206190:	82b1                	srli	a3,a3,0xc
ffffffffc0206192:	00090797          	auipc	a5,0x90
ffffffffc0206196:	70e7b783          	ld	a5,1806(a5) # ffffffffc02968a0 <npage>
ffffffffc020619a:	06f6fa63          	bgeu	a3,a5,ffffffffc020620e <do_wait.part.0+0x1ba>
ffffffffc020619e:	00009517          	auipc	a0,0x9
ffffffffc02061a2:	27253503          	ld	a0,626(a0) # ffffffffc020f410 <nbase>
ffffffffc02061a6:	8e89                	sub	a3,a3,a0
ffffffffc02061a8:	069a                	slli	a3,a3,0x6
ffffffffc02061aa:	00090517          	auipc	a0,0x90
ffffffffc02061ae:	6fe53503          	ld	a0,1790(a0) # ffffffffc02968a8 <pages>
ffffffffc02061b2:	9536                	add	a0,a0,a3
ffffffffc02061b4:	4589                	li	a1,2
ffffffffc02061b6:	ff5fb0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02061ba:	8522                	mv	a0,s0
ffffffffc02061bc:	e83fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02061c0:	4501                	li	a0,0
ffffffffc02061c2:	bde5                	j	ffffffffc02060ba <do_wait.part.0+0x66>
ffffffffc02061c4:	aa9fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02061c8:	bf55                	j	ffffffffc020617c <do_wait.part.0+0x128>
ffffffffc02061ca:	701c                	ld	a5,32(s0)
ffffffffc02061cc:	fbf8                	sd	a4,240(a5)
ffffffffc02061ce:	bf79                	j	ffffffffc020616c <do_wait.part.0+0x118>
ffffffffc02061d0:	aa3fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02061d4:	4585                	li	a1,1
ffffffffc02061d6:	bf95                	j	ffffffffc020614a <do_wait.part.0+0xf6>
ffffffffc02061d8:	f2840413          	addi	s0,s0,-216
ffffffffc02061dc:	b781                	j	ffffffffc020611c <do_wait.part.0+0xc8>
ffffffffc02061de:	00006617          	auipc	a2,0x6
ffffffffc02061e2:	12260613          	addi	a2,a2,290 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc02061e6:	07700593          	li	a1,119
ffffffffc02061ea:	00006517          	auipc	a0,0x6
ffffffffc02061ee:	09650513          	addi	a0,a0,150 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc02061f2:	aacfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02061f6:	00007617          	auipc	a2,0x7
ffffffffc02061fa:	0a260613          	addi	a2,a2,162 # ffffffffc020d298 <CSWTCH.79+0x160>
ffffffffc02061fe:	42600593          	li	a1,1062
ffffffffc0206202:	00007517          	auipc	a0,0x7
ffffffffc0206206:	02650513          	addi	a0,a0,38 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc020620a:	a94fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020620e:	fccff0ef          	jal	ra,ffffffffc02059da <pa2page.part.0>

ffffffffc0206212 <init_main>:
ffffffffc0206212:	1141                	addi	sp,sp,-16
ffffffffc0206214:	00007517          	auipc	a0,0x7
ffffffffc0206218:	0a450513          	addi	a0,a0,164 # ffffffffc020d2b8 <CSWTCH.79+0x180>
ffffffffc020621c:	e406                	sd	ra,8(sp)
ffffffffc020621e:	63e010ef          	jal	ra,ffffffffc020785c <vfs_set_bootfs>
ffffffffc0206222:	e179                	bnez	a0,ffffffffc02062e8 <init_main+0xd6>
ffffffffc0206224:	fc7fb0ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0206228:	d63fb0ef          	jal	ra,ffffffffc0201f8a <kallocated>
ffffffffc020622c:	4601                	li	a2,0
ffffffffc020622e:	4581                	li	a1,0
ffffffffc0206230:	00001517          	auipc	a0,0x1
ffffffffc0206234:	86450513          	addi	a0,a0,-1948 # ffffffffc0206a94 <user_main>
ffffffffc0206238:	c6bff0ef          	jal	ra,ffffffffc0205ea2 <kernel_thread>
ffffffffc020623c:	00a04563          	bgtz	a0,ffffffffc0206246 <init_main+0x34>
ffffffffc0206240:	a841                	j	ffffffffc02062d0 <init_main+0xbe>
ffffffffc0206242:	6ab000ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc0206246:	4581                	li	a1,0
ffffffffc0206248:	4501                	li	a0,0
ffffffffc020624a:	e0bff0ef          	jal	ra,ffffffffc0206054 <do_wait.part.0>
ffffffffc020624e:	d975                	beqz	a0,ffffffffc0206242 <init_main+0x30>
ffffffffc0206250:	ecdfe0ef          	jal	ra,ffffffffc020511c <fs_cleanup>
ffffffffc0206254:	00007517          	auipc	a0,0x7
ffffffffc0206258:	0ac50513          	addi	a0,a0,172 # ffffffffc020d300 <CSWTCH.79+0x1c8>
ffffffffc020625c:	f4bf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206260:	00090797          	auipc	a5,0x90
ffffffffc0206264:	6707b783          	ld	a5,1648(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206268:	7bf8                	ld	a4,240(a5)
ffffffffc020626a:	e339                	bnez	a4,ffffffffc02062b0 <init_main+0x9e>
ffffffffc020626c:	7ff8                	ld	a4,248(a5)
ffffffffc020626e:	e329                	bnez	a4,ffffffffc02062b0 <init_main+0x9e>
ffffffffc0206270:	1007b703          	ld	a4,256(a5)
ffffffffc0206274:	ef15                	bnez	a4,ffffffffc02062b0 <init_main+0x9e>
ffffffffc0206276:	00090697          	auipc	a3,0x90
ffffffffc020627a:	6626a683          	lw	a3,1634(a3) # ffffffffc02968d8 <nr_process>
ffffffffc020627e:	4709                	li	a4,2
ffffffffc0206280:	0ce69163          	bne	a3,a4,ffffffffc0206342 <init_main+0x130>
ffffffffc0206284:	0008f717          	auipc	a4,0x8f
ffffffffc0206288:	53c70713          	addi	a4,a4,1340 # ffffffffc02957c0 <proc_list>
ffffffffc020628c:	6714                	ld	a3,8(a4)
ffffffffc020628e:	0c878793          	addi	a5,a5,200
ffffffffc0206292:	08d79863          	bne	a5,a3,ffffffffc0206322 <init_main+0x110>
ffffffffc0206296:	6318                	ld	a4,0(a4)
ffffffffc0206298:	06e79563          	bne	a5,a4,ffffffffc0206302 <init_main+0xf0>
ffffffffc020629c:	00007517          	auipc	a0,0x7
ffffffffc02062a0:	14c50513          	addi	a0,a0,332 # ffffffffc020d3e8 <CSWTCH.79+0x2b0>
ffffffffc02062a4:	f03f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02062a8:	60a2                	ld	ra,8(sp)
ffffffffc02062aa:	4501                	li	a0,0
ffffffffc02062ac:	0141                	addi	sp,sp,16
ffffffffc02062ae:	8082                	ret
ffffffffc02062b0:	00007697          	auipc	a3,0x7
ffffffffc02062b4:	07868693          	addi	a3,a3,120 # ffffffffc020d328 <CSWTCH.79+0x1f0>
ffffffffc02062b8:	00005617          	auipc	a2,0x5
ffffffffc02062bc:	48060613          	addi	a2,a2,1152 # ffffffffc020b738 <commands+0x210>
ffffffffc02062c0:	49c00593          	li	a1,1180
ffffffffc02062c4:	00007517          	auipc	a0,0x7
ffffffffc02062c8:	f6450513          	addi	a0,a0,-156 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc02062cc:	9d2fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02062d0:	00007617          	auipc	a2,0x7
ffffffffc02062d4:	01060613          	addi	a2,a2,16 # ffffffffc020d2e0 <CSWTCH.79+0x1a8>
ffffffffc02062d8:	48f00593          	li	a1,1167
ffffffffc02062dc:	00007517          	auipc	a0,0x7
ffffffffc02062e0:	f4c50513          	addi	a0,a0,-180 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc02062e4:	9bafa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02062e8:	86aa                	mv	a3,a0
ffffffffc02062ea:	00007617          	auipc	a2,0x7
ffffffffc02062ee:	fd660613          	addi	a2,a2,-42 # ffffffffc020d2c0 <CSWTCH.79+0x188>
ffffffffc02062f2:	48700593          	li	a1,1159
ffffffffc02062f6:	00007517          	auipc	a0,0x7
ffffffffc02062fa:	f3250513          	addi	a0,a0,-206 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc02062fe:	9a0fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206302:	00007697          	auipc	a3,0x7
ffffffffc0206306:	0b668693          	addi	a3,a3,182 # ffffffffc020d3b8 <CSWTCH.79+0x280>
ffffffffc020630a:	00005617          	auipc	a2,0x5
ffffffffc020630e:	42e60613          	addi	a2,a2,1070 # ffffffffc020b738 <commands+0x210>
ffffffffc0206312:	49f00593          	li	a1,1183
ffffffffc0206316:	00007517          	auipc	a0,0x7
ffffffffc020631a:	f1250513          	addi	a0,a0,-238 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc020631e:	980fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206322:	00007697          	auipc	a3,0x7
ffffffffc0206326:	06668693          	addi	a3,a3,102 # ffffffffc020d388 <CSWTCH.79+0x250>
ffffffffc020632a:	00005617          	auipc	a2,0x5
ffffffffc020632e:	40e60613          	addi	a2,a2,1038 # ffffffffc020b738 <commands+0x210>
ffffffffc0206332:	49e00593          	li	a1,1182
ffffffffc0206336:	00007517          	auipc	a0,0x7
ffffffffc020633a:	ef250513          	addi	a0,a0,-270 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc020633e:	960fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206342:	00007697          	auipc	a3,0x7
ffffffffc0206346:	03668693          	addi	a3,a3,54 # ffffffffc020d378 <CSWTCH.79+0x240>
ffffffffc020634a:	00005617          	auipc	a2,0x5
ffffffffc020634e:	3ee60613          	addi	a2,a2,1006 # ffffffffc020b738 <commands+0x210>
ffffffffc0206352:	49d00593          	li	a1,1181
ffffffffc0206356:	00007517          	auipc	a0,0x7
ffffffffc020635a:	ed250513          	addi	a0,a0,-302 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc020635e:	940fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206362 <do_execve>:
ffffffffc0206362:	ce010113          	addi	sp,sp,-800
ffffffffc0206366:	31213023          	sd	s2,768(sp)
ffffffffc020636a:	00090917          	auipc	s2,0x90
ffffffffc020636e:	55690913          	addi	s2,s2,1366 # ffffffffc02968c0 <current>
ffffffffc0206372:	00093683          	ld	a3,0(s2)
ffffffffc0206376:	2f413823          	sd	s4,752(sp)
ffffffffc020637a:	fff58a1b          	addiw	s4,a1,-1
ffffffffc020637e:	2d713c23          	sd	s7,728(sp)
ffffffffc0206382:	30113c23          	sd	ra,792(sp)
ffffffffc0206386:	30813823          	sd	s0,784(sp)
ffffffffc020638a:	30913423          	sd	s1,776(sp)
ffffffffc020638e:	2f313c23          	sd	s3,760(sp)
ffffffffc0206392:	2f513423          	sd	s5,744(sp)
ffffffffc0206396:	2f613023          	sd	s6,736(sp)
ffffffffc020639a:	2d813823          	sd	s8,720(sp)
ffffffffc020639e:	2d913423          	sd	s9,712(sp)
ffffffffc02063a2:	2da13023          	sd	s10,704(sp)
ffffffffc02063a6:	2bb13c23          	sd	s11,696(sp)
ffffffffc02063aa:	000a071b          	sext.w	a4,s4
ffffffffc02063ae:	47fd                	li	a5,31
ffffffffc02063b0:	0286bb83          	ld	s7,40(a3)
ffffffffc02063b4:	4ee7e763          	bltu	a5,a4,ffffffffc02068a2 <do_execve+0x540>
ffffffffc02063b8:	842e                	mv	s0,a1
ffffffffc02063ba:	84aa                	mv	s1,a0
ffffffffc02063bc:	8c32                	mv	s8,a2
ffffffffc02063be:	4581                	li	a1,0
ffffffffc02063c0:	4641                	li	a2,16
ffffffffc02063c2:	1088                	addi	a0,sp,96
ffffffffc02063c4:	68d040ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc02063c8:	000b8c63          	beqz	s7,ffffffffc02063e0 <do_execve+0x7e>
ffffffffc02063cc:	038b8513          	addi	a0,s7,56
ffffffffc02063d0:	8f2fe0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02063d4:	00093783          	ld	a5,0(s2)
ffffffffc02063d8:	c781                	beqz	a5,ffffffffc02063e0 <do_execve+0x7e>
ffffffffc02063da:	43dc                	lw	a5,4(a5)
ffffffffc02063dc:	04fba823          	sw	a5,80(s7)
ffffffffc02063e0:	2a048163          	beqz	s1,ffffffffc0206682 <do_execve+0x320>
ffffffffc02063e4:	46c1                	li	a3,16
ffffffffc02063e6:	8626                	mv	a2,s1
ffffffffc02063e8:	108c                	addi	a1,sp,96
ffffffffc02063ea:	855e                	mv	a0,s7
ffffffffc02063ec:	efffd0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc02063f0:	4c050663          	beqz	a0,ffffffffc02068bc <do_execve+0x55a>
ffffffffc02063f4:	00341793          	slli	a5,s0,0x3
ffffffffc02063f8:	4681                	li	a3,0
ffffffffc02063fa:	863e                	mv	a2,a5
ffffffffc02063fc:	85e2                	mv	a1,s8
ffffffffc02063fe:	855e                	mv	a0,s7
ffffffffc0206400:	e43e                	sd	a5,8(sp)
ffffffffc0206402:	deffd0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc0206406:	8ae2                	mv	s5,s8
ffffffffc0206408:	4a050463          	beqz	a0,ffffffffc02068b0 <do_execve+0x54e>
ffffffffc020640c:	0b010b13          	addi	s6,sp,176
ffffffffc0206410:	4481                	li	s1,0
ffffffffc0206412:	a011                	j	ffffffffc0206416 <do_execve+0xb4>
ffffffffc0206414:	84be                	mv	s1,a5
ffffffffc0206416:	6505                	lui	a0,0x1
ffffffffc0206418:	b77fb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020641c:	89aa                	mv	s3,a0
ffffffffc020641e:	1c050f63          	beqz	a0,ffffffffc02065fc <do_execve+0x29a>
ffffffffc0206422:	000ab603          	ld	a2,0(s5)
ffffffffc0206426:	85aa                	mv	a1,a0
ffffffffc0206428:	6685                	lui	a3,0x1
ffffffffc020642a:	855e                	mv	a0,s7
ffffffffc020642c:	ebffd0ef          	jal	ra,ffffffffc02042ea <copy_string>
ffffffffc0206430:	24050463          	beqz	a0,ffffffffc0206678 <do_execve+0x316>
ffffffffc0206434:	013b3023          	sd	s3,0(s6)
ffffffffc0206438:	0014879b          	addiw	a5,s1,1
ffffffffc020643c:	0b21                	addi	s6,s6,8
ffffffffc020643e:	0aa1                	addi	s5,s5,8
ffffffffc0206440:	fcf41ae3          	bne	s0,a5,ffffffffc0206414 <do_execve+0xb2>
ffffffffc0206444:	000c3983          	ld	s3,0(s8)
ffffffffc0206448:	120b8a63          	beqz	s7,ffffffffc020657c <do_execve+0x21a>
ffffffffc020644c:	038b8513          	addi	a0,s7,56
ffffffffc0206450:	86efe0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0206454:	00093783          	ld	a5,0(s2)
ffffffffc0206458:	040ba823          	sw	zero,80(s7)
ffffffffc020645c:	1487b503          	ld	a0,328(a5)
ffffffffc0206460:	d99fe0ef          	jal	ra,ffffffffc02051f8 <files_closeall>
ffffffffc0206464:	4581                	li	a1,0
ffffffffc0206466:	854e                	mv	a0,s3
ffffffffc0206468:	81cff0ef          	jal	ra,ffffffffc0205484 <sysfile_open>
ffffffffc020646c:	8aaa                	mv	s5,a0
ffffffffc020646e:	12054463          	bltz	a0,ffffffffc0206596 <do_execve+0x234>
ffffffffc0206472:	00090797          	auipc	a5,0x90
ffffffffc0206476:	41e7b783          	ld	a5,1054(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc020647a:	577d                	li	a4,-1
ffffffffc020647c:	177e                	slli	a4,a4,0x3f
ffffffffc020647e:	83b1                	srli	a5,a5,0xc
ffffffffc0206480:	8fd9                	or	a5,a5,a4
ffffffffc0206482:	18079073          	csrw	satp,a5
ffffffffc0206486:	030ba783          	lw	a5,48(s7)
ffffffffc020648a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020648e:	02eba823          	sw	a4,48(s7)
ffffffffc0206492:	34070663          	beqz	a4,ffffffffc02067de <do_execve+0x47c>
ffffffffc0206496:	00093783          	ld	a5,0(s2)
ffffffffc020649a:	0207b423          	sd	zero,40(a5)
ffffffffc020649e:	ec8fd0ef          	jal	ra,ffffffffc0203b66 <mm_create>
ffffffffc02064a2:	89aa                	mv	s3,a0
ffffffffc02064a4:	40050463          	beqz	a0,ffffffffc02068ac <do_execve+0x54a>
ffffffffc02064a8:	4505                	li	a0,1
ffffffffc02064aa:	cc3fb0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02064ae:	3e050c63          	beqz	a0,ffffffffc02068a6 <do_execve+0x544>
ffffffffc02064b2:	00090c97          	auipc	s9,0x90
ffffffffc02064b6:	3f6c8c93          	addi	s9,s9,1014 # ffffffffc02968a8 <pages>
ffffffffc02064ba:	000cb683          	ld	a3,0(s9)
ffffffffc02064be:	00090c17          	auipc	s8,0x90
ffffffffc02064c2:	3e2c0c13          	addi	s8,s8,994 # ffffffffc02968a0 <npage>
ffffffffc02064c6:	00009b17          	auipc	s6,0x9
ffffffffc02064ca:	f4ab3b03          	ld	s6,-182(s6) # ffffffffc020f410 <nbase>
ffffffffc02064ce:	40d506b3          	sub	a3,a0,a3
ffffffffc02064d2:	8699                	srai	a3,a3,0x6
ffffffffc02064d4:	577d                	li	a4,-1
ffffffffc02064d6:	000c3783          	ld	a5,0(s8)
ffffffffc02064da:	96da                	add	a3,a3,s6
ffffffffc02064dc:	8331                	srli	a4,a4,0xc
ffffffffc02064de:	e03a                	sd	a4,0(sp)
ffffffffc02064e0:	8f75                	and	a4,a4,a3
ffffffffc02064e2:	06b2                	slli	a3,a3,0xc
ffffffffc02064e4:	3ef77763          	bgeu	a4,a5,ffffffffc02068d2 <do_execve+0x570>
ffffffffc02064e8:	00090b97          	auipc	s7,0x90
ffffffffc02064ec:	3d0b8b93          	addi	s7,s7,976 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02064f0:	000bbd03          	ld	s10,0(s7)
ffffffffc02064f4:	6605                	lui	a2,0x1
ffffffffc02064f6:	00090597          	auipc	a1,0x90
ffffffffc02064fa:	3a25b583          	ld	a1,930(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc02064fe:	9d36                	add	s10,s10,a3
ffffffffc0206500:	856a                	mv	a0,s10
ffffffffc0206502:	5a1040ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0206506:	4601                	li	a2,0
ffffffffc0206508:	01a9bc23          	sd	s10,24(s3) # 2018 <_binary_bin_swap_img_size-0x5ce8>
ffffffffc020650c:	4581                	li	a1,0
ffffffffc020650e:	8556                	mv	a0,s5
ffffffffc0206510:	9daff0ef          	jal	ra,ffffffffc02056ea <sysfile_seek>
ffffffffc0206514:	8d2a                	mv	s10,a0
ffffffffc0206516:	e105                	bnez	a0,ffffffffc0206536 <do_execve+0x1d4>
ffffffffc0206518:	04000613          	li	a2,64
ffffffffc020651c:	188c                	addi	a1,sp,112
ffffffffc020651e:	8556                	mv	a0,s5
ffffffffc0206520:	f9dfe0ef          	jal	ra,ffffffffc02054bc <sysfile_read>
ffffffffc0206524:	04000793          	li	a5,64
ffffffffc0206528:	06f50d63          	beq	a0,a5,ffffffffc02065a2 <do_execve+0x240>
ffffffffc020652c:	00050d1b          	sext.w	s10,a0
ffffffffc0206530:	00054363          	bltz	a0,ffffffffc0206536 <do_execve+0x1d4>
ffffffffc0206534:	5d7d                	li	s10,-1
ffffffffc0206536:	1a02                	slli	s4,s4,0x20
ffffffffc0206538:	0a010b93          	addi	s7,sp,160
ffffffffc020653c:	020a5a13          	srli	s4,s4,0x20
ffffffffc0206540:	854e                	mv	a0,s3
ffffffffc0206542:	90ffd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc0206546:	0189b503          	ld	a0,24(s3)
ffffffffc020654a:	8aea                	mv	s5,s10
ffffffffc020654c:	caaff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc0206550:	854e                	mv	a0,s3
ffffffffc0206552:	f62fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc0206556:	67a2                	ld	a5,8(sp)
ffffffffc0206558:	147d                	addi	s0,s0,-1
ffffffffc020655a:	040e                	slli	s0,s0,0x3
ffffffffc020655c:	00fb84b3          	add	s1,s7,a5
ffffffffc0206560:	0a0e                	slli	s4,s4,0x3
ffffffffc0206562:	191c                	addi	a5,sp,176
ffffffffc0206564:	943e                	add	s0,s0,a5
ffffffffc0206566:	414484b3          	sub	s1,s1,s4
ffffffffc020656a:	6008                	ld	a0,0(s0)
ffffffffc020656c:	1461                	addi	s0,s0,-8
ffffffffc020656e:	ad1fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206572:	fe941ce3          	bne	s0,s1,ffffffffc020656a <do_execve+0x208>
ffffffffc0206576:	8556                	mv	a0,s5
ffffffffc0206578:	97bff0ef          	jal	ra,ffffffffc0205ef2 <do_exit>
ffffffffc020657c:	00093783          	ld	a5,0(s2)
ffffffffc0206580:	1487b503          	ld	a0,328(a5)
ffffffffc0206584:	c75fe0ef          	jal	ra,ffffffffc02051f8 <files_closeall>
ffffffffc0206588:	4581                	li	a1,0
ffffffffc020658a:	854e                	mv	a0,s3
ffffffffc020658c:	ef9fe0ef          	jal	ra,ffffffffc0205484 <sysfile_open>
ffffffffc0206590:	8aaa                	mv	s5,a0
ffffffffc0206592:	f00556e3          	bgez	a0,ffffffffc020649e <do_execve+0x13c>
ffffffffc0206596:	1a02                	slli	s4,s4,0x20
ffffffffc0206598:	0a010b93          	addi	s7,sp,160
ffffffffc020659c:	020a5a13          	srli	s4,s4,0x20
ffffffffc02065a0:	bf5d                	j	ffffffffc0206556 <do_execve+0x1f4>
ffffffffc02065a2:	5746                	lw	a4,112(sp)
ffffffffc02065a4:	464c47b7          	lui	a5,0x464c4
ffffffffc02065a8:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc02065ac:	0ef71763          	bne	a4,a5,ffffffffc020669a <do_execve+0x338>
ffffffffc02065b0:	0a815783          	lhu	a5,168(sp)
ffffffffc02065b4:	4701                	li	a4,0
ffffffffc02065b6:	10078863          	beqz	a5,ffffffffc02066c6 <do_execve+0x364>
ffffffffc02065ba:	e0a6                	sd	s1,64(sp)
ffffffffc02065bc:	e822                	sd	s0,16(sp)
ffffffffc02065be:	84ba                	mv	s1,a4
ffffffffc02065c0:	ce52                	sw	s4,28(sp)
ffffffffc02065c2:	65ca                	ld	a1,144(sp)
ffffffffc02065c4:	00349793          	slli	a5,s1,0x3
ffffffffc02065c8:	8f85                	sub	a5,a5,s1
ffffffffc02065ca:	078e                	slli	a5,a5,0x3
ffffffffc02065cc:	4601                	li	a2,0
ffffffffc02065ce:	95be                	add	a1,a1,a5
ffffffffc02065d0:	8556                	mv	a0,s5
ffffffffc02065d2:	918ff0ef          	jal	ra,ffffffffc02056ea <sysfile_seek>
ffffffffc02065d6:	1e051b63          	bnez	a0,ffffffffc02067cc <do_execve+0x46a>
ffffffffc02065da:	03800613          	li	a2,56
ffffffffc02065de:	1b0c                	addi	a1,sp,432
ffffffffc02065e0:	8556                	mv	a0,s5
ffffffffc02065e2:	edbfe0ef          	jal	ra,ffffffffc02054bc <sysfile_read>
ffffffffc02065e6:	03800793          	li	a5,56
ffffffffc02065ea:	0af50f63          	beq	a0,a5,ffffffffc02066a8 <do_execve+0x346>
ffffffffc02065ee:	6442                	ld	s0,16(sp)
ffffffffc02065f0:	4a72                	lw	s4,28(sp)
ffffffffc02065f2:	00050d1b          	sext.w	s10,a0
ffffffffc02065f6:	f2055fe3          	bgez	a0,ffffffffc0206534 <do_execve+0x1d2>
ffffffffc02065fa:	bf35                	j	ffffffffc0206536 <do_execve+0x1d4>
ffffffffc02065fc:	5d71                	li	s10,-4
ffffffffc02065fe:	c49d                	beqz	s1,ffffffffc020662c <do_execve+0x2ca>
ffffffffc0206600:	00349713          	slli	a4,s1,0x3
ffffffffc0206604:	fff48413          	addi	s0,s1,-1
ffffffffc0206608:	111c                	addi	a5,sp,160
ffffffffc020660a:	34fd                	addiw	s1,s1,-1
ffffffffc020660c:	97ba                	add	a5,a5,a4
ffffffffc020660e:	02049713          	slli	a4,s1,0x20
ffffffffc0206612:	01d75493          	srli	s1,a4,0x1d
ffffffffc0206616:	040e                	slli	s0,s0,0x3
ffffffffc0206618:	1918                	addi	a4,sp,176
ffffffffc020661a:	943a                	add	s0,s0,a4
ffffffffc020661c:	409784b3          	sub	s1,a5,s1
ffffffffc0206620:	6008                	ld	a0,0(s0)
ffffffffc0206622:	1461                	addi	s0,s0,-8
ffffffffc0206624:	a1bfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206628:	fe849ce3          	bne	s1,s0,ffffffffc0206620 <do_execve+0x2be>
ffffffffc020662c:	000b8863          	beqz	s7,ffffffffc020663c <do_execve+0x2da>
ffffffffc0206630:	038b8513          	addi	a0,s7,56
ffffffffc0206634:	e8bfd0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0206638:	040ba823          	sw	zero,80(s7)
ffffffffc020663c:	31813083          	ld	ra,792(sp)
ffffffffc0206640:	31013403          	ld	s0,784(sp)
ffffffffc0206644:	30813483          	ld	s1,776(sp)
ffffffffc0206648:	30013903          	ld	s2,768(sp)
ffffffffc020664c:	2f813983          	ld	s3,760(sp)
ffffffffc0206650:	2f013a03          	ld	s4,752(sp)
ffffffffc0206654:	2e813a83          	ld	s5,744(sp)
ffffffffc0206658:	2e013b03          	ld	s6,736(sp)
ffffffffc020665c:	2d813b83          	ld	s7,728(sp)
ffffffffc0206660:	2d013c03          	ld	s8,720(sp)
ffffffffc0206664:	2c813c83          	ld	s9,712(sp)
ffffffffc0206668:	2b813d83          	ld	s11,696(sp)
ffffffffc020666c:	856a                	mv	a0,s10
ffffffffc020666e:	2c013d03          	ld	s10,704(sp)
ffffffffc0206672:	32010113          	addi	sp,sp,800
ffffffffc0206676:	8082                	ret
ffffffffc0206678:	854e                	mv	a0,s3
ffffffffc020667a:	9c5fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020667e:	5d75                	li	s10,-3
ffffffffc0206680:	bfbd                	j	ffffffffc02065fe <do_execve+0x29c>
ffffffffc0206682:	00093783          	ld	a5,0(s2)
ffffffffc0206686:	00007617          	auipc	a2,0x7
ffffffffc020668a:	d8260613          	addi	a2,a2,-638 # ffffffffc020d408 <CSWTCH.79+0x2d0>
ffffffffc020668e:	45c1                	li	a1,16
ffffffffc0206690:	43d4                	lw	a3,4(a5)
ffffffffc0206692:	1088                	addi	a0,sp,96
ffffffffc0206694:	2cd040ef          	jal	ra,ffffffffc020b160 <snprintf>
ffffffffc0206698:	bbb1                	j	ffffffffc02063f4 <do_execve+0x92>
ffffffffc020669a:	1a02                	slli	s4,s4,0x20
ffffffffc020669c:	5d75                	li	s10,-3
ffffffffc020669e:	0a010b93          	addi	s7,sp,160
ffffffffc02066a2:	020a5a13          	srli	s4,s4,0x20
ffffffffc02066a6:	bd69                	j	ffffffffc0206540 <do_execve+0x1de>
ffffffffc02066a8:	1b012783          	lw	a5,432(sp)
ffffffffc02066ac:	4705                	li	a4,1
ffffffffc02066ae:	14e78363          	beq	a5,a4,ffffffffc02067f4 <do_execve+0x492>
ffffffffc02066b2:	2485                	addiw	s1,s1,1
ffffffffc02066b4:	0a815783          	lhu	a5,168(sp)
ffffffffc02066b8:	14c2                	slli	s1,s1,0x30
ffffffffc02066ba:	90c1                	srli	s1,s1,0x30
ffffffffc02066bc:	f0f4e3e3          	bltu	s1,a5,ffffffffc02065c2 <do_execve+0x260>
ffffffffc02066c0:	6486                	ld	s1,64(sp)
ffffffffc02066c2:	6442                	ld	s0,16(sp)
ffffffffc02066c4:	4a72                	lw	s4,28(sp)
ffffffffc02066c6:	4701                	li	a4,0
ffffffffc02066c8:	46ad                	li	a3,11
ffffffffc02066ca:	00100637          	lui	a2,0x100
ffffffffc02066ce:	7ff005b7          	lui	a1,0x7ff00
ffffffffc02066d2:	854e                	mv	a0,s3
ffffffffc02066d4:	e32fd0ef          	jal	ra,ffffffffc0203d06 <mm_map>
ffffffffc02066d8:	8d2a                	mv	s10,a0
ffffffffc02066da:	e4051ee3          	bnez	a0,ffffffffc0206536 <do_execve+0x1d4>
ffffffffc02066de:	57fd                	li	a5,-1
ffffffffc02066e0:	00c7da93          	srli	s5,a5,0xc
ffffffffc02066e4:	4785                	li	a5,1
ffffffffc02066e6:	07fe                	slli	a5,a5,0x1f
ffffffffc02066e8:	7ff00db7          	lui	s11,0x7ff00
ffffffffc02066ec:	e03e                	sd	a5,0(sp)
ffffffffc02066ee:	a815                	j	ffffffffc0206722 <do_execve+0x3c0>
ffffffffc02066f0:	000cb783          	ld	a5,0(s9)
ffffffffc02066f4:	000c3703          	ld	a4,0(s8)
ffffffffc02066f8:	40f507b3          	sub	a5,a0,a5
ffffffffc02066fc:	8799                	srai	a5,a5,0x6
ffffffffc02066fe:	97da                	add	a5,a5,s6
ffffffffc0206700:	0157f633          	and	a2,a5,s5
ffffffffc0206704:	07b2                	slli	a5,a5,0xc
ffffffffc0206706:	32e67b63          	bgeu	a2,a4,ffffffffc0206a3c <do_execve+0x6da>
ffffffffc020670a:	000bb503          	ld	a0,0(s7)
ffffffffc020670e:	6605                	lui	a2,0x1
ffffffffc0206710:	4581                	li	a1,0
ffffffffc0206712:	953e                	add	a0,a0,a5
ffffffffc0206714:	33d040ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0206718:	6785                	lui	a5,0x1
ffffffffc020671a:	9dbe                	add	s11,s11,a5
ffffffffc020671c:	6782                	ld	a5,0(sp)
ffffffffc020671e:	1cfd8663          	beq	s11,a5,ffffffffc02068ea <do_execve+0x588>
ffffffffc0206722:	0189b503          	ld	a0,24(s3)
ffffffffc0206726:	4659                	li	a2,22
ffffffffc0206728:	85ee                	mv	a1,s11
ffffffffc020672a:	b56fd0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc020672e:	f169                	bnez	a0,ffffffffc02066f0 <do_execve+0x38e>
ffffffffc0206730:	5d71                	li	s10,-4
ffffffffc0206732:	b511                	j	ffffffffc0206536 <do_execve+0x1d4>
ffffffffc0206734:	7782                	ld	a5,32(sp)
ffffffffc0206736:	dfb5                	beqz	a5,ffffffffc02066b2 <do_execve+0x350>
ffffffffc0206738:	4401                	li	s0,0
ffffffffc020673a:	f852                	sd	s4,48(sp)
ffffffffc020673c:	e4a6                	sd	s1,72(sp)
ffffffffc020673e:	a815                	j	ffffffffc0206772 <do_execve+0x410>
ffffffffc0206740:	7782                	ld	a5,32(sp)
ffffffffc0206742:	414d0633          	sub	a2,s10,s4
ffffffffc0206746:	6705                	lui	a4,0x1
ffffffffc0206748:	8f81                	sub	a5,a5,s0
ffffffffc020674a:	963a                	add	a2,a2,a4
ffffffffc020674c:	00c7f363          	bgeu	a5,a2,ffffffffc0206752 <do_execve+0x3f0>
ffffffffc0206750:	863e                	mv	a2,a5
ffffffffc0206752:	01b485b3          	add	a1,s1,s11
ffffffffc0206756:	41aa0a33          	sub	s4,s4,s10
ffffffffc020675a:	95d2                	add	a1,a1,s4
ffffffffc020675c:	8556                	mv	a0,s5
ffffffffc020675e:	fc32                	sd	a2,56(sp)
ffffffffc0206760:	d5dfe0ef          	jal	ra,ffffffffc02054bc <sysfile_read>
ffffffffc0206764:	7662                	ld	a2,56(sp)
ffffffffc0206766:	e8a614e3          	bne	a2,a0,ffffffffc02065ee <do_execve+0x28c>
ffffffffc020676a:	7782                	ld	a5,32(sp)
ffffffffc020676c:	9432                	add	s0,s0,a2
ffffffffc020676e:	14f47563          	bgeu	s0,a5,ffffffffc02068b8 <do_execve+0x556>
ffffffffc0206772:	77c2                	ld	a5,48(sp)
ffffffffc0206774:	0189b503          	ld	a0,24(s3)
ffffffffc0206778:	4601                	li	a2,0
ffffffffc020677a:	00878a33          	add	s4,a5,s0
ffffffffc020677e:	77fd                	lui	a5,0xfffff
ffffffffc0206780:	00fa7d33          	and	s10,s4,a5
ffffffffc0206784:	85ea                	mv	a1,s10
ffffffffc0206786:	a9ffb0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020678a:	2e050563          	beqz	a0,ffffffffc0206a74 <do_execve+0x712>
ffffffffc020678e:	611c                	ld	a5,0(a0)
ffffffffc0206790:	0017f693          	andi	a3,a5,1
ffffffffc0206794:	2e068063          	beqz	a3,ffffffffc0206a74 <do_execve+0x712>
ffffffffc0206798:	000c3683          	ld	a3,0(s8)
ffffffffc020679c:	078a                	slli	a5,a5,0x2
ffffffffc020679e:	83b1                	srli	a5,a5,0xc
ffffffffc02067a0:	2cd7f863          	bgeu	a5,a3,ffffffffc0206a70 <do_execve+0x70e>
ffffffffc02067a4:	416784b3          	sub	s1,a5,s6
ffffffffc02067a8:	049a                	slli	s1,s1,0x6
ffffffffc02067aa:	6782                	ld	a5,0(sp)
ffffffffc02067ac:	8499                	srai	s1,s1,0x6
ffffffffc02067ae:	94da                	add	s1,s1,s6
ffffffffc02067b0:	8fe5                	and	a5,a5,s1
ffffffffc02067b2:	04b2                	slli	s1,s1,0xc
ffffffffc02067b4:	2ad7f163          	bgeu	a5,a3,ffffffffc0206a56 <do_execve+0x6f4>
ffffffffc02067b8:	77a2                	ld	a5,40(sp)
ffffffffc02067ba:	4601                	li	a2,0
ffffffffc02067bc:	8556                	mv	a0,s5
ffffffffc02067be:	00f405b3          	add	a1,s0,a5
ffffffffc02067c2:	000bbd83          	ld	s11,0(s7)
ffffffffc02067c6:	f25fe0ef          	jal	ra,ffffffffc02056ea <sysfile_seek>
ffffffffc02067ca:	d93d                	beqz	a0,ffffffffc0206740 <do_execve+0x3de>
ffffffffc02067cc:	4a72                	lw	s4,28(sp)
ffffffffc02067ce:	6442                	ld	s0,16(sp)
ffffffffc02067d0:	8d2a                	mv	s10,a0
ffffffffc02067d2:	1a02                	slli	s4,s4,0x20
ffffffffc02067d4:	0a010b93          	addi	s7,sp,160
ffffffffc02067d8:	020a5a13          	srli	s4,s4,0x20
ffffffffc02067dc:	b395                	j	ffffffffc0206540 <do_execve+0x1de>
ffffffffc02067de:	855e                	mv	a0,s7
ffffffffc02067e0:	e70fd0ef          	jal	ra,ffffffffc0203e50 <exit_mmap>
ffffffffc02067e4:	018bb503          	ld	a0,24(s7)
ffffffffc02067e8:	a0eff0ef          	jal	ra,ffffffffc02059f6 <put_pgdir.isra.0>
ffffffffc02067ec:	855e                	mv	a0,s7
ffffffffc02067ee:	cc6fd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc02067f2:	b155                	j	ffffffffc0206496 <do_execve+0x134>
ffffffffc02067f4:	1b412783          	lw	a5,436(sp)
ffffffffc02067f8:	675e                	ld	a4,464(sp)
ffffffffc02067fa:	767a                	ld	a2,440(sp)
ffffffffc02067fc:	4027d69b          	sraiw	a3,a5,0x2
ffffffffc0206800:	f03a                	sd	a4,32(sp)
ffffffffc0206802:	f432                	sd	a2,40(sp)
ffffffffc0206804:	0027f713          	andi	a4,a5,2
ffffffffc0206808:	6a1e                	ld	s4,448(sp)
ffffffffc020680a:	6d7e                	ld	s10,472(sp)
ffffffffc020680c:	8a85                	andi	a3,a3,1
ffffffffc020680e:	c319                	beqz	a4,ffffffffc0206814 <do_execve+0x4b2>
ffffffffc0206810:	0026e693          	ori	a3,a3,2
ffffffffc0206814:	8b85                	andi	a5,a5,1
ffffffffc0206816:	c399                	beqz	a5,ffffffffc020681c <do_execve+0x4ba>
ffffffffc0206818:	0046e693          	ori	a3,a3,4
ffffffffc020681c:	4701                	li	a4,0
ffffffffc020681e:	866a                	mv	a2,s10
ffffffffc0206820:	85d2                	mv	a1,s4
ffffffffc0206822:	854e                	mv	a0,s3
ffffffffc0206824:	ce2fd0ef          	jal	ra,ffffffffc0203d06 <mm_map>
ffffffffc0206828:	f155                	bnez	a0,ffffffffc02067cc <do_execve+0x46a>
ffffffffc020682a:	1b412703          	lw	a4,436(sp)
ffffffffc020682e:	6785                	lui	a5,0x1
ffffffffc0206830:	17fd                	addi	a5,a5,-1
ffffffffc0206832:	9d52                	add	s10,s10,s4
ffffffffc0206834:	9d3e                	add	s10,s10,a5
ffffffffc0206836:	00477693          	andi	a3,a4,4
ffffffffc020683a:	77fd                	lui	a5,0xfffff
ffffffffc020683c:	00fa7433          	and	s0,s4,a5
ffffffffc0206840:	00fd7d33          	and	s10,s10,a5
ffffffffc0206844:	4dc1                	li	s11,16
ffffffffc0206846:	c291                	beqz	a3,ffffffffc020684a <do_execve+0x4e8>
ffffffffc0206848:	4dc9                	li	s11,18
ffffffffc020684a:	00277693          	andi	a3,a4,2
ffffffffc020684e:	c299                	beqz	a3,ffffffffc0206854 <do_execve+0x4f2>
ffffffffc0206850:	004ded93          	ori	s11,s11,4
ffffffffc0206854:	8b05                	andi	a4,a4,1
ffffffffc0206856:	c319                	beqz	a4,ffffffffc020685c <do_execve+0x4fa>
ffffffffc0206858:	008ded93          	ori	s11,s11,8
ffffffffc020685c:	eda47ce3          	bgeu	s0,s10,ffffffffc0206734 <do_execve+0x3d2>
ffffffffc0206860:	0189b503          	ld	a0,24(s3)
ffffffffc0206864:	866e                	mv	a2,s11
ffffffffc0206866:	85a2                	mv	a1,s0
ffffffffc0206868:	a18fd0ef          	jal	ra,ffffffffc0203a80 <pgdir_alloc_page>
ffffffffc020686c:	c51d                	beqz	a0,ffffffffc020689a <do_execve+0x538>
ffffffffc020686e:	000cb703          	ld	a4,0(s9)
ffffffffc0206872:	000c3783          	ld	a5,0(s8)
ffffffffc0206876:	8d19                	sub	a0,a0,a4
ffffffffc0206878:	6702                	ld	a4,0(sp)
ffffffffc020687a:	8519                	srai	a0,a0,0x6
ffffffffc020687c:	955a                	add	a0,a0,s6
ffffffffc020687e:	8f69                	and	a4,a4,a0
ffffffffc0206880:	0532                	slli	a0,a0,0xc
ffffffffc0206882:	04f77763          	bgeu	a4,a5,ffffffffc02068d0 <do_execve+0x56e>
ffffffffc0206886:	000bb783          	ld	a5,0(s7)
ffffffffc020688a:	6605                	lui	a2,0x1
ffffffffc020688c:	4581                	li	a1,0
ffffffffc020688e:	953e                	add	a0,a0,a5
ffffffffc0206890:	6785                	lui	a5,0x1
ffffffffc0206892:	943e                	add	s0,s0,a5
ffffffffc0206894:	1bd040ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0206898:	b7d1                	j	ffffffffc020685c <do_execve+0x4fa>
ffffffffc020689a:	6442                	ld	s0,16(sp)
ffffffffc020689c:	4a72                	lw	s4,28(sp)
ffffffffc020689e:	5d71                	li	s10,-4
ffffffffc02068a0:	b959                	j	ffffffffc0206536 <do_execve+0x1d4>
ffffffffc02068a2:	5d75                	li	s10,-3
ffffffffc02068a4:	bb61                	j	ffffffffc020663c <do_execve+0x2da>
ffffffffc02068a6:	854e                	mv	a0,s3
ffffffffc02068a8:	c0cfd0ef          	jal	ra,ffffffffc0203cb4 <mm_destroy>
ffffffffc02068ac:	5af1                	li	s5,-4
ffffffffc02068ae:	b1e5                	j	ffffffffc0206596 <do_execve+0x234>
ffffffffc02068b0:	5d75                	li	s10,-3
ffffffffc02068b2:	d60b9fe3          	bnez	s7,ffffffffc0206630 <do_execve+0x2ce>
ffffffffc02068b6:	b359                	j	ffffffffc020663c <do_execve+0x2da>
ffffffffc02068b8:	64a6                	ld	s1,72(sp)
ffffffffc02068ba:	bbe5                	j	ffffffffc02066b2 <do_execve+0x350>
ffffffffc02068bc:	fe0b83e3          	beqz	s7,ffffffffc02068a2 <do_execve+0x540>
ffffffffc02068c0:	038b8513          	addi	a0,s7,56
ffffffffc02068c4:	bfbfd0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02068c8:	5d75                	li	s10,-3
ffffffffc02068ca:	040ba823          	sw	zero,80(s7)
ffffffffc02068ce:	b3bd                	j	ffffffffc020663c <do_execve+0x2da>
ffffffffc02068d0:	86aa                	mv	a3,a0
ffffffffc02068d2:	00006617          	auipc	a2,0x6
ffffffffc02068d6:	98660613          	addi	a2,a2,-1658 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc02068da:	07100593          	li	a1,113
ffffffffc02068de:	00006517          	auipc	a0,0x6
ffffffffc02068e2:	9a250513          	addi	a0,a0,-1630 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc02068e6:	bb9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02068ea:	0309a783          	lw	a5,48(s3)
ffffffffc02068ee:	00093583          	ld	a1,0(s2)
ffffffffc02068f2:	0189b683          	ld	a3,24(s3)
ffffffffc02068f6:	2785                	addiw	a5,a5,1
ffffffffc02068f8:	02f9a823          	sw	a5,48(s3)
ffffffffc02068fc:	0335b423          	sd	s3,40(a1) # 7ff00028 <_binary_bin_sfs_img_size+0x7fe8ad28>
ffffffffc0206900:	c02007b7          	lui	a5,0xc0200
ffffffffc0206904:	12f6e063          	bltu	a3,a5,ffffffffc0206a24 <do_execve+0x6c2>
ffffffffc0206908:	000bb603          	ld	a2,0(s7)
ffffffffc020690c:	57fd                	li	a5,-1
ffffffffc020690e:	17fe                	slli	a5,a5,0x3f
ffffffffc0206910:	8e91                	sub	a3,a3,a2
ffffffffc0206912:	00c6d613          	srli	a2,a3,0xc
ffffffffc0206916:	f5d4                	sd	a3,168(a1)
ffffffffc0206918:	8fd1                	or	a5,a5,a2
ffffffffc020691a:	18079073          	csrw	satp,a5
ffffffffc020691e:	12000073          	sfence.vma
ffffffffc0206922:	67a2                	ld	a5,8(sp)
ffffffffc0206924:	1a02                	slli	s4,s4,0x20
ffffffffc0206926:	1918                	addi	a4,sp,176
ffffffffc0206928:	ff878b13          	addi	s6,a5,-8 # ffffffffc01ffff8 <_binary_bin_sfs_img_size+0xffffffffc018acf8>
ffffffffc020692c:	0a010b93          	addi	s7,sp,160
ffffffffc0206930:	020a5a13          	srli	s4,s4,0x20
ffffffffc0206934:	00fb8ab3          	add	s5,s7,a5
ffffffffc0206938:	01670c33          	add	s8,a4,s6
ffffffffc020693c:	003a1793          	slli	a5,s4,0x3
ffffffffc0206940:	1b18                	addi	a4,sp,432
ffffffffc0206942:	9b3a                	add	s6,s6,a4
ffffffffc0206944:	40fa8ab3          	sub	s5,s5,a5
ffffffffc0206948:	000c3c83          	ld	s9,0(s8)
ffffffffc020694c:	8566                	mv	a0,s9
ffffffffc020694e:	061040ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc0206952:	00150693          	addi	a3,a0,1
ffffffffc0206956:	40dd8db3          	sub	s11,s11,a3
ffffffffc020695a:	8666                	mv	a2,s9
ffffffffc020695c:	85ee                	mv	a1,s11
ffffffffc020695e:	854e                	mv	a0,s3
ffffffffc0206960:	959fd0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc0206964:	cd55                	beqz	a0,ffffffffc0206a20 <do_execve+0x6be>
ffffffffc0206966:	01bb3023          	sd	s11,0(s6)
ffffffffc020696a:	1c61                	addi	s8,s8,-8
ffffffffc020696c:	1b61                	addi	s6,s6,-8
ffffffffc020696e:	fd8a9de3          	bne	s5,s8,ffffffffc0206948 <do_execve+0x5e6>
ffffffffc0206972:	67a2                	ld	a5,8(sp)
ffffffffc0206974:	ff8df713          	andi	a4,s11,-8
ffffffffc0206978:	1b010c13          	addi	s8,sp,432
ffffffffc020697c:	00878b13          	addi	s6,a5,8
ffffffffc0206980:	41670b33          	sub	s6,a4,s6
ffffffffc0206984:	4c81                	li	s9,0
ffffffffc0206986:	418b0db3          	sub	s11,s6,s8
ffffffffc020698a:	a011                	j	ffffffffc020698e <do_execve+0x62c>
ffffffffc020698c:	8cbe                	mv	s9,a5
ffffffffc020698e:	46a1                	li	a3,8
ffffffffc0206990:	8662                	mv	a2,s8
ffffffffc0206992:	018d85b3          	add	a1,s11,s8
ffffffffc0206996:	854e                	mv	a0,s3
ffffffffc0206998:	921fd0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc020699c:	c151                	beqz	a0,ffffffffc0206a20 <do_execve+0x6be>
ffffffffc020699e:	001c879b          	addiw	a5,s9,1
ffffffffc02069a2:	0c21                	addi	s8,s8,8
ffffffffc02069a4:	fe9cc4e3          	blt	s9,s1,ffffffffc020698c <do_execve+0x62a>
ffffffffc02069a8:	67a2                	ld	a5,8(sp)
ffffffffc02069aa:	46a1                	li	a3,8
ffffffffc02069ac:	08b0                	addi	a2,sp,88
ffffffffc02069ae:	016785b3          	add	a1,a5,s6
ffffffffc02069b2:	854e                	mv	a0,s3
ffffffffc02069b4:	ec82                	sd	zero,88(sp)
ffffffffc02069b6:	903fd0ef          	jal	ra,ffffffffc02042b8 <copy_to_user>
ffffffffc02069ba:	c13d                	beqz	a0,ffffffffc0206a20 <do_execve+0x6be>
ffffffffc02069bc:	00093783          	ld	a5,0(s2)
ffffffffc02069c0:	12000613          	li	a2,288
ffffffffc02069c4:	4581                	li	a1,0
ffffffffc02069c6:	73c4                	ld	s1,160(a5)
ffffffffc02069c8:	8526                	mv	a0,s1
ffffffffc02069ca:	087040ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc02069ce:	67aa                	ld	a5,136(sp)
ffffffffc02069d0:	e8a0                	sd	s0,80(s1)
ffffffffc02069d2:	0164b823          	sd	s6,16(s1)
ffffffffc02069d6:	0564bc23          	sd	s6,88(s1)
ffffffffc02069da:	10f4b423          	sd	a5,264(s1)
ffffffffc02069de:	100027f3          	csrr	a5,sstatus
ffffffffc02069e2:	edd7f793          	andi	a5,a5,-291
ffffffffc02069e6:	0207e793          	ori	a5,a5,32
ffffffffc02069ea:	147d                	addi	s0,s0,-1
ffffffffc02069ec:	040e                	slli	s0,s0,0x3
ffffffffc02069ee:	10f4b023          	sd	a5,256(s1)
ffffffffc02069f2:	191c                	addi	a5,sp,176
ffffffffc02069f4:	943e                	add	s0,s0,a5
ffffffffc02069f6:	6008                	ld	a0,0(s0)
ffffffffc02069f8:	1461                	addi	s0,s0,-8
ffffffffc02069fa:	e44fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02069fe:	fe8a9ce3          	bne	s5,s0,ffffffffc02069f6 <do_execve+0x694>
ffffffffc0206a02:	00093403          	ld	s0,0(s2)
ffffffffc0206a06:	4641                	li	a2,16
ffffffffc0206a08:	4581                	li	a1,0
ffffffffc0206a0a:	0b440413          	addi	s0,s0,180
ffffffffc0206a0e:	8522                	mv	a0,s0
ffffffffc0206a10:	041040ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0206a14:	463d                	li	a2,15
ffffffffc0206a16:	108c                	addi	a1,sp,96
ffffffffc0206a18:	8522                	mv	a0,s0
ffffffffc0206a1a:	089040ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0206a1e:	b939                	j	ffffffffc020663c <do_execve+0x2da>
ffffffffc0206a20:	5d75                	li	s10,-3
ffffffffc0206a22:	be39                	j	ffffffffc0206540 <do_execve+0x1de>
ffffffffc0206a24:	00006617          	auipc	a2,0x6
ffffffffc0206a28:	8dc60613          	addi	a2,a2,-1828 # ffffffffc020c300 <default_pmm_manager+0xe0>
ffffffffc0206a2c:	33900593          	li	a1,825
ffffffffc0206a30:	00006517          	auipc	a0,0x6
ffffffffc0206a34:	7f850513          	addi	a0,a0,2040 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206a38:	a67f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206a3c:	86be                	mv	a3,a5
ffffffffc0206a3e:	00006617          	auipc	a2,0x6
ffffffffc0206a42:	81a60613          	addi	a2,a2,-2022 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc0206a46:	07100593          	li	a1,113
ffffffffc0206a4a:	00006517          	auipc	a0,0x6
ffffffffc0206a4e:	83650513          	addi	a0,a0,-1994 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0206a52:	a4df90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206a56:	86a6                	mv	a3,s1
ffffffffc0206a58:	00006617          	auipc	a2,0x6
ffffffffc0206a5c:	80060613          	addi	a2,a2,-2048 # ffffffffc020c258 <default_pmm_manager+0x38>
ffffffffc0206a60:	07100593          	li	a1,113
ffffffffc0206a64:	00006517          	auipc	a0,0x6
ffffffffc0206a68:	81c50513          	addi	a0,a0,-2020 # ffffffffc020c280 <default_pmm_manager+0x60>
ffffffffc0206a6c:	a33f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206a70:	f6bfe0ef          	jal	ra,ffffffffc02059da <pa2page.part.0>
ffffffffc0206a74:	00007697          	auipc	a3,0x7
ffffffffc0206a78:	9a468693          	addi	a3,a3,-1628 # ffffffffc020d418 <CSWTCH.79+0x2e0>
ffffffffc0206a7c:	00005617          	auipc	a2,0x5
ffffffffc0206a80:	cbc60613          	addi	a2,a2,-836 # ffffffffc020b738 <commands+0x210>
ffffffffc0206a84:	31900593          	li	a1,793
ffffffffc0206a88:	00006517          	auipc	a0,0x6
ffffffffc0206a8c:	7a050513          	addi	a0,a0,1952 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206a90:	a0ff90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206a94 <user_main>:
ffffffffc0206a94:	7179                	addi	sp,sp,-48
ffffffffc0206a96:	e84a                	sd	s2,16(sp)
ffffffffc0206a98:	00090917          	auipc	s2,0x90
ffffffffc0206a9c:	e2890913          	addi	s2,s2,-472 # ffffffffc02968c0 <current>
ffffffffc0206aa0:	00093783          	ld	a5,0(s2)
ffffffffc0206aa4:	00007617          	auipc	a2,0x7
ffffffffc0206aa8:	99460613          	addi	a2,a2,-1644 # ffffffffc020d438 <CSWTCH.79+0x300>
ffffffffc0206aac:	00007517          	auipc	a0,0x7
ffffffffc0206ab0:	99450513          	addi	a0,a0,-1644 # ffffffffc020d440 <CSWTCH.79+0x308>
ffffffffc0206ab4:	43cc                	lw	a1,4(a5)
ffffffffc0206ab6:	f406                	sd	ra,40(sp)
ffffffffc0206ab8:	f022                	sd	s0,32(sp)
ffffffffc0206aba:	ec26                	sd	s1,24(sp)
ffffffffc0206abc:	e032                	sd	a2,0(sp)
ffffffffc0206abe:	e402                	sd	zero,8(sp)
ffffffffc0206ac0:	ee6f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206ac4:	6782                	ld	a5,0(sp)
ffffffffc0206ac6:	cfb9                	beqz	a5,ffffffffc0206b24 <user_main+0x90>
ffffffffc0206ac8:	003c                	addi	a5,sp,8
ffffffffc0206aca:	4401                	li	s0,0
ffffffffc0206acc:	6398                	ld	a4,0(a5)
ffffffffc0206ace:	0405                	addi	s0,s0,1
ffffffffc0206ad0:	07a1                	addi	a5,a5,8
ffffffffc0206ad2:	ff6d                	bnez	a4,ffffffffc0206acc <user_main+0x38>
ffffffffc0206ad4:	00093783          	ld	a5,0(s2)
ffffffffc0206ad8:	12000613          	li	a2,288
ffffffffc0206adc:	6b84                	ld	s1,16(a5)
ffffffffc0206ade:	73cc                	ld	a1,160(a5)
ffffffffc0206ae0:	6789                	lui	a5,0x2
ffffffffc0206ae2:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206ae6:	94be                	add	s1,s1,a5
ffffffffc0206ae8:	8526                	mv	a0,s1
ffffffffc0206aea:	7b8040ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0206aee:	00093783          	ld	a5,0(s2)
ffffffffc0206af2:	860a                	mv	a2,sp
ffffffffc0206af4:	0004059b          	sext.w	a1,s0
ffffffffc0206af8:	f3c4                	sd	s1,160(a5)
ffffffffc0206afa:	00007517          	auipc	a0,0x7
ffffffffc0206afe:	93e50513          	addi	a0,a0,-1730 # ffffffffc020d438 <CSWTCH.79+0x300>
ffffffffc0206b02:	861ff0ef          	jal	ra,ffffffffc0206362 <do_execve>
ffffffffc0206b06:	8126                	mv	sp,s1
ffffffffc0206b08:	f48fa06f          	j	ffffffffc0201250 <__trapret>
ffffffffc0206b0c:	00007617          	auipc	a2,0x7
ffffffffc0206b10:	95c60613          	addi	a2,a2,-1700 # ffffffffc020d468 <CSWTCH.79+0x330>
ffffffffc0206b14:	47d00593          	li	a1,1149
ffffffffc0206b18:	00006517          	auipc	a0,0x6
ffffffffc0206b1c:	71050513          	addi	a0,a0,1808 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206b20:	97ff90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b24:	4401                	li	s0,0
ffffffffc0206b26:	b77d                	j	ffffffffc0206ad4 <user_main+0x40>

ffffffffc0206b28 <do_yield>:
ffffffffc0206b28:	00090797          	auipc	a5,0x90
ffffffffc0206b2c:	d987b783          	ld	a5,-616(a5) # ffffffffc02968c0 <current>
ffffffffc0206b30:	4705                	li	a4,1
ffffffffc0206b32:	ef98                	sd	a4,24(a5)
ffffffffc0206b34:	4501                	li	a0,0
ffffffffc0206b36:	8082                	ret

ffffffffc0206b38 <do_wait>:
ffffffffc0206b38:	1101                	addi	sp,sp,-32
ffffffffc0206b3a:	e822                	sd	s0,16(sp)
ffffffffc0206b3c:	e426                	sd	s1,8(sp)
ffffffffc0206b3e:	ec06                	sd	ra,24(sp)
ffffffffc0206b40:	842e                	mv	s0,a1
ffffffffc0206b42:	84aa                	mv	s1,a0
ffffffffc0206b44:	c999                	beqz	a1,ffffffffc0206b5a <do_wait+0x22>
ffffffffc0206b46:	00090797          	auipc	a5,0x90
ffffffffc0206b4a:	d7a7b783          	ld	a5,-646(a5) # ffffffffc02968c0 <current>
ffffffffc0206b4e:	7788                	ld	a0,40(a5)
ffffffffc0206b50:	4685                	li	a3,1
ffffffffc0206b52:	4611                	li	a2,4
ffffffffc0206b54:	e9cfd0ef          	jal	ra,ffffffffc02041f0 <user_mem_check>
ffffffffc0206b58:	c909                	beqz	a0,ffffffffc0206b6a <do_wait+0x32>
ffffffffc0206b5a:	85a2                	mv	a1,s0
ffffffffc0206b5c:	6442                	ld	s0,16(sp)
ffffffffc0206b5e:	60e2                	ld	ra,24(sp)
ffffffffc0206b60:	8526                	mv	a0,s1
ffffffffc0206b62:	64a2                	ld	s1,8(sp)
ffffffffc0206b64:	6105                	addi	sp,sp,32
ffffffffc0206b66:	ceeff06f          	j	ffffffffc0206054 <do_wait.part.0>
ffffffffc0206b6a:	60e2                	ld	ra,24(sp)
ffffffffc0206b6c:	6442                	ld	s0,16(sp)
ffffffffc0206b6e:	64a2                	ld	s1,8(sp)
ffffffffc0206b70:	5575                	li	a0,-3
ffffffffc0206b72:	6105                	addi	sp,sp,32
ffffffffc0206b74:	8082                	ret

ffffffffc0206b76 <do_kill>:
ffffffffc0206b76:	1141                	addi	sp,sp,-16
ffffffffc0206b78:	6789                	lui	a5,0x2
ffffffffc0206b7a:	e406                	sd	ra,8(sp)
ffffffffc0206b7c:	e022                	sd	s0,0(sp)
ffffffffc0206b7e:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206b82:	17f9                	addi	a5,a5,-2
ffffffffc0206b84:	02e7e963          	bltu	a5,a4,ffffffffc0206bb6 <do_kill+0x40>
ffffffffc0206b88:	842a                	mv	s0,a0
ffffffffc0206b8a:	45a9                	li	a1,10
ffffffffc0206b8c:	2501                	sext.w	a0,a0
ffffffffc0206b8e:	18e040ef          	jal	ra,ffffffffc020ad1c <hash32>
ffffffffc0206b92:	02051793          	slli	a5,a0,0x20
ffffffffc0206b96:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206b9a:	0008b797          	auipc	a5,0x8b
ffffffffc0206b9e:	c2678793          	addi	a5,a5,-986 # ffffffffc02917c0 <hash_list>
ffffffffc0206ba2:	953e                	add	a0,a0,a5
ffffffffc0206ba4:	87aa                	mv	a5,a0
ffffffffc0206ba6:	a029                	j	ffffffffc0206bb0 <do_kill+0x3a>
ffffffffc0206ba8:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0206bac:	00870b63          	beq	a4,s0,ffffffffc0206bc2 <do_kill+0x4c>
ffffffffc0206bb0:	679c                	ld	a5,8(a5)
ffffffffc0206bb2:	fef51be3          	bne	a0,a5,ffffffffc0206ba8 <do_kill+0x32>
ffffffffc0206bb6:	5475                	li	s0,-3
ffffffffc0206bb8:	60a2                	ld	ra,8(sp)
ffffffffc0206bba:	8522                	mv	a0,s0
ffffffffc0206bbc:	6402                	ld	s0,0(sp)
ffffffffc0206bbe:	0141                	addi	sp,sp,16
ffffffffc0206bc0:	8082                	ret
ffffffffc0206bc2:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206bc6:	00177693          	andi	a3,a4,1
ffffffffc0206bca:	e295                	bnez	a3,ffffffffc0206bee <do_kill+0x78>
ffffffffc0206bcc:	4bd4                	lw	a3,20(a5)
ffffffffc0206bce:	00176713          	ori	a4,a4,1
ffffffffc0206bd2:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0206bd6:	4401                	li	s0,0
ffffffffc0206bd8:	fe06d0e3          	bgez	a3,ffffffffc0206bb8 <do_kill+0x42>
ffffffffc0206bdc:	f2878513          	addi	a0,a5,-216
ffffffffc0206be0:	45a000ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc0206be4:	60a2                	ld	ra,8(sp)
ffffffffc0206be6:	8522                	mv	a0,s0
ffffffffc0206be8:	6402                	ld	s0,0(sp)
ffffffffc0206bea:	0141                	addi	sp,sp,16
ffffffffc0206bec:	8082                	ret
ffffffffc0206bee:	545d                	li	s0,-9
ffffffffc0206bf0:	b7e1                	j	ffffffffc0206bb8 <do_kill+0x42>

ffffffffc0206bf2 <proc_init>:
ffffffffc0206bf2:	1101                	addi	sp,sp,-32
ffffffffc0206bf4:	e426                	sd	s1,8(sp)
ffffffffc0206bf6:	0008f797          	auipc	a5,0x8f
ffffffffc0206bfa:	bca78793          	addi	a5,a5,-1078 # ffffffffc02957c0 <proc_list>
ffffffffc0206bfe:	ec06                	sd	ra,24(sp)
ffffffffc0206c00:	e822                	sd	s0,16(sp)
ffffffffc0206c02:	e04a                	sd	s2,0(sp)
ffffffffc0206c04:	0008b497          	auipc	s1,0x8b
ffffffffc0206c08:	bbc48493          	addi	s1,s1,-1092 # ffffffffc02917c0 <hash_list>
ffffffffc0206c0c:	e79c                	sd	a5,8(a5)
ffffffffc0206c0e:	e39c                	sd	a5,0(a5)
ffffffffc0206c10:	0008f717          	auipc	a4,0x8f
ffffffffc0206c14:	bb070713          	addi	a4,a4,-1104 # ffffffffc02957c0 <proc_list>
ffffffffc0206c18:	87a6                	mv	a5,s1
ffffffffc0206c1a:	e79c                	sd	a5,8(a5)
ffffffffc0206c1c:	e39c                	sd	a5,0(a5)
ffffffffc0206c1e:	07c1                	addi	a5,a5,16
ffffffffc0206c20:	fef71de3          	bne	a4,a5,ffffffffc0206c1a <proc_init+0x28>
ffffffffc0206c24:	d0ffe0ef          	jal	ra,ffffffffc0205932 <alloc_proc>
ffffffffc0206c28:	00090917          	auipc	s2,0x90
ffffffffc0206c2c:	ca090913          	addi	s2,s2,-864 # ffffffffc02968c8 <idleproc>
ffffffffc0206c30:	00a93023          	sd	a0,0(s2)
ffffffffc0206c34:	842a                	mv	s0,a0
ffffffffc0206c36:	12050863          	beqz	a0,ffffffffc0206d66 <proc_init+0x174>
ffffffffc0206c3a:	4789                	li	a5,2
ffffffffc0206c3c:	e11c                	sd	a5,0(a0)
ffffffffc0206c3e:	0000a797          	auipc	a5,0xa
ffffffffc0206c42:	3c278793          	addi	a5,a5,962 # ffffffffc0211000 <bootstack>
ffffffffc0206c46:	e91c                	sd	a5,16(a0)
ffffffffc0206c48:	4785                	li	a5,1
ffffffffc0206c4a:	ed1c                	sd	a5,24(a0)
ffffffffc0206c4c:	ce0fe0ef          	jal	ra,ffffffffc020512c <files_create>
ffffffffc0206c50:	14a43423          	sd	a0,328(s0)
ffffffffc0206c54:	0e050d63          	beqz	a0,ffffffffc0206d4e <proc_init+0x15c>
ffffffffc0206c58:	00093403          	ld	s0,0(s2)
ffffffffc0206c5c:	4641                	li	a2,16
ffffffffc0206c5e:	4581                	li	a1,0
ffffffffc0206c60:	14843703          	ld	a4,328(s0)
ffffffffc0206c64:	0b440413          	addi	s0,s0,180
ffffffffc0206c68:	8522                	mv	a0,s0
ffffffffc0206c6a:	4b1c                	lw	a5,16(a4)
ffffffffc0206c6c:	2785                	addiw	a5,a5,1
ffffffffc0206c6e:	cb1c                	sw	a5,16(a4)
ffffffffc0206c70:	5e0040ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0206c74:	463d                	li	a2,15
ffffffffc0206c76:	00007597          	auipc	a1,0x7
ffffffffc0206c7a:	85258593          	addi	a1,a1,-1966 # ffffffffc020d4c8 <CSWTCH.79+0x390>
ffffffffc0206c7e:	8522                	mv	a0,s0
ffffffffc0206c80:	622040ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0206c84:	00090717          	auipc	a4,0x90
ffffffffc0206c88:	c5470713          	addi	a4,a4,-940 # ffffffffc02968d8 <nr_process>
ffffffffc0206c8c:	431c                	lw	a5,0(a4)
ffffffffc0206c8e:	00093683          	ld	a3,0(s2)
ffffffffc0206c92:	4601                	li	a2,0
ffffffffc0206c94:	2785                	addiw	a5,a5,1
ffffffffc0206c96:	4581                	li	a1,0
ffffffffc0206c98:	fffff517          	auipc	a0,0xfffff
ffffffffc0206c9c:	57a50513          	addi	a0,a0,1402 # ffffffffc0206212 <init_main>
ffffffffc0206ca0:	c31c                	sw	a5,0(a4)
ffffffffc0206ca2:	00090797          	auipc	a5,0x90
ffffffffc0206ca6:	c0d7bf23          	sd	a3,-994(a5) # ffffffffc02968c0 <current>
ffffffffc0206caa:	9f8ff0ef          	jal	ra,ffffffffc0205ea2 <kernel_thread>
ffffffffc0206cae:	842a                	mv	s0,a0
ffffffffc0206cb0:	08a05363          	blez	a0,ffffffffc0206d36 <proc_init+0x144>
ffffffffc0206cb4:	6789                	lui	a5,0x2
ffffffffc0206cb6:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206cba:	17f9                	addi	a5,a5,-2
ffffffffc0206cbc:	2501                	sext.w	a0,a0
ffffffffc0206cbe:	02e7e363          	bltu	a5,a4,ffffffffc0206ce4 <proc_init+0xf2>
ffffffffc0206cc2:	45a9                	li	a1,10
ffffffffc0206cc4:	058040ef          	jal	ra,ffffffffc020ad1c <hash32>
ffffffffc0206cc8:	02051793          	slli	a5,a0,0x20
ffffffffc0206ccc:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0206cd0:	96a6                	add	a3,a3,s1
ffffffffc0206cd2:	87b6                	mv	a5,a3
ffffffffc0206cd4:	a029                	j	ffffffffc0206cde <proc_init+0xec>
ffffffffc0206cd6:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0206cda:	04870b63          	beq	a4,s0,ffffffffc0206d30 <proc_init+0x13e>
ffffffffc0206cde:	679c                	ld	a5,8(a5)
ffffffffc0206ce0:	fef69be3          	bne	a3,a5,ffffffffc0206cd6 <proc_init+0xe4>
ffffffffc0206ce4:	4781                	li	a5,0
ffffffffc0206ce6:	0b478493          	addi	s1,a5,180
ffffffffc0206cea:	4641                	li	a2,16
ffffffffc0206cec:	4581                	li	a1,0
ffffffffc0206cee:	00090417          	auipc	s0,0x90
ffffffffc0206cf2:	be240413          	addi	s0,s0,-1054 # ffffffffc02968d0 <initproc>
ffffffffc0206cf6:	8526                	mv	a0,s1
ffffffffc0206cf8:	e01c                	sd	a5,0(s0)
ffffffffc0206cfa:	556040ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0206cfe:	463d                	li	a2,15
ffffffffc0206d00:	00006597          	auipc	a1,0x6
ffffffffc0206d04:	7f058593          	addi	a1,a1,2032 # ffffffffc020d4f0 <CSWTCH.79+0x3b8>
ffffffffc0206d08:	8526                	mv	a0,s1
ffffffffc0206d0a:	598040ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc0206d0e:	00093783          	ld	a5,0(s2)
ffffffffc0206d12:	c7d1                	beqz	a5,ffffffffc0206d9e <proc_init+0x1ac>
ffffffffc0206d14:	43dc                	lw	a5,4(a5)
ffffffffc0206d16:	e7c1                	bnez	a5,ffffffffc0206d9e <proc_init+0x1ac>
ffffffffc0206d18:	601c                	ld	a5,0(s0)
ffffffffc0206d1a:	c3b5                	beqz	a5,ffffffffc0206d7e <proc_init+0x18c>
ffffffffc0206d1c:	43d8                	lw	a4,4(a5)
ffffffffc0206d1e:	4785                	li	a5,1
ffffffffc0206d20:	04f71f63          	bne	a4,a5,ffffffffc0206d7e <proc_init+0x18c>
ffffffffc0206d24:	60e2                	ld	ra,24(sp)
ffffffffc0206d26:	6442                	ld	s0,16(sp)
ffffffffc0206d28:	64a2                	ld	s1,8(sp)
ffffffffc0206d2a:	6902                	ld	s2,0(sp)
ffffffffc0206d2c:	6105                	addi	sp,sp,32
ffffffffc0206d2e:	8082                	ret
ffffffffc0206d30:	f2878793          	addi	a5,a5,-216
ffffffffc0206d34:	bf4d                	j	ffffffffc0206ce6 <proc_init+0xf4>
ffffffffc0206d36:	00006617          	auipc	a2,0x6
ffffffffc0206d3a:	79a60613          	addi	a2,a2,1946 # ffffffffc020d4d0 <CSWTCH.79+0x398>
ffffffffc0206d3e:	4c900593          	li	a1,1225
ffffffffc0206d42:	00006517          	auipc	a0,0x6
ffffffffc0206d46:	4e650513          	addi	a0,a0,1254 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206d4a:	f54f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d4e:	00006617          	auipc	a2,0x6
ffffffffc0206d52:	75260613          	addi	a2,a2,1874 # ffffffffc020d4a0 <CSWTCH.79+0x368>
ffffffffc0206d56:	4bd00593          	li	a1,1213
ffffffffc0206d5a:	00006517          	auipc	a0,0x6
ffffffffc0206d5e:	4ce50513          	addi	a0,a0,1230 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206d62:	f3cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d66:	00006617          	auipc	a2,0x6
ffffffffc0206d6a:	72260613          	addi	a2,a2,1826 # ffffffffc020d488 <CSWTCH.79+0x350>
ffffffffc0206d6e:	4b300593          	li	a1,1203
ffffffffc0206d72:	00006517          	auipc	a0,0x6
ffffffffc0206d76:	4b650513          	addi	a0,a0,1206 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206d7a:	f24f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d7e:	00006697          	auipc	a3,0x6
ffffffffc0206d82:	7a268693          	addi	a3,a3,1954 # ffffffffc020d520 <CSWTCH.79+0x3e8>
ffffffffc0206d86:	00005617          	auipc	a2,0x5
ffffffffc0206d8a:	9b260613          	addi	a2,a2,-1614 # ffffffffc020b738 <commands+0x210>
ffffffffc0206d8e:	4d000593          	li	a1,1232
ffffffffc0206d92:	00006517          	auipc	a0,0x6
ffffffffc0206d96:	49650513          	addi	a0,a0,1174 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206d9a:	f04f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d9e:	00006697          	auipc	a3,0x6
ffffffffc0206da2:	75a68693          	addi	a3,a3,1882 # ffffffffc020d4f8 <CSWTCH.79+0x3c0>
ffffffffc0206da6:	00005617          	auipc	a2,0x5
ffffffffc0206daa:	99260613          	addi	a2,a2,-1646 # ffffffffc020b738 <commands+0x210>
ffffffffc0206dae:	4cf00593          	li	a1,1231
ffffffffc0206db2:	00006517          	auipc	a0,0x6
ffffffffc0206db6:	47650513          	addi	a0,a0,1142 # ffffffffc020d228 <CSWTCH.79+0xf0>
ffffffffc0206dba:	ee4f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206dbe <cpu_idle>:
ffffffffc0206dbe:	1141                	addi	sp,sp,-16
ffffffffc0206dc0:	e022                	sd	s0,0(sp)
ffffffffc0206dc2:	e406                	sd	ra,8(sp)
ffffffffc0206dc4:	00090417          	auipc	s0,0x90
ffffffffc0206dc8:	afc40413          	addi	s0,s0,-1284 # ffffffffc02968c0 <current>
ffffffffc0206dcc:	6018                	ld	a4,0(s0)
ffffffffc0206dce:	6f1c                	ld	a5,24(a4)
ffffffffc0206dd0:	dffd                	beqz	a5,ffffffffc0206dce <cpu_idle+0x10>
ffffffffc0206dd2:	31a000ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc0206dd6:	bfdd                	j	ffffffffc0206dcc <cpu_idle+0xe>

ffffffffc0206dd8 <lab6_set_priority>:
ffffffffc0206dd8:	1141                	addi	sp,sp,-16
ffffffffc0206dda:	e022                	sd	s0,0(sp)
ffffffffc0206ddc:	85aa                	mv	a1,a0
ffffffffc0206dde:	842a                	mv	s0,a0
ffffffffc0206de0:	00006517          	auipc	a0,0x6
ffffffffc0206de4:	76850513          	addi	a0,a0,1896 # ffffffffc020d548 <CSWTCH.79+0x410>
ffffffffc0206de8:	e406                	sd	ra,8(sp)
ffffffffc0206dea:	bbcf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206dee:	00090797          	auipc	a5,0x90
ffffffffc0206df2:	ad27b783          	ld	a5,-1326(a5) # ffffffffc02968c0 <current>
ffffffffc0206df6:	e801                	bnez	s0,ffffffffc0206e06 <lab6_set_priority+0x2e>
ffffffffc0206df8:	60a2                	ld	ra,8(sp)
ffffffffc0206dfa:	6402                	ld	s0,0(sp)
ffffffffc0206dfc:	4705                	li	a4,1
ffffffffc0206dfe:	14e7a223          	sw	a4,324(a5)
ffffffffc0206e02:	0141                	addi	sp,sp,16
ffffffffc0206e04:	8082                	ret
ffffffffc0206e06:	60a2                	ld	ra,8(sp)
ffffffffc0206e08:	1487a223          	sw	s0,324(a5)
ffffffffc0206e0c:	6402                	ld	s0,0(sp)
ffffffffc0206e0e:	0141                	addi	sp,sp,16
ffffffffc0206e10:	8082                	ret

ffffffffc0206e12 <do_sleep>:
ffffffffc0206e12:	c539                	beqz	a0,ffffffffc0206e60 <do_sleep+0x4e>
ffffffffc0206e14:	7179                	addi	sp,sp,-48
ffffffffc0206e16:	f022                	sd	s0,32(sp)
ffffffffc0206e18:	f406                	sd	ra,40(sp)
ffffffffc0206e1a:	842a                	mv	s0,a0
ffffffffc0206e1c:	100027f3          	csrr	a5,sstatus
ffffffffc0206e20:	8b89                	andi	a5,a5,2
ffffffffc0206e22:	e3a9                	bnez	a5,ffffffffc0206e64 <do_sleep+0x52>
ffffffffc0206e24:	00090797          	auipc	a5,0x90
ffffffffc0206e28:	a9c7b783          	ld	a5,-1380(a5) # ffffffffc02968c0 <current>
ffffffffc0206e2c:	0818                	addi	a4,sp,16
ffffffffc0206e2e:	c02a                	sw	a0,0(sp)
ffffffffc0206e30:	ec3a                	sd	a4,24(sp)
ffffffffc0206e32:	e83a                	sd	a4,16(sp)
ffffffffc0206e34:	e43e                	sd	a5,8(sp)
ffffffffc0206e36:	4705                	li	a4,1
ffffffffc0206e38:	c398                	sw	a4,0(a5)
ffffffffc0206e3a:	80000737          	lui	a4,0x80000
ffffffffc0206e3e:	840a                	mv	s0,sp
ffffffffc0206e40:	0709                	addi	a4,a4,2
ffffffffc0206e42:	0ee7a623          	sw	a4,236(a5)
ffffffffc0206e46:	8522                	mv	a0,s0
ffffffffc0206e48:	364000ef          	jal	ra,ffffffffc02071ac <add_timer>
ffffffffc0206e4c:	2a0000ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc0206e50:	8522                	mv	a0,s0
ffffffffc0206e52:	422000ef          	jal	ra,ffffffffc0207274 <del_timer>
ffffffffc0206e56:	70a2                	ld	ra,40(sp)
ffffffffc0206e58:	7402                	ld	s0,32(sp)
ffffffffc0206e5a:	4501                	li	a0,0
ffffffffc0206e5c:	6145                	addi	sp,sp,48
ffffffffc0206e5e:	8082                	ret
ffffffffc0206e60:	4501                	li	a0,0
ffffffffc0206e62:	8082                	ret
ffffffffc0206e64:	e0ff90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206e68:	00090797          	auipc	a5,0x90
ffffffffc0206e6c:	a587b783          	ld	a5,-1448(a5) # ffffffffc02968c0 <current>
ffffffffc0206e70:	0818                	addi	a4,sp,16
ffffffffc0206e72:	c022                	sw	s0,0(sp)
ffffffffc0206e74:	e43e                	sd	a5,8(sp)
ffffffffc0206e76:	ec3a                	sd	a4,24(sp)
ffffffffc0206e78:	e83a                	sd	a4,16(sp)
ffffffffc0206e7a:	4705                	li	a4,1
ffffffffc0206e7c:	c398                	sw	a4,0(a5)
ffffffffc0206e7e:	80000737          	lui	a4,0x80000
ffffffffc0206e82:	0709                	addi	a4,a4,2
ffffffffc0206e84:	840a                	mv	s0,sp
ffffffffc0206e86:	8522                	mv	a0,s0
ffffffffc0206e88:	0ee7a623          	sw	a4,236(a5)
ffffffffc0206e8c:	320000ef          	jal	ra,ffffffffc02071ac <add_timer>
ffffffffc0206e90:	dddf90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206e94:	bf65                	j	ffffffffc0206e4c <do_sleep+0x3a>

ffffffffc0206e96 <switch_to>:
ffffffffc0206e96:	00153023          	sd	ra,0(a0)
ffffffffc0206e9a:	00253423          	sd	sp,8(a0)
ffffffffc0206e9e:	e900                	sd	s0,16(a0)
ffffffffc0206ea0:	ed04                	sd	s1,24(a0)
ffffffffc0206ea2:	03253023          	sd	s2,32(a0)
ffffffffc0206ea6:	03353423          	sd	s3,40(a0)
ffffffffc0206eaa:	03453823          	sd	s4,48(a0)
ffffffffc0206eae:	03553c23          	sd	s5,56(a0)
ffffffffc0206eb2:	05653023          	sd	s6,64(a0)
ffffffffc0206eb6:	05753423          	sd	s7,72(a0)
ffffffffc0206eba:	05853823          	sd	s8,80(a0)
ffffffffc0206ebe:	05953c23          	sd	s9,88(a0)
ffffffffc0206ec2:	07a53023          	sd	s10,96(a0)
ffffffffc0206ec6:	07b53423          	sd	s11,104(a0)
ffffffffc0206eca:	0005b083          	ld	ra,0(a1)
ffffffffc0206ece:	0085b103          	ld	sp,8(a1)
ffffffffc0206ed2:	6980                	ld	s0,16(a1)
ffffffffc0206ed4:	6d84                	ld	s1,24(a1)
ffffffffc0206ed6:	0205b903          	ld	s2,32(a1)
ffffffffc0206eda:	0285b983          	ld	s3,40(a1)
ffffffffc0206ede:	0305ba03          	ld	s4,48(a1)
ffffffffc0206ee2:	0385ba83          	ld	s5,56(a1)
ffffffffc0206ee6:	0405bb03          	ld	s6,64(a1)
ffffffffc0206eea:	0485bb83          	ld	s7,72(a1)
ffffffffc0206eee:	0505bc03          	ld	s8,80(a1)
ffffffffc0206ef2:	0585bc83          	ld	s9,88(a1)
ffffffffc0206ef6:	0605bd03          	ld	s10,96(a1)
ffffffffc0206efa:	0685bd83          	ld	s11,104(a1)
ffffffffc0206efe:	8082                	ret

ffffffffc0206f00 <RR_init>:
ffffffffc0206f00:	e508                	sd	a0,8(a0)
ffffffffc0206f02:	e108                	sd	a0,0(a0)
ffffffffc0206f04:	00052823          	sw	zero,16(a0)
ffffffffc0206f08:	8082                	ret

ffffffffc0206f0a <RR_pick_next>:
ffffffffc0206f0a:	651c                	ld	a5,8(a0)
ffffffffc0206f0c:	00f50563          	beq	a0,a5,ffffffffc0206f16 <RR_pick_next+0xc>
ffffffffc0206f10:	ef078513          	addi	a0,a5,-272
ffffffffc0206f14:	8082                	ret
ffffffffc0206f16:	4501                	li	a0,0
ffffffffc0206f18:	8082                	ret

ffffffffc0206f1a <RR_proc_tick>:
ffffffffc0206f1a:	1205a783          	lw	a5,288(a1)
ffffffffc0206f1e:	00f05563          	blez	a5,ffffffffc0206f28 <RR_proc_tick+0xe>
ffffffffc0206f22:	37fd                	addiw	a5,a5,-1
ffffffffc0206f24:	12f5a023          	sw	a5,288(a1)
ffffffffc0206f28:	e399                	bnez	a5,ffffffffc0206f2e <RR_proc_tick+0x14>
ffffffffc0206f2a:	4785                	li	a5,1
ffffffffc0206f2c:	ed9c                	sd	a5,24(a1)
ffffffffc0206f2e:	8082                	ret

ffffffffc0206f30 <RR_dequeue>:
ffffffffc0206f30:	1185b703          	ld	a4,280(a1)
ffffffffc0206f34:	11058793          	addi	a5,a1,272
ffffffffc0206f38:	02e78363          	beq	a5,a4,ffffffffc0206f5e <RR_dequeue+0x2e>
ffffffffc0206f3c:	1085b683          	ld	a3,264(a1)
ffffffffc0206f40:	00a69f63          	bne	a3,a0,ffffffffc0206f5e <RR_dequeue+0x2e>
ffffffffc0206f44:	1105b503          	ld	a0,272(a1)
ffffffffc0206f48:	4a90                	lw	a2,16(a3)
ffffffffc0206f4a:	e518                	sd	a4,8(a0)
ffffffffc0206f4c:	e308                	sd	a0,0(a4)
ffffffffc0206f4e:	10f5bc23          	sd	a5,280(a1)
ffffffffc0206f52:	10f5b823          	sd	a5,272(a1)
ffffffffc0206f56:	fff6079b          	addiw	a5,a2,-1
ffffffffc0206f5a:	ca9c                	sw	a5,16(a3)
ffffffffc0206f5c:	8082                	ret
ffffffffc0206f5e:	1141                	addi	sp,sp,-16
ffffffffc0206f60:	00006697          	auipc	a3,0x6
ffffffffc0206f64:	60068693          	addi	a3,a3,1536 # ffffffffc020d560 <CSWTCH.79+0x428>
ffffffffc0206f68:	00004617          	auipc	a2,0x4
ffffffffc0206f6c:	7d060613          	addi	a2,a2,2000 # ffffffffc020b738 <commands+0x210>
ffffffffc0206f70:	03c00593          	li	a1,60
ffffffffc0206f74:	00006517          	auipc	a0,0x6
ffffffffc0206f78:	62450513          	addi	a0,a0,1572 # ffffffffc020d598 <CSWTCH.79+0x460>
ffffffffc0206f7c:	e406                	sd	ra,8(sp)
ffffffffc0206f7e:	d20f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206f82 <RR_enqueue>:
ffffffffc0206f82:	1185b703          	ld	a4,280(a1)
ffffffffc0206f86:	11058793          	addi	a5,a1,272
ffffffffc0206f8a:	02e79d63          	bne	a5,a4,ffffffffc0206fc4 <RR_enqueue+0x42>
ffffffffc0206f8e:	6118                	ld	a4,0(a0)
ffffffffc0206f90:	1205a683          	lw	a3,288(a1)
ffffffffc0206f94:	e11c                	sd	a5,0(a0)
ffffffffc0206f96:	e71c                	sd	a5,8(a4)
ffffffffc0206f98:	10a5bc23          	sd	a0,280(a1)
ffffffffc0206f9c:	10e5b823          	sd	a4,272(a1)
ffffffffc0206fa0:	495c                	lw	a5,20(a0)
ffffffffc0206fa2:	ea89                	bnez	a3,ffffffffc0206fb4 <RR_enqueue+0x32>
ffffffffc0206fa4:	12f5a023          	sw	a5,288(a1)
ffffffffc0206fa8:	491c                	lw	a5,16(a0)
ffffffffc0206faa:	10a5b423          	sd	a0,264(a1)
ffffffffc0206fae:	2785                	addiw	a5,a5,1
ffffffffc0206fb0:	c91c                	sw	a5,16(a0)
ffffffffc0206fb2:	8082                	ret
ffffffffc0206fb4:	fed7c8e3          	blt	a5,a3,ffffffffc0206fa4 <RR_enqueue+0x22>
ffffffffc0206fb8:	491c                	lw	a5,16(a0)
ffffffffc0206fba:	10a5b423          	sd	a0,264(a1)
ffffffffc0206fbe:	2785                	addiw	a5,a5,1
ffffffffc0206fc0:	c91c                	sw	a5,16(a0)
ffffffffc0206fc2:	8082                	ret
ffffffffc0206fc4:	1141                	addi	sp,sp,-16
ffffffffc0206fc6:	00006697          	auipc	a3,0x6
ffffffffc0206fca:	5f268693          	addi	a3,a3,1522 # ffffffffc020d5b8 <CSWTCH.79+0x480>
ffffffffc0206fce:	00004617          	auipc	a2,0x4
ffffffffc0206fd2:	76a60613          	addi	a2,a2,1898 # ffffffffc020b738 <commands+0x210>
ffffffffc0206fd6:	02800593          	li	a1,40
ffffffffc0206fda:	00006517          	auipc	a0,0x6
ffffffffc0206fde:	5be50513          	addi	a0,a0,1470 # ffffffffc020d598 <CSWTCH.79+0x460>
ffffffffc0206fe2:	e406                	sd	ra,8(sp)
ffffffffc0206fe4:	cbaf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206fe8 <sched_init>:
ffffffffc0206fe8:	1141                	addi	sp,sp,-16
ffffffffc0206fea:	0008a717          	auipc	a4,0x8a
ffffffffc0206fee:	03670713          	addi	a4,a4,54 # ffffffffc0291020 <default_sched_class>
ffffffffc0206ff2:	e022                	sd	s0,0(sp)
ffffffffc0206ff4:	e406                	sd	ra,8(sp)
ffffffffc0206ff6:	0008e797          	auipc	a5,0x8e
ffffffffc0206ffa:	7fa78793          	addi	a5,a5,2042 # ffffffffc02957f0 <timer_list>
ffffffffc0206ffe:	6714                	ld	a3,8(a4)
ffffffffc0207000:	0008e517          	auipc	a0,0x8e
ffffffffc0207004:	7d050513          	addi	a0,a0,2000 # ffffffffc02957d0 <__rq>
ffffffffc0207008:	e79c                	sd	a5,8(a5)
ffffffffc020700a:	e39c                	sd	a5,0(a5)
ffffffffc020700c:	4795                	li	a5,5
ffffffffc020700e:	c95c                	sw	a5,20(a0)
ffffffffc0207010:	00090417          	auipc	s0,0x90
ffffffffc0207014:	8d840413          	addi	s0,s0,-1832 # ffffffffc02968e8 <sched_class>
ffffffffc0207018:	00090797          	auipc	a5,0x90
ffffffffc020701c:	8ca7b423          	sd	a0,-1848(a5) # ffffffffc02968e0 <rq>
ffffffffc0207020:	e018                	sd	a4,0(s0)
ffffffffc0207022:	9682                	jalr	a3
ffffffffc0207024:	601c                	ld	a5,0(s0)
ffffffffc0207026:	6402                	ld	s0,0(sp)
ffffffffc0207028:	60a2                	ld	ra,8(sp)
ffffffffc020702a:	638c                	ld	a1,0(a5)
ffffffffc020702c:	00006517          	auipc	a0,0x6
ffffffffc0207030:	5bc50513          	addi	a0,a0,1468 # ffffffffc020d5e8 <CSWTCH.79+0x4b0>
ffffffffc0207034:	0141                	addi	sp,sp,16
ffffffffc0207036:	970f906f          	j	ffffffffc02001a6 <cprintf>

ffffffffc020703a <wakeup_proc>:
ffffffffc020703a:	4118                	lw	a4,0(a0)
ffffffffc020703c:	1101                	addi	sp,sp,-32
ffffffffc020703e:	ec06                	sd	ra,24(sp)
ffffffffc0207040:	e822                	sd	s0,16(sp)
ffffffffc0207042:	e426                	sd	s1,8(sp)
ffffffffc0207044:	478d                	li	a5,3
ffffffffc0207046:	08f70363          	beq	a4,a5,ffffffffc02070cc <wakeup_proc+0x92>
ffffffffc020704a:	842a                	mv	s0,a0
ffffffffc020704c:	100027f3          	csrr	a5,sstatus
ffffffffc0207050:	8b89                	andi	a5,a5,2
ffffffffc0207052:	4481                	li	s1,0
ffffffffc0207054:	e7bd                	bnez	a5,ffffffffc02070c2 <wakeup_proc+0x88>
ffffffffc0207056:	4789                	li	a5,2
ffffffffc0207058:	04f70863          	beq	a4,a5,ffffffffc02070a8 <wakeup_proc+0x6e>
ffffffffc020705c:	c01c                	sw	a5,0(s0)
ffffffffc020705e:	0e042623          	sw	zero,236(s0)
ffffffffc0207062:	00090797          	auipc	a5,0x90
ffffffffc0207066:	85e7b783          	ld	a5,-1954(a5) # ffffffffc02968c0 <current>
ffffffffc020706a:	02878363          	beq	a5,s0,ffffffffc0207090 <wakeup_proc+0x56>
ffffffffc020706e:	00090797          	auipc	a5,0x90
ffffffffc0207072:	85a7b783          	ld	a5,-1958(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207076:	00f40d63          	beq	s0,a5,ffffffffc0207090 <wakeup_proc+0x56>
ffffffffc020707a:	00090797          	auipc	a5,0x90
ffffffffc020707e:	86e7b783          	ld	a5,-1938(a5) # ffffffffc02968e8 <sched_class>
ffffffffc0207082:	6b9c                	ld	a5,16(a5)
ffffffffc0207084:	85a2                	mv	a1,s0
ffffffffc0207086:	00090517          	auipc	a0,0x90
ffffffffc020708a:	85a53503          	ld	a0,-1958(a0) # ffffffffc02968e0 <rq>
ffffffffc020708e:	9782                	jalr	a5
ffffffffc0207090:	e491                	bnez	s1,ffffffffc020709c <wakeup_proc+0x62>
ffffffffc0207092:	60e2                	ld	ra,24(sp)
ffffffffc0207094:	6442                	ld	s0,16(sp)
ffffffffc0207096:	64a2                	ld	s1,8(sp)
ffffffffc0207098:	6105                	addi	sp,sp,32
ffffffffc020709a:	8082                	ret
ffffffffc020709c:	6442                	ld	s0,16(sp)
ffffffffc020709e:	60e2                	ld	ra,24(sp)
ffffffffc02070a0:	64a2                	ld	s1,8(sp)
ffffffffc02070a2:	6105                	addi	sp,sp,32
ffffffffc02070a4:	bc9f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02070a8:	00006617          	auipc	a2,0x6
ffffffffc02070ac:	59060613          	addi	a2,a2,1424 # ffffffffc020d638 <CSWTCH.79+0x500>
ffffffffc02070b0:	05200593          	li	a1,82
ffffffffc02070b4:	00006517          	auipc	a0,0x6
ffffffffc02070b8:	56c50513          	addi	a0,a0,1388 # ffffffffc020d620 <CSWTCH.79+0x4e8>
ffffffffc02070bc:	c4af90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02070c0:	bfc1                	j	ffffffffc0207090 <wakeup_proc+0x56>
ffffffffc02070c2:	bb1f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02070c6:	4018                	lw	a4,0(s0)
ffffffffc02070c8:	4485                	li	s1,1
ffffffffc02070ca:	b771                	j	ffffffffc0207056 <wakeup_proc+0x1c>
ffffffffc02070cc:	00006697          	auipc	a3,0x6
ffffffffc02070d0:	53468693          	addi	a3,a3,1332 # ffffffffc020d600 <CSWTCH.79+0x4c8>
ffffffffc02070d4:	00004617          	auipc	a2,0x4
ffffffffc02070d8:	66460613          	addi	a2,a2,1636 # ffffffffc020b738 <commands+0x210>
ffffffffc02070dc:	04300593          	li	a1,67
ffffffffc02070e0:	00006517          	auipc	a0,0x6
ffffffffc02070e4:	54050513          	addi	a0,a0,1344 # ffffffffc020d620 <CSWTCH.79+0x4e8>
ffffffffc02070e8:	bb6f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02070ec <schedule>:
ffffffffc02070ec:	7179                	addi	sp,sp,-48
ffffffffc02070ee:	f406                	sd	ra,40(sp)
ffffffffc02070f0:	f022                	sd	s0,32(sp)
ffffffffc02070f2:	ec26                	sd	s1,24(sp)
ffffffffc02070f4:	e84a                	sd	s2,16(sp)
ffffffffc02070f6:	e44e                	sd	s3,8(sp)
ffffffffc02070f8:	e052                	sd	s4,0(sp)
ffffffffc02070fa:	100027f3          	csrr	a5,sstatus
ffffffffc02070fe:	8b89                	andi	a5,a5,2
ffffffffc0207100:	4a01                	li	s4,0
ffffffffc0207102:	e3cd                	bnez	a5,ffffffffc02071a4 <schedule+0xb8>
ffffffffc0207104:	0008f497          	auipc	s1,0x8f
ffffffffc0207108:	7bc48493          	addi	s1,s1,1980 # ffffffffc02968c0 <current>
ffffffffc020710c:	608c                	ld	a1,0(s1)
ffffffffc020710e:	0008f997          	auipc	s3,0x8f
ffffffffc0207112:	7da98993          	addi	s3,s3,2010 # ffffffffc02968e8 <sched_class>
ffffffffc0207116:	0008f917          	auipc	s2,0x8f
ffffffffc020711a:	7ca90913          	addi	s2,s2,1994 # ffffffffc02968e0 <rq>
ffffffffc020711e:	4194                	lw	a3,0(a1)
ffffffffc0207120:	0005bc23          	sd	zero,24(a1)
ffffffffc0207124:	4709                	li	a4,2
ffffffffc0207126:	0009b783          	ld	a5,0(s3)
ffffffffc020712a:	00093503          	ld	a0,0(s2)
ffffffffc020712e:	04e68e63          	beq	a3,a4,ffffffffc020718a <schedule+0x9e>
ffffffffc0207132:	739c                	ld	a5,32(a5)
ffffffffc0207134:	9782                	jalr	a5
ffffffffc0207136:	842a                	mv	s0,a0
ffffffffc0207138:	c521                	beqz	a0,ffffffffc0207180 <schedule+0x94>
ffffffffc020713a:	0009b783          	ld	a5,0(s3)
ffffffffc020713e:	00093503          	ld	a0,0(s2)
ffffffffc0207142:	85a2                	mv	a1,s0
ffffffffc0207144:	6f9c                	ld	a5,24(a5)
ffffffffc0207146:	9782                	jalr	a5
ffffffffc0207148:	441c                	lw	a5,8(s0)
ffffffffc020714a:	6098                	ld	a4,0(s1)
ffffffffc020714c:	2785                	addiw	a5,a5,1
ffffffffc020714e:	c41c                	sw	a5,8(s0)
ffffffffc0207150:	00870563          	beq	a4,s0,ffffffffc020715a <schedule+0x6e>
ffffffffc0207154:	8522                	mv	a0,s0
ffffffffc0207156:	903fe0ef          	jal	ra,ffffffffc0205a58 <proc_run>
ffffffffc020715a:	000a1a63          	bnez	s4,ffffffffc020716e <schedule+0x82>
ffffffffc020715e:	70a2                	ld	ra,40(sp)
ffffffffc0207160:	7402                	ld	s0,32(sp)
ffffffffc0207162:	64e2                	ld	s1,24(sp)
ffffffffc0207164:	6942                	ld	s2,16(sp)
ffffffffc0207166:	69a2                	ld	s3,8(sp)
ffffffffc0207168:	6a02                	ld	s4,0(sp)
ffffffffc020716a:	6145                	addi	sp,sp,48
ffffffffc020716c:	8082                	ret
ffffffffc020716e:	7402                	ld	s0,32(sp)
ffffffffc0207170:	70a2                	ld	ra,40(sp)
ffffffffc0207172:	64e2                	ld	s1,24(sp)
ffffffffc0207174:	6942                	ld	s2,16(sp)
ffffffffc0207176:	69a2                	ld	s3,8(sp)
ffffffffc0207178:	6a02                	ld	s4,0(sp)
ffffffffc020717a:	6145                	addi	sp,sp,48
ffffffffc020717c:	af1f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207180:	0008f417          	auipc	s0,0x8f
ffffffffc0207184:	74843403          	ld	s0,1864(s0) # ffffffffc02968c8 <idleproc>
ffffffffc0207188:	b7c1                	j	ffffffffc0207148 <schedule+0x5c>
ffffffffc020718a:	0008f717          	auipc	a4,0x8f
ffffffffc020718e:	73e73703          	ld	a4,1854(a4) # ffffffffc02968c8 <idleproc>
ffffffffc0207192:	fae580e3          	beq	a1,a4,ffffffffc0207132 <schedule+0x46>
ffffffffc0207196:	6b9c                	ld	a5,16(a5)
ffffffffc0207198:	9782                	jalr	a5
ffffffffc020719a:	0009b783          	ld	a5,0(s3)
ffffffffc020719e:	00093503          	ld	a0,0(s2)
ffffffffc02071a2:	bf41                	j	ffffffffc0207132 <schedule+0x46>
ffffffffc02071a4:	acff90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02071a8:	4a05                	li	s4,1
ffffffffc02071aa:	bfa9                	j	ffffffffc0207104 <schedule+0x18>

ffffffffc02071ac <add_timer>:
ffffffffc02071ac:	1141                	addi	sp,sp,-16
ffffffffc02071ae:	e022                	sd	s0,0(sp)
ffffffffc02071b0:	e406                	sd	ra,8(sp)
ffffffffc02071b2:	842a                	mv	s0,a0
ffffffffc02071b4:	100027f3          	csrr	a5,sstatus
ffffffffc02071b8:	8b89                	andi	a5,a5,2
ffffffffc02071ba:	4501                	li	a0,0
ffffffffc02071bc:	eba5                	bnez	a5,ffffffffc020722c <add_timer+0x80>
ffffffffc02071be:	401c                	lw	a5,0(s0)
ffffffffc02071c0:	cbb5                	beqz	a5,ffffffffc0207234 <add_timer+0x88>
ffffffffc02071c2:	6418                	ld	a4,8(s0)
ffffffffc02071c4:	cb25                	beqz	a4,ffffffffc0207234 <add_timer+0x88>
ffffffffc02071c6:	6c18                	ld	a4,24(s0)
ffffffffc02071c8:	01040593          	addi	a1,s0,16
ffffffffc02071cc:	08e59463          	bne	a1,a4,ffffffffc0207254 <add_timer+0xa8>
ffffffffc02071d0:	0008e617          	auipc	a2,0x8e
ffffffffc02071d4:	62060613          	addi	a2,a2,1568 # ffffffffc02957f0 <timer_list>
ffffffffc02071d8:	6618                	ld	a4,8(a2)
ffffffffc02071da:	00c71863          	bne	a4,a2,ffffffffc02071ea <add_timer+0x3e>
ffffffffc02071de:	a80d                	j	ffffffffc0207210 <add_timer+0x64>
ffffffffc02071e0:	6718                	ld	a4,8(a4)
ffffffffc02071e2:	9f95                	subw	a5,a5,a3
ffffffffc02071e4:	c01c                	sw	a5,0(s0)
ffffffffc02071e6:	02c70563          	beq	a4,a2,ffffffffc0207210 <add_timer+0x64>
ffffffffc02071ea:	ff072683          	lw	a3,-16(a4)
ffffffffc02071ee:	fed7f9e3          	bgeu	a5,a3,ffffffffc02071e0 <add_timer+0x34>
ffffffffc02071f2:	40f687bb          	subw	a5,a3,a5
ffffffffc02071f6:	fef72823          	sw	a5,-16(a4)
ffffffffc02071fa:	631c                	ld	a5,0(a4)
ffffffffc02071fc:	e30c                	sd	a1,0(a4)
ffffffffc02071fe:	e78c                	sd	a1,8(a5)
ffffffffc0207200:	ec18                	sd	a4,24(s0)
ffffffffc0207202:	e81c                	sd	a5,16(s0)
ffffffffc0207204:	c105                	beqz	a0,ffffffffc0207224 <add_timer+0x78>
ffffffffc0207206:	6402                	ld	s0,0(sp)
ffffffffc0207208:	60a2                	ld	ra,8(sp)
ffffffffc020720a:	0141                	addi	sp,sp,16
ffffffffc020720c:	a61f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207210:	0008e717          	auipc	a4,0x8e
ffffffffc0207214:	5e070713          	addi	a4,a4,1504 # ffffffffc02957f0 <timer_list>
ffffffffc0207218:	631c                	ld	a5,0(a4)
ffffffffc020721a:	e30c                	sd	a1,0(a4)
ffffffffc020721c:	e78c                	sd	a1,8(a5)
ffffffffc020721e:	ec18                	sd	a4,24(s0)
ffffffffc0207220:	e81c                	sd	a5,16(s0)
ffffffffc0207222:	f175                	bnez	a0,ffffffffc0207206 <add_timer+0x5a>
ffffffffc0207224:	60a2                	ld	ra,8(sp)
ffffffffc0207226:	6402                	ld	s0,0(sp)
ffffffffc0207228:	0141                	addi	sp,sp,16
ffffffffc020722a:	8082                	ret
ffffffffc020722c:	a47f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207230:	4505                	li	a0,1
ffffffffc0207232:	b771                	j	ffffffffc02071be <add_timer+0x12>
ffffffffc0207234:	00006697          	auipc	a3,0x6
ffffffffc0207238:	42468693          	addi	a3,a3,1060 # ffffffffc020d658 <CSWTCH.79+0x520>
ffffffffc020723c:	00004617          	auipc	a2,0x4
ffffffffc0207240:	4fc60613          	addi	a2,a2,1276 # ffffffffc020b738 <commands+0x210>
ffffffffc0207244:	07a00593          	li	a1,122
ffffffffc0207248:	00006517          	auipc	a0,0x6
ffffffffc020724c:	3d850513          	addi	a0,a0,984 # ffffffffc020d620 <CSWTCH.79+0x4e8>
ffffffffc0207250:	a4ef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207254:	00006697          	auipc	a3,0x6
ffffffffc0207258:	43468693          	addi	a3,a3,1076 # ffffffffc020d688 <CSWTCH.79+0x550>
ffffffffc020725c:	00004617          	auipc	a2,0x4
ffffffffc0207260:	4dc60613          	addi	a2,a2,1244 # ffffffffc020b738 <commands+0x210>
ffffffffc0207264:	07b00593          	li	a1,123
ffffffffc0207268:	00006517          	auipc	a0,0x6
ffffffffc020726c:	3b850513          	addi	a0,a0,952 # ffffffffc020d620 <CSWTCH.79+0x4e8>
ffffffffc0207270:	a2ef90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207274 <del_timer>:
ffffffffc0207274:	1101                	addi	sp,sp,-32
ffffffffc0207276:	e822                	sd	s0,16(sp)
ffffffffc0207278:	ec06                	sd	ra,24(sp)
ffffffffc020727a:	e426                	sd	s1,8(sp)
ffffffffc020727c:	842a                	mv	s0,a0
ffffffffc020727e:	100027f3          	csrr	a5,sstatus
ffffffffc0207282:	8b89                	andi	a5,a5,2
ffffffffc0207284:	01050493          	addi	s1,a0,16
ffffffffc0207288:	eb9d                	bnez	a5,ffffffffc02072be <del_timer+0x4a>
ffffffffc020728a:	6d1c                	ld	a5,24(a0)
ffffffffc020728c:	02978463          	beq	a5,s1,ffffffffc02072b4 <del_timer+0x40>
ffffffffc0207290:	4114                	lw	a3,0(a0)
ffffffffc0207292:	6918                	ld	a4,16(a0)
ffffffffc0207294:	ce81                	beqz	a3,ffffffffc02072ac <del_timer+0x38>
ffffffffc0207296:	0008e617          	auipc	a2,0x8e
ffffffffc020729a:	55a60613          	addi	a2,a2,1370 # ffffffffc02957f0 <timer_list>
ffffffffc020729e:	00c78763          	beq	a5,a2,ffffffffc02072ac <del_timer+0x38>
ffffffffc02072a2:	ff07a603          	lw	a2,-16(a5)
ffffffffc02072a6:	9eb1                	addw	a3,a3,a2
ffffffffc02072a8:	fed7a823          	sw	a3,-16(a5)
ffffffffc02072ac:	e71c                	sd	a5,8(a4)
ffffffffc02072ae:	e398                	sd	a4,0(a5)
ffffffffc02072b0:	ec04                	sd	s1,24(s0)
ffffffffc02072b2:	e804                	sd	s1,16(s0)
ffffffffc02072b4:	60e2                	ld	ra,24(sp)
ffffffffc02072b6:	6442                	ld	s0,16(sp)
ffffffffc02072b8:	64a2                	ld	s1,8(sp)
ffffffffc02072ba:	6105                	addi	sp,sp,32
ffffffffc02072bc:	8082                	ret
ffffffffc02072be:	9b5f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02072c2:	6c1c                	ld	a5,24(s0)
ffffffffc02072c4:	02978463          	beq	a5,s1,ffffffffc02072ec <del_timer+0x78>
ffffffffc02072c8:	4014                	lw	a3,0(s0)
ffffffffc02072ca:	6818                	ld	a4,16(s0)
ffffffffc02072cc:	ce81                	beqz	a3,ffffffffc02072e4 <del_timer+0x70>
ffffffffc02072ce:	0008e617          	auipc	a2,0x8e
ffffffffc02072d2:	52260613          	addi	a2,a2,1314 # ffffffffc02957f0 <timer_list>
ffffffffc02072d6:	00c78763          	beq	a5,a2,ffffffffc02072e4 <del_timer+0x70>
ffffffffc02072da:	ff07a603          	lw	a2,-16(a5)
ffffffffc02072de:	9eb1                	addw	a3,a3,a2
ffffffffc02072e0:	fed7a823          	sw	a3,-16(a5)
ffffffffc02072e4:	e71c                	sd	a5,8(a4)
ffffffffc02072e6:	e398                	sd	a4,0(a5)
ffffffffc02072e8:	ec04                	sd	s1,24(s0)
ffffffffc02072ea:	e804                	sd	s1,16(s0)
ffffffffc02072ec:	6442                	ld	s0,16(sp)
ffffffffc02072ee:	60e2                	ld	ra,24(sp)
ffffffffc02072f0:	64a2                	ld	s1,8(sp)
ffffffffc02072f2:	6105                	addi	sp,sp,32
ffffffffc02072f4:	979f906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02072f8 <run_timer_list>:
ffffffffc02072f8:	7139                	addi	sp,sp,-64
ffffffffc02072fa:	fc06                	sd	ra,56(sp)
ffffffffc02072fc:	f822                	sd	s0,48(sp)
ffffffffc02072fe:	f426                	sd	s1,40(sp)
ffffffffc0207300:	f04a                	sd	s2,32(sp)
ffffffffc0207302:	ec4e                	sd	s3,24(sp)
ffffffffc0207304:	e852                	sd	s4,16(sp)
ffffffffc0207306:	e456                	sd	s5,8(sp)
ffffffffc0207308:	e05a                	sd	s6,0(sp)
ffffffffc020730a:	100027f3          	csrr	a5,sstatus
ffffffffc020730e:	8b89                	andi	a5,a5,2
ffffffffc0207310:	4b01                	li	s6,0
ffffffffc0207312:	efe9                	bnez	a5,ffffffffc02073ec <run_timer_list+0xf4>
ffffffffc0207314:	0008e997          	auipc	s3,0x8e
ffffffffc0207318:	4dc98993          	addi	s3,s3,1244 # ffffffffc02957f0 <timer_list>
ffffffffc020731c:	0089b403          	ld	s0,8(s3)
ffffffffc0207320:	07340a63          	beq	s0,s3,ffffffffc0207394 <run_timer_list+0x9c>
ffffffffc0207324:	ff042783          	lw	a5,-16(s0)
ffffffffc0207328:	ff040913          	addi	s2,s0,-16
ffffffffc020732c:	0e078763          	beqz	a5,ffffffffc020741a <run_timer_list+0x122>
ffffffffc0207330:	fff7871b          	addiw	a4,a5,-1
ffffffffc0207334:	fee42823          	sw	a4,-16(s0)
ffffffffc0207338:	ef31                	bnez	a4,ffffffffc0207394 <run_timer_list+0x9c>
ffffffffc020733a:	00006a97          	auipc	s5,0x6
ffffffffc020733e:	3b6a8a93          	addi	s5,s5,950 # ffffffffc020d6f0 <CSWTCH.79+0x5b8>
ffffffffc0207342:	00006a17          	auipc	s4,0x6
ffffffffc0207346:	2dea0a13          	addi	s4,s4,734 # ffffffffc020d620 <CSWTCH.79+0x4e8>
ffffffffc020734a:	a005                	j	ffffffffc020736a <run_timer_list+0x72>
ffffffffc020734c:	0a07d763          	bgez	a5,ffffffffc02073fa <run_timer_list+0x102>
ffffffffc0207350:	8526                	mv	a0,s1
ffffffffc0207352:	ce9ff0ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc0207356:	854a                	mv	a0,s2
ffffffffc0207358:	f1dff0ef          	jal	ra,ffffffffc0207274 <del_timer>
ffffffffc020735c:	03340c63          	beq	s0,s3,ffffffffc0207394 <run_timer_list+0x9c>
ffffffffc0207360:	ff042783          	lw	a5,-16(s0)
ffffffffc0207364:	ff040913          	addi	s2,s0,-16
ffffffffc0207368:	e795                	bnez	a5,ffffffffc0207394 <run_timer_list+0x9c>
ffffffffc020736a:	00893483          	ld	s1,8(s2)
ffffffffc020736e:	6400                	ld	s0,8(s0)
ffffffffc0207370:	0ec4a783          	lw	a5,236(s1)
ffffffffc0207374:	ffe1                	bnez	a5,ffffffffc020734c <run_timer_list+0x54>
ffffffffc0207376:	40d4                	lw	a3,4(s1)
ffffffffc0207378:	8656                	mv	a2,s5
ffffffffc020737a:	0ba00593          	li	a1,186
ffffffffc020737e:	8552                	mv	a0,s4
ffffffffc0207380:	986f90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc0207384:	8526                	mv	a0,s1
ffffffffc0207386:	cb5ff0ef          	jal	ra,ffffffffc020703a <wakeup_proc>
ffffffffc020738a:	854a                	mv	a0,s2
ffffffffc020738c:	ee9ff0ef          	jal	ra,ffffffffc0207274 <del_timer>
ffffffffc0207390:	fd3418e3          	bne	s0,s3,ffffffffc0207360 <run_timer_list+0x68>
ffffffffc0207394:	0008f597          	auipc	a1,0x8f
ffffffffc0207398:	52c5b583          	ld	a1,1324(a1) # ffffffffc02968c0 <current>
ffffffffc020739c:	c18d                	beqz	a1,ffffffffc02073be <run_timer_list+0xc6>
ffffffffc020739e:	0008f797          	auipc	a5,0x8f
ffffffffc02073a2:	52a7b783          	ld	a5,1322(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02073a6:	04f58763          	beq	a1,a5,ffffffffc02073f4 <run_timer_list+0xfc>
ffffffffc02073aa:	0008f797          	auipc	a5,0x8f
ffffffffc02073ae:	53e7b783          	ld	a5,1342(a5) # ffffffffc02968e8 <sched_class>
ffffffffc02073b2:	779c                	ld	a5,40(a5)
ffffffffc02073b4:	0008f517          	auipc	a0,0x8f
ffffffffc02073b8:	52c53503          	ld	a0,1324(a0) # ffffffffc02968e0 <rq>
ffffffffc02073bc:	9782                	jalr	a5
ffffffffc02073be:	000b1c63          	bnez	s6,ffffffffc02073d6 <run_timer_list+0xde>
ffffffffc02073c2:	70e2                	ld	ra,56(sp)
ffffffffc02073c4:	7442                	ld	s0,48(sp)
ffffffffc02073c6:	74a2                	ld	s1,40(sp)
ffffffffc02073c8:	7902                	ld	s2,32(sp)
ffffffffc02073ca:	69e2                	ld	s3,24(sp)
ffffffffc02073cc:	6a42                	ld	s4,16(sp)
ffffffffc02073ce:	6aa2                	ld	s5,8(sp)
ffffffffc02073d0:	6b02                	ld	s6,0(sp)
ffffffffc02073d2:	6121                	addi	sp,sp,64
ffffffffc02073d4:	8082                	ret
ffffffffc02073d6:	7442                	ld	s0,48(sp)
ffffffffc02073d8:	70e2                	ld	ra,56(sp)
ffffffffc02073da:	74a2                	ld	s1,40(sp)
ffffffffc02073dc:	7902                	ld	s2,32(sp)
ffffffffc02073de:	69e2                	ld	s3,24(sp)
ffffffffc02073e0:	6a42                	ld	s4,16(sp)
ffffffffc02073e2:	6aa2                	ld	s5,8(sp)
ffffffffc02073e4:	6b02                	ld	s6,0(sp)
ffffffffc02073e6:	6121                	addi	sp,sp,64
ffffffffc02073e8:	885f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02073ec:	887f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02073f0:	4b05                	li	s6,1
ffffffffc02073f2:	b70d                	j	ffffffffc0207314 <run_timer_list+0x1c>
ffffffffc02073f4:	4785                	li	a5,1
ffffffffc02073f6:	ed9c                	sd	a5,24(a1)
ffffffffc02073f8:	b7d9                	j	ffffffffc02073be <run_timer_list+0xc6>
ffffffffc02073fa:	00006697          	auipc	a3,0x6
ffffffffc02073fe:	2ce68693          	addi	a3,a3,718 # ffffffffc020d6c8 <CSWTCH.79+0x590>
ffffffffc0207402:	00004617          	auipc	a2,0x4
ffffffffc0207406:	33660613          	addi	a2,a2,822 # ffffffffc020b738 <commands+0x210>
ffffffffc020740a:	0b600593          	li	a1,182
ffffffffc020740e:	00006517          	auipc	a0,0x6
ffffffffc0207412:	21250513          	addi	a0,a0,530 # ffffffffc020d620 <CSWTCH.79+0x4e8>
ffffffffc0207416:	888f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020741a:	00006697          	auipc	a3,0x6
ffffffffc020741e:	29668693          	addi	a3,a3,662 # ffffffffc020d6b0 <CSWTCH.79+0x578>
ffffffffc0207422:	00004617          	auipc	a2,0x4
ffffffffc0207426:	31660613          	addi	a2,a2,790 # ffffffffc020b738 <commands+0x210>
ffffffffc020742a:	0ae00593          	li	a1,174
ffffffffc020742e:	00006517          	auipc	a0,0x6
ffffffffc0207432:	1f250513          	addi	a0,a0,498 # ffffffffc020d620 <CSWTCH.79+0x4e8>
ffffffffc0207436:	868f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020743a <sys_getpid>:
ffffffffc020743a:	0008f797          	auipc	a5,0x8f
ffffffffc020743e:	4867b783          	ld	a5,1158(a5) # ffffffffc02968c0 <current>
ffffffffc0207442:	43c8                	lw	a0,4(a5)
ffffffffc0207444:	8082                	ret

ffffffffc0207446 <sys_pgdir>:
ffffffffc0207446:	4501                	li	a0,0
ffffffffc0207448:	8082                	ret

ffffffffc020744a <sys_gettime>:
ffffffffc020744a:	0008f797          	auipc	a5,0x8f
ffffffffc020744e:	4267b783          	ld	a5,1062(a5) # ffffffffc0296870 <ticks>
ffffffffc0207452:	0027951b          	slliw	a0,a5,0x2
ffffffffc0207456:	9d3d                	addw	a0,a0,a5
ffffffffc0207458:	0015151b          	slliw	a0,a0,0x1
ffffffffc020745c:	8082                	ret

ffffffffc020745e <sys_lab6_set_priority>:
ffffffffc020745e:	4108                	lw	a0,0(a0)
ffffffffc0207460:	1141                	addi	sp,sp,-16
ffffffffc0207462:	e406                	sd	ra,8(sp)
ffffffffc0207464:	975ff0ef          	jal	ra,ffffffffc0206dd8 <lab6_set_priority>
ffffffffc0207468:	60a2                	ld	ra,8(sp)
ffffffffc020746a:	4501                	li	a0,0
ffffffffc020746c:	0141                	addi	sp,sp,16
ffffffffc020746e:	8082                	ret

ffffffffc0207470 <sys_dup>:
ffffffffc0207470:	450c                	lw	a1,8(a0)
ffffffffc0207472:	4108                	lw	a0,0(a0)
ffffffffc0207474:	cb2fe06f          	j	ffffffffc0205926 <sysfile_dup>

ffffffffc0207478 <sys_getdirentry>:
ffffffffc0207478:	650c                	ld	a1,8(a0)
ffffffffc020747a:	4108                	lw	a0,0(a0)
ffffffffc020747c:	bbafe06f          	j	ffffffffc0205836 <sysfile_getdirentry>

ffffffffc0207480 <sys_getcwd>:
ffffffffc0207480:	650c                	ld	a1,8(a0)
ffffffffc0207482:	6108                	ld	a0,0(a0)
ffffffffc0207484:	b0efe06f          	j	ffffffffc0205792 <sysfile_getcwd>

ffffffffc0207488 <sys_fsync>:
ffffffffc0207488:	4108                	lw	a0,0(a0)
ffffffffc020748a:	b04fe06f          	j	ffffffffc020578e <sysfile_fsync>

ffffffffc020748e <sys_fstat>:
ffffffffc020748e:	650c                	ld	a1,8(a0)
ffffffffc0207490:	4108                	lw	a0,0(a0)
ffffffffc0207492:	a5cfe06f          	j	ffffffffc02056ee <sysfile_fstat>

ffffffffc0207496 <sys_seek>:
ffffffffc0207496:	4910                	lw	a2,16(a0)
ffffffffc0207498:	650c                	ld	a1,8(a0)
ffffffffc020749a:	4108                	lw	a0,0(a0)
ffffffffc020749c:	a4efe06f          	j	ffffffffc02056ea <sysfile_seek>

ffffffffc02074a0 <sys_write>:
ffffffffc02074a0:	6910                	ld	a2,16(a0)
ffffffffc02074a2:	650c                	ld	a1,8(a0)
ffffffffc02074a4:	4108                	lw	a0,0(a0)
ffffffffc02074a6:	92afe06f          	j	ffffffffc02055d0 <sysfile_write>

ffffffffc02074aa <sys_read>:
ffffffffc02074aa:	6910                	ld	a2,16(a0)
ffffffffc02074ac:	650c                	ld	a1,8(a0)
ffffffffc02074ae:	4108                	lw	a0,0(a0)
ffffffffc02074b0:	80cfe06f          	j	ffffffffc02054bc <sysfile_read>

ffffffffc02074b4 <sys_close>:
ffffffffc02074b4:	4108                	lw	a0,0(a0)
ffffffffc02074b6:	802fe06f          	j	ffffffffc02054b8 <sysfile_close>

ffffffffc02074ba <sys_open>:
ffffffffc02074ba:	450c                	lw	a1,8(a0)
ffffffffc02074bc:	6108                	ld	a0,0(a0)
ffffffffc02074be:	fc7fd06f          	j	ffffffffc0205484 <sysfile_open>

ffffffffc02074c2 <sys_putc>:
ffffffffc02074c2:	4108                	lw	a0,0(a0)
ffffffffc02074c4:	1141                	addi	sp,sp,-16
ffffffffc02074c6:	e406                	sd	ra,8(sp)
ffffffffc02074c8:	d1bf80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc02074cc:	60a2                	ld	ra,8(sp)
ffffffffc02074ce:	4501                	li	a0,0
ffffffffc02074d0:	0141                	addi	sp,sp,16
ffffffffc02074d2:	8082                	ret

ffffffffc02074d4 <sys_kill>:
ffffffffc02074d4:	4108                	lw	a0,0(a0)
ffffffffc02074d6:	ea0ff06f          	j	ffffffffc0206b76 <do_kill>

ffffffffc02074da <sys_sleep>:
ffffffffc02074da:	4108                	lw	a0,0(a0)
ffffffffc02074dc:	937ff06f          	j	ffffffffc0206e12 <do_sleep>

ffffffffc02074e0 <sys_yield>:
ffffffffc02074e0:	e48ff06f          	j	ffffffffc0206b28 <do_yield>

ffffffffc02074e4 <sys_exec>:
ffffffffc02074e4:	6910                	ld	a2,16(a0)
ffffffffc02074e6:	450c                	lw	a1,8(a0)
ffffffffc02074e8:	6108                	ld	a0,0(a0)
ffffffffc02074ea:	e79fe06f          	j	ffffffffc0206362 <do_execve>

ffffffffc02074ee <sys_wait>:
ffffffffc02074ee:	650c                	ld	a1,8(a0)
ffffffffc02074f0:	4108                	lw	a0,0(a0)
ffffffffc02074f2:	e46ff06f          	j	ffffffffc0206b38 <do_wait>

ffffffffc02074f6 <sys_fork>:
ffffffffc02074f6:	0008f797          	auipc	a5,0x8f
ffffffffc02074fa:	3ca7b783          	ld	a5,970(a5) # ffffffffc02968c0 <current>
ffffffffc02074fe:	73d0                	ld	a2,160(a5)
ffffffffc0207500:	4501                	li	a0,0
ffffffffc0207502:	6a0c                	ld	a1,16(a2)
ffffffffc0207504:	dc4fe06f          	j	ffffffffc0205ac8 <do_fork>

ffffffffc0207508 <sys_exit>:
ffffffffc0207508:	4108                	lw	a0,0(a0)
ffffffffc020750a:	9e9fe06f          	j	ffffffffc0205ef2 <do_exit>

ffffffffc020750e <syscall>:
ffffffffc020750e:	715d                	addi	sp,sp,-80
ffffffffc0207510:	fc26                	sd	s1,56(sp)
ffffffffc0207512:	0008f497          	auipc	s1,0x8f
ffffffffc0207516:	3ae48493          	addi	s1,s1,942 # ffffffffc02968c0 <current>
ffffffffc020751a:	6098                	ld	a4,0(s1)
ffffffffc020751c:	e0a2                	sd	s0,64(sp)
ffffffffc020751e:	f84a                	sd	s2,48(sp)
ffffffffc0207520:	7340                	ld	s0,160(a4)
ffffffffc0207522:	e486                	sd	ra,72(sp)
ffffffffc0207524:	0ff00793          	li	a5,255
ffffffffc0207528:	05042903          	lw	s2,80(s0)
ffffffffc020752c:	0327ee63          	bltu	a5,s2,ffffffffc0207568 <syscall+0x5a>
ffffffffc0207530:	00391713          	slli	a4,s2,0x3
ffffffffc0207534:	00006797          	auipc	a5,0x6
ffffffffc0207538:	22478793          	addi	a5,a5,548 # ffffffffc020d758 <syscalls>
ffffffffc020753c:	97ba                	add	a5,a5,a4
ffffffffc020753e:	639c                	ld	a5,0(a5)
ffffffffc0207540:	c785                	beqz	a5,ffffffffc0207568 <syscall+0x5a>
ffffffffc0207542:	6c28                	ld	a0,88(s0)
ffffffffc0207544:	702c                	ld	a1,96(s0)
ffffffffc0207546:	7430                	ld	a2,104(s0)
ffffffffc0207548:	7834                	ld	a3,112(s0)
ffffffffc020754a:	7c38                	ld	a4,120(s0)
ffffffffc020754c:	e42a                	sd	a0,8(sp)
ffffffffc020754e:	e82e                	sd	a1,16(sp)
ffffffffc0207550:	ec32                	sd	a2,24(sp)
ffffffffc0207552:	f036                	sd	a3,32(sp)
ffffffffc0207554:	f43a                	sd	a4,40(sp)
ffffffffc0207556:	0028                	addi	a0,sp,8
ffffffffc0207558:	9782                	jalr	a5
ffffffffc020755a:	60a6                	ld	ra,72(sp)
ffffffffc020755c:	e828                	sd	a0,80(s0)
ffffffffc020755e:	6406                	ld	s0,64(sp)
ffffffffc0207560:	74e2                	ld	s1,56(sp)
ffffffffc0207562:	7942                	ld	s2,48(sp)
ffffffffc0207564:	6161                	addi	sp,sp,80
ffffffffc0207566:	8082                	ret
ffffffffc0207568:	8522                	mv	a0,s0
ffffffffc020756a:	a21f90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc020756e:	609c                	ld	a5,0(s1)
ffffffffc0207570:	86ca                	mv	a3,s2
ffffffffc0207572:	00006617          	auipc	a2,0x6
ffffffffc0207576:	19e60613          	addi	a2,a2,414 # ffffffffc020d710 <CSWTCH.79+0x5d8>
ffffffffc020757a:	43d8                	lw	a4,4(a5)
ffffffffc020757c:	0d800593          	li	a1,216
ffffffffc0207580:	0b478793          	addi	a5,a5,180
ffffffffc0207584:	00006517          	auipc	a0,0x6
ffffffffc0207588:	1bc50513          	addi	a0,a0,444 # ffffffffc020d740 <CSWTCH.79+0x608>
ffffffffc020758c:	f13f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207590 <__alloc_inode>:
ffffffffc0207590:	1141                	addi	sp,sp,-16
ffffffffc0207592:	e022                	sd	s0,0(sp)
ffffffffc0207594:	842a                	mv	s0,a0
ffffffffc0207596:	07800513          	li	a0,120
ffffffffc020759a:	e406                	sd	ra,8(sp)
ffffffffc020759c:	9f3fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02075a0:	c111                	beqz	a0,ffffffffc02075a4 <__alloc_inode+0x14>
ffffffffc02075a2:	cd20                	sw	s0,88(a0)
ffffffffc02075a4:	60a2                	ld	ra,8(sp)
ffffffffc02075a6:	6402                	ld	s0,0(sp)
ffffffffc02075a8:	0141                	addi	sp,sp,16
ffffffffc02075aa:	8082                	ret

ffffffffc02075ac <inode_init>:
ffffffffc02075ac:	4785                	li	a5,1
ffffffffc02075ae:	06052023          	sw	zero,96(a0)
ffffffffc02075b2:	f92c                	sd	a1,112(a0)
ffffffffc02075b4:	f530                	sd	a2,104(a0)
ffffffffc02075b6:	cd7c                	sw	a5,92(a0)
ffffffffc02075b8:	8082                	ret

ffffffffc02075ba <inode_kill>:
ffffffffc02075ba:	4d78                	lw	a4,92(a0)
ffffffffc02075bc:	1141                	addi	sp,sp,-16
ffffffffc02075be:	e406                	sd	ra,8(sp)
ffffffffc02075c0:	e719                	bnez	a4,ffffffffc02075ce <inode_kill+0x14>
ffffffffc02075c2:	513c                	lw	a5,96(a0)
ffffffffc02075c4:	e78d                	bnez	a5,ffffffffc02075ee <inode_kill+0x34>
ffffffffc02075c6:	60a2                	ld	ra,8(sp)
ffffffffc02075c8:	0141                	addi	sp,sp,16
ffffffffc02075ca:	a75fa06f          	j	ffffffffc020203e <kfree>
ffffffffc02075ce:	00007697          	auipc	a3,0x7
ffffffffc02075d2:	98a68693          	addi	a3,a3,-1654 # ffffffffc020df58 <syscalls+0x800>
ffffffffc02075d6:	00004617          	auipc	a2,0x4
ffffffffc02075da:	16260613          	addi	a2,a2,354 # ffffffffc020b738 <commands+0x210>
ffffffffc02075de:	02900593          	li	a1,41
ffffffffc02075e2:	00007517          	auipc	a0,0x7
ffffffffc02075e6:	99650513          	addi	a0,a0,-1642 # ffffffffc020df78 <syscalls+0x820>
ffffffffc02075ea:	eb5f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02075ee:	00007697          	auipc	a3,0x7
ffffffffc02075f2:	9a268693          	addi	a3,a3,-1630 # ffffffffc020df90 <syscalls+0x838>
ffffffffc02075f6:	00004617          	auipc	a2,0x4
ffffffffc02075fa:	14260613          	addi	a2,a2,322 # ffffffffc020b738 <commands+0x210>
ffffffffc02075fe:	02a00593          	li	a1,42
ffffffffc0207602:	00007517          	auipc	a0,0x7
ffffffffc0207606:	97650513          	addi	a0,a0,-1674 # ffffffffc020df78 <syscalls+0x820>
ffffffffc020760a:	e95f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020760e <inode_ref_inc>:
ffffffffc020760e:	4d7c                	lw	a5,92(a0)
ffffffffc0207610:	2785                	addiw	a5,a5,1
ffffffffc0207612:	cd7c                	sw	a5,92(a0)
ffffffffc0207614:	0007851b          	sext.w	a0,a5
ffffffffc0207618:	8082                	ret

ffffffffc020761a <inode_open_inc>:
ffffffffc020761a:	513c                	lw	a5,96(a0)
ffffffffc020761c:	2785                	addiw	a5,a5,1
ffffffffc020761e:	d13c                	sw	a5,96(a0)
ffffffffc0207620:	0007851b          	sext.w	a0,a5
ffffffffc0207624:	8082                	ret

ffffffffc0207626 <inode_check>:
ffffffffc0207626:	1141                	addi	sp,sp,-16
ffffffffc0207628:	e406                	sd	ra,8(sp)
ffffffffc020762a:	c90d                	beqz	a0,ffffffffc020765c <inode_check+0x36>
ffffffffc020762c:	793c                	ld	a5,112(a0)
ffffffffc020762e:	c79d                	beqz	a5,ffffffffc020765c <inode_check+0x36>
ffffffffc0207630:	6398                	ld	a4,0(a5)
ffffffffc0207632:	4625d7b7          	lui	a5,0x4625d
ffffffffc0207636:	0786                	slli	a5,a5,0x1
ffffffffc0207638:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc020763c:	08f71063          	bne	a4,a5,ffffffffc02076bc <inode_check+0x96>
ffffffffc0207640:	4d78                	lw	a4,92(a0)
ffffffffc0207642:	513c                	lw	a5,96(a0)
ffffffffc0207644:	04f74c63          	blt	a4,a5,ffffffffc020769c <inode_check+0x76>
ffffffffc0207648:	0407ca63          	bltz	a5,ffffffffc020769c <inode_check+0x76>
ffffffffc020764c:	66c1                	lui	a3,0x10
ffffffffc020764e:	02d75763          	bge	a4,a3,ffffffffc020767c <inode_check+0x56>
ffffffffc0207652:	02d7d563          	bge	a5,a3,ffffffffc020767c <inode_check+0x56>
ffffffffc0207656:	60a2                	ld	ra,8(sp)
ffffffffc0207658:	0141                	addi	sp,sp,16
ffffffffc020765a:	8082                	ret
ffffffffc020765c:	00007697          	auipc	a3,0x7
ffffffffc0207660:	95468693          	addi	a3,a3,-1708 # ffffffffc020dfb0 <syscalls+0x858>
ffffffffc0207664:	00004617          	auipc	a2,0x4
ffffffffc0207668:	0d460613          	addi	a2,a2,212 # ffffffffc020b738 <commands+0x210>
ffffffffc020766c:	06e00593          	li	a1,110
ffffffffc0207670:	00007517          	auipc	a0,0x7
ffffffffc0207674:	90850513          	addi	a0,a0,-1784 # ffffffffc020df78 <syscalls+0x820>
ffffffffc0207678:	e27f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020767c:	00007697          	auipc	a3,0x7
ffffffffc0207680:	9b468693          	addi	a3,a3,-1612 # ffffffffc020e030 <syscalls+0x8d8>
ffffffffc0207684:	00004617          	auipc	a2,0x4
ffffffffc0207688:	0b460613          	addi	a2,a2,180 # ffffffffc020b738 <commands+0x210>
ffffffffc020768c:	07200593          	li	a1,114
ffffffffc0207690:	00007517          	auipc	a0,0x7
ffffffffc0207694:	8e850513          	addi	a0,a0,-1816 # ffffffffc020df78 <syscalls+0x820>
ffffffffc0207698:	e07f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020769c:	00007697          	auipc	a3,0x7
ffffffffc02076a0:	96468693          	addi	a3,a3,-1692 # ffffffffc020e000 <syscalls+0x8a8>
ffffffffc02076a4:	00004617          	auipc	a2,0x4
ffffffffc02076a8:	09460613          	addi	a2,a2,148 # ffffffffc020b738 <commands+0x210>
ffffffffc02076ac:	07100593          	li	a1,113
ffffffffc02076b0:	00007517          	auipc	a0,0x7
ffffffffc02076b4:	8c850513          	addi	a0,a0,-1848 # ffffffffc020df78 <syscalls+0x820>
ffffffffc02076b8:	de7f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02076bc:	00007697          	auipc	a3,0x7
ffffffffc02076c0:	91c68693          	addi	a3,a3,-1764 # ffffffffc020dfd8 <syscalls+0x880>
ffffffffc02076c4:	00004617          	auipc	a2,0x4
ffffffffc02076c8:	07460613          	addi	a2,a2,116 # ffffffffc020b738 <commands+0x210>
ffffffffc02076cc:	06f00593          	li	a1,111
ffffffffc02076d0:	00007517          	auipc	a0,0x7
ffffffffc02076d4:	8a850513          	addi	a0,a0,-1880 # ffffffffc020df78 <syscalls+0x820>
ffffffffc02076d8:	dc7f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076dc <inode_ref_dec>:
ffffffffc02076dc:	4d7c                	lw	a5,92(a0)
ffffffffc02076de:	1101                	addi	sp,sp,-32
ffffffffc02076e0:	ec06                	sd	ra,24(sp)
ffffffffc02076e2:	e822                	sd	s0,16(sp)
ffffffffc02076e4:	e426                	sd	s1,8(sp)
ffffffffc02076e6:	e04a                	sd	s2,0(sp)
ffffffffc02076e8:	06f05e63          	blez	a5,ffffffffc0207764 <inode_ref_dec+0x88>
ffffffffc02076ec:	fff7849b          	addiw	s1,a5,-1
ffffffffc02076f0:	cd64                	sw	s1,92(a0)
ffffffffc02076f2:	842a                	mv	s0,a0
ffffffffc02076f4:	e09d                	bnez	s1,ffffffffc020771a <inode_ref_dec+0x3e>
ffffffffc02076f6:	793c                	ld	a5,112(a0)
ffffffffc02076f8:	c7b1                	beqz	a5,ffffffffc0207744 <inode_ref_dec+0x68>
ffffffffc02076fa:	0487b903          	ld	s2,72(a5)
ffffffffc02076fe:	04090363          	beqz	s2,ffffffffc0207744 <inode_ref_dec+0x68>
ffffffffc0207702:	00007597          	auipc	a1,0x7
ffffffffc0207706:	9de58593          	addi	a1,a1,-1570 # ffffffffc020e0e0 <syscalls+0x988>
ffffffffc020770a:	f1dff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc020770e:	8522                	mv	a0,s0
ffffffffc0207710:	9902                	jalr	s2
ffffffffc0207712:	c501                	beqz	a0,ffffffffc020771a <inode_ref_dec+0x3e>
ffffffffc0207714:	57c5                	li	a5,-15
ffffffffc0207716:	00f51963          	bne	a0,a5,ffffffffc0207728 <inode_ref_dec+0x4c>
ffffffffc020771a:	60e2                	ld	ra,24(sp)
ffffffffc020771c:	6442                	ld	s0,16(sp)
ffffffffc020771e:	6902                	ld	s2,0(sp)
ffffffffc0207720:	8526                	mv	a0,s1
ffffffffc0207722:	64a2                	ld	s1,8(sp)
ffffffffc0207724:	6105                	addi	sp,sp,32
ffffffffc0207726:	8082                	ret
ffffffffc0207728:	85aa                	mv	a1,a0
ffffffffc020772a:	00007517          	auipc	a0,0x7
ffffffffc020772e:	9be50513          	addi	a0,a0,-1602 # ffffffffc020e0e8 <syscalls+0x990>
ffffffffc0207732:	a75f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207736:	60e2                	ld	ra,24(sp)
ffffffffc0207738:	6442                	ld	s0,16(sp)
ffffffffc020773a:	6902                	ld	s2,0(sp)
ffffffffc020773c:	8526                	mv	a0,s1
ffffffffc020773e:	64a2                	ld	s1,8(sp)
ffffffffc0207740:	6105                	addi	sp,sp,32
ffffffffc0207742:	8082                	ret
ffffffffc0207744:	00007697          	auipc	a3,0x7
ffffffffc0207748:	94c68693          	addi	a3,a3,-1716 # ffffffffc020e090 <syscalls+0x938>
ffffffffc020774c:	00004617          	auipc	a2,0x4
ffffffffc0207750:	fec60613          	addi	a2,a2,-20 # ffffffffc020b738 <commands+0x210>
ffffffffc0207754:	04400593          	li	a1,68
ffffffffc0207758:	00007517          	auipc	a0,0x7
ffffffffc020775c:	82050513          	addi	a0,a0,-2016 # ffffffffc020df78 <syscalls+0x820>
ffffffffc0207760:	d3ff80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207764:	00007697          	auipc	a3,0x7
ffffffffc0207768:	90c68693          	addi	a3,a3,-1780 # ffffffffc020e070 <syscalls+0x918>
ffffffffc020776c:	00004617          	auipc	a2,0x4
ffffffffc0207770:	fcc60613          	addi	a2,a2,-52 # ffffffffc020b738 <commands+0x210>
ffffffffc0207774:	03f00593          	li	a1,63
ffffffffc0207778:	00007517          	auipc	a0,0x7
ffffffffc020777c:	80050513          	addi	a0,a0,-2048 # ffffffffc020df78 <syscalls+0x820>
ffffffffc0207780:	d1ff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207784 <inode_open_dec>:
ffffffffc0207784:	513c                	lw	a5,96(a0)
ffffffffc0207786:	1101                	addi	sp,sp,-32
ffffffffc0207788:	ec06                	sd	ra,24(sp)
ffffffffc020778a:	e822                	sd	s0,16(sp)
ffffffffc020778c:	e426                	sd	s1,8(sp)
ffffffffc020778e:	e04a                	sd	s2,0(sp)
ffffffffc0207790:	06f05b63          	blez	a5,ffffffffc0207806 <inode_open_dec+0x82>
ffffffffc0207794:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207798:	d124                	sw	s1,96(a0)
ffffffffc020779a:	842a                	mv	s0,a0
ffffffffc020779c:	e085                	bnez	s1,ffffffffc02077bc <inode_open_dec+0x38>
ffffffffc020779e:	793c                	ld	a5,112(a0)
ffffffffc02077a0:	c3b9                	beqz	a5,ffffffffc02077e6 <inode_open_dec+0x62>
ffffffffc02077a2:	0107b903          	ld	s2,16(a5)
ffffffffc02077a6:	04090063          	beqz	s2,ffffffffc02077e6 <inode_open_dec+0x62>
ffffffffc02077aa:	00007597          	auipc	a1,0x7
ffffffffc02077ae:	9ce58593          	addi	a1,a1,-1586 # ffffffffc020e178 <syscalls+0xa20>
ffffffffc02077b2:	e75ff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc02077b6:	8522                	mv	a0,s0
ffffffffc02077b8:	9902                	jalr	s2
ffffffffc02077ba:	e901                	bnez	a0,ffffffffc02077ca <inode_open_dec+0x46>
ffffffffc02077bc:	60e2                	ld	ra,24(sp)
ffffffffc02077be:	6442                	ld	s0,16(sp)
ffffffffc02077c0:	6902                	ld	s2,0(sp)
ffffffffc02077c2:	8526                	mv	a0,s1
ffffffffc02077c4:	64a2                	ld	s1,8(sp)
ffffffffc02077c6:	6105                	addi	sp,sp,32
ffffffffc02077c8:	8082                	ret
ffffffffc02077ca:	85aa                	mv	a1,a0
ffffffffc02077cc:	00007517          	auipc	a0,0x7
ffffffffc02077d0:	9b450513          	addi	a0,a0,-1612 # ffffffffc020e180 <syscalls+0xa28>
ffffffffc02077d4:	9d3f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02077d8:	60e2                	ld	ra,24(sp)
ffffffffc02077da:	6442                	ld	s0,16(sp)
ffffffffc02077dc:	6902                	ld	s2,0(sp)
ffffffffc02077de:	8526                	mv	a0,s1
ffffffffc02077e0:	64a2                	ld	s1,8(sp)
ffffffffc02077e2:	6105                	addi	sp,sp,32
ffffffffc02077e4:	8082                	ret
ffffffffc02077e6:	00007697          	auipc	a3,0x7
ffffffffc02077ea:	94268693          	addi	a3,a3,-1726 # ffffffffc020e128 <syscalls+0x9d0>
ffffffffc02077ee:	00004617          	auipc	a2,0x4
ffffffffc02077f2:	f4a60613          	addi	a2,a2,-182 # ffffffffc020b738 <commands+0x210>
ffffffffc02077f6:	06100593          	li	a1,97
ffffffffc02077fa:	00006517          	auipc	a0,0x6
ffffffffc02077fe:	77e50513          	addi	a0,a0,1918 # ffffffffc020df78 <syscalls+0x820>
ffffffffc0207802:	c9df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207806:	00007697          	auipc	a3,0x7
ffffffffc020780a:	90268693          	addi	a3,a3,-1790 # ffffffffc020e108 <syscalls+0x9b0>
ffffffffc020780e:	00004617          	auipc	a2,0x4
ffffffffc0207812:	f2a60613          	addi	a2,a2,-214 # ffffffffc020b738 <commands+0x210>
ffffffffc0207816:	05c00593          	li	a1,92
ffffffffc020781a:	00006517          	auipc	a0,0x6
ffffffffc020781e:	75e50513          	addi	a0,a0,1886 # ffffffffc020df78 <syscalls+0x820>
ffffffffc0207822:	c7df80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207826 <__alloc_fs>:
ffffffffc0207826:	1141                	addi	sp,sp,-16
ffffffffc0207828:	e022                	sd	s0,0(sp)
ffffffffc020782a:	842a                	mv	s0,a0
ffffffffc020782c:	0d800513          	li	a0,216
ffffffffc0207830:	e406                	sd	ra,8(sp)
ffffffffc0207832:	f5cfa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207836:	c119                	beqz	a0,ffffffffc020783c <__alloc_fs+0x16>
ffffffffc0207838:	0a852823          	sw	s0,176(a0)
ffffffffc020783c:	60a2                	ld	ra,8(sp)
ffffffffc020783e:	6402                	ld	s0,0(sp)
ffffffffc0207840:	0141                	addi	sp,sp,16
ffffffffc0207842:	8082                	ret

ffffffffc0207844 <vfs_init>:
ffffffffc0207844:	1141                	addi	sp,sp,-16
ffffffffc0207846:	4585                	li	a1,1
ffffffffc0207848:	0008e517          	auipc	a0,0x8e
ffffffffc020784c:	fb850513          	addi	a0,a0,-72 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207850:	e406                	sd	ra,8(sp)
ffffffffc0207852:	c67fc0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0207856:	60a2                	ld	ra,8(sp)
ffffffffc0207858:	0141                	addi	sp,sp,16
ffffffffc020785a:	a40d                	j	ffffffffc0207a7c <vfs_devlist_init>

ffffffffc020785c <vfs_set_bootfs>:
ffffffffc020785c:	7179                	addi	sp,sp,-48
ffffffffc020785e:	f022                	sd	s0,32(sp)
ffffffffc0207860:	f406                	sd	ra,40(sp)
ffffffffc0207862:	ec26                	sd	s1,24(sp)
ffffffffc0207864:	e402                	sd	zero,8(sp)
ffffffffc0207866:	842a                	mv	s0,a0
ffffffffc0207868:	c915                	beqz	a0,ffffffffc020789c <vfs_set_bootfs+0x40>
ffffffffc020786a:	03a00593          	li	a1,58
ffffffffc020786e:	1cd030ef          	jal	ra,ffffffffc020b23a <strchr>
ffffffffc0207872:	c135                	beqz	a0,ffffffffc02078d6 <vfs_set_bootfs+0x7a>
ffffffffc0207874:	00154783          	lbu	a5,1(a0)
ffffffffc0207878:	efb9                	bnez	a5,ffffffffc02078d6 <vfs_set_bootfs+0x7a>
ffffffffc020787a:	8522                	mv	a0,s0
ffffffffc020787c:	11f000ef          	jal	ra,ffffffffc020819a <vfs_chdir>
ffffffffc0207880:	842a                	mv	s0,a0
ffffffffc0207882:	c519                	beqz	a0,ffffffffc0207890 <vfs_set_bootfs+0x34>
ffffffffc0207884:	70a2                	ld	ra,40(sp)
ffffffffc0207886:	8522                	mv	a0,s0
ffffffffc0207888:	7402                	ld	s0,32(sp)
ffffffffc020788a:	64e2                	ld	s1,24(sp)
ffffffffc020788c:	6145                	addi	sp,sp,48
ffffffffc020788e:	8082                	ret
ffffffffc0207890:	0028                	addi	a0,sp,8
ffffffffc0207892:	013000ef          	jal	ra,ffffffffc02080a4 <vfs_get_curdir>
ffffffffc0207896:	842a                	mv	s0,a0
ffffffffc0207898:	f575                	bnez	a0,ffffffffc0207884 <vfs_set_bootfs+0x28>
ffffffffc020789a:	6422                	ld	s0,8(sp)
ffffffffc020789c:	0008e517          	auipc	a0,0x8e
ffffffffc02078a0:	f6450513          	addi	a0,a0,-156 # ffffffffc0295800 <bootfs_sem>
ffffffffc02078a4:	c1ffc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02078a8:	0008f797          	auipc	a5,0x8f
ffffffffc02078ac:	04878793          	addi	a5,a5,72 # ffffffffc02968f0 <bootfs_node>
ffffffffc02078b0:	6384                	ld	s1,0(a5)
ffffffffc02078b2:	0008e517          	auipc	a0,0x8e
ffffffffc02078b6:	f4e50513          	addi	a0,a0,-178 # ffffffffc0295800 <bootfs_sem>
ffffffffc02078ba:	e380                	sd	s0,0(a5)
ffffffffc02078bc:	4401                	li	s0,0
ffffffffc02078be:	c01fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02078c2:	d0e9                	beqz	s1,ffffffffc0207884 <vfs_set_bootfs+0x28>
ffffffffc02078c4:	8526                	mv	a0,s1
ffffffffc02078c6:	e17ff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc02078ca:	70a2                	ld	ra,40(sp)
ffffffffc02078cc:	8522                	mv	a0,s0
ffffffffc02078ce:	7402                	ld	s0,32(sp)
ffffffffc02078d0:	64e2                	ld	s1,24(sp)
ffffffffc02078d2:	6145                	addi	sp,sp,48
ffffffffc02078d4:	8082                	ret
ffffffffc02078d6:	5475                	li	s0,-3
ffffffffc02078d8:	b775                	j	ffffffffc0207884 <vfs_set_bootfs+0x28>

ffffffffc02078da <vfs_get_bootfs>:
ffffffffc02078da:	1101                	addi	sp,sp,-32
ffffffffc02078dc:	e426                	sd	s1,8(sp)
ffffffffc02078de:	0008f497          	auipc	s1,0x8f
ffffffffc02078e2:	01248493          	addi	s1,s1,18 # ffffffffc02968f0 <bootfs_node>
ffffffffc02078e6:	609c                	ld	a5,0(s1)
ffffffffc02078e8:	ec06                	sd	ra,24(sp)
ffffffffc02078ea:	e822                	sd	s0,16(sp)
ffffffffc02078ec:	c3a1                	beqz	a5,ffffffffc020792c <vfs_get_bootfs+0x52>
ffffffffc02078ee:	842a                	mv	s0,a0
ffffffffc02078f0:	0008e517          	auipc	a0,0x8e
ffffffffc02078f4:	f1050513          	addi	a0,a0,-240 # ffffffffc0295800 <bootfs_sem>
ffffffffc02078f8:	bcbfc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02078fc:	6084                	ld	s1,0(s1)
ffffffffc02078fe:	c08d                	beqz	s1,ffffffffc0207920 <vfs_get_bootfs+0x46>
ffffffffc0207900:	8526                	mv	a0,s1
ffffffffc0207902:	d0dff0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc0207906:	0008e517          	auipc	a0,0x8e
ffffffffc020790a:	efa50513          	addi	a0,a0,-262 # ffffffffc0295800 <bootfs_sem>
ffffffffc020790e:	bb1fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207912:	4501                	li	a0,0
ffffffffc0207914:	e004                	sd	s1,0(s0)
ffffffffc0207916:	60e2                	ld	ra,24(sp)
ffffffffc0207918:	6442                	ld	s0,16(sp)
ffffffffc020791a:	64a2                	ld	s1,8(sp)
ffffffffc020791c:	6105                	addi	sp,sp,32
ffffffffc020791e:	8082                	ret
ffffffffc0207920:	0008e517          	auipc	a0,0x8e
ffffffffc0207924:	ee050513          	addi	a0,a0,-288 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207928:	b97fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020792c:	5541                	li	a0,-16
ffffffffc020792e:	b7e5                	j	ffffffffc0207916 <vfs_get_bootfs+0x3c>

ffffffffc0207930 <vfs_do_add>:
ffffffffc0207930:	7139                	addi	sp,sp,-64
ffffffffc0207932:	fc06                	sd	ra,56(sp)
ffffffffc0207934:	f822                	sd	s0,48(sp)
ffffffffc0207936:	f426                	sd	s1,40(sp)
ffffffffc0207938:	f04a                	sd	s2,32(sp)
ffffffffc020793a:	ec4e                	sd	s3,24(sp)
ffffffffc020793c:	e852                	sd	s4,16(sp)
ffffffffc020793e:	e456                	sd	s5,8(sp)
ffffffffc0207940:	e05a                	sd	s6,0(sp)
ffffffffc0207942:	0e050b63          	beqz	a0,ffffffffc0207a38 <vfs_do_add+0x108>
ffffffffc0207946:	842a                	mv	s0,a0
ffffffffc0207948:	8a2e                	mv	s4,a1
ffffffffc020794a:	8b32                	mv	s6,a2
ffffffffc020794c:	8ab6                	mv	s5,a3
ffffffffc020794e:	c5cd                	beqz	a1,ffffffffc02079f8 <vfs_do_add+0xc8>
ffffffffc0207950:	4db8                	lw	a4,88(a1)
ffffffffc0207952:	6785                	lui	a5,0x1
ffffffffc0207954:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207958:	0af71163          	bne	a4,a5,ffffffffc02079fa <vfs_do_add+0xca>
ffffffffc020795c:	8522                	mv	a0,s0
ffffffffc020795e:	051030ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc0207962:	47fd                	li	a5,31
ffffffffc0207964:	0ca7e663          	bltu	a5,a0,ffffffffc0207a30 <vfs_do_add+0x100>
ffffffffc0207968:	8522                	mv	a0,s0
ffffffffc020796a:	88bf80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc020796e:	84aa                	mv	s1,a0
ffffffffc0207970:	c171                	beqz	a0,ffffffffc0207a34 <vfs_do_add+0x104>
ffffffffc0207972:	03000513          	li	a0,48
ffffffffc0207976:	e18fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020797a:	89aa                	mv	s3,a0
ffffffffc020797c:	c92d                	beqz	a0,ffffffffc02079ee <vfs_do_add+0xbe>
ffffffffc020797e:	0008e517          	auipc	a0,0x8e
ffffffffc0207982:	eaa50513          	addi	a0,a0,-342 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207986:	0008e917          	auipc	s2,0x8e
ffffffffc020798a:	e9290913          	addi	s2,s2,-366 # ffffffffc0295818 <vdev_list>
ffffffffc020798e:	b35fc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207992:	844a                	mv	s0,s2
ffffffffc0207994:	a039                	j	ffffffffc02079a2 <vfs_do_add+0x72>
ffffffffc0207996:	fe043503          	ld	a0,-32(s0)
ffffffffc020799a:	85a6                	mv	a1,s1
ffffffffc020799c:	05b030ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc02079a0:	cd2d                	beqz	a0,ffffffffc0207a1a <vfs_do_add+0xea>
ffffffffc02079a2:	6400                	ld	s0,8(s0)
ffffffffc02079a4:	ff2419e3          	bne	s0,s2,ffffffffc0207996 <vfs_do_add+0x66>
ffffffffc02079a8:	6418                	ld	a4,8(s0)
ffffffffc02079aa:	02098793          	addi	a5,s3,32
ffffffffc02079ae:	0099b023          	sd	s1,0(s3)
ffffffffc02079b2:	0149b423          	sd	s4,8(s3)
ffffffffc02079b6:	0159bc23          	sd	s5,24(s3)
ffffffffc02079ba:	0169b823          	sd	s6,16(s3)
ffffffffc02079be:	e31c                	sd	a5,0(a4)
ffffffffc02079c0:	0289b023          	sd	s0,32(s3)
ffffffffc02079c4:	02e9b423          	sd	a4,40(s3)
ffffffffc02079c8:	0008e517          	auipc	a0,0x8e
ffffffffc02079cc:	e6050513          	addi	a0,a0,-416 # ffffffffc0295828 <vdev_list_sem>
ffffffffc02079d0:	e41c                	sd	a5,8(s0)
ffffffffc02079d2:	4401                	li	s0,0
ffffffffc02079d4:	aebfc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02079d8:	70e2                	ld	ra,56(sp)
ffffffffc02079da:	8522                	mv	a0,s0
ffffffffc02079dc:	7442                	ld	s0,48(sp)
ffffffffc02079de:	74a2                	ld	s1,40(sp)
ffffffffc02079e0:	7902                	ld	s2,32(sp)
ffffffffc02079e2:	69e2                	ld	s3,24(sp)
ffffffffc02079e4:	6a42                	ld	s4,16(sp)
ffffffffc02079e6:	6aa2                	ld	s5,8(sp)
ffffffffc02079e8:	6b02                	ld	s6,0(sp)
ffffffffc02079ea:	6121                	addi	sp,sp,64
ffffffffc02079ec:	8082                	ret
ffffffffc02079ee:	5471                	li	s0,-4
ffffffffc02079f0:	8526                	mv	a0,s1
ffffffffc02079f2:	e4cfa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02079f6:	b7cd                	j	ffffffffc02079d8 <vfs_do_add+0xa8>
ffffffffc02079f8:	d2b5                	beqz	a3,ffffffffc020795c <vfs_do_add+0x2c>
ffffffffc02079fa:	00006697          	auipc	a3,0x6
ffffffffc02079fe:	7ce68693          	addi	a3,a3,1998 # ffffffffc020e1c8 <syscalls+0xa70>
ffffffffc0207a02:	00004617          	auipc	a2,0x4
ffffffffc0207a06:	d3660613          	addi	a2,a2,-714 # ffffffffc020b738 <commands+0x210>
ffffffffc0207a0a:	08f00593          	li	a1,143
ffffffffc0207a0e:	00006517          	auipc	a0,0x6
ffffffffc0207a12:	7a250513          	addi	a0,a0,1954 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207a16:	a89f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a1a:	0008e517          	auipc	a0,0x8e
ffffffffc0207a1e:	e0e50513          	addi	a0,a0,-498 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207a22:	a9dfc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207a26:	854e                	mv	a0,s3
ffffffffc0207a28:	e16fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207a2c:	5425                	li	s0,-23
ffffffffc0207a2e:	b7c9                	j	ffffffffc02079f0 <vfs_do_add+0xc0>
ffffffffc0207a30:	5451                	li	s0,-12
ffffffffc0207a32:	b75d                	j	ffffffffc02079d8 <vfs_do_add+0xa8>
ffffffffc0207a34:	5471                	li	s0,-4
ffffffffc0207a36:	b74d                	j	ffffffffc02079d8 <vfs_do_add+0xa8>
ffffffffc0207a38:	00006697          	auipc	a3,0x6
ffffffffc0207a3c:	76868693          	addi	a3,a3,1896 # ffffffffc020e1a0 <syscalls+0xa48>
ffffffffc0207a40:	00004617          	auipc	a2,0x4
ffffffffc0207a44:	cf860613          	addi	a2,a2,-776 # ffffffffc020b738 <commands+0x210>
ffffffffc0207a48:	08e00593          	li	a1,142
ffffffffc0207a4c:	00006517          	auipc	a0,0x6
ffffffffc0207a50:	76450513          	addi	a0,a0,1892 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207a54:	a4bf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207a58 <find_mount.part.0>:
ffffffffc0207a58:	1141                	addi	sp,sp,-16
ffffffffc0207a5a:	00006697          	auipc	a3,0x6
ffffffffc0207a5e:	74668693          	addi	a3,a3,1862 # ffffffffc020e1a0 <syscalls+0xa48>
ffffffffc0207a62:	00004617          	auipc	a2,0x4
ffffffffc0207a66:	cd660613          	addi	a2,a2,-810 # ffffffffc020b738 <commands+0x210>
ffffffffc0207a6a:	0cd00593          	li	a1,205
ffffffffc0207a6e:	00006517          	auipc	a0,0x6
ffffffffc0207a72:	74250513          	addi	a0,a0,1858 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207a76:	e406                	sd	ra,8(sp)
ffffffffc0207a78:	a27f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207a7c <vfs_devlist_init>:
ffffffffc0207a7c:	0008e797          	auipc	a5,0x8e
ffffffffc0207a80:	d9c78793          	addi	a5,a5,-612 # ffffffffc0295818 <vdev_list>
ffffffffc0207a84:	4585                	li	a1,1
ffffffffc0207a86:	0008e517          	auipc	a0,0x8e
ffffffffc0207a8a:	da250513          	addi	a0,a0,-606 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207a8e:	e79c                	sd	a5,8(a5)
ffffffffc0207a90:	e39c                	sd	a5,0(a5)
ffffffffc0207a92:	a27fc06f          	j	ffffffffc02044b8 <sem_init>

ffffffffc0207a96 <vfs_cleanup>:
ffffffffc0207a96:	1101                	addi	sp,sp,-32
ffffffffc0207a98:	e426                	sd	s1,8(sp)
ffffffffc0207a9a:	0008e497          	auipc	s1,0x8e
ffffffffc0207a9e:	d7e48493          	addi	s1,s1,-642 # ffffffffc0295818 <vdev_list>
ffffffffc0207aa2:	649c                	ld	a5,8(s1)
ffffffffc0207aa4:	ec06                	sd	ra,24(sp)
ffffffffc0207aa6:	e822                	sd	s0,16(sp)
ffffffffc0207aa8:	02978e63          	beq	a5,s1,ffffffffc0207ae4 <vfs_cleanup+0x4e>
ffffffffc0207aac:	0008e517          	auipc	a0,0x8e
ffffffffc0207ab0:	d7c50513          	addi	a0,a0,-644 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207ab4:	a0ffc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207ab8:	6480                	ld	s0,8(s1)
ffffffffc0207aba:	00940b63          	beq	s0,s1,ffffffffc0207ad0 <vfs_cleanup+0x3a>
ffffffffc0207abe:	ff043783          	ld	a5,-16(s0)
ffffffffc0207ac2:	853e                	mv	a0,a5
ffffffffc0207ac4:	c399                	beqz	a5,ffffffffc0207aca <vfs_cleanup+0x34>
ffffffffc0207ac6:	6bfc                	ld	a5,208(a5)
ffffffffc0207ac8:	9782                	jalr	a5
ffffffffc0207aca:	6400                	ld	s0,8(s0)
ffffffffc0207acc:	fe9419e3          	bne	s0,s1,ffffffffc0207abe <vfs_cleanup+0x28>
ffffffffc0207ad0:	6442                	ld	s0,16(sp)
ffffffffc0207ad2:	60e2                	ld	ra,24(sp)
ffffffffc0207ad4:	64a2                	ld	s1,8(sp)
ffffffffc0207ad6:	0008e517          	auipc	a0,0x8e
ffffffffc0207ada:	d5250513          	addi	a0,a0,-686 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207ade:	6105                	addi	sp,sp,32
ffffffffc0207ae0:	9dffc06f          	j	ffffffffc02044be <up>
ffffffffc0207ae4:	60e2                	ld	ra,24(sp)
ffffffffc0207ae6:	6442                	ld	s0,16(sp)
ffffffffc0207ae8:	64a2                	ld	s1,8(sp)
ffffffffc0207aea:	6105                	addi	sp,sp,32
ffffffffc0207aec:	8082                	ret

ffffffffc0207aee <vfs_get_root>:
ffffffffc0207aee:	7179                	addi	sp,sp,-48
ffffffffc0207af0:	f406                	sd	ra,40(sp)
ffffffffc0207af2:	f022                	sd	s0,32(sp)
ffffffffc0207af4:	ec26                	sd	s1,24(sp)
ffffffffc0207af6:	e84a                	sd	s2,16(sp)
ffffffffc0207af8:	e44e                	sd	s3,8(sp)
ffffffffc0207afa:	e052                	sd	s4,0(sp)
ffffffffc0207afc:	c541                	beqz	a0,ffffffffc0207b84 <vfs_get_root+0x96>
ffffffffc0207afe:	0008e917          	auipc	s2,0x8e
ffffffffc0207b02:	d1a90913          	addi	s2,s2,-742 # ffffffffc0295818 <vdev_list>
ffffffffc0207b06:	00893783          	ld	a5,8(s2)
ffffffffc0207b0a:	07278b63          	beq	a5,s2,ffffffffc0207b80 <vfs_get_root+0x92>
ffffffffc0207b0e:	89aa                	mv	s3,a0
ffffffffc0207b10:	0008e517          	auipc	a0,0x8e
ffffffffc0207b14:	d1850513          	addi	a0,a0,-744 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b18:	8a2e                	mv	s4,a1
ffffffffc0207b1a:	844a                	mv	s0,s2
ffffffffc0207b1c:	9a7fc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207b20:	a801                	j	ffffffffc0207b30 <vfs_get_root+0x42>
ffffffffc0207b22:	fe043583          	ld	a1,-32(s0)
ffffffffc0207b26:	854e                	mv	a0,s3
ffffffffc0207b28:	6ce030ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc0207b2c:	84aa                	mv	s1,a0
ffffffffc0207b2e:	c505                	beqz	a0,ffffffffc0207b56 <vfs_get_root+0x68>
ffffffffc0207b30:	6400                	ld	s0,8(s0)
ffffffffc0207b32:	ff2418e3          	bne	s0,s2,ffffffffc0207b22 <vfs_get_root+0x34>
ffffffffc0207b36:	54cd                	li	s1,-13
ffffffffc0207b38:	0008e517          	auipc	a0,0x8e
ffffffffc0207b3c:	cf050513          	addi	a0,a0,-784 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b40:	97ffc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207b44:	70a2                	ld	ra,40(sp)
ffffffffc0207b46:	7402                	ld	s0,32(sp)
ffffffffc0207b48:	6942                	ld	s2,16(sp)
ffffffffc0207b4a:	69a2                	ld	s3,8(sp)
ffffffffc0207b4c:	6a02                	ld	s4,0(sp)
ffffffffc0207b4e:	8526                	mv	a0,s1
ffffffffc0207b50:	64e2                	ld	s1,24(sp)
ffffffffc0207b52:	6145                	addi	sp,sp,48
ffffffffc0207b54:	8082                	ret
ffffffffc0207b56:	ff043503          	ld	a0,-16(s0)
ffffffffc0207b5a:	c519                	beqz	a0,ffffffffc0207b68 <vfs_get_root+0x7a>
ffffffffc0207b5c:	617c                	ld	a5,192(a0)
ffffffffc0207b5e:	9782                	jalr	a5
ffffffffc0207b60:	c519                	beqz	a0,ffffffffc0207b6e <vfs_get_root+0x80>
ffffffffc0207b62:	00aa3023          	sd	a0,0(s4)
ffffffffc0207b66:	bfc9                	j	ffffffffc0207b38 <vfs_get_root+0x4a>
ffffffffc0207b68:	ff843783          	ld	a5,-8(s0)
ffffffffc0207b6c:	c399                	beqz	a5,ffffffffc0207b72 <vfs_get_root+0x84>
ffffffffc0207b6e:	54c9                	li	s1,-14
ffffffffc0207b70:	b7e1                	j	ffffffffc0207b38 <vfs_get_root+0x4a>
ffffffffc0207b72:	fe843503          	ld	a0,-24(s0)
ffffffffc0207b76:	a99ff0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc0207b7a:	fe843503          	ld	a0,-24(s0)
ffffffffc0207b7e:	b7cd                	j	ffffffffc0207b60 <vfs_get_root+0x72>
ffffffffc0207b80:	54cd                	li	s1,-13
ffffffffc0207b82:	b7c9                	j	ffffffffc0207b44 <vfs_get_root+0x56>
ffffffffc0207b84:	00006697          	auipc	a3,0x6
ffffffffc0207b88:	61c68693          	addi	a3,a3,1564 # ffffffffc020e1a0 <syscalls+0xa48>
ffffffffc0207b8c:	00004617          	auipc	a2,0x4
ffffffffc0207b90:	bac60613          	addi	a2,a2,-1108 # ffffffffc020b738 <commands+0x210>
ffffffffc0207b94:	04500593          	li	a1,69
ffffffffc0207b98:	00006517          	auipc	a0,0x6
ffffffffc0207b9c:	61850513          	addi	a0,a0,1560 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207ba0:	8fff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ba4 <vfs_get_devname>:
ffffffffc0207ba4:	0008e697          	auipc	a3,0x8e
ffffffffc0207ba8:	c7468693          	addi	a3,a3,-908 # ffffffffc0295818 <vdev_list>
ffffffffc0207bac:	87b6                	mv	a5,a3
ffffffffc0207bae:	e511                	bnez	a0,ffffffffc0207bba <vfs_get_devname+0x16>
ffffffffc0207bb0:	a829                	j	ffffffffc0207bca <vfs_get_devname+0x26>
ffffffffc0207bb2:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207bb6:	00a70763          	beq	a4,a0,ffffffffc0207bc4 <vfs_get_devname+0x20>
ffffffffc0207bba:	679c                	ld	a5,8(a5)
ffffffffc0207bbc:	fed79be3          	bne	a5,a3,ffffffffc0207bb2 <vfs_get_devname+0xe>
ffffffffc0207bc0:	4501                	li	a0,0
ffffffffc0207bc2:	8082                	ret
ffffffffc0207bc4:	fe07b503          	ld	a0,-32(a5)
ffffffffc0207bc8:	8082                	ret
ffffffffc0207bca:	1141                	addi	sp,sp,-16
ffffffffc0207bcc:	00006697          	auipc	a3,0x6
ffffffffc0207bd0:	65c68693          	addi	a3,a3,1628 # ffffffffc020e228 <syscalls+0xad0>
ffffffffc0207bd4:	00004617          	auipc	a2,0x4
ffffffffc0207bd8:	b6460613          	addi	a2,a2,-1180 # ffffffffc020b738 <commands+0x210>
ffffffffc0207bdc:	06a00593          	li	a1,106
ffffffffc0207be0:	00006517          	auipc	a0,0x6
ffffffffc0207be4:	5d050513          	addi	a0,a0,1488 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207be8:	e406                	sd	ra,8(sp)
ffffffffc0207bea:	8b5f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207bee <vfs_add_dev>:
ffffffffc0207bee:	86b2                	mv	a3,a2
ffffffffc0207bf0:	4601                	li	a2,0
ffffffffc0207bf2:	d3fff06f          	j	ffffffffc0207930 <vfs_do_add>

ffffffffc0207bf6 <vfs_mount>:
ffffffffc0207bf6:	7179                	addi	sp,sp,-48
ffffffffc0207bf8:	e84a                	sd	s2,16(sp)
ffffffffc0207bfa:	892a                	mv	s2,a0
ffffffffc0207bfc:	0008e517          	auipc	a0,0x8e
ffffffffc0207c00:	c2c50513          	addi	a0,a0,-980 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c04:	e44e                	sd	s3,8(sp)
ffffffffc0207c06:	f406                	sd	ra,40(sp)
ffffffffc0207c08:	f022                	sd	s0,32(sp)
ffffffffc0207c0a:	ec26                	sd	s1,24(sp)
ffffffffc0207c0c:	89ae                	mv	s3,a1
ffffffffc0207c0e:	8b5fc0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0207c12:	08090a63          	beqz	s2,ffffffffc0207ca6 <vfs_mount+0xb0>
ffffffffc0207c16:	0008e497          	auipc	s1,0x8e
ffffffffc0207c1a:	c0248493          	addi	s1,s1,-1022 # ffffffffc0295818 <vdev_list>
ffffffffc0207c1e:	6480                	ld	s0,8(s1)
ffffffffc0207c20:	00941663          	bne	s0,s1,ffffffffc0207c2c <vfs_mount+0x36>
ffffffffc0207c24:	a8ad                	j	ffffffffc0207c9e <vfs_mount+0xa8>
ffffffffc0207c26:	6400                	ld	s0,8(s0)
ffffffffc0207c28:	06940b63          	beq	s0,s1,ffffffffc0207c9e <vfs_mount+0xa8>
ffffffffc0207c2c:	ff843783          	ld	a5,-8(s0)
ffffffffc0207c30:	dbfd                	beqz	a5,ffffffffc0207c26 <vfs_mount+0x30>
ffffffffc0207c32:	fe043503          	ld	a0,-32(s0)
ffffffffc0207c36:	85ca                	mv	a1,s2
ffffffffc0207c38:	5be030ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc0207c3c:	f56d                	bnez	a0,ffffffffc0207c26 <vfs_mount+0x30>
ffffffffc0207c3e:	ff043783          	ld	a5,-16(s0)
ffffffffc0207c42:	e3a5                	bnez	a5,ffffffffc0207ca2 <vfs_mount+0xac>
ffffffffc0207c44:	fe043783          	ld	a5,-32(s0)
ffffffffc0207c48:	c3c9                	beqz	a5,ffffffffc0207cca <vfs_mount+0xd4>
ffffffffc0207c4a:	ff843783          	ld	a5,-8(s0)
ffffffffc0207c4e:	cfb5                	beqz	a5,ffffffffc0207cca <vfs_mount+0xd4>
ffffffffc0207c50:	fe843503          	ld	a0,-24(s0)
ffffffffc0207c54:	c939                	beqz	a0,ffffffffc0207caa <vfs_mount+0xb4>
ffffffffc0207c56:	4d38                	lw	a4,88(a0)
ffffffffc0207c58:	6785                	lui	a5,0x1
ffffffffc0207c5a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207c5e:	04f71663          	bne	a4,a5,ffffffffc0207caa <vfs_mount+0xb4>
ffffffffc0207c62:	ff040593          	addi	a1,s0,-16
ffffffffc0207c66:	9982                	jalr	s3
ffffffffc0207c68:	84aa                	mv	s1,a0
ffffffffc0207c6a:	ed01                	bnez	a0,ffffffffc0207c82 <vfs_mount+0x8c>
ffffffffc0207c6c:	ff043783          	ld	a5,-16(s0)
ffffffffc0207c70:	cfad                	beqz	a5,ffffffffc0207cea <vfs_mount+0xf4>
ffffffffc0207c72:	fe043583          	ld	a1,-32(s0)
ffffffffc0207c76:	00006517          	auipc	a0,0x6
ffffffffc0207c7a:	64250513          	addi	a0,a0,1602 # ffffffffc020e2b8 <syscalls+0xb60>
ffffffffc0207c7e:	d28f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207c82:	0008e517          	auipc	a0,0x8e
ffffffffc0207c86:	ba650513          	addi	a0,a0,-1114 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c8a:	835fc0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0207c8e:	70a2                	ld	ra,40(sp)
ffffffffc0207c90:	7402                	ld	s0,32(sp)
ffffffffc0207c92:	6942                	ld	s2,16(sp)
ffffffffc0207c94:	69a2                	ld	s3,8(sp)
ffffffffc0207c96:	8526                	mv	a0,s1
ffffffffc0207c98:	64e2                	ld	s1,24(sp)
ffffffffc0207c9a:	6145                	addi	sp,sp,48
ffffffffc0207c9c:	8082                	ret
ffffffffc0207c9e:	54cd                	li	s1,-13
ffffffffc0207ca0:	b7cd                	j	ffffffffc0207c82 <vfs_mount+0x8c>
ffffffffc0207ca2:	54c5                	li	s1,-15
ffffffffc0207ca4:	bff9                	j	ffffffffc0207c82 <vfs_mount+0x8c>
ffffffffc0207ca6:	db3ff0ef          	jal	ra,ffffffffc0207a58 <find_mount.part.0>
ffffffffc0207caa:	00006697          	auipc	a3,0x6
ffffffffc0207cae:	5be68693          	addi	a3,a3,1470 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc0207cb2:	00004617          	auipc	a2,0x4
ffffffffc0207cb6:	a8660613          	addi	a2,a2,-1402 # ffffffffc020b738 <commands+0x210>
ffffffffc0207cba:	0ed00593          	li	a1,237
ffffffffc0207cbe:	00006517          	auipc	a0,0x6
ffffffffc0207cc2:	4f250513          	addi	a0,a0,1266 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207cc6:	fd8f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207cca:	00006697          	auipc	a3,0x6
ffffffffc0207cce:	56e68693          	addi	a3,a3,1390 # ffffffffc020e238 <syscalls+0xae0>
ffffffffc0207cd2:	00004617          	auipc	a2,0x4
ffffffffc0207cd6:	a6660613          	addi	a2,a2,-1434 # ffffffffc020b738 <commands+0x210>
ffffffffc0207cda:	0eb00593          	li	a1,235
ffffffffc0207cde:	00006517          	auipc	a0,0x6
ffffffffc0207ce2:	4d250513          	addi	a0,a0,1234 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207ce6:	fb8f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207cea:	00006697          	auipc	a3,0x6
ffffffffc0207cee:	5b668693          	addi	a3,a3,1462 # ffffffffc020e2a0 <syscalls+0xb48>
ffffffffc0207cf2:	00004617          	auipc	a2,0x4
ffffffffc0207cf6:	a4660613          	addi	a2,a2,-1466 # ffffffffc020b738 <commands+0x210>
ffffffffc0207cfa:	0ef00593          	li	a1,239
ffffffffc0207cfe:	00006517          	auipc	a0,0x6
ffffffffc0207d02:	4b250513          	addi	a0,a0,1202 # ffffffffc020e1b0 <syscalls+0xa58>
ffffffffc0207d06:	f98f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d0a <vfs_open>:
ffffffffc0207d0a:	711d                	addi	sp,sp,-96
ffffffffc0207d0c:	e4a6                	sd	s1,72(sp)
ffffffffc0207d0e:	e0ca                	sd	s2,64(sp)
ffffffffc0207d10:	fc4e                	sd	s3,56(sp)
ffffffffc0207d12:	ec86                	sd	ra,88(sp)
ffffffffc0207d14:	e8a2                	sd	s0,80(sp)
ffffffffc0207d16:	f852                	sd	s4,48(sp)
ffffffffc0207d18:	f456                	sd	s5,40(sp)
ffffffffc0207d1a:	0035f793          	andi	a5,a1,3
ffffffffc0207d1e:	84ae                	mv	s1,a1
ffffffffc0207d20:	892a                	mv	s2,a0
ffffffffc0207d22:	89b2                	mv	s3,a2
ffffffffc0207d24:	0e078663          	beqz	a5,ffffffffc0207e10 <vfs_open+0x106>
ffffffffc0207d28:	470d                	li	a4,3
ffffffffc0207d2a:	0105fa93          	andi	s5,a1,16
ffffffffc0207d2e:	0ce78f63          	beq	a5,a4,ffffffffc0207e0c <vfs_open+0x102>
ffffffffc0207d32:	002c                	addi	a1,sp,8
ffffffffc0207d34:	854a                	mv	a0,s2
ffffffffc0207d36:	2ae000ef          	jal	ra,ffffffffc0207fe4 <vfs_lookup>
ffffffffc0207d3a:	842a                	mv	s0,a0
ffffffffc0207d3c:	0044fa13          	andi	s4,s1,4
ffffffffc0207d40:	e159                	bnez	a0,ffffffffc0207dc6 <vfs_open+0xbc>
ffffffffc0207d42:	00c4f793          	andi	a5,s1,12
ffffffffc0207d46:	4731                	li	a4,12
ffffffffc0207d48:	0ee78263          	beq	a5,a4,ffffffffc0207e2c <vfs_open+0x122>
ffffffffc0207d4c:	6422                	ld	s0,8(sp)
ffffffffc0207d4e:	12040163          	beqz	s0,ffffffffc0207e70 <vfs_open+0x166>
ffffffffc0207d52:	783c                	ld	a5,112(s0)
ffffffffc0207d54:	cff1                	beqz	a5,ffffffffc0207e30 <vfs_open+0x126>
ffffffffc0207d56:	679c                	ld	a5,8(a5)
ffffffffc0207d58:	cfe1                	beqz	a5,ffffffffc0207e30 <vfs_open+0x126>
ffffffffc0207d5a:	8522                	mv	a0,s0
ffffffffc0207d5c:	00006597          	auipc	a1,0x6
ffffffffc0207d60:	63c58593          	addi	a1,a1,1596 # ffffffffc020e398 <syscalls+0xc40>
ffffffffc0207d64:	8c3ff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0207d68:	783c                	ld	a5,112(s0)
ffffffffc0207d6a:	6522                	ld	a0,8(sp)
ffffffffc0207d6c:	85a6                	mv	a1,s1
ffffffffc0207d6e:	679c                	ld	a5,8(a5)
ffffffffc0207d70:	9782                	jalr	a5
ffffffffc0207d72:	842a                	mv	s0,a0
ffffffffc0207d74:	6522                	ld	a0,8(sp)
ffffffffc0207d76:	e845                	bnez	s0,ffffffffc0207e26 <vfs_open+0x11c>
ffffffffc0207d78:	015a6a33          	or	s4,s4,s5
ffffffffc0207d7c:	89fff0ef          	jal	ra,ffffffffc020761a <inode_open_inc>
ffffffffc0207d80:	020a0663          	beqz	s4,ffffffffc0207dac <vfs_open+0xa2>
ffffffffc0207d84:	64a2                	ld	s1,8(sp)
ffffffffc0207d86:	c4e9                	beqz	s1,ffffffffc0207e50 <vfs_open+0x146>
ffffffffc0207d88:	78bc                	ld	a5,112(s1)
ffffffffc0207d8a:	c3f9                	beqz	a5,ffffffffc0207e50 <vfs_open+0x146>
ffffffffc0207d8c:	73bc                	ld	a5,96(a5)
ffffffffc0207d8e:	c3e9                	beqz	a5,ffffffffc0207e50 <vfs_open+0x146>
ffffffffc0207d90:	00006597          	auipc	a1,0x6
ffffffffc0207d94:	66858593          	addi	a1,a1,1640 # ffffffffc020e3f8 <syscalls+0xca0>
ffffffffc0207d98:	8526                	mv	a0,s1
ffffffffc0207d9a:	88dff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0207d9e:	78bc                	ld	a5,112(s1)
ffffffffc0207da0:	6522                	ld	a0,8(sp)
ffffffffc0207da2:	4581                	li	a1,0
ffffffffc0207da4:	73bc                	ld	a5,96(a5)
ffffffffc0207da6:	9782                	jalr	a5
ffffffffc0207da8:	87aa                	mv	a5,a0
ffffffffc0207daa:	e92d                	bnez	a0,ffffffffc0207e1c <vfs_open+0x112>
ffffffffc0207dac:	67a2                	ld	a5,8(sp)
ffffffffc0207dae:	00f9b023          	sd	a5,0(s3)
ffffffffc0207db2:	60e6                	ld	ra,88(sp)
ffffffffc0207db4:	8522                	mv	a0,s0
ffffffffc0207db6:	6446                	ld	s0,80(sp)
ffffffffc0207db8:	64a6                	ld	s1,72(sp)
ffffffffc0207dba:	6906                	ld	s2,64(sp)
ffffffffc0207dbc:	79e2                	ld	s3,56(sp)
ffffffffc0207dbe:	7a42                	ld	s4,48(sp)
ffffffffc0207dc0:	7aa2                	ld	s5,40(sp)
ffffffffc0207dc2:	6125                	addi	sp,sp,96
ffffffffc0207dc4:	8082                	ret
ffffffffc0207dc6:	57c1                	li	a5,-16
ffffffffc0207dc8:	fef515e3          	bne	a0,a5,ffffffffc0207db2 <vfs_open+0xa8>
ffffffffc0207dcc:	fe0a03e3          	beqz	s4,ffffffffc0207db2 <vfs_open+0xa8>
ffffffffc0207dd0:	0810                	addi	a2,sp,16
ffffffffc0207dd2:	082c                	addi	a1,sp,24
ffffffffc0207dd4:	854a                	mv	a0,s2
ffffffffc0207dd6:	2a4000ef          	jal	ra,ffffffffc020807a <vfs_lookup_parent>
ffffffffc0207dda:	842a                	mv	s0,a0
ffffffffc0207ddc:	f979                	bnez	a0,ffffffffc0207db2 <vfs_open+0xa8>
ffffffffc0207dde:	6462                	ld	s0,24(sp)
ffffffffc0207de0:	c845                	beqz	s0,ffffffffc0207e90 <vfs_open+0x186>
ffffffffc0207de2:	783c                	ld	a5,112(s0)
ffffffffc0207de4:	c7d5                	beqz	a5,ffffffffc0207e90 <vfs_open+0x186>
ffffffffc0207de6:	77bc                	ld	a5,104(a5)
ffffffffc0207de8:	c7c5                	beqz	a5,ffffffffc0207e90 <vfs_open+0x186>
ffffffffc0207dea:	8522                	mv	a0,s0
ffffffffc0207dec:	00006597          	auipc	a1,0x6
ffffffffc0207df0:	54458593          	addi	a1,a1,1348 # ffffffffc020e330 <syscalls+0xbd8>
ffffffffc0207df4:	833ff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0207df8:	783c                	ld	a5,112(s0)
ffffffffc0207dfa:	65c2                	ld	a1,16(sp)
ffffffffc0207dfc:	6562                	ld	a0,24(sp)
ffffffffc0207dfe:	77bc                	ld	a5,104(a5)
ffffffffc0207e00:	4034d613          	srai	a2,s1,0x3
ffffffffc0207e04:	0034                	addi	a3,sp,8
ffffffffc0207e06:	8a05                	andi	a2,a2,1
ffffffffc0207e08:	9782                	jalr	a5
ffffffffc0207e0a:	b789                	j	ffffffffc0207d4c <vfs_open+0x42>
ffffffffc0207e0c:	5475                	li	s0,-3
ffffffffc0207e0e:	b755                	j	ffffffffc0207db2 <vfs_open+0xa8>
ffffffffc0207e10:	0105fa93          	andi	s5,a1,16
ffffffffc0207e14:	5475                	li	s0,-3
ffffffffc0207e16:	f80a9ee3          	bnez	s5,ffffffffc0207db2 <vfs_open+0xa8>
ffffffffc0207e1a:	bf21                	j	ffffffffc0207d32 <vfs_open+0x28>
ffffffffc0207e1c:	6522                	ld	a0,8(sp)
ffffffffc0207e1e:	843e                	mv	s0,a5
ffffffffc0207e20:	965ff0ef          	jal	ra,ffffffffc0207784 <inode_open_dec>
ffffffffc0207e24:	6522                	ld	a0,8(sp)
ffffffffc0207e26:	8b7ff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc0207e2a:	b761                	j	ffffffffc0207db2 <vfs_open+0xa8>
ffffffffc0207e2c:	5425                	li	s0,-23
ffffffffc0207e2e:	b751                	j	ffffffffc0207db2 <vfs_open+0xa8>
ffffffffc0207e30:	00006697          	auipc	a3,0x6
ffffffffc0207e34:	51868693          	addi	a3,a3,1304 # ffffffffc020e348 <syscalls+0xbf0>
ffffffffc0207e38:	00004617          	auipc	a2,0x4
ffffffffc0207e3c:	90060613          	addi	a2,a2,-1792 # ffffffffc020b738 <commands+0x210>
ffffffffc0207e40:	03300593          	li	a1,51
ffffffffc0207e44:	00006517          	auipc	a0,0x6
ffffffffc0207e48:	4d450513          	addi	a0,a0,1236 # ffffffffc020e318 <syscalls+0xbc0>
ffffffffc0207e4c:	e52f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e50:	00006697          	auipc	a3,0x6
ffffffffc0207e54:	55068693          	addi	a3,a3,1360 # ffffffffc020e3a0 <syscalls+0xc48>
ffffffffc0207e58:	00004617          	auipc	a2,0x4
ffffffffc0207e5c:	8e060613          	addi	a2,a2,-1824 # ffffffffc020b738 <commands+0x210>
ffffffffc0207e60:	03a00593          	li	a1,58
ffffffffc0207e64:	00006517          	auipc	a0,0x6
ffffffffc0207e68:	4b450513          	addi	a0,a0,1204 # ffffffffc020e318 <syscalls+0xbc0>
ffffffffc0207e6c:	e32f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e70:	00006697          	auipc	a3,0x6
ffffffffc0207e74:	4c868693          	addi	a3,a3,1224 # ffffffffc020e338 <syscalls+0xbe0>
ffffffffc0207e78:	00004617          	auipc	a2,0x4
ffffffffc0207e7c:	8c060613          	addi	a2,a2,-1856 # ffffffffc020b738 <commands+0x210>
ffffffffc0207e80:	03100593          	li	a1,49
ffffffffc0207e84:	00006517          	auipc	a0,0x6
ffffffffc0207e88:	49450513          	addi	a0,a0,1172 # ffffffffc020e318 <syscalls+0xbc0>
ffffffffc0207e8c:	e12f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e90:	00006697          	auipc	a3,0x6
ffffffffc0207e94:	43868693          	addi	a3,a3,1080 # ffffffffc020e2c8 <syscalls+0xb70>
ffffffffc0207e98:	00004617          	auipc	a2,0x4
ffffffffc0207e9c:	8a060613          	addi	a2,a2,-1888 # ffffffffc020b738 <commands+0x210>
ffffffffc0207ea0:	02c00593          	li	a1,44
ffffffffc0207ea4:	00006517          	auipc	a0,0x6
ffffffffc0207ea8:	47450513          	addi	a0,a0,1140 # ffffffffc020e318 <syscalls+0xbc0>
ffffffffc0207eac:	df2f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207eb0 <vfs_close>:
ffffffffc0207eb0:	1141                	addi	sp,sp,-16
ffffffffc0207eb2:	e406                	sd	ra,8(sp)
ffffffffc0207eb4:	e022                	sd	s0,0(sp)
ffffffffc0207eb6:	842a                	mv	s0,a0
ffffffffc0207eb8:	8cdff0ef          	jal	ra,ffffffffc0207784 <inode_open_dec>
ffffffffc0207ebc:	8522                	mv	a0,s0
ffffffffc0207ebe:	81fff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc0207ec2:	60a2                	ld	ra,8(sp)
ffffffffc0207ec4:	6402                	ld	s0,0(sp)
ffffffffc0207ec6:	4501                	li	a0,0
ffffffffc0207ec8:	0141                	addi	sp,sp,16
ffffffffc0207eca:	8082                	ret

ffffffffc0207ecc <get_device>:
ffffffffc0207ecc:	7179                	addi	sp,sp,-48
ffffffffc0207ece:	ec26                	sd	s1,24(sp)
ffffffffc0207ed0:	e84a                	sd	s2,16(sp)
ffffffffc0207ed2:	f406                	sd	ra,40(sp)
ffffffffc0207ed4:	f022                	sd	s0,32(sp)
ffffffffc0207ed6:	00054303          	lbu	t1,0(a0)
ffffffffc0207eda:	892e                	mv	s2,a1
ffffffffc0207edc:	84b2                	mv	s1,a2
ffffffffc0207ede:	02030463          	beqz	t1,ffffffffc0207f06 <get_device+0x3a>
ffffffffc0207ee2:	00150413          	addi	s0,a0,1
ffffffffc0207ee6:	86a2                	mv	a3,s0
ffffffffc0207ee8:	879a                	mv	a5,t1
ffffffffc0207eea:	4701                	li	a4,0
ffffffffc0207eec:	03a00813          	li	a6,58
ffffffffc0207ef0:	02f00893          	li	a7,47
ffffffffc0207ef4:	03078263          	beq	a5,a6,ffffffffc0207f18 <get_device+0x4c>
ffffffffc0207ef8:	05178963          	beq	a5,a7,ffffffffc0207f4a <get_device+0x7e>
ffffffffc0207efc:	0006c783          	lbu	a5,0(a3)
ffffffffc0207f00:	2705                	addiw	a4,a4,1
ffffffffc0207f02:	0685                	addi	a3,a3,1
ffffffffc0207f04:	fbe5                	bnez	a5,ffffffffc0207ef4 <get_device+0x28>
ffffffffc0207f06:	7402                	ld	s0,32(sp)
ffffffffc0207f08:	00a93023          	sd	a0,0(s2)
ffffffffc0207f0c:	70a2                	ld	ra,40(sp)
ffffffffc0207f0e:	6942                	ld	s2,16(sp)
ffffffffc0207f10:	8526                	mv	a0,s1
ffffffffc0207f12:	64e2                	ld	s1,24(sp)
ffffffffc0207f14:	6145                	addi	sp,sp,48
ffffffffc0207f16:	a279                	j	ffffffffc02080a4 <vfs_get_curdir>
ffffffffc0207f18:	cb15                	beqz	a4,ffffffffc0207f4c <get_device+0x80>
ffffffffc0207f1a:	00e507b3          	add	a5,a0,a4
ffffffffc0207f1e:	0705                	addi	a4,a4,1
ffffffffc0207f20:	00078023          	sb	zero,0(a5)
ffffffffc0207f24:	972a                	add	a4,a4,a0
ffffffffc0207f26:	02f00613          	li	a2,47
ffffffffc0207f2a:	00074783          	lbu	a5,0(a4)
ffffffffc0207f2e:	86ba                	mv	a3,a4
ffffffffc0207f30:	0705                	addi	a4,a4,1
ffffffffc0207f32:	fec78ce3          	beq	a5,a2,ffffffffc0207f2a <get_device+0x5e>
ffffffffc0207f36:	7402                	ld	s0,32(sp)
ffffffffc0207f38:	70a2                	ld	ra,40(sp)
ffffffffc0207f3a:	00d93023          	sd	a3,0(s2)
ffffffffc0207f3e:	85a6                	mv	a1,s1
ffffffffc0207f40:	6942                	ld	s2,16(sp)
ffffffffc0207f42:	64e2                	ld	s1,24(sp)
ffffffffc0207f44:	6145                	addi	sp,sp,48
ffffffffc0207f46:	ba9ff06f          	j	ffffffffc0207aee <vfs_get_root>
ffffffffc0207f4a:	ff55                	bnez	a4,ffffffffc0207f06 <get_device+0x3a>
ffffffffc0207f4c:	02f00793          	li	a5,47
ffffffffc0207f50:	04f30563          	beq	t1,a5,ffffffffc0207f9a <get_device+0xce>
ffffffffc0207f54:	03a00793          	li	a5,58
ffffffffc0207f58:	06f31663          	bne	t1,a5,ffffffffc0207fc4 <get_device+0xf8>
ffffffffc0207f5c:	0028                	addi	a0,sp,8
ffffffffc0207f5e:	146000ef          	jal	ra,ffffffffc02080a4 <vfs_get_curdir>
ffffffffc0207f62:	e515                	bnez	a0,ffffffffc0207f8e <get_device+0xc2>
ffffffffc0207f64:	67a2                	ld	a5,8(sp)
ffffffffc0207f66:	77a8                	ld	a0,104(a5)
ffffffffc0207f68:	cd15                	beqz	a0,ffffffffc0207fa4 <get_device+0xd8>
ffffffffc0207f6a:	617c                	ld	a5,192(a0)
ffffffffc0207f6c:	9782                	jalr	a5
ffffffffc0207f6e:	87aa                	mv	a5,a0
ffffffffc0207f70:	6522                	ld	a0,8(sp)
ffffffffc0207f72:	e09c                	sd	a5,0(s1)
ffffffffc0207f74:	f68ff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc0207f78:	02f00713          	li	a4,47
ffffffffc0207f7c:	a011                	j	ffffffffc0207f80 <get_device+0xb4>
ffffffffc0207f7e:	0405                	addi	s0,s0,1
ffffffffc0207f80:	00044783          	lbu	a5,0(s0)
ffffffffc0207f84:	fee78de3          	beq	a5,a4,ffffffffc0207f7e <get_device+0xb2>
ffffffffc0207f88:	00893023          	sd	s0,0(s2)
ffffffffc0207f8c:	4501                	li	a0,0
ffffffffc0207f8e:	70a2                	ld	ra,40(sp)
ffffffffc0207f90:	7402                	ld	s0,32(sp)
ffffffffc0207f92:	64e2                	ld	s1,24(sp)
ffffffffc0207f94:	6942                	ld	s2,16(sp)
ffffffffc0207f96:	6145                	addi	sp,sp,48
ffffffffc0207f98:	8082                	ret
ffffffffc0207f9a:	8526                	mv	a0,s1
ffffffffc0207f9c:	93fff0ef          	jal	ra,ffffffffc02078da <vfs_get_bootfs>
ffffffffc0207fa0:	dd61                	beqz	a0,ffffffffc0207f78 <get_device+0xac>
ffffffffc0207fa2:	b7f5                	j	ffffffffc0207f8e <get_device+0xc2>
ffffffffc0207fa4:	00006697          	auipc	a3,0x6
ffffffffc0207fa8:	48c68693          	addi	a3,a3,1164 # ffffffffc020e430 <syscalls+0xcd8>
ffffffffc0207fac:	00003617          	auipc	a2,0x3
ffffffffc0207fb0:	78c60613          	addi	a2,a2,1932 # ffffffffc020b738 <commands+0x210>
ffffffffc0207fb4:	03900593          	li	a1,57
ffffffffc0207fb8:	00006517          	auipc	a0,0x6
ffffffffc0207fbc:	46050513          	addi	a0,a0,1120 # ffffffffc020e418 <syscalls+0xcc0>
ffffffffc0207fc0:	cdef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fc4:	00006697          	auipc	a3,0x6
ffffffffc0207fc8:	44468693          	addi	a3,a3,1092 # ffffffffc020e408 <syscalls+0xcb0>
ffffffffc0207fcc:	00003617          	auipc	a2,0x3
ffffffffc0207fd0:	76c60613          	addi	a2,a2,1900 # ffffffffc020b738 <commands+0x210>
ffffffffc0207fd4:	03300593          	li	a1,51
ffffffffc0207fd8:	00006517          	auipc	a0,0x6
ffffffffc0207fdc:	44050513          	addi	a0,a0,1088 # ffffffffc020e418 <syscalls+0xcc0>
ffffffffc0207fe0:	cbef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207fe4 <vfs_lookup>:
ffffffffc0207fe4:	7139                	addi	sp,sp,-64
ffffffffc0207fe6:	f426                	sd	s1,40(sp)
ffffffffc0207fe8:	0830                	addi	a2,sp,24
ffffffffc0207fea:	84ae                	mv	s1,a1
ffffffffc0207fec:	002c                	addi	a1,sp,8
ffffffffc0207fee:	f822                	sd	s0,48(sp)
ffffffffc0207ff0:	fc06                	sd	ra,56(sp)
ffffffffc0207ff2:	f04a                	sd	s2,32(sp)
ffffffffc0207ff4:	e42a                	sd	a0,8(sp)
ffffffffc0207ff6:	ed7ff0ef          	jal	ra,ffffffffc0207ecc <get_device>
ffffffffc0207ffa:	842a                	mv	s0,a0
ffffffffc0207ffc:	ed1d                	bnez	a0,ffffffffc020803a <vfs_lookup+0x56>
ffffffffc0207ffe:	67a2                	ld	a5,8(sp)
ffffffffc0208000:	6962                	ld	s2,24(sp)
ffffffffc0208002:	0007c783          	lbu	a5,0(a5)
ffffffffc0208006:	c3a9                	beqz	a5,ffffffffc0208048 <vfs_lookup+0x64>
ffffffffc0208008:	04090963          	beqz	s2,ffffffffc020805a <vfs_lookup+0x76>
ffffffffc020800c:	07093783          	ld	a5,112(s2)
ffffffffc0208010:	c7a9                	beqz	a5,ffffffffc020805a <vfs_lookup+0x76>
ffffffffc0208012:	7bbc                	ld	a5,112(a5)
ffffffffc0208014:	c3b9                	beqz	a5,ffffffffc020805a <vfs_lookup+0x76>
ffffffffc0208016:	854a                	mv	a0,s2
ffffffffc0208018:	00006597          	auipc	a1,0x6
ffffffffc020801c:	48058593          	addi	a1,a1,1152 # ffffffffc020e498 <syscalls+0xd40>
ffffffffc0208020:	e06ff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0208024:	07093783          	ld	a5,112(s2)
ffffffffc0208028:	65a2                	ld	a1,8(sp)
ffffffffc020802a:	6562                	ld	a0,24(sp)
ffffffffc020802c:	7bbc                	ld	a5,112(a5)
ffffffffc020802e:	8626                	mv	a2,s1
ffffffffc0208030:	9782                	jalr	a5
ffffffffc0208032:	842a                	mv	s0,a0
ffffffffc0208034:	6562                	ld	a0,24(sp)
ffffffffc0208036:	ea6ff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020803a:	70e2                	ld	ra,56(sp)
ffffffffc020803c:	8522                	mv	a0,s0
ffffffffc020803e:	7442                	ld	s0,48(sp)
ffffffffc0208040:	74a2                	ld	s1,40(sp)
ffffffffc0208042:	7902                	ld	s2,32(sp)
ffffffffc0208044:	6121                	addi	sp,sp,64
ffffffffc0208046:	8082                	ret
ffffffffc0208048:	70e2                	ld	ra,56(sp)
ffffffffc020804a:	8522                	mv	a0,s0
ffffffffc020804c:	7442                	ld	s0,48(sp)
ffffffffc020804e:	0124b023          	sd	s2,0(s1)
ffffffffc0208052:	74a2                	ld	s1,40(sp)
ffffffffc0208054:	7902                	ld	s2,32(sp)
ffffffffc0208056:	6121                	addi	sp,sp,64
ffffffffc0208058:	8082                	ret
ffffffffc020805a:	00006697          	auipc	a3,0x6
ffffffffc020805e:	3ee68693          	addi	a3,a3,1006 # ffffffffc020e448 <syscalls+0xcf0>
ffffffffc0208062:	00003617          	auipc	a2,0x3
ffffffffc0208066:	6d660613          	addi	a2,a2,1750 # ffffffffc020b738 <commands+0x210>
ffffffffc020806a:	04f00593          	li	a1,79
ffffffffc020806e:	00006517          	auipc	a0,0x6
ffffffffc0208072:	3aa50513          	addi	a0,a0,938 # ffffffffc020e418 <syscalls+0xcc0>
ffffffffc0208076:	c28f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020807a <vfs_lookup_parent>:
ffffffffc020807a:	7139                	addi	sp,sp,-64
ffffffffc020807c:	f822                	sd	s0,48(sp)
ffffffffc020807e:	f426                	sd	s1,40(sp)
ffffffffc0208080:	842e                	mv	s0,a1
ffffffffc0208082:	84b2                	mv	s1,a2
ffffffffc0208084:	002c                	addi	a1,sp,8
ffffffffc0208086:	0830                	addi	a2,sp,24
ffffffffc0208088:	fc06                	sd	ra,56(sp)
ffffffffc020808a:	e42a                	sd	a0,8(sp)
ffffffffc020808c:	e41ff0ef          	jal	ra,ffffffffc0207ecc <get_device>
ffffffffc0208090:	e509                	bnez	a0,ffffffffc020809a <vfs_lookup_parent+0x20>
ffffffffc0208092:	67a2                	ld	a5,8(sp)
ffffffffc0208094:	e09c                	sd	a5,0(s1)
ffffffffc0208096:	67e2                	ld	a5,24(sp)
ffffffffc0208098:	e01c                	sd	a5,0(s0)
ffffffffc020809a:	70e2                	ld	ra,56(sp)
ffffffffc020809c:	7442                	ld	s0,48(sp)
ffffffffc020809e:	74a2                	ld	s1,40(sp)
ffffffffc02080a0:	6121                	addi	sp,sp,64
ffffffffc02080a2:	8082                	ret

ffffffffc02080a4 <vfs_get_curdir>:
ffffffffc02080a4:	0008f797          	auipc	a5,0x8f
ffffffffc02080a8:	81c7b783          	ld	a5,-2020(a5) # ffffffffc02968c0 <current>
ffffffffc02080ac:	1487b783          	ld	a5,328(a5)
ffffffffc02080b0:	1101                	addi	sp,sp,-32
ffffffffc02080b2:	e426                	sd	s1,8(sp)
ffffffffc02080b4:	6384                	ld	s1,0(a5)
ffffffffc02080b6:	ec06                	sd	ra,24(sp)
ffffffffc02080b8:	e822                	sd	s0,16(sp)
ffffffffc02080ba:	cc81                	beqz	s1,ffffffffc02080d2 <vfs_get_curdir+0x2e>
ffffffffc02080bc:	842a                	mv	s0,a0
ffffffffc02080be:	8526                	mv	a0,s1
ffffffffc02080c0:	d4eff0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc02080c4:	4501                	li	a0,0
ffffffffc02080c6:	e004                	sd	s1,0(s0)
ffffffffc02080c8:	60e2                	ld	ra,24(sp)
ffffffffc02080ca:	6442                	ld	s0,16(sp)
ffffffffc02080cc:	64a2                	ld	s1,8(sp)
ffffffffc02080ce:	6105                	addi	sp,sp,32
ffffffffc02080d0:	8082                	ret
ffffffffc02080d2:	5541                	li	a0,-16
ffffffffc02080d4:	bfd5                	j	ffffffffc02080c8 <vfs_get_curdir+0x24>

ffffffffc02080d6 <vfs_set_curdir>:
ffffffffc02080d6:	7139                	addi	sp,sp,-64
ffffffffc02080d8:	f04a                	sd	s2,32(sp)
ffffffffc02080da:	0008e917          	auipc	s2,0x8e
ffffffffc02080de:	7e690913          	addi	s2,s2,2022 # ffffffffc02968c0 <current>
ffffffffc02080e2:	00093783          	ld	a5,0(s2)
ffffffffc02080e6:	f822                	sd	s0,48(sp)
ffffffffc02080e8:	842a                	mv	s0,a0
ffffffffc02080ea:	1487b503          	ld	a0,328(a5)
ffffffffc02080ee:	ec4e                	sd	s3,24(sp)
ffffffffc02080f0:	fc06                	sd	ra,56(sp)
ffffffffc02080f2:	f426                	sd	s1,40(sp)
ffffffffc02080f4:	82cfd0ef          	jal	ra,ffffffffc0205120 <lock_files>
ffffffffc02080f8:	00093783          	ld	a5,0(s2)
ffffffffc02080fc:	1487b503          	ld	a0,328(a5)
ffffffffc0208100:	00053983          	ld	s3,0(a0)
ffffffffc0208104:	07340963          	beq	s0,s3,ffffffffc0208176 <vfs_set_curdir+0xa0>
ffffffffc0208108:	cc39                	beqz	s0,ffffffffc0208166 <vfs_set_curdir+0x90>
ffffffffc020810a:	783c                	ld	a5,112(s0)
ffffffffc020810c:	c7bd                	beqz	a5,ffffffffc020817a <vfs_set_curdir+0xa4>
ffffffffc020810e:	6bbc                	ld	a5,80(a5)
ffffffffc0208110:	c7ad                	beqz	a5,ffffffffc020817a <vfs_set_curdir+0xa4>
ffffffffc0208112:	00006597          	auipc	a1,0x6
ffffffffc0208116:	3f658593          	addi	a1,a1,1014 # ffffffffc020e508 <syscalls+0xdb0>
ffffffffc020811a:	8522                	mv	a0,s0
ffffffffc020811c:	d0aff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0208120:	783c                	ld	a5,112(s0)
ffffffffc0208122:	006c                	addi	a1,sp,12
ffffffffc0208124:	8522                	mv	a0,s0
ffffffffc0208126:	6bbc                	ld	a5,80(a5)
ffffffffc0208128:	9782                	jalr	a5
ffffffffc020812a:	84aa                	mv	s1,a0
ffffffffc020812c:	e901                	bnez	a0,ffffffffc020813c <vfs_set_curdir+0x66>
ffffffffc020812e:	47b2                	lw	a5,12(sp)
ffffffffc0208130:	669d                	lui	a3,0x7
ffffffffc0208132:	6709                	lui	a4,0x2
ffffffffc0208134:	8ff5                	and	a5,a5,a3
ffffffffc0208136:	54b9                	li	s1,-18
ffffffffc0208138:	02e78063          	beq	a5,a4,ffffffffc0208158 <vfs_set_curdir+0x82>
ffffffffc020813c:	00093783          	ld	a5,0(s2)
ffffffffc0208140:	1487b503          	ld	a0,328(a5)
ffffffffc0208144:	fe3fc0ef          	jal	ra,ffffffffc0205126 <unlock_files>
ffffffffc0208148:	70e2                	ld	ra,56(sp)
ffffffffc020814a:	7442                	ld	s0,48(sp)
ffffffffc020814c:	7902                	ld	s2,32(sp)
ffffffffc020814e:	69e2                	ld	s3,24(sp)
ffffffffc0208150:	8526                	mv	a0,s1
ffffffffc0208152:	74a2                	ld	s1,40(sp)
ffffffffc0208154:	6121                	addi	sp,sp,64
ffffffffc0208156:	8082                	ret
ffffffffc0208158:	8522                	mv	a0,s0
ffffffffc020815a:	cb4ff0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc020815e:	00093783          	ld	a5,0(s2)
ffffffffc0208162:	1487b503          	ld	a0,328(a5)
ffffffffc0208166:	e100                	sd	s0,0(a0)
ffffffffc0208168:	4481                	li	s1,0
ffffffffc020816a:	fc098de3          	beqz	s3,ffffffffc0208144 <vfs_set_curdir+0x6e>
ffffffffc020816e:	854e                	mv	a0,s3
ffffffffc0208170:	d6cff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc0208174:	b7e1                	j	ffffffffc020813c <vfs_set_curdir+0x66>
ffffffffc0208176:	4481                	li	s1,0
ffffffffc0208178:	b7f1                	j	ffffffffc0208144 <vfs_set_curdir+0x6e>
ffffffffc020817a:	00006697          	auipc	a3,0x6
ffffffffc020817e:	32668693          	addi	a3,a3,806 # ffffffffc020e4a0 <syscalls+0xd48>
ffffffffc0208182:	00003617          	auipc	a2,0x3
ffffffffc0208186:	5b660613          	addi	a2,a2,1462 # ffffffffc020b738 <commands+0x210>
ffffffffc020818a:	04300593          	li	a1,67
ffffffffc020818e:	00006517          	auipc	a0,0x6
ffffffffc0208192:	36250513          	addi	a0,a0,866 # ffffffffc020e4f0 <syscalls+0xd98>
ffffffffc0208196:	b08f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020819a <vfs_chdir>:
ffffffffc020819a:	1101                	addi	sp,sp,-32
ffffffffc020819c:	002c                	addi	a1,sp,8
ffffffffc020819e:	e822                	sd	s0,16(sp)
ffffffffc02081a0:	ec06                	sd	ra,24(sp)
ffffffffc02081a2:	e43ff0ef          	jal	ra,ffffffffc0207fe4 <vfs_lookup>
ffffffffc02081a6:	842a                	mv	s0,a0
ffffffffc02081a8:	c511                	beqz	a0,ffffffffc02081b4 <vfs_chdir+0x1a>
ffffffffc02081aa:	60e2                	ld	ra,24(sp)
ffffffffc02081ac:	8522                	mv	a0,s0
ffffffffc02081ae:	6442                	ld	s0,16(sp)
ffffffffc02081b0:	6105                	addi	sp,sp,32
ffffffffc02081b2:	8082                	ret
ffffffffc02081b4:	6522                	ld	a0,8(sp)
ffffffffc02081b6:	f21ff0ef          	jal	ra,ffffffffc02080d6 <vfs_set_curdir>
ffffffffc02081ba:	842a                	mv	s0,a0
ffffffffc02081bc:	6522                	ld	a0,8(sp)
ffffffffc02081be:	d1eff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc02081c2:	60e2                	ld	ra,24(sp)
ffffffffc02081c4:	8522                	mv	a0,s0
ffffffffc02081c6:	6442                	ld	s0,16(sp)
ffffffffc02081c8:	6105                	addi	sp,sp,32
ffffffffc02081ca:	8082                	ret

ffffffffc02081cc <vfs_getcwd>:
ffffffffc02081cc:	0008e797          	auipc	a5,0x8e
ffffffffc02081d0:	6f47b783          	ld	a5,1780(a5) # ffffffffc02968c0 <current>
ffffffffc02081d4:	1487b783          	ld	a5,328(a5)
ffffffffc02081d8:	7179                	addi	sp,sp,-48
ffffffffc02081da:	ec26                	sd	s1,24(sp)
ffffffffc02081dc:	6384                	ld	s1,0(a5)
ffffffffc02081de:	f406                	sd	ra,40(sp)
ffffffffc02081e0:	f022                	sd	s0,32(sp)
ffffffffc02081e2:	e84a                	sd	s2,16(sp)
ffffffffc02081e4:	ccbd                	beqz	s1,ffffffffc0208262 <vfs_getcwd+0x96>
ffffffffc02081e6:	892a                	mv	s2,a0
ffffffffc02081e8:	8526                	mv	a0,s1
ffffffffc02081ea:	c24ff0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc02081ee:	74a8                	ld	a0,104(s1)
ffffffffc02081f0:	c93d                	beqz	a0,ffffffffc0208266 <vfs_getcwd+0x9a>
ffffffffc02081f2:	9b3ff0ef          	jal	ra,ffffffffc0207ba4 <vfs_get_devname>
ffffffffc02081f6:	842a                	mv	s0,a0
ffffffffc02081f8:	7b7020ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc02081fc:	862a                	mv	a2,a0
ffffffffc02081fe:	85a2                	mv	a1,s0
ffffffffc0208200:	4701                	li	a4,0
ffffffffc0208202:	4685                	li	a3,1
ffffffffc0208204:	854a                	mv	a0,s2
ffffffffc0208206:	944fd0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc020820a:	842a                	mv	s0,a0
ffffffffc020820c:	c919                	beqz	a0,ffffffffc0208222 <vfs_getcwd+0x56>
ffffffffc020820e:	8526                	mv	a0,s1
ffffffffc0208210:	cccff0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc0208214:	70a2                	ld	ra,40(sp)
ffffffffc0208216:	8522                	mv	a0,s0
ffffffffc0208218:	7402                	ld	s0,32(sp)
ffffffffc020821a:	64e2                	ld	s1,24(sp)
ffffffffc020821c:	6942                	ld	s2,16(sp)
ffffffffc020821e:	6145                	addi	sp,sp,48
ffffffffc0208220:	8082                	ret
ffffffffc0208222:	03a00793          	li	a5,58
ffffffffc0208226:	4701                	li	a4,0
ffffffffc0208228:	4685                	li	a3,1
ffffffffc020822a:	4605                	li	a2,1
ffffffffc020822c:	00f10593          	addi	a1,sp,15
ffffffffc0208230:	854a                	mv	a0,s2
ffffffffc0208232:	00f107a3          	sb	a5,15(sp)
ffffffffc0208236:	914fd0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc020823a:	842a                	mv	s0,a0
ffffffffc020823c:	f969                	bnez	a0,ffffffffc020820e <vfs_getcwd+0x42>
ffffffffc020823e:	78bc                	ld	a5,112(s1)
ffffffffc0208240:	c3b9                	beqz	a5,ffffffffc0208286 <vfs_getcwd+0xba>
ffffffffc0208242:	7f9c                	ld	a5,56(a5)
ffffffffc0208244:	c3a9                	beqz	a5,ffffffffc0208286 <vfs_getcwd+0xba>
ffffffffc0208246:	00006597          	auipc	a1,0x6
ffffffffc020824a:	32258593          	addi	a1,a1,802 # ffffffffc020e568 <syscalls+0xe10>
ffffffffc020824e:	8526                	mv	a0,s1
ffffffffc0208250:	bd6ff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0208254:	78bc                	ld	a5,112(s1)
ffffffffc0208256:	85ca                	mv	a1,s2
ffffffffc0208258:	8526                	mv	a0,s1
ffffffffc020825a:	7f9c                	ld	a5,56(a5)
ffffffffc020825c:	9782                	jalr	a5
ffffffffc020825e:	842a                	mv	s0,a0
ffffffffc0208260:	b77d                	j	ffffffffc020820e <vfs_getcwd+0x42>
ffffffffc0208262:	5441                	li	s0,-16
ffffffffc0208264:	bf45                	j	ffffffffc0208214 <vfs_getcwd+0x48>
ffffffffc0208266:	00006697          	auipc	a3,0x6
ffffffffc020826a:	1ca68693          	addi	a3,a3,458 # ffffffffc020e430 <syscalls+0xcd8>
ffffffffc020826e:	00003617          	auipc	a2,0x3
ffffffffc0208272:	4ca60613          	addi	a2,a2,1226 # ffffffffc020b738 <commands+0x210>
ffffffffc0208276:	06e00593          	li	a1,110
ffffffffc020827a:	00006517          	auipc	a0,0x6
ffffffffc020827e:	27650513          	addi	a0,a0,630 # ffffffffc020e4f0 <syscalls+0xd98>
ffffffffc0208282:	a1cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208286:	00006697          	auipc	a3,0x6
ffffffffc020828a:	28a68693          	addi	a3,a3,650 # ffffffffc020e510 <syscalls+0xdb8>
ffffffffc020828e:	00003617          	auipc	a2,0x3
ffffffffc0208292:	4aa60613          	addi	a2,a2,1194 # ffffffffc020b738 <commands+0x210>
ffffffffc0208296:	07800593          	li	a1,120
ffffffffc020829a:	00006517          	auipc	a0,0x6
ffffffffc020829e:	25650513          	addi	a0,a0,598 # ffffffffc020e4f0 <syscalls+0xd98>
ffffffffc02082a2:	9fcf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02082a6 <dev_lookup>:
ffffffffc02082a6:	0005c783          	lbu	a5,0(a1)
ffffffffc02082aa:	e385                	bnez	a5,ffffffffc02082ca <dev_lookup+0x24>
ffffffffc02082ac:	1101                	addi	sp,sp,-32
ffffffffc02082ae:	e822                	sd	s0,16(sp)
ffffffffc02082b0:	e426                	sd	s1,8(sp)
ffffffffc02082b2:	ec06                	sd	ra,24(sp)
ffffffffc02082b4:	84aa                	mv	s1,a0
ffffffffc02082b6:	8432                	mv	s0,a2
ffffffffc02082b8:	b56ff0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc02082bc:	60e2                	ld	ra,24(sp)
ffffffffc02082be:	e004                	sd	s1,0(s0)
ffffffffc02082c0:	6442                	ld	s0,16(sp)
ffffffffc02082c2:	64a2                	ld	s1,8(sp)
ffffffffc02082c4:	4501                	li	a0,0
ffffffffc02082c6:	6105                	addi	sp,sp,32
ffffffffc02082c8:	8082                	ret
ffffffffc02082ca:	5541                	li	a0,-16
ffffffffc02082cc:	8082                	ret

ffffffffc02082ce <dev_fstat>:
ffffffffc02082ce:	1101                	addi	sp,sp,-32
ffffffffc02082d0:	e426                	sd	s1,8(sp)
ffffffffc02082d2:	84ae                	mv	s1,a1
ffffffffc02082d4:	e822                	sd	s0,16(sp)
ffffffffc02082d6:	02000613          	li	a2,32
ffffffffc02082da:	842a                	mv	s0,a0
ffffffffc02082dc:	4581                	li	a1,0
ffffffffc02082de:	8526                	mv	a0,s1
ffffffffc02082e0:	ec06                	sd	ra,24(sp)
ffffffffc02082e2:	76f020ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc02082e6:	c429                	beqz	s0,ffffffffc0208330 <dev_fstat+0x62>
ffffffffc02082e8:	783c                	ld	a5,112(s0)
ffffffffc02082ea:	c3b9                	beqz	a5,ffffffffc0208330 <dev_fstat+0x62>
ffffffffc02082ec:	6bbc                	ld	a5,80(a5)
ffffffffc02082ee:	c3a9                	beqz	a5,ffffffffc0208330 <dev_fstat+0x62>
ffffffffc02082f0:	00006597          	auipc	a1,0x6
ffffffffc02082f4:	21858593          	addi	a1,a1,536 # ffffffffc020e508 <syscalls+0xdb0>
ffffffffc02082f8:	8522                	mv	a0,s0
ffffffffc02082fa:	b2cff0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc02082fe:	783c                	ld	a5,112(s0)
ffffffffc0208300:	85a6                	mv	a1,s1
ffffffffc0208302:	8522                	mv	a0,s0
ffffffffc0208304:	6bbc                	ld	a5,80(a5)
ffffffffc0208306:	9782                	jalr	a5
ffffffffc0208308:	ed19                	bnez	a0,ffffffffc0208326 <dev_fstat+0x58>
ffffffffc020830a:	4c38                	lw	a4,88(s0)
ffffffffc020830c:	6785                	lui	a5,0x1
ffffffffc020830e:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208312:	02f71f63          	bne	a4,a5,ffffffffc0208350 <dev_fstat+0x82>
ffffffffc0208316:	6018                	ld	a4,0(s0)
ffffffffc0208318:	641c                	ld	a5,8(s0)
ffffffffc020831a:	4685                	li	a3,1
ffffffffc020831c:	e494                	sd	a3,8(s1)
ffffffffc020831e:	02e787b3          	mul	a5,a5,a4
ffffffffc0208322:	e898                	sd	a4,16(s1)
ffffffffc0208324:	ec9c                	sd	a5,24(s1)
ffffffffc0208326:	60e2                	ld	ra,24(sp)
ffffffffc0208328:	6442                	ld	s0,16(sp)
ffffffffc020832a:	64a2                	ld	s1,8(sp)
ffffffffc020832c:	6105                	addi	sp,sp,32
ffffffffc020832e:	8082                	ret
ffffffffc0208330:	00006697          	auipc	a3,0x6
ffffffffc0208334:	17068693          	addi	a3,a3,368 # ffffffffc020e4a0 <syscalls+0xd48>
ffffffffc0208338:	00003617          	auipc	a2,0x3
ffffffffc020833c:	40060613          	addi	a2,a2,1024 # ffffffffc020b738 <commands+0x210>
ffffffffc0208340:	04200593          	li	a1,66
ffffffffc0208344:	00006517          	auipc	a0,0x6
ffffffffc0208348:	23450513          	addi	a0,a0,564 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc020834c:	952f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208350:	00006697          	auipc	a3,0x6
ffffffffc0208354:	f1868693          	addi	a3,a3,-232 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc0208358:	00003617          	auipc	a2,0x3
ffffffffc020835c:	3e060613          	addi	a2,a2,992 # ffffffffc020b738 <commands+0x210>
ffffffffc0208360:	04500593          	li	a1,69
ffffffffc0208364:	00006517          	auipc	a0,0x6
ffffffffc0208368:	21450513          	addi	a0,a0,532 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc020836c:	932f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208370 <dev_ioctl>:
ffffffffc0208370:	c909                	beqz	a0,ffffffffc0208382 <dev_ioctl+0x12>
ffffffffc0208372:	4d34                	lw	a3,88(a0)
ffffffffc0208374:	6705                	lui	a4,0x1
ffffffffc0208376:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020837a:	00e69463          	bne	a3,a4,ffffffffc0208382 <dev_ioctl+0x12>
ffffffffc020837e:	751c                	ld	a5,40(a0)
ffffffffc0208380:	8782                	jr	a5
ffffffffc0208382:	1141                	addi	sp,sp,-16
ffffffffc0208384:	00006697          	auipc	a3,0x6
ffffffffc0208388:	ee468693          	addi	a3,a3,-284 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc020838c:	00003617          	auipc	a2,0x3
ffffffffc0208390:	3ac60613          	addi	a2,a2,940 # ffffffffc020b738 <commands+0x210>
ffffffffc0208394:	03500593          	li	a1,53
ffffffffc0208398:	00006517          	auipc	a0,0x6
ffffffffc020839c:	1e050513          	addi	a0,a0,480 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc02083a0:	e406                	sd	ra,8(sp)
ffffffffc02083a2:	8fcf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02083a6 <dev_tryseek>:
ffffffffc02083a6:	c51d                	beqz	a0,ffffffffc02083d4 <dev_tryseek+0x2e>
ffffffffc02083a8:	4d38                	lw	a4,88(a0)
ffffffffc02083aa:	6785                	lui	a5,0x1
ffffffffc02083ac:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02083b0:	02f71263          	bne	a4,a5,ffffffffc02083d4 <dev_tryseek+0x2e>
ffffffffc02083b4:	611c                	ld	a5,0(a0)
ffffffffc02083b6:	cf89                	beqz	a5,ffffffffc02083d0 <dev_tryseek+0x2a>
ffffffffc02083b8:	6518                	ld	a4,8(a0)
ffffffffc02083ba:	02e5f6b3          	remu	a3,a1,a4
ffffffffc02083be:	ea89                	bnez	a3,ffffffffc02083d0 <dev_tryseek+0x2a>
ffffffffc02083c0:	0005c863          	bltz	a1,ffffffffc02083d0 <dev_tryseek+0x2a>
ffffffffc02083c4:	02e787b3          	mul	a5,a5,a4
ffffffffc02083c8:	00f5f463          	bgeu	a1,a5,ffffffffc02083d0 <dev_tryseek+0x2a>
ffffffffc02083cc:	4501                	li	a0,0
ffffffffc02083ce:	8082                	ret
ffffffffc02083d0:	5575                	li	a0,-3
ffffffffc02083d2:	8082                	ret
ffffffffc02083d4:	1141                	addi	sp,sp,-16
ffffffffc02083d6:	00006697          	auipc	a3,0x6
ffffffffc02083da:	e9268693          	addi	a3,a3,-366 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc02083de:	00003617          	auipc	a2,0x3
ffffffffc02083e2:	35a60613          	addi	a2,a2,858 # ffffffffc020b738 <commands+0x210>
ffffffffc02083e6:	05f00593          	li	a1,95
ffffffffc02083ea:	00006517          	auipc	a0,0x6
ffffffffc02083ee:	18e50513          	addi	a0,a0,398 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc02083f2:	e406                	sd	ra,8(sp)
ffffffffc02083f4:	8aaf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02083f8 <dev_gettype>:
ffffffffc02083f8:	c10d                	beqz	a0,ffffffffc020841a <dev_gettype+0x22>
ffffffffc02083fa:	4d38                	lw	a4,88(a0)
ffffffffc02083fc:	6785                	lui	a5,0x1
ffffffffc02083fe:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208402:	00f71c63          	bne	a4,a5,ffffffffc020841a <dev_gettype+0x22>
ffffffffc0208406:	6118                	ld	a4,0(a0)
ffffffffc0208408:	6795                	lui	a5,0x5
ffffffffc020840a:	c701                	beqz	a4,ffffffffc0208412 <dev_gettype+0x1a>
ffffffffc020840c:	c19c                	sw	a5,0(a1)
ffffffffc020840e:	4501                	li	a0,0
ffffffffc0208410:	8082                	ret
ffffffffc0208412:	6791                	lui	a5,0x4
ffffffffc0208414:	c19c                	sw	a5,0(a1)
ffffffffc0208416:	4501                	li	a0,0
ffffffffc0208418:	8082                	ret
ffffffffc020841a:	1141                	addi	sp,sp,-16
ffffffffc020841c:	00006697          	auipc	a3,0x6
ffffffffc0208420:	e4c68693          	addi	a3,a3,-436 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc0208424:	00003617          	auipc	a2,0x3
ffffffffc0208428:	31460613          	addi	a2,a2,788 # ffffffffc020b738 <commands+0x210>
ffffffffc020842c:	05300593          	li	a1,83
ffffffffc0208430:	00006517          	auipc	a0,0x6
ffffffffc0208434:	14850513          	addi	a0,a0,328 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc0208438:	e406                	sd	ra,8(sp)
ffffffffc020843a:	864f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020843e <dev_write>:
ffffffffc020843e:	c911                	beqz	a0,ffffffffc0208452 <dev_write+0x14>
ffffffffc0208440:	4d34                	lw	a3,88(a0)
ffffffffc0208442:	6705                	lui	a4,0x1
ffffffffc0208444:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208448:	00e69563          	bne	a3,a4,ffffffffc0208452 <dev_write+0x14>
ffffffffc020844c:	711c                	ld	a5,32(a0)
ffffffffc020844e:	4605                	li	a2,1
ffffffffc0208450:	8782                	jr	a5
ffffffffc0208452:	1141                	addi	sp,sp,-16
ffffffffc0208454:	00006697          	auipc	a3,0x6
ffffffffc0208458:	e1468693          	addi	a3,a3,-492 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc020845c:	00003617          	auipc	a2,0x3
ffffffffc0208460:	2dc60613          	addi	a2,a2,732 # ffffffffc020b738 <commands+0x210>
ffffffffc0208464:	02c00593          	li	a1,44
ffffffffc0208468:	00006517          	auipc	a0,0x6
ffffffffc020846c:	11050513          	addi	a0,a0,272 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc0208470:	e406                	sd	ra,8(sp)
ffffffffc0208472:	82cf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208476 <dev_read>:
ffffffffc0208476:	c911                	beqz	a0,ffffffffc020848a <dev_read+0x14>
ffffffffc0208478:	4d34                	lw	a3,88(a0)
ffffffffc020847a:	6705                	lui	a4,0x1
ffffffffc020847c:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208480:	00e69563          	bne	a3,a4,ffffffffc020848a <dev_read+0x14>
ffffffffc0208484:	711c                	ld	a5,32(a0)
ffffffffc0208486:	4601                	li	a2,0
ffffffffc0208488:	8782                	jr	a5
ffffffffc020848a:	1141                	addi	sp,sp,-16
ffffffffc020848c:	00006697          	auipc	a3,0x6
ffffffffc0208490:	ddc68693          	addi	a3,a3,-548 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc0208494:	00003617          	auipc	a2,0x3
ffffffffc0208498:	2a460613          	addi	a2,a2,676 # ffffffffc020b738 <commands+0x210>
ffffffffc020849c:	02300593          	li	a1,35
ffffffffc02084a0:	00006517          	auipc	a0,0x6
ffffffffc02084a4:	0d850513          	addi	a0,a0,216 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc02084a8:	e406                	sd	ra,8(sp)
ffffffffc02084aa:	ff5f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02084ae <dev_close>:
ffffffffc02084ae:	c909                	beqz	a0,ffffffffc02084c0 <dev_close+0x12>
ffffffffc02084b0:	4d34                	lw	a3,88(a0)
ffffffffc02084b2:	6705                	lui	a4,0x1
ffffffffc02084b4:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02084b8:	00e69463          	bne	a3,a4,ffffffffc02084c0 <dev_close+0x12>
ffffffffc02084bc:	6d1c                	ld	a5,24(a0)
ffffffffc02084be:	8782                	jr	a5
ffffffffc02084c0:	1141                	addi	sp,sp,-16
ffffffffc02084c2:	00006697          	auipc	a3,0x6
ffffffffc02084c6:	da668693          	addi	a3,a3,-602 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc02084ca:	00003617          	auipc	a2,0x3
ffffffffc02084ce:	26e60613          	addi	a2,a2,622 # ffffffffc020b738 <commands+0x210>
ffffffffc02084d2:	45e9                	li	a1,26
ffffffffc02084d4:	00006517          	auipc	a0,0x6
ffffffffc02084d8:	0a450513          	addi	a0,a0,164 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc02084dc:	e406                	sd	ra,8(sp)
ffffffffc02084de:	fc1f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02084e2 <dev_open>:
ffffffffc02084e2:	03c5f713          	andi	a4,a1,60
ffffffffc02084e6:	eb11                	bnez	a4,ffffffffc02084fa <dev_open+0x18>
ffffffffc02084e8:	c919                	beqz	a0,ffffffffc02084fe <dev_open+0x1c>
ffffffffc02084ea:	4d34                	lw	a3,88(a0)
ffffffffc02084ec:	6705                	lui	a4,0x1
ffffffffc02084ee:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02084f2:	00e69663          	bne	a3,a4,ffffffffc02084fe <dev_open+0x1c>
ffffffffc02084f6:	691c                	ld	a5,16(a0)
ffffffffc02084f8:	8782                	jr	a5
ffffffffc02084fa:	5575                	li	a0,-3
ffffffffc02084fc:	8082                	ret
ffffffffc02084fe:	1141                	addi	sp,sp,-16
ffffffffc0208500:	00006697          	auipc	a3,0x6
ffffffffc0208504:	d6868693          	addi	a3,a3,-664 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc0208508:	00003617          	auipc	a2,0x3
ffffffffc020850c:	23060613          	addi	a2,a2,560 # ffffffffc020b738 <commands+0x210>
ffffffffc0208510:	45c5                	li	a1,17
ffffffffc0208512:	00006517          	auipc	a0,0x6
ffffffffc0208516:	06650513          	addi	a0,a0,102 # ffffffffc020e578 <syscalls+0xe20>
ffffffffc020851a:	e406                	sd	ra,8(sp)
ffffffffc020851c:	f83f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208520 <dev_init>:
ffffffffc0208520:	1141                	addi	sp,sp,-16
ffffffffc0208522:	e406                	sd	ra,8(sp)
ffffffffc0208524:	542000ef          	jal	ra,ffffffffc0208a66 <dev_init_stdin>
ffffffffc0208528:	65a000ef          	jal	ra,ffffffffc0208b82 <dev_init_stdout>
ffffffffc020852c:	60a2                	ld	ra,8(sp)
ffffffffc020852e:	0141                	addi	sp,sp,16
ffffffffc0208530:	a439                	j	ffffffffc020873e <dev_init_disk0>

ffffffffc0208532 <dev_create_inode>:
ffffffffc0208532:	6505                	lui	a0,0x1
ffffffffc0208534:	1141                	addi	sp,sp,-16
ffffffffc0208536:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020853a:	e022                	sd	s0,0(sp)
ffffffffc020853c:	e406                	sd	ra,8(sp)
ffffffffc020853e:	852ff0ef          	jal	ra,ffffffffc0207590 <__alloc_inode>
ffffffffc0208542:	842a                	mv	s0,a0
ffffffffc0208544:	c901                	beqz	a0,ffffffffc0208554 <dev_create_inode+0x22>
ffffffffc0208546:	4601                	li	a2,0
ffffffffc0208548:	00006597          	auipc	a1,0x6
ffffffffc020854c:	04858593          	addi	a1,a1,72 # ffffffffc020e590 <dev_node_ops>
ffffffffc0208550:	85cff0ef          	jal	ra,ffffffffc02075ac <inode_init>
ffffffffc0208554:	60a2                	ld	ra,8(sp)
ffffffffc0208556:	8522                	mv	a0,s0
ffffffffc0208558:	6402                	ld	s0,0(sp)
ffffffffc020855a:	0141                	addi	sp,sp,16
ffffffffc020855c:	8082                	ret

ffffffffc020855e <disk0_open>:
ffffffffc020855e:	4501                	li	a0,0
ffffffffc0208560:	8082                	ret

ffffffffc0208562 <disk0_close>:
ffffffffc0208562:	4501                	li	a0,0
ffffffffc0208564:	8082                	ret

ffffffffc0208566 <disk0_ioctl>:
ffffffffc0208566:	5531                	li	a0,-20
ffffffffc0208568:	8082                	ret

ffffffffc020856a <disk0_io>:
ffffffffc020856a:	659c                	ld	a5,8(a1)
ffffffffc020856c:	7159                	addi	sp,sp,-112
ffffffffc020856e:	eca6                	sd	s1,88(sp)
ffffffffc0208570:	f45e                	sd	s7,40(sp)
ffffffffc0208572:	6d84                	ld	s1,24(a1)
ffffffffc0208574:	6b85                	lui	s7,0x1
ffffffffc0208576:	1bfd                	addi	s7,s7,-1
ffffffffc0208578:	e4ce                	sd	s3,72(sp)
ffffffffc020857a:	43f7d993          	srai	s3,a5,0x3f
ffffffffc020857e:	0179f9b3          	and	s3,s3,s7
ffffffffc0208582:	99be                	add	s3,s3,a5
ffffffffc0208584:	8fc5                	or	a5,a5,s1
ffffffffc0208586:	f486                	sd	ra,104(sp)
ffffffffc0208588:	f0a2                	sd	s0,96(sp)
ffffffffc020858a:	e8ca                	sd	s2,80(sp)
ffffffffc020858c:	e0d2                	sd	s4,64(sp)
ffffffffc020858e:	fc56                	sd	s5,56(sp)
ffffffffc0208590:	f85a                	sd	s6,48(sp)
ffffffffc0208592:	f062                	sd	s8,32(sp)
ffffffffc0208594:	ec66                	sd	s9,24(sp)
ffffffffc0208596:	e86a                	sd	s10,16(sp)
ffffffffc0208598:	0177f7b3          	and	a5,a5,s7
ffffffffc020859c:	10079d63          	bnez	a5,ffffffffc02086b6 <disk0_io+0x14c>
ffffffffc02085a0:	40c9d993          	srai	s3,s3,0xc
ffffffffc02085a4:	00c4d713          	srli	a4,s1,0xc
ffffffffc02085a8:	2981                	sext.w	s3,s3
ffffffffc02085aa:	2701                	sext.w	a4,a4
ffffffffc02085ac:	00e987bb          	addw	a5,s3,a4
ffffffffc02085b0:	6114                	ld	a3,0(a0)
ffffffffc02085b2:	1782                	slli	a5,a5,0x20
ffffffffc02085b4:	9381                	srli	a5,a5,0x20
ffffffffc02085b6:	10f6e063          	bltu	a3,a5,ffffffffc02086b6 <disk0_io+0x14c>
ffffffffc02085ba:	4501                	li	a0,0
ffffffffc02085bc:	ef19                	bnez	a4,ffffffffc02085da <disk0_io+0x70>
ffffffffc02085be:	70a6                	ld	ra,104(sp)
ffffffffc02085c0:	7406                	ld	s0,96(sp)
ffffffffc02085c2:	64e6                	ld	s1,88(sp)
ffffffffc02085c4:	6946                	ld	s2,80(sp)
ffffffffc02085c6:	69a6                	ld	s3,72(sp)
ffffffffc02085c8:	6a06                	ld	s4,64(sp)
ffffffffc02085ca:	7ae2                	ld	s5,56(sp)
ffffffffc02085cc:	7b42                	ld	s6,48(sp)
ffffffffc02085ce:	7ba2                	ld	s7,40(sp)
ffffffffc02085d0:	7c02                	ld	s8,32(sp)
ffffffffc02085d2:	6ce2                	ld	s9,24(sp)
ffffffffc02085d4:	6d42                	ld	s10,16(sp)
ffffffffc02085d6:	6165                	addi	sp,sp,112
ffffffffc02085d8:	8082                	ret
ffffffffc02085da:	0008d517          	auipc	a0,0x8d
ffffffffc02085de:	26650513          	addi	a0,a0,614 # ffffffffc0295840 <disk0_sem>
ffffffffc02085e2:	8b2e                	mv	s6,a1
ffffffffc02085e4:	8c32                	mv	s8,a2
ffffffffc02085e6:	0008ea97          	auipc	s5,0x8e
ffffffffc02085ea:	312a8a93          	addi	s5,s5,786 # ffffffffc02968f8 <disk0_buffer>
ffffffffc02085ee:	ed5fb0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02085f2:	6c91                	lui	s9,0x4
ffffffffc02085f4:	e4b9                	bnez	s1,ffffffffc0208642 <disk0_io+0xd8>
ffffffffc02085f6:	a845                	j	ffffffffc02086a6 <disk0_io+0x13c>
ffffffffc02085f8:	00c4d413          	srli	s0,s1,0xc
ffffffffc02085fc:	0034169b          	slliw	a3,s0,0x3
ffffffffc0208600:	00068d1b          	sext.w	s10,a3
ffffffffc0208604:	1682                	slli	a3,a3,0x20
ffffffffc0208606:	2401                	sext.w	s0,s0
ffffffffc0208608:	9281                	srli	a3,a3,0x20
ffffffffc020860a:	8926                	mv	s2,s1
ffffffffc020860c:	00399a1b          	slliw	s4,s3,0x3
ffffffffc0208610:	862e                	mv	a2,a1
ffffffffc0208612:	4509                	li	a0,2
ffffffffc0208614:	85d2                	mv	a1,s4
ffffffffc0208616:	d2af80ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc020861a:	e165                	bnez	a0,ffffffffc02086fa <disk0_io+0x190>
ffffffffc020861c:	000ab583          	ld	a1,0(s5)
ffffffffc0208620:	0038                	addi	a4,sp,8
ffffffffc0208622:	4685                	li	a3,1
ffffffffc0208624:	864a                	mv	a2,s2
ffffffffc0208626:	855a                	mv	a0,s6
ffffffffc0208628:	d23fc0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc020862c:	67a2                	ld	a5,8(sp)
ffffffffc020862e:	09279663          	bne	a5,s2,ffffffffc02086ba <disk0_io+0x150>
ffffffffc0208632:	017977b3          	and	a5,s2,s7
ffffffffc0208636:	e3d1                	bnez	a5,ffffffffc02086ba <disk0_io+0x150>
ffffffffc0208638:	412484b3          	sub	s1,s1,s2
ffffffffc020863c:	013409bb          	addw	s3,s0,s3
ffffffffc0208640:	c0bd                	beqz	s1,ffffffffc02086a6 <disk0_io+0x13c>
ffffffffc0208642:	000ab583          	ld	a1,0(s5)
ffffffffc0208646:	000c1b63          	bnez	s8,ffffffffc020865c <disk0_io+0xf2>
ffffffffc020864a:	fb94e7e3          	bltu	s1,s9,ffffffffc02085f8 <disk0_io+0x8e>
ffffffffc020864e:	02000693          	li	a3,32
ffffffffc0208652:	02000d13          	li	s10,32
ffffffffc0208656:	4411                	li	s0,4
ffffffffc0208658:	6911                	lui	s2,0x4
ffffffffc020865a:	bf4d                	j	ffffffffc020860c <disk0_io+0xa2>
ffffffffc020865c:	0038                	addi	a4,sp,8
ffffffffc020865e:	4681                	li	a3,0
ffffffffc0208660:	6611                	lui	a2,0x4
ffffffffc0208662:	855a                	mv	a0,s6
ffffffffc0208664:	ce7fc0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc0208668:	6422                	ld	s0,8(sp)
ffffffffc020866a:	c825                	beqz	s0,ffffffffc02086da <disk0_io+0x170>
ffffffffc020866c:	0684e763          	bltu	s1,s0,ffffffffc02086da <disk0_io+0x170>
ffffffffc0208670:	017477b3          	and	a5,s0,s7
ffffffffc0208674:	e3bd                	bnez	a5,ffffffffc02086da <disk0_io+0x170>
ffffffffc0208676:	8031                	srli	s0,s0,0xc
ffffffffc0208678:	0034179b          	slliw	a5,s0,0x3
ffffffffc020867c:	000ab603          	ld	a2,0(s5)
ffffffffc0208680:	0039991b          	slliw	s2,s3,0x3
ffffffffc0208684:	02079693          	slli	a3,a5,0x20
ffffffffc0208688:	9281                	srli	a3,a3,0x20
ffffffffc020868a:	85ca                	mv	a1,s2
ffffffffc020868c:	4509                	li	a0,2
ffffffffc020868e:	2401                	sext.w	s0,s0
ffffffffc0208690:	00078a1b          	sext.w	s4,a5
ffffffffc0208694:	d42f80ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc0208698:	e151                	bnez	a0,ffffffffc020871c <disk0_io+0x1b2>
ffffffffc020869a:	6922                	ld	s2,8(sp)
ffffffffc020869c:	013409bb          	addw	s3,s0,s3
ffffffffc02086a0:	412484b3          	sub	s1,s1,s2
ffffffffc02086a4:	fcd9                	bnez	s1,ffffffffc0208642 <disk0_io+0xd8>
ffffffffc02086a6:	0008d517          	auipc	a0,0x8d
ffffffffc02086aa:	19a50513          	addi	a0,a0,410 # ffffffffc0295840 <disk0_sem>
ffffffffc02086ae:	e11fb0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02086b2:	4501                	li	a0,0
ffffffffc02086b4:	b729                	j	ffffffffc02085be <disk0_io+0x54>
ffffffffc02086b6:	5575                	li	a0,-3
ffffffffc02086b8:	b719                	j	ffffffffc02085be <disk0_io+0x54>
ffffffffc02086ba:	00006697          	auipc	a3,0x6
ffffffffc02086be:	04e68693          	addi	a3,a3,78 # ffffffffc020e708 <dev_node_ops+0x178>
ffffffffc02086c2:	00003617          	auipc	a2,0x3
ffffffffc02086c6:	07660613          	addi	a2,a2,118 # ffffffffc020b738 <commands+0x210>
ffffffffc02086ca:	06200593          	li	a1,98
ffffffffc02086ce:	00006517          	auipc	a0,0x6
ffffffffc02086d2:	f8250513          	addi	a0,a0,-126 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc02086d6:	dc9f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02086da:	00006697          	auipc	a3,0x6
ffffffffc02086de:	f3668693          	addi	a3,a3,-202 # ffffffffc020e610 <dev_node_ops+0x80>
ffffffffc02086e2:	00003617          	auipc	a2,0x3
ffffffffc02086e6:	05660613          	addi	a2,a2,86 # ffffffffc020b738 <commands+0x210>
ffffffffc02086ea:	05700593          	li	a1,87
ffffffffc02086ee:	00006517          	auipc	a0,0x6
ffffffffc02086f2:	f6250513          	addi	a0,a0,-158 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc02086f6:	da9f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02086fa:	88aa                	mv	a7,a0
ffffffffc02086fc:	886a                	mv	a6,s10
ffffffffc02086fe:	87a2                	mv	a5,s0
ffffffffc0208700:	8752                	mv	a4,s4
ffffffffc0208702:	86ce                	mv	a3,s3
ffffffffc0208704:	00006617          	auipc	a2,0x6
ffffffffc0208708:	fbc60613          	addi	a2,a2,-68 # ffffffffc020e6c0 <dev_node_ops+0x130>
ffffffffc020870c:	02d00593          	li	a1,45
ffffffffc0208710:	00006517          	auipc	a0,0x6
ffffffffc0208714:	f4050513          	addi	a0,a0,-192 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc0208718:	d87f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020871c:	88aa                	mv	a7,a0
ffffffffc020871e:	8852                	mv	a6,s4
ffffffffc0208720:	87a2                	mv	a5,s0
ffffffffc0208722:	874a                	mv	a4,s2
ffffffffc0208724:	86ce                	mv	a3,s3
ffffffffc0208726:	00006617          	auipc	a2,0x6
ffffffffc020872a:	f4a60613          	addi	a2,a2,-182 # ffffffffc020e670 <dev_node_ops+0xe0>
ffffffffc020872e:	03700593          	li	a1,55
ffffffffc0208732:	00006517          	auipc	a0,0x6
ffffffffc0208736:	f1e50513          	addi	a0,a0,-226 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc020873a:	d65f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020873e <dev_init_disk0>:
ffffffffc020873e:	1101                	addi	sp,sp,-32
ffffffffc0208740:	ec06                	sd	ra,24(sp)
ffffffffc0208742:	e822                	sd	s0,16(sp)
ffffffffc0208744:	e426                	sd	s1,8(sp)
ffffffffc0208746:	dedff0ef          	jal	ra,ffffffffc0208532 <dev_create_inode>
ffffffffc020874a:	c541                	beqz	a0,ffffffffc02087d2 <dev_init_disk0+0x94>
ffffffffc020874c:	4d38                	lw	a4,88(a0)
ffffffffc020874e:	6485                	lui	s1,0x1
ffffffffc0208750:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208754:	842a                	mv	s0,a0
ffffffffc0208756:	0cf71f63          	bne	a4,a5,ffffffffc0208834 <dev_init_disk0+0xf6>
ffffffffc020875a:	4509                	li	a0,2
ffffffffc020875c:	b98f80ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc0208760:	cd55                	beqz	a0,ffffffffc020881c <dev_init_disk0+0xde>
ffffffffc0208762:	4509                	li	a0,2
ffffffffc0208764:	bb4f80ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc0208768:	00355793          	srli	a5,a0,0x3
ffffffffc020876c:	e01c                	sd	a5,0(s0)
ffffffffc020876e:	00000797          	auipc	a5,0x0
ffffffffc0208772:	df078793          	addi	a5,a5,-528 # ffffffffc020855e <disk0_open>
ffffffffc0208776:	e81c                	sd	a5,16(s0)
ffffffffc0208778:	00000797          	auipc	a5,0x0
ffffffffc020877c:	dea78793          	addi	a5,a5,-534 # ffffffffc0208562 <disk0_close>
ffffffffc0208780:	ec1c                	sd	a5,24(s0)
ffffffffc0208782:	00000797          	auipc	a5,0x0
ffffffffc0208786:	de878793          	addi	a5,a5,-536 # ffffffffc020856a <disk0_io>
ffffffffc020878a:	f01c                	sd	a5,32(s0)
ffffffffc020878c:	00000797          	auipc	a5,0x0
ffffffffc0208790:	dda78793          	addi	a5,a5,-550 # ffffffffc0208566 <disk0_ioctl>
ffffffffc0208794:	f41c                	sd	a5,40(s0)
ffffffffc0208796:	4585                	li	a1,1
ffffffffc0208798:	0008d517          	auipc	a0,0x8d
ffffffffc020879c:	0a850513          	addi	a0,a0,168 # ffffffffc0295840 <disk0_sem>
ffffffffc02087a0:	e404                	sd	s1,8(s0)
ffffffffc02087a2:	d17fb0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc02087a6:	6511                	lui	a0,0x4
ffffffffc02087a8:	fe6f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02087ac:	0008e797          	auipc	a5,0x8e
ffffffffc02087b0:	14a7b623          	sd	a0,332(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc02087b4:	c921                	beqz	a0,ffffffffc0208804 <dev_init_disk0+0xc6>
ffffffffc02087b6:	4605                	li	a2,1
ffffffffc02087b8:	85a2                	mv	a1,s0
ffffffffc02087ba:	00006517          	auipc	a0,0x6
ffffffffc02087be:	fde50513          	addi	a0,a0,-34 # ffffffffc020e798 <dev_node_ops+0x208>
ffffffffc02087c2:	c2cff0ef          	jal	ra,ffffffffc0207bee <vfs_add_dev>
ffffffffc02087c6:	e115                	bnez	a0,ffffffffc02087ea <dev_init_disk0+0xac>
ffffffffc02087c8:	60e2                	ld	ra,24(sp)
ffffffffc02087ca:	6442                	ld	s0,16(sp)
ffffffffc02087cc:	64a2                	ld	s1,8(sp)
ffffffffc02087ce:	6105                	addi	sp,sp,32
ffffffffc02087d0:	8082                	ret
ffffffffc02087d2:	00006617          	auipc	a2,0x6
ffffffffc02087d6:	f6660613          	addi	a2,a2,-154 # ffffffffc020e738 <dev_node_ops+0x1a8>
ffffffffc02087da:	08700593          	li	a1,135
ffffffffc02087de:	00006517          	auipc	a0,0x6
ffffffffc02087e2:	e7250513          	addi	a0,a0,-398 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc02087e6:	cb9f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02087ea:	86aa                	mv	a3,a0
ffffffffc02087ec:	00006617          	auipc	a2,0x6
ffffffffc02087f0:	fb460613          	addi	a2,a2,-76 # ffffffffc020e7a0 <dev_node_ops+0x210>
ffffffffc02087f4:	08d00593          	li	a1,141
ffffffffc02087f8:	00006517          	auipc	a0,0x6
ffffffffc02087fc:	e5850513          	addi	a0,a0,-424 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc0208800:	c9ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208804:	00006617          	auipc	a2,0x6
ffffffffc0208808:	f7460613          	addi	a2,a2,-140 # ffffffffc020e778 <dev_node_ops+0x1e8>
ffffffffc020880c:	07f00593          	li	a1,127
ffffffffc0208810:	00006517          	auipc	a0,0x6
ffffffffc0208814:	e4050513          	addi	a0,a0,-448 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc0208818:	c87f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020881c:	00006617          	auipc	a2,0x6
ffffffffc0208820:	f3c60613          	addi	a2,a2,-196 # ffffffffc020e758 <dev_node_ops+0x1c8>
ffffffffc0208824:	07300593          	li	a1,115
ffffffffc0208828:	00006517          	auipc	a0,0x6
ffffffffc020882c:	e2850513          	addi	a0,a0,-472 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc0208830:	c6ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208834:	00006697          	auipc	a3,0x6
ffffffffc0208838:	a3468693          	addi	a3,a3,-1484 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc020883c:	00003617          	auipc	a2,0x3
ffffffffc0208840:	efc60613          	addi	a2,a2,-260 # ffffffffc020b738 <commands+0x210>
ffffffffc0208844:	08900593          	li	a1,137
ffffffffc0208848:	00006517          	auipc	a0,0x6
ffffffffc020884c:	e0850513          	addi	a0,a0,-504 # ffffffffc020e650 <dev_node_ops+0xc0>
ffffffffc0208850:	c4ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208854 <stdin_open>:
ffffffffc0208854:	4501                	li	a0,0
ffffffffc0208856:	e191                	bnez	a1,ffffffffc020885a <stdin_open+0x6>
ffffffffc0208858:	8082                	ret
ffffffffc020885a:	5575                	li	a0,-3
ffffffffc020885c:	8082                	ret

ffffffffc020885e <stdin_close>:
ffffffffc020885e:	4501                	li	a0,0
ffffffffc0208860:	8082                	ret

ffffffffc0208862 <stdin_ioctl>:
ffffffffc0208862:	5575                	li	a0,-3
ffffffffc0208864:	8082                	ret

ffffffffc0208866 <stdin_io>:
ffffffffc0208866:	7135                	addi	sp,sp,-160
ffffffffc0208868:	ed06                	sd	ra,152(sp)
ffffffffc020886a:	e922                	sd	s0,144(sp)
ffffffffc020886c:	e526                	sd	s1,136(sp)
ffffffffc020886e:	e14a                	sd	s2,128(sp)
ffffffffc0208870:	fcce                	sd	s3,120(sp)
ffffffffc0208872:	f8d2                	sd	s4,112(sp)
ffffffffc0208874:	f4d6                	sd	s5,104(sp)
ffffffffc0208876:	f0da                	sd	s6,96(sp)
ffffffffc0208878:	ecde                	sd	s7,88(sp)
ffffffffc020887a:	e8e2                	sd	s8,80(sp)
ffffffffc020887c:	e4e6                	sd	s9,72(sp)
ffffffffc020887e:	e0ea                	sd	s10,64(sp)
ffffffffc0208880:	fc6e                	sd	s11,56(sp)
ffffffffc0208882:	14061163          	bnez	a2,ffffffffc02089c4 <stdin_io+0x15e>
ffffffffc0208886:	0005bd83          	ld	s11,0(a1)
ffffffffc020888a:	0185bd03          	ld	s10,24(a1)
ffffffffc020888e:	8b2e                	mv	s6,a1
ffffffffc0208890:	100027f3          	csrr	a5,sstatus
ffffffffc0208894:	8b89                	andi	a5,a5,2
ffffffffc0208896:	10079e63          	bnez	a5,ffffffffc02089b2 <stdin_io+0x14c>
ffffffffc020889a:	4401                	li	s0,0
ffffffffc020889c:	100d0963          	beqz	s10,ffffffffc02089ae <stdin_io+0x148>
ffffffffc02088a0:	0008e997          	auipc	s3,0x8e
ffffffffc02088a4:	06098993          	addi	s3,s3,96 # ffffffffc0296900 <p_rpos>
ffffffffc02088a8:	0009b783          	ld	a5,0(s3)
ffffffffc02088ac:	800004b7          	lui	s1,0x80000
ffffffffc02088b0:	6c85                	lui	s9,0x1
ffffffffc02088b2:	4a81                	li	s5,0
ffffffffc02088b4:	0008ea17          	auipc	s4,0x8e
ffffffffc02088b8:	054a0a13          	addi	s4,s4,84 # ffffffffc0296908 <p_wpos>
ffffffffc02088bc:	0491                	addi	s1,s1,4
ffffffffc02088be:	0008d917          	auipc	s2,0x8d
ffffffffc02088c2:	f9a90913          	addi	s2,s2,-102 # ffffffffc0295858 <__wait_queue>
ffffffffc02088c6:	1cfd                	addi	s9,s9,-1
ffffffffc02088c8:	000a3703          	ld	a4,0(s4)
ffffffffc02088cc:	000a8c1b          	sext.w	s8,s5
ffffffffc02088d0:	8be2                	mv	s7,s8
ffffffffc02088d2:	02e7d763          	bge	a5,a4,ffffffffc0208900 <stdin_io+0x9a>
ffffffffc02088d6:	a859                	j	ffffffffc020896c <stdin_io+0x106>
ffffffffc02088d8:	815fe0ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc02088dc:	100027f3          	csrr	a5,sstatus
ffffffffc02088e0:	8b89                	andi	a5,a5,2
ffffffffc02088e2:	4401                	li	s0,0
ffffffffc02088e4:	ef8d                	bnez	a5,ffffffffc020891e <stdin_io+0xb8>
ffffffffc02088e6:	0028                	addi	a0,sp,8
ffffffffc02088e8:	c6dfb0ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc02088ec:	e121                	bnez	a0,ffffffffc020892c <stdin_io+0xc6>
ffffffffc02088ee:	47c2                	lw	a5,16(sp)
ffffffffc02088f0:	04979563          	bne	a5,s1,ffffffffc020893a <stdin_io+0xd4>
ffffffffc02088f4:	0009b783          	ld	a5,0(s3)
ffffffffc02088f8:	000a3703          	ld	a4,0(s4)
ffffffffc02088fc:	06e7c863          	blt	a5,a4,ffffffffc020896c <stdin_io+0x106>
ffffffffc0208900:	8626                	mv	a2,s1
ffffffffc0208902:	002c                	addi	a1,sp,8
ffffffffc0208904:	854a                	mv	a0,s2
ffffffffc0208906:	d79fb0ef          	jal	ra,ffffffffc020467e <wait_current_set>
ffffffffc020890a:	d479                	beqz	s0,ffffffffc02088d8 <stdin_io+0x72>
ffffffffc020890c:	b60f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208910:	fdcfe0ef          	jal	ra,ffffffffc02070ec <schedule>
ffffffffc0208914:	100027f3          	csrr	a5,sstatus
ffffffffc0208918:	8b89                	andi	a5,a5,2
ffffffffc020891a:	4401                	li	s0,0
ffffffffc020891c:	d7e9                	beqz	a5,ffffffffc02088e6 <stdin_io+0x80>
ffffffffc020891e:	b54f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208922:	0028                	addi	a0,sp,8
ffffffffc0208924:	4405                	li	s0,1
ffffffffc0208926:	c2ffb0ef          	jal	ra,ffffffffc0204554 <wait_in_queue>
ffffffffc020892a:	d171                	beqz	a0,ffffffffc02088ee <stdin_io+0x88>
ffffffffc020892c:	002c                	addi	a1,sp,8
ffffffffc020892e:	854a                	mv	a0,s2
ffffffffc0208930:	bcbfb0ef          	jal	ra,ffffffffc02044fa <wait_queue_del>
ffffffffc0208934:	47c2                	lw	a5,16(sp)
ffffffffc0208936:	fa978fe3          	beq	a5,s1,ffffffffc02088f4 <stdin_io+0x8e>
ffffffffc020893a:	e435                	bnez	s0,ffffffffc02089a6 <stdin_io+0x140>
ffffffffc020893c:	060b8963          	beqz	s7,ffffffffc02089ae <stdin_io+0x148>
ffffffffc0208940:	018b3783          	ld	a5,24(s6)
ffffffffc0208944:	41578ab3          	sub	s5,a5,s5
ffffffffc0208948:	015b3c23          	sd	s5,24(s6)
ffffffffc020894c:	60ea                	ld	ra,152(sp)
ffffffffc020894e:	644a                	ld	s0,144(sp)
ffffffffc0208950:	64aa                	ld	s1,136(sp)
ffffffffc0208952:	690a                	ld	s2,128(sp)
ffffffffc0208954:	79e6                	ld	s3,120(sp)
ffffffffc0208956:	7a46                	ld	s4,112(sp)
ffffffffc0208958:	7aa6                	ld	s5,104(sp)
ffffffffc020895a:	7b06                	ld	s6,96(sp)
ffffffffc020895c:	6c46                	ld	s8,80(sp)
ffffffffc020895e:	6ca6                	ld	s9,72(sp)
ffffffffc0208960:	6d06                	ld	s10,64(sp)
ffffffffc0208962:	7de2                	ld	s11,56(sp)
ffffffffc0208964:	855e                	mv	a0,s7
ffffffffc0208966:	6be6                	ld	s7,88(sp)
ffffffffc0208968:	610d                	addi	sp,sp,160
ffffffffc020896a:	8082                	ret
ffffffffc020896c:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208970:	03475693          	srli	a3,a4,0x34
ffffffffc0208974:	00d78733          	add	a4,a5,a3
ffffffffc0208978:	01977733          	and	a4,a4,s9
ffffffffc020897c:	8f15                	sub	a4,a4,a3
ffffffffc020897e:	0008d697          	auipc	a3,0x8d
ffffffffc0208982:	eea68693          	addi	a3,a3,-278 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208986:	9736                	add	a4,a4,a3
ffffffffc0208988:	00074683          	lbu	a3,0(a4)
ffffffffc020898c:	0785                	addi	a5,a5,1
ffffffffc020898e:	015d8733          	add	a4,s11,s5
ffffffffc0208992:	00d70023          	sb	a3,0(a4)
ffffffffc0208996:	00f9b023          	sd	a5,0(s3)
ffffffffc020899a:	0a85                	addi	s5,s5,1
ffffffffc020899c:	001c0b9b          	addiw	s7,s8,1
ffffffffc02089a0:	f3aae4e3          	bltu	s5,s10,ffffffffc02088c8 <stdin_io+0x62>
ffffffffc02089a4:	dc51                	beqz	s0,ffffffffc0208940 <stdin_io+0xda>
ffffffffc02089a6:	ac6f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02089aa:	f80b9be3          	bnez	s7,ffffffffc0208940 <stdin_io+0xda>
ffffffffc02089ae:	4b81                	li	s7,0
ffffffffc02089b0:	bf71                	j	ffffffffc020894c <stdin_io+0xe6>
ffffffffc02089b2:	ac0f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02089b6:	4405                	li	s0,1
ffffffffc02089b8:	ee0d14e3          	bnez	s10,ffffffffc02088a0 <stdin_io+0x3a>
ffffffffc02089bc:	ab0f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02089c0:	4b81                	li	s7,0
ffffffffc02089c2:	b769                	j	ffffffffc020894c <stdin_io+0xe6>
ffffffffc02089c4:	5bf5                	li	s7,-3
ffffffffc02089c6:	b759                	j	ffffffffc020894c <stdin_io+0xe6>

ffffffffc02089c8 <dev_stdin_write>:
ffffffffc02089c8:	e111                	bnez	a0,ffffffffc02089cc <dev_stdin_write+0x4>
ffffffffc02089ca:	8082                	ret
ffffffffc02089cc:	1101                	addi	sp,sp,-32
ffffffffc02089ce:	e822                	sd	s0,16(sp)
ffffffffc02089d0:	ec06                	sd	ra,24(sp)
ffffffffc02089d2:	e426                	sd	s1,8(sp)
ffffffffc02089d4:	842a                	mv	s0,a0
ffffffffc02089d6:	100027f3          	csrr	a5,sstatus
ffffffffc02089da:	8b89                	andi	a5,a5,2
ffffffffc02089dc:	4481                	li	s1,0
ffffffffc02089de:	e3c1                	bnez	a5,ffffffffc0208a5e <dev_stdin_write+0x96>
ffffffffc02089e0:	0008e597          	auipc	a1,0x8e
ffffffffc02089e4:	f2858593          	addi	a1,a1,-216 # ffffffffc0296908 <p_wpos>
ffffffffc02089e8:	6198                	ld	a4,0(a1)
ffffffffc02089ea:	6605                	lui	a2,0x1
ffffffffc02089ec:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc02089f0:	43f75693          	srai	a3,a4,0x3f
ffffffffc02089f4:	92d1                	srli	a3,a3,0x34
ffffffffc02089f6:	00d707b3          	add	a5,a4,a3
ffffffffc02089fa:	8fe9                	and	a5,a5,a0
ffffffffc02089fc:	8f95                	sub	a5,a5,a3
ffffffffc02089fe:	0008d697          	auipc	a3,0x8d
ffffffffc0208a02:	e6a68693          	addi	a3,a3,-406 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208a06:	97b6                	add	a5,a5,a3
ffffffffc0208a08:	00878023          	sb	s0,0(a5)
ffffffffc0208a0c:	0008e797          	auipc	a5,0x8e
ffffffffc0208a10:	ef47b783          	ld	a5,-268(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208a14:	40f707b3          	sub	a5,a4,a5
ffffffffc0208a18:	00c7d463          	bge	a5,a2,ffffffffc0208a20 <dev_stdin_write+0x58>
ffffffffc0208a1c:	0705                	addi	a4,a4,1
ffffffffc0208a1e:	e198                	sd	a4,0(a1)
ffffffffc0208a20:	0008d517          	auipc	a0,0x8d
ffffffffc0208a24:	e3850513          	addi	a0,a0,-456 # ffffffffc0295858 <__wait_queue>
ffffffffc0208a28:	b21fb0ef          	jal	ra,ffffffffc0204548 <wait_queue_empty>
ffffffffc0208a2c:	cd09                	beqz	a0,ffffffffc0208a46 <dev_stdin_write+0x7e>
ffffffffc0208a2e:	e491                	bnez	s1,ffffffffc0208a3a <dev_stdin_write+0x72>
ffffffffc0208a30:	60e2                	ld	ra,24(sp)
ffffffffc0208a32:	6442                	ld	s0,16(sp)
ffffffffc0208a34:	64a2                	ld	s1,8(sp)
ffffffffc0208a36:	6105                	addi	sp,sp,32
ffffffffc0208a38:	8082                	ret
ffffffffc0208a3a:	6442                	ld	s0,16(sp)
ffffffffc0208a3c:	60e2                	ld	ra,24(sp)
ffffffffc0208a3e:	64a2                	ld	s1,8(sp)
ffffffffc0208a40:	6105                	addi	sp,sp,32
ffffffffc0208a42:	a2af806f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0208a46:	800005b7          	lui	a1,0x80000
ffffffffc0208a4a:	4605                	li	a2,1
ffffffffc0208a4c:	0591                	addi	a1,a1,4
ffffffffc0208a4e:	0008d517          	auipc	a0,0x8d
ffffffffc0208a52:	e0a50513          	addi	a0,a0,-502 # ffffffffc0295858 <__wait_queue>
ffffffffc0208a56:	b5bfb0ef          	jal	ra,ffffffffc02045b0 <wakeup_queue>
ffffffffc0208a5a:	d8f9                	beqz	s1,ffffffffc0208a30 <dev_stdin_write+0x68>
ffffffffc0208a5c:	bff9                	j	ffffffffc0208a3a <dev_stdin_write+0x72>
ffffffffc0208a5e:	a14f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208a62:	4485                	li	s1,1
ffffffffc0208a64:	bfb5                	j	ffffffffc02089e0 <dev_stdin_write+0x18>

ffffffffc0208a66 <dev_init_stdin>:
ffffffffc0208a66:	1141                	addi	sp,sp,-16
ffffffffc0208a68:	e406                	sd	ra,8(sp)
ffffffffc0208a6a:	e022                	sd	s0,0(sp)
ffffffffc0208a6c:	ac7ff0ef          	jal	ra,ffffffffc0208532 <dev_create_inode>
ffffffffc0208a70:	c93d                	beqz	a0,ffffffffc0208ae6 <dev_init_stdin+0x80>
ffffffffc0208a72:	4d38                	lw	a4,88(a0)
ffffffffc0208a74:	6785                	lui	a5,0x1
ffffffffc0208a76:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208a7a:	842a                	mv	s0,a0
ffffffffc0208a7c:	08f71e63          	bne	a4,a5,ffffffffc0208b18 <dev_init_stdin+0xb2>
ffffffffc0208a80:	4785                	li	a5,1
ffffffffc0208a82:	e41c                	sd	a5,8(s0)
ffffffffc0208a84:	00000797          	auipc	a5,0x0
ffffffffc0208a88:	dd078793          	addi	a5,a5,-560 # ffffffffc0208854 <stdin_open>
ffffffffc0208a8c:	e81c                	sd	a5,16(s0)
ffffffffc0208a8e:	00000797          	auipc	a5,0x0
ffffffffc0208a92:	dd078793          	addi	a5,a5,-560 # ffffffffc020885e <stdin_close>
ffffffffc0208a96:	ec1c                	sd	a5,24(s0)
ffffffffc0208a98:	00000797          	auipc	a5,0x0
ffffffffc0208a9c:	dce78793          	addi	a5,a5,-562 # ffffffffc0208866 <stdin_io>
ffffffffc0208aa0:	f01c                	sd	a5,32(s0)
ffffffffc0208aa2:	00000797          	auipc	a5,0x0
ffffffffc0208aa6:	dc078793          	addi	a5,a5,-576 # ffffffffc0208862 <stdin_ioctl>
ffffffffc0208aaa:	f41c                	sd	a5,40(s0)
ffffffffc0208aac:	0008d517          	auipc	a0,0x8d
ffffffffc0208ab0:	dac50513          	addi	a0,a0,-596 # ffffffffc0295858 <__wait_queue>
ffffffffc0208ab4:	00043023          	sd	zero,0(s0)
ffffffffc0208ab8:	0008e797          	auipc	a5,0x8e
ffffffffc0208abc:	e407b823          	sd	zero,-432(a5) # ffffffffc0296908 <p_wpos>
ffffffffc0208ac0:	0008e797          	auipc	a5,0x8e
ffffffffc0208ac4:	e407b023          	sd	zero,-448(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208ac8:	a2dfb0ef          	jal	ra,ffffffffc02044f4 <wait_queue_init>
ffffffffc0208acc:	4601                	li	a2,0
ffffffffc0208ace:	85a2                	mv	a1,s0
ffffffffc0208ad0:	00006517          	auipc	a0,0x6
ffffffffc0208ad4:	d3050513          	addi	a0,a0,-720 # ffffffffc020e800 <dev_node_ops+0x270>
ffffffffc0208ad8:	916ff0ef          	jal	ra,ffffffffc0207bee <vfs_add_dev>
ffffffffc0208adc:	e10d                	bnez	a0,ffffffffc0208afe <dev_init_stdin+0x98>
ffffffffc0208ade:	60a2                	ld	ra,8(sp)
ffffffffc0208ae0:	6402                	ld	s0,0(sp)
ffffffffc0208ae2:	0141                	addi	sp,sp,16
ffffffffc0208ae4:	8082                	ret
ffffffffc0208ae6:	00006617          	auipc	a2,0x6
ffffffffc0208aea:	cda60613          	addi	a2,a2,-806 # ffffffffc020e7c0 <dev_node_ops+0x230>
ffffffffc0208aee:	07500593          	li	a1,117
ffffffffc0208af2:	00006517          	auipc	a0,0x6
ffffffffc0208af6:	cee50513          	addi	a0,a0,-786 # ffffffffc020e7e0 <dev_node_ops+0x250>
ffffffffc0208afa:	9a5f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208afe:	86aa                	mv	a3,a0
ffffffffc0208b00:	00006617          	auipc	a2,0x6
ffffffffc0208b04:	d0860613          	addi	a2,a2,-760 # ffffffffc020e808 <dev_node_ops+0x278>
ffffffffc0208b08:	07b00593          	li	a1,123
ffffffffc0208b0c:	00006517          	auipc	a0,0x6
ffffffffc0208b10:	cd450513          	addi	a0,a0,-812 # ffffffffc020e7e0 <dev_node_ops+0x250>
ffffffffc0208b14:	98bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b18:	00005697          	auipc	a3,0x5
ffffffffc0208b1c:	75068693          	addi	a3,a3,1872 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc0208b20:	00003617          	auipc	a2,0x3
ffffffffc0208b24:	c1860613          	addi	a2,a2,-1000 # ffffffffc020b738 <commands+0x210>
ffffffffc0208b28:	07700593          	li	a1,119
ffffffffc0208b2c:	00006517          	auipc	a0,0x6
ffffffffc0208b30:	cb450513          	addi	a0,a0,-844 # ffffffffc020e7e0 <dev_node_ops+0x250>
ffffffffc0208b34:	96bf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208b38 <stdout_open>:
ffffffffc0208b38:	4785                	li	a5,1
ffffffffc0208b3a:	4501                	li	a0,0
ffffffffc0208b3c:	00f59363          	bne	a1,a5,ffffffffc0208b42 <stdout_open+0xa>
ffffffffc0208b40:	8082                	ret
ffffffffc0208b42:	5575                	li	a0,-3
ffffffffc0208b44:	8082                	ret

ffffffffc0208b46 <stdout_close>:
ffffffffc0208b46:	4501                	li	a0,0
ffffffffc0208b48:	8082                	ret

ffffffffc0208b4a <stdout_ioctl>:
ffffffffc0208b4a:	5575                	li	a0,-3
ffffffffc0208b4c:	8082                	ret

ffffffffc0208b4e <stdout_io>:
ffffffffc0208b4e:	ca05                	beqz	a2,ffffffffc0208b7e <stdout_io+0x30>
ffffffffc0208b50:	6d9c                	ld	a5,24(a1)
ffffffffc0208b52:	1101                	addi	sp,sp,-32
ffffffffc0208b54:	e822                	sd	s0,16(sp)
ffffffffc0208b56:	e426                	sd	s1,8(sp)
ffffffffc0208b58:	ec06                	sd	ra,24(sp)
ffffffffc0208b5a:	6180                	ld	s0,0(a1)
ffffffffc0208b5c:	84ae                	mv	s1,a1
ffffffffc0208b5e:	cb91                	beqz	a5,ffffffffc0208b72 <stdout_io+0x24>
ffffffffc0208b60:	00044503          	lbu	a0,0(s0)
ffffffffc0208b64:	0405                	addi	s0,s0,1
ffffffffc0208b66:	e7cf70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0208b6a:	6c9c                	ld	a5,24(s1)
ffffffffc0208b6c:	17fd                	addi	a5,a5,-1
ffffffffc0208b6e:	ec9c                	sd	a5,24(s1)
ffffffffc0208b70:	fbe5                	bnez	a5,ffffffffc0208b60 <stdout_io+0x12>
ffffffffc0208b72:	60e2                	ld	ra,24(sp)
ffffffffc0208b74:	6442                	ld	s0,16(sp)
ffffffffc0208b76:	64a2                	ld	s1,8(sp)
ffffffffc0208b78:	4501                	li	a0,0
ffffffffc0208b7a:	6105                	addi	sp,sp,32
ffffffffc0208b7c:	8082                	ret
ffffffffc0208b7e:	5575                	li	a0,-3
ffffffffc0208b80:	8082                	ret

ffffffffc0208b82 <dev_init_stdout>:
ffffffffc0208b82:	1141                	addi	sp,sp,-16
ffffffffc0208b84:	e406                	sd	ra,8(sp)
ffffffffc0208b86:	9adff0ef          	jal	ra,ffffffffc0208532 <dev_create_inode>
ffffffffc0208b8a:	c939                	beqz	a0,ffffffffc0208be0 <dev_init_stdout+0x5e>
ffffffffc0208b8c:	4d38                	lw	a4,88(a0)
ffffffffc0208b8e:	6785                	lui	a5,0x1
ffffffffc0208b90:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208b94:	85aa                	mv	a1,a0
ffffffffc0208b96:	06f71e63          	bne	a4,a5,ffffffffc0208c12 <dev_init_stdout+0x90>
ffffffffc0208b9a:	4785                	li	a5,1
ffffffffc0208b9c:	e51c                	sd	a5,8(a0)
ffffffffc0208b9e:	00000797          	auipc	a5,0x0
ffffffffc0208ba2:	f9a78793          	addi	a5,a5,-102 # ffffffffc0208b38 <stdout_open>
ffffffffc0208ba6:	e91c                	sd	a5,16(a0)
ffffffffc0208ba8:	00000797          	auipc	a5,0x0
ffffffffc0208bac:	f9e78793          	addi	a5,a5,-98 # ffffffffc0208b46 <stdout_close>
ffffffffc0208bb0:	ed1c                	sd	a5,24(a0)
ffffffffc0208bb2:	00000797          	auipc	a5,0x0
ffffffffc0208bb6:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208b4e <stdout_io>
ffffffffc0208bba:	f11c                	sd	a5,32(a0)
ffffffffc0208bbc:	00000797          	auipc	a5,0x0
ffffffffc0208bc0:	f8e78793          	addi	a5,a5,-114 # ffffffffc0208b4a <stdout_ioctl>
ffffffffc0208bc4:	00053023          	sd	zero,0(a0)
ffffffffc0208bc8:	f51c                	sd	a5,40(a0)
ffffffffc0208bca:	4601                	li	a2,0
ffffffffc0208bcc:	00006517          	auipc	a0,0x6
ffffffffc0208bd0:	c9c50513          	addi	a0,a0,-868 # ffffffffc020e868 <dev_node_ops+0x2d8>
ffffffffc0208bd4:	81aff0ef          	jal	ra,ffffffffc0207bee <vfs_add_dev>
ffffffffc0208bd8:	e105                	bnez	a0,ffffffffc0208bf8 <dev_init_stdout+0x76>
ffffffffc0208bda:	60a2                	ld	ra,8(sp)
ffffffffc0208bdc:	0141                	addi	sp,sp,16
ffffffffc0208bde:	8082                	ret
ffffffffc0208be0:	00006617          	auipc	a2,0x6
ffffffffc0208be4:	c4860613          	addi	a2,a2,-952 # ffffffffc020e828 <dev_node_ops+0x298>
ffffffffc0208be8:	03700593          	li	a1,55
ffffffffc0208bec:	00006517          	auipc	a0,0x6
ffffffffc0208bf0:	c5c50513          	addi	a0,a0,-932 # ffffffffc020e848 <dev_node_ops+0x2b8>
ffffffffc0208bf4:	8abf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208bf8:	86aa                	mv	a3,a0
ffffffffc0208bfa:	00006617          	auipc	a2,0x6
ffffffffc0208bfe:	c7660613          	addi	a2,a2,-906 # ffffffffc020e870 <dev_node_ops+0x2e0>
ffffffffc0208c02:	03d00593          	li	a1,61
ffffffffc0208c06:	00006517          	auipc	a0,0x6
ffffffffc0208c0a:	c4250513          	addi	a0,a0,-958 # ffffffffc020e848 <dev_node_ops+0x2b8>
ffffffffc0208c0e:	891f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c12:	00005697          	auipc	a3,0x5
ffffffffc0208c16:	65668693          	addi	a3,a3,1622 # ffffffffc020e268 <syscalls+0xb10>
ffffffffc0208c1a:	00003617          	auipc	a2,0x3
ffffffffc0208c1e:	b1e60613          	addi	a2,a2,-1250 # ffffffffc020b738 <commands+0x210>
ffffffffc0208c22:	03900593          	li	a1,57
ffffffffc0208c26:	00006517          	auipc	a0,0x6
ffffffffc0208c2a:	c2250513          	addi	a0,a0,-990 # ffffffffc020e848 <dev_node_ops+0x2b8>
ffffffffc0208c2e:	871f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208c32 <bitmap_translate.part.0>:
ffffffffc0208c32:	1141                	addi	sp,sp,-16
ffffffffc0208c34:	00006697          	auipc	a3,0x6
ffffffffc0208c38:	c5c68693          	addi	a3,a3,-932 # ffffffffc020e890 <dev_node_ops+0x300>
ffffffffc0208c3c:	00003617          	auipc	a2,0x3
ffffffffc0208c40:	afc60613          	addi	a2,a2,-1284 # ffffffffc020b738 <commands+0x210>
ffffffffc0208c44:	04c00593          	li	a1,76
ffffffffc0208c48:	00006517          	auipc	a0,0x6
ffffffffc0208c4c:	c6050513          	addi	a0,a0,-928 # ffffffffc020e8a8 <dev_node_ops+0x318>
ffffffffc0208c50:	e406                	sd	ra,8(sp)
ffffffffc0208c52:	84df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208c56 <bitmap_create>:
ffffffffc0208c56:	7139                	addi	sp,sp,-64
ffffffffc0208c58:	fc06                	sd	ra,56(sp)
ffffffffc0208c5a:	f822                	sd	s0,48(sp)
ffffffffc0208c5c:	f426                	sd	s1,40(sp)
ffffffffc0208c5e:	f04a                	sd	s2,32(sp)
ffffffffc0208c60:	ec4e                	sd	s3,24(sp)
ffffffffc0208c62:	e852                	sd	s4,16(sp)
ffffffffc0208c64:	e456                	sd	s5,8(sp)
ffffffffc0208c66:	c14d                	beqz	a0,ffffffffc0208d08 <bitmap_create+0xb2>
ffffffffc0208c68:	842a                	mv	s0,a0
ffffffffc0208c6a:	4541                	li	a0,16
ffffffffc0208c6c:	b22f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208c70:	84aa                	mv	s1,a0
ffffffffc0208c72:	cd25                	beqz	a0,ffffffffc0208cea <bitmap_create+0x94>
ffffffffc0208c74:	02041a13          	slli	s4,s0,0x20
ffffffffc0208c78:	020a5a13          	srli	s4,s4,0x20
ffffffffc0208c7c:	01fa0793          	addi	a5,s4,31
ffffffffc0208c80:	0057d993          	srli	s3,a5,0x5
ffffffffc0208c84:	00299a93          	slli	s5,s3,0x2
ffffffffc0208c88:	8556                	mv	a0,s5
ffffffffc0208c8a:	894e                	mv	s2,s3
ffffffffc0208c8c:	b02f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208c90:	c53d                	beqz	a0,ffffffffc0208cfe <bitmap_create+0xa8>
ffffffffc0208c92:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0208c96:	c080                	sw	s0,0(s1)
ffffffffc0208c98:	8656                	mv	a2,s5
ffffffffc0208c9a:	0ff00593          	li	a1,255
ffffffffc0208c9e:	5b2020ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0208ca2:	e488                	sd	a0,8(s1)
ffffffffc0208ca4:	0996                	slli	s3,s3,0x5
ffffffffc0208ca6:	053a0263          	beq	s4,s3,ffffffffc0208cea <bitmap_create+0x94>
ffffffffc0208caa:	fff9079b          	addiw	a5,s2,-1
ffffffffc0208cae:	0057969b          	slliw	a3,a5,0x5
ffffffffc0208cb2:	0054561b          	srliw	a2,s0,0x5
ffffffffc0208cb6:	40d4073b          	subw	a4,s0,a3
ffffffffc0208cba:	0054541b          	srliw	s0,s0,0x5
ffffffffc0208cbe:	08f61463          	bne	a2,a5,ffffffffc0208d46 <bitmap_create+0xf0>
ffffffffc0208cc2:	fff7069b          	addiw	a3,a4,-1
ffffffffc0208cc6:	47f9                	li	a5,30
ffffffffc0208cc8:	04d7ef63          	bltu	a5,a3,ffffffffc0208d26 <bitmap_create+0xd0>
ffffffffc0208ccc:	1402                	slli	s0,s0,0x20
ffffffffc0208cce:	8079                	srli	s0,s0,0x1e
ffffffffc0208cd0:	9522                	add	a0,a0,s0
ffffffffc0208cd2:	411c                	lw	a5,0(a0)
ffffffffc0208cd4:	4585                	li	a1,1
ffffffffc0208cd6:	02000613          	li	a2,32
ffffffffc0208cda:	00e596bb          	sllw	a3,a1,a4
ffffffffc0208cde:	8fb5                	xor	a5,a5,a3
ffffffffc0208ce0:	2705                	addiw	a4,a4,1
ffffffffc0208ce2:	2781                	sext.w	a5,a5
ffffffffc0208ce4:	fec71be3          	bne	a4,a2,ffffffffc0208cda <bitmap_create+0x84>
ffffffffc0208ce8:	c11c                	sw	a5,0(a0)
ffffffffc0208cea:	70e2                	ld	ra,56(sp)
ffffffffc0208cec:	7442                	ld	s0,48(sp)
ffffffffc0208cee:	7902                	ld	s2,32(sp)
ffffffffc0208cf0:	69e2                	ld	s3,24(sp)
ffffffffc0208cf2:	6a42                	ld	s4,16(sp)
ffffffffc0208cf4:	6aa2                	ld	s5,8(sp)
ffffffffc0208cf6:	8526                	mv	a0,s1
ffffffffc0208cf8:	74a2                	ld	s1,40(sp)
ffffffffc0208cfa:	6121                	addi	sp,sp,64
ffffffffc0208cfc:	8082                	ret
ffffffffc0208cfe:	8526                	mv	a0,s1
ffffffffc0208d00:	b3ef90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208d04:	4481                	li	s1,0
ffffffffc0208d06:	b7d5                	j	ffffffffc0208cea <bitmap_create+0x94>
ffffffffc0208d08:	00006697          	auipc	a3,0x6
ffffffffc0208d0c:	bb868693          	addi	a3,a3,-1096 # ffffffffc020e8c0 <dev_node_ops+0x330>
ffffffffc0208d10:	00003617          	auipc	a2,0x3
ffffffffc0208d14:	a2860613          	addi	a2,a2,-1496 # ffffffffc020b738 <commands+0x210>
ffffffffc0208d18:	45d5                	li	a1,21
ffffffffc0208d1a:	00006517          	auipc	a0,0x6
ffffffffc0208d1e:	b8e50513          	addi	a0,a0,-1138 # ffffffffc020e8a8 <dev_node_ops+0x318>
ffffffffc0208d22:	f7cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d26:	00006697          	auipc	a3,0x6
ffffffffc0208d2a:	bda68693          	addi	a3,a3,-1062 # ffffffffc020e900 <dev_node_ops+0x370>
ffffffffc0208d2e:	00003617          	auipc	a2,0x3
ffffffffc0208d32:	a0a60613          	addi	a2,a2,-1526 # ffffffffc020b738 <commands+0x210>
ffffffffc0208d36:	02b00593          	li	a1,43
ffffffffc0208d3a:	00006517          	auipc	a0,0x6
ffffffffc0208d3e:	b6e50513          	addi	a0,a0,-1170 # ffffffffc020e8a8 <dev_node_ops+0x318>
ffffffffc0208d42:	f5cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d46:	00006697          	auipc	a3,0x6
ffffffffc0208d4a:	ba268693          	addi	a3,a3,-1118 # ffffffffc020e8e8 <dev_node_ops+0x358>
ffffffffc0208d4e:	00003617          	auipc	a2,0x3
ffffffffc0208d52:	9ea60613          	addi	a2,a2,-1558 # ffffffffc020b738 <commands+0x210>
ffffffffc0208d56:	02a00593          	li	a1,42
ffffffffc0208d5a:	00006517          	auipc	a0,0x6
ffffffffc0208d5e:	b4e50513          	addi	a0,a0,-1202 # ffffffffc020e8a8 <dev_node_ops+0x318>
ffffffffc0208d62:	f3cf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208d66 <bitmap_alloc>:
ffffffffc0208d66:	4150                	lw	a2,4(a0)
ffffffffc0208d68:	651c                	ld	a5,8(a0)
ffffffffc0208d6a:	c231                	beqz	a2,ffffffffc0208dae <bitmap_alloc+0x48>
ffffffffc0208d6c:	4701                	li	a4,0
ffffffffc0208d6e:	a029                	j	ffffffffc0208d78 <bitmap_alloc+0x12>
ffffffffc0208d70:	2705                	addiw	a4,a4,1
ffffffffc0208d72:	0791                	addi	a5,a5,4
ffffffffc0208d74:	02e60d63          	beq	a2,a4,ffffffffc0208dae <bitmap_alloc+0x48>
ffffffffc0208d78:	4394                	lw	a3,0(a5)
ffffffffc0208d7a:	dafd                	beqz	a3,ffffffffc0208d70 <bitmap_alloc+0xa>
ffffffffc0208d7c:	4501                	li	a0,0
ffffffffc0208d7e:	4885                	li	a7,1
ffffffffc0208d80:	8e36                	mv	t3,a3
ffffffffc0208d82:	02000313          	li	t1,32
ffffffffc0208d86:	a021                	j	ffffffffc0208d8e <bitmap_alloc+0x28>
ffffffffc0208d88:	2505                	addiw	a0,a0,1
ffffffffc0208d8a:	02650463          	beq	a0,t1,ffffffffc0208db2 <bitmap_alloc+0x4c>
ffffffffc0208d8e:	00a8983b          	sllw	a6,a7,a0
ffffffffc0208d92:	0106f633          	and	a2,a3,a6
ffffffffc0208d96:	2601                	sext.w	a2,a2
ffffffffc0208d98:	da65                	beqz	a2,ffffffffc0208d88 <bitmap_alloc+0x22>
ffffffffc0208d9a:	010e4833          	xor	a6,t3,a6
ffffffffc0208d9e:	0057171b          	slliw	a4,a4,0x5
ffffffffc0208da2:	9f29                	addw	a4,a4,a0
ffffffffc0208da4:	0107a023          	sw	a6,0(a5)
ffffffffc0208da8:	c198                	sw	a4,0(a1)
ffffffffc0208daa:	4501                	li	a0,0
ffffffffc0208dac:	8082                	ret
ffffffffc0208dae:	5571                	li	a0,-4
ffffffffc0208db0:	8082                	ret
ffffffffc0208db2:	1141                	addi	sp,sp,-16
ffffffffc0208db4:	00004697          	auipc	a3,0x4
ffffffffc0208db8:	a2468693          	addi	a3,a3,-1500 # ffffffffc020c7d8 <default_pmm_manager+0x5b8>
ffffffffc0208dbc:	00003617          	auipc	a2,0x3
ffffffffc0208dc0:	97c60613          	addi	a2,a2,-1668 # ffffffffc020b738 <commands+0x210>
ffffffffc0208dc4:	04300593          	li	a1,67
ffffffffc0208dc8:	00006517          	auipc	a0,0x6
ffffffffc0208dcc:	ae050513          	addi	a0,a0,-1312 # ffffffffc020e8a8 <dev_node_ops+0x318>
ffffffffc0208dd0:	e406                	sd	ra,8(sp)
ffffffffc0208dd2:	eccf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208dd6 <bitmap_test>:
ffffffffc0208dd6:	411c                	lw	a5,0(a0)
ffffffffc0208dd8:	00f5ff63          	bgeu	a1,a5,ffffffffc0208df6 <bitmap_test+0x20>
ffffffffc0208ddc:	651c                	ld	a5,8(a0)
ffffffffc0208dde:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0208de2:	070a                	slli	a4,a4,0x2
ffffffffc0208de4:	97ba                	add	a5,a5,a4
ffffffffc0208de6:	4388                	lw	a0,0(a5)
ffffffffc0208de8:	4785                	li	a5,1
ffffffffc0208dea:	00b795bb          	sllw	a1,a5,a1
ffffffffc0208dee:	8d6d                	and	a0,a0,a1
ffffffffc0208df0:	1502                	slli	a0,a0,0x20
ffffffffc0208df2:	9101                	srli	a0,a0,0x20
ffffffffc0208df4:	8082                	ret
ffffffffc0208df6:	1141                	addi	sp,sp,-16
ffffffffc0208df8:	e406                	sd	ra,8(sp)
ffffffffc0208dfa:	e39ff0ef          	jal	ra,ffffffffc0208c32 <bitmap_translate.part.0>

ffffffffc0208dfe <bitmap_free>:
ffffffffc0208dfe:	411c                	lw	a5,0(a0)
ffffffffc0208e00:	1141                	addi	sp,sp,-16
ffffffffc0208e02:	e406                	sd	ra,8(sp)
ffffffffc0208e04:	02f5f463          	bgeu	a1,a5,ffffffffc0208e2c <bitmap_free+0x2e>
ffffffffc0208e08:	651c                	ld	a5,8(a0)
ffffffffc0208e0a:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0208e0e:	070a                	slli	a4,a4,0x2
ffffffffc0208e10:	97ba                	add	a5,a5,a4
ffffffffc0208e12:	4398                	lw	a4,0(a5)
ffffffffc0208e14:	4685                	li	a3,1
ffffffffc0208e16:	00b695bb          	sllw	a1,a3,a1
ffffffffc0208e1a:	00b776b3          	and	a3,a4,a1
ffffffffc0208e1e:	2681                	sext.w	a3,a3
ffffffffc0208e20:	ea81                	bnez	a3,ffffffffc0208e30 <bitmap_free+0x32>
ffffffffc0208e22:	60a2                	ld	ra,8(sp)
ffffffffc0208e24:	8f4d                	or	a4,a4,a1
ffffffffc0208e26:	c398                	sw	a4,0(a5)
ffffffffc0208e28:	0141                	addi	sp,sp,16
ffffffffc0208e2a:	8082                	ret
ffffffffc0208e2c:	e07ff0ef          	jal	ra,ffffffffc0208c32 <bitmap_translate.part.0>
ffffffffc0208e30:	00006697          	auipc	a3,0x6
ffffffffc0208e34:	af868693          	addi	a3,a3,-1288 # ffffffffc020e928 <dev_node_ops+0x398>
ffffffffc0208e38:	00003617          	auipc	a2,0x3
ffffffffc0208e3c:	90060613          	addi	a2,a2,-1792 # ffffffffc020b738 <commands+0x210>
ffffffffc0208e40:	05f00593          	li	a1,95
ffffffffc0208e44:	00006517          	auipc	a0,0x6
ffffffffc0208e48:	a6450513          	addi	a0,a0,-1436 # ffffffffc020e8a8 <dev_node_ops+0x318>
ffffffffc0208e4c:	e52f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e50 <bitmap_destroy>:
ffffffffc0208e50:	1141                	addi	sp,sp,-16
ffffffffc0208e52:	e022                	sd	s0,0(sp)
ffffffffc0208e54:	842a                	mv	s0,a0
ffffffffc0208e56:	6508                	ld	a0,8(a0)
ffffffffc0208e58:	e406                	sd	ra,8(sp)
ffffffffc0208e5a:	9e4f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208e5e:	8522                	mv	a0,s0
ffffffffc0208e60:	6402                	ld	s0,0(sp)
ffffffffc0208e62:	60a2                	ld	ra,8(sp)
ffffffffc0208e64:	0141                	addi	sp,sp,16
ffffffffc0208e66:	9d8f906f          	j	ffffffffc020203e <kfree>

ffffffffc0208e6a <bitmap_getdata>:
ffffffffc0208e6a:	c589                	beqz	a1,ffffffffc0208e74 <bitmap_getdata+0xa>
ffffffffc0208e6c:	00456783          	lwu	a5,4(a0)
ffffffffc0208e70:	078a                	slli	a5,a5,0x2
ffffffffc0208e72:	e19c                	sd	a5,0(a1)
ffffffffc0208e74:	6508                	ld	a0,8(a0)
ffffffffc0208e76:	8082                	ret

ffffffffc0208e78 <sfs_init>:
ffffffffc0208e78:	1141                	addi	sp,sp,-16
ffffffffc0208e7a:	00006517          	auipc	a0,0x6
ffffffffc0208e7e:	91e50513          	addi	a0,a0,-1762 # ffffffffc020e798 <dev_node_ops+0x208>
ffffffffc0208e82:	e406                	sd	ra,8(sp)
ffffffffc0208e84:	554000ef          	jal	ra,ffffffffc02093d8 <sfs_mount>
ffffffffc0208e88:	e501                	bnez	a0,ffffffffc0208e90 <sfs_init+0x18>
ffffffffc0208e8a:	60a2                	ld	ra,8(sp)
ffffffffc0208e8c:	0141                	addi	sp,sp,16
ffffffffc0208e8e:	8082                	ret
ffffffffc0208e90:	86aa                	mv	a3,a0
ffffffffc0208e92:	00006617          	auipc	a2,0x6
ffffffffc0208e96:	aa660613          	addi	a2,a2,-1370 # ffffffffc020e938 <dev_node_ops+0x3a8>
ffffffffc0208e9a:	45c1                	li	a1,16
ffffffffc0208e9c:	00006517          	auipc	a0,0x6
ffffffffc0208ea0:	abc50513          	addi	a0,a0,-1348 # ffffffffc020e958 <dev_node_ops+0x3c8>
ffffffffc0208ea4:	dfaf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ea8 <sfs_unmount>:
ffffffffc0208ea8:	1141                	addi	sp,sp,-16
ffffffffc0208eaa:	e406                	sd	ra,8(sp)
ffffffffc0208eac:	e022                	sd	s0,0(sp)
ffffffffc0208eae:	cd1d                	beqz	a0,ffffffffc0208eec <sfs_unmount+0x44>
ffffffffc0208eb0:	0b052783          	lw	a5,176(a0)
ffffffffc0208eb4:	842a                	mv	s0,a0
ffffffffc0208eb6:	eb9d                	bnez	a5,ffffffffc0208eec <sfs_unmount+0x44>
ffffffffc0208eb8:	7158                	ld	a4,160(a0)
ffffffffc0208eba:	09850793          	addi	a5,a0,152
ffffffffc0208ebe:	02f71563          	bne	a4,a5,ffffffffc0208ee8 <sfs_unmount+0x40>
ffffffffc0208ec2:	613c                	ld	a5,64(a0)
ffffffffc0208ec4:	e7a1                	bnez	a5,ffffffffc0208f0c <sfs_unmount+0x64>
ffffffffc0208ec6:	7d08                	ld	a0,56(a0)
ffffffffc0208ec8:	f89ff0ef          	jal	ra,ffffffffc0208e50 <bitmap_destroy>
ffffffffc0208ecc:	6428                	ld	a0,72(s0)
ffffffffc0208ece:	970f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208ed2:	7448                	ld	a0,168(s0)
ffffffffc0208ed4:	96af90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208ed8:	8522                	mv	a0,s0
ffffffffc0208eda:	964f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208ede:	4501                	li	a0,0
ffffffffc0208ee0:	60a2                	ld	ra,8(sp)
ffffffffc0208ee2:	6402                	ld	s0,0(sp)
ffffffffc0208ee4:	0141                	addi	sp,sp,16
ffffffffc0208ee6:	8082                	ret
ffffffffc0208ee8:	5545                	li	a0,-15
ffffffffc0208eea:	bfdd                	j	ffffffffc0208ee0 <sfs_unmount+0x38>
ffffffffc0208eec:	00006697          	auipc	a3,0x6
ffffffffc0208ef0:	a8468693          	addi	a3,a3,-1404 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc0208ef4:	00003617          	auipc	a2,0x3
ffffffffc0208ef8:	84460613          	addi	a2,a2,-1980 # ffffffffc020b738 <commands+0x210>
ffffffffc0208efc:	04100593          	li	a1,65
ffffffffc0208f00:	00006517          	auipc	a0,0x6
ffffffffc0208f04:	aa050513          	addi	a0,a0,-1376 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc0208f08:	d96f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208f0c:	00006697          	auipc	a3,0x6
ffffffffc0208f10:	aac68693          	addi	a3,a3,-1364 # ffffffffc020e9b8 <dev_node_ops+0x428>
ffffffffc0208f14:	00003617          	auipc	a2,0x3
ffffffffc0208f18:	82460613          	addi	a2,a2,-2012 # ffffffffc020b738 <commands+0x210>
ffffffffc0208f1c:	04500593          	li	a1,69
ffffffffc0208f20:	00006517          	auipc	a0,0x6
ffffffffc0208f24:	a8050513          	addi	a0,a0,-1408 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc0208f28:	d76f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f2c <sfs_cleanup>:
ffffffffc0208f2c:	1101                	addi	sp,sp,-32
ffffffffc0208f2e:	ec06                	sd	ra,24(sp)
ffffffffc0208f30:	e822                	sd	s0,16(sp)
ffffffffc0208f32:	e426                	sd	s1,8(sp)
ffffffffc0208f34:	e04a                	sd	s2,0(sp)
ffffffffc0208f36:	c525                	beqz	a0,ffffffffc0208f9e <sfs_cleanup+0x72>
ffffffffc0208f38:	0b052783          	lw	a5,176(a0)
ffffffffc0208f3c:	84aa                	mv	s1,a0
ffffffffc0208f3e:	e3a5                	bnez	a5,ffffffffc0208f9e <sfs_cleanup+0x72>
ffffffffc0208f40:	4158                	lw	a4,4(a0)
ffffffffc0208f42:	4514                	lw	a3,8(a0)
ffffffffc0208f44:	00c50913          	addi	s2,a0,12
ffffffffc0208f48:	85ca                	mv	a1,s2
ffffffffc0208f4a:	40d7063b          	subw	a2,a4,a3
ffffffffc0208f4e:	00006517          	auipc	a0,0x6
ffffffffc0208f52:	a8250513          	addi	a0,a0,-1406 # ffffffffc020e9d0 <dev_node_ops+0x440>
ffffffffc0208f56:	a50f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0208f5a:	02000413          	li	s0,32
ffffffffc0208f5e:	a019                	j	ffffffffc0208f64 <sfs_cleanup+0x38>
ffffffffc0208f60:	347d                	addiw	s0,s0,-1
ffffffffc0208f62:	c819                	beqz	s0,ffffffffc0208f78 <sfs_cleanup+0x4c>
ffffffffc0208f64:	7cdc                	ld	a5,184(s1)
ffffffffc0208f66:	8526                	mv	a0,s1
ffffffffc0208f68:	9782                	jalr	a5
ffffffffc0208f6a:	f97d                	bnez	a0,ffffffffc0208f60 <sfs_cleanup+0x34>
ffffffffc0208f6c:	60e2                	ld	ra,24(sp)
ffffffffc0208f6e:	6442                	ld	s0,16(sp)
ffffffffc0208f70:	64a2                	ld	s1,8(sp)
ffffffffc0208f72:	6902                	ld	s2,0(sp)
ffffffffc0208f74:	6105                	addi	sp,sp,32
ffffffffc0208f76:	8082                	ret
ffffffffc0208f78:	6442                	ld	s0,16(sp)
ffffffffc0208f7a:	60e2                	ld	ra,24(sp)
ffffffffc0208f7c:	64a2                	ld	s1,8(sp)
ffffffffc0208f7e:	86ca                	mv	a3,s2
ffffffffc0208f80:	6902                	ld	s2,0(sp)
ffffffffc0208f82:	872a                	mv	a4,a0
ffffffffc0208f84:	00006617          	auipc	a2,0x6
ffffffffc0208f88:	a6c60613          	addi	a2,a2,-1428 # ffffffffc020e9f0 <dev_node_ops+0x460>
ffffffffc0208f8c:	05f00593          	li	a1,95
ffffffffc0208f90:	00006517          	auipc	a0,0x6
ffffffffc0208f94:	a1050513          	addi	a0,a0,-1520 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc0208f98:	6105                	addi	sp,sp,32
ffffffffc0208f9a:	d6cf706f          	j	ffffffffc0200506 <__warn>
ffffffffc0208f9e:	00006697          	auipc	a3,0x6
ffffffffc0208fa2:	9d268693          	addi	a3,a3,-1582 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc0208fa6:	00002617          	auipc	a2,0x2
ffffffffc0208faa:	79260613          	addi	a2,a2,1938 # ffffffffc020b738 <commands+0x210>
ffffffffc0208fae:	05400593          	li	a1,84
ffffffffc0208fb2:	00006517          	auipc	a0,0x6
ffffffffc0208fb6:	9ee50513          	addi	a0,a0,-1554 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc0208fba:	ce4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208fbe <sfs_sync>:
ffffffffc0208fbe:	7179                	addi	sp,sp,-48
ffffffffc0208fc0:	f406                	sd	ra,40(sp)
ffffffffc0208fc2:	f022                	sd	s0,32(sp)
ffffffffc0208fc4:	ec26                	sd	s1,24(sp)
ffffffffc0208fc6:	e84a                	sd	s2,16(sp)
ffffffffc0208fc8:	e44e                	sd	s3,8(sp)
ffffffffc0208fca:	e052                	sd	s4,0(sp)
ffffffffc0208fcc:	cd4d                	beqz	a0,ffffffffc0209086 <sfs_sync+0xc8>
ffffffffc0208fce:	0b052783          	lw	a5,176(a0)
ffffffffc0208fd2:	8a2a                	mv	s4,a0
ffffffffc0208fd4:	ebcd                	bnez	a5,ffffffffc0209086 <sfs_sync+0xc8>
ffffffffc0208fd6:	527010ef          	jal	ra,ffffffffc020acfc <lock_sfs_fs>
ffffffffc0208fda:	0a0a3403          	ld	s0,160(s4)
ffffffffc0208fde:	098a0913          	addi	s2,s4,152
ffffffffc0208fe2:	02890763          	beq	s2,s0,ffffffffc0209010 <sfs_sync+0x52>
ffffffffc0208fe6:	00004997          	auipc	s3,0x4
ffffffffc0208fea:	0ca98993          	addi	s3,s3,202 # ffffffffc020d0b0 <default_pmm_manager+0xe90>
ffffffffc0208fee:	7c1c                	ld	a5,56(s0)
ffffffffc0208ff0:	fc840493          	addi	s1,s0,-56
ffffffffc0208ff4:	cbb5                	beqz	a5,ffffffffc0209068 <sfs_sync+0xaa>
ffffffffc0208ff6:	7b9c                	ld	a5,48(a5)
ffffffffc0208ff8:	cba5                	beqz	a5,ffffffffc0209068 <sfs_sync+0xaa>
ffffffffc0208ffa:	85ce                	mv	a1,s3
ffffffffc0208ffc:	8526                	mv	a0,s1
ffffffffc0208ffe:	e28fe0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0209002:	7c1c                	ld	a5,56(s0)
ffffffffc0209004:	8526                	mv	a0,s1
ffffffffc0209006:	7b9c                	ld	a5,48(a5)
ffffffffc0209008:	9782                	jalr	a5
ffffffffc020900a:	6400                	ld	s0,8(s0)
ffffffffc020900c:	fe8911e3          	bne	s2,s0,ffffffffc0208fee <sfs_sync+0x30>
ffffffffc0209010:	8552                	mv	a0,s4
ffffffffc0209012:	4fb010ef          	jal	ra,ffffffffc020ad0c <unlock_sfs_fs>
ffffffffc0209016:	040a3783          	ld	a5,64(s4)
ffffffffc020901a:	4501                	li	a0,0
ffffffffc020901c:	eb89                	bnez	a5,ffffffffc020902e <sfs_sync+0x70>
ffffffffc020901e:	70a2                	ld	ra,40(sp)
ffffffffc0209020:	7402                	ld	s0,32(sp)
ffffffffc0209022:	64e2                	ld	s1,24(sp)
ffffffffc0209024:	6942                	ld	s2,16(sp)
ffffffffc0209026:	69a2                	ld	s3,8(sp)
ffffffffc0209028:	6a02                	ld	s4,0(sp)
ffffffffc020902a:	6145                	addi	sp,sp,48
ffffffffc020902c:	8082                	ret
ffffffffc020902e:	040a3023          	sd	zero,64(s4)
ffffffffc0209032:	8552                	mv	a0,s4
ffffffffc0209034:	3ad010ef          	jal	ra,ffffffffc020abe0 <sfs_sync_super>
ffffffffc0209038:	cd01                	beqz	a0,ffffffffc0209050 <sfs_sync+0x92>
ffffffffc020903a:	70a2                	ld	ra,40(sp)
ffffffffc020903c:	7402                	ld	s0,32(sp)
ffffffffc020903e:	4785                	li	a5,1
ffffffffc0209040:	04fa3023          	sd	a5,64(s4)
ffffffffc0209044:	64e2                	ld	s1,24(sp)
ffffffffc0209046:	6942                	ld	s2,16(sp)
ffffffffc0209048:	69a2                	ld	s3,8(sp)
ffffffffc020904a:	6a02                	ld	s4,0(sp)
ffffffffc020904c:	6145                	addi	sp,sp,48
ffffffffc020904e:	8082                	ret
ffffffffc0209050:	8552                	mv	a0,s4
ffffffffc0209052:	3d5010ef          	jal	ra,ffffffffc020ac26 <sfs_sync_freemap>
ffffffffc0209056:	f175                	bnez	a0,ffffffffc020903a <sfs_sync+0x7c>
ffffffffc0209058:	70a2                	ld	ra,40(sp)
ffffffffc020905a:	7402                	ld	s0,32(sp)
ffffffffc020905c:	64e2                	ld	s1,24(sp)
ffffffffc020905e:	6942                	ld	s2,16(sp)
ffffffffc0209060:	69a2                	ld	s3,8(sp)
ffffffffc0209062:	6a02                	ld	s4,0(sp)
ffffffffc0209064:	6145                	addi	sp,sp,48
ffffffffc0209066:	8082                	ret
ffffffffc0209068:	00004697          	auipc	a3,0x4
ffffffffc020906c:	ff868693          	addi	a3,a3,-8 # ffffffffc020d060 <default_pmm_manager+0xe40>
ffffffffc0209070:	00002617          	auipc	a2,0x2
ffffffffc0209074:	6c860613          	addi	a2,a2,1736 # ffffffffc020b738 <commands+0x210>
ffffffffc0209078:	45ed                	li	a1,27
ffffffffc020907a:	00006517          	auipc	a0,0x6
ffffffffc020907e:	92650513          	addi	a0,a0,-1754 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc0209082:	c1cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209086:	00006697          	auipc	a3,0x6
ffffffffc020908a:	8ea68693          	addi	a3,a3,-1814 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc020908e:	00002617          	auipc	a2,0x2
ffffffffc0209092:	6aa60613          	addi	a2,a2,1706 # ffffffffc020b738 <commands+0x210>
ffffffffc0209096:	45d5                	li	a1,21
ffffffffc0209098:	00006517          	auipc	a0,0x6
ffffffffc020909c:	90850513          	addi	a0,a0,-1784 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc02090a0:	bfef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02090a4 <sfs_get_root>:
ffffffffc02090a4:	1101                	addi	sp,sp,-32
ffffffffc02090a6:	ec06                	sd	ra,24(sp)
ffffffffc02090a8:	cd09                	beqz	a0,ffffffffc02090c2 <sfs_get_root+0x1e>
ffffffffc02090aa:	0b052783          	lw	a5,176(a0)
ffffffffc02090ae:	eb91                	bnez	a5,ffffffffc02090c2 <sfs_get_root+0x1e>
ffffffffc02090b0:	4605                	li	a2,1
ffffffffc02090b2:	002c                	addi	a1,sp,8
ffffffffc02090b4:	35e010ef          	jal	ra,ffffffffc020a412 <sfs_load_inode>
ffffffffc02090b8:	e50d                	bnez	a0,ffffffffc02090e2 <sfs_get_root+0x3e>
ffffffffc02090ba:	60e2                	ld	ra,24(sp)
ffffffffc02090bc:	6522                	ld	a0,8(sp)
ffffffffc02090be:	6105                	addi	sp,sp,32
ffffffffc02090c0:	8082                	ret
ffffffffc02090c2:	00006697          	auipc	a3,0x6
ffffffffc02090c6:	8ae68693          	addi	a3,a3,-1874 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc02090ca:	00002617          	auipc	a2,0x2
ffffffffc02090ce:	66e60613          	addi	a2,a2,1646 # ffffffffc020b738 <commands+0x210>
ffffffffc02090d2:	03600593          	li	a1,54
ffffffffc02090d6:	00006517          	auipc	a0,0x6
ffffffffc02090da:	8ca50513          	addi	a0,a0,-1846 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc02090de:	bc0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02090e2:	86aa                	mv	a3,a0
ffffffffc02090e4:	00006617          	auipc	a2,0x6
ffffffffc02090e8:	92c60613          	addi	a2,a2,-1748 # ffffffffc020ea10 <dev_node_ops+0x480>
ffffffffc02090ec:	03700593          	li	a1,55
ffffffffc02090f0:	00006517          	auipc	a0,0x6
ffffffffc02090f4:	8b050513          	addi	a0,a0,-1872 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc02090f8:	ba6f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02090fc <sfs_do_mount>:
ffffffffc02090fc:	6518                	ld	a4,8(a0)
ffffffffc02090fe:	7171                	addi	sp,sp,-176
ffffffffc0209100:	f506                	sd	ra,168(sp)
ffffffffc0209102:	f122                	sd	s0,160(sp)
ffffffffc0209104:	ed26                	sd	s1,152(sp)
ffffffffc0209106:	e94a                	sd	s2,144(sp)
ffffffffc0209108:	e54e                	sd	s3,136(sp)
ffffffffc020910a:	e152                	sd	s4,128(sp)
ffffffffc020910c:	fcd6                	sd	s5,120(sp)
ffffffffc020910e:	f8da                	sd	s6,112(sp)
ffffffffc0209110:	f4de                	sd	s7,104(sp)
ffffffffc0209112:	f0e2                	sd	s8,96(sp)
ffffffffc0209114:	ece6                	sd	s9,88(sp)
ffffffffc0209116:	e8ea                	sd	s10,80(sp)
ffffffffc0209118:	e4ee                	sd	s11,72(sp)
ffffffffc020911a:	6785                	lui	a5,0x1
ffffffffc020911c:	24f71663          	bne	a4,a5,ffffffffc0209368 <sfs_do_mount+0x26c>
ffffffffc0209120:	892a                	mv	s2,a0
ffffffffc0209122:	4501                	li	a0,0
ffffffffc0209124:	8aae                	mv	s5,a1
ffffffffc0209126:	f00fe0ef          	jal	ra,ffffffffc0207826 <__alloc_fs>
ffffffffc020912a:	842a                	mv	s0,a0
ffffffffc020912c:	24050463          	beqz	a0,ffffffffc0209374 <sfs_do_mount+0x278>
ffffffffc0209130:	0b052b03          	lw	s6,176(a0)
ffffffffc0209134:	260b1263          	bnez	s6,ffffffffc0209398 <sfs_do_mount+0x29c>
ffffffffc0209138:	03253823          	sd	s2,48(a0)
ffffffffc020913c:	6505                	lui	a0,0x1
ffffffffc020913e:	e51f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209142:	e428                	sd	a0,72(s0)
ffffffffc0209144:	84aa                	mv	s1,a0
ffffffffc0209146:	16050363          	beqz	a0,ffffffffc02092ac <sfs_do_mount+0x1b0>
ffffffffc020914a:	85aa                	mv	a1,a0
ffffffffc020914c:	4681                	li	a3,0
ffffffffc020914e:	6605                	lui	a2,0x1
ffffffffc0209150:	1008                	addi	a0,sp,32
ffffffffc0209152:	9eefc0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0209156:	02093783          	ld	a5,32(s2)
ffffffffc020915a:	85aa                	mv	a1,a0
ffffffffc020915c:	4601                	li	a2,0
ffffffffc020915e:	854a                	mv	a0,s2
ffffffffc0209160:	9782                	jalr	a5
ffffffffc0209162:	8a2a                	mv	s4,a0
ffffffffc0209164:	10051e63          	bnez	a0,ffffffffc0209280 <sfs_do_mount+0x184>
ffffffffc0209168:	408c                	lw	a1,0(s1)
ffffffffc020916a:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc020916e:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc0209172:	14c59863          	bne	a1,a2,ffffffffc02092c2 <sfs_do_mount+0x1c6>
ffffffffc0209176:	40dc                	lw	a5,4(s1)
ffffffffc0209178:	00093603          	ld	a2,0(s2)
ffffffffc020917c:	02079713          	slli	a4,a5,0x20
ffffffffc0209180:	9301                	srli	a4,a4,0x20
ffffffffc0209182:	12e66763          	bltu	a2,a4,ffffffffc02092b0 <sfs_do_mount+0x1b4>
ffffffffc0209186:	020485a3          	sb	zero,43(s1)
ffffffffc020918a:	0084af03          	lw	t5,8(s1)
ffffffffc020918e:	00c4ae83          	lw	t4,12(s1)
ffffffffc0209192:	0104ae03          	lw	t3,16(s1)
ffffffffc0209196:	0144a303          	lw	t1,20(s1)
ffffffffc020919a:	0184a883          	lw	a7,24(s1)
ffffffffc020919e:	01c4a803          	lw	a6,28(s1)
ffffffffc02091a2:	5090                	lw	a2,32(s1)
ffffffffc02091a4:	50d4                	lw	a3,36(s1)
ffffffffc02091a6:	5498                	lw	a4,40(s1)
ffffffffc02091a8:	6511                	lui	a0,0x4
ffffffffc02091aa:	c00c                	sw	a1,0(s0)
ffffffffc02091ac:	c05c                	sw	a5,4(s0)
ffffffffc02091ae:	01e42423          	sw	t5,8(s0)
ffffffffc02091b2:	01d42623          	sw	t4,12(s0)
ffffffffc02091b6:	01c42823          	sw	t3,16(s0)
ffffffffc02091ba:	00642a23          	sw	t1,20(s0)
ffffffffc02091be:	01142c23          	sw	a7,24(s0)
ffffffffc02091c2:	01042e23          	sw	a6,28(s0)
ffffffffc02091c6:	d010                	sw	a2,32(s0)
ffffffffc02091c8:	d054                	sw	a3,36(s0)
ffffffffc02091ca:	d418                	sw	a4,40(s0)
ffffffffc02091cc:	dc3f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02091d0:	f448                	sd	a0,168(s0)
ffffffffc02091d2:	8c2a                	mv	s8,a0
ffffffffc02091d4:	18050c63          	beqz	a0,ffffffffc020936c <sfs_do_mount+0x270>
ffffffffc02091d8:	6711                	lui	a4,0x4
ffffffffc02091da:	87aa                	mv	a5,a0
ffffffffc02091dc:	972a                	add	a4,a4,a0
ffffffffc02091de:	e79c                	sd	a5,8(a5)
ffffffffc02091e0:	e39c                	sd	a5,0(a5)
ffffffffc02091e2:	07c1                	addi	a5,a5,16
ffffffffc02091e4:	fee79de3          	bne	a5,a4,ffffffffc02091de <sfs_do_mount+0xe2>
ffffffffc02091e8:	0044eb83          	lwu	s7,4(s1)
ffffffffc02091ec:	67a1                	lui	a5,0x8
ffffffffc02091ee:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc02091f2:	9bce                	add	s7,s7,s3
ffffffffc02091f4:	77e1                	lui	a5,0xffff8
ffffffffc02091f6:	00fbfbb3          	and	s7,s7,a5
ffffffffc02091fa:	2b81                	sext.w	s7,s7
ffffffffc02091fc:	855e                	mv	a0,s7
ffffffffc02091fe:	a59ff0ef          	jal	ra,ffffffffc0208c56 <bitmap_create>
ffffffffc0209202:	fc08                	sd	a0,56(s0)
ffffffffc0209204:	8d2a                	mv	s10,a0
ffffffffc0209206:	14050f63          	beqz	a0,ffffffffc0209364 <sfs_do_mount+0x268>
ffffffffc020920a:	0044e783          	lwu	a5,4(s1)
ffffffffc020920e:	082c                	addi	a1,sp,24
ffffffffc0209210:	97ce                	add	a5,a5,s3
ffffffffc0209212:	00f7d713          	srli	a4,a5,0xf
ffffffffc0209216:	e43a                	sd	a4,8(sp)
ffffffffc0209218:	40f7d993          	srai	s3,a5,0xf
ffffffffc020921c:	c4fff0ef          	jal	ra,ffffffffc0208e6a <bitmap_getdata>
ffffffffc0209220:	14050c63          	beqz	a0,ffffffffc0209378 <sfs_do_mount+0x27c>
ffffffffc0209224:	00c9979b          	slliw	a5,s3,0xc
ffffffffc0209228:	66e2                	ld	a3,24(sp)
ffffffffc020922a:	1782                	slli	a5,a5,0x20
ffffffffc020922c:	9381                	srli	a5,a5,0x20
ffffffffc020922e:	14d79563          	bne	a5,a3,ffffffffc0209378 <sfs_do_mount+0x27c>
ffffffffc0209232:	6722                	ld	a4,8(sp)
ffffffffc0209234:	6d89                	lui	s11,0x2
ffffffffc0209236:	89aa                	mv	s3,a0
ffffffffc0209238:	00c71c93          	slli	s9,a4,0xc
ffffffffc020923c:	9caa                	add	s9,s9,a0
ffffffffc020923e:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0209242:	e711                	bnez	a4,ffffffffc020924e <sfs_do_mount+0x152>
ffffffffc0209244:	a079                	j	ffffffffc02092d2 <sfs_do_mount+0x1d6>
ffffffffc0209246:	6785                	lui	a5,0x1
ffffffffc0209248:	99be                	add	s3,s3,a5
ffffffffc020924a:	093c8463          	beq	s9,s3,ffffffffc02092d2 <sfs_do_mount+0x1d6>
ffffffffc020924e:	013d86bb          	addw	a3,s11,s3
ffffffffc0209252:	1682                	slli	a3,a3,0x20
ffffffffc0209254:	6605                	lui	a2,0x1
ffffffffc0209256:	85ce                	mv	a1,s3
ffffffffc0209258:	9281                	srli	a3,a3,0x20
ffffffffc020925a:	1008                	addi	a0,sp,32
ffffffffc020925c:	8e4fc0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc0209260:	02093783          	ld	a5,32(s2)
ffffffffc0209264:	85aa                	mv	a1,a0
ffffffffc0209266:	4601                	li	a2,0
ffffffffc0209268:	854a                	mv	a0,s2
ffffffffc020926a:	9782                	jalr	a5
ffffffffc020926c:	dd69                	beqz	a0,ffffffffc0209246 <sfs_do_mount+0x14a>
ffffffffc020926e:	e42a                	sd	a0,8(sp)
ffffffffc0209270:	856a                	mv	a0,s10
ffffffffc0209272:	bdfff0ef          	jal	ra,ffffffffc0208e50 <bitmap_destroy>
ffffffffc0209276:	67a2                	ld	a5,8(sp)
ffffffffc0209278:	8a3e                	mv	s4,a5
ffffffffc020927a:	8562                	mv	a0,s8
ffffffffc020927c:	dc3f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209280:	8526                	mv	a0,s1
ffffffffc0209282:	dbdf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209286:	8522                	mv	a0,s0
ffffffffc0209288:	db7f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020928c:	70aa                	ld	ra,168(sp)
ffffffffc020928e:	740a                	ld	s0,160(sp)
ffffffffc0209290:	64ea                	ld	s1,152(sp)
ffffffffc0209292:	694a                	ld	s2,144(sp)
ffffffffc0209294:	69aa                	ld	s3,136(sp)
ffffffffc0209296:	7ae6                	ld	s5,120(sp)
ffffffffc0209298:	7b46                	ld	s6,112(sp)
ffffffffc020929a:	7ba6                	ld	s7,104(sp)
ffffffffc020929c:	7c06                	ld	s8,96(sp)
ffffffffc020929e:	6ce6                	ld	s9,88(sp)
ffffffffc02092a0:	6d46                	ld	s10,80(sp)
ffffffffc02092a2:	6da6                	ld	s11,72(sp)
ffffffffc02092a4:	8552                	mv	a0,s4
ffffffffc02092a6:	6a0a                	ld	s4,128(sp)
ffffffffc02092a8:	614d                	addi	sp,sp,176
ffffffffc02092aa:	8082                	ret
ffffffffc02092ac:	5a71                	li	s4,-4
ffffffffc02092ae:	bfe1                	j	ffffffffc0209286 <sfs_do_mount+0x18a>
ffffffffc02092b0:	85be                	mv	a1,a5
ffffffffc02092b2:	00005517          	auipc	a0,0x5
ffffffffc02092b6:	7b650513          	addi	a0,a0,1974 # ffffffffc020ea68 <dev_node_ops+0x4d8>
ffffffffc02092ba:	eedf60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02092be:	5a75                	li	s4,-3
ffffffffc02092c0:	b7c1                	j	ffffffffc0209280 <sfs_do_mount+0x184>
ffffffffc02092c2:	00005517          	auipc	a0,0x5
ffffffffc02092c6:	76e50513          	addi	a0,a0,1902 # ffffffffc020ea30 <dev_node_ops+0x4a0>
ffffffffc02092ca:	eddf60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02092ce:	5a75                	li	s4,-3
ffffffffc02092d0:	bf45                	j	ffffffffc0209280 <sfs_do_mount+0x184>
ffffffffc02092d2:	00442903          	lw	s2,4(s0)
ffffffffc02092d6:	4481                	li	s1,0
ffffffffc02092d8:	080b8c63          	beqz	s7,ffffffffc0209370 <sfs_do_mount+0x274>
ffffffffc02092dc:	85a6                	mv	a1,s1
ffffffffc02092de:	856a                	mv	a0,s10
ffffffffc02092e0:	af7ff0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc02092e4:	c111                	beqz	a0,ffffffffc02092e8 <sfs_do_mount+0x1ec>
ffffffffc02092e6:	2b05                	addiw	s6,s6,1
ffffffffc02092e8:	2485                	addiw	s1,s1,1
ffffffffc02092ea:	fe9b99e3          	bne	s7,s1,ffffffffc02092dc <sfs_do_mount+0x1e0>
ffffffffc02092ee:	441c                	lw	a5,8(s0)
ffffffffc02092f0:	0d679463          	bne	a5,s6,ffffffffc02093b8 <sfs_do_mount+0x2bc>
ffffffffc02092f4:	4585                	li	a1,1
ffffffffc02092f6:	05040513          	addi	a0,s0,80
ffffffffc02092fa:	04043023          	sd	zero,64(s0)
ffffffffc02092fe:	9bafb0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0209302:	4585                	li	a1,1
ffffffffc0209304:	06840513          	addi	a0,s0,104
ffffffffc0209308:	9b0fb0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc020930c:	4585                	li	a1,1
ffffffffc020930e:	08040513          	addi	a0,s0,128
ffffffffc0209312:	9a6fb0ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc0209316:	09840793          	addi	a5,s0,152
ffffffffc020931a:	f05c                	sd	a5,160(s0)
ffffffffc020931c:	ec5c                	sd	a5,152(s0)
ffffffffc020931e:	874a                	mv	a4,s2
ffffffffc0209320:	86da                	mv	a3,s6
ffffffffc0209322:	4169063b          	subw	a2,s2,s6
ffffffffc0209326:	00c40593          	addi	a1,s0,12
ffffffffc020932a:	00005517          	auipc	a0,0x5
ffffffffc020932e:	7ce50513          	addi	a0,a0,1998 # ffffffffc020eaf8 <dev_node_ops+0x568>
ffffffffc0209332:	e75f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209336:	00000797          	auipc	a5,0x0
ffffffffc020933a:	c8878793          	addi	a5,a5,-888 # ffffffffc0208fbe <sfs_sync>
ffffffffc020933e:	fc5c                	sd	a5,184(s0)
ffffffffc0209340:	00000797          	auipc	a5,0x0
ffffffffc0209344:	d6478793          	addi	a5,a5,-668 # ffffffffc02090a4 <sfs_get_root>
ffffffffc0209348:	e07c                	sd	a5,192(s0)
ffffffffc020934a:	00000797          	auipc	a5,0x0
ffffffffc020934e:	b5e78793          	addi	a5,a5,-1186 # ffffffffc0208ea8 <sfs_unmount>
ffffffffc0209352:	e47c                	sd	a5,200(s0)
ffffffffc0209354:	00000797          	auipc	a5,0x0
ffffffffc0209358:	bd878793          	addi	a5,a5,-1064 # ffffffffc0208f2c <sfs_cleanup>
ffffffffc020935c:	e87c                	sd	a5,208(s0)
ffffffffc020935e:	008ab023          	sd	s0,0(s5)
ffffffffc0209362:	b72d                	j	ffffffffc020928c <sfs_do_mount+0x190>
ffffffffc0209364:	5a71                	li	s4,-4
ffffffffc0209366:	bf11                	j	ffffffffc020927a <sfs_do_mount+0x17e>
ffffffffc0209368:	5a49                	li	s4,-14
ffffffffc020936a:	b70d                	j	ffffffffc020928c <sfs_do_mount+0x190>
ffffffffc020936c:	5a71                	li	s4,-4
ffffffffc020936e:	bf09                	j	ffffffffc0209280 <sfs_do_mount+0x184>
ffffffffc0209370:	4b01                	li	s6,0
ffffffffc0209372:	bfb5                	j	ffffffffc02092ee <sfs_do_mount+0x1f2>
ffffffffc0209374:	5a71                	li	s4,-4
ffffffffc0209376:	bf19                	j	ffffffffc020928c <sfs_do_mount+0x190>
ffffffffc0209378:	00005697          	auipc	a3,0x5
ffffffffc020937c:	72068693          	addi	a3,a3,1824 # ffffffffc020ea98 <dev_node_ops+0x508>
ffffffffc0209380:	00002617          	auipc	a2,0x2
ffffffffc0209384:	3b860613          	addi	a2,a2,952 # ffffffffc020b738 <commands+0x210>
ffffffffc0209388:	08300593          	li	a1,131
ffffffffc020938c:	00005517          	auipc	a0,0x5
ffffffffc0209390:	61450513          	addi	a0,a0,1556 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc0209394:	90af70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209398:	00005697          	auipc	a3,0x5
ffffffffc020939c:	5d868693          	addi	a3,a3,1496 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc02093a0:	00002617          	auipc	a2,0x2
ffffffffc02093a4:	39860613          	addi	a2,a2,920 # ffffffffc020b738 <commands+0x210>
ffffffffc02093a8:	0a300593          	li	a1,163
ffffffffc02093ac:	00005517          	auipc	a0,0x5
ffffffffc02093b0:	5f450513          	addi	a0,a0,1524 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc02093b4:	8eaf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02093b8:	00005697          	auipc	a3,0x5
ffffffffc02093bc:	71068693          	addi	a3,a3,1808 # ffffffffc020eac8 <dev_node_ops+0x538>
ffffffffc02093c0:	00002617          	auipc	a2,0x2
ffffffffc02093c4:	37860613          	addi	a2,a2,888 # ffffffffc020b738 <commands+0x210>
ffffffffc02093c8:	0e000593          	li	a1,224
ffffffffc02093cc:	00005517          	auipc	a0,0x5
ffffffffc02093d0:	5d450513          	addi	a0,a0,1492 # ffffffffc020e9a0 <dev_node_ops+0x410>
ffffffffc02093d4:	8caf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02093d8 <sfs_mount>:
ffffffffc02093d8:	00000597          	auipc	a1,0x0
ffffffffc02093dc:	d2458593          	addi	a1,a1,-732 # ffffffffc02090fc <sfs_do_mount>
ffffffffc02093e0:	817fe06f          	j	ffffffffc0207bf6 <vfs_mount>

ffffffffc02093e4 <sfs_opendir>:
ffffffffc02093e4:	0235f593          	andi	a1,a1,35
ffffffffc02093e8:	4501                	li	a0,0
ffffffffc02093ea:	e191                	bnez	a1,ffffffffc02093ee <sfs_opendir+0xa>
ffffffffc02093ec:	8082                	ret
ffffffffc02093ee:	553d                	li	a0,-17
ffffffffc02093f0:	8082                	ret

ffffffffc02093f2 <sfs_openfile>:
ffffffffc02093f2:	4501                	li	a0,0
ffffffffc02093f4:	8082                	ret

ffffffffc02093f6 <sfs_gettype>:
ffffffffc02093f6:	1141                	addi	sp,sp,-16
ffffffffc02093f8:	e406                	sd	ra,8(sp)
ffffffffc02093fa:	c939                	beqz	a0,ffffffffc0209450 <sfs_gettype+0x5a>
ffffffffc02093fc:	4d34                	lw	a3,88(a0)
ffffffffc02093fe:	6785                	lui	a5,0x1
ffffffffc0209400:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209404:	04e69663          	bne	a3,a4,ffffffffc0209450 <sfs_gettype+0x5a>
ffffffffc0209408:	6114                	ld	a3,0(a0)
ffffffffc020940a:	4709                	li	a4,2
ffffffffc020940c:	0046d683          	lhu	a3,4(a3)
ffffffffc0209410:	02e68a63          	beq	a3,a4,ffffffffc0209444 <sfs_gettype+0x4e>
ffffffffc0209414:	470d                	li	a4,3
ffffffffc0209416:	02e68163          	beq	a3,a4,ffffffffc0209438 <sfs_gettype+0x42>
ffffffffc020941a:	4705                	li	a4,1
ffffffffc020941c:	00e68f63          	beq	a3,a4,ffffffffc020943a <sfs_gettype+0x44>
ffffffffc0209420:	00005617          	auipc	a2,0x5
ffffffffc0209424:	74860613          	addi	a2,a2,1864 # ffffffffc020eb68 <dev_node_ops+0x5d8>
ffffffffc0209428:	39600593          	li	a1,918
ffffffffc020942c:	00005517          	auipc	a0,0x5
ffffffffc0209430:	72450513          	addi	a0,a0,1828 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209434:	86af70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209438:	678d                	lui	a5,0x3
ffffffffc020943a:	60a2                	ld	ra,8(sp)
ffffffffc020943c:	c19c                	sw	a5,0(a1)
ffffffffc020943e:	4501                	li	a0,0
ffffffffc0209440:	0141                	addi	sp,sp,16
ffffffffc0209442:	8082                	ret
ffffffffc0209444:	60a2                	ld	ra,8(sp)
ffffffffc0209446:	6789                	lui	a5,0x2
ffffffffc0209448:	c19c                	sw	a5,0(a1)
ffffffffc020944a:	4501                	li	a0,0
ffffffffc020944c:	0141                	addi	sp,sp,16
ffffffffc020944e:	8082                	ret
ffffffffc0209450:	00005697          	auipc	a3,0x5
ffffffffc0209454:	6c868693          	addi	a3,a3,1736 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc0209458:	00002617          	auipc	a2,0x2
ffffffffc020945c:	2e060613          	addi	a2,a2,736 # ffffffffc020b738 <commands+0x210>
ffffffffc0209460:	38a00593          	li	a1,906
ffffffffc0209464:	00005517          	auipc	a0,0x5
ffffffffc0209468:	6ec50513          	addi	a0,a0,1772 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020946c:	832f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209470 <sfs_fsync>:
ffffffffc0209470:	7179                	addi	sp,sp,-48
ffffffffc0209472:	ec26                	sd	s1,24(sp)
ffffffffc0209474:	7524                	ld	s1,104(a0)
ffffffffc0209476:	f406                	sd	ra,40(sp)
ffffffffc0209478:	f022                	sd	s0,32(sp)
ffffffffc020947a:	e84a                	sd	s2,16(sp)
ffffffffc020947c:	e44e                	sd	s3,8(sp)
ffffffffc020947e:	c4bd                	beqz	s1,ffffffffc02094ec <sfs_fsync+0x7c>
ffffffffc0209480:	0b04a783          	lw	a5,176(s1)
ffffffffc0209484:	e7a5                	bnez	a5,ffffffffc02094ec <sfs_fsync+0x7c>
ffffffffc0209486:	4d38                	lw	a4,88(a0)
ffffffffc0209488:	6785                	lui	a5,0x1
ffffffffc020948a:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020948e:	842a                	mv	s0,a0
ffffffffc0209490:	06f71e63          	bne	a4,a5,ffffffffc020950c <sfs_fsync+0x9c>
ffffffffc0209494:	691c                	ld	a5,16(a0)
ffffffffc0209496:	4901                	li	s2,0
ffffffffc0209498:	eb89                	bnez	a5,ffffffffc02094aa <sfs_fsync+0x3a>
ffffffffc020949a:	70a2                	ld	ra,40(sp)
ffffffffc020949c:	7402                	ld	s0,32(sp)
ffffffffc020949e:	64e2                	ld	s1,24(sp)
ffffffffc02094a0:	69a2                	ld	s3,8(sp)
ffffffffc02094a2:	854a                	mv	a0,s2
ffffffffc02094a4:	6942                	ld	s2,16(sp)
ffffffffc02094a6:	6145                	addi	sp,sp,48
ffffffffc02094a8:	8082                	ret
ffffffffc02094aa:	02050993          	addi	s3,a0,32
ffffffffc02094ae:	854e                	mv	a0,s3
ffffffffc02094b0:	812fb0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc02094b4:	681c                	ld	a5,16(s0)
ffffffffc02094b6:	ef81                	bnez	a5,ffffffffc02094ce <sfs_fsync+0x5e>
ffffffffc02094b8:	854e                	mv	a0,s3
ffffffffc02094ba:	804fb0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc02094be:	70a2                	ld	ra,40(sp)
ffffffffc02094c0:	7402                	ld	s0,32(sp)
ffffffffc02094c2:	64e2                	ld	s1,24(sp)
ffffffffc02094c4:	69a2                	ld	s3,8(sp)
ffffffffc02094c6:	854a                	mv	a0,s2
ffffffffc02094c8:	6942                	ld	s2,16(sp)
ffffffffc02094ca:	6145                	addi	sp,sp,48
ffffffffc02094cc:	8082                	ret
ffffffffc02094ce:	4414                	lw	a3,8(s0)
ffffffffc02094d0:	600c                	ld	a1,0(s0)
ffffffffc02094d2:	00043823          	sd	zero,16(s0)
ffffffffc02094d6:	4701                	li	a4,0
ffffffffc02094d8:	04000613          	li	a2,64
ffffffffc02094dc:	8526                	mv	a0,s1
ffffffffc02094de:	66e010ef          	jal	ra,ffffffffc020ab4c <sfs_wbuf>
ffffffffc02094e2:	892a                	mv	s2,a0
ffffffffc02094e4:	d971                	beqz	a0,ffffffffc02094b8 <sfs_fsync+0x48>
ffffffffc02094e6:	4785                	li	a5,1
ffffffffc02094e8:	e81c                	sd	a5,16(s0)
ffffffffc02094ea:	b7f9                	j	ffffffffc02094b8 <sfs_fsync+0x48>
ffffffffc02094ec:	00005697          	auipc	a3,0x5
ffffffffc02094f0:	48468693          	addi	a3,a3,1156 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc02094f4:	00002617          	auipc	a2,0x2
ffffffffc02094f8:	24460613          	addi	a2,a2,580 # ffffffffc020b738 <commands+0x210>
ffffffffc02094fc:	2ce00593          	li	a1,718
ffffffffc0209500:	00005517          	auipc	a0,0x5
ffffffffc0209504:	65050513          	addi	a0,a0,1616 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209508:	f97f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020950c:	00005697          	auipc	a3,0x5
ffffffffc0209510:	60c68693          	addi	a3,a3,1548 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc0209514:	00002617          	auipc	a2,0x2
ffffffffc0209518:	22460613          	addi	a2,a2,548 # ffffffffc020b738 <commands+0x210>
ffffffffc020951c:	2cf00593          	li	a1,719
ffffffffc0209520:	00005517          	auipc	a0,0x5
ffffffffc0209524:	63050513          	addi	a0,a0,1584 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209528:	f77f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020952c <sfs_fstat>:
ffffffffc020952c:	1101                	addi	sp,sp,-32
ffffffffc020952e:	e426                	sd	s1,8(sp)
ffffffffc0209530:	84ae                	mv	s1,a1
ffffffffc0209532:	e822                	sd	s0,16(sp)
ffffffffc0209534:	02000613          	li	a2,32
ffffffffc0209538:	842a                	mv	s0,a0
ffffffffc020953a:	4581                	li	a1,0
ffffffffc020953c:	8526                	mv	a0,s1
ffffffffc020953e:	ec06                	sd	ra,24(sp)
ffffffffc0209540:	511010ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc0209544:	c439                	beqz	s0,ffffffffc0209592 <sfs_fstat+0x66>
ffffffffc0209546:	783c                	ld	a5,112(s0)
ffffffffc0209548:	c7a9                	beqz	a5,ffffffffc0209592 <sfs_fstat+0x66>
ffffffffc020954a:	6bbc                	ld	a5,80(a5)
ffffffffc020954c:	c3b9                	beqz	a5,ffffffffc0209592 <sfs_fstat+0x66>
ffffffffc020954e:	00005597          	auipc	a1,0x5
ffffffffc0209552:	fba58593          	addi	a1,a1,-70 # ffffffffc020e508 <syscalls+0xdb0>
ffffffffc0209556:	8522                	mv	a0,s0
ffffffffc0209558:	8cefe0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc020955c:	783c                	ld	a5,112(s0)
ffffffffc020955e:	85a6                	mv	a1,s1
ffffffffc0209560:	8522                	mv	a0,s0
ffffffffc0209562:	6bbc                	ld	a5,80(a5)
ffffffffc0209564:	9782                	jalr	a5
ffffffffc0209566:	e10d                	bnez	a0,ffffffffc0209588 <sfs_fstat+0x5c>
ffffffffc0209568:	4c38                	lw	a4,88(s0)
ffffffffc020956a:	6785                	lui	a5,0x1
ffffffffc020956c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209570:	04f71163          	bne	a4,a5,ffffffffc02095b2 <sfs_fstat+0x86>
ffffffffc0209574:	601c                	ld	a5,0(s0)
ffffffffc0209576:	0067d683          	lhu	a3,6(a5)
ffffffffc020957a:	0087e703          	lwu	a4,8(a5)
ffffffffc020957e:	0007e783          	lwu	a5,0(a5)
ffffffffc0209582:	e494                	sd	a3,8(s1)
ffffffffc0209584:	e898                	sd	a4,16(s1)
ffffffffc0209586:	ec9c                	sd	a5,24(s1)
ffffffffc0209588:	60e2                	ld	ra,24(sp)
ffffffffc020958a:	6442                	ld	s0,16(sp)
ffffffffc020958c:	64a2                	ld	s1,8(sp)
ffffffffc020958e:	6105                	addi	sp,sp,32
ffffffffc0209590:	8082                	ret
ffffffffc0209592:	00005697          	auipc	a3,0x5
ffffffffc0209596:	f0e68693          	addi	a3,a3,-242 # ffffffffc020e4a0 <syscalls+0xd48>
ffffffffc020959a:	00002617          	auipc	a2,0x2
ffffffffc020959e:	19e60613          	addi	a2,a2,414 # ffffffffc020b738 <commands+0x210>
ffffffffc02095a2:	2bf00593          	li	a1,703
ffffffffc02095a6:	00005517          	auipc	a0,0x5
ffffffffc02095aa:	5aa50513          	addi	a0,a0,1450 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc02095ae:	ef1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02095b2:	00005697          	auipc	a3,0x5
ffffffffc02095b6:	56668693          	addi	a3,a3,1382 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc02095ba:	00002617          	auipc	a2,0x2
ffffffffc02095be:	17e60613          	addi	a2,a2,382 # ffffffffc020b738 <commands+0x210>
ffffffffc02095c2:	2c200593          	li	a1,706
ffffffffc02095c6:	00005517          	auipc	a0,0x5
ffffffffc02095ca:	58a50513          	addi	a0,a0,1418 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc02095ce:	ed1f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02095d2 <sfs_tryseek>:
ffffffffc02095d2:	080007b7          	lui	a5,0x8000
ffffffffc02095d6:	04f5fd63          	bgeu	a1,a5,ffffffffc0209630 <sfs_tryseek+0x5e>
ffffffffc02095da:	1101                	addi	sp,sp,-32
ffffffffc02095dc:	e822                	sd	s0,16(sp)
ffffffffc02095de:	ec06                	sd	ra,24(sp)
ffffffffc02095e0:	e426                	sd	s1,8(sp)
ffffffffc02095e2:	842a                	mv	s0,a0
ffffffffc02095e4:	c921                	beqz	a0,ffffffffc0209634 <sfs_tryseek+0x62>
ffffffffc02095e6:	4d38                	lw	a4,88(a0)
ffffffffc02095e8:	6785                	lui	a5,0x1
ffffffffc02095ea:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02095ee:	04f71363          	bne	a4,a5,ffffffffc0209634 <sfs_tryseek+0x62>
ffffffffc02095f2:	611c                	ld	a5,0(a0)
ffffffffc02095f4:	84ae                	mv	s1,a1
ffffffffc02095f6:	0007e783          	lwu	a5,0(a5)
ffffffffc02095fa:	02b7d563          	bge	a5,a1,ffffffffc0209624 <sfs_tryseek+0x52>
ffffffffc02095fe:	793c                	ld	a5,112(a0)
ffffffffc0209600:	cbb1                	beqz	a5,ffffffffc0209654 <sfs_tryseek+0x82>
ffffffffc0209602:	73bc                	ld	a5,96(a5)
ffffffffc0209604:	cba1                	beqz	a5,ffffffffc0209654 <sfs_tryseek+0x82>
ffffffffc0209606:	00005597          	auipc	a1,0x5
ffffffffc020960a:	df258593          	addi	a1,a1,-526 # ffffffffc020e3f8 <syscalls+0xca0>
ffffffffc020960e:	818fe0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0209612:	783c                	ld	a5,112(s0)
ffffffffc0209614:	8522                	mv	a0,s0
ffffffffc0209616:	6442                	ld	s0,16(sp)
ffffffffc0209618:	60e2                	ld	ra,24(sp)
ffffffffc020961a:	73bc                	ld	a5,96(a5)
ffffffffc020961c:	85a6                	mv	a1,s1
ffffffffc020961e:	64a2                	ld	s1,8(sp)
ffffffffc0209620:	6105                	addi	sp,sp,32
ffffffffc0209622:	8782                	jr	a5
ffffffffc0209624:	60e2                	ld	ra,24(sp)
ffffffffc0209626:	6442                	ld	s0,16(sp)
ffffffffc0209628:	64a2                	ld	s1,8(sp)
ffffffffc020962a:	4501                	li	a0,0
ffffffffc020962c:	6105                	addi	sp,sp,32
ffffffffc020962e:	8082                	ret
ffffffffc0209630:	5575                	li	a0,-3
ffffffffc0209632:	8082                	ret
ffffffffc0209634:	00005697          	auipc	a3,0x5
ffffffffc0209638:	4e468693          	addi	a3,a3,1252 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020963c:	00002617          	auipc	a2,0x2
ffffffffc0209640:	0fc60613          	addi	a2,a2,252 # ffffffffc020b738 <commands+0x210>
ffffffffc0209644:	3a100593          	li	a1,929
ffffffffc0209648:	00005517          	auipc	a0,0x5
ffffffffc020964c:	50850513          	addi	a0,a0,1288 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209650:	e4ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209654:	00005697          	auipc	a3,0x5
ffffffffc0209658:	d4c68693          	addi	a3,a3,-692 # ffffffffc020e3a0 <syscalls+0xc48>
ffffffffc020965c:	00002617          	auipc	a2,0x2
ffffffffc0209660:	0dc60613          	addi	a2,a2,220 # ffffffffc020b738 <commands+0x210>
ffffffffc0209664:	3a300593          	li	a1,931
ffffffffc0209668:	00005517          	auipc	a0,0x5
ffffffffc020966c:	4e850513          	addi	a0,a0,1256 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209670:	e2ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209674 <sfs_close>:
ffffffffc0209674:	1141                	addi	sp,sp,-16
ffffffffc0209676:	e406                	sd	ra,8(sp)
ffffffffc0209678:	e022                	sd	s0,0(sp)
ffffffffc020967a:	c11d                	beqz	a0,ffffffffc02096a0 <sfs_close+0x2c>
ffffffffc020967c:	793c                	ld	a5,112(a0)
ffffffffc020967e:	842a                	mv	s0,a0
ffffffffc0209680:	c385                	beqz	a5,ffffffffc02096a0 <sfs_close+0x2c>
ffffffffc0209682:	7b9c                	ld	a5,48(a5)
ffffffffc0209684:	cf91                	beqz	a5,ffffffffc02096a0 <sfs_close+0x2c>
ffffffffc0209686:	00004597          	auipc	a1,0x4
ffffffffc020968a:	a2a58593          	addi	a1,a1,-1494 # ffffffffc020d0b0 <default_pmm_manager+0xe90>
ffffffffc020968e:	f99fd0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc0209692:	783c                	ld	a5,112(s0)
ffffffffc0209694:	8522                	mv	a0,s0
ffffffffc0209696:	6402                	ld	s0,0(sp)
ffffffffc0209698:	60a2                	ld	ra,8(sp)
ffffffffc020969a:	7b9c                	ld	a5,48(a5)
ffffffffc020969c:	0141                	addi	sp,sp,16
ffffffffc020969e:	8782                	jr	a5
ffffffffc02096a0:	00004697          	auipc	a3,0x4
ffffffffc02096a4:	9c068693          	addi	a3,a3,-1600 # ffffffffc020d060 <default_pmm_manager+0xe40>
ffffffffc02096a8:	00002617          	auipc	a2,0x2
ffffffffc02096ac:	09060613          	addi	a2,a2,144 # ffffffffc020b738 <commands+0x210>
ffffffffc02096b0:	21c00593          	li	a1,540
ffffffffc02096b4:	00005517          	auipc	a0,0x5
ffffffffc02096b8:	49c50513          	addi	a0,a0,1180 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc02096bc:	de3f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02096c0 <sfs_io.part.0>:
ffffffffc02096c0:	1141                	addi	sp,sp,-16
ffffffffc02096c2:	00005697          	auipc	a3,0x5
ffffffffc02096c6:	45668693          	addi	a3,a3,1110 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc02096ca:	00002617          	auipc	a2,0x2
ffffffffc02096ce:	06e60613          	addi	a2,a2,110 # ffffffffc020b738 <commands+0x210>
ffffffffc02096d2:	29e00593          	li	a1,670
ffffffffc02096d6:	00005517          	auipc	a0,0x5
ffffffffc02096da:	47a50513          	addi	a0,a0,1146 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc02096de:	e406                	sd	ra,8(sp)
ffffffffc02096e0:	dbff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02096e4 <sfs_block_free>:
ffffffffc02096e4:	1101                	addi	sp,sp,-32
ffffffffc02096e6:	e426                	sd	s1,8(sp)
ffffffffc02096e8:	ec06                	sd	ra,24(sp)
ffffffffc02096ea:	e822                	sd	s0,16(sp)
ffffffffc02096ec:	4154                	lw	a3,4(a0)
ffffffffc02096ee:	84ae                	mv	s1,a1
ffffffffc02096f0:	c595                	beqz	a1,ffffffffc020971c <sfs_block_free+0x38>
ffffffffc02096f2:	02d5f563          	bgeu	a1,a3,ffffffffc020971c <sfs_block_free+0x38>
ffffffffc02096f6:	842a                	mv	s0,a0
ffffffffc02096f8:	7d08                	ld	a0,56(a0)
ffffffffc02096fa:	edcff0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc02096fe:	ed05                	bnez	a0,ffffffffc0209736 <sfs_block_free+0x52>
ffffffffc0209700:	7c08                	ld	a0,56(s0)
ffffffffc0209702:	85a6                	mv	a1,s1
ffffffffc0209704:	efaff0ef          	jal	ra,ffffffffc0208dfe <bitmap_free>
ffffffffc0209708:	441c                	lw	a5,8(s0)
ffffffffc020970a:	4705                	li	a4,1
ffffffffc020970c:	60e2                	ld	ra,24(sp)
ffffffffc020970e:	2785                	addiw	a5,a5,1
ffffffffc0209710:	e038                	sd	a4,64(s0)
ffffffffc0209712:	c41c                	sw	a5,8(s0)
ffffffffc0209714:	6442                	ld	s0,16(sp)
ffffffffc0209716:	64a2                	ld	s1,8(sp)
ffffffffc0209718:	6105                	addi	sp,sp,32
ffffffffc020971a:	8082                	ret
ffffffffc020971c:	8726                	mv	a4,s1
ffffffffc020971e:	00005617          	auipc	a2,0x5
ffffffffc0209722:	46260613          	addi	a2,a2,1122 # ffffffffc020eb80 <dev_node_ops+0x5f0>
ffffffffc0209726:	05300593          	li	a1,83
ffffffffc020972a:	00005517          	auipc	a0,0x5
ffffffffc020972e:	42650513          	addi	a0,a0,1062 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209732:	d6df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209736:	00005697          	auipc	a3,0x5
ffffffffc020973a:	48268693          	addi	a3,a3,1154 # ffffffffc020ebb8 <dev_node_ops+0x628>
ffffffffc020973e:	00002617          	auipc	a2,0x2
ffffffffc0209742:	ffa60613          	addi	a2,a2,-6 # ffffffffc020b738 <commands+0x210>
ffffffffc0209746:	06a00593          	li	a1,106
ffffffffc020974a:	00005517          	auipc	a0,0x5
ffffffffc020974e:	40650513          	addi	a0,a0,1030 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209752:	d4df60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209756 <sfs_reclaim>:
ffffffffc0209756:	1101                	addi	sp,sp,-32
ffffffffc0209758:	e426                	sd	s1,8(sp)
ffffffffc020975a:	7524                	ld	s1,104(a0)
ffffffffc020975c:	ec06                	sd	ra,24(sp)
ffffffffc020975e:	e822                	sd	s0,16(sp)
ffffffffc0209760:	e04a                	sd	s2,0(sp)
ffffffffc0209762:	0e048a63          	beqz	s1,ffffffffc0209856 <sfs_reclaim+0x100>
ffffffffc0209766:	0b04a783          	lw	a5,176(s1)
ffffffffc020976a:	0e079663          	bnez	a5,ffffffffc0209856 <sfs_reclaim+0x100>
ffffffffc020976e:	4d38                	lw	a4,88(a0)
ffffffffc0209770:	6785                	lui	a5,0x1
ffffffffc0209772:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209776:	842a                	mv	s0,a0
ffffffffc0209778:	10f71f63          	bne	a4,a5,ffffffffc0209896 <sfs_reclaim+0x140>
ffffffffc020977c:	8526                	mv	a0,s1
ffffffffc020977e:	57e010ef          	jal	ra,ffffffffc020acfc <lock_sfs_fs>
ffffffffc0209782:	4c1c                	lw	a5,24(s0)
ffffffffc0209784:	0ef05963          	blez	a5,ffffffffc0209876 <sfs_reclaim+0x120>
ffffffffc0209788:	fff7871b          	addiw	a4,a5,-1
ffffffffc020978c:	cc18                	sw	a4,24(s0)
ffffffffc020978e:	eb59                	bnez	a4,ffffffffc0209824 <sfs_reclaim+0xce>
ffffffffc0209790:	05c42903          	lw	s2,92(s0)
ffffffffc0209794:	08091863          	bnez	s2,ffffffffc0209824 <sfs_reclaim+0xce>
ffffffffc0209798:	601c                	ld	a5,0(s0)
ffffffffc020979a:	0067d783          	lhu	a5,6(a5)
ffffffffc020979e:	e785                	bnez	a5,ffffffffc02097c6 <sfs_reclaim+0x70>
ffffffffc02097a0:	783c                	ld	a5,112(s0)
ffffffffc02097a2:	10078a63          	beqz	a5,ffffffffc02098b6 <sfs_reclaim+0x160>
ffffffffc02097a6:	73bc                	ld	a5,96(a5)
ffffffffc02097a8:	10078763          	beqz	a5,ffffffffc02098b6 <sfs_reclaim+0x160>
ffffffffc02097ac:	00005597          	auipc	a1,0x5
ffffffffc02097b0:	c4c58593          	addi	a1,a1,-948 # ffffffffc020e3f8 <syscalls+0xca0>
ffffffffc02097b4:	8522                	mv	a0,s0
ffffffffc02097b6:	e71fd0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc02097ba:	783c                	ld	a5,112(s0)
ffffffffc02097bc:	4581                	li	a1,0
ffffffffc02097be:	8522                	mv	a0,s0
ffffffffc02097c0:	73bc                	ld	a5,96(a5)
ffffffffc02097c2:	9782                	jalr	a5
ffffffffc02097c4:	e559                	bnez	a0,ffffffffc0209852 <sfs_reclaim+0xfc>
ffffffffc02097c6:	681c                	ld	a5,16(s0)
ffffffffc02097c8:	c39d                	beqz	a5,ffffffffc02097ee <sfs_reclaim+0x98>
ffffffffc02097ca:	783c                	ld	a5,112(s0)
ffffffffc02097cc:	10078563          	beqz	a5,ffffffffc02098d6 <sfs_reclaim+0x180>
ffffffffc02097d0:	7b9c                	ld	a5,48(a5)
ffffffffc02097d2:	10078263          	beqz	a5,ffffffffc02098d6 <sfs_reclaim+0x180>
ffffffffc02097d6:	8522                	mv	a0,s0
ffffffffc02097d8:	00004597          	auipc	a1,0x4
ffffffffc02097dc:	8d858593          	addi	a1,a1,-1832 # ffffffffc020d0b0 <default_pmm_manager+0xe90>
ffffffffc02097e0:	e47fd0ef          	jal	ra,ffffffffc0207626 <inode_check>
ffffffffc02097e4:	783c                	ld	a5,112(s0)
ffffffffc02097e6:	8522                	mv	a0,s0
ffffffffc02097e8:	7b9c                	ld	a5,48(a5)
ffffffffc02097ea:	9782                	jalr	a5
ffffffffc02097ec:	e13d                	bnez	a0,ffffffffc0209852 <sfs_reclaim+0xfc>
ffffffffc02097ee:	7c18                	ld	a4,56(s0)
ffffffffc02097f0:	603c                	ld	a5,64(s0)
ffffffffc02097f2:	8526                	mv	a0,s1
ffffffffc02097f4:	e71c                	sd	a5,8(a4)
ffffffffc02097f6:	e398                	sd	a4,0(a5)
ffffffffc02097f8:	6438                	ld	a4,72(s0)
ffffffffc02097fa:	683c                	ld	a5,80(s0)
ffffffffc02097fc:	e71c                	sd	a5,8(a4)
ffffffffc02097fe:	e398                	sd	a4,0(a5)
ffffffffc0209800:	50c010ef          	jal	ra,ffffffffc020ad0c <unlock_sfs_fs>
ffffffffc0209804:	6008                	ld	a0,0(s0)
ffffffffc0209806:	00655783          	lhu	a5,6(a0)
ffffffffc020980a:	cb85                	beqz	a5,ffffffffc020983a <sfs_reclaim+0xe4>
ffffffffc020980c:	833f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209810:	8522                	mv	a0,s0
ffffffffc0209812:	da9fd0ef          	jal	ra,ffffffffc02075ba <inode_kill>
ffffffffc0209816:	60e2                	ld	ra,24(sp)
ffffffffc0209818:	6442                	ld	s0,16(sp)
ffffffffc020981a:	64a2                	ld	s1,8(sp)
ffffffffc020981c:	854a                	mv	a0,s2
ffffffffc020981e:	6902                	ld	s2,0(sp)
ffffffffc0209820:	6105                	addi	sp,sp,32
ffffffffc0209822:	8082                	ret
ffffffffc0209824:	5945                	li	s2,-15
ffffffffc0209826:	8526                	mv	a0,s1
ffffffffc0209828:	4e4010ef          	jal	ra,ffffffffc020ad0c <unlock_sfs_fs>
ffffffffc020982c:	60e2                	ld	ra,24(sp)
ffffffffc020982e:	6442                	ld	s0,16(sp)
ffffffffc0209830:	64a2                	ld	s1,8(sp)
ffffffffc0209832:	854a                	mv	a0,s2
ffffffffc0209834:	6902                	ld	s2,0(sp)
ffffffffc0209836:	6105                	addi	sp,sp,32
ffffffffc0209838:	8082                	ret
ffffffffc020983a:	440c                	lw	a1,8(s0)
ffffffffc020983c:	8526                	mv	a0,s1
ffffffffc020983e:	ea7ff0ef          	jal	ra,ffffffffc02096e4 <sfs_block_free>
ffffffffc0209842:	6008                	ld	a0,0(s0)
ffffffffc0209844:	5d4c                	lw	a1,60(a0)
ffffffffc0209846:	d1f9                	beqz	a1,ffffffffc020980c <sfs_reclaim+0xb6>
ffffffffc0209848:	8526                	mv	a0,s1
ffffffffc020984a:	e9bff0ef          	jal	ra,ffffffffc02096e4 <sfs_block_free>
ffffffffc020984e:	6008                	ld	a0,0(s0)
ffffffffc0209850:	bf75                	j	ffffffffc020980c <sfs_reclaim+0xb6>
ffffffffc0209852:	892a                	mv	s2,a0
ffffffffc0209854:	bfc9                	j	ffffffffc0209826 <sfs_reclaim+0xd0>
ffffffffc0209856:	00005697          	auipc	a3,0x5
ffffffffc020985a:	11a68693          	addi	a3,a3,282 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc020985e:	00002617          	auipc	a2,0x2
ffffffffc0209862:	eda60613          	addi	a2,a2,-294 # ffffffffc020b738 <commands+0x210>
ffffffffc0209866:	35f00593          	li	a1,863
ffffffffc020986a:	00005517          	auipc	a0,0x5
ffffffffc020986e:	2e650513          	addi	a0,a0,742 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209872:	c2df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209876:	00005697          	auipc	a3,0x5
ffffffffc020987a:	36268693          	addi	a3,a3,866 # ffffffffc020ebd8 <dev_node_ops+0x648>
ffffffffc020987e:	00002617          	auipc	a2,0x2
ffffffffc0209882:	eba60613          	addi	a2,a2,-326 # ffffffffc020b738 <commands+0x210>
ffffffffc0209886:	36500593          	li	a1,869
ffffffffc020988a:	00005517          	auipc	a0,0x5
ffffffffc020988e:	2c650513          	addi	a0,a0,710 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209892:	c0df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209896:	00005697          	auipc	a3,0x5
ffffffffc020989a:	28268693          	addi	a3,a3,642 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020989e:	00002617          	auipc	a2,0x2
ffffffffc02098a2:	e9a60613          	addi	a2,a2,-358 # ffffffffc020b738 <commands+0x210>
ffffffffc02098a6:	36000593          	li	a1,864
ffffffffc02098aa:	00005517          	auipc	a0,0x5
ffffffffc02098ae:	2a650513          	addi	a0,a0,678 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc02098b2:	bedf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098b6:	00005697          	auipc	a3,0x5
ffffffffc02098ba:	aea68693          	addi	a3,a3,-1302 # ffffffffc020e3a0 <syscalls+0xc48>
ffffffffc02098be:	00002617          	auipc	a2,0x2
ffffffffc02098c2:	e7a60613          	addi	a2,a2,-390 # ffffffffc020b738 <commands+0x210>
ffffffffc02098c6:	36a00593          	li	a1,874
ffffffffc02098ca:	00005517          	auipc	a0,0x5
ffffffffc02098ce:	28650513          	addi	a0,a0,646 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc02098d2:	bcdf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098d6:	00003697          	auipc	a3,0x3
ffffffffc02098da:	78a68693          	addi	a3,a3,1930 # ffffffffc020d060 <default_pmm_manager+0xe40>
ffffffffc02098de:	00002617          	auipc	a2,0x2
ffffffffc02098e2:	e5a60613          	addi	a2,a2,-422 # ffffffffc020b738 <commands+0x210>
ffffffffc02098e6:	36f00593          	li	a1,879
ffffffffc02098ea:	00005517          	auipc	a0,0x5
ffffffffc02098ee:	26650513          	addi	a0,a0,614 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc02098f2:	badf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02098f6 <sfs_block_alloc>:
ffffffffc02098f6:	1101                	addi	sp,sp,-32
ffffffffc02098f8:	e822                	sd	s0,16(sp)
ffffffffc02098fa:	842a                	mv	s0,a0
ffffffffc02098fc:	7d08                	ld	a0,56(a0)
ffffffffc02098fe:	e426                	sd	s1,8(sp)
ffffffffc0209900:	ec06                	sd	ra,24(sp)
ffffffffc0209902:	84ae                	mv	s1,a1
ffffffffc0209904:	c62ff0ef          	jal	ra,ffffffffc0208d66 <bitmap_alloc>
ffffffffc0209908:	e90d                	bnez	a0,ffffffffc020993a <sfs_block_alloc+0x44>
ffffffffc020990a:	441c                	lw	a5,8(s0)
ffffffffc020990c:	cbad                	beqz	a5,ffffffffc020997e <sfs_block_alloc+0x88>
ffffffffc020990e:	37fd                	addiw	a5,a5,-1
ffffffffc0209910:	c41c                	sw	a5,8(s0)
ffffffffc0209912:	408c                	lw	a1,0(s1)
ffffffffc0209914:	4785                	li	a5,1
ffffffffc0209916:	e03c                	sd	a5,64(s0)
ffffffffc0209918:	4054                	lw	a3,4(s0)
ffffffffc020991a:	c58d                	beqz	a1,ffffffffc0209944 <sfs_block_alloc+0x4e>
ffffffffc020991c:	02d5f463          	bgeu	a1,a3,ffffffffc0209944 <sfs_block_alloc+0x4e>
ffffffffc0209920:	7c08                	ld	a0,56(s0)
ffffffffc0209922:	cb4ff0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc0209926:	ed05                	bnez	a0,ffffffffc020995e <sfs_block_alloc+0x68>
ffffffffc0209928:	8522                	mv	a0,s0
ffffffffc020992a:	6442                	ld	s0,16(sp)
ffffffffc020992c:	408c                	lw	a1,0(s1)
ffffffffc020992e:	60e2                	ld	ra,24(sp)
ffffffffc0209930:	64a2                	ld	s1,8(sp)
ffffffffc0209932:	4605                	li	a2,1
ffffffffc0209934:	6105                	addi	sp,sp,32
ffffffffc0209936:	3660106f          	j	ffffffffc020ac9c <sfs_clear_block>
ffffffffc020993a:	60e2                	ld	ra,24(sp)
ffffffffc020993c:	6442                	ld	s0,16(sp)
ffffffffc020993e:	64a2                	ld	s1,8(sp)
ffffffffc0209940:	6105                	addi	sp,sp,32
ffffffffc0209942:	8082                	ret
ffffffffc0209944:	872e                	mv	a4,a1
ffffffffc0209946:	00005617          	auipc	a2,0x5
ffffffffc020994a:	23a60613          	addi	a2,a2,570 # ffffffffc020eb80 <dev_node_ops+0x5f0>
ffffffffc020994e:	05300593          	li	a1,83
ffffffffc0209952:	00005517          	auipc	a0,0x5
ffffffffc0209956:	1fe50513          	addi	a0,a0,510 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020995a:	b45f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020995e:	00005697          	auipc	a3,0x5
ffffffffc0209962:	2b268693          	addi	a3,a3,690 # ffffffffc020ec10 <dev_node_ops+0x680>
ffffffffc0209966:	00002617          	auipc	a2,0x2
ffffffffc020996a:	dd260613          	addi	a2,a2,-558 # ffffffffc020b738 <commands+0x210>
ffffffffc020996e:	06100593          	li	a1,97
ffffffffc0209972:	00005517          	auipc	a0,0x5
ffffffffc0209976:	1de50513          	addi	a0,a0,478 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020997a:	b25f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020997e:	00005697          	auipc	a3,0x5
ffffffffc0209982:	27268693          	addi	a3,a3,626 # ffffffffc020ebf0 <dev_node_ops+0x660>
ffffffffc0209986:	00002617          	auipc	a2,0x2
ffffffffc020998a:	db260613          	addi	a2,a2,-590 # ffffffffc020b738 <commands+0x210>
ffffffffc020998e:	05f00593          	li	a1,95
ffffffffc0209992:	00005517          	auipc	a0,0x5
ffffffffc0209996:	1be50513          	addi	a0,a0,446 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020999a:	b05f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020999e <sfs_bmap_load_nolock>:
ffffffffc020999e:	7159                	addi	sp,sp,-112
ffffffffc02099a0:	f85a                	sd	s6,48(sp)
ffffffffc02099a2:	0005bb03          	ld	s6,0(a1)
ffffffffc02099a6:	f45e                	sd	s7,40(sp)
ffffffffc02099a8:	f486                	sd	ra,104(sp)
ffffffffc02099aa:	008b2b83          	lw	s7,8(s6)
ffffffffc02099ae:	f0a2                	sd	s0,96(sp)
ffffffffc02099b0:	eca6                	sd	s1,88(sp)
ffffffffc02099b2:	e8ca                	sd	s2,80(sp)
ffffffffc02099b4:	e4ce                	sd	s3,72(sp)
ffffffffc02099b6:	e0d2                	sd	s4,64(sp)
ffffffffc02099b8:	fc56                	sd	s5,56(sp)
ffffffffc02099ba:	f062                	sd	s8,32(sp)
ffffffffc02099bc:	ec66                	sd	s9,24(sp)
ffffffffc02099be:	18cbe363          	bltu	s7,a2,ffffffffc0209b44 <sfs_bmap_load_nolock+0x1a6>
ffffffffc02099c2:	47ad                	li	a5,11
ffffffffc02099c4:	8aae                	mv	s5,a1
ffffffffc02099c6:	8432                	mv	s0,a2
ffffffffc02099c8:	84aa                	mv	s1,a0
ffffffffc02099ca:	89b6                	mv	s3,a3
ffffffffc02099cc:	04c7f563          	bgeu	a5,a2,ffffffffc0209a16 <sfs_bmap_load_nolock+0x78>
ffffffffc02099d0:	ff46071b          	addiw	a4,a2,-12
ffffffffc02099d4:	0007069b          	sext.w	a3,a4
ffffffffc02099d8:	3ff00793          	li	a5,1023
ffffffffc02099dc:	1ad7e163          	bltu	a5,a3,ffffffffc0209b7e <sfs_bmap_load_nolock+0x1e0>
ffffffffc02099e0:	03cb2a03          	lw	s4,60(s6)
ffffffffc02099e4:	02071793          	slli	a5,a4,0x20
ffffffffc02099e8:	c602                	sw	zero,12(sp)
ffffffffc02099ea:	c452                	sw	s4,8(sp)
ffffffffc02099ec:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc02099f0:	0e0a1e63          	bnez	s4,ffffffffc0209aec <sfs_bmap_load_nolock+0x14e>
ffffffffc02099f4:	0acb8663          	beq	s7,a2,ffffffffc0209aa0 <sfs_bmap_load_nolock+0x102>
ffffffffc02099f8:	4a01                	li	s4,0
ffffffffc02099fa:	40d4                	lw	a3,4(s1)
ffffffffc02099fc:	8752                	mv	a4,s4
ffffffffc02099fe:	00005617          	auipc	a2,0x5
ffffffffc0209a02:	18260613          	addi	a2,a2,386 # ffffffffc020eb80 <dev_node_ops+0x5f0>
ffffffffc0209a06:	05300593          	li	a1,83
ffffffffc0209a0a:	00005517          	auipc	a0,0x5
ffffffffc0209a0e:	14650513          	addi	a0,a0,326 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209a12:	a8df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a16:	02061793          	slli	a5,a2,0x20
ffffffffc0209a1a:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209a1e:	9a5a                	add	s4,s4,s6
ffffffffc0209a20:	00ca2583          	lw	a1,12(s4)
ffffffffc0209a24:	c22e                	sw	a1,4(sp)
ffffffffc0209a26:	ed99                	bnez	a1,ffffffffc0209a44 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209a28:	fccb98e3          	bne	s7,a2,ffffffffc02099f8 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209a2c:	004c                	addi	a1,sp,4
ffffffffc0209a2e:	ec9ff0ef          	jal	ra,ffffffffc02098f6 <sfs_block_alloc>
ffffffffc0209a32:	892a                	mv	s2,a0
ffffffffc0209a34:	e921                	bnez	a0,ffffffffc0209a84 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209a36:	4592                	lw	a1,4(sp)
ffffffffc0209a38:	4705                	li	a4,1
ffffffffc0209a3a:	00ba2623          	sw	a1,12(s4)
ffffffffc0209a3e:	00eab823          	sd	a4,16(s5)
ffffffffc0209a42:	d9dd                	beqz	a1,ffffffffc02099f8 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209a44:	40d4                	lw	a3,4(s1)
ffffffffc0209a46:	10d5ff63          	bgeu	a1,a3,ffffffffc0209b64 <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209a4a:	7c88                	ld	a0,56(s1)
ffffffffc0209a4c:	b8aff0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc0209a50:	18051363          	bnez	a0,ffffffffc0209bd6 <sfs_bmap_load_nolock+0x238>
ffffffffc0209a54:	4a12                	lw	s4,4(sp)
ffffffffc0209a56:	fa0a02e3          	beqz	s4,ffffffffc02099fa <sfs_bmap_load_nolock+0x5c>
ffffffffc0209a5a:	40dc                	lw	a5,4(s1)
ffffffffc0209a5c:	f8fa7fe3          	bgeu	s4,a5,ffffffffc02099fa <sfs_bmap_load_nolock+0x5c>
ffffffffc0209a60:	7c88                	ld	a0,56(s1)
ffffffffc0209a62:	85d2                	mv	a1,s4
ffffffffc0209a64:	b72ff0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc0209a68:	12051763          	bnez	a0,ffffffffc0209b96 <sfs_bmap_load_nolock+0x1f8>
ffffffffc0209a6c:	008b9763          	bne	s7,s0,ffffffffc0209a7a <sfs_bmap_load_nolock+0xdc>
ffffffffc0209a70:	008b2783          	lw	a5,8(s6)
ffffffffc0209a74:	2785                	addiw	a5,a5,1
ffffffffc0209a76:	00fb2423          	sw	a5,8(s6)
ffffffffc0209a7a:	4901                	li	s2,0
ffffffffc0209a7c:	00098463          	beqz	s3,ffffffffc0209a84 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209a80:	0149a023          	sw	s4,0(s3)
ffffffffc0209a84:	70a6                	ld	ra,104(sp)
ffffffffc0209a86:	7406                	ld	s0,96(sp)
ffffffffc0209a88:	64e6                	ld	s1,88(sp)
ffffffffc0209a8a:	69a6                	ld	s3,72(sp)
ffffffffc0209a8c:	6a06                	ld	s4,64(sp)
ffffffffc0209a8e:	7ae2                	ld	s5,56(sp)
ffffffffc0209a90:	7b42                	ld	s6,48(sp)
ffffffffc0209a92:	7ba2                	ld	s7,40(sp)
ffffffffc0209a94:	7c02                	ld	s8,32(sp)
ffffffffc0209a96:	6ce2                	ld	s9,24(sp)
ffffffffc0209a98:	854a                	mv	a0,s2
ffffffffc0209a9a:	6946                	ld	s2,80(sp)
ffffffffc0209a9c:	6165                	addi	sp,sp,112
ffffffffc0209a9e:	8082                	ret
ffffffffc0209aa0:	002c                	addi	a1,sp,8
ffffffffc0209aa2:	e55ff0ef          	jal	ra,ffffffffc02098f6 <sfs_block_alloc>
ffffffffc0209aa6:	892a                	mv	s2,a0
ffffffffc0209aa8:	00c10c93          	addi	s9,sp,12
ffffffffc0209aac:	fd61                	bnez	a0,ffffffffc0209a84 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209aae:	85e6                	mv	a1,s9
ffffffffc0209ab0:	8526                	mv	a0,s1
ffffffffc0209ab2:	e45ff0ef          	jal	ra,ffffffffc02098f6 <sfs_block_alloc>
ffffffffc0209ab6:	892a                	mv	s2,a0
ffffffffc0209ab8:	e925                	bnez	a0,ffffffffc0209b28 <sfs_bmap_load_nolock+0x18a>
ffffffffc0209aba:	46a2                	lw	a3,8(sp)
ffffffffc0209abc:	85e6                	mv	a1,s9
ffffffffc0209abe:	8762                	mv	a4,s8
ffffffffc0209ac0:	4611                	li	a2,4
ffffffffc0209ac2:	8526                	mv	a0,s1
ffffffffc0209ac4:	088010ef          	jal	ra,ffffffffc020ab4c <sfs_wbuf>
ffffffffc0209ac8:	45b2                	lw	a1,12(sp)
ffffffffc0209aca:	892a                	mv	s2,a0
ffffffffc0209acc:	e939                	bnez	a0,ffffffffc0209b22 <sfs_bmap_load_nolock+0x184>
ffffffffc0209ace:	03cb2683          	lw	a3,60(s6)
ffffffffc0209ad2:	4722                	lw	a4,8(sp)
ffffffffc0209ad4:	c22e                	sw	a1,4(sp)
ffffffffc0209ad6:	f6d706e3          	beq	a4,a3,ffffffffc0209a42 <sfs_bmap_load_nolock+0xa4>
ffffffffc0209ada:	eef1                	bnez	a3,ffffffffc0209bb6 <sfs_bmap_load_nolock+0x218>
ffffffffc0209adc:	02eb2e23          	sw	a4,60(s6)
ffffffffc0209ae0:	4705                	li	a4,1
ffffffffc0209ae2:	00eab823          	sd	a4,16(s5)
ffffffffc0209ae6:	f00589e3          	beqz	a1,ffffffffc02099f8 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209aea:	bfa9                	j	ffffffffc0209a44 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209aec:	00c10c93          	addi	s9,sp,12
ffffffffc0209af0:	8762                	mv	a4,s8
ffffffffc0209af2:	86d2                	mv	a3,s4
ffffffffc0209af4:	4611                	li	a2,4
ffffffffc0209af6:	85e6                	mv	a1,s9
ffffffffc0209af8:	7d5000ef          	jal	ra,ffffffffc020aacc <sfs_rbuf>
ffffffffc0209afc:	892a                	mv	s2,a0
ffffffffc0209afe:	f159                	bnez	a0,ffffffffc0209a84 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209b00:	45b2                	lw	a1,12(sp)
ffffffffc0209b02:	e995                	bnez	a1,ffffffffc0209b36 <sfs_bmap_load_nolock+0x198>
ffffffffc0209b04:	fa8b85e3          	beq	s7,s0,ffffffffc0209aae <sfs_bmap_load_nolock+0x110>
ffffffffc0209b08:	03cb2703          	lw	a4,60(s6)
ffffffffc0209b0c:	47a2                	lw	a5,8(sp)
ffffffffc0209b0e:	c202                	sw	zero,4(sp)
ffffffffc0209b10:	eee784e3          	beq	a5,a4,ffffffffc02099f8 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209b14:	e34d                	bnez	a4,ffffffffc0209bb6 <sfs_bmap_load_nolock+0x218>
ffffffffc0209b16:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209b1a:	4785                	li	a5,1
ffffffffc0209b1c:	00fab823          	sd	a5,16(s5)
ffffffffc0209b20:	bde1                	j	ffffffffc02099f8 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209b22:	8526                	mv	a0,s1
ffffffffc0209b24:	bc1ff0ef          	jal	ra,ffffffffc02096e4 <sfs_block_free>
ffffffffc0209b28:	45a2                	lw	a1,8(sp)
ffffffffc0209b2a:	f4ba0de3          	beq	s4,a1,ffffffffc0209a84 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209b2e:	8526                	mv	a0,s1
ffffffffc0209b30:	bb5ff0ef          	jal	ra,ffffffffc02096e4 <sfs_block_free>
ffffffffc0209b34:	bf81                	j	ffffffffc0209a84 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209b36:	03cb2683          	lw	a3,60(s6)
ffffffffc0209b3a:	4722                	lw	a4,8(sp)
ffffffffc0209b3c:	c22e                	sw	a1,4(sp)
ffffffffc0209b3e:	f8e69ee3          	bne	a3,a4,ffffffffc0209ada <sfs_bmap_load_nolock+0x13c>
ffffffffc0209b42:	b709                	j	ffffffffc0209a44 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209b44:	00005697          	auipc	a3,0x5
ffffffffc0209b48:	0f468693          	addi	a3,a3,244 # ffffffffc020ec38 <dev_node_ops+0x6a8>
ffffffffc0209b4c:	00002617          	auipc	a2,0x2
ffffffffc0209b50:	bec60613          	addi	a2,a2,-1044 # ffffffffc020b738 <commands+0x210>
ffffffffc0209b54:	16400593          	li	a1,356
ffffffffc0209b58:	00005517          	auipc	a0,0x5
ffffffffc0209b5c:	ff850513          	addi	a0,a0,-8 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209b60:	93ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b64:	872e                	mv	a4,a1
ffffffffc0209b66:	00005617          	auipc	a2,0x5
ffffffffc0209b6a:	01a60613          	addi	a2,a2,26 # ffffffffc020eb80 <dev_node_ops+0x5f0>
ffffffffc0209b6e:	05300593          	li	a1,83
ffffffffc0209b72:	00005517          	auipc	a0,0x5
ffffffffc0209b76:	fde50513          	addi	a0,a0,-34 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209b7a:	925f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b7e:	00005617          	auipc	a2,0x5
ffffffffc0209b82:	0ea60613          	addi	a2,a2,234 # ffffffffc020ec68 <dev_node_ops+0x6d8>
ffffffffc0209b86:	11e00593          	li	a1,286
ffffffffc0209b8a:	00005517          	auipc	a0,0x5
ffffffffc0209b8e:	fc650513          	addi	a0,a0,-58 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209b92:	90df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b96:	00005697          	auipc	a3,0x5
ffffffffc0209b9a:	02268693          	addi	a3,a3,34 # ffffffffc020ebb8 <dev_node_ops+0x628>
ffffffffc0209b9e:	00002617          	auipc	a2,0x2
ffffffffc0209ba2:	b9a60613          	addi	a2,a2,-1126 # ffffffffc020b738 <commands+0x210>
ffffffffc0209ba6:	16b00593          	li	a1,363
ffffffffc0209baa:	00005517          	auipc	a0,0x5
ffffffffc0209bae:	fa650513          	addi	a0,a0,-90 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209bb2:	8edf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bb6:	00005697          	auipc	a3,0x5
ffffffffc0209bba:	09a68693          	addi	a3,a3,154 # ffffffffc020ec50 <dev_node_ops+0x6c0>
ffffffffc0209bbe:	00002617          	auipc	a2,0x2
ffffffffc0209bc2:	b7a60613          	addi	a2,a2,-1158 # ffffffffc020b738 <commands+0x210>
ffffffffc0209bc6:	11800593          	li	a1,280
ffffffffc0209bca:	00005517          	auipc	a0,0x5
ffffffffc0209bce:	f8650513          	addi	a0,a0,-122 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209bd2:	8cdf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bd6:	00005697          	auipc	a3,0x5
ffffffffc0209bda:	0c268693          	addi	a3,a3,194 # ffffffffc020ec98 <dev_node_ops+0x708>
ffffffffc0209bde:	00002617          	auipc	a2,0x2
ffffffffc0209be2:	b5a60613          	addi	a2,a2,-1190 # ffffffffc020b738 <commands+0x210>
ffffffffc0209be6:	12100593          	li	a1,289
ffffffffc0209bea:	00005517          	auipc	a0,0x5
ffffffffc0209bee:	f6650513          	addi	a0,a0,-154 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209bf2:	8adf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209bf6 <sfs_io_nolock>:
ffffffffc0209bf6:	7175                	addi	sp,sp,-144
ffffffffc0209bf8:	f0d2                	sd	s4,96(sp)
ffffffffc0209bfa:	8a2e                	mv	s4,a1
ffffffffc0209bfc:	618c                	ld	a1,0(a1)
ffffffffc0209bfe:	e506                	sd	ra,136(sp)
ffffffffc0209c00:	e122                	sd	s0,128(sp)
ffffffffc0209c02:	0045d883          	lhu	a7,4(a1)
ffffffffc0209c06:	fca6                	sd	s1,120(sp)
ffffffffc0209c08:	f8ca                	sd	s2,112(sp)
ffffffffc0209c0a:	f4ce                	sd	s3,104(sp)
ffffffffc0209c0c:	ecd6                	sd	s5,88(sp)
ffffffffc0209c0e:	e8da                	sd	s6,80(sp)
ffffffffc0209c10:	e4de                	sd	s7,72(sp)
ffffffffc0209c12:	e0e2                	sd	s8,64(sp)
ffffffffc0209c14:	fc66                	sd	s9,56(sp)
ffffffffc0209c16:	f86a                	sd	s10,48(sp)
ffffffffc0209c18:	f46e                	sd	s11,40(sp)
ffffffffc0209c1a:	4809                	li	a6,2
ffffffffc0209c1c:	19088363          	beq	a7,a6,ffffffffc0209da2 <sfs_io_nolock+0x1ac>
ffffffffc0209c20:	00073b03          	ld	s6,0(a4) # 4000 <_binary_bin_swap_img_size-0x3d00>
ffffffffc0209c24:	8bba                	mv	s7,a4
ffffffffc0209c26:	000bb023          	sd	zero,0(s7) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0209c2a:	08000737          	lui	a4,0x8000
ffffffffc0209c2e:	89b6                	mv	s3,a3
ffffffffc0209c30:	8cb6                	mv	s9,a3
ffffffffc0209c32:	9b36                	add	s6,s6,a3
ffffffffc0209c34:	16e6f563          	bgeu	a3,a4,ffffffffc0209d9e <sfs_io_nolock+0x1a8>
ffffffffc0209c38:	16db4363          	blt	s6,a3,ffffffffc0209d9e <sfs_io_nolock+0x1a8>
ffffffffc0209c3c:	892a                	mv	s2,a0
ffffffffc0209c3e:	4501                	li	a0,0
ffffffffc0209c40:	09668563          	beq	a3,s6,ffffffffc0209cca <sfs_io_nolock+0xd4>
ffffffffc0209c44:	8432                	mv	s0,a2
ffffffffc0209c46:	01677463          	bgeu	a4,s6,ffffffffc0209c4e <sfs_io_nolock+0x58>
ffffffffc0209c4a:	08000b37          	lui	s6,0x8000
ffffffffc0209c4e:	cfc9                	beqz	a5,ffffffffc0209ce8 <sfs_io_nolock+0xf2>
ffffffffc0209c50:	00001c17          	auipc	s8,0x1
ffffffffc0209c54:	e1cc0c13          	addi	s8,s8,-484 # ffffffffc020aa6c <sfs_wblock>
ffffffffc0209c58:	00001d17          	auipc	s10,0x1
ffffffffc0209c5c:	ef4d0d13          	addi	s10,s10,-268 # ffffffffc020ab4c <sfs_wbuf>
ffffffffc0209c60:	6805                	lui	a6,0x1
ffffffffc0209c62:	40c9dd93          	srai	s11,s3,0xc
ffffffffc0209c66:	40cb5a93          	srai	s5,s6,0xc
ffffffffc0209c6a:	fff80493          	addi	s1,a6,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0209c6e:	41ba87bb          	subw	a5,s5,s11
ffffffffc0209c72:	0099f4b3          	and	s1,s3,s1
ffffffffc0209c76:	8abe                	mv	s5,a5
ffffffffc0209c78:	2d81                	sext.w	s11,s11
ffffffffc0209c7a:	e4d9                	bnez	s1,ffffffffc0209d08 <sfs_io_nolock+0x112>
ffffffffc0209c7c:	01b78cbb          	addw	s9,a5,s11
ffffffffc0209c80:	6a85                	lui	s5,0x1
ffffffffc0209c82:	ef89                	bnez	a5,ffffffffc0209c9c <sfs_io_nolock+0xa6>
ffffffffc0209c84:	a0f9                	j	ffffffffc0209d52 <sfs_io_nolock+0x15c>
ffffffffc0209c86:	4672                	lw	a2,28(sp)
ffffffffc0209c88:	4685                	li	a3,1
ffffffffc0209c8a:	85a2                	mv	a1,s0
ffffffffc0209c8c:	854a                	mv	a0,s2
ffffffffc0209c8e:	9c02                	jalr	s8
ffffffffc0209c90:	ed09                	bnez	a0,ffffffffc0209caa <sfs_io_nolock+0xb4>
ffffffffc0209c92:	2d85                	addiw	s11,s11,1
ffffffffc0209c94:	9456                	add	s0,s0,s5
ffffffffc0209c96:	94d6                	add	s1,s1,s5
ffffffffc0209c98:	0b9d8e63          	beq	s11,s9,ffffffffc0209d54 <sfs_io_nolock+0x15e>
ffffffffc0209c9c:	0874                	addi	a3,sp,28
ffffffffc0209c9e:	866e                	mv	a2,s11
ffffffffc0209ca0:	85d2                	mv	a1,s4
ffffffffc0209ca2:	854a                	mv	a0,s2
ffffffffc0209ca4:	cfbff0ef          	jal	ra,ffffffffc020999e <sfs_bmap_load_nolock>
ffffffffc0209ca8:	dd79                	beqz	a0,ffffffffc0209c86 <sfs_io_nolock+0x90>
ffffffffc0209caa:	00998cb3          	add	s9,s3,s1
ffffffffc0209cae:	000a3783          	ld	a5,0(s4)
ffffffffc0209cb2:	009bb023          	sd	s1,0(s7)
ffffffffc0209cb6:	0007e703          	lwu	a4,0(a5)
ffffffffc0209cba:	01977863          	bgeu	a4,s9,ffffffffc0209cca <sfs_io_nolock+0xd4>
ffffffffc0209cbe:	009984bb          	addw	s1,s3,s1
ffffffffc0209cc2:	c384                	sw	s1,0(a5)
ffffffffc0209cc4:	4785                	li	a5,1
ffffffffc0209cc6:	00fa3823          	sd	a5,16(s4)
ffffffffc0209cca:	60aa                	ld	ra,136(sp)
ffffffffc0209ccc:	640a                	ld	s0,128(sp)
ffffffffc0209cce:	74e6                	ld	s1,120(sp)
ffffffffc0209cd0:	7946                	ld	s2,112(sp)
ffffffffc0209cd2:	79a6                	ld	s3,104(sp)
ffffffffc0209cd4:	7a06                	ld	s4,96(sp)
ffffffffc0209cd6:	6ae6                	ld	s5,88(sp)
ffffffffc0209cd8:	6b46                	ld	s6,80(sp)
ffffffffc0209cda:	6ba6                	ld	s7,72(sp)
ffffffffc0209cdc:	6c06                	ld	s8,64(sp)
ffffffffc0209cde:	7ce2                	ld	s9,56(sp)
ffffffffc0209ce0:	7d42                	ld	s10,48(sp)
ffffffffc0209ce2:	7da2                	ld	s11,40(sp)
ffffffffc0209ce4:	6149                	addi	sp,sp,144
ffffffffc0209ce6:	8082                	ret
ffffffffc0209ce8:	0005e783          	lwu	a5,0(a1)
ffffffffc0209cec:	4501                	li	a0,0
ffffffffc0209cee:	fcf9dee3          	bge	s3,a5,ffffffffc0209cca <sfs_io_nolock+0xd4>
ffffffffc0209cf2:	0567c663          	blt	a5,s6,ffffffffc0209d3e <sfs_io_nolock+0x148>
ffffffffc0209cf6:	00001c17          	auipc	s8,0x1
ffffffffc0209cfa:	d16c0c13          	addi	s8,s8,-746 # ffffffffc020aa0c <sfs_rblock>
ffffffffc0209cfe:	00001d17          	auipc	s10,0x1
ffffffffc0209d02:	dced0d13          	addi	s10,s10,-562 # ffffffffc020aacc <sfs_rbuf>
ffffffffc0209d06:	bfa9                	j	ffffffffc0209c60 <sfs_io_nolock+0x6a>
ffffffffc0209d08:	0874                	addi	a3,sp,28
ffffffffc0209d0a:	866e                	mv	a2,s11
ffffffffc0209d0c:	85d2                	mv	a1,s4
ffffffffc0209d0e:	854a                	mv	a0,s2
ffffffffc0209d10:	e426                	sd	s1,8(sp)
ffffffffc0209d12:	e03e                	sd	a5,0(sp)
ffffffffc0209d14:	c8bff0ef          	jal	ra,ffffffffc020999e <sfs_bmap_load_nolock>
ffffffffc0209d18:	4481                	li	s1,0
ffffffffc0209d1a:	f951                	bnez	a0,ffffffffc0209cae <sfs_io_nolock+0xb8>
ffffffffc0209d1c:	6782                	ld	a5,0(sp)
ffffffffc0209d1e:	46f2                	lw	a3,28(sp)
ffffffffc0209d20:	6722                	ld	a4,8(sp)
ffffffffc0209d22:	c3b9                	beqz	a5,ffffffffc0209d68 <sfs_io_nolock+0x172>
ffffffffc0209d24:	6805                	lui	a6,0x1
ffffffffc0209d26:	40e804b3          	sub	s1,a6,a4
ffffffffc0209d2a:	8626                	mv	a2,s1
ffffffffc0209d2c:	85a2                	mv	a1,s0
ffffffffc0209d2e:	854a                	mv	a0,s2
ffffffffc0209d30:	9d02                	jalr	s10
ffffffffc0209d32:	e131                	bnez	a0,ffffffffc0209d76 <sfs_io_nolock+0x180>
ffffffffc0209d34:	9426                	add	s0,s0,s1
ffffffffc0209d36:	2d85                	addiw	s11,s11,1
ffffffffc0209d38:	fffa879b          	addiw	a5,s5,-1
ffffffffc0209d3c:	b781                	j	ffffffffc0209c7c <sfs_io_nolock+0x86>
ffffffffc0209d3e:	8b3e                	mv	s6,a5
ffffffffc0209d40:	00001c17          	auipc	s8,0x1
ffffffffc0209d44:	cccc0c13          	addi	s8,s8,-820 # ffffffffc020aa0c <sfs_rblock>
ffffffffc0209d48:	00001d17          	auipc	s10,0x1
ffffffffc0209d4c:	d84d0d13          	addi	s10,s10,-636 # ffffffffc020aacc <sfs_rbuf>
ffffffffc0209d50:	bf01                	j	ffffffffc0209c60 <sfs_io_nolock+0x6a>
ffffffffc0209d52:	8cee                	mv	s9,s11
ffffffffc0209d54:	413b0b33          	sub	s6,s6,s3
ffffffffc0209d58:	409b0ab3          	sub	s5,s6,s1
ffffffffc0209d5c:	009b1f63          	bne	s6,s1,ffffffffc0209d7a <sfs_io_nolock+0x184>
ffffffffc0209d60:	00998cb3          	add	s9,s3,s1
ffffffffc0209d64:	4501                	li	a0,0
ffffffffc0209d66:	b7a1                	j	ffffffffc0209cae <sfs_io_nolock+0xb8>
ffffffffc0209d68:	413b04b3          	sub	s1,s6,s3
ffffffffc0209d6c:	8626                	mv	a2,s1
ffffffffc0209d6e:	85a2                	mv	a1,s0
ffffffffc0209d70:	854a                	mv	a0,s2
ffffffffc0209d72:	9d02                	jalr	s10
ffffffffc0209d74:	d91d                	beqz	a0,ffffffffc0209caa <sfs_io_nolock+0xb4>
ffffffffc0209d76:	4481                	li	s1,0
ffffffffc0209d78:	bf1d                	j	ffffffffc0209cae <sfs_io_nolock+0xb8>
ffffffffc0209d7a:	0874                	addi	a3,sp,28
ffffffffc0209d7c:	8666                	mv	a2,s9
ffffffffc0209d7e:	85d2                	mv	a1,s4
ffffffffc0209d80:	854a                	mv	a0,s2
ffffffffc0209d82:	c1dff0ef          	jal	ra,ffffffffc020999e <sfs_bmap_load_nolock>
ffffffffc0209d86:	f115                	bnez	a0,ffffffffc0209caa <sfs_io_nolock+0xb4>
ffffffffc0209d88:	46f2                	lw	a3,28(sp)
ffffffffc0209d8a:	4701                	li	a4,0
ffffffffc0209d8c:	8656                	mv	a2,s5
ffffffffc0209d8e:	85a2                	mv	a1,s0
ffffffffc0209d90:	854a                	mv	a0,s2
ffffffffc0209d92:	9d02                	jalr	s10
ffffffffc0209d94:	f919                	bnez	a0,ffffffffc0209caa <sfs_io_nolock+0xb4>
ffffffffc0209d96:	01698cb3          	add	s9,s3,s6
ffffffffc0209d9a:	84da                	mv	s1,s6
ffffffffc0209d9c:	bf09                	j	ffffffffc0209cae <sfs_io_nolock+0xb8>
ffffffffc0209d9e:	5575                	li	a0,-3
ffffffffc0209da0:	b72d                	j	ffffffffc0209cca <sfs_io_nolock+0xd4>
ffffffffc0209da2:	00005697          	auipc	a3,0x5
ffffffffc0209da6:	f1e68693          	addi	a3,a3,-226 # ffffffffc020ecc0 <dev_node_ops+0x730>
ffffffffc0209daa:	00002617          	auipc	a2,0x2
ffffffffc0209dae:	98e60613          	addi	a2,a2,-1650 # ffffffffc020b738 <commands+0x210>
ffffffffc0209db2:	22b00593          	li	a1,555
ffffffffc0209db6:	00005517          	auipc	a0,0x5
ffffffffc0209dba:	d9a50513          	addi	a0,a0,-614 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209dbe:	ee0f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209dc2 <sfs_read>:
ffffffffc0209dc2:	7139                	addi	sp,sp,-64
ffffffffc0209dc4:	f04a                	sd	s2,32(sp)
ffffffffc0209dc6:	06853903          	ld	s2,104(a0)
ffffffffc0209dca:	fc06                	sd	ra,56(sp)
ffffffffc0209dcc:	f822                	sd	s0,48(sp)
ffffffffc0209dce:	f426                	sd	s1,40(sp)
ffffffffc0209dd0:	ec4e                	sd	s3,24(sp)
ffffffffc0209dd2:	04090f63          	beqz	s2,ffffffffc0209e30 <sfs_read+0x6e>
ffffffffc0209dd6:	0b092783          	lw	a5,176(s2)
ffffffffc0209dda:	ebb9                	bnez	a5,ffffffffc0209e30 <sfs_read+0x6e>
ffffffffc0209ddc:	4d38                	lw	a4,88(a0)
ffffffffc0209dde:	6785                	lui	a5,0x1
ffffffffc0209de0:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209de4:	842a                	mv	s0,a0
ffffffffc0209de6:	06f71563          	bne	a4,a5,ffffffffc0209e50 <sfs_read+0x8e>
ffffffffc0209dea:	02050993          	addi	s3,a0,32
ffffffffc0209dee:	854e                	mv	a0,s3
ffffffffc0209df0:	84ae                	mv	s1,a1
ffffffffc0209df2:	ed0fa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0209df6:	0184b803          	ld	a6,24(s1)
ffffffffc0209dfa:	6494                	ld	a3,8(s1)
ffffffffc0209dfc:	6090                	ld	a2,0(s1)
ffffffffc0209dfe:	85a2                	mv	a1,s0
ffffffffc0209e00:	4781                	li	a5,0
ffffffffc0209e02:	0038                	addi	a4,sp,8
ffffffffc0209e04:	854a                	mv	a0,s2
ffffffffc0209e06:	e442                	sd	a6,8(sp)
ffffffffc0209e08:	defff0ef          	jal	ra,ffffffffc0209bf6 <sfs_io_nolock>
ffffffffc0209e0c:	65a2                	ld	a1,8(sp)
ffffffffc0209e0e:	842a                	mv	s0,a0
ffffffffc0209e10:	ed81                	bnez	a1,ffffffffc0209e28 <sfs_read+0x66>
ffffffffc0209e12:	854e                	mv	a0,s3
ffffffffc0209e14:	eaafa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0209e18:	70e2                	ld	ra,56(sp)
ffffffffc0209e1a:	8522                	mv	a0,s0
ffffffffc0209e1c:	7442                	ld	s0,48(sp)
ffffffffc0209e1e:	74a2                	ld	s1,40(sp)
ffffffffc0209e20:	7902                	ld	s2,32(sp)
ffffffffc0209e22:	69e2                	ld	s3,24(sp)
ffffffffc0209e24:	6121                	addi	sp,sp,64
ffffffffc0209e26:	8082                	ret
ffffffffc0209e28:	8526                	mv	a0,s1
ffffffffc0209e2a:	d8cfb0ef          	jal	ra,ffffffffc02053b6 <iobuf_skip>
ffffffffc0209e2e:	b7d5                	j	ffffffffc0209e12 <sfs_read+0x50>
ffffffffc0209e30:	00005697          	auipc	a3,0x5
ffffffffc0209e34:	b4068693          	addi	a3,a3,-1216 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc0209e38:	00002617          	auipc	a2,0x2
ffffffffc0209e3c:	90060613          	addi	a2,a2,-1792 # ffffffffc020b738 <commands+0x210>
ffffffffc0209e40:	29d00593          	li	a1,669
ffffffffc0209e44:	00005517          	auipc	a0,0x5
ffffffffc0209e48:	d0c50513          	addi	a0,a0,-756 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209e4c:	e52f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e50:	871ff0ef          	jal	ra,ffffffffc02096c0 <sfs_io.part.0>

ffffffffc0209e54 <sfs_write>:
ffffffffc0209e54:	7139                	addi	sp,sp,-64
ffffffffc0209e56:	f04a                	sd	s2,32(sp)
ffffffffc0209e58:	06853903          	ld	s2,104(a0)
ffffffffc0209e5c:	fc06                	sd	ra,56(sp)
ffffffffc0209e5e:	f822                	sd	s0,48(sp)
ffffffffc0209e60:	f426                	sd	s1,40(sp)
ffffffffc0209e62:	ec4e                	sd	s3,24(sp)
ffffffffc0209e64:	04090f63          	beqz	s2,ffffffffc0209ec2 <sfs_write+0x6e>
ffffffffc0209e68:	0b092783          	lw	a5,176(s2)
ffffffffc0209e6c:	ebb9                	bnez	a5,ffffffffc0209ec2 <sfs_write+0x6e>
ffffffffc0209e6e:	4d38                	lw	a4,88(a0)
ffffffffc0209e70:	6785                	lui	a5,0x1
ffffffffc0209e72:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209e76:	842a                	mv	s0,a0
ffffffffc0209e78:	06f71563          	bne	a4,a5,ffffffffc0209ee2 <sfs_write+0x8e>
ffffffffc0209e7c:	02050993          	addi	s3,a0,32
ffffffffc0209e80:	854e                	mv	a0,s3
ffffffffc0209e82:	84ae                	mv	s1,a1
ffffffffc0209e84:	e3efa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc0209e88:	0184b803          	ld	a6,24(s1)
ffffffffc0209e8c:	6494                	ld	a3,8(s1)
ffffffffc0209e8e:	6090                	ld	a2,0(s1)
ffffffffc0209e90:	85a2                	mv	a1,s0
ffffffffc0209e92:	4785                	li	a5,1
ffffffffc0209e94:	0038                	addi	a4,sp,8
ffffffffc0209e96:	854a                	mv	a0,s2
ffffffffc0209e98:	e442                	sd	a6,8(sp)
ffffffffc0209e9a:	d5dff0ef          	jal	ra,ffffffffc0209bf6 <sfs_io_nolock>
ffffffffc0209e9e:	65a2                	ld	a1,8(sp)
ffffffffc0209ea0:	842a                	mv	s0,a0
ffffffffc0209ea2:	ed81                	bnez	a1,ffffffffc0209eba <sfs_write+0x66>
ffffffffc0209ea4:	854e                	mv	a0,s3
ffffffffc0209ea6:	e18fa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc0209eaa:	70e2                	ld	ra,56(sp)
ffffffffc0209eac:	8522                	mv	a0,s0
ffffffffc0209eae:	7442                	ld	s0,48(sp)
ffffffffc0209eb0:	74a2                	ld	s1,40(sp)
ffffffffc0209eb2:	7902                	ld	s2,32(sp)
ffffffffc0209eb4:	69e2                	ld	s3,24(sp)
ffffffffc0209eb6:	6121                	addi	sp,sp,64
ffffffffc0209eb8:	8082                	ret
ffffffffc0209eba:	8526                	mv	a0,s1
ffffffffc0209ebc:	cfafb0ef          	jal	ra,ffffffffc02053b6 <iobuf_skip>
ffffffffc0209ec0:	b7d5                	j	ffffffffc0209ea4 <sfs_write+0x50>
ffffffffc0209ec2:	00005697          	auipc	a3,0x5
ffffffffc0209ec6:	aae68693          	addi	a3,a3,-1362 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc0209eca:	00002617          	auipc	a2,0x2
ffffffffc0209ece:	86e60613          	addi	a2,a2,-1938 # ffffffffc020b738 <commands+0x210>
ffffffffc0209ed2:	29d00593          	li	a1,669
ffffffffc0209ed6:	00005517          	auipc	a0,0x5
ffffffffc0209eda:	c7a50513          	addi	a0,a0,-902 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209ede:	dc0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209ee2:	fdeff0ef          	jal	ra,ffffffffc02096c0 <sfs_io.part.0>

ffffffffc0209ee6 <sfs_dirent_read_nolock>:
ffffffffc0209ee6:	6198                	ld	a4,0(a1)
ffffffffc0209ee8:	7179                	addi	sp,sp,-48
ffffffffc0209eea:	f406                	sd	ra,40(sp)
ffffffffc0209eec:	00475883          	lhu	a7,4(a4) # 8000004 <_binary_bin_sfs_img_size+0x7f8ad04>
ffffffffc0209ef0:	f022                	sd	s0,32(sp)
ffffffffc0209ef2:	ec26                	sd	s1,24(sp)
ffffffffc0209ef4:	4809                	li	a6,2
ffffffffc0209ef6:	05089b63          	bne	a7,a6,ffffffffc0209f4c <sfs_dirent_read_nolock+0x66>
ffffffffc0209efa:	4718                	lw	a4,8(a4)
ffffffffc0209efc:	87b2                	mv	a5,a2
ffffffffc0209efe:	2601                	sext.w	a2,a2
ffffffffc0209f00:	04e7f663          	bgeu	a5,a4,ffffffffc0209f4c <sfs_dirent_read_nolock+0x66>
ffffffffc0209f04:	84b6                	mv	s1,a3
ffffffffc0209f06:	0074                	addi	a3,sp,12
ffffffffc0209f08:	842a                	mv	s0,a0
ffffffffc0209f0a:	a95ff0ef          	jal	ra,ffffffffc020999e <sfs_bmap_load_nolock>
ffffffffc0209f0e:	c511                	beqz	a0,ffffffffc0209f1a <sfs_dirent_read_nolock+0x34>
ffffffffc0209f10:	70a2                	ld	ra,40(sp)
ffffffffc0209f12:	7402                	ld	s0,32(sp)
ffffffffc0209f14:	64e2                	ld	s1,24(sp)
ffffffffc0209f16:	6145                	addi	sp,sp,48
ffffffffc0209f18:	8082                	ret
ffffffffc0209f1a:	45b2                	lw	a1,12(sp)
ffffffffc0209f1c:	4054                	lw	a3,4(s0)
ffffffffc0209f1e:	c5b9                	beqz	a1,ffffffffc0209f6c <sfs_dirent_read_nolock+0x86>
ffffffffc0209f20:	04d5f663          	bgeu	a1,a3,ffffffffc0209f6c <sfs_dirent_read_nolock+0x86>
ffffffffc0209f24:	7c08                	ld	a0,56(s0)
ffffffffc0209f26:	eb1fe0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc0209f2a:	ed31                	bnez	a0,ffffffffc0209f86 <sfs_dirent_read_nolock+0xa0>
ffffffffc0209f2c:	46b2                	lw	a3,12(sp)
ffffffffc0209f2e:	4701                	li	a4,0
ffffffffc0209f30:	10400613          	li	a2,260
ffffffffc0209f34:	85a6                	mv	a1,s1
ffffffffc0209f36:	8522                	mv	a0,s0
ffffffffc0209f38:	395000ef          	jal	ra,ffffffffc020aacc <sfs_rbuf>
ffffffffc0209f3c:	f971                	bnez	a0,ffffffffc0209f10 <sfs_dirent_read_nolock+0x2a>
ffffffffc0209f3e:	100481a3          	sb	zero,259(s1)
ffffffffc0209f42:	70a2                	ld	ra,40(sp)
ffffffffc0209f44:	7402                	ld	s0,32(sp)
ffffffffc0209f46:	64e2                	ld	s1,24(sp)
ffffffffc0209f48:	6145                	addi	sp,sp,48
ffffffffc0209f4a:	8082                	ret
ffffffffc0209f4c:	00005697          	auipc	a3,0x5
ffffffffc0209f50:	d9468693          	addi	a3,a3,-620 # ffffffffc020ece0 <dev_node_ops+0x750>
ffffffffc0209f54:	00001617          	auipc	a2,0x1
ffffffffc0209f58:	7e460613          	addi	a2,a2,2020 # ffffffffc020b738 <commands+0x210>
ffffffffc0209f5c:	18e00593          	li	a1,398
ffffffffc0209f60:	00005517          	auipc	a0,0x5
ffffffffc0209f64:	bf050513          	addi	a0,a0,-1040 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209f68:	d36f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f6c:	872e                	mv	a4,a1
ffffffffc0209f6e:	00005617          	auipc	a2,0x5
ffffffffc0209f72:	c1260613          	addi	a2,a2,-1006 # ffffffffc020eb80 <dev_node_ops+0x5f0>
ffffffffc0209f76:	05300593          	li	a1,83
ffffffffc0209f7a:	00005517          	auipc	a0,0x5
ffffffffc0209f7e:	bd650513          	addi	a0,a0,-1066 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209f82:	d1cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f86:	00005697          	auipc	a3,0x5
ffffffffc0209f8a:	c3268693          	addi	a3,a3,-974 # ffffffffc020ebb8 <dev_node_ops+0x628>
ffffffffc0209f8e:	00001617          	auipc	a2,0x1
ffffffffc0209f92:	7aa60613          	addi	a2,a2,1962 # ffffffffc020b738 <commands+0x210>
ffffffffc0209f96:	19500593          	li	a1,405
ffffffffc0209f9a:	00005517          	auipc	a0,0x5
ffffffffc0209f9e:	bb650513          	addi	a0,a0,-1098 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc0209fa2:	cfcf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209fa6 <sfs_getdirentry>:
ffffffffc0209fa6:	715d                	addi	sp,sp,-80
ffffffffc0209fa8:	ec56                	sd	s5,24(sp)
ffffffffc0209faa:	8aaa                	mv	s5,a0
ffffffffc0209fac:	10400513          	li	a0,260
ffffffffc0209fb0:	e85a                	sd	s6,16(sp)
ffffffffc0209fb2:	e486                	sd	ra,72(sp)
ffffffffc0209fb4:	e0a2                	sd	s0,64(sp)
ffffffffc0209fb6:	fc26                	sd	s1,56(sp)
ffffffffc0209fb8:	f84a                	sd	s2,48(sp)
ffffffffc0209fba:	f44e                	sd	s3,40(sp)
ffffffffc0209fbc:	f052                	sd	s4,32(sp)
ffffffffc0209fbe:	e45e                	sd	s7,8(sp)
ffffffffc0209fc0:	e062                	sd	s8,0(sp)
ffffffffc0209fc2:	8b2e                	mv	s6,a1
ffffffffc0209fc4:	fcbf70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209fc8:	cd61                	beqz	a0,ffffffffc020a0a0 <sfs_getdirentry+0xfa>
ffffffffc0209fca:	068abb83          	ld	s7,104(s5) # 1068 <_binary_bin_swap_img_size-0x6c98>
ffffffffc0209fce:	0c0b8b63          	beqz	s7,ffffffffc020a0a4 <sfs_getdirentry+0xfe>
ffffffffc0209fd2:	0b0ba783          	lw	a5,176(s7)
ffffffffc0209fd6:	e7f9                	bnez	a5,ffffffffc020a0a4 <sfs_getdirentry+0xfe>
ffffffffc0209fd8:	058aa703          	lw	a4,88(s5)
ffffffffc0209fdc:	6785                	lui	a5,0x1
ffffffffc0209fde:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209fe2:	0ef71163          	bne	a4,a5,ffffffffc020a0c4 <sfs_getdirentry+0x11e>
ffffffffc0209fe6:	008b3983          	ld	s3,8(s6) # 8000008 <_binary_bin_sfs_img_size+0x7f8ad08>
ffffffffc0209fea:	892a                	mv	s2,a0
ffffffffc0209fec:	0a09c163          	bltz	s3,ffffffffc020a08e <sfs_getdirentry+0xe8>
ffffffffc0209ff0:	0ff9f793          	zext.b	a5,s3
ffffffffc0209ff4:	efc9                	bnez	a5,ffffffffc020a08e <sfs_getdirentry+0xe8>
ffffffffc0209ff6:	000ab783          	ld	a5,0(s5)
ffffffffc0209ffa:	0089d993          	srli	s3,s3,0x8
ffffffffc0209ffe:	2981                	sext.w	s3,s3
ffffffffc020a000:	479c                	lw	a5,8(a5)
ffffffffc020a002:	0937eb63          	bltu	a5,s3,ffffffffc020a098 <sfs_getdirentry+0xf2>
ffffffffc020a006:	020a8c13          	addi	s8,s5,32
ffffffffc020a00a:	8562                	mv	a0,s8
ffffffffc020a00c:	cb6fa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a010:	000ab783          	ld	a5,0(s5)
ffffffffc020a014:	0087aa03          	lw	s4,8(a5)
ffffffffc020a018:	07405663          	blez	s4,ffffffffc020a084 <sfs_getdirentry+0xde>
ffffffffc020a01c:	4481                	li	s1,0
ffffffffc020a01e:	a811                	j	ffffffffc020a032 <sfs_getdirentry+0x8c>
ffffffffc020a020:	00092783          	lw	a5,0(s2)
ffffffffc020a024:	c781                	beqz	a5,ffffffffc020a02c <sfs_getdirentry+0x86>
ffffffffc020a026:	02098263          	beqz	s3,ffffffffc020a04a <sfs_getdirentry+0xa4>
ffffffffc020a02a:	39fd                	addiw	s3,s3,-1
ffffffffc020a02c:	2485                	addiw	s1,s1,1
ffffffffc020a02e:	049a0b63          	beq	s4,s1,ffffffffc020a084 <sfs_getdirentry+0xde>
ffffffffc020a032:	86ca                	mv	a3,s2
ffffffffc020a034:	8626                	mv	a2,s1
ffffffffc020a036:	85d6                	mv	a1,s5
ffffffffc020a038:	855e                	mv	a0,s7
ffffffffc020a03a:	eadff0ef          	jal	ra,ffffffffc0209ee6 <sfs_dirent_read_nolock>
ffffffffc020a03e:	842a                	mv	s0,a0
ffffffffc020a040:	d165                	beqz	a0,ffffffffc020a020 <sfs_getdirentry+0x7a>
ffffffffc020a042:	8562                	mv	a0,s8
ffffffffc020a044:	c7afa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a048:	a831                	j	ffffffffc020a064 <sfs_getdirentry+0xbe>
ffffffffc020a04a:	8562                	mv	a0,s8
ffffffffc020a04c:	c72fa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a050:	4701                	li	a4,0
ffffffffc020a052:	4685                	li	a3,1
ffffffffc020a054:	10000613          	li	a2,256
ffffffffc020a058:	00490593          	addi	a1,s2,4
ffffffffc020a05c:	855a                	mv	a0,s6
ffffffffc020a05e:	aecfb0ef          	jal	ra,ffffffffc020534a <iobuf_move>
ffffffffc020a062:	842a                	mv	s0,a0
ffffffffc020a064:	854a                	mv	a0,s2
ffffffffc020a066:	fd9f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a06a:	60a6                	ld	ra,72(sp)
ffffffffc020a06c:	8522                	mv	a0,s0
ffffffffc020a06e:	6406                	ld	s0,64(sp)
ffffffffc020a070:	74e2                	ld	s1,56(sp)
ffffffffc020a072:	7942                	ld	s2,48(sp)
ffffffffc020a074:	79a2                	ld	s3,40(sp)
ffffffffc020a076:	7a02                	ld	s4,32(sp)
ffffffffc020a078:	6ae2                	ld	s5,24(sp)
ffffffffc020a07a:	6b42                	ld	s6,16(sp)
ffffffffc020a07c:	6ba2                	ld	s7,8(sp)
ffffffffc020a07e:	6c02                	ld	s8,0(sp)
ffffffffc020a080:	6161                	addi	sp,sp,80
ffffffffc020a082:	8082                	ret
ffffffffc020a084:	8562                	mv	a0,s8
ffffffffc020a086:	5441                	li	s0,-16
ffffffffc020a088:	c36fa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a08c:	bfe1                	j	ffffffffc020a064 <sfs_getdirentry+0xbe>
ffffffffc020a08e:	854a                	mv	a0,s2
ffffffffc020a090:	faff70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a094:	5475                	li	s0,-3
ffffffffc020a096:	bfd1                	j	ffffffffc020a06a <sfs_getdirentry+0xc4>
ffffffffc020a098:	fa7f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a09c:	5441                	li	s0,-16
ffffffffc020a09e:	b7f1                	j	ffffffffc020a06a <sfs_getdirentry+0xc4>
ffffffffc020a0a0:	5471                	li	s0,-4
ffffffffc020a0a2:	b7e1                	j	ffffffffc020a06a <sfs_getdirentry+0xc4>
ffffffffc020a0a4:	00005697          	auipc	a3,0x5
ffffffffc020a0a8:	8cc68693          	addi	a3,a3,-1844 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc020a0ac:	00001617          	auipc	a2,0x1
ffffffffc020a0b0:	68c60613          	addi	a2,a2,1676 # ffffffffc020b738 <commands+0x210>
ffffffffc020a0b4:	34100593          	li	a1,833
ffffffffc020a0b8:	00005517          	auipc	a0,0x5
ffffffffc020a0bc:	a9850513          	addi	a0,a0,-1384 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a0c0:	bdef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0c4:	00005697          	auipc	a3,0x5
ffffffffc020a0c8:	a5468693          	addi	a3,a3,-1452 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020a0cc:	00001617          	auipc	a2,0x1
ffffffffc020a0d0:	66c60613          	addi	a2,a2,1644 # ffffffffc020b738 <commands+0x210>
ffffffffc020a0d4:	34200593          	li	a1,834
ffffffffc020a0d8:	00005517          	auipc	a0,0x5
ffffffffc020a0dc:	a7850513          	addi	a0,a0,-1416 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a0e0:	bbef60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a0e4 <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a0e4:	715d                	addi	sp,sp,-80
ffffffffc020a0e6:	f052                	sd	s4,32(sp)
ffffffffc020a0e8:	8a2a                	mv	s4,a0
ffffffffc020a0ea:	8532                	mv	a0,a2
ffffffffc020a0ec:	f44e                	sd	s3,40(sp)
ffffffffc020a0ee:	e85a                	sd	s6,16(sp)
ffffffffc020a0f0:	e45e                	sd	s7,8(sp)
ffffffffc020a0f2:	e486                	sd	ra,72(sp)
ffffffffc020a0f4:	e0a2                	sd	s0,64(sp)
ffffffffc020a0f6:	fc26                	sd	s1,56(sp)
ffffffffc020a0f8:	f84a                	sd	s2,48(sp)
ffffffffc020a0fa:	ec56                	sd	s5,24(sp)
ffffffffc020a0fc:	e062                	sd	s8,0(sp)
ffffffffc020a0fe:	8b32                	mv	s6,a2
ffffffffc020a100:	89ae                	mv	s3,a1
ffffffffc020a102:	8bb6                	mv	s7,a3
ffffffffc020a104:	0aa010ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc020a108:	0ff00793          	li	a5,255
ffffffffc020a10c:	06a7ef63          	bltu	a5,a0,ffffffffc020a18a <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a110:	10400513          	li	a0,260
ffffffffc020a114:	e7bf70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a118:	892a                	mv	s2,a0
ffffffffc020a11a:	c535                	beqz	a0,ffffffffc020a186 <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a11c:	0009b783          	ld	a5,0(s3)
ffffffffc020a120:	0087aa83          	lw	s5,8(a5)
ffffffffc020a124:	05505a63          	blez	s5,ffffffffc020a178 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a128:	4481                	li	s1,0
ffffffffc020a12a:	00450c13          	addi	s8,a0,4
ffffffffc020a12e:	a829                	j	ffffffffc020a148 <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a130:	00092783          	lw	a5,0(s2)
ffffffffc020a134:	c799                	beqz	a5,ffffffffc020a142 <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a136:	85e2                	mv	a1,s8
ffffffffc020a138:	855a                	mv	a0,s6
ffffffffc020a13a:	0bc010ef          	jal	ra,ffffffffc020b1f6 <strcmp>
ffffffffc020a13e:	842a                	mv	s0,a0
ffffffffc020a140:	cd15                	beqz	a0,ffffffffc020a17c <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a142:	2485                	addiw	s1,s1,1
ffffffffc020a144:	029a8a63          	beq	s5,s1,ffffffffc020a178 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a148:	86ca                	mv	a3,s2
ffffffffc020a14a:	8626                	mv	a2,s1
ffffffffc020a14c:	85ce                	mv	a1,s3
ffffffffc020a14e:	8552                	mv	a0,s4
ffffffffc020a150:	d97ff0ef          	jal	ra,ffffffffc0209ee6 <sfs_dirent_read_nolock>
ffffffffc020a154:	842a                	mv	s0,a0
ffffffffc020a156:	dd69                	beqz	a0,ffffffffc020a130 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a158:	854a                	mv	a0,s2
ffffffffc020a15a:	ee5f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a15e:	60a6                	ld	ra,72(sp)
ffffffffc020a160:	8522                	mv	a0,s0
ffffffffc020a162:	6406                	ld	s0,64(sp)
ffffffffc020a164:	74e2                	ld	s1,56(sp)
ffffffffc020a166:	7942                	ld	s2,48(sp)
ffffffffc020a168:	79a2                	ld	s3,40(sp)
ffffffffc020a16a:	7a02                	ld	s4,32(sp)
ffffffffc020a16c:	6ae2                	ld	s5,24(sp)
ffffffffc020a16e:	6b42                	ld	s6,16(sp)
ffffffffc020a170:	6ba2                	ld	s7,8(sp)
ffffffffc020a172:	6c02                	ld	s8,0(sp)
ffffffffc020a174:	6161                	addi	sp,sp,80
ffffffffc020a176:	8082                	ret
ffffffffc020a178:	5441                	li	s0,-16
ffffffffc020a17a:	bff9                	j	ffffffffc020a158 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a17c:	00092783          	lw	a5,0(s2)
ffffffffc020a180:	00fba023          	sw	a5,0(s7)
ffffffffc020a184:	bfd1                	j	ffffffffc020a158 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a186:	5471                	li	s0,-4
ffffffffc020a188:	bfd9                	j	ffffffffc020a15e <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a18a:	00005697          	auipc	a3,0x5
ffffffffc020a18e:	ba668693          	addi	a3,a3,-1114 # ffffffffc020ed30 <dev_node_ops+0x7a0>
ffffffffc020a192:	00001617          	auipc	a2,0x1
ffffffffc020a196:	5a660613          	addi	a2,a2,1446 # ffffffffc020b738 <commands+0x210>
ffffffffc020a19a:	1ba00593          	li	a1,442
ffffffffc020a19e:	00005517          	auipc	a0,0x5
ffffffffc020a1a2:	9b250513          	addi	a0,a0,-1614 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a1a6:	af8f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a1aa <sfs_truncfile>:
ffffffffc020a1aa:	7175                	addi	sp,sp,-144
ffffffffc020a1ac:	e506                	sd	ra,136(sp)
ffffffffc020a1ae:	e122                	sd	s0,128(sp)
ffffffffc020a1b0:	fca6                	sd	s1,120(sp)
ffffffffc020a1b2:	f8ca                	sd	s2,112(sp)
ffffffffc020a1b4:	f4ce                	sd	s3,104(sp)
ffffffffc020a1b6:	f0d2                	sd	s4,96(sp)
ffffffffc020a1b8:	ecd6                	sd	s5,88(sp)
ffffffffc020a1ba:	e8da                	sd	s6,80(sp)
ffffffffc020a1bc:	e4de                	sd	s7,72(sp)
ffffffffc020a1be:	e0e2                	sd	s8,64(sp)
ffffffffc020a1c0:	fc66                	sd	s9,56(sp)
ffffffffc020a1c2:	f86a                	sd	s10,48(sp)
ffffffffc020a1c4:	f46e                	sd	s11,40(sp)
ffffffffc020a1c6:	080007b7          	lui	a5,0x8000
ffffffffc020a1ca:	16b7e463          	bltu	a5,a1,ffffffffc020a332 <sfs_truncfile+0x188>
ffffffffc020a1ce:	06853c83          	ld	s9,104(a0)
ffffffffc020a1d2:	89aa                	mv	s3,a0
ffffffffc020a1d4:	160c8163          	beqz	s9,ffffffffc020a336 <sfs_truncfile+0x18c>
ffffffffc020a1d8:	0b0ca783          	lw	a5,176(s9) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a1dc:	14079d63          	bnez	a5,ffffffffc020a336 <sfs_truncfile+0x18c>
ffffffffc020a1e0:	4d38                	lw	a4,88(a0)
ffffffffc020a1e2:	6405                	lui	s0,0x1
ffffffffc020a1e4:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a1e8:	16f71763          	bne	a4,a5,ffffffffc020a356 <sfs_truncfile+0x1ac>
ffffffffc020a1ec:	00053a83          	ld	s5,0(a0)
ffffffffc020a1f0:	147d                	addi	s0,s0,-1
ffffffffc020a1f2:	942e                	add	s0,s0,a1
ffffffffc020a1f4:	000ae783          	lwu	a5,0(s5)
ffffffffc020a1f8:	8031                	srli	s0,s0,0xc
ffffffffc020a1fa:	8a2e                	mv	s4,a1
ffffffffc020a1fc:	2401                	sext.w	s0,s0
ffffffffc020a1fe:	02b79763          	bne	a5,a1,ffffffffc020a22c <sfs_truncfile+0x82>
ffffffffc020a202:	008aa783          	lw	a5,8(s5)
ffffffffc020a206:	4901                	li	s2,0
ffffffffc020a208:	18879763          	bne	a5,s0,ffffffffc020a396 <sfs_truncfile+0x1ec>
ffffffffc020a20c:	60aa                	ld	ra,136(sp)
ffffffffc020a20e:	640a                	ld	s0,128(sp)
ffffffffc020a210:	74e6                	ld	s1,120(sp)
ffffffffc020a212:	79a6                	ld	s3,104(sp)
ffffffffc020a214:	7a06                	ld	s4,96(sp)
ffffffffc020a216:	6ae6                	ld	s5,88(sp)
ffffffffc020a218:	6b46                	ld	s6,80(sp)
ffffffffc020a21a:	6ba6                	ld	s7,72(sp)
ffffffffc020a21c:	6c06                	ld	s8,64(sp)
ffffffffc020a21e:	7ce2                	ld	s9,56(sp)
ffffffffc020a220:	7d42                	ld	s10,48(sp)
ffffffffc020a222:	7da2                	ld	s11,40(sp)
ffffffffc020a224:	854a                	mv	a0,s2
ffffffffc020a226:	7946                	ld	s2,112(sp)
ffffffffc020a228:	6149                	addi	sp,sp,144
ffffffffc020a22a:	8082                	ret
ffffffffc020a22c:	02050b13          	addi	s6,a0,32
ffffffffc020a230:	855a                	mv	a0,s6
ffffffffc020a232:	a90fa0ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a236:	008aa483          	lw	s1,8(s5)
ffffffffc020a23a:	0a84e663          	bltu	s1,s0,ffffffffc020a2e6 <sfs_truncfile+0x13c>
ffffffffc020a23e:	0c947163          	bgeu	s0,s1,ffffffffc020a300 <sfs_truncfile+0x156>
ffffffffc020a242:	4dad                	li	s11,11
ffffffffc020a244:	4b85                	li	s7,1
ffffffffc020a246:	a09d                	j	ffffffffc020a2ac <sfs_truncfile+0x102>
ffffffffc020a248:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a24c:	0009079b          	sext.w	a5,s2
ffffffffc020a250:	3ff00713          	li	a4,1023
ffffffffc020a254:	04f76563          	bltu	a4,a5,ffffffffc020a29e <sfs_truncfile+0xf4>
ffffffffc020a258:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a25c:	040c0163          	beqz	s8,ffffffffc020a29e <sfs_truncfile+0xf4>
ffffffffc020a260:	004ca783          	lw	a5,4(s9)
ffffffffc020a264:	18fc7963          	bgeu	s8,a5,ffffffffc020a3f6 <sfs_truncfile+0x24c>
ffffffffc020a268:	038cb503          	ld	a0,56(s9)
ffffffffc020a26c:	85e2                	mv	a1,s8
ffffffffc020a26e:	b69fe0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc020a272:	16051263          	bnez	a0,ffffffffc020a3d6 <sfs_truncfile+0x22c>
ffffffffc020a276:	02091793          	slli	a5,s2,0x20
ffffffffc020a27a:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a27e:	86e2                	mv	a3,s8
ffffffffc020a280:	4611                	li	a2,4
ffffffffc020a282:	082c                	addi	a1,sp,24
ffffffffc020a284:	8566                	mv	a0,s9
ffffffffc020a286:	e43a                	sd	a4,8(sp)
ffffffffc020a288:	ce02                	sw	zero,28(sp)
ffffffffc020a28a:	043000ef          	jal	ra,ffffffffc020aacc <sfs_rbuf>
ffffffffc020a28e:	892a                	mv	s2,a0
ffffffffc020a290:	e141                	bnez	a0,ffffffffc020a310 <sfs_truncfile+0x166>
ffffffffc020a292:	47e2                	lw	a5,24(sp)
ffffffffc020a294:	6722                	ld	a4,8(sp)
ffffffffc020a296:	e3c9                	bnez	a5,ffffffffc020a318 <sfs_truncfile+0x16e>
ffffffffc020a298:	008d2603          	lw	a2,8(s10)
ffffffffc020a29c:	367d                	addiw	a2,a2,-1
ffffffffc020a29e:	00cd2423          	sw	a2,8(s10)
ffffffffc020a2a2:	0179b823          	sd	s7,16(s3)
ffffffffc020a2a6:	34fd                	addiw	s1,s1,-1
ffffffffc020a2a8:	04940a63          	beq	s0,s1,ffffffffc020a2fc <sfs_truncfile+0x152>
ffffffffc020a2ac:	0009bd03          	ld	s10,0(s3)
ffffffffc020a2b0:	008d2703          	lw	a4,8(s10)
ffffffffc020a2b4:	c369                	beqz	a4,ffffffffc020a376 <sfs_truncfile+0x1cc>
ffffffffc020a2b6:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a2ba:	0007861b          	sext.w	a2,a5
ffffffffc020a2be:	f8cde5e3          	bltu	s11,a2,ffffffffc020a248 <sfs_truncfile+0x9e>
ffffffffc020a2c2:	02079713          	slli	a4,a5,0x20
ffffffffc020a2c6:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a2ca:	00fd0933          	add	s2,s10,a5
ffffffffc020a2ce:	00c92583          	lw	a1,12(s2)
ffffffffc020a2d2:	d5f1                	beqz	a1,ffffffffc020a29e <sfs_truncfile+0xf4>
ffffffffc020a2d4:	8566                	mv	a0,s9
ffffffffc020a2d6:	c0eff0ef          	jal	ra,ffffffffc02096e4 <sfs_block_free>
ffffffffc020a2da:	00092623          	sw	zero,12(s2)
ffffffffc020a2de:	008d2603          	lw	a2,8(s10)
ffffffffc020a2e2:	367d                	addiw	a2,a2,-1
ffffffffc020a2e4:	bf6d                	j	ffffffffc020a29e <sfs_truncfile+0xf4>
ffffffffc020a2e6:	4681                	li	a3,0
ffffffffc020a2e8:	8626                	mv	a2,s1
ffffffffc020a2ea:	85ce                	mv	a1,s3
ffffffffc020a2ec:	8566                	mv	a0,s9
ffffffffc020a2ee:	eb0ff0ef          	jal	ra,ffffffffc020999e <sfs_bmap_load_nolock>
ffffffffc020a2f2:	892a                	mv	s2,a0
ffffffffc020a2f4:	ed11                	bnez	a0,ffffffffc020a310 <sfs_truncfile+0x166>
ffffffffc020a2f6:	2485                	addiw	s1,s1,1
ffffffffc020a2f8:	fe9417e3          	bne	s0,s1,ffffffffc020a2e6 <sfs_truncfile+0x13c>
ffffffffc020a2fc:	008aa483          	lw	s1,8(s5)
ffffffffc020a300:	0a941b63          	bne	s0,s1,ffffffffc020a3b6 <sfs_truncfile+0x20c>
ffffffffc020a304:	014aa023          	sw	s4,0(s5)
ffffffffc020a308:	4785                	li	a5,1
ffffffffc020a30a:	00f9b823          	sd	a5,16(s3)
ffffffffc020a30e:	4901                	li	s2,0
ffffffffc020a310:	855a                	mv	a0,s6
ffffffffc020a312:	9acfa0ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a316:	bddd                	j	ffffffffc020a20c <sfs_truncfile+0x62>
ffffffffc020a318:	86e2                	mv	a3,s8
ffffffffc020a31a:	4611                	li	a2,4
ffffffffc020a31c:	086c                	addi	a1,sp,28
ffffffffc020a31e:	8566                	mv	a0,s9
ffffffffc020a320:	02d000ef          	jal	ra,ffffffffc020ab4c <sfs_wbuf>
ffffffffc020a324:	892a                	mv	s2,a0
ffffffffc020a326:	f56d                	bnez	a0,ffffffffc020a310 <sfs_truncfile+0x166>
ffffffffc020a328:	45e2                	lw	a1,24(sp)
ffffffffc020a32a:	8566                	mv	a0,s9
ffffffffc020a32c:	bb8ff0ef          	jal	ra,ffffffffc02096e4 <sfs_block_free>
ffffffffc020a330:	b7a5                	j	ffffffffc020a298 <sfs_truncfile+0xee>
ffffffffc020a332:	5975                	li	s2,-3
ffffffffc020a334:	bde1                	j	ffffffffc020a20c <sfs_truncfile+0x62>
ffffffffc020a336:	00004697          	auipc	a3,0x4
ffffffffc020a33a:	63a68693          	addi	a3,a3,1594 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc020a33e:	00001617          	auipc	a2,0x1
ffffffffc020a342:	3fa60613          	addi	a2,a2,1018 # ffffffffc020b738 <commands+0x210>
ffffffffc020a346:	3b000593          	li	a1,944
ffffffffc020a34a:	00005517          	auipc	a0,0x5
ffffffffc020a34e:	80650513          	addi	a0,a0,-2042 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a352:	94cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a356:	00004697          	auipc	a3,0x4
ffffffffc020a35a:	7c268693          	addi	a3,a3,1986 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020a35e:	00001617          	auipc	a2,0x1
ffffffffc020a362:	3da60613          	addi	a2,a2,986 # ffffffffc020b738 <commands+0x210>
ffffffffc020a366:	3b100593          	li	a1,945
ffffffffc020a36a:	00004517          	auipc	a0,0x4
ffffffffc020a36e:	7e650513          	addi	a0,a0,2022 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a372:	92cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a376:	00005697          	auipc	a3,0x5
ffffffffc020a37a:	9fa68693          	addi	a3,a3,-1542 # ffffffffc020ed70 <dev_node_ops+0x7e0>
ffffffffc020a37e:	00001617          	auipc	a2,0x1
ffffffffc020a382:	3ba60613          	addi	a2,a2,954 # ffffffffc020b738 <commands+0x210>
ffffffffc020a386:	17b00593          	li	a1,379
ffffffffc020a38a:	00004517          	auipc	a0,0x4
ffffffffc020a38e:	7c650513          	addi	a0,a0,1990 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a392:	90cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a396:	00005697          	auipc	a3,0x5
ffffffffc020a39a:	9c268693          	addi	a3,a3,-1598 # ffffffffc020ed58 <dev_node_ops+0x7c8>
ffffffffc020a39e:	00001617          	auipc	a2,0x1
ffffffffc020a3a2:	39a60613          	addi	a2,a2,922 # ffffffffc020b738 <commands+0x210>
ffffffffc020a3a6:	3b800593          	li	a1,952
ffffffffc020a3aa:	00004517          	auipc	a0,0x4
ffffffffc020a3ae:	7a650513          	addi	a0,a0,1958 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a3b2:	8ecf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3b6:	00005697          	auipc	a3,0x5
ffffffffc020a3ba:	a0a68693          	addi	a3,a3,-1526 # ffffffffc020edc0 <dev_node_ops+0x830>
ffffffffc020a3be:	00001617          	auipc	a2,0x1
ffffffffc020a3c2:	37a60613          	addi	a2,a2,890 # ffffffffc020b738 <commands+0x210>
ffffffffc020a3c6:	3d100593          	li	a1,977
ffffffffc020a3ca:	00004517          	auipc	a0,0x4
ffffffffc020a3ce:	78650513          	addi	a0,a0,1926 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a3d2:	8ccf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3d6:	00005697          	auipc	a3,0x5
ffffffffc020a3da:	9b268693          	addi	a3,a3,-1614 # ffffffffc020ed88 <dev_node_ops+0x7f8>
ffffffffc020a3de:	00001617          	auipc	a2,0x1
ffffffffc020a3e2:	35a60613          	addi	a2,a2,858 # ffffffffc020b738 <commands+0x210>
ffffffffc020a3e6:	12b00593          	li	a1,299
ffffffffc020a3ea:	00004517          	auipc	a0,0x4
ffffffffc020a3ee:	76650513          	addi	a0,a0,1894 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a3f2:	8acf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3f6:	8762                	mv	a4,s8
ffffffffc020a3f8:	86be                	mv	a3,a5
ffffffffc020a3fa:	00004617          	auipc	a2,0x4
ffffffffc020a3fe:	78660613          	addi	a2,a2,1926 # ffffffffc020eb80 <dev_node_ops+0x5f0>
ffffffffc020a402:	05300593          	li	a1,83
ffffffffc020a406:	00004517          	auipc	a0,0x4
ffffffffc020a40a:	74a50513          	addi	a0,a0,1866 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a40e:	890f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a412 <sfs_load_inode>:
ffffffffc020a412:	7139                	addi	sp,sp,-64
ffffffffc020a414:	fc06                	sd	ra,56(sp)
ffffffffc020a416:	f822                	sd	s0,48(sp)
ffffffffc020a418:	f426                	sd	s1,40(sp)
ffffffffc020a41a:	f04a                	sd	s2,32(sp)
ffffffffc020a41c:	84b2                	mv	s1,a2
ffffffffc020a41e:	892a                	mv	s2,a0
ffffffffc020a420:	ec4e                	sd	s3,24(sp)
ffffffffc020a422:	e852                	sd	s4,16(sp)
ffffffffc020a424:	89ae                	mv	s3,a1
ffffffffc020a426:	e456                	sd	s5,8(sp)
ffffffffc020a428:	0d5000ef          	jal	ra,ffffffffc020acfc <lock_sfs_fs>
ffffffffc020a42c:	45a9                	li	a1,10
ffffffffc020a42e:	8526                	mv	a0,s1
ffffffffc020a430:	0a893403          	ld	s0,168(s2)
ffffffffc020a434:	0e9000ef          	jal	ra,ffffffffc020ad1c <hash32>
ffffffffc020a438:	02051793          	slli	a5,a0,0x20
ffffffffc020a43c:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a440:	9722                	add	a4,a4,s0
ffffffffc020a442:	843a                	mv	s0,a4
ffffffffc020a444:	a029                	j	ffffffffc020a44e <sfs_load_inode+0x3c>
ffffffffc020a446:	fc042783          	lw	a5,-64(s0)
ffffffffc020a44a:	10978863          	beq	a5,s1,ffffffffc020a55a <sfs_load_inode+0x148>
ffffffffc020a44e:	6400                	ld	s0,8(s0)
ffffffffc020a450:	fe871be3          	bne	a4,s0,ffffffffc020a446 <sfs_load_inode+0x34>
ffffffffc020a454:	04000513          	li	a0,64
ffffffffc020a458:	b37f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a45c:	8aaa                	mv	s5,a0
ffffffffc020a45e:	16050563          	beqz	a0,ffffffffc020a5c8 <sfs_load_inode+0x1b6>
ffffffffc020a462:	00492683          	lw	a3,4(s2)
ffffffffc020a466:	18048363          	beqz	s1,ffffffffc020a5ec <sfs_load_inode+0x1da>
ffffffffc020a46a:	18d4f163          	bgeu	s1,a3,ffffffffc020a5ec <sfs_load_inode+0x1da>
ffffffffc020a46e:	03893503          	ld	a0,56(s2)
ffffffffc020a472:	85a6                	mv	a1,s1
ffffffffc020a474:	963fe0ef          	jal	ra,ffffffffc0208dd6 <bitmap_test>
ffffffffc020a478:	18051763          	bnez	a0,ffffffffc020a606 <sfs_load_inode+0x1f4>
ffffffffc020a47c:	4701                	li	a4,0
ffffffffc020a47e:	86a6                	mv	a3,s1
ffffffffc020a480:	04000613          	li	a2,64
ffffffffc020a484:	85d6                	mv	a1,s5
ffffffffc020a486:	854a                	mv	a0,s2
ffffffffc020a488:	644000ef          	jal	ra,ffffffffc020aacc <sfs_rbuf>
ffffffffc020a48c:	842a                	mv	s0,a0
ffffffffc020a48e:	0e051563          	bnez	a0,ffffffffc020a578 <sfs_load_inode+0x166>
ffffffffc020a492:	006ad783          	lhu	a5,6(s5)
ffffffffc020a496:	12078b63          	beqz	a5,ffffffffc020a5cc <sfs_load_inode+0x1ba>
ffffffffc020a49a:	6405                	lui	s0,0x1
ffffffffc020a49c:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a4a0:	8f0fd0ef          	jal	ra,ffffffffc0207590 <__alloc_inode>
ffffffffc020a4a4:	8a2a                	mv	s4,a0
ffffffffc020a4a6:	c961                	beqz	a0,ffffffffc020a576 <sfs_load_inode+0x164>
ffffffffc020a4a8:	004ad683          	lhu	a3,4(s5)
ffffffffc020a4ac:	4785                	li	a5,1
ffffffffc020a4ae:	0cf69c63          	bne	a3,a5,ffffffffc020a586 <sfs_load_inode+0x174>
ffffffffc020a4b2:	864a                	mv	a2,s2
ffffffffc020a4b4:	00005597          	auipc	a1,0x5
ffffffffc020a4b8:	a1c58593          	addi	a1,a1,-1508 # ffffffffc020eed0 <sfs_node_fileops>
ffffffffc020a4bc:	8f0fd0ef          	jal	ra,ffffffffc02075ac <inode_init>
ffffffffc020a4c0:	058a2783          	lw	a5,88(s4)
ffffffffc020a4c4:	23540413          	addi	s0,s0,565
ffffffffc020a4c8:	0e879063          	bne	a5,s0,ffffffffc020a5a8 <sfs_load_inode+0x196>
ffffffffc020a4cc:	4785                	li	a5,1
ffffffffc020a4ce:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a4d2:	015a3023          	sd	s5,0(s4)
ffffffffc020a4d6:	009a2423          	sw	s1,8(s4)
ffffffffc020a4da:	000a3823          	sd	zero,16(s4)
ffffffffc020a4de:	4585                	li	a1,1
ffffffffc020a4e0:	020a0513          	addi	a0,s4,32
ffffffffc020a4e4:	fd5f90ef          	jal	ra,ffffffffc02044b8 <sem_init>
ffffffffc020a4e8:	058a2703          	lw	a4,88(s4)
ffffffffc020a4ec:	6785                	lui	a5,0x1
ffffffffc020a4ee:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a4f2:	14f71663          	bne	a4,a5,ffffffffc020a63e <sfs_load_inode+0x22c>
ffffffffc020a4f6:	0a093703          	ld	a4,160(s2)
ffffffffc020a4fa:	038a0793          	addi	a5,s4,56
ffffffffc020a4fe:	008a2503          	lw	a0,8(s4)
ffffffffc020a502:	e31c                	sd	a5,0(a4)
ffffffffc020a504:	0af93023          	sd	a5,160(s2)
ffffffffc020a508:	09890793          	addi	a5,s2,152
ffffffffc020a50c:	0a893403          	ld	s0,168(s2)
ffffffffc020a510:	45a9                	li	a1,10
ffffffffc020a512:	04ea3023          	sd	a4,64(s4)
ffffffffc020a516:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a51a:	003000ef          	jal	ra,ffffffffc020ad1c <hash32>
ffffffffc020a51e:	02051713          	slli	a4,a0,0x20
ffffffffc020a522:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a526:	97a2                	add	a5,a5,s0
ffffffffc020a528:	6798                	ld	a4,8(a5)
ffffffffc020a52a:	048a0693          	addi	a3,s4,72
ffffffffc020a52e:	e314                	sd	a3,0(a4)
ffffffffc020a530:	e794                	sd	a3,8(a5)
ffffffffc020a532:	04ea3823          	sd	a4,80(s4)
ffffffffc020a536:	04fa3423          	sd	a5,72(s4)
ffffffffc020a53a:	854a                	mv	a0,s2
ffffffffc020a53c:	7d0000ef          	jal	ra,ffffffffc020ad0c <unlock_sfs_fs>
ffffffffc020a540:	4401                	li	s0,0
ffffffffc020a542:	0149b023          	sd	s4,0(s3)
ffffffffc020a546:	70e2                	ld	ra,56(sp)
ffffffffc020a548:	8522                	mv	a0,s0
ffffffffc020a54a:	7442                	ld	s0,48(sp)
ffffffffc020a54c:	74a2                	ld	s1,40(sp)
ffffffffc020a54e:	7902                	ld	s2,32(sp)
ffffffffc020a550:	69e2                	ld	s3,24(sp)
ffffffffc020a552:	6a42                	ld	s4,16(sp)
ffffffffc020a554:	6aa2                	ld	s5,8(sp)
ffffffffc020a556:	6121                	addi	sp,sp,64
ffffffffc020a558:	8082                	ret
ffffffffc020a55a:	fb840a13          	addi	s4,s0,-72
ffffffffc020a55e:	8552                	mv	a0,s4
ffffffffc020a560:	8aefd0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc020a564:	4785                	li	a5,1
ffffffffc020a566:	fcf51ae3          	bne	a0,a5,ffffffffc020a53a <sfs_load_inode+0x128>
ffffffffc020a56a:	fd042783          	lw	a5,-48(s0)
ffffffffc020a56e:	2785                	addiw	a5,a5,1
ffffffffc020a570:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a574:	b7d9                	j	ffffffffc020a53a <sfs_load_inode+0x128>
ffffffffc020a576:	5471                	li	s0,-4
ffffffffc020a578:	8556                	mv	a0,s5
ffffffffc020a57a:	ac5f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a57e:	854a                	mv	a0,s2
ffffffffc020a580:	78c000ef          	jal	ra,ffffffffc020ad0c <unlock_sfs_fs>
ffffffffc020a584:	b7c9                	j	ffffffffc020a546 <sfs_load_inode+0x134>
ffffffffc020a586:	4789                	li	a5,2
ffffffffc020a588:	08f69f63          	bne	a3,a5,ffffffffc020a626 <sfs_load_inode+0x214>
ffffffffc020a58c:	864a                	mv	a2,s2
ffffffffc020a58e:	00005597          	auipc	a1,0x5
ffffffffc020a592:	8c258593          	addi	a1,a1,-1854 # ffffffffc020ee50 <sfs_node_dirops>
ffffffffc020a596:	816fd0ef          	jal	ra,ffffffffc02075ac <inode_init>
ffffffffc020a59a:	058a2703          	lw	a4,88(s4)
ffffffffc020a59e:	6785                	lui	a5,0x1
ffffffffc020a5a0:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a5a4:	f2f704e3          	beq	a4,a5,ffffffffc020a4cc <sfs_load_inode+0xba>
ffffffffc020a5a8:	00004697          	auipc	a3,0x4
ffffffffc020a5ac:	57068693          	addi	a3,a3,1392 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020a5b0:	00001617          	auipc	a2,0x1
ffffffffc020a5b4:	18860613          	addi	a2,a2,392 # ffffffffc020b738 <commands+0x210>
ffffffffc020a5b8:	07700593          	li	a1,119
ffffffffc020a5bc:	00004517          	auipc	a0,0x4
ffffffffc020a5c0:	59450513          	addi	a0,a0,1428 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a5c4:	edbf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a5c8:	5471                	li	s0,-4
ffffffffc020a5ca:	bf55                	j	ffffffffc020a57e <sfs_load_inode+0x16c>
ffffffffc020a5cc:	00005697          	auipc	a3,0x5
ffffffffc020a5d0:	80c68693          	addi	a3,a3,-2036 # ffffffffc020edd8 <dev_node_ops+0x848>
ffffffffc020a5d4:	00001617          	auipc	a2,0x1
ffffffffc020a5d8:	16460613          	addi	a2,a2,356 # ffffffffc020b738 <commands+0x210>
ffffffffc020a5dc:	0ad00593          	li	a1,173
ffffffffc020a5e0:	00004517          	auipc	a0,0x4
ffffffffc020a5e4:	57050513          	addi	a0,a0,1392 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a5e8:	eb7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a5ec:	8726                	mv	a4,s1
ffffffffc020a5ee:	00004617          	auipc	a2,0x4
ffffffffc020a5f2:	59260613          	addi	a2,a2,1426 # ffffffffc020eb80 <dev_node_ops+0x5f0>
ffffffffc020a5f6:	05300593          	li	a1,83
ffffffffc020a5fa:	00004517          	auipc	a0,0x4
ffffffffc020a5fe:	55650513          	addi	a0,a0,1366 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a602:	e9df50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a606:	00004697          	auipc	a3,0x4
ffffffffc020a60a:	5b268693          	addi	a3,a3,1458 # ffffffffc020ebb8 <dev_node_ops+0x628>
ffffffffc020a60e:	00001617          	auipc	a2,0x1
ffffffffc020a612:	12a60613          	addi	a2,a2,298 # ffffffffc020b738 <commands+0x210>
ffffffffc020a616:	0a800593          	li	a1,168
ffffffffc020a61a:	00004517          	auipc	a0,0x4
ffffffffc020a61e:	53650513          	addi	a0,a0,1334 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a622:	e7df50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a626:	00004617          	auipc	a2,0x4
ffffffffc020a62a:	54260613          	addi	a2,a2,1346 # ffffffffc020eb68 <dev_node_ops+0x5d8>
ffffffffc020a62e:	02e00593          	li	a1,46
ffffffffc020a632:	00004517          	auipc	a0,0x4
ffffffffc020a636:	51e50513          	addi	a0,a0,1310 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a63a:	e65f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a63e:	00004697          	auipc	a3,0x4
ffffffffc020a642:	4da68693          	addi	a3,a3,1242 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020a646:	00001617          	auipc	a2,0x1
ffffffffc020a64a:	0f260613          	addi	a2,a2,242 # ffffffffc020b738 <commands+0x210>
ffffffffc020a64e:	0b100593          	li	a1,177
ffffffffc020a652:	00004517          	auipc	a0,0x4
ffffffffc020a656:	4fe50513          	addi	a0,a0,1278 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a65a:	e45f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a65e <sfs_lookup>:
ffffffffc020a65e:	7139                	addi	sp,sp,-64
ffffffffc020a660:	ec4e                	sd	s3,24(sp)
ffffffffc020a662:	06853983          	ld	s3,104(a0)
ffffffffc020a666:	fc06                	sd	ra,56(sp)
ffffffffc020a668:	f822                	sd	s0,48(sp)
ffffffffc020a66a:	f426                	sd	s1,40(sp)
ffffffffc020a66c:	f04a                	sd	s2,32(sp)
ffffffffc020a66e:	e852                	sd	s4,16(sp)
ffffffffc020a670:	0a098c63          	beqz	s3,ffffffffc020a728 <sfs_lookup+0xca>
ffffffffc020a674:	0b09a783          	lw	a5,176(s3)
ffffffffc020a678:	ebc5                	bnez	a5,ffffffffc020a728 <sfs_lookup+0xca>
ffffffffc020a67a:	0005c783          	lbu	a5,0(a1)
ffffffffc020a67e:	84ae                	mv	s1,a1
ffffffffc020a680:	c7c1                	beqz	a5,ffffffffc020a708 <sfs_lookup+0xaa>
ffffffffc020a682:	02f00713          	li	a4,47
ffffffffc020a686:	08e78163          	beq	a5,a4,ffffffffc020a708 <sfs_lookup+0xaa>
ffffffffc020a68a:	842a                	mv	s0,a0
ffffffffc020a68c:	8a32                	mv	s4,a2
ffffffffc020a68e:	f81fc0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc020a692:	4c38                	lw	a4,88(s0)
ffffffffc020a694:	6785                	lui	a5,0x1
ffffffffc020a696:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a69a:	0af71763          	bne	a4,a5,ffffffffc020a748 <sfs_lookup+0xea>
ffffffffc020a69e:	6018                	ld	a4,0(s0)
ffffffffc020a6a0:	4789                	li	a5,2
ffffffffc020a6a2:	00475703          	lhu	a4,4(a4)
ffffffffc020a6a6:	04f71c63          	bne	a4,a5,ffffffffc020a6fe <sfs_lookup+0xa0>
ffffffffc020a6aa:	02040913          	addi	s2,s0,32
ffffffffc020a6ae:	854a                	mv	a0,s2
ffffffffc020a6b0:	e13f90ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a6b4:	8626                	mv	a2,s1
ffffffffc020a6b6:	0054                	addi	a3,sp,4
ffffffffc020a6b8:	85a2                	mv	a1,s0
ffffffffc020a6ba:	854e                	mv	a0,s3
ffffffffc020a6bc:	a29ff0ef          	jal	ra,ffffffffc020a0e4 <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a6c0:	84aa                	mv	s1,a0
ffffffffc020a6c2:	854a                	mv	a0,s2
ffffffffc020a6c4:	dfbf90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a6c8:	cc89                	beqz	s1,ffffffffc020a6e2 <sfs_lookup+0x84>
ffffffffc020a6ca:	8522                	mv	a0,s0
ffffffffc020a6cc:	810fd0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020a6d0:	70e2                	ld	ra,56(sp)
ffffffffc020a6d2:	7442                	ld	s0,48(sp)
ffffffffc020a6d4:	7902                	ld	s2,32(sp)
ffffffffc020a6d6:	69e2                	ld	s3,24(sp)
ffffffffc020a6d8:	6a42                	ld	s4,16(sp)
ffffffffc020a6da:	8526                	mv	a0,s1
ffffffffc020a6dc:	74a2                	ld	s1,40(sp)
ffffffffc020a6de:	6121                	addi	sp,sp,64
ffffffffc020a6e0:	8082                	ret
ffffffffc020a6e2:	4612                	lw	a2,4(sp)
ffffffffc020a6e4:	002c                	addi	a1,sp,8
ffffffffc020a6e6:	854e                	mv	a0,s3
ffffffffc020a6e8:	d2bff0ef          	jal	ra,ffffffffc020a412 <sfs_load_inode>
ffffffffc020a6ec:	84aa                	mv	s1,a0
ffffffffc020a6ee:	8522                	mv	a0,s0
ffffffffc020a6f0:	fedfc0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020a6f4:	fcf1                	bnez	s1,ffffffffc020a6d0 <sfs_lookup+0x72>
ffffffffc020a6f6:	67a2                	ld	a5,8(sp)
ffffffffc020a6f8:	00fa3023          	sd	a5,0(s4)
ffffffffc020a6fc:	bfd1                	j	ffffffffc020a6d0 <sfs_lookup+0x72>
ffffffffc020a6fe:	8522                	mv	a0,s0
ffffffffc020a700:	fddfc0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020a704:	54b9                	li	s1,-18
ffffffffc020a706:	b7e9                	j	ffffffffc020a6d0 <sfs_lookup+0x72>
ffffffffc020a708:	00004697          	auipc	a3,0x4
ffffffffc020a70c:	6e868693          	addi	a3,a3,1768 # ffffffffc020edf0 <dev_node_ops+0x860>
ffffffffc020a710:	00001617          	auipc	a2,0x1
ffffffffc020a714:	02860613          	addi	a2,a2,40 # ffffffffc020b738 <commands+0x210>
ffffffffc020a718:	3e200593          	li	a1,994
ffffffffc020a71c:	00004517          	auipc	a0,0x4
ffffffffc020a720:	43450513          	addi	a0,a0,1076 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a724:	d7bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a728:	00004697          	auipc	a3,0x4
ffffffffc020a72c:	24868693          	addi	a3,a3,584 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc020a730:	00001617          	auipc	a2,0x1
ffffffffc020a734:	00860613          	addi	a2,a2,8 # ffffffffc020b738 <commands+0x210>
ffffffffc020a738:	3e100593          	li	a1,993
ffffffffc020a73c:	00004517          	auipc	a0,0x4
ffffffffc020a740:	41450513          	addi	a0,a0,1044 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a744:	d5bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a748:	00004697          	auipc	a3,0x4
ffffffffc020a74c:	3d068693          	addi	a3,a3,976 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020a750:	00001617          	auipc	a2,0x1
ffffffffc020a754:	fe860613          	addi	a2,a2,-24 # ffffffffc020b738 <commands+0x210>
ffffffffc020a758:	3e400593          	li	a1,996
ffffffffc020a75c:	00004517          	auipc	a0,0x4
ffffffffc020a760:	3f450513          	addi	a0,a0,1012 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a764:	d3bf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a768 <sfs_namefile>:
ffffffffc020a768:	6d98                	ld	a4,24(a1)
ffffffffc020a76a:	7175                	addi	sp,sp,-144
ffffffffc020a76c:	e506                	sd	ra,136(sp)
ffffffffc020a76e:	e122                	sd	s0,128(sp)
ffffffffc020a770:	fca6                	sd	s1,120(sp)
ffffffffc020a772:	f8ca                	sd	s2,112(sp)
ffffffffc020a774:	f4ce                	sd	s3,104(sp)
ffffffffc020a776:	f0d2                	sd	s4,96(sp)
ffffffffc020a778:	ecd6                	sd	s5,88(sp)
ffffffffc020a77a:	e8da                	sd	s6,80(sp)
ffffffffc020a77c:	e4de                	sd	s7,72(sp)
ffffffffc020a77e:	e0e2                	sd	s8,64(sp)
ffffffffc020a780:	fc66                	sd	s9,56(sp)
ffffffffc020a782:	f86a                	sd	s10,48(sp)
ffffffffc020a784:	f46e                	sd	s11,40(sp)
ffffffffc020a786:	e42e                	sd	a1,8(sp)
ffffffffc020a788:	4789                	li	a5,2
ffffffffc020a78a:	1ae7f363          	bgeu	a5,a4,ffffffffc020a930 <sfs_namefile+0x1c8>
ffffffffc020a78e:	89aa                	mv	s3,a0
ffffffffc020a790:	10400513          	li	a0,260
ffffffffc020a794:	ffaf70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a798:	842a                	mv	s0,a0
ffffffffc020a79a:	18050b63          	beqz	a0,ffffffffc020a930 <sfs_namefile+0x1c8>
ffffffffc020a79e:	0689b483          	ld	s1,104(s3)
ffffffffc020a7a2:	1e048963          	beqz	s1,ffffffffc020a994 <sfs_namefile+0x22c>
ffffffffc020a7a6:	0b04a783          	lw	a5,176(s1)
ffffffffc020a7aa:	1e079563          	bnez	a5,ffffffffc020a994 <sfs_namefile+0x22c>
ffffffffc020a7ae:	0589ac83          	lw	s9,88(s3)
ffffffffc020a7b2:	6785                	lui	a5,0x1
ffffffffc020a7b4:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a7b8:	1afc9e63          	bne	s9,a5,ffffffffc020a974 <sfs_namefile+0x20c>
ffffffffc020a7bc:	6722                	ld	a4,8(sp)
ffffffffc020a7be:	854e                	mv	a0,s3
ffffffffc020a7c0:	8ace                	mv	s5,s3
ffffffffc020a7c2:	6f1c                	ld	a5,24(a4)
ffffffffc020a7c4:	00073b03          	ld	s6,0(a4)
ffffffffc020a7c8:	02098a13          	addi	s4,s3,32
ffffffffc020a7cc:	ffe78b93          	addi	s7,a5,-2
ffffffffc020a7d0:	9b3e                	add	s6,s6,a5
ffffffffc020a7d2:	00004d17          	auipc	s10,0x4
ffffffffc020a7d6:	63ed0d13          	addi	s10,s10,1598 # ffffffffc020ee10 <dev_node_ops+0x880>
ffffffffc020a7da:	e35fc0ef          	jal	ra,ffffffffc020760e <inode_ref_inc>
ffffffffc020a7de:	00440c13          	addi	s8,s0,4
ffffffffc020a7e2:	e066                	sd	s9,0(sp)
ffffffffc020a7e4:	8552                	mv	a0,s4
ffffffffc020a7e6:	cddf90ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a7ea:	0854                	addi	a3,sp,20
ffffffffc020a7ec:	866a                	mv	a2,s10
ffffffffc020a7ee:	85d6                	mv	a1,s5
ffffffffc020a7f0:	8526                	mv	a0,s1
ffffffffc020a7f2:	8f3ff0ef          	jal	ra,ffffffffc020a0e4 <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a7f6:	8daa                	mv	s11,a0
ffffffffc020a7f8:	8552                	mv	a0,s4
ffffffffc020a7fa:	cc5f90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a7fe:	020d8863          	beqz	s11,ffffffffc020a82e <sfs_namefile+0xc6>
ffffffffc020a802:	854e                	mv	a0,s3
ffffffffc020a804:	ed9fc0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020a808:	8522                	mv	a0,s0
ffffffffc020a80a:	835f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a80e:	60aa                	ld	ra,136(sp)
ffffffffc020a810:	640a                	ld	s0,128(sp)
ffffffffc020a812:	74e6                	ld	s1,120(sp)
ffffffffc020a814:	7946                	ld	s2,112(sp)
ffffffffc020a816:	79a6                	ld	s3,104(sp)
ffffffffc020a818:	7a06                	ld	s4,96(sp)
ffffffffc020a81a:	6ae6                	ld	s5,88(sp)
ffffffffc020a81c:	6b46                	ld	s6,80(sp)
ffffffffc020a81e:	6ba6                	ld	s7,72(sp)
ffffffffc020a820:	6c06                	ld	s8,64(sp)
ffffffffc020a822:	7ce2                	ld	s9,56(sp)
ffffffffc020a824:	7d42                	ld	s10,48(sp)
ffffffffc020a826:	856e                	mv	a0,s11
ffffffffc020a828:	7da2                	ld	s11,40(sp)
ffffffffc020a82a:	6149                	addi	sp,sp,144
ffffffffc020a82c:	8082                	ret
ffffffffc020a82e:	4652                	lw	a2,20(sp)
ffffffffc020a830:	082c                	addi	a1,sp,24
ffffffffc020a832:	8526                	mv	a0,s1
ffffffffc020a834:	bdfff0ef          	jal	ra,ffffffffc020a412 <sfs_load_inode>
ffffffffc020a838:	8daa                	mv	s11,a0
ffffffffc020a83a:	f561                	bnez	a0,ffffffffc020a802 <sfs_namefile+0x9a>
ffffffffc020a83c:	854e                	mv	a0,s3
ffffffffc020a83e:	008aa903          	lw	s2,8(s5)
ffffffffc020a842:	e9bfc0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020a846:	6ce2                	ld	s9,24(sp)
ffffffffc020a848:	0b3c8463          	beq	s9,s3,ffffffffc020a8f0 <sfs_namefile+0x188>
ffffffffc020a84c:	100c8463          	beqz	s9,ffffffffc020a954 <sfs_namefile+0x1ec>
ffffffffc020a850:	058ca703          	lw	a4,88(s9)
ffffffffc020a854:	6782                	ld	a5,0(sp)
ffffffffc020a856:	0ef71f63          	bne	a4,a5,ffffffffc020a954 <sfs_namefile+0x1ec>
ffffffffc020a85a:	008ca703          	lw	a4,8(s9)
ffffffffc020a85e:	8ae6                	mv	s5,s9
ffffffffc020a860:	0d270a63          	beq	a4,s2,ffffffffc020a934 <sfs_namefile+0x1cc>
ffffffffc020a864:	000cb703          	ld	a4,0(s9)
ffffffffc020a868:	4789                	li	a5,2
ffffffffc020a86a:	00475703          	lhu	a4,4(a4)
ffffffffc020a86e:	0cf71363          	bne	a4,a5,ffffffffc020a934 <sfs_namefile+0x1cc>
ffffffffc020a872:	020c8a13          	addi	s4,s9,32
ffffffffc020a876:	8552                	mv	a0,s4
ffffffffc020a878:	c4bf90ef          	jal	ra,ffffffffc02044c2 <down>
ffffffffc020a87c:	000cb703          	ld	a4,0(s9)
ffffffffc020a880:	00872983          	lw	s3,8(a4)
ffffffffc020a884:	01304963          	bgtz	s3,ffffffffc020a896 <sfs_namefile+0x12e>
ffffffffc020a888:	a899                	j	ffffffffc020a8de <sfs_namefile+0x176>
ffffffffc020a88a:	4018                	lw	a4,0(s0)
ffffffffc020a88c:	01270e63          	beq	a4,s2,ffffffffc020a8a8 <sfs_namefile+0x140>
ffffffffc020a890:	2d85                	addiw	s11,s11,1
ffffffffc020a892:	05b98663          	beq	s3,s11,ffffffffc020a8de <sfs_namefile+0x176>
ffffffffc020a896:	86a2                	mv	a3,s0
ffffffffc020a898:	866e                	mv	a2,s11
ffffffffc020a89a:	85e6                	mv	a1,s9
ffffffffc020a89c:	8526                	mv	a0,s1
ffffffffc020a89e:	e48ff0ef          	jal	ra,ffffffffc0209ee6 <sfs_dirent_read_nolock>
ffffffffc020a8a2:	872a                	mv	a4,a0
ffffffffc020a8a4:	d17d                	beqz	a0,ffffffffc020a88a <sfs_namefile+0x122>
ffffffffc020a8a6:	a82d                	j	ffffffffc020a8e0 <sfs_namefile+0x178>
ffffffffc020a8a8:	8552                	mv	a0,s4
ffffffffc020a8aa:	c15f90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a8ae:	8562                	mv	a0,s8
ffffffffc020a8b0:	0ff000ef          	jal	ra,ffffffffc020b1ae <strlen>
ffffffffc020a8b4:	00150793          	addi	a5,a0,1
ffffffffc020a8b8:	862a                	mv	a2,a0
ffffffffc020a8ba:	06fbe863          	bltu	s7,a5,ffffffffc020a92a <sfs_namefile+0x1c2>
ffffffffc020a8be:	fff64913          	not	s2,a2
ffffffffc020a8c2:	995a                	add	s2,s2,s6
ffffffffc020a8c4:	85e2                	mv	a1,s8
ffffffffc020a8c6:	854a                	mv	a0,s2
ffffffffc020a8c8:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020a8cc:	1d7000ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc020a8d0:	02f00793          	li	a5,47
ffffffffc020a8d4:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020a8d8:	89e6                	mv	s3,s9
ffffffffc020a8da:	8b4a                	mv	s6,s2
ffffffffc020a8dc:	b721                	j	ffffffffc020a7e4 <sfs_namefile+0x7c>
ffffffffc020a8de:	5741                	li	a4,-16
ffffffffc020a8e0:	8552                	mv	a0,s4
ffffffffc020a8e2:	e03a                	sd	a4,0(sp)
ffffffffc020a8e4:	bdbf90ef          	jal	ra,ffffffffc02044be <up>
ffffffffc020a8e8:	6702                	ld	a4,0(sp)
ffffffffc020a8ea:	89e6                	mv	s3,s9
ffffffffc020a8ec:	8dba                	mv	s11,a4
ffffffffc020a8ee:	bf11                	j	ffffffffc020a802 <sfs_namefile+0x9a>
ffffffffc020a8f0:	854e                	mv	a0,s3
ffffffffc020a8f2:	debfc0ef          	jal	ra,ffffffffc02076dc <inode_ref_dec>
ffffffffc020a8f6:	64a2                	ld	s1,8(sp)
ffffffffc020a8f8:	85da                	mv	a1,s6
ffffffffc020a8fa:	6c98                	ld	a4,24(s1)
ffffffffc020a8fc:	6088                	ld	a0,0(s1)
ffffffffc020a8fe:	1779                	addi	a4,a4,-2
ffffffffc020a900:	41770bb3          	sub	s7,a4,s7
ffffffffc020a904:	865e                	mv	a2,s7
ffffffffc020a906:	0505                	addi	a0,a0,1
ffffffffc020a908:	15b000ef          	jal	ra,ffffffffc020b262 <memmove>
ffffffffc020a90c:	02f00713          	li	a4,47
ffffffffc020a910:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020a914:	955e                	add	a0,a0,s7
ffffffffc020a916:	00050023          	sb	zero,0(a0)
ffffffffc020a91a:	85de                	mv	a1,s7
ffffffffc020a91c:	8526                	mv	a0,s1
ffffffffc020a91e:	a99fa0ef          	jal	ra,ffffffffc02053b6 <iobuf_skip>
ffffffffc020a922:	8522                	mv	a0,s0
ffffffffc020a924:	f1af70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a928:	b5dd                	j	ffffffffc020a80e <sfs_namefile+0xa6>
ffffffffc020a92a:	89e6                	mv	s3,s9
ffffffffc020a92c:	5df1                	li	s11,-4
ffffffffc020a92e:	bdd1                	j	ffffffffc020a802 <sfs_namefile+0x9a>
ffffffffc020a930:	5df1                	li	s11,-4
ffffffffc020a932:	bdf1                	j	ffffffffc020a80e <sfs_namefile+0xa6>
ffffffffc020a934:	00004697          	auipc	a3,0x4
ffffffffc020a938:	4e468693          	addi	a3,a3,1252 # ffffffffc020ee18 <dev_node_ops+0x888>
ffffffffc020a93c:	00001617          	auipc	a2,0x1
ffffffffc020a940:	dfc60613          	addi	a2,a2,-516 # ffffffffc020b738 <commands+0x210>
ffffffffc020a944:	30000593          	li	a1,768
ffffffffc020a948:	00004517          	auipc	a0,0x4
ffffffffc020a94c:	20850513          	addi	a0,a0,520 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a950:	b4ff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a954:	00004697          	auipc	a3,0x4
ffffffffc020a958:	1c468693          	addi	a3,a3,452 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020a95c:	00001617          	auipc	a2,0x1
ffffffffc020a960:	ddc60613          	addi	a2,a2,-548 # ffffffffc020b738 <commands+0x210>
ffffffffc020a964:	2ff00593          	li	a1,767
ffffffffc020a968:	00004517          	auipc	a0,0x4
ffffffffc020a96c:	1e850513          	addi	a0,a0,488 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a970:	b2ff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a974:	00004697          	auipc	a3,0x4
ffffffffc020a978:	1a468693          	addi	a3,a3,420 # ffffffffc020eb18 <dev_node_ops+0x588>
ffffffffc020a97c:	00001617          	auipc	a2,0x1
ffffffffc020a980:	dbc60613          	addi	a2,a2,-580 # ffffffffc020b738 <commands+0x210>
ffffffffc020a984:	2ec00593          	li	a1,748
ffffffffc020a988:	00004517          	auipc	a0,0x4
ffffffffc020a98c:	1c850513          	addi	a0,a0,456 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a990:	b0ff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a994:	00004697          	auipc	a3,0x4
ffffffffc020a998:	fdc68693          	addi	a3,a3,-36 # ffffffffc020e970 <dev_node_ops+0x3e0>
ffffffffc020a99c:	00001617          	auipc	a2,0x1
ffffffffc020a9a0:	d9c60613          	addi	a2,a2,-612 # ffffffffc020b738 <commands+0x210>
ffffffffc020a9a4:	2eb00593          	li	a1,747
ffffffffc020a9a8:	00004517          	auipc	a0,0x4
ffffffffc020a9ac:	1a850513          	addi	a0,a0,424 # ffffffffc020eb50 <dev_node_ops+0x5c0>
ffffffffc020a9b0:	aeff50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a9b4 <sfs_rwblock_nolock>:
ffffffffc020a9b4:	7139                	addi	sp,sp,-64
ffffffffc020a9b6:	f822                	sd	s0,48(sp)
ffffffffc020a9b8:	f426                	sd	s1,40(sp)
ffffffffc020a9ba:	fc06                	sd	ra,56(sp)
ffffffffc020a9bc:	842a                	mv	s0,a0
ffffffffc020a9be:	84b6                	mv	s1,a3
ffffffffc020a9c0:	e211                	bnez	a2,ffffffffc020a9c4 <sfs_rwblock_nolock+0x10>
ffffffffc020a9c2:	e715                	bnez	a4,ffffffffc020a9ee <sfs_rwblock_nolock+0x3a>
ffffffffc020a9c4:	405c                	lw	a5,4(s0)
ffffffffc020a9c6:	02f67463          	bgeu	a2,a5,ffffffffc020a9ee <sfs_rwblock_nolock+0x3a>
ffffffffc020a9ca:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020a9ce:	1682                	slli	a3,a3,0x20
ffffffffc020a9d0:	6605                	lui	a2,0x1
ffffffffc020a9d2:	9281                	srli	a3,a3,0x20
ffffffffc020a9d4:	850a                	mv	a0,sp
ffffffffc020a9d6:	96bfa0ef          	jal	ra,ffffffffc0205340 <iobuf_init>
ffffffffc020a9da:	85aa                	mv	a1,a0
ffffffffc020a9dc:	7808                	ld	a0,48(s0)
ffffffffc020a9de:	8626                	mv	a2,s1
ffffffffc020a9e0:	7118                	ld	a4,32(a0)
ffffffffc020a9e2:	9702                	jalr	a4
ffffffffc020a9e4:	70e2                	ld	ra,56(sp)
ffffffffc020a9e6:	7442                	ld	s0,48(sp)
ffffffffc020a9e8:	74a2                	ld	s1,40(sp)
ffffffffc020a9ea:	6121                	addi	sp,sp,64
ffffffffc020a9ec:	8082                	ret
ffffffffc020a9ee:	00004697          	auipc	a3,0x4
ffffffffc020a9f2:	56268693          	addi	a3,a3,1378 # ffffffffc020ef50 <sfs_node_fileops+0x80>
ffffffffc020a9f6:	00001617          	auipc	a2,0x1
ffffffffc020a9fa:	d4260613          	addi	a2,a2,-702 # ffffffffc020b738 <commands+0x210>
ffffffffc020a9fe:	45d5                	li	a1,21
ffffffffc020aa00:	00004517          	auipc	a0,0x4
ffffffffc020aa04:	58850513          	addi	a0,a0,1416 # ffffffffc020ef88 <sfs_node_fileops+0xb8>
ffffffffc020aa08:	a97f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aa0c <sfs_rblock>:
ffffffffc020aa0c:	7139                	addi	sp,sp,-64
ffffffffc020aa0e:	ec4e                	sd	s3,24(sp)
ffffffffc020aa10:	89b6                	mv	s3,a3
ffffffffc020aa12:	f822                	sd	s0,48(sp)
ffffffffc020aa14:	f04a                	sd	s2,32(sp)
ffffffffc020aa16:	e852                	sd	s4,16(sp)
ffffffffc020aa18:	fc06                	sd	ra,56(sp)
ffffffffc020aa1a:	f426                	sd	s1,40(sp)
ffffffffc020aa1c:	e456                	sd	s5,8(sp)
ffffffffc020aa1e:	8a2a                	mv	s4,a0
ffffffffc020aa20:	892e                	mv	s2,a1
ffffffffc020aa22:	8432                	mv	s0,a2
ffffffffc020aa24:	2e0000ef          	jal	ra,ffffffffc020ad04 <lock_sfs_io>
ffffffffc020aa28:	04098063          	beqz	s3,ffffffffc020aa68 <sfs_rblock+0x5c>
ffffffffc020aa2c:	013409bb          	addw	s3,s0,s3
ffffffffc020aa30:	6a85                	lui	s5,0x1
ffffffffc020aa32:	a021                	j	ffffffffc020aa3a <sfs_rblock+0x2e>
ffffffffc020aa34:	9956                	add	s2,s2,s5
ffffffffc020aa36:	02898963          	beq	s3,s0,ffffffffc020aa68 <sfs_rblock+0x5c>
ffffffffc020aa3a:	8622                	mv	a2,s0
ffffffffc020aa3c:	85ca                	mv	a1,s2
ffffffffc020aa3e:	4705                	li	a4,1
ffffffffc020aa40:	4681                	li	a3,0
ffffffffc020aa42:	8552                	mv	a0,s4
ffffffffc020aa44:	f71ff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020aa48:	84aa                	mv	s1,a0
ffffffffc020aa4a:	2405                	addiw	s0,s0,1
ffffffffc020aa4c:	d565                	beqz	a0,ffffffffc020aa34 <sfs_rblock+0x28>
ffffffffc020aa4e:	8552                	mv	a0,s4
ffffffffc020aa50:	2c4000ef          	jal	ra,ffffffffc020ad14 <unlock_sfs_io>
ffffffffc020aa54:	70e2                	ld	ra,56(sp)
ffffffffc020aa56:	7442                	ld	s0,48(sp)
ffffffffc020aa58:	7902                	ld	s2,32(sp)
ffffffffc020aa5a:	69e2                	ld	s3,24(sp)
ffffffffc020aa5c:	6a42                	ld	s4,16(sp)
ffffffffc020aa5e:	6aa2                	ld	s5,8(sp)
ffffffffc020aa60:	8526                	mv	a0,s1
ffffffffc020aa62:	74a2                	ld	s1,40(sp)
ffffffffc020aa64:	6121                	addi	sp,sp,64
ffffffffc020aa66:	8082                	ret
ffffffffc020aa68:	4481                	li	s1,0
ffffffffc020aa6a:	b7d5                	j	ffffffffc020aa4e <sfs_rblock+0x42>

ffffffffc020aa6c <sfs_wblock>:
ffffffffc020aa6c:	7139                	addi	sp,sp,-64
ffffffffc020aa6e:	ec4e                	sd	s3,24(sp)
ffffffffc020aa70:	89b6                	mv	s3,a3
ffffffffc020aa72:	f822                	sd	s0,48(sp)
ffffffffc020aa74:	f04a                	sd	s2,32(sp)
ffffffffc020aa76:	e852                	sd	s4,16(sp)
ffffffffc020aa78:	fc06                	sd	ra,56(sp)
ffffffffc020aa7a:	f426                	sd	s1,40(sp)
ffffffffc020aa7c:	e456                	sd	s5,8(sp)
ffffffffc020aa7e:	8a2a                	mv	s4,a0
ffffffffc020aa80:	892e                	mv	s2,a1
ffffffffc020aa82:	8432                	mv	s0,a2
ffffffffc020aa84:	280000ef          	jal	ra,ffffffffc020ad04 <lock_sfs_io>
ffffffffc020aa88:	04098063          	beqz	s3,ffffffffc020aac8 <sfs_wblock+0x5c>
ffffffffc020aa8c:	013409bb          	addw	s3,s0,s3
ffffffffc020aa90:	6a85                	lui	s5,0x1
ffffffffc020aa92:	a021                	j	ffffffffc020aa9a <sfs_wblock+0x2e>
ffffffffc020aa94:	9956                	add	s2,s2,s5
ffffffffc020aa96:	02898963          	beq	s3,s0,ffffffffc020aac8 <sfs_wblock+0x5c>
ffffffffc020aa9a:	8622                	mv	a2,s0
ffffffffc020aa9c:	85ca                	mv	a1,s2
ffffffffc020aa9e:	4705                	li	a4,1
ffffffffc020aaa0:	4685                	li	a3,1
ffffffffc020aaa2:	8552                	mv	a0,s4
ffffffffc020aaa4:	f11ff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020aaa8:	84aa                	mv	s1,a0
ffffffffc020aaaa:	2405                	addiw	s0,s0,1
ffffffffc020aaac:	d565                	beqz	a0,ffffffffc020aa94 <sfs_wblock+0x28>
ffffffffc020aaae:	8552                	mv	a0,s4
ffffffffc020aab0:	264000ef          	jal	ra,ffffffffc020ad14 <unlock_sfs_io>
ffffffffc020aab4:	70e2                	ld	ra,56(sp)
ffffffffc020aab6:	7442                	ld	s0,48(sp)
ffffffffc020aab8:	7902                	ld	s2,32(sp)
ffffffffc020aaba:	69e2                	ld	s3,24(sp)
ffffffffc020aabc:	6a42                	ld	s4,16(sp)
ffffffffc020aabe:	6aa2                	ld	s5,8(sp)
ffffffffc020aac0:	8526                	mv	a0,s1
ffffffffc020aac2:	74a2                	ld	s1,40(sp)
ffffffffc020aac4:	6121                	addi	sp,sp,64
ffffffffc020aac6:	8082                	ret
ffffffffc020aac8:	4481                	li	s1,0
ffffffffc020aaca:	b7d5                	j	ffffffffc020aaae <sfs_wblock+0x42>

ffffffffc020aacc <sfs_rbuf>:
ffffffffc020aacc:	7179                	addi	sp,sp,-48
ffffffffc020aace:	f406                	sd	ra,40(sp)
ffffffffc020aad0:	f022                	sd	s0,32(sp)
ffffffffc020aad2:	ec26                	sd	s1,24(sp)
ffffffffc020aad4:	e84a                	sd	s2,16(sp)
ffffffffc020aad6:	e44e                	sd	s3,8(sp)
ffffffffc020aad8:	e052                	sd	s4,0(sp)
ffffffffc020aada:	6785                	lui	a5,0x1
ffffffffc020aadc:	04f77863          	bgeu	a4,a5,ffffffffc020ab2c <sfs_rbuf+0x60>
ffffffffc020aae0:	84ba                	mv	s1,a4
ffffffffc020aae2:	9732                	add	a4,a4,a2
ffffffffc020aae4:	89b2                	mv	s3,a2
ffffffffc020aae6:	04e7e363          	bltu	a5,a4,ffffffffc020ab2c <sfs_rbuf+0x60>
ffffffffc020aaea:	8936                	mv	s2,a3
ffffffffc020aaec:	842a                	mv	s0,a0
ffffffffc020aaee:	8a2e                	mv	s4,a1
ffffffffc020aaf0:	214000ef          	jal	ra,ffffffffc020ad04 <lock_sfs_io>
ffffffffc020aaf4:	642c                	ld	a1,72(s0)
ffffffffc020aaf6:	864a                	mv	a2,s2
ffffffffc020aaf8:	4705                	li	a4,1
ffffffffc020aafa:	4681                	li	a3,0
ffffffffc020aafc:	8522                	mv	a0,s0
ffffffffc020aafe:	eb7ff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020ab02:	892a                	mv	s2,a0
ffffffffc020ab04:	cd09                	beqz	a0,ffffffffc020ab1e <sfs_rbuf+0x52>
ffffffffc020ab06:	8522                	mv	a0,s0
ffffffffc020ab08:	20c000ef          	jal	ra,ffffffffc020ad14 <unlock_sfs_io>
ffffffffc020ab0c:	70a2                	ld	ra,40(sp)
ffffffffc020ab0e:	7402                	ld	s0,32(sp)
ffffffffc020ab10:	64e2                	ld	s1,24(sp)
ffffffffc020ab12:	69a2                	ld	s3,8(sp)
ffffffffc020ab14:	6a02                	ld	s4,0(sp)
ffffffffc020ab16:	854a                	mv	a0,s2
ffffffffc020ab18:	6942                	ld	s2,16(sp)
ffffffffc020ab1a:	6145                	addi	sp,sp,48
ffffffffc020ab1c:	8082                	ret
ffffffffc020ab1e:	642c                	ld	a1,72(s0)
ffffffffc020ab20:	864e                	mv	a2,s3
ffffffffc020ab22:	8552                	mv	a0,s4
ffffffffc020ab24:	95a6                	add	a1,a1,s1
ffffffffc020ab26:	77c000ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc020ab2a:	bff1                	j	ffffffffc020ab06 <sfs_rbuf+0x3a>
ffffffffc020ab2c:	00004697          	auipc	a3,0x4
ffffffffc020ab30:	47468693          	addi	a3,a3,1140 # ffffffffc020efa0 <sfs_node_fileops+0xd0>
ffffffffc020ab34:	00001617          	auipc	a2,0x1
ffffffffc020ab38:	c0460613          	addi	a2,a2,-1020 # ffffffffc020b738 <commands+0x210>
ffffffffc020ab3c:	05500593          	li	a1,85
ffffffffc020ab40:	00004517          	auipc	a0,0x4
ffffffffc020ab44:	44850513          	addi	a0,a0,1096 # ffffffffc020ef88 <sfs_node_fileops+0xb8>
ffffffffc020ab48:	957f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ab4c <sfs_wbuf>:
ffffffffc020ab4c:	7139                	addi	sp,sp,-64
ffffffffc020ab4e:	fc06                	sd	ra,56(sp)
ffffffffc020ab50:	f822                	sd	s0,48(sp)
ffffffffc020ab52:	f426                	sd	s1,40(sp)
ffffffffc020ab54:	f04a                	sd	s2,32(sp)
ffffffffc020ab56:	ec4e                	sd	s3,24(sp)
ffffffffc020ab58:	e852                	sd	s4,16(sp)
ffffffffc020ab5a:	e456                	sd	s5,8(sp)
ffffffffc020ab5c:	6785                	lui	a5,0x1
ffffffffc020ab5e:	06f77163          	bgeu	a4,a5,ffffffffc020abc0 <sfs_wbuf+0x74>
ffffffffc020ab62:	893a                	mv	s2,a4
ffffffffc020ab64:	9732                	add	a4,a4,a2
ffffffffc020ab66:	8a32                	mv	s4,a2
ffffffffc020ab68:	04e7ec63          	bltu	a5,a4,ffffffffc020abc0 <sfs_wbuf+0x74>
ffffffffc020ab6c:	842a                	mv	s0,a0
ffffffffc020ab6e:	89b6                	mv	s3,a3
ffffffffc020ab70:	8aae                	mv	s5,a1
ffffffffc020ab72:	192000ef          	jal	ra,ffffffffc020ad04 <lock_sfs_io>
ffffffffc020ab76:	642c                	ld	a1,72(s0)
ffffffffc020ab78:	4705                	li	a4,1
ffffffffc020ab7a:	4681                	li	a3,0
ffffffffc020ab7c:	864e                	mv	a2,s3
ffffffffc020ab7e:	8522                	mv	a0,s0
ffffffffc020ab80:	e35ff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020ab84:	84aa                	mv	s1,a0
ffffffffc020ab86:	cd11                	beqz	a0,ffffffffc020aba2 <sfs_wbuf+0x56>
ffffffffc020ab88:	8522                	mv	a0,s0
ffffffffc020ab8a:	18a000ef          	jal	ra,ffffffffc020ad14 <unlock_sfs_io>
ffffffffc020ab8e:	70e2                	ld	ra,56(sp)
ffffffffc020ab90:	7442                	ld	s0,48(sp)
ffffffffc020ab92:	7902                	ld	s2,32(sp)
ffffffffc020ab94:	69e2                	ld	s3,24(sp)
ffffffffc020ab96:	6a42                	ld	s4,16(sp)
ffffffffc020ab98:	6aa2                	ld	s5,8(sp)
ffffffffc020ab9a:	8526                	mv	a0,s1
ffffffffc020ab9c:	74a2                	ld	s1,40(sp)
ffffffffc020ab9e:	6121                	addi	sp,sp,64
ffffffffc020aba0:	8082                	ret
ffffffffc020aba2:	6428                	ld	a0,72(s0)
ffffffffc020aba4:	8652                	mv	a2,s4
ffffffffc020aba6:	85d6                	mv	a1,s5
ffffffffc020aba8:	954a                	add	a0,a0,s2
ffffffffc020abaa:	6f8000ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc020abae:	642c                	ld	a1,72(s0)
ffffffffc020abb0:	4705                	li	a4,1
ffffffffc020abb2:	4685                	li	a3,1
ffffffffc020abb4:	864e                	mv	a2,s3
ffffffffc020abb6:	8522                	mv	a0,s0
ffffffffc020abb8:	dfdff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020abbc:	84aa                	mv	s1,a0
ffffffffc020abbe:	b7e9                	j	ffffffffc020ab88 <sfs_wbuf+0x3c>
ffffffffc020abc0:	00004697          	auipc	a3,0x4
ffffffffc020abc4:	3e068693          	addi	a3,a3,992 # ffffffffc020efa0 <sfs_node_fileops+0xd0>
ffffffffc020abc8:	00001617          	auipc	a2,0x1
ffffffffc020abcc:	b7060613          	addi	a2,a2,-1168 # ffffffffc020b738 <commands+0x210>
ffffffffc020abd0:	06b00593          	li	a1,107
ffffffffc020abd4:	00004517          	auipc	a0,0x4
ffffffffc020abd8:	3b450513          	addi	a0,a0,948 # ffffffffc020ef88 <sfs_node_fileops+0xb8>
ffffffffc020abdc:	8c3f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020abe0 <sfs_sync_super>:
ffffffffc020abe0:	1101                	addi	sp,sp,-32
ffffffffc020abe2:	ec06                	sd	ra,24(sp)
ffffffffc020abe4:	e822                	sd	s0,16(sp)
ffffffffc020abe6:	e426                	sd	s1,8(sp)
ffffffffc020abe8:	842a                	mv	s0,a0
ffffffffc020abea:	11a000ef          	jal	ra,ffffffffc020ad04 <lock_sfs_io>
ffffffffc020abee:	6428                	ld	a0,72(s0)
ffffffffc020abf0:	6605                	lui	a2,0x1
ffffffffc020abf2:	4581                	li	a1,0
ffffffffc020abf4:	65c000ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc020abf8:	6428                	ld	a0,72(s0)
ffffffffc020abfa:	85a2                	mv	a1,s0
ffffffffc020abfc:	02c00613          	li	a2,44
ffffffffc020ac00:	6a2000ef          	jal	ra,ffffffffc020b2a2 <memcpy>
ffffffffc020ac04:	642c                	ld	a1,72(s0)
ffffffffc020ac06:	4701                	li	a4,0
ffffffffc020ac08:	4685                	li	a3,1
ffffffffc020ac0a:	4601                	li	a2,0
ffffffffc020ac0c:	8522                	mv	a0,s0
ffffffffc020ac0e:	da7ff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020ac12:	84aa                	mv	s1,a0
ffffffffc020ac14:	8522                	mv	a0,s0
ffffffffc020ac16:	0fe000ef          	jal	ra,ffffffffc020ad14 <unlock_sfs_io>
ffffffffc020ac1a:	60e2                	ld	ra,24(sp)
ffffffffc020ac1c:	6442                	ld	s0,16(sp)
ffffffffc020ac1e:	8526                	mv	a0,s1
ffffffffc020ac20:	64a2                	ld	s1,8(sp)
ffffffffc020ac22:	6105                	addi	sp,sp,32
ffffffffc020ac24:	8082                	ret

ffffffffc020ac26 <sfs_sync_freemap>:
ffffffffc020ac26:	7139                	addi	sp,sp,-64
ffffffffc020ac28:	ec4e                	sd	s3,24(sp)
ffffffffc020ac2a:	e852                	sd	s4,16(sp)
ffffffffc020ac2c:	00456983          	lwu	s3,4(a0)
ffffffffc020ac30:	8a2a                	mv	s4,a0
ffffffffc020ac32:	7d08                	ld	a0,56(a0)
ffffffffc020ac34:	67a1                	lui	a5,0x8
ffffffffc020ac36:	17fd                	addi	a5,a5,-1
ffffffffc020ac38:	4581                	li	a1,0
ffffffffc020ac3a:	f822                	sd	s0,48(sp)
ffffffffc020ac3c:	fc06                	sd	ra,56(sp)
ffffffffc020ac3e:	f426                	sd	s1,40(sp)
ffffffffc020ac40:	f04a                	sd	s2,32(sp)
ffffffffc020ac42:	e456                	sd	s5,8(sp)
ffffffffc020ac44:	99be                	add	s3,s3,a5
ffffffffc020ac46:	a24fe0ef          	jal	ra,ffffffffc0208e6a <bitmap_getdata>
ffffffffc020ac4a:	00f9d993          	srli	s3,s3,0xf
ffffffffc020ac4e:	842a                	mv	s0,a0
ffffffffc020ac50:	8552                	mv	a0,s4
ffffffffc020ac52:	0b2000ef          	jal	ra,ffffffffc020ad04 <lock_sfs_io>
ffffffffc020ac56:	04098163          	beqz	s3,ffffffffc020ac98 <sfs_sync_freemap+0x72>
ffffffffc020ac5a:	09b2                	slli	s3,s3,0xc
ffffffffc020ac5c:	99a2                	add	s3,s3,s0
ffffffffc020ac5e:	4909                	li	s2,2
ffffffffc020ac60:	6a85                	lui	s5,0x1
ffffffffc020ac62:	a021                	j	ffffffffc020ac6a <sfs_sync_freemap+0x44>
ffffffffc020ac64:	2905                	addiw	s2,s2,1
ffffffffc020ac66:	02898963          	beq	s3,s0,ffffffffc020ac98 <sfs_sync_freemap+0x72>
ffffffffc020ac6a:	85a2                	mv	a1,s0
ffffffffc020ac6c:	864a                	mv	a2,s2
ffffffffc020ac6e:	4705                	li	a4,1
ffffffffc020ac70:	4685                	li	a3,1
ffffffffc020ac72:	8552                	mv	a0,s4
ffffffffc020ac74:	d41ff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020ac78:	84aa                	mv	s1,a0
ffffffffc020ac7a:	9456                	add	s0,s0,s5
ffffffffc020ac7c:	d565                	beqz	a0,ffffffffc020ac64 <sfs_sync_freemap+0x3e>
ffffffffc020ac7e:	8552                	mv	a0,s4
ffffffffc020ac80:	094000ef          	jal	ra,ffffffffc020ad14 <unlock_sfs_io>
ffffffffc020ac84:	70e2                	ld	ra,56(sp)
ffffffffc020ac86:	7442                	ld	s0,48(sp)
ffffffffc020ac88:	7902                	ld	s2,32(sp)
ffffffffc020ac8a:	69e2                	ld	s3,24(sp)
ffffffffc020ac8c:	6a42                	ld	s4,16(sp)
ffffffffc020ac8e:	6aa2                	ld	s5,8(sp)
ffffffffc020ac90:	8526                	mv	a0,s1
ffffffffc020ac92:	74a2                	ld	s1,40(sp)
ffffffffc020ac94:	6121                	addi	sp,sp,64
ffffffffc020ac96:	8082                	ret
ffffffffc020ac98:	4481                	li	s1,0
ffffffffc020ac9a:	b7d5                	j	ffffffffc020ac7e <sfs_sync_freemap+0x58>

ffffffffc020ac9c <sfs_clear_block>:
ffffffffc020ac9c:	7179                	addi	sp,sp,-48
ffffffffc020ac9e:	f022                	sd	s0,32(sp)
ffffffffc020aca0:	e84a                	sd	s2,16(sp)
ffffffffc020aca2:	e44e                	sd	s3,8(sp)
ffffffffc020aca4:	f406                	sd	ra,40(sp)
ffffffffc020aca6:	89b2                	mv	s3,a2
ffffffffc020aca8:	ec26                	sd	s1,24(sp)
ffffffffc020acaa:	892a                	mv	s2,a0
ffffffffc020acac:	842e                	mv	s0,a1
ffffffffc020acae:	056000ef          	jal	ra,ffffffffc020ad04 <lock_sfs_io>
ffffffffc020acb2:	04893503          	ld	a0,72(s2)
ffffffffc020acb6:	6605                	lui	a2,0x1
ffffffffc020acb8:	4581                	li	a1,0
ffffffffc020acba:	596000ef          	jal	ra,ffffffffc020b250 <memset>
ffffffffc020acbe:	02098d63          	beqz	s3,ffffffffc020acf8 <sfs_clear_block+0x5c>
ffffffffc020acc2:	013409bb          	addw	s3,s0,s3
ffffffffc020acc6:	a019                	j	ffffffffc020accc <sfs_clear_block+0x30>
ffffffffc020acc8:	02898863          	beq	s3,s0,ffffffffc020acf8 <sfs_clear_block+0x5c>
ffffffffc020accc:	04893583          	ld	a1,72(s2)
ffffffffc020acd0:	8622                	mv	a2,s0
ffffffffc020acd2:	4705                	li	a4,1
ffffffffc020acd4:	4685                	li	a3,1
ffffffffc020acd6:	854a                	mv	a0,s2
ffffffffc020acd8:	cddff0ef          	jal	ra,ffffffffc020a9b4 <sfs_rwblock_nolock>
ffffffffc020acdc:	84aa                	mv	s1,a0
ffffffffc020acde:	2405                	addiw	s0,s0,1
ffffffffc020ace0:	d565                	beqz	a0,ffffffffc020acc8 <sfs_clear_block+0x2c>
ffffffffc020ace2:	854a                	mv	a0,s2
ffffffffc020ace4:	030000ef          	jal	ra,ffffffffc020ad14 <unlock_sfs_io>
ffffffffc020ace8:	70a2                	ld	ra,40(sp)
ffffffffc020acea:	7402                	ld	s0,32(sp)
ffffffffc020acec:	6942                	ld	s2,16(sp)
ffffffffc020acee:	69a2                	ld	s3,8(sp)
ffffffffc020acf0:	8526                	mv	a0,s1
ffffffffc020acf2:	64e2                	ld	s1,24(sp)
ffffffffc020acf4:	6145                	addi	sp,sp,48
ffffffffc020acf6:	8082                	ret
ffffffffc020acf8:	4481                	li	s1,0
ffffffffc020acfa:	b7e5                	j	ffffffffc020ace2 <sfs_clear_block+0x46>

ffffffffc020acfc <lock_sfs_fs>:
ffffffffc020acfc:	05050513          	addi	a0,a0,80
ffffffffc020ad00:	fc2f906f          	j	ffffffffc02044c2 <down>

ffffffffc020ad04 <lock_sfs_io>:
ffffffffc020ad04:	06850513          	addi	a0,a0,104
ffffffffc020ad08:	fbaf906f          	j	ffffffffc02044c2 <down>

ffffffffc020ad0c <unlock_sfs_fs>:
ffffffffc020ad0c:	05050513          	addi	a0,a0,80
ffffffffc020ad10:	faef906f          	j	ffffffffc02044be <up>

ffffffffc020ad14 <unlock_sfs_io>:
ffffffffc020ad14:	06850513          	addi	a0,a0,104
ffffffffc020ad18:	fa6f906f          	j	ffffffffc02044be <up>

ffffffffc020ad1c <hash32>:
ffffffffc020ad1c:	9e3707b7          	lui	a5,0x9e370
ffffffffc020ad20:	2785                	addiw	a5,a5,1
ffffffffc020ad22:	02a7853b          	mulw	a0,a5,a0
ffffffffc020ad26:	02000793          	li	a5,32
ffffffffc020ad2a:	9f8d                	subw	a5,a5,a1
ffffffffc020ad2c:	00f5553b          	srlw	a0,a0,a5
ffffffffc020ad30:	8082                	ret

ffffffffc020ad32 <printnum>:
ffffffffc020ad32:	02071893          	slli	a7,a4,0x20
ffffffffc020ad36:	7139                	addi	sp,sp,-64
ffffffffc020ad38:	0208d893          	srli	a7,a7,0x20
ffffffffc020ad3c:	e456                	sd	s5,8(sp)
ffffffffc020ad3e:	0316fab3          	remu	s5,a3,a7
ffffffffc020ad42:	f822                	sd	s0,48(sp)
ffffffffc020ad44:	f426                	sd	s1,40(sp)
ffffffffc020ad46:	f04a                	sd	s2,32(sp)
ffffffffc020ad48:	ec4e                	sd	s3,24(sp)
ffffffffc020ad4a:	fc06                	sd	ra,56(sp)
ffffffffc020ad4c:	e852                	sd	s4,16(sp)
ffffffffc020ad4e:	84aa                	mv	s1,a0
ffffffffc020ad50:	89ae                	mv	s3,a1
ffffffffc020ad52:	8932                	mv	s2,a2
ffffffffc020ad54:	fff7841b          	addiw	s0,a5,-1
ffffffffc020ad58:	2a81                	sext.w	s5,s5
ffffffffc020ad5a:	0516f163          	bgeu	a3,a7,ffffffffc020ad9c <printnum+0x6a>
ffffffffc020ad5e:	8a42                	mv	s4,a6
ffffffffc020ad60:	00805863          	blez	s0,ffffffffc020ad70 <printnum+0x3e>
ffffffffc020ad64:	347d                	addiw	s0,s0,-1
ffffffffc020ad66:	864e                	mv	a2,s3
ffffffffc020ad68:	85ca                	mv	a1,s2
ffffffffc020ad6a:	8552                	mv	a0,s4
ffffffffc020ad6c:	9482                	jalr	s1
ffffffffc020ad6e:	f87d                	bnez	s0,ffffffffc020ad64 <printnum+0x32>
ffffffffc020ad70:	1a82                	slli	s5,s5,0x20
ffffffffc020ad72:	00004797          	auipc	a5,0x4
ffffffffc020ad76:	27678793          	addi	a5,a5,630 # ffffffffc020efe8 <sfs_node_fileops+0x118>
ffffffffc020ad7a:	020ada93          	srli	s5,s5,0x20
ffffffffc020ad7e:	9abe                	add	s5,s5,a5
ffffffffc020ad80:	7442                	ld	s0,48(sp)
ffffffffc020ad82:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020ad86:	70e2                	ld	ra,56(sp)
ffffffffc020ad88:	6a42                	ld	s4,16(sp)
ffffffffc020ad8a:	6aa2                	ld	s5,8(sp)
ffffffffc020ad8c:	864e                	mv	a2,s3
ffffffffc020ad8e:	85ca                	mv	a1,s2
ffffffffc020ad90:	69e2                	ld	s3,24(sp)
ffffffffc020ad92:	7902                	ld	s2,32(sp)
ffffffffc020ad94:	87a6                	mv	a5,s1
ffffffffc020ad96:	74a2                	ld	s1,40(sp)
ffffffffc020ad98:	6121                	addi	sp,sp,64
ffffffffc020ad9a:	8782                	jr	a5
ffffffffc020ad9c:	0316d6b3          	divu	a3,a3,a7
ffffffffc020ada0:	87a2                	mv	a5,s0
ffffffffc020ada2:	f91ff0ef          	jal	ra,ffffffffc020ad32 <printnum>
ffffffffc020ada6:	b7e9                	j	ffffffffc020ad70 <printnum+0x3e>

ffffffffc020ada8 <sprintputch>:
ffffffffc020ada8:	499c                	lw	a5,16(a1)
ffffffffc020adaa:	6198                	ld	a4,0(a1)
ffffffffc020adac:	6594                	ld	a3,8(a1)
ffffffffc020adae:	2785                	addiw	a5,a5,1
ffffffffc020adb0:	c99c                	sw	a5,16(a1)
ffffffffc020adb2:	00d77763          	bgeu	a4,a3,ffffffffc020adc0 <sprintputch+0x18>
ffffffffc020adb6:	00170793          	addi	a5,a4,1
ffffffffc020adba:	e19c                	sd	a5,0(a1)
ffffffffc020adbc:	00a70023          	sb	a0,0(a4)
ffffffffc020adc0:	8082                	ret

ffffffffc020adc2 <vprintfmt>:
ffffffffc020adc2:	7119                	addi	sp,sp,-128
ffffffffc020adc4:	f4a6                	sd	s1,104(sp)
ffffffffc020adc6:	f0ca                	sd	s2,96(sp)
ffffffffc020adc8:	ecce                	sd	s3,88(sp)
ffffffffc020adca:	e8d2                	sd	s4,80(sp)
ffffffffc020adcc:	e4d6                	sd	s5,72(sp)
ffffffffc020adce:	e0da                	sd	s6,64(sp)
ffffffffc020add0:	fc5e                	sd	s7,56(sp)
ffffffffc020add2:	ec6e                	sd	s11,24(sp)
ffffffffc020add4:	fc86                	sd	ra,120(sp)
ffffffffc020add6:	f8a2                	sd	s0,112(sp)
ffffffffc020add8:	f862                	sd	s8,48(sp)
ffffffffc020adda:	f466                	sd	s9,40(sp)
ffffffffc020addc:	f06a                	sd	s10,32(sp)
ffffffffc020adde:	89aa                	mv	s3,a0
ffffffffc020ade0:	892e                	mv	s2,a1
ffffffffc020ade2:	84b2                	mv	s1,a2
ffffffffc020ade4:	8db6                	mv	s11,a3
ffffffffc020ade6:	8aba                	mv	s5,a4
ffffffffc020ade8:	02500a13          	li	s4,37
ffffffffc020adec:	5bfd                	li	s7,-1
ffffffffc020adee:	00004b17          	auipc	s6,0x4
ffffffffc020adf2:	226b0b13          	addi	s6,s6,550 # ffffffffc020f014 <sfs_node_fileops+0x144>
ffffffffc020adf6:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020adfa:	001d8413          	addi	s0,s11,1
ffffffffc020adfe:	01450b63          	beq	a0,s4,ffffffffc020ae14 <vprintfmt+0x52>
ffffffffc020ae02:	c129                	beqz	a0,ffffffffc020ae44 <vprintfmt+0x82>
ffffffffc020ae04:	864a                	mv	a2,s2
ffffffffc020ae06:	85a6                	mv	a1,s1
ffffffffc020ae08:	0405                	addi	s0,s0,1
ffffffffc020ae0a:	9982                	jalr	s3
ffffffffc020ae0c:	fff44503          	lbu	a0,-1(s0)
ffffffffc020ae10:	ff4519e3          	bne	a0,s4,ffffffffc020ae02 <vprintfmt+0x40>
ffffffffc020ae14:	00044583          	lbu	a1,0(s0)
ffffffffc020ae18:	02000813          	li	a6,32
ffffffffc020ae1c:	4d01                	li	s10,0
ffffffffc020ae1e:	4301                	li	t1,0
ffffffffc020ae20:	5cfd                	li	s9,-1
ffffffffc020ae22:	5c7d                	li	s8,-1
ffffffffc020ae24:	05500513          	li	a0,85
ffffffffc020ae28:	48a5                	li	a7,9
ffffffffc020ae2a:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020ae2e:	0ff67613          	zext.b	a2,a2
ffffffffc020ae32:	00140d93          	addi	s11,s0,1
ffffffffc020ae36:	04c56263          	bltu	a0,a2,ffffffffc020ae7a <vprintfmt+0xb8>
ffffffffc020ae3a:	060a                	slli	a2,a2,0x2
ffffffffc020ae3c:	965a                	add	a2,a2,s6
ffffffffc020ae3e:	4214                	lw	a3,0(a2)
ffffffffc020ae40:	96da                	add	a3,a3,s6
ffffffffc020ae42:	8682                	jr	a3
ffffffffc020ae44:	70e6                	ld	ra,120(sp)
ffffffffc020ae46:	7446                	ld	s0,112(sp)
ffffffffc020ae48:	74a6                	ld	s1,104(sp)
ffffffffc020ae4a:	7906                	ld	s2,96(sp)
ffffffffc020ae4c:	69e6                	ld	s3,88(sp)
ffffffffc020ae4e:	6a46                	ld	s4,80(sp)
ffffffffc020ae50:	6aa6                	ld	s5,72(sp)
ffffffffc020ae52:	6b06                	ld	s6,64(sp)
ffffffffc020ae54:	7be2                	ld	s7,56(sp)
ffffffffc020ae56:	7c42                	ld	s8,48(sp)
ffffffffc020ae58:	7ca2                	ld	s9,40(sp)
ffffffffc020ae5a:	7d02                	ld	s10,32(sp)
ffffffffc020ae5c:	6de2                	ld	s11,24(sp)
ffffffffc020ae5e:	6109                	addi	sp,sp,128
ffffffffc020ae60:	8082                	ret
ffffffffc020ae62:	882e                	mv	a6,a1
ffffffffc020ae64:	00144583          	lbu	a1,1(s0)
ffffffffc020ae68:	846e                	mv	s0,s11
ffffffffc020ae6a:	00140d93          	addi	s11,s0,1
ffffffffc020ae6e:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020ae72:	0ff67613          	zext.b	a2,a2
ffffffffc020ae76:	fcc572e3          	bgeu	a0,a2,ffffffffc020ae3a <vprintfmt+0x78>
ffffffffc020ae7a:	864a                	mv	a2,s2
ffffffffc020ae7c:	85a6                	mv	a1,s1
ffffffffc020ae7e:	02500513          	li	a0,37
ffffffffc020ae82:	9982                	jalr	s3
ffffffffc020ae84:	fff44783          	lbu	a5,-1(s0)
ffffffffc020ae88:	8da2                	mv	s11,s0
ffffffffc020ae8a:	f74786e3          	beq	a5,s4,ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020ae8e:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020ae92:	1dfd                	addi	s11,s11,-1
ffffffffc020ae94:	ff479de3          	bne	a5,s4,ffffffffc020ae8e <vprintfmt+0xcc>
ffffffffc020ae98:	bfb9                	j	ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020ae9a:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020ae9e:	00144583          	lbu	a1,1(s0)
ffffffffc020aea2:	846e                	mv	s0,s11
ffffffffc020aea4:	fd05869b          	addiw	a3,a1,-48
ffffffffc020aea8:	0005861b          	sext.w	a2,a1
ffffffffc020aeac:	02d8e463          	bltu	a7,a3,ffffffffc020aed4 <vprintfmt+0x112>
ffffffffc020aeb0:	00144583          	lbu	a1,1(s0)
ffffffffc020aeb4:	002c969b          	slliw	a3,s9,0x2
ffffffffc020aeb8:	0196873b          	addw	a4,a3,s9
ffffffffc020aebc:	0017171b          	slliw	a4,a4,0x1
ffffffffc020aec0:	9f31                	addw	a4,a4,a2
ffffffffc020aec2:	fd05869b          	addiw	a3,a1,-48
ffffffffc020aec6:	0405                	addi	s0,s0,1
ffffffffc020aec8:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020aecc:	0005861b          	sext.w	a2,a1
ffffffffc020aed0:	fed8f0e3          	bgeu	a7,a3,ffffffffc020aeb0 <vprintfmt+0xee>
ffffffffc020aed4:	f40c5be3          	bgez	s8,ffffffffc020ae2a <vprintfmt+0x68>
ffffffffc020aed8:	8c66                	mv	s8,s9
ffffffffc020aeda:	5cfd                	li	s9,-1
ffffffffc020aedc:	b7b9                	j	ffffffffc020ae2a <vprintfmt+0x68>
ffffffffc020aede:	fffc4693          	not	a3,s8
ffffffffc020aee2:	96fd                	srai	a3,a3,0x3f
ffffffffc020aee4:	00dc77b3          	and	a5,s8,a3
ffffffffc020aee8:	00144583          	lbu	a1,1(s0)
ffffffffc020aeec:	00078c1b          	sext.w	s8,a5
ffffffffc020aef0:	846e                	mv	s0,s11
ffffffffc020aef2:	bf25                	j	ffffffffc020ae2a <vprintfmt+0x68>
ffffffffc020aef4:	000aac83          	lw	s9,0(s5)
ffffffffc020aef8:	00144583          	lbu	a1,1(s0)
ffffffffc020aefc:	0aa1                	addi	s5,s5,8
ffffffffc020aefe:	846e                	mv	s0,s11
ffffffffc020af00:	bfd1                	j	ffffffffc020aed4 <vprintfmt+0x112>
ffffffffc020af02:	4705                	li	a4,1
ffffffffc020af04:	008a8613          	addi	a2,s5,8
ffffffffc020af08:	00674463          	blt	a4,t1,ffffffffc020af10 <vprintfmt+0x14e>
ffffffffc020af0c:	1c030c63          	beqz	t1,ffffffffc020b0e4 <vprintfmt+0x322>
ffffffffc020af10:	000ab683          	ld	a3,0(s5)
ffffffffc020af14:	4741                	li	a4,16
ffffffffc020af16:	8ab2                	mv	s5,a2
ffffffffc020af18:	2801                	sext.w	a6,a6
ffffffffc020af1a:	87e2                	mv	a5,s8
ffffffffc020af1c:	8626                	mv	a2,s1
ffffffffc020af1e:	85ca                	mv	a1,s2
ffffffffc020af20:	854e                	mv	a0,s3
ffffffffc020af22:	e11ff0ef          	jal	ra,ffffffffc020ad32 <printnum>
ffffffffc020af26:	bdc1                	j	ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020af28:	000aa503          	lw	a0,0(s5)
ffffffffc020af2c:	864a                	mv	a2,s2
ffffffffc020af2e:	85a6                	mv	a1,s1
ffffffffc020af30:	0aa1                	addi	s5,s5,8
ffffffffc020af32:	9982                	jalr	s3
ffffffffc020af34:	b5c9                	j	ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020af36:	4705                	li	a4,1
ffffffffc020af38:	008a8613          	addi	a2,s5,8
ffffffffc020af3c:	00674463          	blt	a4,t1,ffffffffc020af44 <vprintfmt+0x182>
ffffffffc020af40:	18030d63          	beqz	t1,ffffffffc020b0da <vprintfmt+0x318>
ffffffffc020af44:	000ab683          	ld	a3,0(s5)
ffffffffc020af48:	4729                	li	a4,10
ffffffffc020af4a:	8ab2                	mv	s5,a2
ffffffffc020af4c:	b7f1                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020af4e:	00144583          	lbu	a1,1(s0)
ffffffffc020af52:	4d05                	li	s10,1
ffffffffc020af54:	846e                	mv	s0,s11
ffffffffc020af56:	bdd1                	j	ffffffffc020ae2a <vprintfmt+0x68>
ffffffffc020af58:	864a                	mv	a2,s2
ffffffffc020af5a:	85a6                	mv	a1,s1
ffffffffc020af5c:	02500513          	li	a0,37
ffffffffc020af60:	9982                	jalr	s3
ffffffffc020af62:	bd51                	j	ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020af64:	00144583          	lbu	a1,1(s0)
ffffffffc020af68:	2305                	addiw	t1,t1,1
ffffffffc020af6a:	846e                	mv	s0,s11
ffffffffc020af6c:	bd7d                	j	ffffffffc020ae2a <vprintfmt+0x68>
ffffffffc020af6e:	4705                	li	a4,1
ffffffffc020af70:	008a8613          	addi	a2,s5,8
ffffffffc020af74:	00674463          	blt	a4,t1,ffffffffc020af7c <vprintfmt+0x1ba>
ffffffffc020af78:	14030c63          	beqz	t1,ffffffffc020b0d0 <vprintfmt+0x30e>
ffffffffc020af7c:	000ab683          	ld	a3,0(s5)
ffffffffc020af80:	4721                	li	a4,8
ffffffffc020af82:	8ab2                	mv	s5,a2
ffffffffc020af84:	bf51                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020af86:	03000513          	li	a0,48
ffffffffc020af8a:	864a                	mv	a2,s2
ffffffffc020af8c:	85a6                	mv	a1,s1
ffffffffc020af8e:	e042                	sd	a6,0(sp)
ffffffffc020af90:	9982                	jalr	s3
ffffffffc020af92:	864a                	mv	a2,s2
ffffffffc020af94:	85a6                	mv	a1,s1
ffffffffc020af96:	07800513          	li	a0,120
ffffffffc020af9a:	9982                	jalr	s3
ffffffffc020af9c:	0aa1                	addi	s5,s5,8
ffffffffc020af9e:	6802                	ld	a6,0(sp)
ffffffffc020afa0:	4741                	li	a4,16
ffffffffc020afa2:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020afa6:	bf8d                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020afa8:	000ab403          	ld	s0,0(s5)
ffffffffc020afac:	008a8793          	addi	a5,s5,8
ffffffffc020afb0:	e03e                	sd	a5,0(sp)
ffffffffc020afb2:	14040c63          	beqz	s0,ffffffffc020b10a <vprintfmt+0x348>
ffffffffc020afb6:	11805063          	blez	s8,ffffffffc020b0b6 <vprintfmt+0x2f4>
ffffffffc020afba:	02d00693          	li	a3,45
ffffffffc020afbe:	0cd81963          	bne	a6,a3,ffffffffc020b090 <vprintfmt+0x2ce>
ffffffffc020afc2:	00044683          	lbu	a3,0(s0)
ffffffffc020afc6:	0006851b          	sext.w	a0,a3
ffffffffc020afca:	ce8d                	beqz	a3,ffffffffc020b004 <vprintfmt+0x242>
ffffffffc020afcc:	00140a93          	addi	s5,s0,1
ffffffffc020afd0:	05e00413          	li	s0,94
ffffffffc020afd4:	000cc563          	bltz	s9,ffffffffc020afde <vprintfmt+0x21c>
ffffffffc020afd8:	3cfd                	addiw	s9,s9,-1
ffffffffc020afda:	037c8363          	beq	s9,s7,ffffffffc020b000 <vprintfmt+0x23e>
ffffffffc020afde:	864a                	mv	a2,s2
ffffffffc020afe0:	85a6                	mv	a1,s1
ffffffffc020afe2:	100d0663          	beqz	s10,ffffffffc020b0ee <vprintfmt+0x32c>
ffffffffc020afe6:	3681                	addiw	a3,a3,-32
ffffffffc020afe8:	10d47363          	bgeu	s0,a3,ffffffffc020b0ee <vprintfmt+0x32c>
ffffffffc020afec:	03f00513          	li	a0,63
ffffffffc020aff0:	9982                	jalr	s3
ffffffffc020aff2:	000ac683          	lbu	a3,0(s5)
ffffffffc020aff6:	3c7d                	addiw	s8,s8,-1
ffffffffc020aff8:	0a85                	addi	s5,s5,1
ffffffffc020affa:	0006851b          	sext.w	a0,a3
ffffffffc020affe:	faf9                	bnez	a3,ffffffffc020afd4 <vprintfmt+0x212>
ffffffffc020b000:	01805a63          	blez	s8,ffffffffc020b014 <vprintfmt+0x252>
ffffffffc020b004:	3c7d                	addiw	s8,s8,-1
ffffffffc020b006:	864a                	mv	a2,s2
ffffffffc020b008:	85a6                	mv	a1,s1
ffffffffc020b00a:	02000513          	li	a0,32
ffffffffc020b00e:	9982                	jalr	s3
ffffffffc020b010:	fe0c1ae3          	bnez	s8,ffffffffc020b004 <vprintfmt+0x242>
ffffffffc020b014:	6a82                	ld	s5,0(sp)
ffffffffc020b016:	b3c5                	j	ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020b018:	4705                	li	a4,1
ffffffffc020b01a:	008a8d13          	addi	s10,s5,8
ffffffffc020b01e:	00674463          	blt	a4,t1,ffffffffc020b026 <vprintfmt+0x264>
ffffffffc020b022:	0a030463          	beqz	t1,ffffffffc020b0ca <vprintfmt+0x308>
ffffffffc020b026:	000ab403          	ld	s0,0(s5)
ffffffffc020b02a:	0c044463          	bltz	s0,ffffffffc020b0f2 <vprintfmt+0x330>
ffffffffc020b02e:	86a2                	mv	a3,s0
ffffffffc020b030:	8aea                	mv	s5,s10
ffffffffc020b032:	4729                	li	a4,10
ffffffffc020b034:	b5d5                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020b036:	000aa783          	lw	a5,0(s5)
ffffffffc020b03a:	46e1                	li	a3,24
ffffffffc020b03c:	0aa1                	addi	s5,s5,8
ffffffffc020b03e:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b042:	8fb9                	xor	a5,a5,a4
ffffffffc020b044:	40e7873b          	subw	a4,a5,a4
ffffffffc020b048:	02e6c663          	blt	a3,a4,ffffffffc020b074 <vprintfmt+0x2b2>
ffffffffc020b04c:	00371793          	slli	a5,a4,0x3
ffffffffc020b050:	00004697          	auipc	a3,0x4
ffffffffc020b054:	2f868693          	addi	a3,a3,760 # ffffffffc020f348 <error_string>
ffffffffc020b058:	97b6                	add	a5,a5,a3
ffffffffc020b05a:	639c                	ld	a5,0(a5)
ffffffffc020b05c:	cf81                	beqz	a5,ffffffffc020b074 <vprintfmt+0x2b2>
ffffffffc020b05e:	873e                	mv	a4,a5
ffffffffc020b060:	00000697          	auipc	a3,0x0
ffffffffc020b064:	28868693          	addi	a3,a3,648 # ffffffffc020b2e8 <etext+0x2e>
ffffffffc020b068:	8626                	mv	a2,s1
ffffffffc020b06a:	85ca                	mv	a1,s2
ffffffffc020b06c:	854e                	mv	a0,s3
ffffffffc020b06e:	0d4000ef          	jal	ra,ffffffffc020b142 <printfmt>
ffffffffc020b072:	b351                	j	ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020b074:	00004697          	auipc	a3,0x4
ffffffffc020b078:	f9468693          	addi	a3,a3,-108 # ffffffffc020f008 <sfs_node_fileops+0x138>
ffffffffc020b07c:	8626                	mv	a2,s1
ffffffffc020b07e:	85ca                	mv	a1,s2
ffffffffc020b080:	854e                	mv	a0,s3
ffffffffc020b082:	0c0000ef          	jal	ra,ffffffffc020b142 <printfmt>
ffffffffc020b086:	bb85                	j	ffffffffc020adf6 <vprintfmt+0x34>
ffffffffc020b088:	00004417          	auipc	s0,0x4
ffffffffc020b08c:	f7840413          	addi	s0,s0,-136 # ffffffffc020f000 <sfs_node_fileops+0x130>
ffffffffc020b090:	85e6                	mv	a1,s9
ffffffffc020b092:	8522                	mv	a0,s0
ffffffffc020b094:	e442                	sd	a6,8(sp)
ffffffffc020b096:	132000ef          	jal	ra,ffffffffc020b1c8 <strnlen>
ffffffffc020b09a:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b09e:	01805c63          	blez	s8,ffffffffc020b0b6 <vprintfmt+0x2f4>
ffffffffc020b0a2:	6822                	ld	a6,8(sp)
ffffffffc020b0a4:	00080a9b          	sext.w	s5,a6
ffffffffc020b0a8:	3c7d                	addiw	s8,s8,-1
ffffffffc020b0aa:	864a                	mv	a2,s2
ffffffffc020b0ac:	85a6                	mv	a1,s1
ffffffffc020b0ae:	8556                	mv	a0,s5
ffffffffc020b0b0:	9982                	jalr	s3
ffffffffc020b0b2:	fe0c1be3          	bnez	s8,ffffffffc020b0a8 <vprintfmt+0x2e6>
ffffffffc020b0b6:	00044683          	lbu	a3,0(s0)
ffffffffc020b0ba:	00140a93          	addi	s5,s0,1
ffffffffc020b0be:	0006851b          	sext.w	a0,a3
ffffffffc020b0c2:	daa9                	beqz	a3,ffffffffc020b014 <vprintfmt+0x252>
ffffffffc020b0c4:	05e00413          	li	s0,94
ffffffffc020b0c8:	b731                	j	ffffffffc020afd4 <vprintfmt+0x212>
ffffffffc020b0ca:	000aa403          	lw	s0,0(s5)
ffffffffc020b0ce:	bfb1                	j	ffffffffc020b02a <vprintfmt+0x268>
ffffffffc020b0d0:	000ae683          	lwu	a3,0(s5)
ffffffffc020b0d4:	4721                	li	a4,8
ffffffffc020b0d6:	8ab2                	mv	s5,a2
ffffffffc020b0d8:	b581                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020b0da:	000ae683          	lwu	a3,0(s5)
ffffffffc020b0de:	4729                	li	a4,10
ffffffffc020b0e0:	8ab2                	mv	s5,a2
ffffffffc020b0e2:	bd1d                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020b0e4:	000ae683          	lwu	a3,0(s5)
ffffffffc020b0e8:	4741                	li	a4,16
ffffffffc020b0ea:	8ab2                	mv	s5,a2
ffffffffc020b0ec:	b535                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020b0ee:	9982                	jalr	s3
ffffffffc020b0f0:	b709                	j	ffffffffc020aff2 <vprintfmt+0x230>
ffffffffc020b0f2:	864a                	mv	a2,s2
ffffffffc020b0f4:	85a6                	mv	a1,s1
ffffffffc020b0f6:	02d00513          	li	a0,45
ffffffffc020b0fa:	e042                	sd	a6,0(sp)
ffffffffc020b0fc:	9982                	jalr	s3
ffffffffc020b0fe:	6802                	ld	a6,0(sp)
ffffffffc020b100:	8aea                	mv	s5,s10
ffffffffc020b102:	408006b3          	neg	a3,s0
ffffffffc020b106:	4729                	li	a4,10
ffffffffc020b108:	bd01                	j	ffffffffc020af18 <vprintfmt+0x156>
ffffffffc020b10a:	03805163          	blez	s8,ffffffffc020b12c <vprintfmt+0x36a>
ffffffffc020b10e:	02d00693          	li	a3,45
ffffffffc020b112:	f6d81be3          	bne	a6,a3,ffffffffc020b088 <vprintfmt+0x2c6>
ffffffffc020b116:	00004417          	auipc	s0,0x4
ffffffffc020b11a:	eea40413          	addi	s0,s0,-278 # ffffffffc020f000 <sfs_node_fileops+0x130>
ffffffffc020b11e:	02800693          	li	a3,40
ffffffffc020b122:	02800513          	li	a0,40
ffffffffc020b126:	00140a93          	addi	s5,s0,1
ffffffffc020b12a:	b55d                	j	ffffffffc020afd0 <vprintfmt+0x20e>
ffffffffc020b12c:	00004a97          	auipc	s5,0x4
ffffffffc020b130:	ed5a8a93          	addi	s5,s5,-299 # ffffffffc020f001 <sfs_node_fileops+0x131>
ffffffffc020b134:	02800513          	li	a0,40
ffffffffc020b138:	02800693          	li	a3,40
ffffffffc020b13c:	05e00413          	li	s0,94
ffffffffc020b140:	bd51                	j	ffffffffc020afd4 <vprintfmt+0x212>

ffffffffc020b142 <printfmt>:
ffffffffc020b142:	7139                	addi	sp,sp,-64
ffffffffc020b144:	02010313          	addi	t1,sp,32
ffffffffc020b148:	f03a                	sd	a4,32(sp)
ffffffffc020b14a:	871a                	mv	a4,t1
ffffffffc020b14c:	ec06                	sd	ra,24(sp)
ffffffffc020b14e:	f43e                	sd	a5,40(sp)
ffffffffc020b150:	f842                	sd	a6,48(sp)
ffffffffc020b152:	fc46                	sd	a7,56(sp)
ffffffffc020b154:	e41a                	sd	t1,8(sp)
ffffffffc020b156:	c6dff0ef          	jal	ra,ffffffffc020adc2 <vprintfmt>
ffffffffc020b15a:	60e2                	ld	ra,24(sp)
ffffffffc020b15c:	6121                	addi	sp,sp,64
ffffffffc020b15e:	8082                	ret

ffffffffc020b160 <snprintf>:
ffffffffc020b160:	711d                	addi	sp,sp,-96
ffffffffc020b162:	15fd                	addi	a1,a1,-1
ffffffffc020b164:	03810313          	addi	t1,sp,56
ffffffffc020b168:	95aa                	add	a1,a1,a0
ffffffffc020b16a:	f406                	sd	ra,40(sp)
ffffffffc020b16c:	fc36                	sd	a3,56(sp)
ffffffffc020b16e:	e0ba                	sd	a4,64(sp)
ffffffffc020b170:	e4be                	sd	a5,72(sp)
ffffffffc020b172:	e8c2                	sd	a6,80(sp)
ffffffffc020b174:	ecc6                	sd	a7,88(sp)
ffffffffc020b176:	e01a                	sd	t1,0(sp)
ffffffffc020b178:	e42a                	sd	a0,8(sp)
ffffffffc020b17a:	e82e                	sd	a1,16(sp)
ffffffffc020b17c:	cc02                	sw	zero,24(sp)
ffffffffc020b17e:	c515                	beqz	a0,ffffffffc020b1aa <snprintf+0x4a>
ffffffffc020b180:	02a5e563          	bltu	a1,a0,ffffffffc020b1aa <snprintf+0x4a>
ffffffffc020b184:	75dd                	lui	a1,0xffff7
ffffffffc020b186:	86b2                	mv	a3,a2
ffffffffc020b188:	00000517          	auipc	a0,0x0
ffffffffc020b18c:	c2050513          	addi	a0,a0,-992 # ffffffffc020ada8 <sprintputch>
ffffffffc020b190:	871a                	mv	a4,t1
ffffffffc020b192:	0030                	addi	a2,sp,8
ffffffffc020b194:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b198:	c2bff0ef          	jal	ra,ffffffffc020adc2 <vprintfmt>
ffffffffc020b19c:	67a2                	ld	a5,8(sp)
ffffffffc020b19e:	00078023          	sb	zero,0(a5)
ffffffffc020b1a2:	4562                	lw	a0,24(sp)
ffffffffc020b1a4:	70a2                	ld	ra,40(sp)
ffffffffc020b1a6:	6125                	addi	sp,sp,96
ffffffffc020b1a8:	8082                	ret
ffffffffc020b1aa:	5575                	li	a0,-3
ffffffffc020b1ac:	bfe5                	j	ffffffffc020b1a4 <snprintf+0x44>

ffffffffc020b1ae <strlen>:
ffffffffc020b1ae:	00054783          	lbu	a5,0(a0)
ffffffffc020b1b2:	872a                	mv	a4,a0
ffffffffc020b1b4:	4501                	li	a0,0
ffffffffc020b1b6:	cb81                	beqz	a5,ffffffffc020b1c6 <strlen+0x18>
ffffffffc020b1b8:	0505                	addi	a0,a0,1
ffffffffc020b1ba:	00a707b3          	add	a5,a4,a0
ffffffffc020b1be:	0007c783          	lbu	a5,0(a5)
ffffffffc020b1c2:	fbfd                	bnez	a5,ffffffffc020b1b8 <strlen+0xa>
ffffffffc020b1c4:	8082                	ret
ffffffffc020b1c6:	8082                	ret

ffffffffc020b1c8 <strnlen>:
ffffffffc020b1c8:	4781                	li	a5,0
ffffffffc020b1ca:	e589                	bnez	a1,ffffffffc020b1d4 <strnlen+0xc>
ffffffffc020b1cc:	a811                	j	ffffffffc020b1e0 <strnlen+0x18>
ffffffffc020b1ce:	0785                	addi	a5,a5,1
ffffffffc020b1d0:	00f58863          	beq	a1,a5,ffffffffc020b1e0 <strnlen+0x18>
ffffffffc020b1d4:	00f50733          	add	a4,a0,a5
ffffffffc020b1d8:	00074703          	lbu	a4,0(a4)
ffffffffc020b1dc:	fb6d                	bnez	a4,ffffffffc020b1ce <strnlen+0x6>
ffffffffc020b1de:	85be                	mv	a1,a5
ffffffffc020b1e0:	852e                	mv	a0,a1
ffffffffc020b1e2:	8082                	ret

ffffffffc020b1e4 <strcpy>:
ffffffffc020b1e4:	87aa                	mv	a5,a0
ffffffffc020b1e6:	0005c703          	lbu	a4,0(a1)
ffffffffc020b1ea:	0785                	addi	a5,a5,1
ffffffffc020b1ec:	0585                	addi	a1,a1,1
ffffffffc020b1ee:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b1f2:	fb75                	bnez	a4,ffffffffc020b1e6 <strcpy+0x2>
ffffffffc020b1f4:	8082                	ret

ffffffffc020b1f6 <strcmp>:
ffffffffc020b1f6:	00054783          	lbu	a5,0(a0)
ffffffffc020b1fa:	0005c703          	lbu	a4,0(a1)
ffffffffc020b1fe:	cb89                	beqz	a5,ffffffffc020b210 <strcmp+0x1a>
ffffffffc020b200:	0505                	addi	a0,a0,1
ffffffffc020b202:	0585                	addi	a1,a1,1
ffffffffc020b204:	fee789e3          	beq	a5,a4,ffffffffc020b1f6 <strcmp>
ffffffffc020b208:	0007851b          	sext.w	a0,a5
ffffffffc020b20c:	9d19                	subw	a0,a0,a4
ffffffffc020b20e:	8082                	ret
ffffffffc020b210:	4501                	li	a0,0
ffffffffc020b212:	bfed                	j	ffffffffc020b20c <strcmp+0x16>

ffffffffc020b214 <strncmp>:
ffffffffc020b214:	c20d                	beqz	a2,ffffffffc020b236 <strncmp+0x22>
ffffffffc020b216:	962e                	add	a2,a2,a1
ffffffffc020b218:	a031                	j	ffffffffc020b224 <strncmp+0x10>
ffffffffc020b21a:	0505                	addi	a0,a0,1
ffffffffc020b21c:	00e79a63          	bne	a5,a4,ffffffffc020b230 <strncmp+0x1c>
ffffffffc020b220:	00b60b63          	beq	a2,a1,ffffffffc020b236 <strncmp+0x22>
ffffffffc020b224:	00054783          	lbu	a5,0(a0)
ffffffffc020b228:	0585                	addi	a1,a1,1
ffffffffc020b22a:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b22e:	f7f5                	bnez	a5,ffffffffc020b21a <strncmp+0x6>
ffffffffc020b230:	40e7853b          	subw	a0,a5,a4
ffffffffc020b234:	8082                	ret
ffffffffc020b236:	4501                	li	a0,0
ffffffffc020b238:	8082                	ret

ffffffffc020b23a <strchr>:
ffffffffc020b23a:	00054783          	lbu	a5,0(a0)
ffffffffc020b23e:	c799                	beqz	a5,ffffffffc020b24c <strchr+0x12>
ffffffffc020b240:	00f58763          	beq	a1,a5,ffffffffc020b24e <strchr+0x14>
ffffffffc020b244:	00154783          	lbu	a5,1(a0)
ffffffffc020b248:	0505                	addi	a0,a0,1
ffffffffc020b24a:	fbfd                	bnez	a5,ffffffffc020b240 <strchr+0x6>
ffffffffc020b24c:	4501                	li	a0,0
ffffffffc020b24e:	8082                	ret

ffffffffc020b250 <memset>:
ffffffffc020b250:	ca01                	beqz	a2,ffffffffc020b260 <memset+0x10>
ffffffffc020b252:	962a                	add	a2,a2,a0
ffffffffc020b254:	87aa                	mv	a5,a0
ffffffffc020b256:	0785                	addi	a5,a5,1
ffffffffc020b258:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b25c:	fec79de3          	bne	a5,a2,ffffffffc020b256 <memset+0x6>
ffffffffc020b260:	8082                	ret

ffffffffc020b262 <memmove>:
ffffffffc020b262:	02a5f263          	bgeu	a1,a0,ffffffffc020b286 <memmove+0x24>
ffffffffc020b266:	00c587b3          	add	a5,a1,a2
ffffffffc020b26a:	00f57e63          	bgeu	a0,a5,ffffffffc020b286 <memmove+0x24>
ffffffffc020b26e:	00c50733          	add	a4,a0,a2
ffffffffc020b272:	c615                	beqz	a2,ffffffffc020b29e <memmove+0x3c>
ffffffffc020b274:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b278:	17fd                	addi	a5,a5,-1
ffffffffc020b27a:	177d                	addi	a4,a4,-1
ffffffffc020b27c:	00d70023          	sb	a3,0(a4)
ffffffffc020b280:	fef59ae3          	bne	a1,a5,ffffffffc020b274 <memmove+0x12>
ffffffffc020b284:	8082                	ret
ffffffffc020b286:	00c586b3          	add	a3,a1,a2
ffffffffc020b28a:	87aa                	mv	a5,a0
ffffffffc020b28c:	ca11                	beqz	a2,ffffffffc020b2a0 <memmove+0x3e>
ffffffffc020b28e:	0005c703          	lbu	a4,0(a1)
ffffffffc020b292:	0585                	addi	a1,a1,1
ffffffffc020b294:	0785                	addi	a5,a5,1
ffffffffc020b296:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b29a:	fed59ae3          	bne	a1,a3,ffffffffc020b28e <memmove+0x2c>
ffffffffc020b29e:	8082                	ret
ffffffffc020b2a0:	8082                	ret

ffffffffc020b2a2 <memcpy>:
ffffffffc020b2a2:	ca19                	beqz	a2,ffffffffc020b2b8 <memcpy+0x16>
ffffffffc020b2a4:	962e                	add	a2,a2,a1
ffffffffc020b2a6:	87aa                	mv	a5,a0
ffffffffc020b2a8:	0005c703          	lbu	a4,0(a1)
ffffffffc020b2ac:	0585                	addi	a1,a1,1
ffffffffc020b2ae:	0785                	addi	a5,a5,1
ffffffffc020b2b0:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b2b4:	fec59ae3          	bne	a1,a2,ffffffffc020b2a8 <memcpy+0x6>
ffffffffc020b2b8:	8082                	ret
