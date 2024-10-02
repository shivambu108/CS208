# PROGRAM 3 : Sum of digits of a number
# Date: 30/09/2024

.data
    p: .asciiz "Enter a non-negative integer: "
    e: .asciiz "Error: Please enter a non-negative integer.\n"
    r: .asciiz "Sum of digits: "

.text
.globl main

main:
    li $v0, 4
    la $a0, p
    syscall
    li $v0, 5
    syscall
    move $a0, $v0
    bltz $a0, error
    jal sum_of_digits
    move $t0, $v0  
    li $v0, 4
    la $a0, r
    syscall
    li $v0, 1
    move $a0, $t0  
    syscall
    j exit

error:
    li $v0, 4
    la $a0, e
    syscall
    j main

exit:
    li $v0, 10
    syscall

sum_of_digits:
    li $v0, 0
sum_loop:
    beqz $a0, sum_done
    li $t0, 10
    div $a0, $t0
    mfhi $t1
    mflo $a0
    add $v0, $v0, $t1
    j sum_loop
sum_done:
    jr $ra