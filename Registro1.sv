module Registro1 #(parameter N=32)( input logic reset,clk,en,
												 input logic [N-1:0] d_A,d_B,
												 output logic [N-1:0] q_A,q_B);


//reset asincronico

always_ff@(negedge clk,posedge reset)												 
		if (reset) begin q_A<=32'b0; q_B<=32'b0; end 
		else if(en) begin q_A<=d_A; q_B<=d_B; end
			
												 
endmodule
