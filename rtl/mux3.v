/*
mux 3x1
*/
//-----------------------------------------------------------------------------

module mux3 #
(
    parameter   width   =   32
)
(
    // inputs
    input       [width-1:0] i_a,    
    input       [width-1:0] i_b,    
    input       [width-1:0] i_c,    
    // sel
    input       [1:0]       i_sel,  
    // output
    output reg  [width-1:0] o_out   
);

//===========================================================================
// output assignments
//===========================================================================

always @(*) begin
    case(i_sel)
        2'b00: o_out = i_a;
        2'b01: o_out = i_b;
        2'b10: o_out = i_c;
        default: o_out = i_a;
    endcase
end

endmodule
