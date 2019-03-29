module FASE2  #(N = 32) (input logic [N-1:0]  mayor,menor, 
								 input logic [7:0] diff_exp,
								 output logic [N-1:0] Mayor,Menor,
								 output logic [22:0]menor_mantisa);

	
	//Obtener la mantisa del menor
	logic [22:0] mantisa_menor;
	assign mantisa_menor = menor[22:0];

	
	//hacer corrimiento de datos   _in, _delay,  _out
	shiftRightArit#23 shifter(mantisa_menor,diff_exp,menor_mantisa);
	
	assign Mayor = mayor;
	assign Menor = menor;

endmodule
