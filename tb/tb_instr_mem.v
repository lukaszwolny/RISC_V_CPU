`timescale 1ns/1ps

module tb_instr_mem;

    reg         clk, rst;
    reg         branch_sel;
    reg  [1:0]  pc_im_sel;
    reg  [31:0] imm, data_reg;

    wire [31:0] out_pc4, out_pc_imm, out_pc;
    wire [31:0] instrukjca;

    pc u_pc (
        .i_clk(clk),
        .i_rst(rst),
        .i_branch_sel(branch_sel),
        .i_pc_imm_sel(pc_im_sel),
        .i_imm(imm),
        .i_reg_read(data_reg),
        .o_pc4(out_pc4),
        .o_pc_imm(out_pc_imm),
        .o_pc(out_pc)
    );

    instr_mem u_instr_mem (
        .i_addr(out_pc),
        .o_instr(instrukjca)
    );

    initial clk = 1;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_instr_mem.vcd");
        $dumpvars(0, tb_instr_mem);

        // ===================================================
        branch_sel = 0;
        pc_im_sel = 0;
        imm = 0;
        data_reg = 0;

        rst = 0;
        #7;
        rst = 1;
        #3;

        #80;
        @(posedge clk);

        // skoki

        // pc = 36
        branch_sel = 1;
        pc_im_sel = 1;
        imm = 8;// 20 + pc = 12 + 36 = 48 powinno byc
        @(posedge clk);
        branch_sel = 0; //pc = 36 + 8 =44
        @(posedge clk);
        branch_sel = 1;
        imm = 16;
        @(posedge clk);
        branch_sel = 0;
        @(posedge clk);
        branch_sel = 1;
        pc_im_sel = 1;
        imm = 32'hFFFFFFF4; //-12
        @(posedge clk);
        branch_sel = 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        branch_sel = 1;
        pc_im_sel = 2;
        data_reg = 16;
        imm = 0;
        @(posedge clk);
        branch_sel = 0;
        @(posedge clk);
        branch_sel = 1;
        pc_im_sel = 2;
        data_reg = 32'hFFFFFFF4;
        #1000
        $finish;
    end

endmodule
