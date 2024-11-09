# PROGRAM 3 : Sum of digits of a number
# Date: 30/09/2024

.data
    p: .asciiz "Enter a non-negative integer: "       # Prompt message
    e: .asciiz "Error: Please enter a non-negative integer.\n" # Error message
    r: .asciiz "Sum of digits: "                      # Result message

.text
.globl main

main:
    # Display "Enter a non-negative integer: "
    li $v0, 4
    la $a0, p
    syscall

    # Read the integer input from the user
    li $v0, 5
    syscall
    move $a0, $v0            # Move user input to $a0 for further checks

    # Check if input is negative
    bltz $a0, error          # If input is negative, jump to error

    # Call sum_of_digits function to calculate sum
    jal sum_of_digits

    # Store result (sum of digits) in $t0 for output
    move $t0, $v0            

    # Print "Sum of digits: "
    li $v0, 4
    la $a0, r
    syscall

    # Print the calculated sum stored in $t0
    li $v0, 1
    move $a0, $t0            # Move result into $a0 for printing
    syscall

    # Exit program
    j exit

# Error handling if input is negative
error:
    li $v0, 4
    la $a0, e                # Display error message
    syscall
    j main                   # Restart the program to prompt user again

exit:
    li $v0, 10               # Exit syscall
    syscall

# Function to calculate the sum of digits
sum_of_digits:
    li $v0, 0                # Initialize $v0 to hold the sum (accumulator)

sum_loop:
    beqz $a0, sum_done       # If $a0 is 0, all digits have been processed

    # Separate the last digit of $a0
    li $t0, 10               # Load 10 into $t0 for modulus division
    div $a0, $t0             # Divide $a0 by 10
    mfhi $t1                 # Remainder (last digit) in $t1
    mflo $a0                 # Quotient in $a0, removes last digit

    # Add the extracted digit to the sum
    add $v0, $v0, $t1        # Add last digit to sum
    j sum_loop               # Repeat loop for next digit

sum_done:
    jr $ra                   # Return to caller with the sum in $v0
