module FSM( input clk, 
				input rst,
				input start,
				input init,
				input done,
				output logic ack,
				output logic[1:0] out);

				 /**Comments*/
	logic[1:0] state;
	logic[1:0] next_state;
	
	//sequential logic
	always_ff @(posedge clk, posedge rst) begin
		if(rst) state <= 2'b00;
		else state <= next_state;
	end
		
	//combinational logic
	always_comb begin
		case (state)
		2'b00: begin
			if (start) next_state = 2'b01;
			else next_state = 2'b00;
			ack = 0;
		end
		2'b01: begin
			if (done) next_state = 2'b10;
			else next_state = 2'b11;
			ack = 0;
		end
		2'b10: begin
			next_state = 2'b00;
			ack = 0;
		end
		2'b11: begin
			if (init) next_state = 2'b00;
			else next_state = 2'b11;
			ack = 1;
		end
		default: begin
			if (start) next_state = 2'b01;
			else next_state = 2'b00;
			ack = 0;
		end
		endcase
	end				
assign out = state;
endmodule
