#PROGRAM 3 : GCD and LCM of two numbers.
#Date: 19/08/2024

.data
x: .word 10
y: .word 17
newline: .asciiz "\n"

.text

.globl main
main:
    la $t2, x
    lw $t0, 0($t2)

    la $t2, y
    lw $t1, 0($t2)

    move $t4, $t0  #original x
    move $t5, $t1  #original y

    gcd:
        beq $t0, $t1, gcdEnd
        blt $t0, $t1, gcdSwap
        sub $t0, $t0, $t1
        j gcd
    gcdSwap:
        move $t3, $t0
        move $t0, $t1
        move $t1, $t3
        j gcd
    gcdEnd:
        move $t6, $t0  #GCD in $t6

    # LCM
    mul $t3, $t4, $t5
    div $t3, $t6
    mflo $t3

    li $v0, 1
    add $a0, $t6, $0   #gcd
    syscall


    li $v0, 4
    la $a0, newline 
    syscall

    li $v0, 1
    add $a0, $t3, $0   #lcm
    syscall    

    li $v0, 10
    syscall
