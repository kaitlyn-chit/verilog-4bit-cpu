module tb_control_fsm;
    reg clk_tb;
    reg reset_tb;
    reg [7:0] instr_tb;
    reg acc_zero_tb;
    wire [2:0] alu_op_sel_tb;
    wire reg_load_tb;
    wire mem_ena_tb;
    wire pc_jump_ena_tb;
    wire pc_en_tb;

    control_fsm uut (
        .clk(clk_tb),
        .reset(reset_tb),
        .instr(instr_tb),
        .acc_zero(acc_zero_tb),
        .alu_op_sel(alu_op_sel_tb),
        .reg_load(reg_load_tb),
        .mem_ena(mem_ena_tb),
        .pc_jump_ena(pc_jump_ena_tb),
        .pc_en(pc_en_tb)
    );

    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end

    initial begin
        // TEST: ADD -> alu_op_sel=000, reg_load=1, nothing else asserted
        reset_tb = 1; instr_tb = 8'b0; acc_zero_tb = 0;
        @(posedge clk_tb); #1;
        reset_tb = 0;
        instr_tb = {`ADD, 4'd0};
        @(posedge clk_tb); // now in DECODE
        @(posedge clk_tb); // now in EXECUTE
        #1;
        if (alu_op_sel_tb == 3'b000 && reg_load_tb == 1 && mem_ena_tb == 0 && pc_jump_ena_tb == 0)
            $display("PASS: ADD drives op_sel=000, reg_load=1");
        else
            $display("FAIL: ADD -- op_sel=%b load=%b ena=%b jump=%b", alu_op_sel_tb, reg_load_tb, mem_ena_tb, pc_jump_ena_tb);

        // TEST: STORE -> mem_ena=1, reg_load=0
        reset_tb = 1; @(posedge clk_tb); #1; reset_tb = 0;
        instr_tb = {`STORE, 4'd0};
        @(posedge clk_tb); @(posedge clk_tb); #1;
        if (mem_ena_tb == 1 && reg_load_tb == 0 && pc_jump_ena_tb == 0)
            $display("PASS: STORE drives mem_ena=1");
        else
            $display("FAIL: STORE -- load=%b ena=%b jump=%b", reg_load_tb, mem_ena_tb, pc_jump_ena_tb);

        // TEST: JZ with acc_zero=1 -> pc_jump_ena=1
        reset_tb = 1; @(posedge clk_tb); #1; reset_tb = 0;
        instr_tb = {`JZ, 4'd0}; acc_zero_tb = 1;
        @(posedge clk_tb); @(posedge clk_tb); #1;
        if (pc_jump_ena_tb == 1)
            $display("PASS: JZ jumps when acc_zero=1");
        else
            $display("FAIL: JZ jumps when acc_zero=1 -- got pc_jump_ena=%b", pc_jump_ena_tb);

        // TEST: JZ with acc_zero=0 -> pc_jump_ena=0
        reset_tb = 1; @(posedge clk_tb); #1; reset_tb = 0;
        instr_tb = {`JZ, 4'd0}; acc_zero_tb = 0;
        @(posedge clk_tb); @(posedge clk_tb); #1;
        if (pc_jump_ena_tb == 0)
            $display("PASS: JZ does not jump when acc_zero=0");
        else
            $display("FAIL: JZ does not jump when acc_zero=0 -- got pc_jump_ena=%b", pc_jump_ena_tb);

        // TEST: HALT -> once state reaches HALTED, further instructions are ignored
        reset_tb = 1; @(posedge clk_tb); #1; reset_tb = 0;
        instr_tb = {`HALT, 4'd0};
        @(posedge clk_tb); @(posedge clk_tb); #1; // now in EXECUTE, instr=HALT
        @(posedge clk_tb); // now in HALTED
        instr_tb = {`SUB, 4'd0}; // change instr -- should be ignored now
        #1;
        if (alu_op_sel_tb == 3'b000 && reg_load_tb == 0)
            $display("PASS: HALTED ignores further instructions");
        else
            $display("FAIL: HALTED ignores further instructions -- op_sel=%b load=%b", alu_op_sel_tb, reg_load_tb);

        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_control_fsm);
    end
endmodule