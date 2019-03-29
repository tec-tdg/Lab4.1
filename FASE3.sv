module FASE3 #(N = 32) ( input logic [N-1:0]  mayor,menor, 
								 input logic [22:0] mantisa_menor_prima,
								 
								 output logic [N-1:0] Mayor,Menor,
								 output logic [7:0] exponente_prima, 
								 output logic [22:0] mantisa_resultado,
								 output logic carry_out_mantisa,
								 output logic carry_out_exp );

								
assign Mayor = mayor;
assign Menor = menor;								

//tomar la mantisa del mayor:
logic [22:0] mantisa_mayor; 
assign mantisa_mayor = mayor[22:0];
logic [7:0] exponente_mayor;
assign exponente_mayor = mayor[30:23];

//Instanciar un adder para sumar las mantisas

 /*
 
	Fulladder #(N = 4)
	(input logic[N-1:0] a,b,input logic cin,
	output logic[N-1:0] s,output logic carryout);
 
 */
logic carry_in = 0;
logic carry_out;
Fulladder#23 fulladder_mantisa( mantisa_mayor,
								mantisa_menor_prima,
								carry_in,
								mantisa_resultado,carry_out);
logic [7:0] temp;
assign temp = 8'b00000000;								
Fulladder#8 fulladder_exponente_overflow(exponente_mayor,
														temp,
														carry_out,
														exponente_prima,
														carry_out_exp);

													
assign carry_out_mantisa = carry_out;

endmodule
