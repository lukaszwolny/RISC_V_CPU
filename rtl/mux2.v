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
    input   [width-1:0] i_a,    
    input   [width-1:0] i_b,    
    // sel
    input               i_sel,  
    // output
    output  [width-1:0] o_out   
);

//===========================================================================
// output assignments
//===========================================================================

assign o_out = (i_sel) ? i_b : i_a;

endmodule
