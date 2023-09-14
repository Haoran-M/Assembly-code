    .section .note.GNU-stack, ""
    .global array_sum
    .text

array_sum:
    mov $0, %eax
    mov $0, %ecx
as_loop:
    cmp %esi, %ecx
    jge as_return    
    add (%rdi, %rcx, 4), %eax
    add $1, %ecx
    jmp as_loop

as_return:    
    ret

