# cpu.v — Top-Level Integration Spec

Wires all six modules together: pc, instr_mem, data_mem, alu, reg4, control_fsm.
No new computation happens here except two small pieces of glue logic
(the LOAD mux, and the acc_zero comparison) — everything else is just
connecting existing, already-verified modules.

## Glue logic (lives in cpu.v, not in any module)
- `is_load = (instr[7:4] == LOAD)` — detects whether the current instruction is LOAD
- `reg_data_in = is_load ? data_mem_out : alu_result` — the accumulator's next value
  comes straight from data memory for LOAD, or from the ALU for every other operation
- `acc_zero = (acc_out == 0)` — feeds control_fsm's JZ condition

## Signal map

| Wire | Source (drives it) | Destination(s) (reads it) | Purpose |
|---|---|---|---|
| `pc_out` | `pc_inst` | `instr_mem_inst.addr` | current instruction address |
| `instr` | `instr_mem_inst` | `control_fsm_inst.instr`, decoded locally | the fetched instruction word |
| `instr[3:0]` | part of `instr` | `pc_inst.jump_addr`, `data_mem_inst.addr` | address field — jump target or memory folder |
| `instr[7:4]` | part of `instr` | used to compute `is_load` | opcode field |
| `acc_out` | `reg4_inst` | `alu_inst.a`, `data_mem_inst.data_in`, `acc_zero` | the accumulator's current value |
| `data_mem_out` | `data_mem_inst` | `alu_inst.b`, the LOAD mux | value read from memory |
| `alu_result` | `alu_inst` | the LOAD mux | ALU's computed result |
| `reg_data_in` | the LOAD mux | `reg4_inst.data_in` | accumulator's next value |
| `acc_zero` | computed locally | `control_fsm_inst.acc_zero` | is ACC currently 0? (for JZ) |
| `alu_op_sel` | `control_fsm_inst` | `alu_inst.op_sel` | which ALU operation to perform |
| `reg_load` | `control_fsm_inst` | `reg4_inst.load` | capture a new accumulator value this cycle? |
| `mem_ena` | `control_fsm_inst` | `data_mem_inst.ena` | write to data memory this cycle? |
| `pc_jump_ena` | `control_fsm_inst` | `pc_inst.jump_ena` | override PC's normal +1 this cycle? |
