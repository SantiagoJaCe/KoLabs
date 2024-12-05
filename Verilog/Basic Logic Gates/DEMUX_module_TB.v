//Test bench for DEMUX Gate

module sDEMUX_TB();

reg in, sel;

initial begin
    $dumpfile("DEMUX_module_TB.vcd");
    $dumpvars(0, sDEMUX_TB);
end

initial begin
    $display ("a\t b\t a\t b\t");
    $monitor ("%b\t %b\t %b\t %b\t", in, sel, a, b);

    in = 0; sel = 0; #10;
    in = 0; sel = 1; #10;
    in = 1; sel = 0; #10;
    in = 1; sel = 1; #10;
    $finish;
end



sDEMUX DUT (in, sel, a, b);
endmodule