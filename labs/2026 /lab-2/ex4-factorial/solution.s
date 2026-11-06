.data
n:      .word 5            # Input number N
result: .word 0            # Destination for result

.text
.globl main
main:
    # Prepare argument for the procedure
    la t0, n
    lw a0, 0(t0)           # a0 = n (first argument register)

    # Call the factorial procedure
    jal ra, factorial      # Jump to factorial, save return address in ra

    # Store the returned result
    la t1, result
    sw a0, 0(t1)           # Store return value (from a0) into result memory

    # Exit program execution
    li a7, 10              # Ripes exit service code
    ecall

# --- Factorial Procedure ---
factorial:
    # Prologue: Reserve stack space to preserve callee-saved registers
    addi sp, sp, -8        # Allocate 8 bytes on the stack
    sw s0, 4(sp)           # Save s0 to stack
    sw s1, 0(sp)           # Save s1 to stack

    # Initialization
    li s0, 1               # s0 = running product accumulator (fact = 1)
    li s1, 1               # s1 = loop counter (i = 1)

fact_loop:
    bgt s1, a0, fact_done  # If i > num, branch out of the loop
    mul s0, s0, s1         # fact = fact * i
    addi s1, s1, 1         # i++
    j fact_loop            # Repeat loop

fact_done:
    # Move final answer to the return register
    mv a0, s0              # a0 = final product

    #Restore registers from stack
    lw s1, 0(sp)           # Restore s1
    lw s0, 4(sp)           # Restore s0
    addi sp, sp, 8         # Deallocate stack space

    # Return to caller
    jalr x0, 0(ra)         # Jump back to address held in ra
