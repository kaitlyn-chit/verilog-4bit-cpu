// 4-bit accumulator register — synchronous reset, load-enabled
// Sequential — holds its value across clock cycles until explicitly told to load or reset.
// Role in CPU: the one working register (ACC). Stores the running result that ALU operations read from and write back into (e.g. ACC <- ACC + MEM[addr]).

module reg4(
    input clk,
    input reset,
    input load,
    input [3:0] data_in,
    output reg [3:0] data_out
);

    always @(posedge clk) begin
        if (reset)
            data_out <= 4'b0000;
        else if (load)
            data_out <= data_in;
    end

endmodule