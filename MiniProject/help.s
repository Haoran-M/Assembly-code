	.file	"fibonacci.c"
	.text
	.p2align 4
	.globl	fib_dynamic_cache
	.type	fib_dynamic_cache, @function
fib_dynamic_cache:
.LFB0:
	.cfi_startproc
	endbr64
	xorl	%eax, %eax
	testl	%edi, %edi
	jle	.L1
	movl	$1, %eax
	cmpl	$1, %edi
	je	.L1
	movl	$2, %edx
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L3:
	movl	%eax, %esi
	incl	%edx
	addl	%ecx, %eax
	movl	%esi, %ecx
	cmpl	%edx, %edi
	jge	.L3
.L1:
	ret
	.cfi_endproc
.LFE0:
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
