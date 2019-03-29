module FASE3_tb ();

	logic [31:0]  valor_mayor, valor_menor;
	logic [22:0]  mantisa_prima;
	
	logic [31:0] resultado_mayor, resultado_menor;
	logic [22:0] resultado_mantisa;
	logic [7:0]  resultado_exponente;
	logic carry_out_exponente;
	
	/*
	input logic [N-1:0]  mayor,
								menor, 
 input logic [22:0] 		mantisa_menor_prima,
 output logic [N-1:0] 	Mayor,
								Menor,
 output logic [7:0] 		exponente_prima, 
 output logic [22:0] 	mantisa_resultado,
 output logic 				carry_out_exp 
	
	*/
	
	/**
	
	
	input logic [N-1:0]  mayor,menor, 
	 input logic [22:0] mantisa_menor_prima,
	 
	 output logic [N-1:0] Mayor,Menor,
	 output logic [7:0] exponente_prima, 
	 output logic [22:0] mantisa_resultado,
	 output logic carry_out_mantisa,
	 output logic carry_out_exp );
	*/
	
	FASE3#32  dut(
					  valor_mayor,
					  valor_menor,
					  mantisa_prima,
					  resultado_mayor,
				     resultado_menor,
					  resultado_exponente,
					  resultado_mantisa,
					  carry_out_mantisa,
					  carry_out_exponente);
					  
	initial begin
		assign valor_mayor = 32'b0_00000110_00000000010000000000000; 
		assign valor_menor = 32'b0_00000001_00000000000000001000000;
		
		assign mantisa_prima = 23'b00000000000000000000010;#10;
											//0000000001_0000000000_010
		
		assert(resultado_mayor  == valor_mayor ) $display("Ok mayor"); else $error("failed mayor");
		assert(resultado_menor  === valor_menor) $display("Ok menor"); else $error("failed menor");
		assert(resultado_mantisa  === 23'b00000000010000000000010) $display("Ok mantisa"); else $error("failed mantisa");
		assert(resultado_exponente  === 8'b00000110) $display("Ok exponente res "); else $error("failed resultado exponente suma");
		assert(carry_out_exponente === 1'b0) $display("ok  carry exponente"); else $error("failed exponente carry"); 
	
	end
	
endmodule
