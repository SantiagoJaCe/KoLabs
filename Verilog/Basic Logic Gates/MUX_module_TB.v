//Test bench for MUX Gate

module sMUX_TB();

reg a, b, sel;

initial begin
    $dumpfile("MUX_module_TB.vcd");
    $dumpvars(0, sMUX_TB);
end

initial begin
    $display ("a\t b\t sel\t out\t");
    $monitor ("%b\t %b\t %b\t %b\t", a, b, sel, out);

    a = 0; b = 0; sel = 0; #10;
    a = 0; b = 0; sel = 1; #10;
    a = 0; b = 1; sel = 0; #10;
    a = 0; b = 1; sel = 1; #10;
    a = 1; b = 0; sel = 0; #10;
    a = 1; b = 0; sel = 1; #10;
    a = 1; b = 1; sel = 0; #10;
    a = 1; b = 1; sel = 1; #10;
    $finish;
end



sMUX DUT (a, b, sel, out);
endmodule