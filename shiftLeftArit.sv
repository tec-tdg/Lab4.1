module shiftLeftArit #(parameter N=1) (
	input signed  [N-1:0] _in, input [7:0] _delay,
	output [N-1:0] _out);
	
	assign _out = _in <<< _delay;
	
endmodule
