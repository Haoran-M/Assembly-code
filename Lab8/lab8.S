    .global hailstone_length
    .global hailstone_length_cmov
    .text

#Haoran Miao 
#301542189
#hma98@sfu.ca


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




hailstone_length_cmov:
    push %rbx       # stores length
    mov $0, %rbx    # set length to 0
    push %r12
    mov %rdi, %r12  # store n in r12

hailstone_length_cmov_loop:
    cmp $1, %r12        # check initial state
    je hailstone_length_cmov_loop_end  # check state to end

    add $1, %rbx
    mov %r12, %r8
    mov %r12, %r9
    shr $1, %r8
    imul $3, %r9
    add $1, %r9
    and $1, %r12
    cmovz %r8, %r12   # rdi = r12 if rsi == 0
    cmovnz %r9, %r12  # rsi = r12 if rsi != 0
    jmp hailstone_length_cmov_loop
    

hailstone_length_cmov_loop_end:
    mov %rbx, %rax      # move to output register
    pop %rbx
    pop %r12
    ret
