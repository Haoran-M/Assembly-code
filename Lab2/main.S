    .section .note.GNU-stack,""
    .global _start
    .text

_start:
    # Put some values in the call-preserved registers, so we can check that they are preserved.
    # It should be possible to change the values here (45-89) to *anything* and still get the same result before and after the function calls
    mov $45, %rbx
    mov $56, %r12
    mov $67, %r13
    mov $78, %r14
    mov $89, %r15
    
    # do some calculation with the call-preserved registers, and print the result
    mov %rbx, %rdi
    shl $2, %rdi
    add %r12, %rdi
    shl $2, %rdi
    add %r13, %rdi
    shl $2, %rdi
    add %r14, %rdi
    shl $2, %rdi
    add %r15, %rdi
    call print_int64
    
    # call the calculate function, and print its return value
    mov $12, %rdi
    call calculate
    mov %rax, %rdi
    call print_int64

    # call the calculate function, and print its return value
    mov $-10, %rdi
    call calculate
    mov %rax, %rdi
    call print_int64

    # do the same calculation, and print the result. It should be the same
    mov %rbx, %rdi
    shl $2, %rdi
    add %r12, %rdi
    shl $2, %rdi
    add %r13, %rdi
    shl $2, %rdi
    add %r14, %rdi
    shl $2, %rdi
    add %r15, %rdi
    call print_int64

    mov $0, %rdi
    call syscall_exit
