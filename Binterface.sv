module Binterface #(parameter N=1)(
	input [N-1:0] b_i, 
	input [3:0] control,
	output [N-1:0] result); 
	
	
	logic or_out;
	assign or_out = control[0]| control[1]| control[2]| control[3] ;
	
	
	logic [N-1:0] array_or_out;
	genvar i;
	
	generate 
		for (i = 0; i < N; i = i+1) begin:forloop
			assign array_or_out[i]= or_out;
		end
	
	endgenerate
	
	logic [N-1:0] b_i_prima;
	
	xorGate#N xor_out(b_i,array_or_out,b_i_prima);
	
	
	assign result = b_i_prima + or_out ;
	
endmodule
