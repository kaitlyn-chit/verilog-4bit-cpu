# 4-Bit Verilog CPU

A 4-bit ALU built in Verilog, with a control-unit FSM and mini-CPU planned as the next layer. Built as a hardware/RTL portfolio project.

## Status
- [x] **Layer 1 — ALU**: complete, tested, tagged [`v0.1-alu`](../../releases/tag/v0.1-alu)
- [ ] **Layer 2 — CPU + FSM**: in progress
  - [x] Accumulator register (`reg4.v`) — 4 test cases passing (reset priority, load, hold, reset-from-nonzero)
  - [ ] Program counter (`pc.v`) — next
  - [ ] Instruction/data memory
  - [ ] Control unit FSM
  - [ ] Top-level integration

## ALU (`rtl/alu.v`)

A purely combinational 4-bit ALU, 8 operations selected by `op_sel[2:0]`.

Full design notes: [`docs/alu_spec.md`](docs/alu_spec.md)

### Testing
`tb/tb_alu.v` is a self-checking testbench covering all 8 operations (12 test cases total), including edge cases for overflow, borrow, and the zero flag. All tests pass.

### How to run
1. Go to [EDA Playground](https://edaplayground.com)
2. Paste `rtl/alu.v` into the Design panel
3. Paste `tb/tb_alu.v` into the Testbench panel
4. Select Icarus Verilog as the simulator, click Run

## What's next
Building out the CPU layer: a register/accumulator, program counter, instruction & data memory, and a Fetch-Decode-Execute control unit FSM wired around this ALU.
