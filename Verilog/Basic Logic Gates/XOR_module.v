//------------------------------------------------------------------------------
// File: XOR_module.v
// Description: Implementation of the XOR gate built using the sNAND 
//              primitive gate as part of the "The Elements of Computing Systems" book
//              projects by Noam Nisan and Shimon Schocken.
// Author: Santiago Jácome
//------------------------------------------------------------------------------
// Note: This module is part of a larger effort to build a complete computer 
//       from first principles, starting with a NAND gate.
//------------------------------------------------------------------------------

// This one was much easier, using DeMorgan's Law again it's very quick to solve:

`include "AND_module.v"

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