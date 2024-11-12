.data
choose_method: .asciiz "Choose method (0-iterative/1-recursive): "
error: .asciiz "Invalid! Try again\n"
enter_n: .asciiz "Enter n: "
newline: .asciiz "\n"

.text
.globl main
#-------------------- Main Program Flow --------------------#
main:
input:  # Get and validate method choice (0 or 1)
    li $v0, 4            # Print method prompt
    la $a0, choose_method
    syscall
    li $v0, 5            # Get user's choice
    syscall
    bltz $v0, retry      # Check if choice < 0
    bgt $v0, 1, retry    # Check if choice > 1
    move $s0, $v0        # Save valid choice
    j get_n              # Proceed to get n
retry:  # Handle invalid input
    li $v0, 4            # Print error message
    la $a0, error
    syscall
    j input              # Try again
    
get_n:  # Get the Fibonacci number position
    li $v0, 4            # Print n prompt
    la $a0, enter_n
    syscall
    li $v0, 5            # Read n
    syscall
    move $a0, $v0        # Save n in $a0
    beqz $s0, iter       # If choice=0, use iterative
    jal recur            # If choice=1, use recursive
    j print              # Print results

iter:   jal iter_fib     # Call iterative function
print:  # Print both Fibonacci numbers
    move $t0, $v0        # Save nth number
    move $t1, $v1        # Save (n+1)th number
    move $a0, $t0        # Print nth number
    li $v0, 1
    syscall
    li $a0, 10           # Print newline
    li $v0, 11
    syscall
    move $a0, $t1        # Print (n+1)th number
    li $v0, 1
    syscall
    li $v0, 10           # Exit program
    syscall

#-------------------- Iterative Method --------------------#
iter_fib:    # Calculate Fibonacci iteratively
    beqz $a0, ret0_i     # If n=0, return (0,1)
    beq $a0, 1, ret1_i   # If n=1, return (1,1)
    li $t1, 0            # f(n-2) = 0
    li $t2, 1            # f(n-1) = 1
    li $t4, 0            # counter = 0
loop:   
    bge $t4, $a0, end_i  # If counter >= n, end
    add $t3, $t1, $t2    # next_fib = f(n-2) + f(n-1)
    move $t1, $t2        # f(n-2) = f(n-1)
    move $t2, $t3        # f(n-1) = next_fib
    addi $t4, $t4, 1     # counter++
    j loop
end_i:  
    move $v0, $t1    # Return nth number
    move $v1, $t2        # Return (n+1)th number
    jr $ra
ret0_i: 
    li $v0, 0        # Return (0,1) for n=0
    li $v1, 1
    jr $ra
ret1_i: 
    li $v0, 1        # Return (1,1) for n=1
    li $v1, 1
    jr $ra

#-------------------- Recursive Method --------------------#
recur:  # Calculate Fibonacci recursively
    addi $sp, $sp, -16   # Save registers
    sw $ra, 0($sp)       # Save return address
    sw $s0, 4($sp)       # Save n
    sw $s1, 8($sp)       # Save f(n-1)
    sw $s2, 12($sp)      # Save f(n)
    move $s0, $a0        # Store n
    beqz $s0, ret0_r     # If n=0, return (0,1)
    beq $s0, 1, ret1_r   # If n=1, return (1,1)
    addi $a0, $s0, -1    # Calculate f(n-1)
    jal recur
    move $s1, $v0        # Save f(n-1)
    move $s2, $v1        # Save f(n)
    addi $a0, $s0, -2    # Calculate f(n-2)
    jal recur
    add $v0, $v0, $s1    # f(n) = f(n-2) + f(n-1)
    add $v1, $s1, $s2    # f(n+1) = f(n-1) + f(n)
ret_r:  lw $ra, 0($sp)   # Restore registers
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addi $sp, $sp, 16
    jr $ra
ret1_r: li $v0, 1        # Return (1,1) for n=1
    li $v1, 1
    j ret_r
ret0_r: li $v0, 0        # Return (0,1) for n=0
    li $v1, 1
    j ret_r