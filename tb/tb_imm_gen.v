`timescale 1ns/1ps

module tb_imm_gen;

    reg  [2:0]  typ_imm;
    reg  [31:0] instr;
    wire  [31:0] imm;

    imm_gen u_imm_gen (
        .i_instr(instr),
        .i_imm_type(typ_imm),
        .o_imm(imm)
    );

    initial begin
        $dumpfile("tb_imm_gen.vcd");
        $dumpvars(0, tb_imm_gen);

        // ===================================================
        instr = 0;
        typ_imm = 0;
        #10;

        instr = 32'h12300093;
        typ_imm = 0;
        #10;//123

        instr = 32'h3271F950;
        typ_imm = 1;
        #10;//332

        //B
        instr = 32'h54BAA22F;
        typ_imm = 2;
        #10;//544

        //J
        instr = 32'h24800ABC;
        typ_imm = 3;
        #10;//248

        instr = 32'h33201AEF;
        typ_imm = 4;
        #10;//332





        #1000
        $finish;
    end

endmodule