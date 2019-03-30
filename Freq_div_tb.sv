module Freq_div_tb();

	logic clk_in;
	logic clk_out;
	
	Freq_div dut (clk_in,clk_out);
	
	initial begin
		assign clk_in = 0;	
	end
endmodule
