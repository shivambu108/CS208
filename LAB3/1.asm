# PROGRAM 1 : MIPS Assembly program to sort the given numbers using the bubble sort algorithm. (use subroutine bubble)
# Date: 26/08/2024

.data
arr:    .word 10, 60, 40, 70, 20, 30, 90, 100, 0, 80, 50
space:  .asciiz " "

.text
.globl main

main:
    la $s0, arr         
    li $s1, 11
    
    jal bubble_sort
    
    jal print_array
    
    li $v0, 10
    syscall

bubble_sort:
    li $t0, 0
    addi $s1, $s1, -1
    
outer_loop:
    li $t1, 0
    add $t3, $zero, $s0
    addi $s2, $s1, 0

inner_loop:
    lw $s3, 0($t3)
    addi $t3, $t3, 4
    lw $s4, 0($t3)
    
    slt $t4, $s4, $s3
    beq $t4, $zero, no_swap
    
    # Swap elements
    sw $s3, 0($t3)
    sw $s4, -4($t3)

no_swap:
    addi $t1, $t1, 1
    bne $t1, $s2, inner_loop

    addi $t0, $t0, 1
    bne $t0, $s1, outer_loop
    
    jr $ra

print_array:
    li $t0, 0
    add $t2, $zero, $s0
    addi $s1, $s1, 1
    
print_loop:
    li $v0, 1
    lw $a0, 0($t2)
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    addi $t2, $t2, 4
    addi $t0, $t0, 1
    bne $t0, $s1, print_loop
    
    jr $ra