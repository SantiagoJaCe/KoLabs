//------------------------------------------------------------------------------
// File: OR_module.v
// Description: Implementation of the OR gate built using the sNAND 
//              primitive gate as part of the "The Elements of Computing Systems" book
//              projects by Noam Nisan and Shimon Schocken.
// Author: Santiago Jácome
//------------------------------------------------------------------------------
// Note: This module is part of a larger effort to build a complete computer 
//       from first principles, starting with a NAND gate.
//------------------------------------------------------------------------------

/**
We start with the Canonical Representation, creatd from evaluating the OR Truth Table.
Canonical OR: !A*B + A*!B + A*B

Using Boolean algebra we can simplify to: B + A*!B
With De Morgan's Law (!A + !B = !(A*B)) we get that OR can be represented with: !(!B * ![A * !B])
Which is basically NAND(!B, NAND(A,!B))
**/

`include "NOT_module.v"

module sOR (a, b, out);
input a, b;
output out;

wire NAND_1_OUT;
wire NOT_B_OUT;

sNOT NOT_B (b, NOT_B_OUT);
sNAND NAND_1 (a, NOT_B_OUT, NAND_1_OUT);
sNAND NAND_2 (NOT_B_OUT, NAND_1_OUT, out);

endmodule
