/*
TOP module
Single Cycle RISC V CPU gold+
*/
//-----------------------------------------------------------------------------

/*
todo:
skleic calosc
testy calosc
*/

module single_cycle_cpu(
    input   i_clk,
    input   i_rst
);

//===========================================================================
// internal signals
//===========================================================================

wire    [31:0]  instruction;
wire    [:] ;

//===========================================================================
// internal logic
//===========================================================================

//-------------------------------
// processor

// control unit
control_unit u_control_unit (
    .i_opcode(),       // instruction opcode
    .i_funct3(),       // instruction funct3
    .i_funct7_bit(),   // instruction funct7 1 bit
    .o_branch(),       // branch signal
    .o_pc_imm_sel(),   // (pc_add_sel) pc_imm mux signal
    .o_we_reg(),       // write enable register
    .o_imm_type(),     // immediate type sel
    .o_alu_op(),       // alu operation
    .o_alu_src(),      // alu mux sel
    .o_we_mem(),       // write enable datamem
    .o_mux4_sel()      // mux4x1 sel
);

// datapath
datapath u_datapath(
    .i_clk(),
    .i_rst(),
    .i_branch,           // jump
    .i_pc_imm_mux,       // pc mux sel o/pc/reg
    input           .i_we_reg,           // write enable register file
    input   [2:0]   .i_imm_type_sel,     // immediate type sel
    input   [3:0]   .i_alu_operation,    // alu control
    input           .i_alu_src,          // alu mux sel
    input   [1:0]   .i_mux4_sel,         // mux4x1 sel
    // instr
    input   [31:0]  .i_instruction,      // full instr 32bits
    // interface data mem
    input   [31:0]  .i_read_data,        // data from data mem
    output  [31:0]  .o_alu_result_adr,       // data mem address input
    output  [31:0]  .o_read_data_reg2,   // data to datamem
    // interface instr mem
    output  [31:0]  .o_instr_adr,        // pc output - as instr mem address
    // alu flags
    output          .o_zero_flag,        // alu zero flag
    output          .o_alu_l_b_flag      // alu last bit result flag
);

//-------------------------------
// external memory

// instr mem
instr_mem #(
    .depth(256)
) u_instr_mem (
    .i_addr(),
    .o_instr(instruction),
);

// data mem
data_mem #(
    .depth(256)
) u_data_mem (
    .i_clk(i_clk),
    .i_address(),
    .i_data(),
    .i_write_en(),
    .i_funct3(),
    .o_data()
);

//-------------------------------

endmodule
