/*
Control unit

main_decoder + alu_decoder
*/
//-----------------------------------------------------------------------------

module control_unit (
    input [6:0] i_opcode,
    input [2:0] i_funct3,
    input       i_funct7_bit,

    output       o_branch,
    output [1:0] o_pc_imm_sel, //pc_add_sel
    output      o_we_reg,
    output [2:0] o_imm_type,
    output [3:0] o_alu_op,
    output      o_alu_src,
    output      o_we_mem,
    output [1:0] o_mux4_sel
);

// main decoder


// alu decoder

endmodule
