.text
.global dot_double
.global dot_single
.global map_poly_double
.global map_poly_single
.global dot_double_vec
.global dot_single_vec
.global map_poly_double_vec
.global map_poly_single_vec

# Haoran Miao 
# 301542189
# hma98@sfu.ca

# Double Precision Dot Product without SIMD
dot_double:
    testq   %rdx, %rdx
    je      dot_double_end
    movl    $0, %eax
    pxor    %xmm1, %xmm1

dot_double_loop:
    movsd   (%rdi,%rax,8), %xmm0
    mulsd   (%rsi,%rax,8), %xmm0
    addsd   %xmm0, %xmm1
    addq    $1, %rax
    cmpq    %rax, %rdx
    jne     dot_double_loop

dot_double_end:
    movapd  %xmm1, %xmm0
    ret

# Double Precision Map Polynomial without SIMD
map_poly_double:                        # @map_poly_double
	
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movsd	%xmm0, -32(%rbp)
	movsd	%xmm1, -40(%rbp)
	movsd	%xmm2, -48(%rbp)
	movsd	%xmm3, -56(%rbp)
	movq	$0, -64(%rbp)

map_poly_double_loop:                                # =>This Inner Loop Header: Depth=1
	movq	-64(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	map_poly_double_end                               #   in Loop: Header=BB1_1 Depth=1
	movq	-8(%rbp), %rax
	movq	-64(%rbp), %rcx
	movsd	(%rax,%rcx,8), %xmm0            # xmm0 = mem[0],zero
	movsd	%xmm0, -72(%rbp)
	movsd	-32(%rbp), %xmm1                # xmm1 = mem[0],zero
	mulsd	-72(%rbp), %xmm1
	mulsd	-72(%rbp), %xmm1
	movsd	-72(%rbp), %xmm2                # xmm2 = mem[0],zero
	movsd	-40(%rbp), %xmm0                # xmm0 = mem[0],zero
	mulsd	-72(%rbp), %xmm0
	mulsd	-72(%rbp), %xmm0
	mulsd	%xmm2, %xmm1
	addsd	%xmm0, %xmm1
	movsd	-48(%rbp), %xmm0                # xmm0 = mem[0],zero
	movsd	-72(%rbp), %xmm2                # xmm2 = mem[0],zero
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	addsd	-56(%rbp), %xmm0
	movq	-16(%rbp), %rax
	movq	-64(%rbp), %rcx
	movsd	%xmm0, (%rax,%rcx,8)                              #   in Loop: Header=BB1_1 Depth=1
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -64(%rbp)
	jmp	map_poly_double_loop

map_poly_double_end:
	popq	%rbp
	retq

# Single Precision Dot Product without SIMD
dot_single:
    testq   %rdx, %rdx
    je      dot_single_end
    movl    $0, %eax
    pxor    %xmm1, %xmm1

dot_single_loop:
    movss   (%rdi,%rax,4), %xmm0
    mulss   (%rsi,%rax,4), %xmm0
    addss   %xmm0, %xmm1
    addq    $1, %rax
    cmpq    %rax, %rdx
    jne     dot_single_loop

dot_single_end:
    movaps  %xmm1, %xmm0
    ret

# Single Precision Map Polynomial without SIMD
map_poly_single:
    movaps  %xmm0, %xmm5
    testq   %rdx, %rdx
    je      map_poly_single_end
    movl    $0, %eax

map_poly_single_loop:
    movss   (%rdi,%rax,4), %xmm4
    movaps  %xmm4, %xmm0
    mulss   %xmm5, %xmm0
    addss   %xmm1, %xmm0
    mulss   %xmm4, %xmm0
    addss   %xmm2, %xmm0
    mulss   %xmm4, %xmm0
    addss   %xmm3, %xmm0
    movss   %xmm0, (%rsi,%rax,4)

    addq    $1, %rax
    cmpq    %rax, %rdx
    jne     map_poly_single_loop

map_poly_single_end:
    ret

# Double Precision Dot Product with SIMD
dot_double_vec:
    vpxor   %ymm1, %ymm1, %ymm1

dot_double_vec_loop:
    vmovupd (%rdi), %ymm0
    vmulpd  (%rsi), %ymm0, %ymm0
    vaddpd  %ymm0, %ymm1, %ymm1
    addq    $32, %rdi
    addq    $32, %rsi
    subq    $8, %rdx
    jnz     dot_double_vec_loop

dot_double_vec_end:
    vextractf128 $1, %ymm1, %xmm0
    vaddpd  %xmm0, %xmm1, %xmm1
    ret



# Single Precision Dot Product with SIMD
dot_single_vec:
    vpxor   %ymm1, %ymm1, %ymm1

dot_single_vec_loop:
    vmovups (%rdi), %ymm0
    vmulps  (%rsi), %ymm0, %ymm0
    vaddps  %ymm0, %ymm1, %ymm1
    addq    $32, %rdi
    addq    $32, %rsi
    subq    $8, %rdx
    jnz     dot_single_vec_loop

dot_single_vec_end:
    vextractf128 $1, %ymm1, %xmm0
    vaddps  %xmm0, %xmm1, %xmm1
    ret

# Single Precision Map Polynomial with SIMD
map_poly_single_vec:
    movaps  %xmm0, %xmm5
    testq   %rdx, %rdx
    je      map_poly_single_vec_end
    movl    $0, %eax

map_poly_single_vec_loop:
	movss   (%rdi,%rax,4), %xmm4
    movaps  %xmm4, %xmm0
    mulss   %xmm5, %xmm0
    addss   %xmm1, %xmm0
    mulss   %xmm4, %xmm0
    addss   %xmm2, %xmm0
    mulss   %xmm4, %xmm0
    addss   %xmm3, %xmm0
    movss   %xmm0, (%rsi,%rax,4)

    addq    $1, %rax
    cmpq    %rax, %rdx
    jne     map_poly_single_vec_loop

map_poly_single_vec_end:
	ret



map_poly_double_vec:
    pushq   %rbp
    movq    %rsp, %rbp
    movq    %rdi, -8(%rbp)
    movq    %rsi, -16(%rbp)
    movq    %rdx, -24(%rbp)
    vmovsd  -32(%rbp), %xmm4
    vmovsd  -40(%rbp), %xmm5
    vmovsd  -48(%rbp), %xmm6
    vmovsd  -56(%rbp), %xmm7
    movq    $0, -64(%rbp)

map_poly_double_vec_loop:
    movq    -64(%rbp), %rax
    cmpq    -24(%rbp), %rax
    jae     map_poly_double_vec_end

    movq    -8(%rbp), %rax
    movq    -64(%rbp), %rcx
    vmovapd (%rax,%rcx,8), %xmm0
    vmovapd %xmm0, %xmm1
    vmulpd  %xmm0, %xmm0, %xmm0
    vmulpd  %xmm1, %xmm4, %xmm1
    vmovapd %xmm0, %xmm2
    vmulpd  %xmm0, %xmm5, %xmm0
    vmulpd  %xmm2, %xmm5, %xmm2
    vaddpd  %xmm1, %xmm0, %xmm1
    vmovapd %xmm0, %xmm0
    vmulpd  %xmm0, %xmm6, %xmm0
    vmovapd %xmm1, %xmm3
    vmulpd  %xmm2, %xmm6, %xmm2
    vmovapd %xmm3, %xmm1
    vaddpd  %xmm2, %xmm0, %xmm2
    vaddpd  %xmm7, %xmm2, %xmm2

    movq    -16(%rbp), %rax
    movq    -64(%rbp), %rcx
    vmovapd %xmm2, (%rax,%rcx,8)

    addq    $1, %rax
    movq    %rax, -64(%rbp)
    jmp     map_poly_double_vec_loop

map_poly_double_vec_end:
    popq    %rbp
    retq
