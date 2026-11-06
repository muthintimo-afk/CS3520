# Exercise 4: Factorial Procedure

## Program Description
This program computes the factorial of an integer `N` loaded from memory. The calculation is isolated within a procedural block called via `jal`. It follows RISC-V calling conventions by passing the input parameter via register `a0` and returning the calculated product back inside `a0`.

## Register Allocation Map
- `a0`: Procedure input argument (`num`) & procedure return register
- `ra`: Return address tracker used by `jal` / `jalr`
- `sp`: Stack pointer used to safely preserve context
- `s0`: Local procedure variable for tracking the running product
- `s1`: Local procedure variable acting as the loop index counter (`i`)

## Challenges Faced
Managing the stack frame correctly was essential. Because the procedure modifies callee-saved registers (`s0` and `s1`), it was mandatory to push their original values onto the stack during the prologue phase and restore them exactly during the epilogue phase before issuing the final `jalr` instruction.
