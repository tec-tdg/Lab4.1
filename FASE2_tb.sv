module FASE2_tb ();

	logic [31:0] Mayor,Menor, res_mayor,res_menor;								
	logic [7:0] diff_exponente;
	logic [22:0] menor_mantisa_res;
	logic signed [22:0]  test_res;
	
	/**
		 input logic [N-1:0]  mayor,menor, 
		 input logic [7:0] diff_exp,
		 output logic [N-1:0] Mayor,Menor,
		 output logic [7:0]menor_mantisa
	**/
	
	FASE2#32 dut(Mayor,Menor,diff_exponente,res_mayor,res_menor,menor_mantisa_res);
	initial begin
		assign Mayor = 32'b0_00000110_00000000010000000000000; 
		assign Menor = 32'b0_00000001_00000000000000001000000;
		assign diff_exponente = 8'b00000101;	#10;
		assert(Mayor  === res_mayor) $display("Ok Mayor  === res_mayor"); else $error("Mayor  === res_mayor");#10;
		assert(Menor  === res_menor) $display("Ok Menor  === res_menor"); else $error("Menor  === res_menor");#10;	
		assert(menor_mantisa_res  === 23'b00000000000000000000010) $display("Ok mantisa desplazada"); else $error("failed mantisa");#10;
		
		
		assign Mayor = 32'b0_00000111_00000000010000000000000; 
		assign Menor = 32'b0_00000101_00000000000000001000000;
		assign diff_exponente = 8'b00000010;	#10;
		assert(Mayor  === res_mayor) $display("Ok Mayor  === res_mayor"); else $error("Mayor  === res_mayor");#10;
		assert(Menor  === res_menor) $display("Ok Menor  === res_menor"); else $error("Menor  === res_menor");#10;	
		assert(menor_mantisa_res  === 23'b00000000000000000010000) $display("Ok mantisa desplazada"); else $error("failed mantisa");#10;
		
		assign test_res = 23'b00000000000000001000000;
		assert(test_res >>> 8'b00000010  === 23'b00000000000000000010000) $display("Ok mantisa desplazada 2"); else $error("failed mantisa");#10;
		
	end
								
endmodule
