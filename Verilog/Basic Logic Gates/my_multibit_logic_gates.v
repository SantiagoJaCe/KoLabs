//------------------------------------------------------------------------------
// File: multi_bit_gates.v
// Description: Library of multi-bit logic gates implemented in Verilog, including:
//              - sNOT16: 16-bit NOT gate
//              - sAND16: 16-bit AND gate
//              - sOR16: 16-bit OR gate
//              - sMUX16: 16-bit 2-to-1 multiplexer
//              - sOR8WAY: 8-input OR gate
//              - sMUX4WAY16: 16-bit 4-to-1 multiplexer
//              - sMUX8WAY16: 16-bit 8-to-1 multiplexer
//              - sDMUX4WAY: 1-to-4 demultiplexer
//              - sDMUX8WAY: 1-to-8 demultiplexer
//
// Author: Santiago Jácome
// Date: 2024-12-05
//
// Note:
// This library is an extension of the simple gates library and implements
// multi-bit and multi-way gates. These modules are designed to handle larger
// data widths and complex selection mechanisms, making them suitable for 
// building scalable digital systems.
//------------------------------------------------------------------------------

/** 

For these multibit gates, I learned about the "generate" keyword and "genvar" variable type, which will help
me use my simple gates iteratively to create multi-bit ones

**/

`include "my_simple_logic_gates.v"

// NOT16 Logic Gate
module sNOT16 (in, out);
input [15:0] in;
output [15:0] out;

genvar i;

generate
    for(i = 0; i < 16; i = i + 1) begin
        sNOT NOT (in[i], out[i]);
    end
endgenerate

endmodule

// AND16 Logic Gate
module sAND16 (a, b, out);
input [15:0] a, b;
output [15:0] out;

genvar i;

generate
    for(i = 0; i < 16; i = i + 1) begin
        sAND AND (a[i], b[i], out[i]);
    end
endgenerate

endmodule

// OR16 Logic Gate
module sOR16 (a, b, out);
input [15:0] a, b;
output [15:0] out;

genvar i;

generate
    for(i = 0; i < 16; i = i + 1) begin
        sOR OR (a[i], b[i], out[i]);
    end
endgenerate

endmodule

// MUX16 Logic Gate
module sMUX16 (a, b, sel, out);
input [15:0] a, b;
input sel;
output [15:0] out;

genvar i;

generate
    for(i = 0; i < 16; i = i + 1) begin
        sMUX MUX (a[i], b[i], sel, out[i]);
    end
endgenerate

endmodule

// OR 8-Way Logic Gate
module sOR8WAY (in, out);
input [7:0] in;
output out;

wire [7:0] temp;

genvar i;
generate
    for(i = 0; i < 8; i = i + 1) begin
        if (i == 0) begin
            sOR OR1 (in[i], in[i+1], temp[i]);
        end
        else begin
            sOR OR2 (temp[i-1], in[i+1], temp[i]);
        end
    end
endgenerate

assign out = temp[6];

endmodule

// MUX16 4-Way Gate
module sMUX4WAY16 (a, b, c, d, sel_1, sel_2, out);
input [15:0] a, b, c, d;
input sel_1, sel_2;
output [15:0] out;

wire NOT_sel_1, NOT_sel_2;
wire [15:0] AND_a_out, AND_b_out, AND_c_out, AND_d_out, AND_first_term, AND_second_term;
wire [15:0] or_1, or_2, term_1, term_2;

sNOT NOT_1 (sel_1, NOT_sel_1);
sNOT NOT_2 (sel_2, NOT_sel_2);

//Term 1
sAND16 AND_a (a, {16{NOT_sel_2}}, AND_a_out);
sAND16 AND_b (b, {16{sel_2}}, AND_b_out);
sOR16 OR_1 (AND_a_out, AND_b_out, or_1);
sAND16 AND_t1 (or_1, {16{NOT_sel_1}}, term_1);

//Term 2
sAND16 AND_1 (c, {16{NOT_sel_2}}, AND_c_out);
sAND16 AND_2 (d, {16{sel_2}}, AND_d_out);
sOR16 OR_X (AND_c_out, AND_d_out, or_2);
sAND16 AND_X (or_2, {16{sel_1}}, term_2);

//Out
sOR16 MUX_out (term_1, term_2, out);

endmodule

//MUX16 8-Way
module sMUX8WAY16 (a, b, c, d, e, f, g, h, sel_1, sel_2, sel_3, out);
input [15:0] a, b, c, d, e, f, g, h;
input sel_1, sel_2, sel_3;
output [15:0] out;

wire [15:0] NOT_sel_1, NOT_sel_2, NOT_sel_3;
wire [15:0] AND_a_out, AND_b_out, AND_c_out, AND_d_out, AND_e_out, AND_f_out, AND_g_out, AND_h_out;
wire [15:0] AND_a_1, AND_a_2, AND_b_1, AND_b_2, AND_c_1, AND_c_2, AND_d_1, AND_d_2, AND_e_1, AND_e_2, AND_f_1, AND_f_2, AND_g_1, AND_g_2, AND_h_1, AND_h_2;
wire [15:0] or_1, or_2, or_3, or_4, or_5, or_6, or_7;

sNOT16 NOT_1 ({16{sel_1}}, NOT_sel_1);
sNOT16 NOT_2 ({16{sel_2}}, NOT_sel_2);
sNOT16 NOT_3 ({16{sel_3}}, NOT_sel_3);

// Canonical Representation: !s1*(!s2*(a*!s3 + b*s3) + s2(c*!s3 + d*s3)) + s1*(!s2*(e*!s3 + f*s3) + s2*(g*!s3 + h*s3))

//Term 1
wire [15:0] and1_out, and2_out, and3_out, or1_out;
sAND16 and1 (a, NOT_sel_3, and1_out);           //a*!s3
sAND16 and2 (b, {16{sel_3}}, and2_out);         //b*s3
sOR16 or1 (and1_out, and2_out, or1_out);        //a*!s3 + b*s3
sAND16 and3 (NOT_sel_2, or1_out, and3_out);     //!s2*(a*!s3 + b*s3)

wire [15:0] and4_out, and5_out, and6_out, or2_out;
sAND16 and4 (c, NOT_sel_3, and4_out);           //c*!s3
sAND16 and5 (d, {16{sel_3}}, and5_out);         //d*s3
sOR16 or2 (and4_out, and5_out, or2_out);        //c*!s3 + d*s3
sAND16 and6 ({16{sel_2}}, or2_out, and6_out);   //s2 * (c*!s3 + d*s3)

wire [15: 0] or3_out, and_first_term;

sOR16 or3 (and3_out, and6_out, or3_out);        // (!s2*(a*!s3 + b*s3)) + (s2 * (c*!s3 + d*s3))
sAND16 and7 (NOT_sel_1, or3_out, and_first_term); // !s1 * ((!s2*(a*!s3 + b*s3)) + (s2 * (c*!s3 + d*s3)))

//Term 2
wire [15:0] and8_out, and9_out, and10_out, or4_out;
sAND16 and8 (e, NOT_sel_3, and8_out);           // e*!s3
sAND16 and9 (f, {16{sel_3}}, and9_out);         // f*s3
sOR16 or4 (and8_out, and9_out, or4_out);        // e*!s3 + f*s3
sAND16 and10 (NOT_sel_2, or4_out, and10_out);   // !s2 * (e*!s3 + f*s3)

wire [15:0] and11_out, and12_out, and13_out, or5_out;
sAND16 and11 (g, NOT_sel_3, and11_out);         // g*!s3
sAND16 and12 (h, {16{sel_3}}, and12_out);       // h*s3
sOR16 or5 (and11_out, and12_out, or5_out);      // (g*!s3) + (h*s3)
sAND16 and13 ({16{sel_2}}, or5_out, and13_out); // s2 * ((g*!s3) + (h*s3))

wire [15:0] or6_out, and_second_term;
sOR16 or6 (and10_out, and13_out, or6_out);
sAND16 and14 ({16{sel_1}}, or6_out, and_second_term);

//Out
sOR16 MUX_out (and_first_term, and_second_term, out);

endmodule

// DEMUX4WAY Logic Gate
module sDEMUX4WAY (in, sel_1, sel_2, a, b, c, d);
input in, sel_1, sel_2;
output a, b, c, d;

wire NOT_sel_1_out, NOT_sel_2_out;
sNOT NOT_sel1 (sel_1, NOT_sel_1_out);
sNOT NOT_sel2 (sel_2, NOT_sel_2_out);

wire a_out, b_out, c_out, d_out;

sAND AND_a (in, NOT_sel_1_out, a_out);
sAND AND_a2 (a_out, NOT_sel_2_out, a);

sAND AND_b (in, NOT_sel_1_out, b_out);
sAND AND_b2 (b_out, sel_2, b);

sAND AND_c (in, sel_1, c_out);
sAND AND_c2 (c_out, NOT_sel_2_out, c);

sAND AND_d (in, sel_1, d_out);
sAND AND_d2 (d_out, sel_2, d);

endmodule

// DEMUX8WAY Logic Gate
module sDEMUX8WAY (in, sel_1, sel_2, sel_3, a, b, c, d, e, f, g, h);
input in, sel_1, sel_2, sel_3;
output a, b, c, d, e, f, g, h;

wire NOT_sel_1_out, NOT_sel_2_out, NOT_sel_3_out;
sNOT NOT_sel1 (sel_1, NOT_sel_1_out);
sNOT NOT_sel2 (sel_2, NOT_sel_2_out);
sNOT NOT_sel3 (sel_3, NOT_sel_3_out);

// Select Combinations

// !s1 * !s2 * !s3 - 0 0 0
wire and1_out, sel_0_0_0;
sAND and1 (NOT_sel_1_out, NOT_sel_2_out, and1_out);
sAND and2 (and1_out, NOT_sel_3_out, sel_0_0_0);

// !s1 * !s2 * s3 - 0 0 1
wire sel_0_0_1;
sAND and3 (and1_out, sel_3, sel_0_0_1);

// !s1 * s2 * !s3 - 0 1 0
wire and4_out, sel_0_1_0;
sAND and4 (NOT_sel_1_out, sel_2, and4_out);
sAND and5 (and4_out, NOT_sel_3_out, sel_0_1_0);

// !s1 * s2 * s3 - 0 1 1
wire sel_0_1_1;
sAND and6 (and4_out, sel_3, sel_0_1_1);

// s1 * !s2 * !s3 - 1 0 0
wire and7_out, sel_1_0_0;
sAND and7 (sel_1, NOT_sel_2_out, and7_out);
sAND and8 (and7_out, NOT_sel_3_out, sel_1_0_0);

// s1 * !s2 * s3 - 1 0 1
wire sel_1_0_1;
sAND and9 (and7_out, sel_3, sel_1_0_1);

// s1 * s2 * !s3 - 1 1 0
wire and10_out, sel_1_1_0;
sAND and10 (sel_1, sel_2, and10_out);
sAND and11 (and10_out, NOT_sel_3_out, sel_1_1_0);

// s1 * s2 * s3 - 1 1 1
wire sel_1_1_1;
sAND and12 (and10_out, sel_3, sel_1_1_1);

// ANDing with the input and corresponding output
sAND and_a_output (in, sel_0_0_0, a);
sAND and_b_output (in, sel_0_0_1, b);
sAND and_c_output (in, sel_0_1_0, c);
sAND and_d_output (in, sel_0_1_1, d);
sAND and_e_output (in, sel_1_0_0, e);
sAND and_f_output (in, sel_1_0_1, f);
sAND and_g_output (in, sel_1_1_0, g);
sAND and_h_output (in, sel_1_1_1, h);

endmodule