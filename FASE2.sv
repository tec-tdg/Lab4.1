module FASE2  #(N = 32) (input logic [N-1:0]  mayor,menor, 
								 input logic [7:0] diff_exp,
								 output logic [N-1:0] Mayor,Menor,
								 output logic [7:0]menor_mantisa);

	
	//Obtener la mantisa del menor
	logic [7:0] mantisa_menor;
	assign mantisa_menor = menor[30:23];

	
	//hacer corrimiento de datos input signed [N-1:0] _in,input [7:0] _delay,output [N-1:0] _out
	shiftLeftArit shifter(mantisa_menor,diff_exp,menor_mantisa);
	
	assign Mayor = mayor;
	assign Menor = menor;

endmodule
