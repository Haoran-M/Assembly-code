.text
.global fib

fib:
    xorl    %eax, %eax
    testl   %edi, %edi
    jle     fib_base
    movl    $1, %eax
    cmpl    $1, %edi
    je      fib_base
    movl    $2, %edx
    xorl    %ecx, %ecx

fib_loop:
    movl    %eax, %esi
    incl    %edx
    addl    %ecx, %eax
    movl    %esi, %ecx
    cmpl    %edx, %edi
    jge     fib_loop

fib_base:
    ret

