module Comparador_tb ();
logic [31:0] entrada_a,entrada_b;

logic [31:0] salida_a,salida_b;

Comparador dut(entrada_a,entrada_b,salida_a,salida_b);
initial begin
assign entrada_a = 32'b0_00000111_00000000010000000000000; 
assign entrada_b = 32'b0_00000001_00000000000000001000000; #10;
assert(entrada_a  === salida_a) $display("Ok a > b"); else $error("failed");#10;
assert(entrada_b  === salida_b) $display("Ok b < a"); else $error("failed");#10;	
assert(salida_a  === salida_b) $display("Ok salida_a > salida_b"); else $error("failed");											 
end									 
endmodule
