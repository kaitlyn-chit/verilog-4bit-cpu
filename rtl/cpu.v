module cpu(
    input clk,
    input reset,
    output [3:0] acc_out,
    output [3:0] pc_out
);

    wire [7:0] instr;
    wire [3:0] alu_result;
    wire alu_zero, alu_carry;
    wire [3:0] data_mem_out;
    wire [2:0] alu_op_sel;
    wire reg_load, mem_ena, pc_jump_ena;

    // logic that lives in cpu.v itself, not inside any module
    wire is_load = (instr[7:4] == `LOAD);
    wire [3:0] reg_data_in = is_load ? data_mem_out : alu_result;
    wire acc_zero = (acc_out == 4'b0000);

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .jump_ena(pc_jump_ena),
        .jump_addr(instr[3:0]),
        .pc_out(pc_out)
    );

    instr_mem instr_mem_inst (
        .addr(pc_out),
        .instr(instr)
    );

    data_mem data_mem_inst (
        .clk(clk),
        .ena(mem_ena),
        .addr(instr[3:0]),
        .data_in(acc_out),
        .data_out(data_mem_out)
    );

    alu alu_inst (
        .a(acc_out),
        .b(data_mem_out),
        .op_sel(alu_op_sel),
        .result(alu_result),
        .zero(alu_zero),
        .carry(alu_carry)
    );

    reg4 reg4_inst (
        .clk(clk),
        .reset(reset),
        .load(reg_load),
        .data_in(reg_data_in),
        .data_out(acc_out)
    );

    control_fsm control_fsm_inst (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .acc_zero(acc_zero),
        .alu_op_sel(alu_op_sel),
        .reg_load(reg_load),
        .mem_ena(mem_ena),
        .pc_jump_ena(pc_jump_ena)
    );

endmodule