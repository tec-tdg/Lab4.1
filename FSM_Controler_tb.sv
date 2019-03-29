/*  FSM_Controller( input clk, rst,
						 input logic start, manual, sw1, sw2, sw3,
						 output logic led1, led2, led3, led4);   */

module FSM_Controler_tb();

 logic _clk, _rst, _start, _manual, _sw1, _sw2, _sw3, led1o, led2o, led3o, led4o;
FSM_Controller dutFSM(_clk, _rst, _start, _manual, _sw1, _sw2, _sw3, led1o, led2o, led3o, led4o);

initial begin

_clk = 0; _rst = 0;
#10;
_rst = 1;
#10;
_rst = 0;
#10;
_start = 0; _manual = 0; 
assert (led1o === 0 &&led2o ===0 &&led3o===0 &&led4o ===0) $display ("ok"); else $error("failed");
#10;
_start = 1; _manual = 0; 
assert (led1o === 1 &&led2o ===0 &&led3o===0 &&led4o ===0) $display ("ok"); else $error("failed");

end

always
#10 _clk = ~_clk;

endmodule
