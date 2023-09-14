	.file	"fibonacci.c"
	.text
	.globl	fib_dynamic
	.type	fib_dynamic, @function
fib_dynamic:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, %esi
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leal	2(%rdi), %eax
	cltq
	leaq	15(,%rax,4), %rax
	movq	%rax, %rcx
	andq	$-16, %rcx
	andq	$-4096, %rax
	movq	%rsp, %rdx
	subq	%rax, %rdx
.L2:
	cmpq	%rdx, %rsp
	je	.L3
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L2
.L3:
	movq	%rcx, %rax
	andl	$4095, %eax
	subq	%rax, %rsp
	testq	%rax, %rax
	je	.L4
	orq	$0, -8(%rsp,%rax)
.L4:
	movl	$2, %eax
	shrx	%rax, %rsp, %rax
	movq	%rsp, %rdi
	movl	$0, 0(,%rax,4)
	movl	$1, 4(,%rax,4)
	cmpl	$1, %esi
	jle	.L5
	movq	%rdi, %rax
	leal	-1(%rsi), %edx
	leaq	(%rdi,%rdx,4), %rcx
.L6:
	movl	(%rax), %edx
	addl	4(%rax), %edx
	movl	%edx, 8(%rax)
	addq	$4, %rax
	cmpq	%rcx, %rax
	jne	.L6
.L5:
	movslq	%esi, %rsi
	movl	(%rdi,%rsi,4), %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	jne	.L10
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L10:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE0:
	.size	fib_dynamic, .-fib_dynamic
	.globl	fib_dynamic_cache
	.type	fib_dynamic_cache, @function
fib_dynamic_cache:
.LFB1:
	.cfi_startproc
	endbr64
	movl	$0, %eax
	testl	%edi, %edi
	jle	.L11
	movl	%edi, %eax
	cmpl	$1, %edi
	je	.L11
	movl	$2, %edx
	movl	$1, %eax
	movl	$0, %ecx
.L13:
	movl	%eax, %esi
	addl	%ecx, %eax
	incl	%edx
	movl	%esi, %ecx
	cmpl	%edx, %edi
	jge	.L13
.L11:
	ret
	.cfi_endproc
.LFE1:
	.size	fib_dynamic_cache, .-fib_dynamic_cache
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
