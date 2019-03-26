module Halfadder(sum, cout, a, b, cin); 
input logic a, b, cin; 
output logic sum, cout; 


 	assign sum = (a ^ b)^cin;
	
	assign cout = (a&b) | (cin & (a ^ b));

 
endmodule



module Fulladder #(N = 4)
	(input logic[N-1:0] a,b,input logic cin,
	output logic[N-1:0] s,output logic carryout);

	logic[N:0] c_out;
	assign c_out[0]  = cin;
	assign carryout = c_out[N];
	genvar i;
	
	generate 
		for (i = 0; i < N; i = i+1) begin:forloop
			Halfadder addr( s[i],c_out[i+1], a[i],b[i],c_out[i]);
		end
	
	endgenerate
	
	
 
endmodule

