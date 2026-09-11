module tb_reg4;
    reg clk_tb;
    reg reset_tb;
    reg load_tb;
    reg [3:0] data_in_tb;
    wire [3:0] data_out_tb; // coming out of the DUT must be wire

    reg4 uut (
    .clk(clk_tb),
    .reset(reset_tb),
    .load(load_tb),
    .data_in(data_in_tb),
    .data_out(data_out_tb)
    );

    initial begin
    clk_tb = 0;
    forever #5 clk_tb = ~clk_tb;
    end

    initial begin
    // TEST: reset overrides load — even with load=1, reset=1 should force data_out to 0
        reset_tb = 1'b1; load_tb = 1'b1; data_in_tb = 4'b0001;
        @(posedge clk_tb); 
        #1; // small safty pause before reading data_out_tb
        if (data_out_tb == 4'b0000)
            $display("PASS: reset overrides load");
        else
            $display("FAIL: reset overrides load -- got data_out=%b", data_out_tb);

    // TEST: load asserted, data_in should pass through to data_out
        reset_tb = 1'b0; load_tb = 1'b1; data_in_tb = 4'b0101;
        @(posedge clk_tb); 
        #1; 
        if (data_out_tb == 4'b0101)
            $display("PASS: loading data_in = data_out");
        else
            $display("FAIL: loading -- data_in =%b but data_out=%b", data_in_tb, data_out_tb);
    
    // TEST: load de-asserted — data_out should hold previous value (0101)
        reset_tb = 1'b0; load_tb = 1'b0; data_in_tb = 4'b0011;
        @(posedge clk_tb); 
        #1; 
        if (data_out_tb == 4'b0101)
            $display("PASS: holds value when load=0");
        else
            $display("FAIL: holds value when load=0 -- got data_out=%b", data_out_tb);

    // TEST: reset from a known nonzero state — data_out was 0101 (Test 3)
        reset_tb = 1'b1; load_tb = 1'b0; data_in_tb = 4'b0001;
        @(posedge clk_tb); 
        #1; 
        if (data_out_tb == 4'b0000)
            $display("PASS: reset overrides known nonzero value");
        else
            $display("FAIL: reset overrides known nonzero value -- got data_out=%b", data_out_tb);
    
    $finish;
    end
endmodule