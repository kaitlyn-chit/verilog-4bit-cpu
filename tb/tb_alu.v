module tb_alu;
    reg  [3:0] a_tb, b_tb;
    reg  [2:0] op_sel_tb;
    wire [3:0] result_tb;
    wire zero_tb, carry_tb;

    alu uut (
    .a(a_tb),
    .b(b_tb),
    .op_sel(op_sel_tb),
    .result(result_tb),
    .zero(zero_tb),
    .carry(carry_tb)
    );

    initial begin
    // Test: ADD 3 + 1 = 4, no overflow expected
        a_tb = 4'b0011; b_tb = 4'b0001; op_sel_tb = 3'b000;
        #10; // advance that internal stopwatch by 10 units before executing the next line
        if (result_tb == 4'b0100 && carry_tb == 1'b0)
            $display("PASS: ADD 3+1");
        else
            $display("FAIL: ADD 3+1 -- got result=%b carry=%b", result_tb, carry_tb);
    
    // Test: ADD 10 + 10 = 20, overflow expected
        a_tb = 4'b1010; b_tb = 4'b1010; op_sel_tb = 3'b000;
        #10; 
        if (result_tb == 4'b0100 && carry_tb == 1'b1)
            $display("PASS: ADD 10+10");
        else
            $display("FAIL: ADD 10+10 -- got result=%b carry=%b", result_tb, carry_tb);

    // Test: SUB 8 - 2 = 6, no barrow expected
        a_tb = 4'b1000; b_tb = 4'b0010; op_sel_tb = 3'b001;
        #10; 
        if (result_tb == 4'b0110 && carry_tb == 1'b0)
            $display("PASS: SUB 8-2");
        else
            $display("FAIL: SUB 8-2 -- got result=%b carry=%b", result_tb, carry_tb);
    
    // Test: SUB 4 - 4 = 0, zero-flag test
        a_tb = 4'b0100; b_tb = 4'b0100; op_sel_tb = 3'b001;
        #10; 
        if (result_tb == 4'b0000 && carry_tb == 1'b0 && zero_tb == 1'b1)
            $display("PASS: SUB 4-4");
        else
            $display("FAIL: SUB 4-4 -- got result=%b carry=%b", result_tb, carry_tb);

    // Test: SUB 2 - 5 = -3, barrow expected
        a_tb = 4'b0010; b_tb = 4'b0101; op_sel_tb = 3'b001;
        #10; 
        if (result_tb == 4'b1101 && carry_tb == 1'b1)
            $display("PASS: SUB 2-5");
        else
            $display("FAIL: SUB 2-5 -- got result=%b carry=%b", result_tb, carry_tb);

    // Test: AND
        a_tb = 4'b1011; b_tb = 4'b1001; op_sel_tb = 3'b010;
        #10; 
        if (result_tb == 4'b1001 && carry_tb == 1'b0)
            $display("PASS: AND");
        else
            $display("FAIL: AND a=1011 b=1001 -- got result=%b carry=%b", result_tb, carry_tb);
    
    // Test: OR
        a_tb = 4'b1011; b_tb = 4'b1001; op_sel_tb = 3'b011;
        #10; 
        if (result_tb == 4'b1011 && carry_tb == 1'b0)
            $display("PASS: OR");
        else
            $display("FAIL: OR a=1011 b=1001 -- got result=%b carry=%b", result_tb, carry_tb);

    // Test: XOR
        a_tb = 4'b1011; b_tb = 4'b1001; op_sel_tb = 3'b100;
        #10; 
        if (result_tb == 4'b0010 && carry_tb == 1'b0)
            $display("PASS: XOR");
        else
            $display("FAIL: XOR a=1011 b=1001 -- got result=%b carry=%b", result_tb, carry_tb);

    // Test: NOT
        a_tb = 4'b1011; b_tb = 4'b0000; op_sel_tb = 3'b101;
        #10; 
        if (result_tb == 4'b0100 && carry_tb == 1'b0)
            $display("PASS: NOT");
        else
            $display("FAIL: NOT 1011 -- got result=%b carry=%b", result_tb, carry_tb);

    // Test: SHL
        a_tb = 4'b1001; b_tb = 4'b0000; op_sel_tb = 3'b110;
        #10; 
        if (result_tb == 4'b0010 && carry_tb == 1'b0)
            $display("PASS: SHL");
        else
            $display("FAIL: SHL 1001 -- got result=%b carry=%b", result_tb, carry_tb);

    // Test: SHR
        a_tb = 4'b1001; b_tb = 4'b0000; op_sel_tb = 3'b111;
        #10; 
        if (result_tb == 4'b0100 && carry_tb == 1'b0)
            $display("PASS: SHR");
        else
            $display("FAIL: SHR 1001 -- got result=%b carry=%b", result_tb, carry_tb);
        
        $finish;
    end


endmodule