/*
adder
*/
//-----------------------------------------------------------------------------

module adder #
(
    parameter   width   =   32
)
(
    // inputs
    input   [width-1:0] i_a,    
    input   [width-1:0] i_b,    
    // output
    output  [width-1:0] o_out   
);

//===========================================================================
// output assignments
//===========================================================================

assign o_out = i_b + i_a;

endmodule
