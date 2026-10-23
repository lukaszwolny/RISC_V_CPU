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

//sim
//---
// bubble
// integer i;
// initial begin
//     for (i = 0; i < depth*4; i = i + 1)
//         mem_data[i] = 8'h00;

//     //array = 
//     mem_data[0]  = 8'd64;
//     mem_data[4]  = 8'd34;
//     mem_data[8]  = 8'd25;
//     mem_data[12] = 8'd12;
//     mem_data[16] = 8'd22;
//     mem_data[20] = 8'd11;
//     mem_data[24] = 8'd90;
//     // length = 5
//     mem_data[28] = 8'd7;
// end

//---
// //binarysearch
// integer i;
// initial begin
//     for (i = 0; i < depth*4; i = i + 1)
//         mem_data[i] = 8'h00;

//     //array = 
//     mem_data[0]  = 8'd2;
//     mem_data[4]  = 8'd5;
//     mem_data[8]  = 8'd8;
//     mem_data[12] = 8'd12;
//     mem_data[16] = 8'd16;
//     mem_data[20] = 8'd23;
//     mem_data[24] = 8'd38;
//     mem_data[28] = 8'd56;
//     mem_data[32] = 8'd72;
//     mem_data[36] = 8'd91;
//     // length = 5
//     mem_data[40] = 8'd10;
//     mem_data[44] = 8'd56;
// end
//---
//---
//binarysearch
integer i;
initial begin
    for (i = 0; i < depth*4; i = i + 1)
        mem_data[i] = 8'h00;

    //array = 
    mem_data[0]  = 8'd64;
    mem_data[4]  = 8'd34;
    mem_data[8]  = 8'd25;
    mem_data[12] = 8'd12;
    mem_data[16] = 8'd22;
    mem_data[20] = 8'd11;
    mem_data[24] = 8'd90;
    mem_data[28] = 8'd45;
    // length = 5
    mem_data[32] = 8'd8;
end
//---
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
