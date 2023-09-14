    .text
    .global is_prime
    .global largest_power_unsigned
    .global overflowing_subtract
    .global dumb

#   Haoran Miao
#   301542189
#   hma98@sfu.ca


is_prime:
    push %rbx
    mov %rdi, %rbx   # n
    push %r12
    mov $2, %r12     # i
    jmp is_prime_loop

is_prime_loop:
    cmp %r12, %rbx   # check i < n
    je prime
    mov $0, %rdx      # check n % i
    mov %rbx, %rax
    div %r12
    cmp $0, %rdx
    je is_prime_no    # if n % i = 0
    add $1, %r12
    jmp is_prime_loop


is_prime_no:         # return 0 if not prime
    pop %rbx
    pop %r12
    mov $0, %rax
    ret

prime:               # return 1 if prime
    pop %rbx
    pop %r12
    mov $1, %rax
    ret




largest_power_unsigned:
    push %rbx
    push %r12
    push %r13

    mov $1, %rax       # Initialize result to 1
    mov %rdi, %rbx     # rbx = n

multiply_loop:
    mov %rax, %r12     # Move current to r12
    mov %rbx, %r13     # Move n to r13

    mul %rbx           # Multiply current by n

    jc overflow         #jump to overflow label

    jmp check_overflow  # If no overflow, continue

overflow:
    mov %r12, %rax     # Set returnto previous
    pop %r13
    pop %r12
    pop %rbx
    ret

check_overflow:
    cmp %r12, %rax     # check overflow
    jb overflow        # if previousis greater than current, there is an overflow.

    jmp multiply_loop   # If no overflow, continue


overflowing_subtract:
    push %rbx            

    mov %rdi, %rbx         # Move a into rbx
    sub %rsi, %rbx         # a - b

    jo overflow_output     # check overflow

    mov %rbx, %rax          # Move the result to rax for returning

    pop %rbx              

    ret                   

overflow_output:
    mov $0, %rax       # Set the result to zero

    pop %rbx               

    ret   


dumb: 
    cmp $0, %rdi          #check a = 0
    je  ret_b
    cmp $0, %rsi          #check b =0
    je  ret_a
    jmp dumb_recursive_case      # both not 0, do recursion

dumb_recursive_case:
    push %rdi        # a 8(%rsp)
    push %rsi        # b (%rsp)
    sub  $1, %rdi     # a = a-1, b = b-1
    sub  $1, %rsi
    call dumb          #recursion
    pop  %rsi        # b 
    pop  %rdi        # a
    add  %rdi, %rax  # return + a + b + b
    add  %rsi, %rax
    add  %rsi, %rax
    ret              # final return

ret_b:
    mov %rsi, %rax    
    ret

ret_a:
    mov %rdi, %rax
    ret





