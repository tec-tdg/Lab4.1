module Bloque_tb();


	 logic [31:0] Operando_a, Operando_b,Mayor_F1,Menor_F1;
	 logic [7:0]  diff_exp_F1;
	 
	/* FASE1 #(N = 32) (input logic [N-1:0]  A,B,
								output logic [N-1:0] Mayor,Menor, output logic [7:0]diff_exp );*/
								
								
	assign Operando_a = 32'b0_00000110_00000000010000000000000; 
	assign Operando_b = 32'b0_00000001_00000000000000001000000;
								
	FASE1#32 dutFase1(Operando_a, Operando_b,Mayor_F1,Menor_F1,diff_exp_F1);
	
	/*Instancia Fase 2*/
	
	
	/*	FASE2  #(N = 32) (input logic [N-1:0]  mayor,menor, 
								 input logic [7:0] diff_exp,
								 output logic [N-1:0] Mayor,Menor,
								 output logic [22:0]menor_mantisa);*/
		
	logic [31:0] Mayor_F2,Menor_F2;
	logic [22:0] menor_mantisa_F2;
	FASE2#32 dutfase2(Mayor_F1,Menor_F1,diff_exp_F1, Mayor_F2,Menor_F2,menor_mantisa_F2);
	
	
	/* Fase 3*/
	
	/** FASE3 #(N = 32) ( input logic [N-1:0]  mayor,menor, 
								 input logic [22:0] mantisa_menor_prima,
								 
								 output logic [N-1:0] Mayor,Menor,
								 output logic [7:0] exponente_prima, 
								 output logic [22:0] mantisa_resultado,
								 output logic carry_out_mantisa,
								 output logic carry_out_exp );*/
								 
	logic [31:0] Mayor_F3,Menor_F3;
	logic [7:0]  exponente_prima_F3;
	logic [22:0] mantisa_resultado_F3;
	logic carry_out_mantisa_F3, carry_out_exp_F3;
	
	FASE3#32(Mayor_F2,Menor_F2,menor_mantisa_F2,Mayor_F3,Menor_F3,exponente_prima_F3,mantisa_resultado_F3,carry_out_mantisa_F3, carry_out_exp_F3);
	
								

endmodule
