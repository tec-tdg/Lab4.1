module Debounce_tb();
`timescale 1ns / 1ps
// testbench verilog code for debouncing button without creating another clock
 // Inputs
 logic pb_1;
 logic clk;
 // Outputs
 logic  pb_out;
 // Instantiate the debouncing Verilog code
 Debounce dut (
  .pb_1(pb_1), 
  .clk(clk), 
  .pb_out(pb_out)
 );
 initial begin
  clk = 0;
  forever #10 clk = ~clk;
 end
 initial begin
 //aqui hay que ver en que tiempo nos sirve hacer el rebote
  pb_1 = 0;
  #10000;
  pb_1=1;
  #20000;
  pb_1 = 0;
  #10000;
  pb_1=1;
  #30000; 
  pb_1 = 0;
  #10000;
  pb_1=1;
  #40000;
  pb_1 = 0;
  #10;
  pb_1=1;
  #30; 
  pb_1 = 0;
  #10;
  pb_1=1; 
  #400; 
  pb_1 = 0;
  #10;
  pb_1=1;
  #20;
  pb_1 = 0;
  #10;
  pb_1=1;
  #30; 
  pb_1 = 0;
  #10;
  pb_1=1;
  #40;
  pb_1 = 0; 
 end 
      
endmodule
