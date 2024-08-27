# PROGRAM 5 : MIPS Assembly program to generate Fibonacci Series
# Input: user provided command line argument, a random positive integer, say n
# Calculate the nth, and the next number in the Fibonacci sequence using
# (a) loops, (b) recursion. The two outputs should be in registers $v0, and $v1.
# Date: 26/08/2024

.data
prompt:  .asciiz "Enter the value of n: "
newline: .asciiz "\n"

.text
.globl main

main:
    # Prompt user and read input
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0          # store input n

    # Calculate Fibonacci using loop
    jal fibonacci_loop
    move $t1, $v0          # nth Fibonacci from loop
    move $t2, $v1          # (n+1)th Fibonacci from loop

    # Print loop results (n and n+1)
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Calculate Fibonacci using recursion
    move $a0, $t0
    jal fibonacci_recursive
    move $t3, $v0          # nth Fibonacci from recursion
    move $t4, $v1          # (n+1)th Fibonacci from recursion

    # Print recursion results (n and n+1)
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall

# Fibonacci using loop
fibonacci_loop:
    li $t3, 0              # f(0)
    li $t4, 1              # f(1)
    move $t5, $t0

    beq $t5, 0, loop_end
    beq $t5, 1, loop_end

loop_start:
    sub $t5, $t5, 1
    move $t6, $t4
    add $t4, $t3, $t4      # f(i+1) = f(i) + f(i-1)
    move $t3, $t6          # f(i-1) = previous f(i)

    bgt $t5, 1, loop_start

loop_end:
    move $v0, $t3          # nth Fibonacci
    move $v1, $t4          # (n+1)th Fibonacci
    jr $ra

# Fibonacci using recursion
fibonacci_recursive:
    li $v0, 0
    beq $a0, $v0, recursion_end

    li $v0, 1
    beq $a0, $v0, recursion_end

    addi $a1, $a0, -1
    addi $a2, $a0, -2
    jal fibonacci_recursive  # fib(n-1)
    move $t7, $v0            # store fib(n-1)
    move $t8, $v1            # store fib(n)

    move $a0, $a2
    jal fibonacci_recursive  # fib(n-2)
    add $v0, $t7, $v0        # fib(n) = fib(n-1) + fib(n-2)
    move $v1, $v0            # fib(n+1) = fib(n-1) + fib(n)

recursion_end:
    jr $ra
