// Control unit — the CPU's supervisor. Two-block FSM: Fetch -> Decode -> Execute -> Fetch, branching to Halted when opcode == HALT. Reads the current instruction and acc_zero;
// drives alu_op_sel, reg_load, mem_ena, and pc_jump_ena to coordinate every other module. See docs/control_fsm_spec.md for the full state diagram and signal table.

module control_fsm(
    input clk,
    input reset,
    input [7:0] instr,
    input acc_zero,
    output reg [2:0] alu_op_sel,
    output reg reg_load,
    output reg mem_ena,
    output reg pc_jump_ena
);

    localparam FETCH   = 2'b00;
    localparam DECODE  = 2'b01;
    localparam EXECUTE = 2'b10;
    localparam HALTED  = 2'b11;

    reg [1:0] state;
    reg [1:0] next;

    // state transition logic
    always @(*) begin
        case(state)
            FETCH: next = DECODE;
            DECODE: next = EXECUTE;                
            EXECUTE: next = (instr[7:4] == `HALT) ? HALTED : FETCH;
            HALTED: next = HALTED;
        endcase
    end

    // state flip-flops
    always @(posedge clk) begin
        if (reset)
            state <= FETCH;
        else
            state <= next;
    end

    // output logic
    always @(*) begin
        // defaults — nothing active unless EXECUTE says otherwise
        alu_op_sel   = 3'b000;
        reg_load     = 1'b0;
        mem_ena      = 1'b0;
        pc_jump_ena  = 1'b0;

        if (state == EXECUTE) begin
            case(instr[7:4])
                `LOAD: reg_load = 1'b1;
                `STORE: mem_ena = 1'b1;
                `JMP: pc_jump_ena = 1'b1;
                `JZ: begin pc_jump_ena = acc_zero ? 1'b1 : 1'b0; end
                `ADD: begin alu_op_sel = 3'b000; reg_load = 1'b1; end
                `SUB: begin alu_op_sel = 3'b001; reg_load = 1'b1; end
                `AND: begin alu_op_sel = 3'b010; reg_load = 1'b1; end
                `OR: begin alu_op_sel = 3'b011; reg_load = 1'b1; end
                `XOR: begin alu_op_sel = 3'b100; reg_load = 1'b1; end
                `NOT: begin alu_op_sel = 3'b101; reg_load = 1'b1; end
                `SHL: begin alu_op_sel = 3'b110; reg_load = 1'b1; end
                `SHR: begin alu_op_sel = 3'b111; reg_load = 1'b1; end
            endcase
        end
    end


endmodule