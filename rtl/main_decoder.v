/*
Main Decoder
*/
//-----------------------------------------------------------------------------

module main_decoder (
    // input instr control
    input       [6:0]   i_op,                   // opcode
    //input               i_f3,                   // funct3 1 bit - msb
    input       [2:0]   i_f3,                   // funct3 1 bit - msb
    // input flags
    input               i_zero,    // 
    input               i_alu_l_b, // 
    // output controls
    output reg          o_decoder_branch,       //     
    output reg  [1:0]   o_decoder_pc_imm_sel,   // pc_add_sel
    output reg          o_decoder_we_reg,       // 
    output reg  [2:0]   o_decoder_imm_type,     // 
    output reg          o_decoder_alu_src,      // 
    output reg          o_decoder_we_mem,       // 
    output reg  [1:0]   o_decoder_mux4_sel,     // 
    output reg  [1:0]   o_alu_control           // 
);

wire            funct3_bit;     // funct3 1 bit

assign funct3_bit = i_f3[2];

always @(*) begin
    o_decoder_branch        =   1'b0;
    o_decoder_pc_imm_sel    =   2'b00;
    o_decoder_we_reg        =   1'b0;
    o_decoder_imm_type      =   3'b000;
    o_decoder_alu_src       =   1'b0;
    o_decoder_we_mem        =   1'b0;
    o_decoder_mux4_sel      =   2'b00;
    o_alu_control           =   2'b00;

    case(i_op)
        7'b0110011: begin   //R-type
            o_decoder_we_reg = 1'b1;
        end
        7'b0010011: begin   //I-type alu
            o_decoder_we_reg = 1'b1;
            o_decoder_alu_src = 1'b1;
            o_alu_control = 2'b11;
        end
        7'b0000011: begin   //I-type load
            o_decoder_we_reg = 1'b1;
            o_decoder_alu_src = 1'b1;
            o_decoder_mux4_sel = 2'b01;
            o_alu_control = 2'b01;
        end
        7'b0100011: begin   //S-type
            o_decoder_imm_type = 3'b001;
            o_decoder_alu_src = 1'b1;
            o_decoder_we_mem = 1'b1;
            o_alu_control = 2'b01;
        end
        7'b1100011: begin   //B-type
            // branch decoder: 
            case(i_f3)
                3'b000: o_decoder_branch = i_zero;//if(zero) o_decoder_branch = 1'b1;  i_alu_l_b
                3'b001: o_decoder_branch = ~i_zero;
                3'b100: o_decoder_branch = i_alu_l_b;
                3'b101: o_decoder_branch = ~i_alu_l_b;
                3'b110: o_decoder_branch = i_alu_l_b;
                3'b111: o_decoder_branch = ~i_alu_l_b;
                default: o_decoder_branch = 1'b0;
            endcase
            // o_decoder_branch = 1'b1;
            o_decoder_pc_imm_sel = 2'b01;
            o_decoder_imm_type = 3'b010;
            //o_alu_control = (funct3_bit) ? 2'b11 : 2'b10;
            o_alu_control = 2'b10;
        end
        7'b1101111: begin   //J-type jal
            o_decoder_branch = 1'b1;
            o_decoder_pc_imm_sel = 2'b01;
            o_decoder_we_reg = 1'b1;
            o_decoder_imm_type = 3'b011;
            o_decoder_mux4_sel = 2'b10;
            o_alu_control = 2'b01;
        end
        7'b1100111: begin   //I-type jalr
            o_decoder_branch = 1'b1;
            o_decoder_pc_imm_sel = 2'b10;
            o_decoder_we_reg = 1'b1;
            o_decoder_mux4_sel = 2'b10;
            o_alu_control = 2'b01;
        end
        7'b0110111: begin   //U-type lui
            o_decoder_we_reg = 1'b1;
            o_decoder_imm_type = 3'b100;
            o_decoder_mux4_sel = 2'b11;
            o_alu_control = 2'b01;
        end
        7'b0010111: begin   //U-type auipc
            o_decoder_pc_imm_sel = 2'b01;
            o_decoder_we_reg = 1'b1;
            o_decoder_imm_type = 3'b100;
            o_decoder_mux4_sel = 2'b11;
            o_alu_control = 2'b01;
        end
        default: ;
    endcase
end

endmodule
