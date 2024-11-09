.data
arr:    .space 24               # Reserve space for 6 integers (4 bytes each)
size:   .word 6                # Store the size of the array
prompt: .asciiz "Enter a number: "
space:  .asciiz " "
newline: .asciiz "\n"

.text
.globl main

main:
    la $s0, arr                 # Load the base address of the array into $s0
    lw $s1, size                # Load the array size into $s1
    
    jal read_array              # Call subroutine to read user input
    
    jal bubble_sort             # Call `bubble_sort` subroutine to sort the array
    
    jal print_array             # Call `print_array` subroutine to display the sorted array
    
    li $v0, 10                  # Exit the program
    syscall

# Subroutine to read user input and populate the array
read_array:
    li $t0, 0                   # Counter for array index

input_loop:
    li $v0, 4                   # Syscall code for print string
    la $a0, prompt              # Load address of the prompt message
    syscall                     # Print "Enter a number: "
    
    li $v0, 5                   # Syscall code for read integer
    syscall                     # Read integer from user input
    sw $v0, 0($s0)              # Store the input at the current array index
    
    addi $s0, $s0, 4            # Move to the next position in the array
    addi $t0, $t0, 1            # Increment counter
    bne $t0, $s1, input_loop    # Repeat until we've read `size` elements
    
    jr $ra                      # Return from `read_array`

# Bubble sort subroutine
bubble_sort:
    la $s0, arr                 # Reload base address of array
    lw $s1, size                # Reload array size
    li $t0, 0                   # Initialize outer loop counter
    addi $s1, $s1, -1           # Adjust size for bubble sort passes
    
outer_loop:
    li $t1, 0                   # Initialize inner loop counter
    add $t3, $zero, $s0         # Load the base address of the array into $t3
    addi $s2, $s1, 0            # Copy `s1` to `s2` for inner loop limit
    
inner_loop:
    lw $s3, 0($t3)              # Load the current element into $s3
    addi $t3, $t3, 4            # Move to the next element
    lw $s4, 0($t3)              # Load the next element into $s4
    
    slt $t4, $s4, $s3           # Check if the next element is smaller than the current element
    beq $t4, $zero, no_swap     # If not, skip the swap
    
    # Swap elements
    sw $s3, 0($t3)              # Store the current element in the next element's position
    sw $s4, -4($t3)             # Store the next element in the current position

no_swap:
    addi $t1, $t1, 1            # Increment the inner loop counter
    bne $t1, $s2, inner_loop    # Continue inner loop if `t1` is less than `s2`

    addi $t0, $t0, 1            # Increment the outer loop counter
    bne $t0, $s1, outer_loop    # Continue outer loop if `t0` is less than `s1`
    
    jr $ra                      # Return from `bubble_sort`

# Print array subroutine
print_array:
    li $t0, 0                   # Initialize print counter
    la $t2, arr                 # Load the base address of `arr` into $t2
    lw $s1, size                # Reload array size
    
print_loop:
    li $v0, 1                   # Syscall code for print integer
    lw $a0, 0($t2)              # Load the current array element
    syscall                     # Print integer
    
    li $v0, 4                   # Syscall code for print string
    la $a0, space               # Load address of space character
    syscall                     # Print space
    
    addi $t2, $t2, 4            # Move to the next element in the array
    addi $t0, $t0, 1            # Increment print counter
    bne $t0, $s1, print_loop    # Continue printing until all elements are printed
    
    li $v0, 4                   # Print newline after array
    la $a0, newline
    syscall
    
    jr $ra                      # Return from `print_array`
