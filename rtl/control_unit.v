/*
Control unit

main_decoder + alu_decoder
*/
//-----------------------------------------------------------------------------

module control_unit (
    // input
    input   [6:0]   i_opcode,       // instruction opcode
    input   [2:0]   i_funct3,       // instruction funct3
    input           i_funct7_bit,   // instruction funct7 1 bit
    // alu flags
    input           i_zero_flag,    // 
    input           i_alu_l_b_flag, // 
    // outputs controls
    output          o_branch,       // branch signal
    output  [1:0]   o_pc_imm_sel,   // (pc_add_sel) pc_imm mux signal
    output          o_we_reg,       // write enable register
    output  [2:0]   o_imm_type,     // immediate type sel
    output  [3:0]   o_alu_op,       // alu operation
    output          o_alu_src,      // alu mux sel
    output          o_we_mem,       // write enable datamem
    output  [1:0]   o_mux4_sel      // mux4x1 sel
);

//===========================================================================
// internal signals
//===========================================================================

// wire            funct3_bit;     // funct3 1 bit
wire    [1:0]   alu_control;    // main decoder->alu decoder

//===========================================================================
// internal logic
//===========================================================================

// funct3 1 bit
// assign funct3_bit = i_funct3[2];

// main decoder
main_decoder u_main_decoder(
    .i_op(i_opcode),                  
    //.i_f3(funct3_bit),                  
    .i_f3(i_funct3),      
    .i_zero(i_zero_flag),    // 
    .i_alu_l_b(i_alu_l_b_flag), //             
    .o_decoder_branch(o_branch),            
    .o_decoder_pc_imm_sel(o_pc_imm_sel),   
    .o_decoder_we_reg(o_we_reg),        
    .o_decoder_imm_type(o_imm_type),      
    .o_decoder_alu_src(o_alu_src),       
    .o_decoder_we_mem(o_we_mem),        
    .o_decoder_mux4_sel(o_mux4_sel),      
    .o_alu_control(alu_control)        
);

// alu decoder
alu_decoder u_alu_decoder(
    .i_f3(i_funct3),           
    .i_f7(i_funct7_bit),            
    .i_alu_control(alu_control),  
    .o_op(o_alu_op) 
);

endmodule
