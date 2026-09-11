// 4-bit ALU — 8 operations selected via op_sel, see docs/alu_spec.md
// Purely combinational — computes instantly, holds no state.
// Role in CPU: performs the actual computation each time an instruction (e.g. ADD, SUB) executes.

module alu(
    input  [3:0] a,
    input  [3:0] b,
    input  [2:0] op_sel,
    output reg [3:0] result, // declared "output reg" because assigned in an always block
    output zero,
    output reg carry
);

    always @(*) begin
        carry = 1'b0; // default for every op — ADD/SUB override this below
        case(op_sel)
            3'b000: {carry, result} = a + b; // carry = overflow
            3'b001: {carry, result} = a - b; // carry = borrow
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b100: result = a ^ b;
            3'b101: result = ~a;
            3'b110: result = a << 1;
            3'b111: result = a >> 1;
            default: result = 4'b0000;
        endcase
    end

    assign zero = (result == 4'b0000);

endmodule

