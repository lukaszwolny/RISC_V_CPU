/*
Sign Extension
Immediate Generation
*/
//-----------------------------------------------------------------------------

module imm_gen (
    // input
    input       [31:0]  i_instr,    // instruction
    input       [2:0]   i_imm_type, // immediate type
    // output
    output reg  [31:0]  o_imm       // immediate value
);

//===========================================================================
// internal logic
//===========================================================================

// imm gen(signed ext)
always @(*) begin
    case(i_imm_type)
        3'b000: o_imm = {{20{i_instr[31]}}, i_instr[31:20]}; // I-type
        3'b001: o_imm = {{20{i_instr[31]}}, i_instr[31:25], i_instr[11:7]}; // S-type
        3'b010: o_imm = {{19{i_instr[31]}}, i_instr[31], i_instr[7], i_instr[30:25], i_instr[11:8], 1'b0}; // B-type
        3'b011: o_imm = {{11{i_instr[31]}}, i_instr[31], i_instr[19:12], i_instr[20], i_instr[30:21], 1'b0}; // J-type
        3'b100: o_imm = {i_instr[31:12], 12'd0}; // U-type
        default: o_imm = 32'd0;
    endcase
end

endmodule
