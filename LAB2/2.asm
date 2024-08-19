# PROGRAM 2: Area of a Rectangle.
# Date: 19/08/2024

.data
x: .word 15
y: .word 30

.text

.globl main
main:
    la $t2, x
    lw $t0, 0($t2)

    la $t2, y
    lw $t1, 0($t2)

    mul $t3, $t1, $t0

    li $v0, 1
    add $a0, $t3, $0
    syscall

    li $v0, 10
    syscall
