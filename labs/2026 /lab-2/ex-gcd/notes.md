# Exercise 5: Greatest Common Divisor (GCD)

## Program Description
This program computes the Greatest Common Divisor (GCD) of two integers loaded from memory using Euclid's subtraction method. The algorithm repeatedly subtracts the smaller number from the larger number until both values match, which represents the GCD.

## Register Allocation Map
- `a0`: First input number (`a`), and final returned GCD result
- `a1`: Second input number (`b`)
- `ra`: Return address linkage tracking register

## Challenges Faced
The main conceptual breakthrough was realizing that this is a **leaf procedure** (it does not call any other functions inside itself). Because it only alters the temporary argument registers `a0` and `a1`, it did not require allocating space on the stack or saving/restoring any registers, keeping the prologue and epilogue completely empty and maximizing execution speed.
