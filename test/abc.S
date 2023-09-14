.global abc

abc:
    push %rdi
    push %rsi    
    mov (%rsp), %rdx
    add %rdx, 8(%rsp)
    mov (%rsp), %rdx
    imul 8(%rsp), %rdx
    mov %rdx, (%rsp)
    ret
