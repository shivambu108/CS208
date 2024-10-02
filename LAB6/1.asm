# PROGRAM 1 : Binary Search with check for ascending order in an array
# Date: 30/09/2024

.data
    array: .space 400
    size: .word 0
    p1: .asciiz "Enter number of elements (max 100): "
    p2: .asciiz "Enter element "
    p3: .asciiz ": "
    p4: .asciiz "Enter element to search: "
    mf: .asciiz "Element found at index: "
    mnf: .asciiz "Element not found."
    me: .asciiz "Error: Array not in ascending order."
    nl: .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, p1
    syscall
    li $v0, 5
    syscall
    sw $v0, size

    la $t0, array
    lw $t1, size
    li $t2, 0

input_loop:
    beq $t2, $t1, end_input
    li $v0, 4
    la $a0, p2
    syscall
    move $a0, $t2
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, p3
    syscall
    li $v0, 5
    syscall
    sw $v0, ($t0)
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j input_loop
    
end_input:

    jal check_order
    beqz $v0, error

    li $v0, 4
    la $a0, p4
    syscall
    li $v0, 5
    syscall
    move $a1, $v0

    la $a0, array
    lw $a2, size
    jal binary_search

    move $t0, $v0
    li $t1, -1
    beq $t0, $t1, not_found
    li $v0, 4
    la $a0, mf
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    j end_program

not_found:
    li $v0, 4
    la $a0, mnf
    syscall
    j end_program

error:
    li $v0, 4
    la $a0, me
    syscall

end_program:
    li $v0, 10
    syscall

check_order:
    la $t0, array
    lw $t1, size
    addi $t1, $t1, -1
    li $t2, 0
check_loop:
    beq $t2, $t1, check_done
    lw $t3, ($t0)
    lw $t4, 4($t0)
    bgt $t3, $t4, check_fail
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j check_loop
check_fail:
    li $v0, 0
    jr $ra
check_done:
    li $v0, 1
    jr $ra

binary_search:
    li $t0, 0
    addi $t1, $a2, -1
search_loop:
    bgt $t0, $t1, search_fail
    add $t2, $t0, $t1
    srl $t2, $t2, 1
    sll $t3, $t2, 2
    add $t3, $t3, $a0
    lw $t4, ($t3)
    beq $t4, $a1, search_success
    blt $t4, $a1, search_right
    addi $t1, $t2, -1
    j search_loop
search_right:
    addi $t0, $t2, 1
    j search_loop
search_success:
    move $v0, $t2
    jr $ra
search_fail:
    li $v0, -1
    jr $ra