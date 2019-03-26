module shiftRightLog #(parameter N=1) (
	input [N-1:0] _in, _delay,
	output [N-1:0] _out);
	
	assign _out = _in >> _delay;
	
endmodule
