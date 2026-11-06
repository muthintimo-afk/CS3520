## Step 3 — Trace One Instruction, Completely

### Instruction Traced: `add t2, t0, t1` at PC = `0x00000008`

| Datapath Element | Port | Value | Notes / Derivation |
| :--- | :--- | :--- | :--- |
| **pc_reg** | out | 0x00000008 | Address of the instruction executing right now. |
| **pc_4** | out | 0x0000000C | Sequentially next instruction location (PC + 4). |
| **instr_mem** | data_out | 0x006283B3 | The 32-bit machine code encoding for this instruction. |
| **decode** | r1_reg_idx / r2_reg_idx | 5 / 6 | Source registers extracted: rs1 = 5 (t0), rs2 = 6 (t1). |
| **decode** | wr_reg_idx | 7 | Destination register extracted: rd = 7 (t2). |
| **control** | reg_do_write_ctrl | 1 | True. Enables writing the result back to the register file. |
| **control** | alu_op2_ctrl | 0 | Mux control signal selecting register file operand over immediate. |
| **registerFile** | r1_out / r2_out | 12 / 5 | Values read from registers t0 (12) and t1 (5). |
| **alu_op1_src** | out | 12 | First operand delivered to ALU (comes from r1_out). |
| **alu_op2_src** | out | 5 | Second operand delivered to ALU (comes from r2_out). |
| **alu** | res | 17 | Result of the addition operation performed (12 + 5). |
| **data_mem** | wr_en | 0 | False. Memory write is disabled since this is an R-type math operation. |
| **reg_wr_src** | select / out | 0 / 17 | Mux selects path 0 (ALU result) to feed back into register write data. |
| **pc_src** | select / out | 0 / 0x0000000C | Mux selects path 0 (PC + 4) because no branching or jumping is taken. |

* **Where did the value on `data_mem.addr` come from?** The value comes directly from the output of the ALU (`alu.res`), which is hardwired to the address port of the data memory.
* **Why is it harmless?** It is entirely harmless because `data_mem.wr_en` is `0` (disabled), meaning the memory controller will ignore the address and won't overwrite or corrupt any data.
* **What is it costing the machine?** It incurs a dynamic power/energy cost. Even though data isn't saved, changing values on the address lines triggers charging and discharging of internal logic and capacitive busses inside the memory hardware block.
## Step 4 — Trace Every Instruction Class

| Instruction | Format | imm | op1 mux | op2 mux | alu.res | wb mux / pc mux |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `addi t0, zero, 12` | I-Type | 12 | 0 (reg) | 12 (imm) | 12 | 0 (ALU) / 0 (PC+4) |
| `add t2, t0, t1` | R-Type | X | 12 (reg) | 5 (reg) | 17 | 0 (ALU) / 0 (PC+4) |
| `lui t4, 0x2B` | U-Type | 0x2B000 | X | 0x2B000 (imm) | 0x2B000 | 0 (ALU) / 0 (PC+4) |
| `auipc t5, 0x0` | U-Type | 0 | 0x00000014 (PC) | 0 (imm) | 0x00000014 | 0 (ALU) / 0 (PC+4) |
| `lw a1, 0(a0)` | I-Type | 0 | 0x10000000 (reg) | 0 (imm) | 0x10000000 | 1 (DataMem) / 0 (PC+4) |
| `sw t2, 4(a0)` | S-Type | 4 | 0x10000000 (reg) | 4 (imm) | 0x10000004 | X / 0 (PC+4) |
| `beq t0, t1, skip` | B-Type | [offset] | 12 (reg) | 5 (reg) | [cmp] | X / 0 (PC+4) |
| `bne t0, t1, target` | B-Type | [offset] | 12 (reg) | 5 (reg) | [cmp] | X / 1 (Branch Target) |
| `jal ra, report` | J-Type | [offset] | 0x00000028 (PC) | [offset] (imm) | [target] | 2 (PC+4) / 1 (Jump Target) |
| `jalr zero, ra, 0` | I-Type | 0 | 0x00000030 (reg) | 0 (imm) | [target] | X / 2 (ALU Target) |


