# Exercise 1: Larger of Two

## Program Description
This program loads two 32-bit integers (`num1` and `num2`) from the data section, determines which of the two values is greater using a conditional branch, and writes the larger value back into the `larger` memory slot.

## Register Allocation Map
- `t0`: Memory address pointer for `num1`
- `t1`: Memory address pointer for `num2`
- `t2`: Memory address pointer for `larger`
- `s0`: Value of `num1` (loaded from memory)
- `s1`: Value of `num2` (loaded from memory)
- `s2`: The maximum/larger value computed

## Challenges Faced
The main hurdle was remembering to invert the C++ conditional statement. In C++, we express the condition to execute the *if* block (`num1 >= num2`). In assembly, it is more efficient to branch *over* the if block to the *else* block if the condition is false (`num1 < num2`), which requires using `blt`.
