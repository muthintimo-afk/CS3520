# Step 5: New Instruction Format Analysis

## 1. Conditional Branch (B-type Instruction)
- **Instruction Evaluated:** `blt s0, s1, else_branch`
- **Example 32-bit Hex Encoding (from Ripes):** `0x00944c63`
- **Field Breakdown:**
  - `imm[12|10:5]`: `0000000` (Bits 31-25)
  - `rs2` (s1/x9): `01001` (Bits 24-20)
  - `rs1` (s0/x8): `01000` (Bits 19-15)
  - `funct3`: `100` (Bits 14-12, representing BLT)
  - `imm[4:1|11]`: `11000` (Bits 11-7)
  - `opcode`: `1100011` (Bits 6-0, BRANCH opcode)

## 2. Unconditional Jump (J-type Instruction)
- **Instruction Evaluated:** `jal ra, factorial`
- **Example 32-bit Hex Encoding (from Ripes):** `0x01c000ef`
- **Field Breakdown:**
  - `imm[20|10:1|11|19:12]`: `00000001110000000000` (Bits 31-12)
  - `rd` (ra/x1): `00001` (Bits 11-7)
  - `opcode`: `1101111` (Bits 6-0, JAL opcode)

## Why Immediate Fields are Stored in Scattered Pieces
In RISC-V architectures, immediate bits are scrambled across non-contiguous fields to match the exact placement positions of register source specifiers (`rs1`, `rs2`) and destinations (`rd`) used in other layouts like R-type and I-type formats. Keeping these register decoding lines routed to identical, fixed locations simplifies the hardware complexity of the processor's execution control logic, saving physical chip area and accelerating clock cycles.
