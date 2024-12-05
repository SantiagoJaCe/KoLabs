//------------------------------------------------------------------------------
// File: logic_gates.v
// Description: Library of all the basic logic gates I created, implemented in Verilog, including:
//              - sNAND: The fundamental NAND gate
//              - sNOT: NOT gate derived from NAND
//              - sAND: AND gate derived from NAND and NOT
//              - sOR: OR gate derived from NAND and NOT
//              - sXOR: XOR gate derived from NAND
//              - sMUX: 2-to-1 multiplexer
//              - sDEMUX: 1-to-2 demultiplexer
//
// Author: Santiago Jácome
// Date: 2024-12-05
//
// Note:
// This library contains only single-bit gate implementations. For 16-bit 
// versions of these gates, refer to the separate 16-bit logic gates library.
// The modules in this file are designed to be fundamental building blocks 
// for larger digital systems.
//------------------------------------------------------------------------------

// NAND Logic Gate
module sNAND (a, b, out);
input a, b;
output out;

reg out;

always @(*) begin
    if (a == b && b == 1'b1) begin
        out = 1'b0;
    end

    else begin
        out = 1'b1;
    end
end

endmodule

// NOT Logic Gate
module sNOT (in, out);
input in;
output out;

sNAND NAND (in, in, out);
endmodule

// AND Logic Gate
module sAND (a, b, out);
input a, b;
output out;

wire NAND_out;

sNAND NAND (a, b, NAND_out);
sNOT NOT (NAND_out, out);

endmodule

// OR Logic Gate
module sOR (a, b, out);
input a, b;
output out;

wire NAND_1_OUT;
wire NOT_B_OUT;

sNOT NOT_B (b, NOT_B_OUT);
sNAND NAND_1 (a, NOT_B_OUT, NAND_1_OUT);
sNAND NAND_2 (NOT_B_OUT, NAND_1_OUT, out);

endmodule

// XOR Logic Gate
module sXOR (a, b, out);
input a, b;
output out;

wire NOT_A_OUT;
wire NOT_B_OUT;

wire NAND_1_OUT;
wire NAND_2_OUT;

sNOT NOT_A (a, NOT_A_OUT);
sNOT NOT_B (b, NOT_B_OUT);

sNAND NAND_1 (NOT_A_OUT, b, NAND_1_OUT);
sNAND NAND_2 (a, NOT_B_OUT, NAND_2_OUT);

sNAND NAND (NAND_1_OUT, NAND_2_OUT, out);

endmodule

// MUX Logic Gate
module sMUX (a, b, sel, out);
input a, b, sel;
output out;

wire NOT_sel_out;
wire AND_a_out;
wire AND_b_out;

sNOT NOT_sel (sel, NOT_sel_out);
sAND AND_a (a, sel, AND_a_out);
sAND AND_b (b, NOT_sel_out, AND_b_out);

sOR OR1 (AND_a_out, AND_b_out, out);

endmodule

// DEMUX Logic Gate
module sDEMUX (in, sel, a, b);
input in, sel;
output a, b;

wire NOT_sel_out;

sAND AND_a (in, sel, a);

sNOT NOT_sel (sel, NOT_sel_out);

sAND AND_b (in, NOT_sel_out, b);

endmodule

