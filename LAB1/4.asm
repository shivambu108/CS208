#SHIVAMBU DEV PANDEY
#23BCS123
#CSE B
#LAB 1
#PROGRAM 4 : Multiplication of two numbers 50 and 60
#Date: 12/08/2024

.data
.text
.globl main

main:
li $t0, 50            
li $t1, 60            
mul $t2, $t0, $t1     

mfhi $t3              
mflo $t4              

li $v0, 10            # Exit program
syscall
