module tb_instr_mem;
    reg  [3:0] addr_tb;
    wire [7:0] instr_tb;

    instr_mem uut(.addr(addr_tb), .instr(instr_tb));

    initial begin
        // TEST: addr 0 -> LOAD 8
        addr_tb = 4'd0; #10;
        if (instr_tb == 8'b0001_1000) $display("PASS: addr 0 = LOAD 8");
        else $display("FAIL: addr 0 = LOAD 8 -- got instr=%b", instr_tb);

        // TEST: addr 1 -> SUB 9
        addr_tb = 4'd1; #10;
        if (instr_tb == 8'b0111_1001) $display("PASS: addr 1 = SUB 9");
        else $display("FAIL: addr 1 = SUB 9 -- got instr=%b", instr_tb);

        // TEST: addr 2 -> JZ 4
        addr_tb = 4'd2; #10;
        if (instr_tb == 8'b0100_0100) $display("PASS: addr 2 = JZ 4");
        else $display("FAIL: addr 2 = JZ 4 -- got instr=%b", instr_tb);

        // TEST: addr 3 -> JMP 1
        addr_tb = 4'd3; #10;
        if (instr_tb == 8'b0011_0001) $display("PASS: addr 3 = JMP 1");
        else $display("FAIL: addr 3 = JMP 1 -- got instr=%b", instr_tb);

        // TEST: addr 4 -> HALT
        addr_tb = 4'd4; #10;
        if (instr_tb == 8'b0101_0000) $display("PASS: addr 4 = HALT");
        else $display("FAIL: addr 4 = HALT -- got instr=%b", instr_tb);

        // TEST: unused address defaults to NOP
        addr_tb = 4'd5; #10;
        if (instr_tb == 8'b0000_0000) $display("PASS: unused addr defaults to NOP");
        else $display("FAIL: unused addr defaults to NOP -- got instr=%b", instr_tb);

        $finish;
    end
endmodule