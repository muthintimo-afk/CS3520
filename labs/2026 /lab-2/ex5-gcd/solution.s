.data
num1:   .word 54           # First integer
num2:   .word 24           # Second integer
result: .word 0            # Destination for final GCD

.text
.globl main
main:
    # Prepare arguments for the gcd procedure
    la t0, num1
    lw a0, 0(t0)           # a0 = num1 (Argument 1)
    la t1, num2
    lw a1, 0(t1)           # a1 = num2 (Argument 2)

    # Call the gcd procedure
    jal ra, gcd            # Jump to gcd, save return address in ra

    # Store the returned result
    la t2, result
    sw a0, 0(t2)           # Store return value (from a0) into result

    # Exit program execution
    li a7, 10              # Ripes exit service code
    ecall

# --- GCD Procedure (Iterative Subtraction) ---
gcd:
    # Check for base edge cases
    beqz a0, return_b      # If a = 0, return b
    beqz a1, return_a      # If b = 0, return a

gcd_loop:
    beq a0, a1, gcd_done   # If a == b, loop finished (found GCD)
    blt a0, a1, b_is_larger # If a < b, jump to subtraction block for b

    # If a > b
    sub a0, a0, a1         # a = a - b
    j gcd_loop             # Repeat loop

b_is_larger:
    # If b > a
    sub a1, a1, a0         # b = b - a
    j gcd_loop             # Repeat loop

return_b:
    mv a0, a1              # Move value of b into return register a0
return_a:
    # If returning a, it is already sitting inside a0
gcd_done:
    jalr x0, 0(ra)         # Return to main caller
