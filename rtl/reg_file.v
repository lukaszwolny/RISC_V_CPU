/*
Registers
*/
//-----------------------------------------------------------------------------

module reg_file (
    // clock and reset
    input           i_clk,          // clock
    input           i_rst,          // asynchronous reset (active low)
    // inputs
    input   [4:0]   i_read_reg1,    // reg read 1
    input   [4:0]   i_read_reg2,    // reg read 2
    input   [4:0]   i_write_reg,    // reg where to save input data
    input   [31:0]  i_write_data,   // data to save
    // control
    input           i_write_en,     // write enable
    // outputs
    output  [31:0]  o_read_data1,   // output data 1
    output  [31:0]  o_read_data2    // output data 2
);

integer i; // loop

//===========================================================================
// internal signals
//===========================================================================

reg [31:0]  reg_file    [0:31]; // reg file

//===========================================================================
// internal logic
//===========================================================================

// reg logic
always @(posedge i_clk or negedge i_rst) begin
    if(!i_rst) begin
        for(i=0; i < 32; i=i+1) begin
            reg_file[i] <= 32'd0;
        end 
    end else begin
        if(i_write_en && i_write_reg != 5'd0) reg_file[i_write_reg] <= i_write_data;
    end
end

//===========================================================================
// output assignments
//===========================================================================

// read data 1 output
assign o_read_data1 = (i_read_reg1 == 5'd0) ? 32'd0 : reg_file[i_read_reg1];

// read data 2 output
assign o_read_data2 = (i_read_reg2 == 5'd0) ? 32'd0 : reg_file[i_read_reg2];

endmodule
