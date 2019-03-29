module Sumador_punto_flotante #(N = 32) ( input logic modo,
														input logic clk,
														input logic sw1, sw2,sw3,sw4, //switches
														input logic reset, manual,
														
														output logic Signo_suma, //signo del resultado
														output logic Estado_1,Estado_2,Estado_3,Estado_4,//Estados de la máquina de estados
														output logic Overflow, // overflow de la suma 

														output logic [7:0] Exponente_suma, // exponente del resultado
														output logic [22:0] Mantisa_suma); // la mantisa la mantisa final 

logic [31:0] entrada_a;
assign entrada_a = 32'b0_00000110_00000000010000000000000; 
		
logic [31:0] entrada_b;		
assign entrada_b = 32'b0_00000001_00000000000000001000000;

logic [31:0] salida_fase_0_a, salida_fase_0_b;

//Salidas del debounce, que serán usadas como entrada a la FSM
logic output_sw1,output_sw2,output_sw3,output_sw4;

														
/**Debuncer : Debounce(input  pb_1,clk,output  pb_out);*/
Debounce debounce_1(sw1,clk,output_sw1);
Debounce debounce_2(sw2,clk,output_sw2);
Debounce debounce_3(sw3,clk,output_sw3);
Debounce debounce_4(sw4,clk,output_sw4);														
														
														 

/**Máquina de estados 

FSM_Controller( input clk, rst,
						 input logic start, manual, sw1, sw2, sw3,
						 output logic led1, led2, led3, led4);


*/


FSM_Controller fsm_controller(clk,reset,sw1,manual,sw2,sw3,sw4,Estado_1,Estado_2,Estado_3,Estado_4);

														 

														 
/*Se crea Reistro 1    en:Estado_1

	input logic reset,clk,en,
	input logic d_A[N-1:0],d_B[N-1:0],
	output logic q_A[N-1:0],q_B[N-1:0]);
*/
Registro1#32 registro_1(reset,clk,Estado_1,entrada_a,entrada_b,salida_fase_0_a, salida_fase_0_b);


/*Fase 1: FASE1 #(N = 32) (input logic [N-1:0]  A,B,
								output logic [N-1:0] Mayor,Menor, output logic [7:0]diff_exp );;*/
								
logic [31:0] mayor_fase_1, menor_fase_1;
logic [7:0]  diff_expo_fase_1;
								
FASE1#32 fase1(salida_fase_0_a, salida_fase_0_b, mayor_fase_1, menor_fase_1,diff_expo_fase_1);


/*Se crea Registro # 2**/
/*Registro2 #(parameter N=32)( input logic reset,clk,en, enable lo aporta Estado2
										 input logic [N-1:0]d_Ma,d_Me,
										 input logic  [7:0] d_diff_expo,
										 output logic [N-1:0]q_Ma,q_Me,
										 output logic [7:0] q_diff_expo  );*/

logic [31:0] mayor_fase_2,menor_fase_2;
logic [22:0]  man_fase_2;
Registro2#32 registro2( reset, 
                        clk, 
								Estado_2,
								mayor_fase_1 ,
								menor_fase_1,
								diff_expo_fase_1,
								mayor_fase_2,
								menor_fase_2,
								man_fase_2);
														 
														 
				

/* Fase 2:
 #(N = 32) (input logic [N-1:0]  mayor,menor, 
								 input logic [7:0] diff_exp,
								 output logic [N-1:0] Mayor,Menor,
								 output logic [22:0]menor_mantisa);

	*/
logic [31:0] mayor_fase_3,menor_fase_3;
logic [22:0] menor_mantisa_fase_3;
FASE2#32 fase2(mayor_fase_2,menor_fase_2,dif_expo_fase_2,mayor_fase_3,menor_fase_3,menor_mantisa_fase_3);

		
/*Se creae registro 3*/


/* Registro3 #(parameter N=32)( input logic reset,clk,en,
												 input logic d_X[N-1:0],d_Y[N-1:0],d_Exp[7:0],
						output logic q_X[N-1:0],q_Y[N-1:0],q_man[22:0]);
*/




logic [31:0] mayor_fase_4,menor_fase_4;
logic [22:0] menor_man_fase_4;
Registro3#32 registro3 (reset,clk,
								Estado_3,
								mayor_fase_3,
								menor_fase_3,
								menor_mantisa_fase_3,
								mayor_fase_4,
								menor_fase_4,
								menor_man_fase_4);
/**Se crea FASE3


FASE3 #(N = 32) ( input logic [N-1:0]  mayor,menor, 
								 input logic [22:0] mantisa_menor_prima,
								 
								 output logic [N-1:0] Mayor,Menor,
								 output logic [7:0] exponente_prima, 
								 output logic [22:0] mantisa_resultado,
								 output logic carry_out_mantisa,
								 output logic carry_out_exp );*/

								 
logic [31:0] mayor_fase_5, menor_fase_5;
logic [7:0] exponente_prima_fase_5;
logic [22:0] mantisa_resultado_fase_5;
logic carry_out_mantisa_fase_5;
logic carry_out_exp_fase_5;
							 
FASE3#32 fase3 ( mayor_fase_4,
					  menor_fase_4, 
					  menor_man_fase_4,
					  mayor_fase_5,
					  menor_fase_5,
					  exponente_prima_fase_5,
					  mantisa_resultado_fase_5,
					  carry_out_mantisa_fase_5,
					  carry_out_exp_fase_5);
								 
/**Se crea Registro 4 */

													
											
		
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 
														 /*
Se inicia la Fase 1 , se instancian las salidas para la siguiente fase 
*/

logic [31:0] Salida_fase1_Mayor,Salida_fase1_Menor;
logic [7:0] Salida_fase1_DiferenciaExponentes;


//input logic [N-1:0]  A,B,	output logic [N-1:0] Mayor,Menor, output logic [7:0]diff_exp );



FASE1#32 Primera_Fase(Numero_A,Numero_B,Salida_fase1_Mayor,Salida_fase1_Menor,Salida_fase1_DiferenciaExponentes);


/*
Se inicia la Fase 2 , se instancian las salidas para la siguiente fase 
*/


output logic [N-1:0] Salida_fase2_Mayor,Salida_fase2_Menor;
output logic [7:0]Salida_fase2_menor_mantisa;


/**
		 input logic [N-1:0]  mayor,menor, 
		 input logic [7:0] diff_exp,
		 output logic [N-1:0] Mayor,Menor,
		 output logic [7:0]menor_mantisa
	**/
	
FASE2#32 Segunda_Fase(Salida_fase1_Mayor,Salida_fase1_Menor,Salida_fase1_DiferenciaExponentes,
Salida_fase2_Mayor,Salida_fase2_Menor,Salida_fase2_menor_mantisa);





														 

endmodule
