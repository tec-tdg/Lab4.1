module Registro4 #(parameter N=32)( input logic reset,clk,en,carry_in,Overflow_in
												 input logic d_Result[N-1:0],d_Exp[7:0],
												 output logic q_Result[N-1:0],q_Exp[7:0]
												 output logic carry_out,overflow_out);


//reset asincronico

always_ff@(posedge clk,posedge reset)												 
		if (reset) begin q_Result<=32'b0; q_Exp<=8'b0; carry_out <= 1'b0; overflow_out<=1'b0 end 
		else if(en) begin q_Result<=d_Result; carry_out<=carry_in; q_Exp <=  d_Exp; overflow_out <= overflow_in end
			
												 
endmodule
