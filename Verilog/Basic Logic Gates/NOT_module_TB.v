//Test bench for NOT Gate

module sNOT_TB();

reg in;

initial begin
    $dumpfile("NOT_module_TB.vcd");
    $dumpvars(0, sNOT_TB);
end

initial begin
    $display ("in\t out\t");
    $monitor ("%b\t %b\t", in, out);

    in = 1; #10;
    in = 0; #10;
    $finish;
end



sNOT DUT (in, out);
endmodule