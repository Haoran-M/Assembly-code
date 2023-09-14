.section .text
.globl strlen_mine
.globl strlen_utf8
 # Haoran Miao
 # 301542189

strlen_mine:
    mov %rdi, %rdx          # Stores pointer
    mov $0, %rcx            # Set counter to 0
    jmp strlen_mine_loop    # go to loop

strlen_mine_loop:
    cmpb $0, (%rdx)         # check if end or not
    je strlen_mine_end      # end if its the end

    inc %rbx                # pointer + 1 byte
    add $1, %rcx
    jmp strlen_mine_loop    # back to the loop

strlen_mine_end:
    mov %rcx, %rax          # loop end
    ret

strlen_utf8:
    mov %rdi, %rdx          # Move the pointer to rcx
    mov $0, %rcx            # counter set to 0

strlen_utf8_loop:
    cmpb $0, (%rdx)                # Compare the byte with zero
    je strlen_utf8_end             # If zero byte is found, exit the loop

    movb (%rdx), %r8b               # Move the byte to r8 8 bit version
    andb $0xC0, %r8b                # combine the first two bits of the byte
    cmpb $0x80, %r8b               # Check if the the current value is 0x80
    je strlen_utf8_next            

    add $1, %rcx                   # add 1 to count

strlen_utf8_next:
    incq %rdx                    # Move to next byte
    jmp strlen_utf8_loop         # Jump back to loop

strlen_utf8_end:
    mov %rcx, %rax
    ret                     # Return the count