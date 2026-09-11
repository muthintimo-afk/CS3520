#Lab 2 Ex1:solution.s.placeholder
#RISC-V code will go here later
.data
num1:   .word 25
num2:   .word 42

.text
.globl main

main:
    # Load addresses of num1 and num2
    la   t0, num1
    la   t1, num2

    # Load the two numbers
    lw   t2, 0(t0)       # t2 = num1
    lw   t3, 0(t1)       # t3 = num2

    # Compare t2 and t3
    bge  t2, t3, num1_larger

    # If we get here, num2 is larger
    mv   a0, t3
    j    print

num1_larger:
    mv   a0, t2

print:
    # Print integer in Ripes
    li   a7, 1
    ecall

    # Exit program
    li   a7, 10
    ecall
