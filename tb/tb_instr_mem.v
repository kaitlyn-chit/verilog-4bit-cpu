module tb_instr_mem;
    reg  [3:0] addr_tb;
    wire [7:0] instr_tb;

    instr_mem uut(
        .addr(addr_tb),
        .instr(instr_tb)
    );

    initial begin
        // TEST: addr 0 -> NOP 0
        addr_tb = 4'd0; #10;
        if (instr_tb == 8'b0000_0000) $display("PASS: addr 0 = NOP");
        else $display("FAIL: addr 0 = NOP -- got instr=%b", instr_tb);

        // TEST: addr 1 -> LOAD 5
        addr_tb = 4'd1; #10;
        if (instr_tb == 8'b0001_0101) $display("PASS: addr 1 = LOAD 5");
        else $display("FAIL: addr 1 = LOAD 5 -- got instr=%b", instr_tb);

        // TEST: addr 2 -> STORE 6
        addr_tb = 4'd2; #10;
        if (instr_tb == 8'b0010_0110) $display("PASS: addr 2 = STORE 6");
        else $display("FAIL: addr 2 = STORE 6 -- got instr=%b", instr_tb);

        // TEST: addr 3 -> JMP 0
        addr_tb = 4'd3; #10;
        if (instr_tb == 8'b0011_0000) $display("PASS: addr 3 = JMP 0");
        else $display("FAIL: addr 3 = JMP 0 -- got instr=%b", instr_tb);

        // TEST: addr 4 -> JZ 0
        addr_tb = 4'd4; #10;
        if (instr_tb == 8'b0100_0000) $display("PASS: addr 4 = JZ 0");
        else $display("FAIL: addr 4 = JZ 0 -- got instr=%b", instr_tb);

        // TEST: addr 5 -> HALT
        addr_tb = 4'd5; #10;
        if (instr_tb == 8'b0101_0000) $display("PASS: addr 5 = HALT");
        else $display("FAIL: addr 5 = HALT -- got instr=%b", instr_tb);

        // TEST: addr 6 -> ADD 5
        addr_tb = 4'd6; #10;
        if (instr_tb == 8'b0110_0101) $display("PASS: addr 6 = ADD 5");
        else $display("FAIL: addr 6 = ADD 5 -- got instr=%b", instr_tb);

        // TEST: addr 7 -> SUB 5
        addr_tb = 4'd7; #10;
        if (instr_tb == 8'b0111_0101) $display("PASS: addr 7 = SUB 5");
        else $display("FAIL: addr 7 = SUB 5 -- got instr=%b", instr_tb);

        // TEST: addr 8 -> AND 5
        addr_tb = 4'd8; #10;
        if (instr_tb == 8'b1000_0101) $display("PASS: addr 8 = AND 5");
        else $display("FAIL: addr 8 = AND 5 -- got instr=%b", instr_tb);

        // TEST: addr 9 -> OR 5
        addr_tb = 4'd9; #10;
        if (instr_tb == 8'b1001_0101) $display("PASS: addr 9 = OR 5");
        else $display("FAIL: addr 9 = OR 5 -- got instr=%b", instr_tb);

        // TEST: addr 10 -> XOR 5
        addr_tb = 4'd10; #10;
        if (instr_tb == 8'b1010_0101) $display("PASS: addr 10 = XOR 5");
        else $display("FAIL: addr 10 = XOR 5 -- got instr=%b", instr_tb);

        // TEST: addr 11 -> NOT
        addr_tb = 4'd11; #10;
        if (instr_tb == 8'b1011_0000) $display("PASS: addr 11 = NOT");
        else $display("FAIL: addr 11 = NOT -- got instr=%b", instr_tb);

        // TEST: addr 12 -> SHL
        addr_tb = 4'd12; #10;
        if (instr_tb == 8'b1100_0000) $display("PASS: addr 12 = SHL");
        else $display("FAIL: addr 12 = SHL -- got instr=%b", instr_tb);

        // TEST: addr 13 -> SHR
        addr_tb = 4'd13; #10;
        if (instr_tb == 8'b1101_0000) $display("PASS: addr 13 = SHR");
        else $display("FAIL: addr 13 = SHR -- got instr=%b", instr_tb);

        // TEST: addr 14 -> unused, defaults to NOP
        addr_tb = 4'd14; #10;
        if (instr_tb == 8'b0000_0000) $display("PASS: addr 14 defaults to NOP");
        else $display("FAIL: addr 14 defaults to NOP -- got instr=%b", instr_tb);

        $finish;
    end
endmodule