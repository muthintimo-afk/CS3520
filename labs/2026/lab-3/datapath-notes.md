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
