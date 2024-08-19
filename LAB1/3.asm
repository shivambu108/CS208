#SHIVAMBU DEV PANDEY
#23BCS123
#CSE B
#LAB 1
#PROGRAM 3 : Add 3 and 4 , and save the value in register
#Date: 12/08/2024

.data
.text
.globl main

main:
li $t0, 3             
li $t1, 4             
add $t2, $t0, $t1     
li $v0, 10            
syscall
