module tb_cpu;
    reg clk_tb;
    reg reset_tb;
    wire [3:0] acc_out_tb;
    wire [3:0] pc_out_tb;

    cpu uut (
        .clk(clk_tb),
        .reset(reset_tb),
        .acc_out(acc_out_tb),
        .pc_out(pc_out_tb)
    );

    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end

    initial begin
        reset_tb = 1;
        @(posedge clk_tb); #1;
        reset_tb = 0;

        // each instruction takes 3 states (Fetch/Decode/Execute) = 3 clock edges.
        // the loop runs 3 times before hitting HALT — run generously to be safe.
        repeat (60) @(posedge clk_tb);
        #1;

        if (acc_out_tb == 4'b0000)
            $display("PASS: countdown loop finished, ACC = 0");
        else
            $display("FAIL: countdown loop -- got acc_out=%b", acc_out_tb);

        $display("Final PC = %d, ACC = %d", pc_out_tb, acc_out_tb);
        $finish;
    end
endmodule