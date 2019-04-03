`timescale 1s / 100ms
module FSM_Controller( input clk, rst,
						 input logic auto, manual, sw1, sw2, sw3,
						 output logic en1,en2,en3,en4,led1, led2, led3, led4);

	typedef enum logic [3:0] {I, F1, F2, F3, F4} statetype;
	statetype state, next_state;

	
	//sequential logic
	always_ff @(posedge clk, posedge rst) begin
		if(rst) state <= I;
		else state <= next_state;
	end
		
	//combinational logic
	always_comb 
		case (state)
		I: begin
			if (auto | (manual & ~sw2))
				next_state = F1;
			else
				next_state = I;
			
			en1 = 0;
			en2 = 0;
			en3 = 0;
			en4 = 0;
			led1 = 0;
			led2 = 0;
			led3 = 0;
			led4 = 0;
		end
		F1: begin
			if ((manual & sw1)| auto)
				next_state = F2;
			else
				next_state = F1;
			en1 = 1;
			en2 = 0;
			en3 = 0;
			en4 = 0;
			led1 = 1;
			led2 = 0;
			led3 = 0;
			led4 = 0;
		end
		F2: begin
			if ((manual & sw2) | auto )
				next_state = F3;
			else
				next_state = F2;
			en1 = 0;
			en2 = 1;
			en3 = 0;
			en4 = 0;
			led1 = 1;
			led2 = 1;
			led3 = 0;
			led4 = 0;
		end
		F3: begin
			if ((manual & sw3) | auto)
				#20 next_state = F4;
			else
				next_state = F3;
			en1 = 0;
			en2 = 0;
			en3 = 1;
			en4 = 0;
			led1 = 1;
			led2 = 1;
			led3 = 1;
			led4 = 0; 
		end
		F4: begin                                                
			en1 = 0;
			en2 = 0;
			en3 = 0;
			en4 = 1;
			led1 = 1;
			led2 = 1;
			led3 = 1;
			led4 = 1;
			#5 next_state = I;
		end

		default: begin
			if (auto | manual)
				next_state = F1;
			else
				next_state = I;
			en1 = 0;
			en2 = 0;
			en3 = 0;
			en4 = 0;
			led1 = 0;
			led2 = 0;
			led3 = 0;
			led4 = 0;
		end
		endcase			
endmodule
