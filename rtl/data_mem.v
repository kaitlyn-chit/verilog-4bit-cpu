// Data memory — the CPU's filing cabinet, 16 addressable 4-bit slots.
// Read: combinational, always shows mem[addr] instantly (like instr_mem.v).
// Write: sequential, only updates mem[addr] on a clock edge when ena=1.
// Role in CPU: LOAD/ADD/SUB/etc. read from here; STORE writes back into it.

module data_mem(
    input clk,
    input ena,
    input [3:0] addr,
    input [3:0] data_in,
    output [3:0] data_out
);

    // 16 separate 4-bit storage slots, indexed 0 through 15
    reg [3:0] mem [0:15];
    
    always @(posedge clk) begin
        if (ena)
            mem[addr] <= data_in;      
    end

    assign data_out = mem[addr];


endmodule