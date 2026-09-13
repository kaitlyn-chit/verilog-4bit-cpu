# Control Unit FSM Spec

## States
- **Fetch** — reads instr_mem[pc_out] into an instruction register
- **Decode** — splits the instruction into opcode (bits [7:4]) and address (bits [3:0])
- **Execute** — drives control signals for one cycle, based on the decoded opcode
- **Halted** — terminal state, entered only when opcode == HALT; no exit except reset

## Diagram
See docs/fsm_diagram_v2.png

## Control signal table (Execute state, by opcode)
| Opcode | alu.op_sel | reg4.load  | data_mem.ena  | pc.jump_ena  |
|--------|------------|------------|---------------|--------------|
| LOAD   | n/a        | 1          | 0 (read)      | 0            |
| STORE  | n/a        | 0          | 1 (write)     | 0            |
| ADD    | 000        | 1          | 0             | 0            |
| SUB    | 001        | 1          | 0             | 0            |
| AND    | 010        | 1          | 0             | 0            |
| OR     | 011        | 1          | 0             | 0            |
| XOR    | 100        | 1          | 0             | 0            |
| NOT    | 101        | 1          | 0             | 0            |
| SHL    | 110        | 1          | 0             | 0            |
| SHR    | 111        | 1          | 0             | 0            |
| JMP    | n/a        | 0          | 0             | 1            |
| JZ     | n/a        | 0          | 0             | 1 (if ACC==0)|
| HALT   | n/a        | 0          | 0             | 0            |
| NOP    | n/a        | 0          | 0             | 0            |