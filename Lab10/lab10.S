.text
.global dot_double
.global dot_single
.global map_poly_double
.global map_poly_single
.global sin_x87

# Haoran Miao 
# 301542189
// hma98@sfu.ca


dot_double:
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
	

map_poly_double:

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
	

dot_single:
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
	

map_poly_single:
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


sin_x87:
    mov $0, %rcx
s87_loop:
    cmp %rdx, %rcx
    jae s87_ret
    fldl (%rdi, %rcx, 8)
    fsin
    fstpl (%rsi, %rcx, 8)
    inc %rcx
    jmp s87_loop
s87_ret:
    ret
