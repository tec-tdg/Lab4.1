module Debounce_tb();
`timescale 10ms / 10us
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
  forever #1000 clk = ~clk;
 end
 initial begin
 //se enciende el boton
  pb_1 = 0;
  #1000000000;
  pb_1=1;
  #20000000;
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #30000000; 
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #40000000;
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #30000000; 
  pb_1 = 0;
  #10000000;
  pb_1=1; 
  #400000000; 
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #20000000;
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #30000000; 
  pb_1 = 0;
 
  
  //se apaga boton
  
  #1000000000;
  pb_1=0;
  

  pb_1=1;
  #20000000;
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #30000000; 
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #40000000;
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #30000000; 
  pb_1 = 0;
  #10000000;
  pb_1=1; 
  #400000000; 
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #20000000;
  pb_1 = 0;
  #10000000;
  pb_1=1;
  #30000000; 
  pb_1 = 0;
 
 
 
 end 
      
endmodule
