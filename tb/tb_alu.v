`timescale 1ns/1ps

module tb_alu;

    reg  [3:0]  i_alu_op;
    reg  [31:0] i_a, i_b;

    wire        o_zero, o_alu_last_bit;
    wire [31:0] o_alu_result;

    alu u_alu(
        .i_a(i_a),           
        .i_b(i_b),            
        .i_alu_op(i_alu_op),       
        .o_alu_result(o_alu_result),   
        .o_zero(o_zero),         
        .o_alu_last_bit(o_alu_last_bit)  
    );

    initial begin
        $dumpfile("tb_alu.vcd");
        $dumpvars(0, tb_alu);

        // ===================================================
        i_alu_op = 4'b0000;
        i_a = 0;
        i_b = 0;
        #10;
        i_a = 32'd1000;//add
        i_b = 32'd500;
        #10;
        i_alu_op = 4'b0001;//sub
        i_a = 32'd1000;
        i_b = 32'd500;
        #10;
        i_alu_op = 4'b0010;//xor
        i_a = 32'h0F00FF0F;
        i_b = 32'hF000FFF0;
        #10;
        i_alu_op = 4'b0011;//or
        i_a = 32'h0F00FF0F;
        i_b = 32'hF000FFF0;
        #10;
        i_alu_op = 4'b0100;//and
        i_a = 32'h0F00FF0F;
        i_b = 32'hF000FFF0;
        #10;
        i_alu_op = 4'b0101;//sll
        i_a = 32'h0000FF00;
        i_b = 32'h00000004;
        #10;
        i_alu_op = 4'b0110;//srl
        i_a = 32'hFFFFFF00;
        i_b = 32'h00000004;
        #10;
        i_alu_op = 4'b0111;//sra
        i_a = 32'hFFFFFF00;
        i_b = 32'h00000004;
        #10;
        i_alu_op = 4'b1000;//slt
        i_a = 32'h00000003;
        i_b = 32'h00000005;
        #10;
        i_alu_op = 4'b1001;//sltu
        i_a = 32'h00000003;
        i_b = 32'h00000005;
        #10;
        i_alu_op = 4'b1000;//slt
        i_a = 32'h00000005;
        i_b = 32'h00000003;
        #10;
        i_alu_op = 4'b1001;//sltu
        i_a = 32'h00000005;
        i_b = 32'h00000003;
        #10;
        i_alu_op = 4'b1000;//slt
        i_a = 32'hFFFFFFFF;
        i_b = 32'h00000001;
        #10;
        i_alu_op = 4'b1001;//sltu
        i_a = 32'hFFFFFFFF;
        i_b = 32'h00000001;

        #10;
        i_alu_op = 4'b1000;//slt
        i_a = 32'h80000000;
        i_b = 32'h00000001;
        #10;
        i_alu_op = 4'b1001;//sltu
        i_a = 32'h80000000;
        i_b = 32'h00000001;

        #10;
        i_alu_op = 4'b1000;//slt
        i_a = 32'h7FFFFFFF;
        i_b = 32'hFFFFFFFF;
        #10;
        i_alu_op = 4'b1001;//sltu
        i_a = 32'h7FFFFFFF;
        i_b = 32'hFFFFFFFF;

        #10;
        i_alu_op = 4'b1000;//slt
        i_a = 32'h00000004;
        i_b = 32'h00000004;
        #10;
        i_alu_op = 4'b1001;//sltu
        i_a = 32'h00000004;
        i_b = 32'h00000004;


        #10;
        i_alu_op = 4'b0001;//sub
        i_a = 32'h00000004;
        i_b = 32'h00000004;
        #10;


        #1000
        $finish;
    end

endmodule
