// Counter Design Block
// My second code ever, a 4-bit synchronous up counter
// Following the ASIC-World Courses

module first_counter (clock, reset, enable, counter_out);

//Inputs
input clock;
input reset;
input enable;
//Outputs
output [3:0] counter_out;

//Input Data Types
wire clock;
wire reset;
wire enable;

//Output Data Types
reg [3:0] counter_out;

//This will be a positive edge triggered counter, we will use edge sensitive lists with an always block

always @ (posedge clock)
begin : COUNTER
  // At every rising edge of clock we check if reset is active
  // If active, we load the counter output with 4'b0000
  if (reset == 1'b1) begin
    counter_out <= #1 4'b0000;
  end

  // If enable is active, then we increment the counter
  else if (enable == 1'b1) begin
    counter_out <= #1 counter_out + 1;
  end
end
endmodule
