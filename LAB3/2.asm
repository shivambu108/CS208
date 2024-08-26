# PROGRAM 2 : MIPS Assembly program to calculate the area of a rectangle (using subroutine) and exit the program.
# Date: 26/08/2024

.data
length: .word 5       
breadth: .word 3       
area: .word 0         

.text

.globl main 
main:
    la $t0, length
    lw $t1, 0($t0)
    la $t2, breadth
    lw $t3, 0($t2)

    move $a0, $t1      
    move $a1, $t3      
    jal area_of_rectangle

    move $t4, $v0      
    la $t5, area
    sw $t4, 0($t5)     

    li $v0, 1
    la $a0, area
    lw $a0, 0($a0)
    syscall

    li $v0, 10
    syscall

area_of_rectangle:
    mul $v0, $a0, $a1  
    jr $ra