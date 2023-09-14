	.text
	.file	"code.c"
	.globl	randint                         # -- Begin function randint
	.p2align	4, 0x90
	.type	randint,@function
randint:                                # @randint
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movabsq	$6364136223846793005, %rax      # imm = 0x5851F42D4C957F2D
	imulq	seed(%rip), %rax
	movabsq	$1442695040888963407, %rcx      # imm = 0x14057B7EF767814F
	addq	%rcx, %rax
	movq	%rax, seed(%rip)
	movq	seed(%rip), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	randint, .Lfunc_end0-randint
	.cfi_endproc
                                        # -- End function
	.globl	fill_array                      # -- Begin function fill_array
	.p2align	4, 0x90
	.type	fill_array,@function
fill_array:                             # @fill_array
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, -24(%rbp)
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jge	.LBB1_4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	callq	randint
	movq	%rax, %rdx
	andq	$255, %rdx
	subq	$128, %rdx
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rdx, (%rax,%rcx,8)
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB1_1
.LBB1_4:
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	fill_array, .Lfunc_end1-fill_array
	.cfi_endproc
                                        # -- End function
	.globl	dot                             # -- Begin function dot
	.p2align	4, 0x90
	.type	dot,@function
dot:                                    # @dot
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -40(%rbp)
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	movq	-40(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jge	.LBB2_4
# %bb.2:                                #   in Loop: Header=BB2_1 Depth=1
	movq	-8(%rbp), %rax
	movq	-40(%rbp), %rcx
	movq	(%rax,%rcx,8), %rax
	movq	-16(%rbp), %rcx
	movq	-40(%rbp), %rdx
	imulq	(%rcx,%rdx,8), %rax
	addq	-32(%rbp), %rax
	movq	%rax, -32(%rbp)
# %bb.3:                                #   in Loop: Header=BB2_1 Depth=1
	movq	-40(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB2_1
.LBB2_4:
	movq	-32(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	dot, .Lfunc_end2-dot
	.cfi_endproc
                                        # -- End function
	.globl	dot_struct                      # -- Begin function dot_struct
	.p2align	4, 0x90
	.type	dot_struct,@function
dot_struct:                             # @dot_struct
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -32(%rbp)
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jge	.LBB3_4
# %bb.2:                                #   in Loop: Header=BB3_1 Depth=1
	movq	-8(%rbp), %rax
	movq	-32(%rbp), %rcx
	shlq	$4, %rcx
	addq	%rcx, %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movq	-32(%rbp), %rdx
	shlq	$4, %rdx
	addq	%rdx, %rcx
	imulq	8(%rcx), %rax
	addq	-24(%rbp), %rax
	movq	%rax, -24(%rbp)
# %bb.3:                                #   in Loop: Header=BB3_1 Depth=1
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB3_1
.LBB3_4:
	movq	-24(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	dot_struct, .Lfunc_end3-dot_struct
	.cfi_endproc
                                        # -- End function
	.type	seed,@object                    # @seed
	.local	seed
	.comm	seed,8,8
	.ident	"Ubuntu clang version 14.0.0-1ubuntu1"
	.section	".note.GNU-stack","",@progbits
	