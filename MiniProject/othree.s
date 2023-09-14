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
	movslq	%edi, %rsi
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leal	2(%rsi), %eax
	movq	%rsp, %rcx
	cltq
	leaq	15(,%rax,4), %rax
	movq	%rax, %rdx
	andq	$-4096, %rax
	subq	%rax, %rcx
	andq	$-16, %rdx
	cmpq	%rcx, %rsp
	je	.L3
.L18:
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	cmpq	%rcx, %rsp
	jne	.L18
.L3:
	andl	$4095, %edx
	subq	%rdx, %rsp
	testq	%rdx, %rdx
	jne	.L19
.L4:
	movq	.LC0(%rip), %rax
	movq	%rsp, %rcx
	movq	%rax, (%rsp)
	cmpl	$1, %esi
	jle	.L5
	cmpl	$3, %esi
	jle	.L10
	leal	-4(%rsi), %eax
	movl	$4, %edx
	movl	$1, %r8d
	xorl	%edi, %edi
	shrl	%eax
	leal	3(%rax), %r9d
	addq	%r9, %r9
.L7:
	addl	%r8d, %edi
	movslq	%edx, %rax
	addl	%edi, %r8d
	vmovd	%edi, %xmm1
	vpinsrd	$1, %r8d, %xmm1, %xmm0
	vmovq	%xmm0, -8(%rcx,%rdx,4)
	addq	$2, %rdx
	cmpq	%rdx, %r9
	jne	.L7
	.p2align 4,,10
	.p2align 3
.L8:
	movl	-4(%rcx,%rax,4), %edx
	addl	-8(%rcx,%rax,4), %edx
	movl	%edx, (%rcx,%rax,4)
	incq	%rax
	cmpl	%eax, %esi
	jge	.L8
.L5:
	movl	(%rcx,%rsi,4), %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	jne	.L20
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L19:
	.cfi_restore_state
	orq	$0, -8(%rsp,%rdx)
	jmp	.L4
.L10:
	movl	$2, %eax
	jmp	.L8
.L20:
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
	jle	.L21
	movl	$1, %eax
	cmpl	$1, %edi
	je	.L21
	movl	$2, %edx
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L23:
	movl	%eax, %esi
	incl	%edx
	addl	%ecx, %eax
	movl	%esi, %ecx
	cmpl	%edx, %edi
	jge	.L23
.L21:
	ret
	.cfi_endproc
.LFE1:
	.size	fib_dynamic_cache, .-fib_dynamic_cache
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1
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
