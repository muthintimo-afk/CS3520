# CS3520 Lab 3 — Datapath Analysis Notes

## Step 2 — Think Block
* **Question:** Element 14 (Write-back mux) chooses between three candidate results, but the textbook has only a two-way MemtoReg signal. What is the third input, and which instructions cannot work without it?
* **Answer:** The third input is the sequential **PC + 4** return address link path. Unconditional jump instructions (`jal` and `jalr`) absolutely depend on it to save the return address into the link register (`ra`).

## Step 4 — Analysis Questions

### 1. lui and auipc difference
* **Analysis:** Both share the upper immediate format, but the core element making the difference is **ALU operand mux 1 (alu_op1_src)**. For `lui`, it selects a constant `0` (or bypasses PC) to pass the bare immediate through the ALU. For `auipc`, it selects the actual **Program Counter (PC)** value to add it to the shifted immediate.

### 2. sw control signals
* **Analysis:** The single control signal that prevents a register write is **reg_do_write_ctrl (RegWrite) = 0**. While this instruction runs, the write-back multiplexer output is completely ignored because the register file's physical write-enable line is deactivated.

### 3. Branch path logic gate sequence
* **Analysis:** The path flows from the equality/inequality evaluation output of the separate branch comparison block into a **2-input AND gate** (which checks the match condition alongside the control unit's branch signal). The output of this AND gate runs into a **3-input OR gate** (`controlflow_or`), which directly controls the selector line on **`pc_src`**.

### 4. Jumps return address restriction
* **Analysis:** The return address (`PC + 4`) is supplied by input channel 2 of the write-back mux. Neither the ALU nor data memory can supply it because the ALU is fully occupied calculating the destination address (`PC + offset`), and data memory is idle.
## Step 5 — Statistics Panel Analysis
* **CPI Evaluation:** The CPI reported in the single-cycle processor panel is exactly `1.00`. 
* **Design Sacrifice:** According to the CPU Performance Equation CPU Time= Instruction Count(IC)*CPI*CCT. Because every instruction must complete within a single cycle, the clock period is forced to be long enough to accommodate the absolute worst-case critical path (a load instruction `lw` traversing Instruction Memory, Register File, ALU, Data Memory, and Write-Back). This significantly lowers the maximum operational clock frequency.

## Step 6 — Implementation vs. Textbook Diagram

### Finding A: Absence of a Dedicated Branch Target Adder
* **Observation:** The implementation does not feature a dedicated branch adder separate from the ALU.
* **Engineering Justification:** The designer saved hardware area by routing the Program Counter (PC) value through **ALU operand mux 1** (`alu_op1_src`) and the branch offset through **ALU operand mux 2** (`alu_op2_src`). This allows the main ALU to compute the branch target address (\(PC + \text{offset}\)), eliminating an entire 32-bit adder block.

### Finding B: Separate Hardware Comparison Unit
* **Observation:** Instead of subtracting operands in the ALU and relying on a zero flag, a dedicated, separate comparison unit handles branch decisions.
* **Engineering Justification:** A standard zero flag can only easily tell if two numbers are equal (via subtraction resulting in zero). Instructions like "less than" (`blt`, `bltu`) or "greater than or equal" (`bge`, `bgeu`) require signed and unsigned inequality evaluations. A dedicated comparison unit handles all these conditions directly, reducing critical path delay.

### Finding C: Three-Input Write-Back Multiplexer
* **Observation:** The `reg_wr_src` multiplexer has three inputs instead of the standard textbook two-input version.
* **Engineering Justification:** The third input path feeds the sequential **PC + 4** address directly back to the register file. Unconditional jump instructions (`jal` and `jalr`) require this path to save the return address into the link register (`ra`) while the main ALU is simultaneously tied up calculating the target jumping address.
