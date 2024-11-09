# PROGRAM 2 : Linear search in an array
# Date: 30/09/2024

.data
    array: .space 400           # Reserve space for an array of integers
    size: .word 0                # Holds the number of elements in the array
    p1: .asciiz "Enter number of elements (max 100): "
    p2: .asciiz "Enter element "
    p3: .asciiz ": "
    p4: .asciiz "Enter element to search: "
    mf: .asciiz "Element found at index: "
    mnf: .asciiz "Element not found."

.text
.globl main

main:
    # Print "Enter number of elements (max 100): "
    li $v0, 4
    la $a0, p1
    syscall

    # Read user input for the array size
    li $v0, 5
    syscall
    sw $v0, size                # Store size in the 'size' variable

    # Initialize pointers and counters
    la $t0, array               # Load base address of 'array' into $t0
    lw $t1, size                # Load 'size' into $t1 for loop control
    li $t2, 0                   # Initialize index counter

# Input loop to read array elements
input_loop:
    beq $t2, $t1, end_input     # Check if all elements have been entered

    # Print "Enter element <index>: "
    li $v0, 4
    la $a0, p2
    syscall
    move $a0, $t2               # Load index into $a0 for display
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, p3
    syscall

    # Read the element and store it in the array
    li $v0, 5
    syscall
    sw $v0, ($t0)               # Store input element in array
    addi $t0, $t0, 4            # Move to next array position
    addi $t2, $t2, 1            # Increment the element counter
    j input_loop                # Repeat for the next element

end_input:
    # Ask for the element to search
    li $v0, 4
    la $a0, p4
    syscall
    li $v0, 5
    syscall
    move $a1, $v0               # Store the search element in $a1

    # Set up parameters for linear_search
    la $a0, array               # Base address of array in $a0
    lw $a2, size                # Number of elements in $a2
    jal linear_search           # Call linear_search function

    # Check search result
    move $t0, $v0               # Get the result from linear_search
    li $t1, -1                  # -1 indicates "not found"
    beq $t0, $t1, not_found     # If not found, jump to not_found

    # Element found - print the index
    li $v0, 4
    la $a0, mf
    syscall
    li $v0, 1
    move $a0, $t0               # Print the index where the element was found
    syscall
    j end_program               # End the program

not_found:
    # Print "Element not found."
    li $v0, 4
    la $a0, mnf
    syscall

end_program:
    li $v0, 10                  # Exit program
    syscall

# Linear search function
linear_search:
    li $t0, 0                   # Initialize index counter to 0

search_loop:
    beq $t0, $a2, search_fail   # If all elements checked, fail

    # Calculate address of current element and load it
    sll $t1, $t0, 2             # Multiply index by 4 to get byte offset
    add $t1, $t1, $a0           # Add offset to base address of array
    lw $t2, ($t1)               # Load array element at offset

    # Check if current element matches search element
    beq $t2, $a1, search_success # If match, success

    # Move to the next element
    addi $t0, $t0, 1
    j search_loop               # Repeat for the next element

search_success:
    move $v0, $t0               # Store index of found element in $v0
    jr $ra                      # Return to caller

search_fail:
    li $v0, -1                  # Set $v0 to -1 to indicate "not found"
    jr $ra                      # Return to caller
