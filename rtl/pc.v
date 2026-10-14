/*
pc logic
*/
//-----------------------------------------------------------------------------

module pc(
    // clock and reset
    input           i_clk,          // clock
    input           i_rst,          // asynchronous reset (active low)
    // controlls
    input           i_branch_sel,   // branch mux
    input   [1:0]   i_pc_imm_sel,   // imm adder mux 0/reg/pc
    // values
    input   [31:0]  i_imm,          // immeduate value
    input   [31:0]  i_reg_read,     // read reg data value
    // outputs
    output  [31:0]  o_pc4,          // output pc+4
    output  [31:0]  o_pc_imm,       // output imm+0/pc/reg
    output  [31:0]  o_pc            // output pc
);

//===========================================================================
// internal signals
//===========================================================================

reg     [31:0]  pc_r;       // pc reg
wire    [31:0]  pc_next_s;  // pc value after mux branch
wire    [31:0]  pc4_s;      // pc value after +4
wire    [31:0]  pc_imm_s;   // pc value after +imm
wire    [31:0]  mux_add_s;  // value befor addder_imm

//===========================================================================
// internal logic
//===========================================================================

// pc reg
always @(posedge i_clk or negedge i_rst) begin
    if(!i_rst) pc_r <= 32'd0;
    else pc_r <= pc_next_s;
end

// mux branch
mux2 #(
    .width(32)
) u_mux2 (
    .i_a(pc4_s),
    .i_b(pc_imm_s),
    .i_sel(i_branch_sel),
    .o_out(pc_next_s)
);

// add +4
adder #(
    .width(32)
) u_adder4 (
    .i_a(pc_r),
    .i_b(32'd4),
    .o_out(pc4_s)
);

// mux adder sel
mux3 #(
    .width(32)
) u_mux3 (
    .i_a(32'd0),
    .i_b(pc_r),
    .i_c(i_reg_read),
    .i_sel(i_pc_imm_sel),
    .o_out(mux_add_s)
);

// add +imm
adder #(
    .width(32)
) u_adder_imm (
    .i_a(i_imm),
    .i_b(mux_add_s),
    .o_out(pc_imm_s)
);

//===========================================================================
// output assignments
//===========================================================================

//  currnent pc value
assign o_pc = pc_r;

// pc + 4 value
assign o_pc4 = pc4_s;

// pc/pc+reg/pc+imm value
assign o_pc_imm = pc_imm_s;

endmodule
