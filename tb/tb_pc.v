module tb_pc;
    reg clk_tb;
    reg reset_tb;
    reg jump_ena_tb;
    reg [3:0] jump_addr_tb;
    wire [3:0] pc_out_tb; 

    pc uut (
    .clk(clk_tb),
    .reset(reset_tb),
    .jump_ena(jump_ena_tb),
    .jump_addr(jump_addr_tb),
    .pc_out(pc_out_tb)
    );

    initial begin
    clk_tb = 0;
    forever #5 clk_tb = ~clk_tb;
    end

    initial begin
        // TEST: reset overrides jump
        reset_tb = 1'b1; jump_ena_tb = 1'b1; jump_addr_tb = 4'b0101;
        @(posedge clk_tb); 
        #1; 
        if (pc_out_tb == 4'b0000)
            $display("PASS: reset overrides jump");
        else
            $display("FAIL: reset overrides jump -- got pc_out=%b", pc_out_tb);
        
        // TEST: count up by 1
        reset_tb = 1'b0; jump_ena_tb = 1'b0; jump_addr_tb = 4'b0101;
        @(posedge clk_tb); 
        #1; 
        if (pc_out_tb == 4'b0001)
            $display("PASS: count up by 1");
        else
            $display("FAIL: count up by 1 -- got pc_out=%b", pc_out_tb);

        // TEST: jump
        reset_tb = 1'b0; jump_ena_tb = 1'b1; jump_addr_tb = 4'b1111;
        @(posedge clk_tb); 
        #1; 
        if (pc_out_tb == 4'b1111)
            $display("PASS: jump");
        else
            $display("FAIL: jump -- got pc_out=%b", pc_out_tb);

        // TEST: PC wraps from 15 to 0 after increment (no jump)
        reset_tb = 1'b0; jump_ena_tb = 1'b0; jump_addr_tb = 4'b0001;
        @(posedge clk_tb); 
        #1; 
        if (pc_out_tb == 4'b0000)
            $display("PASS: pc wraps 15 to 0");
        else
            $display("FAIL: pc wraps 15 to 0 -- got pc_out=%b", pc_out_tb);

        $finish;
    end
endmodule