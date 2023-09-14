.global abc

abc:
    mov (%rsp), %rdx
    add %rdx, 8(%rsp)
    mov (%rsp), %rdx
    imul 8(%rsp), %rdx
    mov %rdx, (%rsp)
    ret
