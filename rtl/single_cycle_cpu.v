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

wire    [31:0]  instruction;    // full instr
wire    [6:0]   opcode;         // opcode
wire    [2:0]   funct3;         // funct3
wire            funct7_bit;     // funct7 instr[30]
wire            branch;         // branch
wire    [1:0]   pc_imm_sel;     // mux sel pc/reg/0 + imm
wire            we_reg;         // write enable reg
wire    [2:0]   imm_type;       // imm type sel
wire    [3:0]   alu_op;         // alu op sel
wire            alu_src;        // mux sel alu
wire            we_mem;         // write enable data mem
wire    [1:0]   mux4_sel;       // mux4x1 sel
wire    [31:0]  dmem_data;      // data mem data
wire    [31:0]  alu_result_adr; // data mem: address (alu result)
wire    [31:0]  read_data_reg2; // data mem: data (rs2)
wire    [31:0]  instr_adr;      // instr adr 
wire            zero_flag;      // 
wire            alu_l_b_flag;   // 

//===========================================================================
// internal logic
//===========================================================================

//-------------------------------
// processor

// split instr into opcode,....
assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7_bit = instruction[30];

// control unit
control_unit u_control_unit (
    .i_opcode(opcode),       // instruction opcode
    .i_funct3(funct3),       // instruction funct3
    .i_funct7_bit(funct7_bit),   // instruction funct7 1 bit
    .i_zero_flag(zero_flag),    // 
    .i_alu_l_b_flag(alu_l_b_flag), // 
    .o_branch(branch),       // branch signal
    .o_pc_imm_sel(pc_imm_sel),   // (pc_add_sel) pc_imm mux signal
    .o_we_reg(we_reg),       // write enable register
    .o_imm_type(imm_type),     // immediate type sel
    .o_alu_op(alu_op),       // alu operation
    .o_alu_src(alu_src),      // alu mux sel
    .o_we_mem(we_mem),       // write enable datamem
    .o_mux4_sel(mux4_sel)      // mux4x1 sel
);

// datapath
datapath u_datapath(
    .i_clk(i_clk),
    .i_rst(i_rst),               
    .i_branch(branch),            // jump
    .i_pc_imm_mux(pc_imm_sel),        // pc mux sel o/pc/reg
    .i_we_reg(we_reg),            // write enable register file
    .i_imm_type_sel(imm_type),      // immediate type sel
    .i_alu_operation(alu_op),     // alu control
    .i_alu_src(alu_src),           // alu mux sel
    .i_mux4_sel(mux4_sel),          // mux4x1 sel
    .i_instruction(instruction),       // full instr 32bits
    .i_read_data(dmem_data),         // data from data mem
    .o_alu_result_adr(alu_result_adr),    // data mem address input
    .o_read_data_reg2(read_data_reg2),    // data to datamem
    .o_instr_adr(instr_adr),         // pc output - as instr mem address
    .o_zero_flag(zero_flag),         // alu zero flag
    .o_alu_l_b_flag(alu_l_b_flag)       // alu last bit result flag
);

//-------------------------------
// external memory

// instr mem
instr_mem #(
    .depth(256)
) u_instr_mem (
    .i_addr(instr_adr),
    .o_instr(instruction)
);

// data mem
data_mem #(
    .depth(256)
) u_data_mem (
    .i_clk(i_clk),
    .i_address(alu_result_adr),
    .i_data(read_data_reg2),
    .i_write_en(we_mem),
    .i_funct3(funct3),
    .o_data(dmem_data)
);

//-------------------------------

endmodule
