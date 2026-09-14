// Instruction memory — the CPU's to-do list, fixed at compile time.
// Combinational — given an address (from pc.v), instantly returns the instruction stored there. No memory of its own; purely a lookup table.
// Role in CPU: control_fsm.v will use pc_out (from pc.v) as this module's addr input to fetch each instruction in sequence.

// Program: address = opcode value, one instruction per opcode — demonstrates all 16 slots.
// A real branching program (using JMP/JZ to loop) will replace this once control_fsm.v exists.

`define NOP  4'b0000
`define LOAD  4'b0001
`define STORE 4'b0010
`define JMP   4'b0011
`define JZ    4'b0100
`define HALT  4'b0101
`define ADD   4'b0110
`define SUB   4'b0111
`define AND   4'b1000
`define OR    4'b1001
`define XOR   4'b1010
`define NOT   4'b1011
`define SHL   4'b1100
`define SHR   4'b1101

module instr_mem(
    input  [3:0] addr,
    output reg [7:0] instr
);
    
    always @(*) begin
    case(addr)
        4'd0: instr = {`LOAD, 4'd8};   // ACC <- MEM[8] (counter, starts at 3)
        4'd1: instr = {`SUB,  4'd9};   // ACC <- ACC - MEM[9] (MEM[9] = 1)
        4'd2: instr = {`JZ,   4'd4};   // if ACC == 0, jump to address 4 (done)
        4'd3: instr = {`JMP,  4'd1};   // otherwise, loop back and subtract again
        4'd4: instr = {`HALT, 4'd0};   // stop
        default: instr = {`NOP, 4'd0};
    endcase
end
endmodule

