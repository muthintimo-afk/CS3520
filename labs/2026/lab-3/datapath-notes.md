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

- **CPI Evaluation:** The CPI reported in the single-cycle processor panel is exactly `1.00`.
- **Design Sacrifice:** According to the CPU Performance Equation ($\text{CPU Time} = \text{Instruction Count (IC)} \times \text{CPI} \times \text{Clock Cycle Time (CCT)}$), because every instruction must complete within a single clock cycle, the clock period is forced to be long enough to accommodate the absolute worst-case critical path (a load instruction `lw` traversing Instruction Memory, Register File, ALU, Data Memory, and Write-Back). This significantly lowers the maximum operational clock frequency by a **factor of roughly 4x to 5x** compared to a pipelined or multi-cycle design where faster instructions do not have to wait for slow memory access stages.

---

## Step 6 — Architectural Implementation Anomalies

### Finding A: Shared ALU Target Computation
- **What the Week 6 Figure Shows:** A dedicated branch adder, separate from the ALU, computing $PC + \text{offset}$.
- **What to Look for in the Implementation:** There is no second adder. The implementation routes the Program Counter (PC) value straight into the primary ALU's first operand multiplexer (`alu_op1_src`). This allows the main ALU to handle branch target address calculations during control-flow execution cycles, reducing the raw transistor area on the physical silicon chip.

### Finding B: Decoupled Logic Comparators
- **What the Week 6 Figure Shows:** `beq` tested by the ALU's `Zero` output flag after a subtraction operation.
- **What to Look for in the Implementation:** There is a separate comparison unit located right next to the register file output lines. This isolated hardware block can evaluate advanced conditional inequalities (like signed and unsigned boundary limits for `blt` and `bge`) without routing traffic down the main ALU, which is necessary for scaling up complex instruction sets efficiently.

### Finding C: Expanded 3-Input Write-Back Mux
- **What the Week 6 Figure Shows:** A standard two-input `MemtoReg` multiplexer selecting between ALU and memory data.
- **What to Look for in the Implementation:** The write-back multiplexer (`reg_wr_src`) features three distinct input ports. The critical third input channel links directly to the sequential **PC Adder (`pc_4` out)** bus line. Unconditional link-and-jump operations (`jal` and `jalr`) depend completely on this third channel to write back the return recovery pointer ($PC + 4$) into the register file.

