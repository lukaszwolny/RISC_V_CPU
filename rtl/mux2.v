/*
mux 2x1
*/
//-----------------------------------------------------------------------------

module mux2 #
(
    parameter   width   =   32
)
(
    // inputs
    input   [width-1:0] i_a,    // a
    input   [width-1:0] i_b,    // b
    // sel
    input               i_sel,  // sel  
    // output
    output  [width-1:0] o_out   // out
);

//===========================================================================
// output assignments
//===========================================================================

// mux
assign o_out = (i_sel) ? i_b : i_a;

endmodule
