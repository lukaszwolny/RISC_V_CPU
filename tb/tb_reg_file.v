
`timescale 1ns/1ps

module tb_reg_file;

    reg         i_clk;
    reg         i_rst;
    reg         write_en;
    reg  [4:0]  read_reg_1, read_reg_2, write_reg;
    reg  [31:0] write_data;

    wire [31:0] read_data_1, read_data_2;

    reg_file u_reg_file (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_read_reg1(read_reg_1),
        .i_read_reg2(read_reg_2),
        .i_write_reg(write_reg),
        .i_write_data(write_data),
        .i_write_en(write_en),
        .o_read_data1(read_data_1),
        .o_read_data2(read_data_2)
    );

    initial i_clk = 1;
    always #5 i_clk = ~i_clk;
    
    initial begin
        $dumpfile("tb_reg_file.vcd");
        $dumpvars(0, tb_reg_file);

        i_rst = 0;
        write_en = 0;
        read_reg_1 = 0;
        read_reg_2 = 0;
        write_reg = 0;
        write_data = 0;

        #2;
        i_rst = 1;
        #1;

        @(posedge i_clk);
        // write 42 into x1
        write_en=1;write_reg=5'd1;write_data=32'd42;read_reg_1=5'd1;read_reg_2=5'd0;
        @(posedge i_clk);

        // write 99 into x5
        write_reg=5'd5;write_data=32'd99;read_reg_1=5'd5;
        @(posedge i_clk);

        // x0 always reads 0 even if written
        write_reg=5'd0;write_data=32'hDEAD;read_reg_1=5'd0;
        @(posedge i_clk);

        // simultaneous read x1 and x5
        write_en=0;read_reg_1=5'd1;read_reg_2=5'd5;
        

        #1000;
        $finish;
    end

endmodule
