.data
numbers: .space 24                  # Reserve space for 6 integers
evenArr: .space 24                  # Space for even numbers
oddArr: .space 24                   # Space for odd numbers
even_msg: .asciiz "\nEven Numbers: "
odd_msg: .asciiz "\nOdd Numbers: "
avg_msg: .asciiz "\nAverage: "
space: .asciiz " "
input_prompt: .asciiz "Enter a number: "

.text
.globl main
main:
    la $t0, numbers                 # Load address of numbers array
    li $t4, 6                       # Number of elements to read

input_loop:
    li $v0, 4                       # Syscall to print string
    la $a0, input_prompt            # Address of input_prompt
    syscall

    li $v0, 5                       # Syscall to read integer
    syscall
    sw $v0, 0($t0)                  # Store the input in numbers array
    addi $t0, $t0, 4                # Move to the next array slot
    addi $t4, $t4, -1               # Decrement count
    bnez $t4, input_loop            # Repeat until 6 numbers are entered

    # Reset for processing
    la $t0, numbers                 # Reload address of numbers array
    la $t1, evenArr                 # Load address of evenArr
    la $t2, oddArr                  # Load address of oddArr
    li $t3, 0                       # Initialize sum for average calculation
    li $t4, 6                       # Reset number of elements count
    li $t8, 0                       # Even count
    li $t9, 0                       # Odd count

check:
    lw $t5, 0($t0)                  # Load current number
    add $t3, $t3, $t5               # Add to sum
    andi $t6, $t5, 1                # Check if even or odd
    
    beq $t6, $zero, even            # If even, jump to even

odd:
    sw $t5, 0($t2)                  # Store in oddArr
    addi $t2, $t2, 4                # Increment odd array address
    addi $t9, $t9, 1                # Increment odd count
    j next

even:
    sw $t5, 0($t1)                  # Store in evenArr
    addi $t1, $t1, 4                # Increment even array address
    addi $t8, $t8, 1                # Increment even count

next:
    addi $t0, $t0, 4                # Next number
    addi $t4, $t4, -1               # Decrement the counter
    bnez $t4, check                 # Repeat until all numbers are checked

print_even_odd:

    # Print even numbers
    li $v0, 4
    la $a0, even_msg
    syscall

    la $t1, evenArr                 # Reset $t1 to start of evenArr
    move $t4, $t8                   # Load even count

print_even:
    beqz $t4, print_odd_msg         # If count is zero, move to print odd numbers
    lw $t7, 0($t1)                  # Load next even number
    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t1, $t1, 4               # Move to the next evenArr element
    addi $t4, $t4, -1              # Decrement even count
    j print_even

print_odd_msg:
    # Print odd numbers
    li $v0, 4
    la $a0, odd_msg
    syscall

    la $t2, oddArr                 # Reset $t2 to start of oddArr
    move $t4, $t9                  # Load odd count

print_odd:
    beqz $t4, print_avg            # If count is zero, move to average
    lw $t7, 0($t2)                 # Load next odd number
    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t2, $t2, 4               # Move to the next oddArr element
    addi $t4, $t4, -1              # Decrement odd count
    j print_odd

print_avg:
    li $v0, 4
    la $a0, avg_msg
    syscall

    li $t4, 6                      # Total number of elements
    div $t3, $t4                   # Divide sum by number of elements
    mflo $a0                       # Move quotient to $a0

    li $v0, 1                      # Print average
    syscall

    li $v0, 10                     # Exit program
    syscall
