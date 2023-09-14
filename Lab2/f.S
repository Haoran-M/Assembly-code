    .section .note.GNU-stack,""
    .global f
    .text

f:  # f(x, y) -> x^2 + y

    # the actual function logic
    mov %rdi, %rax
    imul %rdi, %rax
    add %rsi, %rax
    
    # nuke all non-call-preserved registers (except %rax, which has our result)
    mov $0, %rcx
    mov $0, %rdx
    mov $0, %rsi
    mov $0, %rdi
    mov $0, %r8
    mov $0, %r9
    mov $0, %r10
    mov $0, %r11
    vzeroall
    
    ret

