/*
DataPath
*/
//-----------------------------------------------------------------------------

module datapath(
    // clock and reset
    input           i_clk,              // clock
    input           i_rst,              // asynchronous reset (active low)
    // input controls
    input           i_branch,           // jump
    input   [1:0]   i_pc_imm_mux,       // pc mux sel o/pc/reg
    input           i_we_reg,           // write enable register file
    input   [2:0]   i_imm_type_sel,     // immediate type sel
    input   [3:0]   i_alu_operation,    // alu control
    input           i_alu_src,          // alu mux sel
    input   [1:0]   i_mux4_sel,         // mux4x1 sel
    // instr
    input   [31:0]  i_instruction,      // full instr 32bits
    // interface data mem
    input   [31:0]  i_read_data,        // data from data mem
    output  [31:0]  o_alu_result_adr,       // data mem address input
    output  [31:0]  o_read_data_reg2,   // data to datamem
    // interface instr mem
    output  [31:0]  o_instr_adr,        // pc output - as instr mem address
    // alu flags
    output          o_zero_flag,        // alu zero flag
    output          o_alu_l_b_flag      // alu last bit result flag
);

//===========================================================================
// internal signals
//===========================================================================

wire    [31:0]  imm_s;              // immediate value
wire    [31:0]  pc4_s;              // 
wire    [31:0]  pc_imm_s;           // 
wire    [31:0]  data_rs1_s;         // 
wire    [31:0]  data_rs2_s;         // 
wire    [31:0]  reg_write_data_s;   // 
wire    [31:0]  alu_result_s;       // 
wire    [4:0]   instr_read_reg1_s;  // 
wire    [4:0]   instr_read_reg2_s;  // 
wire    [4:0]   instr_write_reg_s;  // 
wire    [31:0]  alu_in2_s;          // 

//===========================================================================
// internal logic
//===========================================================================

//-------------------------------
// pc

// pc
pc u_pc(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_branch_sel(i_branch),
    .i_pc_imm_sel(i_pc_imm_mux),
    .i_imm(imm_s),
    .i_reg_read(data_rs1_s),
    .o_pc4(pc4_s),
    .o_pc_imm(pc_imm_s),
    .o_pc(o_instr_adr)
);

//-------------------------------
// mux4 into reg file

// mux4
mux4 #(
    .width(32)
) u_mux4 (
    .i_a(alu_result_s), // alu
    .i_b(i_read_data),  // data mem
    .i_c(pc4_s),        // pc4
    .i_d(pc_imm_s),     // pc imm
    .i_sel(i_mux4_sel),
    .o_out(reg_write_data_s)
);

// split instr into reg file signals
assign instr_read_reg1_s = i_instruction[19:15];
assign instr_read_reg2_s = i_instruction[24:20];
assign instr_write_reg_s = i_instruction[11:7];

// reg file
reg_file u_reg_file(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_read_reg1(instr_read_reg1_s),
    .i_read_reg2(instr_read_reg2_s),
    .i_write_reg(instr_write_reg_s),
    .i_write_data(reg_write_data_s),
    .i_write_en(i_we_reg),
    .o_read_data1(data_rs1_s),
    .o_read_data2(data_rs2_s)
);

//-------------------------------
// immediate gen

// imm gen
imm_gen u_gen(
    .i_instr(i_instruction),
    .i_imm_type(i_imm_type_sel),
    .o_imm(imm_s)
);

//-------------------------------
// alu + mux

//mux2
mux2 #(
    .width(32)
) u_mux2 (
    .i_a(data_rs2_s),
    .i_b(imm_s),
    .i_sel(i_alu_src),
    .o_out(alu_in2_s)
);

// alu
alu u_alu(
    .i_a(data_rs1_s),
    .i_b(alu_in2_s),
    .i_alu_op(i_alu_operation),
    .o_alu_result(alu_result_s),
    .o_zero(o_zero_flag),
    .o_alu_last_bit(o_alu_l_b_flag)
);

//-------------------------------

//===========================================================================
// output assignments
//===========================================================================

// interface with data mem - input data
assign o_read_data_reg2 = data_rs2_s;

// interface with data mem - input address
assign o_alu_result_adr = alu_result_s;

endmodule
