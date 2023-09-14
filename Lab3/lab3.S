    .global abs_value
    .global power2
    .global hailstone_length
    .text
    .extern helpers

#  Haoran Miao 301542189

abs_value:
 

abs_neg:
    neg %rdi
    mov %rdi, %rax   # after turning positive return
    ret

power2:
    push %r12    # use call preserved server stores n
    mov %rdi, %r12
    push %r13    # stores 
    mov $0, %r13  # counter
    push %rbx
    mov $1, %rbx  # return value, start with 2^0 =1


power2_loop:
    mov %rbx, %rdi    # rdi is the print output registor
    call print_uint64   # call print

    add $1, %r13    # counter add 1
    imul $2, %rbx    

    cmp %r12, %r13   # check counter with n
    jle power2_loop  # return to loop if counter is less or equal
    pop %r12         # clear all registor
    pop %r13
    pop %rbx
    ret

hailstone_length:
    push %rbx     #stores length
    mov  $0, %rbx  # set length to 0
    push %r12
    mov %rdi, %r12    #store n in r12
    push %r13      # use for and 1 compare


hailstone_length_loop:
    cmp $1, %r12    # check initial state
    je hailstone_length_loop_end     # check state to end
    add $1, %rbx
    mov %r12, %r13   #used for and 1 compare
    and $1, %r13
    cmp $0, %r13  
    je hailstone_length_loop_even    # jump to even 
    imul $3, %r12
    add $1, %r12    
    jmp hailstone_length_loop     #return to loop
    

hailstone_length_loop_even:
    shr $1, %r12      #divide by 2
    jmp hailstone_length_loop        #return to loop

hailstone_length_loop_end:
    mov %rbx, %rax      # move to output registor
    pop %rbx
    pop %r12
    pop %r13
    ret








