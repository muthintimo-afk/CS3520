.data
N:      .word 10

.text
.globl main

main:
    # Load N from memory
    la   t0, N
    lw   t1, 0(t0)       # t1 = N

    # Initialize
    li   t2, 1           # t2 = i = 1
    li   t3, 0           # t3 = sum = 0

loop:
    # Check if i > N
    bgt  t2, t1, done

    # sum = sum + i
    add  t3, t3, t2

    # i = i + 1
    addi t2, t2, 1

    # Repeat loop
    j    loop

done:
    # Move sum to a0 for printing
    mv   a0, t3

    # Print integer
    li   a7, 1
    ecall

    # Exit
    li   a7, 10
    ecall
