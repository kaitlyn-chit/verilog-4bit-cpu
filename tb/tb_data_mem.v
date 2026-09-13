module tb_data_mem;
    reg clk_tb;
    reg ena_tb;
    reg [3:0] addr_tb;
    reg [3:0] data_in_tb;
    wire [3:0] data_out_tb; 

    data_mem uut (
        .clk(clk_tb),
        .ena(ena_tb),
        .addr(addr_tb),
        .data_in(data_in_tb),
        .data_out(data_out_tb)
    );

    initial begin
    clk_tb = 0;
    forever #5 clk_tb = ~clk_tb;
    end

    initial begin
        // TEST: write then read back
        ena_tb = 1'b1; addr_tb = 4'b0000; data_in_tb = 4'b1010;
        @(posedge clk_tb); 
        #1; 
        if (data_out_tb == 4'b1010)
            $display("PASS: write then read back");
        else
            $display("FAIL: write then read back -- got data_out=%b", data_out_tb);

        // TEST: write-disabled, value holds
        ena_tb = 1'b0; addr_tb = 4'b0000; data_in_tb = 4'b1111;
        @(posedge clk_tb); 
        #1; 
        if (data_out_tb == 4'b1010)
            $display("PASS: write-disabled, value holds");
        else
            $display("FAIL: write-disabled, value holds -- got data_out=%b", data_out_tb);

        // TEST: writing to a different address doesn't affect address 0
        ena_tb = 1'b1; addr_tb = 4'b0011; data_in_tb = 4'b0110;
        @(posedge clk_tb);
        #1;
        if (data_out_tb == 4'b0110)
            $display("PASS: write to address 3 succeeds");
        else
            $display("FAIL: write to address 3 succeeds -- got data_out=%b", data_out_tb);

        // TEST: address 0 still holds its original value, unaffected by the address-3 write
        ena_tb = 1'b0; addr_tb = 4'b0000;
        @(posedge clk_tb);
        #1;
        if (data_out_tb == 4'b1010)
            $display("PASS: address 0 unaffected by address 3 write");
        else
            $display("FAIL: address 0 unaffected by address 3 write -- got data_out=%b", data_out_tb);
        
        $finish;
    end
endmodule