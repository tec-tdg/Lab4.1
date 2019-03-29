module Binterface_tb();

	logic [2:0] bvalue;
	logic [3:0] control_values;
	
	//salidas
	logic [2:0] result_values;

	
	Binterface#3 dut(bvalue,control_values,result_values);
	
	initial begin
	bvalue=3'b000; control_values=4'b0001; #10;
	assert(result_values===3'b000) $display ("  000 ok"); else $error("000 value failed");
	
	bvalue=3'b010; control_values=4'b0001; #10;
	assert(result_values===3'b110) $display ("  010 ok"); else $error("010 value failed");
	end


endmodule