//------------------------------------------------------------------------------
// File: MUX_module.v
// Description: Implementation of the MUX gate built using the sNAND 
//              primitive gate as part of the "The Elements of Computing Systems" book
//              projects by Noam Nisan and Shimon Schocken.
// Author: Santiago Jácome
//------------------------------------------------------------------------------
// Note: This module is part of a larger effort to build a complete computer 
//       from first principles, starting with a NAND gate.
//------------------------------------------------------------------------------

/**

I started by creating the truth table using inputs a, b, and sel. From that it was a matter of getting the canonical representation.
After simplifying using boolean algebra, I get that the equation that represents the MUX is:
!S * B + S * A. So let's build it!

**/

`include "XOR_module.v"

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