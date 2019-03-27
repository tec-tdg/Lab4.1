module notGate #(parameter N=1) (
	input [N-1:0] a_i,
	output [N-1:0] y_o);
	
	assign y_o = ~a_i;
	
endmodule
