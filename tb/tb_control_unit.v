`timescale 1ns/1ps

module tb_control_unit;

    reg  [6:0]  i_opcode;
    reg  [2:0]  i_funct3;
    reg         i_funct7_bit;

    wire        o_branch;
    wire [1:0]  o_pc_imm_sel;
    wire          o_we_reg;     // 
    wire  [2:0]   o_imm_type;     // 
    wire  [3:0]   o_alu_op;       // 
    wire          o_alu_src;      // 
    wire          o_we_mem;       // 
    wire  [1:0]   o_mux4_sel;      


    control_unit u_control_unit(
        .*
    );

    initial begin
        $dumpfile("tb_control_unit.vcd");
        $dumpvars(0, tb_control_unit);

        // ===================================================
        i_opcode = 0;
        i_funct3 = 0;
        i_funct7_bit = 0;

        #10;

        //R type
        i_opcode = 7'b0110011;
        i_funct3 = 0;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 0;
        i_funct7_bit = 1;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 4;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 6;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 7;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 1;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 5;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 5;
        i_funct7_bit = 1;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 2;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0110011;
        i_funct3 = 3;
        i_funct7_bit = 0;

        //I type
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 0;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 4;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 6;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 7;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 1;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 5;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 5;
        i_funct7_bit = 1;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 2;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0010011;
        i_funct3 = 3;
        i_funct7_bit = 0;

        // I type load
        #10;
        i_opcode = 7'b0000011;
        i_funct3 = 0;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0000011;
        i_funct3 = 1;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0000011;
        i_funct3 = 2;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0000011;
        i_funct3 = 4;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0000011;
        i_funct3 = 5;
        i_funct7_bit = 0;

        //S type
        #10;
        i_opcode = 7'b0100011;
        i_funct3 = 0;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0100011;
        i_funct3 = 1;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b0100011;
        i_funct3 = 2;
        i_funct7_bit = 0;

        // B type

        #10;
        i_opcode = 7'b1100011;
        i_funct3 = 0;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b1100011;
        i_funct3 = 1;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b1100011;
        i_funct3 = 4;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b1100011;
        i_funct3 = 5;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b1100011;
        i_funct3 = 6;
        i_funct7_bit = 0;
        #10;
        i_opcode = 7'b1100011;
        i_funct3 = 7;
        i_funct7_bit = 0;

        // J type jal
        #10;
        i_opcode = 7'b1101111;
        i_funct3 = 0;
        i_funct7_bit = 0;

        // I type jalr
        #10;
        i_opcode = 7'b1100111;
        i_funct3 = 0;
        i_funct7_bit = 0;

        // U type lui
        #10;
        i_opcode = 7'b0110111;
        i_funct3 = 0;
        i_funct7_bit = 0;

        // U type auipc
        #10;
        i_opcode = 7'b0010111;
        i_funct3 = 0;
        i_funct7_bit = 0;

        // other
        #10;
        i_opcode = 7'b1010101;
        i_funct3 = 0;
        i_funct7_bit = 0;

        #1000
        $finish;
    end

endmodule
