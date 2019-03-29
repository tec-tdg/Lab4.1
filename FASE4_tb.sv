module FASE4_tb();



/* Salidas FASE 3

output logic [N-1:0] Mayor,Menor,
								 output logic [7:0] exponente_prima, 
								 output logic [22:0] mantisa_resultado,
								 output logic carry_out_mantisa,
								 output logic carry_out_exp
*/

logic [31:0] mayor_num, menor_num;
logic [7:0]  exponente_prima_num;
logic [22:0] mantisa_resultado_num;
logic carry_out_exp_num,carry_out_mantisa_num;

/** Entradas de fase 4

input logic [N-1:0] Mayor,Menor,
input logic [7:0] exponente_prima, 
input logic [22:0] mantisa_resultado,
input logic carry_out_exp, 
input logic carry_out_mantisa

output logic [N-1:0] Mayor_res,
Menor_res,float_number,
output logic overflow

**/

logic [31:0] Mayor_res_num,Menor_res_num;

logic float_number_sgn;
logic [7:0] float_number_exp;
logic [22:0] float_number_man;

logic overflow_num;

logic test;
	logic [7:0] delay_test;
	
	assign delay_test	= { 7'b0000000,carry_out_mantisa_num};
	
	
	

FASE4#32 fase4( mayor_num,
					 menor_num,
					 exponente_prima_num,
					 mantisa_resultado_num,
					 carry_out_exp_num,
					 carry_out_mantisa_num,
					 
					 Mayor_res_num,
					 Menor_res_num,
					 float_number_sgn,
					 float_number_exp,
					 float_number_man,
					 overflow_num);
					 
					 initial begin
						 assign mayor_num = 32'b0_00000110_00000000010000000000000;
						 assign menor_num = 32'b0_00000001_00000000000000001000000;
						 assign exponente_prima_num =8'b00000110 ;
						 assign mantisa_resultado_num = 23'b00000000010000000000010;
						 assign carry_out_exp_num = 1'b0;
						 assign carry_out_mantisa_num = 1'b0; #10;
						 
						 
						 
						 
						 
						 
						 assert(float_number_sgn === 0) $display (delay_test); else $error("failed");
						 assert(float_number_exp === 8'b00000110);
						 assert(float_number_man === 23'b00000000010000000000010);
					 
					 
					 end

endmodule
