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
    input   [width-1:0] i_a,    // a
    input   [width-1:0] i_b,    // b
    // output
    output  [width-1:0] o_out   // result
);

//===========================================================================
// output assignments
//===========================================================================

// adder
assign o_out = i_a + i_b;

endmodule
