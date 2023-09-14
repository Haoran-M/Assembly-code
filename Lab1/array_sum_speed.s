	.file	"array_sum_speed.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Must give integer on command line for array size."
.LC1:
	.string	"Can't allocate memory."
.LC2:
	.string	"calculated %d in %g cycles\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4262:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	cmpl	$1, -68(%rbp)
	jg	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$2, %eax
	jmp	.L3
.L2:
	movq	-80(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	cltq
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L4
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L3
.L4:
	movl	$0, -52(%rbp)
	jmp	.L5
.L6:
	call	rand@PLT
	movl	%eax, %ecx
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movslq	%ecx, %rax
	imulq	$1717986919, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, (%rsi)
	incl	-52(%rbp)
.L5:
	movl	-52(%rbp), %eax
	cltq
	cmpq	%rax, -40(%rbp)
	ja	.L6
	movl	$0, -48(%rbp)
	jmp	.L7
.L12:
	rdtsc
	salq	$32, %rdx
	orq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	-40(%rbp), %rax
	movl	%eax, %edx
	movq	-32(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	array_sum@PLT
	movl	%eax, -44(%rbp)
	rdtsc
	salq	$32, %rdx
	orq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	subq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	testq	%rax, %rax
	js	.L10
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	jmp	.L11
.L10:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
.L11:
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	incl	-48(%rbp)
.L7:
	cmpl	$9, -48(%rbp)
	jle	.L12
	movl	$0, %eax
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4262:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
