	.file	"fibonacci.c"
	.text
	.p2align 4
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
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leal	2(%rdi), %eax
	movq	%rsp, %rcx
	cltq
	leaq	15(,%rax,4), %rax
	movq	%rax, %rdx
	andq	$-4096, %rax
	subq	%rax, %rcx
	andq	$-16, %rdx
	cmpq	%rcx, %rsp
	je	.L3
.L13:
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	cmpq	%rcx, %rsp
	jne	.L13
.L3:
	andl	$4095, %edx
	subq	%rdx, %rsp
	testq	%rdx, %rdx
	jne	.L14
.L4:
	movabsq	$4294967296, %rax
	movq	%rsp, %r8
	movq	%rax, (%rsp)
	cmpl	$1, %edi
	jle	.L5
	leal	-2(%rdi), %edx
	leaq	8(%r8), %rax
	xorl	%ecx, %ecx
	leaq	8(%r8,%rdx,4), %rsi
	movl	$1, %edx
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L15:
	movl	-4(%rax), %ecx
	addq	$4, %rax
.L6:
	addl	%ecx, %edx
	movl	%edx, (%rax)
	cmpq	%rsi, %rax
	jne	.L15
.L5:
	movslq	%edi, %rdi
	movl	(%r8,%rdi,4), %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	jne	.L16
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L14:
	.cfi_restore_state
	orq	$0, -8(%rsp,%rdx)
	jmp	.L4
.L16:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE0:
	.size	fib_dynamic, .-fib_dynamic
	.p2align 4
	.globl	fib_dynamic_cache
	.type	fib_dynamic_cache, @function
fib_dynamic_cache:
.LFB1:
	.cfi_startproc
	endbr64
	xorl	%eax, %eax
	testl	%edi, %edi
	jle	.L17
	movl	$1, %eax
	cmpl	$1, %edi
	je	.L17
	movl	$2, %edx
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L19:
	movl	%eax, %esi
	incl	%edx
	addl	%ecx, %eax
	movl	%esi, %ecx
	cmpl	%edx, %edi
	jge	.L19
.L17:
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
