/*
mux 4x1
*/
//-----------------------------------------------------------------------------

module mux4 #
(
    parameter   width   =   32
)
(
    // inputs
    input       [width-1:0] i_a,    // a
    input       [width-1:0] i_b,    // b
    input       [width-1:0] i_c,    // c
    input       [width-1:0] i_d,    // d
    // sel
    input       [1:0]       i_sel,  // sel  
    // output
    output reg  [width-1:0] o_out   // out
);

//===========================================================================
// output assignments
//===========================================================================

// mux
always @(*) begin
    case(i_sel)
        2'b00: o_out = i_a;
        2'b01: o_out = i_b;
        2'b10: o_out = i_c;
        2'b11: o_out = i_d;
    endcase
end

endmodule
