module FASE4 #(N = 32) ( input logic [N-1:0] Mayor,Menor,
								 input logic [7:0] exponente_prima, 
								 input logic [22:0] mantisa_resultado,
								 input logic carry_out_exp, 
								 input logic carry_out_mantisa,
								 output logic [N-1:0] Mayor_res,Menor_res,
								 output logic float_number_sgn,
								 output logic [7:0] float_number_exp,
								 output logic [22:0] float_number_man,
								 output logic overflow );
								 

	//shift right
	/*
	input   signed[N-1:0] _in,input [7:0] _delay,
	output [N-1:0] _out);
	*/
	
	logic [22:0] mantisa_resultado_shifted;
	logic [7:0] delay_value;
	
	assign delay_value	= { 7'b0000000,carry_out_mantisa};
	
	shiftRightArit#23 shifter(mantisa_resultado,delay_value,mantisa_resultado_shifted);
	
	
	
	//conformar el número
	assign Mayor_res = Mayor; 
	assign Menor_res =  Menor;
	assign overflow = carry_out_exp;
	assign float_number_sgn = Mayor[31];
	assign float_number_exp = exponente_prima;
	assign float_number_man= mantisa_resultado_shifted;
	
	

								 
								 
								 
endmodule
