`timescale 1ns/1ps

module tb_mux;

    reg  [31:0] in0, in1, in2, in3;
    reg         sel2;
    reg  [1:0]  sel3, sel4;

    wire [31:0] out2, out3, out4;

    mux2 u_mux2 (
        .i_a(in0),
        .i_b(in1),
        .i_sel(sel2),
        .o_out(out2)
    );

    mux3 u_mux3 (
        .i_a(in0),
        .i_b(in1),
        .i_c(in2),
        .i_sel(sel3),
        .o_out(out3)
    );

    mux4 u_mux4 (
        .i_a(in0),
        .i_b(in1),
        .i_c(in2),
        .i_d(in3),
        .i_sel(sel4),
        .o_out(out4)
    );

    initial begin
        $dumpfile("tb_mux.vcd");
        $dumpvars(0, tb_mux);

        in0 = 32'h11111111;
        in1 = 32'h22222222;
        in2 = 32'h33333333;
        in3 = 32'h44444444;

        sel2 = 0;
        sel3 = 0;
        sel4 = 0;
        #1;


        sel2 = 1;
        sel3 = 1;
        sel4 = 1;
        #1;


        sel2 = 0;
        sel3 = 2;
        sel4 = 2;
        #1;


        sel2 = 1;
        sel3 = 0;
        sel4 = 3;
        #1;

        $finish;
    end

endmodule
