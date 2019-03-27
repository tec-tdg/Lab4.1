module Registro2 #(parameter N=32)( input logic reset,clk,en,
												 input logic [N-1:0]d_Ma,d_Me,
												 output logic [N-1:0]q_Ma,q_Me);


//reset asincronico

always_ff@(posedge clk,posedge reset)												 
		if (reset) begin q_Ma<=32'b0; q_Me<=32'b0;end
		else if(en) begin q_Ma<=d_Ma; q_Me<=d_Me; end
			
												 
endmodule
