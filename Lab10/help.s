	.file	"help.c"
	.text
	.globl	dot_double
	.type	dot_double, @function
dot_double:
.LFB16:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx
	je	.L4
	movl	$0, %eax
	pxor	%xmm1, %xmm1
.L3:
	movsd	(%rdi,%rax,8), %xmm0
	mulsd	(%rsi,%rax,8), %xmm0
	addsd	%xmm0, %xmm1
	addq	$1, %rax
	cmpq	%rax, %rdx
	jne	.L3
.L1:
	movapd	%xmm1, %xmm0
	ret
.L4:
	pxor	%xmm1, %xmm1
	jmp	.L1
	.cfi_endproc
.LFE16:
	.size	dot_double, .-dot_double
	.globl	map_poly_double
	.type	map_poly_double, @function
map_poly_double:
.LFB17:
	.cfi_startproc
	endbr64
	movq	%rdi, %rcx
	movapd	%xmm0, %xmm6
	testq	%rdx, %rdx
	je	.L6
	movl	$0, %eax
.L8:
	movsd	(%rcx,%rax,8), %xmm4
	movapd	%xmm4, %xmm0
	mulsd	%xmm6, %xmm0
	mulsd	%xmm4, %xmm0
	mulsd	%xmm4, %xmm0
	movapd	%xmm4, %xmm5
	mulsd	%xmm1, %xmm5
	mulsd	%xmm4, %xmm5
	addsd	%xmm5, %xmm0
	mulsd	%xmm2, %xmm4
	addsd	%xmm4, %xmm0
	addsd	%xmm3, %xmm0
	movsd	%xmm0, (%rsi,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %rdx
	jne	.L8
.L6:
	ret
	.cfi_endproc
.LFE17:
	.size	map_poly_double, .-map_poly_double
	.globl	dot_single
	.type	dot_single, @function
dot_single:
.LFB18:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx
	je	.L13
	movl	$0, %eax
	pxor	%xmm1, %xmm1
.L12:
	movss	(%rdi,%rax,4), %xmm0
	mulss	(%rsi,%rax,4), %xmm0
	addss	%xmm0, %xmm1
	addq	$1, %rax
	cmpq	%rax, %rdx
	jne	.L12
.L10:
	movaps	%xmm1, %xmm0
	ret
.L13:
	pxor	%xmm1, %xmm1
	jmp	.L10
	.cfi_endproc
.LFE18:
	.size	dot_single, .-dot_single
	.globl	map_poly_single
	.type	map_poly_single, @function
map_poly_single:
.LFB19:
	.cfi_startproc
	endbr64
	movaps	%xmm0, %xmm5
	testq	%rdx, %rdx
	je	.L15
	movl	$0, %eax
.L17:
	movss	(%rdi,%rax,4), %xmm4
	movaps	%xmm4, %xmm0
	mulss	%xmm5, %xmm0
	addss	%xmm1, %xmm0
	mulss	%xmm4, %xmm0
	addss	%xmm2, %xmm0
	mulss	%xmm4, %xmm0
	addss	%xmm3, %xmm0
	movss	%xmm0, (%rsi,%rax,4)
	addq	$1, %rax
	cmpq	%rax, %rdx
	jne	.L17
.L15:
	ret
	.cfi_endproc
.LFE19:
	.size	map_poly_single, .-map_poly_single
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
