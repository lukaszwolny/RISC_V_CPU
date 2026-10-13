`timescale 1ns/1ps

module tb_adder;

    reg  [31:0] in0, in1;

    wire [31:0] out1;

    adder u_adder (
        .i_a(in0),
        .i_b(in1),
        .o_out(out1)
    );

    initial begin
        $dumpfile("tb_adder.vcd");
        $dumpvars(0, tb_adder);

        in0 = 32'h11111111;
        in1 = 32'h22222222;
        #1;

        in0 = 32'd10;
        in1 = 32'd255;
        #1;

        in0 = 32'd0;
        in1 = 32'd0;
        #1;

        in0 = 32'hffffffff;
        in1 = 32'd1;
        #1;

        in0 = 32'h7fffffff;
        in1 = 32'd1;
        #1;

        $finish;
    end

endmodule
