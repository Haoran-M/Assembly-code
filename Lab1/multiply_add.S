    
    .global multiply_add
    .text
multiply_add:
    imul %rsi, %rdx
    add  %rdi, %rdx
    mov  %rdx, %rax
    ret
