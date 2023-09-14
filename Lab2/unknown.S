    .section .note.GNU-stack,""
    .global _start
    .text

do_something:
    push %rbx
    mov $1, %rcx
    mov $0, %rbx
    //Haoran Miao, 301542189
    
loop_top:
    add %rcx, %rbx
    add $2, %rcx    
    cmp %rdi, %rbx
    jle loop_top
        
    mov %rbx, %rax
    pop %rbx
    ret

_start:
    mov $60, %rdi
    call do_something
        
    # exit
    mov $0, %rdi
    call syscall_exit
