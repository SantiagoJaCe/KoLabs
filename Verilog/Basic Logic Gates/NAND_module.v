//------------------------------------------------------------------------------
// File: NAND_module.v
// Description: Implementation of the NAND gate built from scratch as part of the "The Elements of Computing Systems" 
//              book projects by Noam Nisan and Shimon Schocken.
// Author: Santiago Jácome
//------------------------------------------------------------------------------
// Note: This module is part of a larger effort to build a complete computer 
//       from first principles, starting with a NAND gate.
//------------------------------------------------------------------------------


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