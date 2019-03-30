module Bloque_tb();


	 logic [31:0] Operando_a, Operando_b,Mayor_F1,Menor_F1;
	 logic [7:0]  diff_exp_F1;
	 
	/* FASE1 #(N = 32) (input logic [N-1:0]  A,B,
								output logic [N-1:0] Mayor,Menor, output logic [7:0]diff_exp );*/
								
								
	
								
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
	
	FASE3#32 fase3(Mayor_F2,Menor_F2,menor_mantisa_F2,Mayor_F3,Menor_F3,exponente_prima_F3,mantisa_resultado_F3,carry_out_mantisa_F3, carry_out_exp_F3);
	
			

	/*Fase 4
		FASE4 #(N = 32) ( input logic [N-1:0] Mayor,Menor,
								 input logic [7:0] exponente_prima, 
								 input logic [22:0] mantisa_resultado,
								 input logic carry_out_exp, 
								 input logic carry_out_mantisa,
								 output logic [N-1:0] Mayor_res,Menor_res,
								 output logic float_number_sgn,
								 output logic [7:0] float_number_exp,
								 output logic [22:0] float_number_man,
								 output logic overflow );
	
	*/
	
	logic [31:0]  Mayor_res_F4,Menor_res_F4;
	logic float_number_sgn_F4;
	logic [7:0] float_number_expo_F4;
	logic [22:0] float_number_man_F4;
	logic overflow_F4;
	FASE4#32  fase4(Mayor_F3,
				  Menor_F3,
				  exponente_prima_F3,
				  mantisa_resultado_F3,
				  carry_out_mantisa_F3,
				  carry_out_exp_F3,
				  Mayor_res_F4,
				  Menor_res_F4,
				  float_number_sgn_F4,
				  float_number_expo_F4,
				  float_number_man_F4,
				  overflow_F4);
				  
				  
	  initial begin
			assign Operando_a = 32'b0_00000110_00000000010000000000000; 
			assign Operando_b = 32'b0_00000001_00000000000000001000000;
			assert(overflow_F4 == 0) $display("Éxito"); else $error("Error");
	  end
				

endmodule
