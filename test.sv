module test(input logic clock_entrada,reset,start,manual,sw1,sw2,sw3,
			   output logic salida1,salida2,salida3,salida4);			
/*
Se retrasa el clock  
Freq_div (input logic clk_in,output logic clk_out);*/

logic clock_maquina_estados;

Freq_div retraso(clock_entrada,clock_maquina_estados);

//Salidas del debounce, que serán usadas como entrada a la FSM
logic output_sw1,output_sw2,output_sw3,output_sw4;

/*Se retrasan los switches*/
Debounce debounce_1(sw1,clk,output_sw1);
Debounce debounce_2(sw2,clk,output_sw2);
Debounce debounce_3(sw3,clk,output_sw3);
Debounce debounce_4(start,clk,output_sw4);	

/*FSM_Controller( input clk, rst,
						 input logic start, manual, sw1, sw2, sw3,
						 output logic led1, led2, led3, led4);
Se instancia FSM controller	
						*/
FSM_Controller fsm(Clock_maquina_estados,reset,output_sw4,
					manual,output_sw1,output_sw2,output_sw3,salida1,salida2,salida3,salida4);
					
											
endmodule
