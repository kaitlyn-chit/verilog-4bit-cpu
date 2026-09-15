# 4-Bit Verilog CPU

A 4-bit ALU built in Verilog, with a control-unit FSM and mini-CPU planned as the next layer. Built as a hardware/RTL portfolio project.

## Status
- [x] **Layer 1 — ALU**: complete, tested, tagged [`v0.1-alu`](../../releases/tag/v0.1-alu)
- [x] **Layer 2 — CPU + FSM**: in progress
  - [x] Accumulator register (`reg4.v`) — 4 test cases passing (reset priority, load, hold, reset-from-nonzero)
  - [x] Program counter (`pc.v`) — tagged [`v0.15-registers`](../../releases/tag/v0.15-registers)
  - [x] Instruction/data memory — tagged [`v0.2-datapath`](../../releases/tag/v0.2-datapath)
  - [x] Control unit FSM — tagged [`v0.3-control`](../../releases/tag/v0.3-control)
  - [x] Top-level integration

## Design docs
- [`docs/alu_spec.md`](docs/alu_spec.md) — ALU operation table
- [`docs/isa_spec.md`](docs/isa_spec.md) — full 16-instruction ISA
- [`docs/datapath_spec.md`](docs/datapath_spec.md) — datapath module overview
- [`docs/control_fsm_spec.md`](docs/control_fsm_spec.md) — FSM states, diagram, control signal table
- [`docs/cpu_spec.md`](docs/cpu_spec.md) — top-level wiring, full signal map

## Architecture
- **ALU** (`rtl/alu.v`) — combinational, 8 operations
- **Accumulator** (`rtl/reg4.v`) — the CPU's one working register
- **Program counter** (`rtl/pc.v`) — increments or jumps
- **Instruction memory** (`rtl/instr_mem.v`) — fixed program storage
- **Data memory** (`rtl/data_mem.v`) — 16-slot read/write storage
- **Control unit** (`rtl/control_fsm.v`) — Fetch/Decode/Execute/Halted FSM, decodes each opcode
- **`rtl/cpu.v`** — wires everything together

## Testing
Every module has its own self-checking testbench in `/tb`. `tb_cpu.v` runs a full countdown-loop program end-to-end and confirms the CPU reaches the correct final state.

### How to run
1. Go to [EDA Playground](https://edaplayground.com)
2. Paste the relevant `rtl/*.v` files (see each testbench's header for dependencies) into Design
3. Paste the matching `tb/tb_*.v` file into Testbench
4. Select Icarus Verilog, click Run

## Possible next steps
- Freeze the PC once HALTED (currently it keeps incrementing harmlessly in the background)
- Synthesize on real FPGA hardware
