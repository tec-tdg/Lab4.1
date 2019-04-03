module Sumador_punto_flotante #(N = 32) ( 
														input logic clk_maquina,
														input logic sw1, sw2,sw3, //switches
														input logic reset, manual,auto, // modos
														
														output logic Signo_suma, //signo del resultado
														output logic Estado_1,Estado_2,Estado_3,Estado_4,//Estados de la máquina de estados
														output logic Overflow, // overflow de la suma 

														output logic [7:0] Exponente_suma, // exponente del resultado
														output logic [22:0] Mantisa_suma,
														output logic [6:0] Hex1, Hex2, Hex3, Hex4, Hex5, Hex6); // la mantisa la mantisa final 

logic [31:0] entrada_a;
assign entrada_a = 32'b0_00000110_00000000010000000000000; 
		
logic [31:0] entrada_b;		
assign entrada_b = 32'b0_00000001_00000000000000001000000;

logic [31:0] salida_fase_0_a, salida_fase_0_b;

//Salidas del debounce, que serán usadas como entrada a la FSM
logic output_sw1,output_sw2,output_sw3,output_auto,output_manual,output_reset;

logic clk;


Freq_div Reloj(clk_maquina,clk);

/*														
/**Debuncer : Debounce(input  pb_1,clk,output  pb_out);
Debounce debounce_1(sw1,clk_maquina,output_sw1);
Debounce debounce_2(sw2,clk_maquina,output_sw2);
Debounce debounce_3(sw3,clk_maquina,output_sw3);
Debounce debounce_4(auto,clk_maquina,output_auto);
Debounce debounce_5(manual,clk_maquina,output_manual);
Debounce debounce_6(reset,clk_maquina,output_reset);*/

													
													

/**Máquina de estados 

FSM_Controller( input clk, rst,
						 input logic auto, manual, sw1, sw2, sw3, 
						 output logic en1,en2,en3,en4,led1, led2, led3, led4);

*/

logic en1,en2,en3,en4;
FSM_Controller fsm(  clk, reset,
						 auto, manual, sw1, sw2, sw3, 
					en1, en2, en3, en4, Estado_1, Estado_2, Estado_3, Estado_4);

					 

														 
/*Se crea Reistro 1    en:Estado_1

	input logic reset,clk,en,
	input logic d_A[N-1:0],d_B[N-1:0],
	output logic q_A[N-1:0],q_B[N-1:0]);
*/
Registro1#32 registro_1(reset,clk,en1,entrada_a,entrada_b,salida_fase_0_a, salida_fase_0_b);


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
logic [7:0]  diff_expo_fase_2;
Registro2#32 registro2( reset, 
                        clk, 
								en2,
								mayor_fase_1 ,
								menor_fase_1,
								diff_expo_fase_1,
								mayor_fase_2,
								menor_fase_2,
								diff_expo_fase_2);
														 
														 
				

/* Fase 2:
 #(N = 32) (input logic [N-1:0]  mayor,menor,  
								 input logic [7:0] diff_exp,
								 output logic [N-1:0] Mayor,Menor,
								 output logic [22:0]menor_mantisa);

	*/
logic [31:0] mayor_fase_3,menor_fase_3;
logic [22:0] menor_mantisa_fase_3;
FASE2#32 fase2(mayor_fase_2,menor_fase_2,diff_expo_fase_2,mayor_fase_3,menor_fase_3,menor_mantisa_fase_3);

		
/*Se creae registro 3*/


/* Registro3 #(parameter N=32)( input logic reset,clk,en,
												 input logic [N-1:0] d_X, d_Y,
												 input logic [22:0] d_man,
												 output logic [N-1:0] q_X, q_Y,
												  output logic [22:0] q_man);
*/




logic [31:0] mayor_fase_4,menor_fase_4;
logic [22:0] menor_man_fase_4;
Registro3#32 registro3 (reset,clk,
								en3,
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

//Se utiliza para dar una salida al decodificador 

logic [7:0] deco_exponente;
							 
FASE3#32 fase3 ( mayor_fase_4,
					  menor_fase_4, 
					  menor_man_fase_4,
					  
					  mayor_fase_5,
					  menor_fase_5,
					  exponente_prima_fase_5,
					  mantisa_resultado_fase_5,
					  carry_out_mantisa_fase_5,
					  carry_out_exp_fase_5);
					  
assign deco_exponente = exponente_prima_fase_5;
								 
/**Se crea Registro 4 

Registro4 #(parameter N=32)( input logic reset,clk,en,carry_in_man,carry_in_exp,
												 input logic [N-1:0] Mayor, Menor, 
												 input logic [7:0] Exp_in,
												 input logic  [22:0] Man_in,
												 
												 output logic [N-1:0] Mayor_out, Menor_out,
												 output logic [7:0] Exp_out,
												 output logic [22:0] Man_out,
												 output logic carry_exp_out,carry_man_out);




*/

logic [31:0] mayor_fase_6, menor_fase_6;
logic [7:0] exponente_prima_fase_6;
logic [22:0] mantisa_resultado_fase_6;
logic carry_out_mantisa_fase_6;
logic carry_out_exp_fase_6;
							 												
											
Registro4#32 registro4 (reset,
								clk,
								en4,
								carry_out_mantisa_fase_5,
								carry_out_exp_fase_5,
								mayor_fase_5,
								menor_fase_5,
								exponente_prima_fase_5,
								mantisa_resultado_fase_5,
								
								mayor_fase_6, 
								menor_fase_6,
								exponente_prima_fase_6,
								mantisa_resultado_fase_6,
								carry_out_exp_fase_6,
								carry_out_mantisa_fase_6
								
								);
														 
														 
/*Se crea FASE4
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
														 
														 
														 
logic [31:0] mayor_final, menor_final;


							 
FASE4#32 fase4 ( mayor_fase_6,
					  menor_fase_6, 
					  exponente_prima_fase_6,
					  mantisa_resultado_fase_6,
					  carry_out_exp_fase_6,
					  carry_out_mantisa_fase_6,
					  
					  mayor_final,
					  menor_final,
					  Signo_suma,
					  Exponente_suma,
					  Mantisa_suma,
					  Overflow
					  );														 
										 														 
														 

logic [6:0] Entrada_Deco1;
logic [6:0] Entrada_Deco2;
logic [6:0] Entrada_Deco3;
logic [6:0] Entrada_Deco4;
logic [6:0] Entrada_Deco5;
logic [6:0] Entrada_Deco6;




always_comb  begin

if(Estado_3 & ~Estado_4) begin 
								
	Entrada_Deco1 = exponente_prima_fase_5[7:4];
	Entrada_Deco2 = exponente_prima_fase_5[3:0];
	Entrada_Deco3  = 4'b0000;
	Entrada_Deco4  = 4'b0000;
	Entrada_Deco5  = 4'b0000;
	Entrada_Deco6 = 4'b0000;
	
	end

/* Decoder Ss2(Exponente_suma[3:0],Hex2); Decoder Ss3 (4'b0000,Hex3); Decoder Ss4 (4'b0000,Hex4); Decoder Ss5 (4'b0000,Hex5); Decoder Ss6 (4'b0000,Hex6);	*/													 							
else if (Estado_3 & Estado_4) begin 
	Entrada_Deco1 = Mantisa_suma[22:20];
	Entrada_Deco2 = Mantisa_suma[19:16]; 
	Entrada_Deco3  = Mantisa_suma[15:12];
	Entrada_Deco4  = Mantisa_suma[11:8];
	Entrada_Deco5  = Mantisa_suma[7:4];
	Entrada_Deco6 = Mantisa_suma[3:0];

end


else begin  
	Entrada_Deco1 = 4'bxxxx;
	Entrada_Deco2 = 4'bxxxx; 
	Entrada_Deco3 = 4'bxxxx;
	Entrada_Deco4 = 4'bxxxx;
	Entrada_Deco5 = 4'bxxxx;
	Entrada_Deco6 = 4'bxxxx;
				
end
				
end 				
Decoder Ss1 (Entrada_Deco1,Hex6); 
Decoder Ss2 (Entrada_Deco2,Hex5); 
Decoder Ss3 (Entrada_Deco3,Hex4); 
Decoder Ss4 (Entrada_Deco4,Hex3); 
Decoder Ss5 (Entrada_Deco5,Hex2); 
Decoder Ss6 (Entrada_Deco6,Hex1);														 
								

endmodule
