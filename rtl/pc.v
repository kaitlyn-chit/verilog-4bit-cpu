// Program counter — tracks the address of the current instruction.
// Sequential — holds its value across clock cycles like reg4.v.
// Role in CPU: normally counts up by 1 each cycle to advance through the to-do list (instr_mem); overridden by the control unit to jump when the
// current instruction is JMP or JZ (jump_ena=1, jump_addr=destination).
module pc(
    input clk,
    input reset,
    input jump_ena,
    input [3:0] jump_addr,
    output reg [3:0] pc_out 
);

    always @(posedge clk) begin
        if (reset)
            pc_out <= 4'b0000;
        else if (jump_ena)  // control unit says jump — go here instead
            pc_out <= jump_addr;
        else
            pc_out <= pc_out + 1; // truncates silently, wraps 15 -> 0 
    end

endmodule