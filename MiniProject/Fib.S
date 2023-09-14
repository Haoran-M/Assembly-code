.text
.global fib_mod


fib_mod:
    xorl     %eax, %eax
    testl    %edi, %edi
    jl      fib_mod_base
    movl     $1, %eax
    je      fib_mod_base
    movl     $2, %edx
    xorl     %ecx, %ecx

fib_mod_loop:
    movl    %eax, %esi
    incl    %edx
    addl    %ecx, %eax
    movl    %esi, %ecx
    cmpl    %edx, %edi
    jge    fib_mod_loop

fib_mod_base:
    ret


