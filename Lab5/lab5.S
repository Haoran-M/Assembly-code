    .text
    .global fibonacci
    .global polynomial1
    .global polynomial2
    .global is_odd1
    .global is_odd2
    .global mul1
    .global mul2

# Haoran Miao
# 301542189
# hma98@sfu.ca



fibonacci:
    mov %rdi, %rbx              # store n
    cmp $1, %rbx                # check n<=1
    jle base_case              
    push %rbx                   # store n for recursion                    
    push %r12       
    jmp recursive_case

base_case:
    mov %rbx, %rax              # move n to return
    ret

recursive_case:
    mov %rbx, %rdi              # move to rdi for recursion
    sub $1, %rdi
    call fibonacci
    mov %rax, %r12               # store fib n-1
    mov %rbx, %rdi              # move to rdi for recursion
    sub $1, %rdi                
    call fibonacci
    mov %rax, %rcx             # store fib n-2     
    mov %r12, %rax              # move fib n-1 to rax
    add %rcx, %rax              # add fib n-2 to fib n-1
    pop %r12
    pop %rbx                    # pop all preserved registor
    ret


polynomial1:
    imul %rdi, %rsi 
    imul %rdi, %rsi 
    imul %rdi, %rsi             # a*x*x*x
    imul %rdi, %rdx
    imul %rdi, %rdx             # b*x*x
    imul %rdi, %rcx             # c*x
    mov %r8, %rax 
    add %rsi, %rax
    add %rdx, %rax
    add %rcx, %rax
    ret

polynomial2:
    imul %rdi, %rsi             #a*x
    add %rdx, %rsi              #a*x+b
    imul %rdi, %rsi             
    add %rcx, %rsi              #x*(a*x + b) + c
    imul %rdi, %rsi
    add %r8, %rsi               #x*(x*(a*x + b) + c) + d
    mov %rsi, %rax
    ret

is_odd1:
    mov $2, %rcx
    mov $0, %rdx     
    mov %rdi, %rax
    idiv %rcx     
    ret               


is_odd2:
    mov %rdi, %rax     
    and $1, %rax        
    ret               

mul1:
    mov $65537, %rax
    imul %rdi, %rax
    ret

mul2:
    mov %rdi, %rax
    shl $16, %rax
    add %rdi, %rax
    ret



