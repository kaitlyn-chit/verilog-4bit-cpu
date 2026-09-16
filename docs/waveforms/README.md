# Waveform Screenshots

## tb_alu.png
Purely combinational — result/carry/zero update instantly alongside a/b/op_sel,
with no clock edge required. Proves the ALU has no memory of its own.

## tb_control_fsm.png
`state` visibly cycles 00 (Fetch) -> 01 (Decode) -> 10 (Execute) -> 00, two clock
edges per instruction, then jumps to 11 (Halted) and freezes there once a HALT
instruction is decoded.

## tb_cpu.png
acc_out_tb counts down 3 -> 2 -> 1 -> 0 across the countdown-loop program, with
pc_out_tb correctly holding steady for 3 clock edges per instruction (gated by
pc_en) before advancing -- proving fetch/decode/execute stay synchronized with
the program counter.