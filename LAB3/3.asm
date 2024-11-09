# PROGRAM 3 : MIPS Assembly program to check whether an entered string is palindrome or not. (use subroutine)
# Date: 26/08/2024

.data
prompt:     .asciiz "Enter a string: "
success:     .asciiz "The string is a palindrome.\n"
failure: .asciiz "The string is not a palindrome.\n"
buffer:     .space 100

.text
.globl main

main:
    li   $v0, 4
    la   $a0, prompt
    syscall

    li   $v0, 8
    la   $a0, buffer
    li   $a1, 100
    syscall

    la   $t0, buffer
    lb   $t1, ($t0)
loop_remove_newline:
        beq  $t1, $zero, end_remove_newline
        beq  $t1, 10, set_null
        addi $t0, $t0, 1
        lb   $t1, ($t0)
        j    loop_remove_newline
    set_null:
        sb   $zero, ($t0)
    end_remove_newline:

    la   $a0, buffer
    jal  is_palin

    beq  $v0, 1, print_palin
    li   $v0, 4
    la   $a0, failure
    syscall
    j    exit_program

print_palin:
    li   $v0, 4
    la   $a0, success
    syscall

exit_program:
    li   $v0, 10
    syscall

is_palin:
    move $t0, $a0
    li   $t1, 0

    find_len:
        lb   $t2, ($t0)
        beq  $t2, $zero, len_found  # If end of string (null byte), length found
        addi $t1, $t1, 1            # Increment length counter
        addi $t0, $t0, 1            # Move to next character
        j    find_len
        
    len_found:
    move $t2, $t1                   # Store length in $t2
    move $t0, $a0                   # Reset start pointer
    add  $t3, $a0, $t1              # Calculate end pointer
    addi $t3, $t3, -1               # Point to last character
    li   $v0, 1                     # Assume palindrome (return value)

    check_palin:
        bge  $t0, $t3, done_check   # If pointers cross, palindrome check done
        lb   $t4, ($t0)             # Load character from start pointer
        lb   $t5, ($t3)             # Load character from end pointer
        bne  $t4, $t5, not_palin    # If mismatch, not a palindrome
        addi $t0, $t0, 1            # Move start pointer forward
        addi $t3, $t3, -1           # Move end pointer backward
        j    check_palin

    not_palin:
        li   $v0, 0                 # Set return value to 0 (not a palindrome)

    done_check:
        jr   $ra                    # Return to caller
