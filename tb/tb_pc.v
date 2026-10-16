
`timescale 1ns/1ps

module tb_pc;

    reg         i_clk;
    reg         i_rst;
    reg         i_branch_sel;
    reg  [1:0]  i_pc_imm_sel;
    reg  [31:0] i_imm;
    reg  [31:0] i_reg_read;

    wire [31:0] o_pc4;
    wire [31:0] o_pc_imm;
    wire [31:0] o_pc;

    pc dut (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_branch_sel(i_branch_sel),
        .i_pc_imm_sel(i_pc_imm_sel),
        .i_imm(i_imm),
        .i_reg_read(i_reg_read),
        .o_pc4(o_pc4),
        .o_pc_imm(o_pc_imm),
        .o_pc(o_pc)
    );

    initial i_clk = 1;
    always #5 i_clk = ~i_clk;
    
    initial begin
        $dumpfile("tb_pc.vcd");
        $dumpvars(0, tb_pc);

        i_rst = 0;
        i_branch_sel = 0;
        i_pc_imm_sel = 0;
        i_imm = 0;
        i_reg_read = 0;

        #2;
        i_rst = 1;
        #1;


        // PC + 4
        @(posedge i_clk);
        
        #1;
        if (o_pc === 32'd4)
            $display("PASS: PC + 4");
        else begin
            $display("FAIL: expected PC = 4, got %h", o_pc);
        end

        if (o_pc4 === 32'd8)
            $display("PASS: PC+4 ");
        else begin
            $display("FAIL: expected PC+4 = 8, got %h", o_pc4);
        end

        @(posedge i_clk);
  

        // register + immediate
        i_branch_sel = 1;
        i_reg_read = 32'd100;
        i_imm = 32'd20;
        i_pc_imm_sel = 2;

        @(posedge i_clk);
  

        if (o_pc_imm === 32'd120)
            $display("PASS: register + immediate");
        else begin
            $display("FAIL: expected 120, got %h", o_pc_imm);
            $finish;
        end

        // Test 4: PC + immediate
        i_branch_sel = 1;
        i_pc_imm_sel = 1;
        i_imm = 32'd8;

        @(posedge i_clk);
       

        if (o_pc_imm === o_pc + 32'd8)
            $display("PASS: PC + immediate");
        else begin
            $display("FAIL: PC + immediate, got %h", o_pc_imm);
            $finish;
        end

        // Test 6: sequential PC+4
        i_branch_sel = 0;

        @(posedge i_clk);
    

        if (o_pc === 32'd128)
            $display("PASS: +imm");
        else begin
            $display("FAIL: expected PC = 20, got %h", o_pc);
            $finish;
        end

        @(posedge i_clk);
    

        if (o_pc === 32'd132)
            $display("PASS: sequential PC+4");
        else begin
            $display("FAIL: expected PC = 20, got %h", o_pc);
            $finish;
        end

        //wwwwww
        i_branch_sel = 0;
        i_pc_imm_sel = 0;

        @(posedge i_clk);
        

        #1000;
        $display("All PC tests passed.");
        $finish;
    end

endmodule
