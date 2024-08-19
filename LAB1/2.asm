#SHIVAMBU DEV PANDEY
#23BCS123
#CSE B
#LAB 1
#PROGRAM 2 : Swap two numbers using a temporary variable
#Date : 12/08/2024

.data
x: .word 5
y: .word 8
dis1: .asciiz "Original x ="
dis2: .asciiz "Original y ="
dis3: .asciiz "New x ="
dis4: .asciiz "New y ="


.text

.globl main

main:
la $t2, x
lw $t0, 0($t2)

la $t2, y
lw $t1, 0($t2)

# Print original 

li $v0, 4             
la $a0, dis1   #message    
syscall

li $v0, 1             
move $a0, $t0
syscall
li $v0, 11
li $a0, 10            
syscall

li $v0, 4             
la $a0, dis2   #message  
syscall

li $v0, 1             
move $a0, $t1         
syscall
li $v0, 11
li $a0, 10            
syscall

move $t2, $t0
move $t0, $t1
move $t1, $t2

# Print new 
li $v0, 4             
la $a0, dis3   #message  
syscall

li $v0, 1             
move $a0, $t0
syscall
li $v0, 11
li $a0, 10            
syscall

li $v0, 4             
la $a0, dis4   #message  
syscall

li $v0, 1             
move $a0, $t1         
syscall
li $v0, 11
li $a0, 10            
syscall



li $v0, 10            # Exit program
syscall