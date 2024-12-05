//------------------------------------------------------------------------------
// File: DEMUX_module.v
// Description: Implementation of the DEMUX gate built using the sNAND 
//              primitive gate as part of the "The Elements of Computing Systems" book
//              projects by Noam Nisan and Shimon Schocken.
// Author: Santiago Jácome
//------------------------------------------------------------------------------
// Note: This module is part of a larger effort to build a complete computer 
//       from first principles, starting with a NAND gate.
//------------------------------------------------------------------------------

`include "MUX_module.v"

module sDEMUX (in, sel, a, b);

input in, sel;
output a, b;

wire NOT_sel_out;

sAND AND_a (in, sel, a);

sNOT NOT_sel (sel, NOT_sel_out);

sAND AND_b (in, NOT_sel_out, b);

endmodule