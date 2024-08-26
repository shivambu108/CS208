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
        beq  $t2, $zero, len_found
        addi $t1, $t1, 1
        addi $t0, $t0, 1
        j    find_len
    len_found:
    move $t2, $t1
    move $t0, $a0
    add  $t3, $a0, $t1
    addi $t3, $t3, -1
    li   $v0, 1
    check_palin:
        bge  $t0, $t3, done_check
        lb   $t4, ($t0)
        lb   $t5, ($t3)
        bne  $t4, $t5, not_palin
        addi $t0, $t0, 1
        addi $t3, $t3, -1
        j    check_palin
    not_palin:
        li   $v0, 0
    done_check:
        jr   $ra
