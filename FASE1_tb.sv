module FASE1_tb ();

	logic [31:0] entrada_a,entrada_b,val_mayor,val_menor;
	logic [7:0] diff_expon;

	 

	//input logic [N-1:0]  A,B,	output logic [N-1:0] Mayor,Menor, output logic [7:0]diff_exp );

	FASE1#32 dut (entrada_a,entrada_b,val_mayor,val_menor,diff_expon);
	initial begin
		assign entrada_a = 32'b0_00000111_00000000010000000000000; 
		assign entrada_b = 32'b0_00000001_00000000000000001000000; #10;
		assert(entrada_a  === val_mayor) $display("Ok a > b"); else $error("failed a > b");#10;
		assert(entrada_b  === val_menor) $display("Ok b < a"); else $error("failed b < a");#10;	
		assert(val_mayor  >= val_menor) $display("Ok mayor >= menor"); else $error("failed mayor >= menor");
		assert(diff_expon  === 8'b00000110) $display("Ok diff exp"); else $error("failed diff exp");
	end


endmodule
