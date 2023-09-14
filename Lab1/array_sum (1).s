	.file	"array_sum.c"
	.text
	.p2align 4
	.globl	array_sum
	.type	array_sum, @function
array_sum:
.LFB0:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	je	.L7
	leal	-1(%rsi), %eax
	cmpl	$6, %eax
	jbe	.L8
	movl	%esi, %edx
	movq	%rdi, %rax
	vpxor	%xmm0, %xmm0, %xmm0
	shrl	$3, %edx
	salq	$5, %rdx
	addq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L4:
	vpaddd	(%rax), %ymm0, %ymm0
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L4
	vmovdqa	%xmm0, %xmm1
	vextracti128	$0x1, %ymm0, %xmm0
	movl	%esi, %edx
	vpaddd	%xmm0, %xmm1, %xmm0
	andl	$-8, %edx
	vpsrldq	$8, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vpsrldq	$4, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vmovd	%xmm0, %eax
	testb	$7, %sil
	je	.L13
	vzeroupper
.L3:
	movslq	%edx, %rcx
	addl	(%rdi,%rcx,4), %eax
	leal	1(%rdx), %ecx
	cmpl	%esi, %ecx
	jnb	.L11
	movslq	%ecx, %rcx
	addl	(%rdi,%rcx,4), %eax
	leal	2(%rdx), %ecx
	cmpl	%ecx, %esi
	jbe	.L11
	movslq	%ecx, %rcx
	addl	(%rdi,%rcx,4), %eax
	leal	3(%rdx), %ecx
	cmpl	%ecx, %esi
	jbe	.L11
	movslq	%ecx, %rcx
	addl	(%rdi,%rcx,4), %eax
	leal	4(%rdx), %ecx
	cmpl	%ecx, %esi
	jbe	.L11
	movslq	%ecx, %rcx
	addl	(%rdi,%rcx,4), %eax
	leal	5(%rdx), %ecx
	cmpl	%ecx, %esi
	jbe	.L11
	movslq	%ecx, %rcx
	addl	$6, %edx
	addl	(%rdi,%rcx,4), %eax
	cmpl	%edx, %esi
	jbe	.L11
	movslq	%edx, %rdx
	addl	(%rdi,%rdx,4), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	xorl	%eax, %eax
.L11:
	ret
	.p2align 4,,10
	.p2align 3
.L13:
	vzeroupper
	ret
.L8:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L3
	.cfi_endproc
.LFE0:
	.size	array_sum, .-array_sum
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
