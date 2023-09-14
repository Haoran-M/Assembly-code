.global calculate
.extern f
// Haoran Miao 301542189
.section .text
calculate:
    push %rbx     #call-preserved register
    
    mov %rdi, %r11 # store x in r11
    #a = x + 3
    mov %rdi, %r8    #Move x into rax
    add $3, %r8      # store a in r8

    #b = f(x, a)
    mov %r11, %rdi   #Pass in x
    mov %r8, %rsi    #Pass in a
    call f
    mov %rax, %rdx   # Store b in rdx

    # c = f(b, x)
    mov %rdx, %rdi   # Pass in b 
    mov %r11, %rsi   # Move x to rsi
    call f
    add %rax, %rbx   # put c in rbx

    # Calculate d = f(x, c)
    mov %r11, %rdi   #Pass in x
    mov %rbx, %rsi   #Pass in c 
    call f
    add %rax, %rbx   # Add d to c

    add %rdx, %rbx   # add b to d and C
    add %r8,  %rbx   # add a to b c d 
    mov %rbx, %rax 

    pop %rbx         # add all to return

    ret
