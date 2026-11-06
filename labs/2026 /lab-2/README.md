# Lab 2 Discussion Questions (Step 2)

### 1. The C++ loop says `i < n`, but the assembly branches on `bge` (i >= n). Why must the test be inverted?
In high-level languages like C++, a loop condition specifies the criteria required for the loop body to keep running. In assembly, branch instructions like `bge` are used to determine when to jump *out* of the sequential execution path. Therefore, the condition must be inverted to tell the processor when to exit the loop early and jump to the termination label.

### 2. Compare your source with machine code for pseudo-instructions (li, mv, la, ble). Why does the assembler provide them?
- `li` (Load Immediate) expands into an `addi` or a combination of `lui` and `addi`.
- `mv` (Move) translates directly into an `addi rd, rs, 0`.
- `la` (Load Address) expands into an `auipc` and `addi` sequence to calculate a PC-relative address.
- `ble` (Branch Less Than or Equal) is synthesized using a combination of `slt` (Set Less Than) and a conditional branch like `bnez` or `beqz`.

The assembler provides pseudo-instructions to improve code readability and simplify programming, allowing engineers to write intuitive operations without manually calculating complex multi-instruction operations or register configurations.

### 3. `find_max` saves `s1` on the stack but does not save `ra`. Explain why both decisions are correct.
- **Saving `s1` is correct** because `s1` belongs to the callee-saved register class (`s0`-`s11`). The RISC-V calling convention mandates that if a subroutine modifies a callee-saved register, it must preserve its original value on the stack and restore it before returning so the caller's data isn't corrupted.
- **Not saving `ra` is correct** because `find_max` is a leaf procedure (it does not call any subsequent functions inside itself). Since no internal `jal` instructions overwrite the `ra` register, its contents remain completely intact, and it can safely be used to jump directly back to the caller at execution termination without consuming stack space.
