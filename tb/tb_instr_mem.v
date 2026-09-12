module tb_instr_mem;
    reg [3:0] addr_tb;
    wire [7:0] instr_tb;

    instr_mem uut(
        .addr(addr_tb),
        .instr(instr_tb)
    );

    initial begin
        // TEST: address 0 -> LOAD 8  (opcode 0001, addr 1000 -> 0001_1000)
        addr_tb = 4'b0000;
        #10;
        if (instr_tb == 8'b0001_1000) // underscores purely as a readability separator (verilog ignores them)
            $display("PASS: addr 0 = LOAD 8");
        else
            $display("FAIL: addr 0 = LOAD 8 -- got instr=%b", instr_tb);

        // TEST: address 1 -> ADD 9  (opcode 0110, addr 1001 -> 0110_1001)
        addr_tb = 4'b0001;
        #10;
        if (instr_tb == 8'b0110_1001)
            $display("PASS: addr 1 = ADD 9");
        else
            $display("FAIL: addr 1 = ADD 9 -- got instr=%b", instr_tb);

        // TEST: address 2 -> STORE 10  (opcode 0010, addr 1010 -> 0010_1010)
        addr_tb = 4'b0010;
        #10;
        if (instr_tb == 8'b0010_1010)
            $display("PASS: addr 2 = STORE 10");
        else
            $display("FAIL: addr 2 = STORE 10 -- got instr=%b", instr_tb);

        // TEST: address 3 -> HALT  (opcode 0101, addr 0000 -> 0101_0000)
        addr_tb = 4'b0011;
        #10;
        if (instr_tb == 8'b0101_0000)
            $display("PASS: addr 3 = HALT");
        else
            $display("FAIL: addr 3 = HALT -- got instr=%b", instr_tb);

        // TEST: unused address (7) falls through to default -> NOP
        addr_tb = 4'b0111;
        #10;
        if (instr_tb == 8'b0000_0000)
            $display("PASS: unused addr defaults to NOP");
        else
            $display("FAIL: unused addr defaults to NOP -- got instr=%b", instr_tb);

        $finish;
    end
endmodule