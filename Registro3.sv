module Registro3 #(parameter N=32)( input logic reset,clk,en,
												 input logic [N-1:0] d_X, d_Y,
												 input logic [22:0] d_man,
												 output logic [N-1:0] q_X, q_Y,
												  output logic [22:0] q_man);


//reset asincronico 

always_ff@(negedge clk,posedge reset)												 
		if (reset) begin q_X<=32'b0; q_Y<=32'b0; q_man<=23'b0; end 
		else if(en) begin q_X<=d_X; q_Y<=d_Y; q_man <=  d_man; end
			
												 
endmodule
