//------------------------------------------------------------------------------
// File: NOT_module.v
// Description: Implementation of the NOT gate built using the sNAND 
//              primitive gate as part of the "The Elements of Computing Systems" 
//              book projects by Noam Nisan and Shimon Schocken.
// Author: Santiago Jácome
//------------------------------------------------------------------------------
// Note: This module is part of a larger effort to build a complete computer 
//       from first principles, starting with a NAND gate.
//------------------------------------------------------------------------------

`include "NAND_module.v"
module sNOT (in, out);
input in;
output out;

sNAND NAND (in, in, out);
endmodule