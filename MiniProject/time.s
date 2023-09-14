	.file	"Fib.c"
	.text
	.p2align 4
	.globl	fib_dynamic
	.type	fib_dynamic, @function
fib_dynamic:
.LFB4379:
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
.LFE4379:
	.size	fib_dynamic, .-fib_dynamic
	.p2align 4
	.globl	fib_dynamic_cache
	.type	fib_dynamic_cache, @function
fib_dynamic_cache:
.LFB4380:
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
.LFE4380:
	.size	fib_dynamic_cache, .-fib_dynamic_cache
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Result: %d\n"
	.text
	.p2align 4
	.globl	measureCycles
	.type	measureCycles, @function
measureCycles:
.LFB4381:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rcx
	movl	%esi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	rdtsc
	salq	$32, %rdx
	movq	%rax, %rbp
	orq	%rdx, %rbp
	call	*%rcx
	movl	%eax, %esi
	rdtsc
	leaq	.LC0(%rip), %rdi
	movq	%rax, %rbx
	salq	$32, %rdx
	xorl	%eax, %eax
	orq	%rdx, %rbx
	call	printf@PLT
	movq	%rbx, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	subq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4381:
	.size	measureCycles, .-measureCycles
	.p2align 4
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB4382:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	%esi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	call	clock@PLT
	movl	%r12d, %edi
	movq	%rax, %rbp
	call	*%rbx
	movl	%eax, %r12d
	call	clock@PLT
	movl	%r12d, %esi
	leaq	.LC0(%rip), %rdi
	movq	%rax, %rbx
	xorl	%eax, %eax
	call	printf@PLT
	subq	%rbp, %rbx
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2sdq	%rbx, %xmm0, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 24
	vdivsd	.LC1(%rip), %xmm0, %xmm0
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4382:
	.size	measureTime, .-measureTime
	.section	.rodata.str1.1
.LC2:
	.string	"\nFibonacci assembly:"
.LC3:
	.string	"Time taken: %.9f seconds\n"
.LC4:
	.string	"Cycles taken: %lu\n"
.LC5:
	.string	"\nFib mod assembly:"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"\nFibonacci using Dynamic Programming:"
	.align 8
.LC7:
	.string	"\nFibonacci using Dynamic Programming with caching:"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB4383:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC2(%rip), %rdi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	leaq	.LC3(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	call	puts@PLT
	movq	fib@GOTPCREL(%rip), %rbp
	movl	$40, %esi
	movq	%rbp, %rdi
	call	measureTime
	movq	%r12, %rdi
	movl	$1, %eax
	call	printf@PLT
	movq	%rbp, %rdi
	movl	$40, %esi
	leaq	.LC4(%rip), %rbp
	call	measureCycles
	movq	%rbp, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
	movq	fib_mod@GOTPCREL(%rip), %r13
	movl	$40, %esi
	movq	%r13, %rdi
	call	measureTime
	movq	%r12, %rdi
	movl	$1, %eax
	call	printf@PLT
	movq	%r13, %rdi
	movl	$40, %esi
	leaq	fib_dynamic(%rip), %r13
	call	measureCycles
	movq	%rbp, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
	movl	$40, %esi
	movq	%r13, %rdi
	call	measureTime
	movq	%r12, %rdi
	movl	$1, %eax
	call	printf@PLT
	movq	%r13, %rdi
	movl	$40, %esi
	leaq	fib_dynamic_cache(%rip), %r13
	call	measureCycles
	movq	%rbp, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
	movl	$40, %esi
	movq	%r13, %rdi
	call	measureTime
	movq	%r12, %rdi
	movl	$1, %eax
	call	printf@PLT
	movq	%r13, %rdi
	movl	$40, %esi
	call	measureCycles
	movq	%rbp, %rdi
	movq	%rax, %rsi
	xorl	%eax, %eax
	call	printf@PLT
	popq	%rbp
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4383:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1093567616
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
