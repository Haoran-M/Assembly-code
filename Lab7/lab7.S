# Haoran Miao
# 301542189
# hma98@sfu.ca 

.data
seed:
    .quad 0

.text
.global randint

randint:                               
    push    %rbp
    mov     %rsp, %rbp
    movabs  $6364136223846793005, %rax     # Multiplier for random number generation
    imul    seed(%rip), %rax
    movabs  $1442695040888963407, %rcx    # Additive constant for random number generation
    add     %rcx, %rax
    mov     %rax, seed(%rip)               # Update seed with the generated random number
    mov     seed(%rip), %rax
    pop     %rbp
    ret

.global fill_array

fill_array:
    push    %rbp
    mov     %rsp, %rbp
    sub     $32, %rsp
    mov     %rdi, -8(%rbp)                  # Array pointer
    mov     %rsi, -16(%rbp)                 # Array size
    movq    $0, -24(%rbp)                   # Loop counter

fill_array_loop:
    mov     -24(%rbp), %rax
    cmp     -16(%rbp), %rax
    jge     fill_array_end                  # Exit loop when counter >= size
    call    randint                         # Generate a random number
    mov     %rax, %rdx
    and     $255, %rdx                       # Keep only the lower 8 bits
    sub     $128, %rdx                       # Subtract 128
    mov     -8(%rbp), %rax
    mov     -24(%rbp), %rcx
    mov     %rdx, (%rax,%rcx,8)              # Store the random number in the array
    mov     -24(%rbp), %rax
    add     $1, %rax
    mov     %rax, -24(%rbp)
    jmp     fill_array_loop

fill_array_end:
    add     $32, %rsp
    pop     %rbp
    ret

.global dot

dot:
    push    %rbp
    mov     %rsp, %rbp
    mov     %rdi, -8(%rbp)                   # Array pointer A
    mov     %rsi, -16(%rbp)                  # Array pointer B
    mov     %rdx, -24(%rbp)                  # Array size
    movq    $0, -32(%rbp)                    # Accumulator
    movq    $0, -40(%rbp)                    # Loop counter

dot_loop:
    mov     -40(%rbp), %rax
    cmp     -24(%rbp), %rax
    jge     dot_end                           # Exit loop when counter >= size
    mov     -8(%rbp), %rax
    mov     -40(%rbp), %rcx
    mov     (%rax,%rcx,8), %rax               # Get element from array A
    mov     -16(%rbp), %rcx
    mov     -40(%rbp), %rdx
    imul    (%rcx,%rdx,8), %rax               # Multiply element from array B
    add     -32(%rbp), %rax
    mov     %rax, -32(%rbp)                   # Update accumulator
    mov     -40(%rbp), %rax
    add     $1, %rax
    mov     %rax, -40(%rbp)
    jmp     dot_loop

dot_end:
    mov     -32(%rbp), %rax
    pop     %rbp
    ret

.global dot_struct

dot_struct: 
    push    %rbp
    mov     %rsp, %rbp
    mov     %rdi, -8(%rbp)                    # Struct pointer
    mov     %rsi, -16(%rbp)                   # Array pointer
    movq    $0, -24(%rbp)                     # Accumulator
    movq    $0, -32(%rbp)                     # Loop counter

dot_struct_loop:
    mov     -32(%rbp), %rax
    cmp     -16(%rbp), %rax
    jge     dot_struct_end                     # Exit loop when counter >= size
    mov     -8(%rbp), %rax
    mov     -32(%rbp), %rcx
    shl     $4, %rcx                           # Multiply loop counter by 16 (assuming struct size is 16 bytes)
    add     %rcx, %rax
    mov     (%rax), %rax                        # Get element from struct
    mov     -8(%rbp), %rcx
    mov     -32(%rbp), %rdx
    shl     $4, %rdx                            # Multiply loop counter by 16 (assuming struct size is 16 bytes)
    add     %rdx, %rcx
    imul    8(%rcx), %rax                        # Multiply element from array
    add     -24(%rbp), %rax
    mov     %rax, -24(%rbp)                      # Update accumulator
    mov     -32(%rbp), %rax
    add     $1, %rax
    mov     %rax, -32(%rbp)
    jmp     dot_struct_loop

dot_struct_end:
    mov     -24(%rbp), %rax
    pop     %rbp
    retq
