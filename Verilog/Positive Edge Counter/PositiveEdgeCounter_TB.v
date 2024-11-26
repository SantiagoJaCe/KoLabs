// This is the PositiveEdgeCounter TestBench (TB)
// It consists of a clock generator, reset control, enable control and monitor logic.
// I also added dumpfile so that I can plot the waveform using "gtkwave" from Icarus Verilog.
module counter_tb();
//Declaring inputs as regs and outputs as wires
reg clock, reset, enable;
wire [3:0] counter_out;

initial begin
    $display ("time\t clk\t reset\t enable\t counter");
    $monitor ("%g\t %b\t %b\t %b\t %b", $time, clock, reset, enable, counter_out);
    clock = 1;
    reset = 0;
    enable = 0;
    #5 reset = 1;
    #10 reset = 0;
    #10 enable = 1;
    #100 enable = 0;
    #5 $finish;
end

// Dumpfile and dumpvars for waveform generation
initial begin
    $dumpfile("PosEdgeCounter_TB.vcd");
    $dumpvars(0, counter_tb);
end

//Clock Generator
always begin
    #5 clock = ~clock;
end

// DUT = Design under Test
first_counter DUT (clock, reset, enable, counter_out);

endmodule
