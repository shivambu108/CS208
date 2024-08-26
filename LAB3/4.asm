# PROGRAM 4 : MIPS Assembly program to compute the GCD and LCM of the two numbers and store the result. (use subroutines gcd and lcm )
# Date: 26/08/2024

.data
num1: .word 12
num2: .word 15
space: .asciiz " "

.text
main:
    la $t0, num1
    lw $a0, 0($t0)
    la $t0, num2
    lw $a1, 0($t0)
    jal gcd
    
    move $s0, $v0  

    la $t0, num1
    lw $a0, 0($t0)
    la $t0, num2
    lw $a1, 0($t0)
    move $a2, $s0  
    jal lcm
    move $s1, $v0  

    move $a0, $s0  
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, space
    syscall

    move $a0, $s1  
    li $v0, 1
    syscall

    li $v0, 10
    syscall

gcd:
    beq $a0, $a1, gcd_end
    blt $a0, $a1, gcd_swap
    sub $a0, $a0, $a1
    j gcd

    gcd_swap:
        move $t3, $a0
        move $a0, $a1
        move $a1, $t3
        j gcd
    gcd_end:
        move $v0, $a0
    jr $ra

lcm:
    beqz $a0, lcm_zero   
    beqz $a1, lcm_zero   

    multu $a0, $a1       
    mfhi $t4            
    mflo $t5     

    bnez $t4, lcm_overflow

    divu $t5, $a2       
    mflo $v0             
    jr $ra               

    lcm_zero:
        move $v0, $zero      
        jr $ra               

    lcm_overflow:
        li $v0, -1           
        jr $ra                   