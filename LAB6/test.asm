# Data section: Declaring variables and strings
.data
    array: .space 400      # Reserve 400 bytes (100 integers * 4 bytes each)
    size: .word 0          # Variable to store array size
    p1: .asciiz "Enter number of elements (max 100): "
    p2: .asciiz "Enter element "
    p3: .asciiz ": "
    p4: .asciiz "Enter element to search: "
    mf: .asciiz "Element found at index: "
    mnf: .asciiz "Element not found."
    me: .asciiz "Error: Array not in ascending order."

# Code section
.text
.globl main
main:
    # Get the size of array from user
    li $v0, 4             # System call code for print_string
    la $a0, p1            # Load address of prompt
    syscall
    li $v0, 5             # System call code for read_integer
    syscall
    sw $v0, size          # Store size in memory
    la $t0, array         # $t0 = base address of array
    move $t1, $v0         # $t1 = size (counter for loop)
    li $t2, 0             # $t2 = current index (0)

# Loop to input array elements
input_loop:
    beq $t2, $t1, check_array    # If index == size, exit loop
    # Print "Enter element "
    la $a0, p2
    li $v0, 4
    syscall
    # Print current index
    move $a0, $t2
    li $v0, 1
    syscall
    # Print ": "
    la $a0, p3
    li $v0, 4
    syscall
    # Read integer input
    li $v0, 5
    syscall
    sw $v0, ($t0)         # Store integer in array
    addi $t0, 4           # Move to next array position
    addi $t2, 1           # Increment index
    j input_loop

# Check if array is in ascending order
check_array:
    la $t0, array         # Reset to array start
    addi $t1, -1          # Decrease size by 1 for comparison
check_loop:
    beqz $t1, search_prep # If done checking, prepare for search
    lw $t3, ($t0)         # Load current element
    lw $t4, 4($t0)        # Load next element
    bgt $t3, $t4, error_exit  # If current > next, array not ascending
    addi $t0, 4           # Move to next element
    addi $t1, -1          # Decrement counter
    j check_loop

# Prepare for binary search
search_prep:
    # Get search element from user
    la $a0, p4
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $a1, $v0         # $a1 = search value
    la $a0, array         # $a0 = array base address
    lw $a2, size          # $a2 = array size
    li $t0, 0             # $t0 = left index
    addi $t1, $a2, -1     # $t1 = right index

# Binary search implementation
search_loop:
    bgt $t0, $t1, not_found   # If left > right, element not found
    add $t2, $t0, $t1         # $t2 = left + right
    srl $t2, $t2, 1           # $t2 = (left + right)/2 (mid point)
    sll $t3, $t2, 2           # $t3 = mid * 4 (byte offset)
    add $t3, $t3, $a0         # $t3 = address of middle element
    lw $t4, ($t3)             # $t4 = value at middle
    beq $t4, $a1, found       # If middle element = search value, found
    blt $t4, $a1, search_right # If middle < search value, search right half
    addi $t1, $t2, -1         # Else search left half
    j search_loop

# Search right half of array
search_right:
    addi $t0, $t2, 1          # left = mid + 1
    j search_loop

# Element found handling
found:
    la $a0, mf                # Load "Found" message
    li $v0, 4
    syscall
    move $a0, $t2             # Print index where found
    li $v0, 1
    j exit

# Element not found handling
not_found:
    la $a0, mnf               # Load "Not found" message
    li $v0, 4
    j exit

# Error handling for non-ascending array
error_exit:
    la $a0, me                # Load error message
    li $v0, 4

# Program exit
exit:
    syscall                   # Print final message
    li $v0, 10               # Exit program
    syscall