# PROGRAM 1 : Area of a Square.
# Date: 19/08/2024

.data
    x: .word 10

.text

.globl main
main:
    la $t2, x
    lw $t0, 0($t2)

    mul $t3, $t0, $t0

    li $v0, 1
    add $a0, $t3, $0
    syscall

    li $v0, 10
    syscall
