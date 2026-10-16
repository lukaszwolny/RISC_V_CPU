/*
Data MEM
+ decoder funct3
*/
//-----------------------------------------------------------------------------

module data_mem #
(
    parameter   depth   =   256
)
(
    // clock
    input               i_clk,      // clock
    // input
    input       [31:0]  i_address,  // input address
    input       [31:0]  i_data,     // data to write
    // controls
    input               i_write_en, // write enable
    input       [2:0]   i_funct3,   // control
    // output
    output reg  [31:0]  o_data      // read data
);

//===========================================================================
// internal signals
//===========================================================================

// reg [31:0] mem_data [0:depth-1];
reg [7:0]   mem_data    [0:(depth*4)-1];    // mem

//===========================================================================
// internal logic
//===========================================================================

// write logic
always @(posedge i_clk) begin
    if(i_write_en) begin
        case(i_funct3)
            3'b000: mem_data[i_address] <= i_data[7:0]; // sb
            3'b001: {mem_data[i_address+1], mem_data[i_address]} <= i_data[15:0]; // sh
            3'b010: {mem_data[i_address+3], mem_data[i_address+2], mem_data[i_address+1], mem_data[i_address]} <= i_data; // sw
            default: ;
        endcase
    end
end

//===========================================================================
// output assignments
//===========================================================================

// read output logic
always @(*) begin
    case(i_funct3)
        3'b000: o_data = {{24{mem_data[i_address][7]}}, mem_data[i_address]};
        3'b001: o_data = {{16{mem_data[i_address+1][7]}}, mem_data[i_address+1], mem_data[i_address]};
        3'b010: o_data = {mem_data[i_address+3], mem_data[i_address+2], mem_data[i_address+1], mem_data[i_address]};
        3'b100: o_data = {24'd0, mem_data[i_address]};
        3'b101: o_data = {16'd0, mem_data[i_address+1], mem_data[i_address]};
        default: o_data = 32'd0;
    endcase
end

endmodule
