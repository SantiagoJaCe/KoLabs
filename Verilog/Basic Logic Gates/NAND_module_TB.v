//Test bench for NAND Gate

module sNAND_TB();

reg a, b;

initial begin
    $dumpfile("NAND_module_TB.vcd");
    $dumpvars(0, sNAND_TB);
end

initial begin
    $display ("a\t b\t out\t");
    $monitor ("%b\t %b\t %b\t", a, b, out);

    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
    $finish;
end



sNAND DUT (a, b, out);
endmodule