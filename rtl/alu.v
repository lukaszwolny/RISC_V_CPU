/*
ALU
*/
//-----------------------------------------------------------------------------

module alu (
    // inputs 
    input       [31:0]  i_a,            // rs1
    input       [31:0]  i_b,            // rs2/imm
    // control
    input       [3:0]   i_alu_op,       // code
    // output
    output reg  [31:0]  o_alu_result,   // rd
    output              o_zero,         // zero flag
    output              o_alu_last_bit  // slt sltu flag
);

//===========================================================================
// internal logic
//===========================================================================

// alu
always @(*) begin
    case(i_alu_op)
        4'b0000: o_alu_result = i_a + i_b;                                      // add
        4'b0001: o_alu_result = i_a - i_b;                                      // sub
        4'b0010: o_alu_result = i_a ^ i_b;                                      // xor
        4'b0011: o_alu_result = i_a | i_b;                                      // or
        4'b0100: o_alu_result = i_a & i_b;                                      // and
        4'b0101: o_alu_result = i_a << i_b[4:0];                                // sll
        4'b0110: o_alu_result = i_a >> i_b[4:0];                                // srl
        4'b0111: o_alu_result = $signed(i_a) >>> i_b[4:0];                      // sra
        4'b1000: o_alu_result = ($signed(i_a) < $signed(i_b)) ? 32'd1 : 32'd0;  // slt
        4'b1001: o_alu_result = (i_a < i_b) ? 32'd1 : 32'd0;                    // sltu
        default: o_alu_result = 32'd0;
    endcase
end

//===========================================================================
// output assignments
//===========================================================================

// zero flag
assign o_zero = (o_alu_result == 32'd0);

// last bit
assign o_alu_last_bit = o_alu_result[0];

endmodule
