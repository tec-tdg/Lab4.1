module Freq_div (input logic clk_in,output logic clk_out);


	   reg [27:0] counter_out;
	
	   always_ff @(negedge clk_in) 
			begin 
				if(counter_out == 28'b0010_1111_1010_1111_0000_1000_0000) counter_out <= 28'b0;
			   else begin counter_out <= counter_out+ 1;end
				clk_out <= counter_out[25];
			end
  
		  
		

endmodule
