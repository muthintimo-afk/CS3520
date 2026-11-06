# Exercise 2: Sum to N Integers

## Program Description
This program calculates the sum of the first N sequential integers (from 1 to N), where the value of N is loaded from a specific variable stored in the `.data` memory section. The result is computed using a counted loop structure and then written back into memory.

## Register Allocation Map
- `t0`: Memory address pointer for the input variable `N`
- `t1`: Memory address pointer for the destination variable `sum`
- `s0`: The loop boundary limit value `N` (loaded from memory)
- `s1`: Loop counter variable `i` (starts at 1 or 0)
- `s2`: Accumulator variable holding the running `sum`

## Challenges Faced
Translating the loop condition required using an inverted branch test. While a high-level loop checks if the counter is less than or equal to N to keep running, the RISC-V implementation uses a `bgt` (branch if greater than) or `bge` instruction to break out of the loop early and jump to the termination block once the counter exceeds N.
