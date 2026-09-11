// 4-bit accumulator register — synchronous reset, load-enabled
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