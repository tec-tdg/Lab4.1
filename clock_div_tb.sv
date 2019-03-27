module clock_div_tb();
`timescale 1ns / 1ps
// testbench verilog code for debouncing button without creating another clock
 // Inputs

 logic clk;
 // Outputs
 logic  out;
 // Instantiate the debouncing Verilog code
 clock_div dut (
  clk, 
  out
 );
 initial begin
  clk = 0;
  forever #10 clk = ~clk;
 end
      
endmodule
