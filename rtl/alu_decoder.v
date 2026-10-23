/*
ALU Decoder
*/
//-----------------------------------------------------------------------------

module alu_decoder (
    // controls
    input       [2:0]   i_f3,           // funct3 code instr
    input               i_f7,           // funct7 1 bit 
    input       [1:0]   i_alu_control,  // from main decoder instr type
    // output alu operation
    output reg  [3:0]   o_op            // alu operation output
);

//===========================================================================
// output assignments
//===========================================================================

always @(*) begin
    case(i_alu_control)
        2'b00: begin
            case({i_f7, i_f3})
                // o_op = {i_f7, i_f3};

                // 4'b0000: o_op = {i_f7, i_f3}; //add  -
                // 4'b1000: o_op = {i_f7, i_f3}; //sub  -
                // 4'b0100: o_op = {i_f7, i_f3}; //xor -
                // 4'b0110: o_op = {i_f7, i_f3}; //or  -
                // 4'b0111: o_op = {i_f7, i_f3}; //and  -
                // 4'b0001: o_op = {i_f7, i_f3}; //sll  -
                // 4'b0101: o_op = {i_f7, i_f3}; //srl  -
                // 4'b1101: o_op = {i_f7, i_f3}; //sra  -
                // 4'b0010: o_op = {i_f7, i_f3}; //slt  -
                // 4'b0011: o_op = {i_f7, i_f3}; //sltu 
                // default: o_op = 4'b0000;

                4'b0000: o_op = 4'b0000; //add  -
                4'b1000: o_op = 4'b0001; //sub  -
                4'b0100: o_op = 4'b0010; //xor -
                4'b0110: o_op = 4'b0011; //or  -
                4'b0111: o_op = 4'b0100; //and  -
                4'b0001: o_op = 4'b0101; //sll  -
                4'b0101: o_op = 4'b0110; //srl  -
                4'b1101: o_op = 4'b0111; //sra  -
                4'b0010: o_op = 4'b1000; //slt  -
                4'b0011: o_op = 4'b1001; //sltu 
                default: o_op = 4'b0000;
            endcase
        end
        2'b01: o_op = 4'b0000;//add
        2'b10: o_op = (i_f3[2]) ? (i_f3[1]) ? 4'b1001 : 4'b1000 : 4'b0001;//sub // Branch
        2'b11: begin
            case(i_f3)
                3'b000: o_op = 4'b0000; //addi  -
                3'b100: o_op = 4'b0010; //xori -
                3'b110: o_op = 4'b0011; //ori  -
                3'b111: o_op = 4'b0100; //andi  -
                3'b001: o_op = 4'b0101; //slli  -
                3'b101: o_op = (i_f7) ? 4'b0111 : 4'b0110; //srli  - 4'b0111; //srai  -
                3'b010: o_op = 4'b1000; //slti  -
                3'b011: o_op = 4'b1001; //sltui 
                default: o_op = 4'b0000;
            endcase
        end
        // 2'b10: o_op = 4'b0001;//sub
        // 2'b11: begin // branch - slt/sltu
        //     //o_op = 4'b1000;//slt
        //     o_op = (i_f3[1]) ? 4'b1001 : 4'b1000;
        // end
    endcase
end

endmodule
