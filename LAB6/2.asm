# PROGRAM 2 : Linear search in an array
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

    li $v0, 4
    la $a0, p4
    syscall
    li $v0, 5
    syscall
    move $a1, $v0

    la $a0, array
    lw $a2, size
    jal linear_search

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

end_program:
    li $v0, 10
    syscall

linear_search:
    li $t0, 0
search_loop:
    beq $t0, $a2, search_fail
    sll $t1, $t0, 2
    add $t1, $t1, $a0
    lw $t2, ($t1)
    beq $t2, $a1, search_success
    addi $t0, $t0, 1
    j search_loop
search_success:
    move $v0, $t0
    jr $ra
search_fail:
    li $v0, -1
    jr $ra