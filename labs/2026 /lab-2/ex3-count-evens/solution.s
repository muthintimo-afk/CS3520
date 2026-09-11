.data
array:  .word 10, 7, 4, 9, 12, 5
N:      .word 6

.text
.globl main

main:
    # Load address of array
    la   t0, array

    # Load number of elements
    la   t1, N
    lw   t1, 0(t1)        # t1 = N

    # Initialize
    li   t2, 0            # t2 = index
    li   t3, 0            # t3 = even count

loop:
    # Check if index >= N
    bge  t2, t1, done

    # Load array[index]
    lw   t4, 0(t0)

    # Check if number is even
    andi t5, t4, 1

    # If remainder is 1, number is odd
    bne  t5, zero, not_even

    # Number is even
    addi t3, t3, 1

not_even:
    # Move to next array element
    addi t0, t0, 4

    # index = index + 1
    addi t2, t2, 1

    # Repeat
    j    loop

done:
    # Print even count
    mv   a0, t3
    li   a7, 1
    ecall

    # Exit
    li   a7, 10
    ecall
