module Registro4 #(parameter N=32)( input logic reset,clk,en,carry_in_man,carry_in_exp,
												 input logic [N-1:0] Mayor, Menor, 
												 input logic [7:0] Exp_in,
												 input logic  [22:0] Man_in,
												 
												 output logic [N-1:0] Mayor_out, Menor_out,
												  output logic [7:0] Exp_out,
												 output logic [22:0] Man_out,
												 output logic carry_exp_out,carry_man_out);


//reset asincronico

always_ff@(posedge clk,posedge reset)												 
		if (reset) begin Mayor_out<=32'b0; Menor_out<=32'b0; Exp_out<=8'b0; Man_out<=23'b0;  carry_exp_out <= 1'b0; carry_man_out<=1'b0; end 
		else if(en) begin Mayor_out<=Mayor; Menor_out<=Menor; Exp_out<=Exp_in; Man_out<=Man_in;  carry_exp_out<=carry_in_exp; carry_man_out<=carry_in_man; end
			
												 
endmodule
