`timescale 1ns/1ps

module tb_alu_dec;

    reg  [2:0]  funct3;
    reg         funct7;
    reg  [1:0]  alu_control;

    wire [3:0]  alu_operation;

    alu_decoder u_alu_decoder(
        .i_f3(funct3),           
        .i_f7(funct7),            
        .i_alu_control(alu_control),       
        .o_op(alu_operation)
    );

    initial begin
        $dumpfile("tb_alu_dec.vcd");
        $dumpvars(0, tb_alu_dec);

        // ===================================================

        funct3 = 0;
        funct7 = 0;
        alu_control = 0;

        #10;

        funct3 = 6;
        alu_control = 0;

        #10;

        funct3 = 6;
        alu_control = 1;

        #10;    
        funct3 = 6;
        alu_control = 2;

        #10;

        funct3 = 6;
        alu_control = 3;

        #10;
        // =============================
        alu_control = 0;

        {funct7, funct3} = 4'b0000;
        #10;
        {funct7, funct3} = 4'b1000;
        #10;
        {funct7, funct3} = 4'b0100;
        #10;
        {funct7, funct3} = 4'b0110;
        #10;
        {funct7, funct3} = 4'b0111;
        #10;
        {funct7, funct3} = 4'b0001;
        #10;
        {funct7, funct3} = 4'b0101;
        #10;
        {funct7, funct3} = 4'b1101;
        #10;
        {funct7, funct3} = 4'b0010;
        #10;
        {funct7, funct3} = 4'b0011;
        #10;
        {funct7, funct3} = 4'b1100;
        #10;

        #10;

        #10;





        #1000
        $finish;
    end

endmodule
