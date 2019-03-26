module Fulladder_tb();

logic c_in, c_out;
logic  [3:0] a;
logic  [3:0] b;
logic  [3:0] sum;

//instanciate modules
//Fulladder(fsum, fcarry_out, a, b, c); 

Fulladder dut(sum,c_out,a,b,c_in);


initial begin
	a=4'b0000; b=4'b0000; c_in=0; #10;
	assert(sum===4'b0000 && c_out===0 ) $display ("0000 ok"); else $error("0000 failed");

	a=4'b0000; b=4'b0001; c_in=0; #10;
	assert(sum===4'b0001 && c_out===0 ) $display ("0001 ok"); else $error("0001 failed");

	a=4'b0001; b=4'b0000; c_in=0; #10;
	assert(sum===4'b0001 && c_out===0 ) $display ("0001 B ok"); else $error("0001 B failed");

	a=4'b0000; b=4'b0000; c_in=1; #10;
	assert(sum===4'b0001 && c_out===0 ) $display ("0001 C ok"); else $error("0001C failed");

	a=4'b0010; b=4'b1100; c_in=0; #10;
	assert(sum===4'b1110 && c_out===0 ) $display ("1110 ok"); else $error("1110 failed");

		a=4'b0110; b=4'b1111; c_in=0; #10;
	assert(sum===4'b0101 && c_out===1 ) $display ("10101 ok"); else $error("10101 failed");



end

endmodule