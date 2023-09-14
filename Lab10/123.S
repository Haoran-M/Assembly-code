.text
.global dot_double
.global dot_single
.global map_poly_double
.global map_poly_single


dot_double:                          
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	xorps	%xmm0, %xmm0
	movsd	%xmm0, -32(%rbp)
	movq	$0, -40(%rbp)

dot_double_loop:                                
	movq	-40(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	dot_double_end                          
	movq	-8(%rbp), %rax
	movq	-40(%rbp), %rcx
	movsd	(%rax,%rcx,8), %xmm0       
	movq	-16(%rbp), %rax
	movq	-40(%rbp), %rcx
	movsd	(%rax,%rcx,8), %xmm2         
	movsd	-32(%rbp), %xmm1               
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)                          
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	dot_double_loop

dot_double_end:
	movsd	-32(%rbp), %xmm0            
	popq	%rbp
	retq



map_poly_double:                    
	
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

map_poly_double_loop:                               
	movq	-64(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	map_poly_double_end                           
	movq	-8(%rbp), %rax
	movq	-64(%rbp), %rcx
	movsd	(%rax,%rcx,8), %xmm0         
	movsd	%xmm0, -72(%rbp)
	movsd	-32(%rbp), %xmm1               
	mulsd	-72(%rbp), %xmm1
	mulsd	-72(%rbp), %xmm1
	movsd	-72(%rbp), %xmm2              
	movsd	-40(%rbp), %xmm0               
	mulsd	-72(%rbp), %xmm0
	mulsd	-72(%rbp), %xmm0
	mulsd	%xmm2, %xmm1
	addsd	%xmm0, %xmm1
	movsd	-48(%rbp), %xmm0             
	movsd	-72(%rbp), %xmm2              
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	addsd	-56(%rbp), %xmm0
	movq	-16(%rbp), %rax
	movq	-64(%rbp), %rcx
	movsd	%xmm0, (%rax,%rcx,8)                          
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -64(%rbp)
	jmp	map_poly_double_loop

map_poly_double_end:
	popq	%rbp
	retq




dot_single:                            
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	xorps	%xmm0, %xmm0
	movss	%xmm0, -28(%rbp)
	movq	$0, -40(%rbp)

dot_single_loop:                              
	movq	-40(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	dot_single_end                             
	movq	-8(%rbp), %rax
	movq	-40(%rbp), %rcx
	movss	(%rax,%rcx,4), %xmm0           
	movq	-16(%rbp), %rax
	movq	-40(%rbp), %rcx
	movss	(%rax,%rcx,4), %xmm2        
	movss	-28(%rbp), %xmm1             
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -28(%rbp)                         
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	dot_single_loop

dot_single_end:
	movss	-28(%rbp), %xmm0            
	popq	%rbp
	retq




map_poly_single:                      
	
	pushq	%rbp

	movq	%rsp, %rbp

	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movss	%xmm0, -28(%rbp)
	movss	%xmm1, -32(%rbp)
	movss	%xmm2, -36(%rbp)
	movss	%xmm3, -40(%rbp)
	movq	$0, -48(%rbp)

map_poly_single_loop:                            
	movq	-48(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	map_poly_single_end                            
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rcx
	movss	(%rax,%rcx,4), %xmm0          
	movss	%xmm0, -52(%rbp)
	movss	-28(%rbp), %xmm0               
	movss	-52(%rbp), %xmm2               
	movss	-32(%rbp), %xmm1              
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	-52(%rbp), %xmm2               
	movss	-36(%rbp), %xmm1              
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	-52(%rbp), %xmm2             
	movss	-40(%rbp), %xmm1              
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movq	-16(%rbp), %rax
	movq	-48(%rbp), %rcx
	movss	%xmm0, (%rax,%rcx,4)                             
	movq	-48(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -48(%rbp)
	jmp	map_poly_single_loop

map_poly_single_end:
	popq	%rbp
	retq



