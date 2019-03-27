module Comparador #(parameter N=32)(input logic [N-1:0]  A,B,
												output logic [N-1:0] Mayor,Menor);

												 

logic [7:0] exp_A,exp_B;
logic [22:0] man_A, man_B; 
assign exp_A = A[30:23];
assign exp_B = B[30:23];

assign man_A = A[22:0];
assign man_B = B[22:0];


always_comb 
begin
	if(exp_A > exp_B)begin
		 Mayor=A;
		 Menor=B;
	end
	else if (exp_A == exp_B) begin
	
		if (man_A > man_B) begin 
			 Mayor=A;
			 Menor=B;
		end
		
		else if (man_A == man_B) begin
			 Mayor=A;
			 Menor=B;
		end
		
		else begin
			 Mayor=B;
			 Menor=A;
		end
		
	end
	else begin
		 Mayor=B;
		 Menor=A;
	end

end
											 
endmodule
