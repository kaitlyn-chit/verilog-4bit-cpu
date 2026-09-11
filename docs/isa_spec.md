# Instruction Set Architecture (ISA) Spec

16 instructions (4-bit opcode), 4-bit address. Instruction word: 8 bits total —
[7:4] = opcode, [3:0] = address (unused for register-only ops like NOT/SHL/SHR).
16 memory locations, accumulator-based (one working register, ACC).

All 8 ALU operations are exposed as CPU instructions.

| Opcode | Mnemonic  | Behaviour                        |
|--------|-----------|-----------------------------------|
| 0000   | NOP       | do nothing                        |
| 0001   | LOAD addr | ACC <- MEM[addr]                  |
| 0010   | STORE addr| MEM[addr] <- ACC                  |
| 0011   | JMP addr  | PC <- addr                        |
| 0100   | JZ addr   | if ACC == 0: PC <- addr           |
| 0101   | HALT      | stop                               |
| 0110   | ADD addr  | ACC <- ACC + MEM[addr]            |
| 0111   | SUB addr  | ACC <- ACC - MEM[addr]            |
| 1000   | AND addr  | ACC <- ACC & MEM[addr]            |
| 1001   | OR addr   | ACC <- ACC \| MEM[addr]           |
| 1010   | XOR addr  | ACC <- ACC ^ MEM[addr]            |
| 1011   | NOT       | ACC <- ~ACC (addr unused)         |
| 1100   | SHL       | ACC <- ACC << 1 (addr unused)     |
| 1101   | SHR       | ACC <- ACC >> 1 (addr unused)     |
| 1110-1111 | -      | reserved / unused                 |

## Relevance to modules
- `pc.v` — must support JMP and JZ overriding its normal increment
- `instr_mem.v` — stores programs written using these opcodes
- `control_fsm.v` — decodes the opcode and drives the ALU's op_sel, reg4's load, and pc.v's jump signal for each instruction