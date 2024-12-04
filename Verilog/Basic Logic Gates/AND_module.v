//------------------------------------------------------------------------------
// File: AND_module.v
// Description: Implementation of the AND gate built using the sNAND 
//              primitive gate as part of the "The Elements of Computing Systems" 
//              book projects by Noam Nisan and Shimon Schocken.
// Author: Santiago Jácome
//------------------------------------------------------------------------------
// Note: This module is part of a larger effort to build a complete computer 
//       from first principles, starting with a NAND gate.
//------------------------------------------------------------------------------

// Since the NOT module already includes the NAND, including that file here is not needed.
`include "NOT_module.v"

module sAND (a, b, out);
input a, b;
output out;

wire NAND_out;

sNAND NAND (a, b, NAND_out);
sNOT NOT (NAND_out, out);

endmodule
