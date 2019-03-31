module Freq_div2 (input logic clk_in,output logic clk_out);


	   reg [27:0] counter_out;
	
	   always_ff @(negedge clk_in) 
			begin 
				if(counter_out == 28'b101_1111_0101_1110_0001_0000_00000) counter_out <= 28'b0;
			   else begin counter_out <= counter_out+ 1;end
				clk_out <= counter_out[27];
			end
  
		  
		

endmodule
