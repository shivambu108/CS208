# PROGRAM 4 : Store 6 numbers. Print even and odd numbers. Also print the average.
# Date: 19/08/2024

.data
numbers: .word 1, 2, 3, 4, 5, 6        # Array 
evenArr: .space 24                     
oddArr: .space 24                      
even_msg: .asciiz "\nEven Numbers: "   
odd_msg: .asciiz "\nOdd Numbers: "     
avg_msg: .asciiz "\nAverage: "         
space: .asciiz " "                     

.text
.globl main
main:
    la $t0, numbers        
    la $t1, evenArr        
    la $t2, oddArr         
    li $t3, 0              # for avg
    li $t4, 6              # Number of elements 

check:
    lw $t5, 0($t0)         
    add $t3, $t3, $t5      
    andi $t6, $t5, 1       # Check 
    
    beq $t6, $zero, even  

odd:
    sw $t5, 0($t2)         # Store in oddArr
    addi $t2, $t2, 4       # Increment odd array address
    j next

even:
    sw $t5, 0($t1)         # Store in evenArr
    addi $t1, $t1, 4       # Increment even array address

next:
    addi $t0, $t0, 4       # next number
    addi $t4, $t4, -1      # Decrement the counter
    bnez $t4, check 

print_even_odd:

    # Print even numbers
    li $v0, 4
    la $a0, even_msg
    syscall

    la $t1, evenArr         # Reset $t1 

print_even:
    lw $t7, 0($t1)         
    beqz $t7, print_odd_msg 
    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t1, $t1, 4       
    j print_even

print_odd_msg:
    # Print odd numbers
    li $v0, 4
    la $a0, odd_msg
    syscall

    la $t2, oddArr          # Reset $t2 

print_odd:
    lw $t7, 0($t2)         
    beqz $t7, print_avg    
    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t2, $t2, 4       
    j print_odd

print_avg:
    li $v0, 4
    la $a0, avg_msg
    syscall

    li $t4, 6              
    div $t3, $t4           
    mflo $a0               

    li $v0, 1              # average
    syscall

    li $v0, 10             # Exit program
    syscall
