#SHIVAMBU DEV PANDEY
#23BCS123
#CSE B
#LAB 1
#PROGRAM 1 : Load two 32b constants onto $t0 and $t1, add them, store in $t2
#Date: 12/08/2024

.data
x: .word 10
y: .word -11

.text

.globl main
main:
la $t2, x
lw $t0, 0($t2)

la $t2, y
lw $t1, 0($t2)

add $t2, $t1, $t0

li $v0, 1             # Print
add $a0, $t2, $0
syscall

li $v0, 10            # Exit program
syscall