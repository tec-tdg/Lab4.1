module Debounce(input pb_1,clk,output  pb_out);
logic slow_clk;
logic Q1,Q2,Q2_bar;

Freq_div u1(clk,slow_clk);
my_dff d1(slow_clk, pb_1,Q1 );
my_dff d2(slow_clk, Q1,Q2);
assign Q2_bar = ~Q2;
assign pb_out = Q1 & Q2_bar;
endmodule


// D-flip-flop for debouncing module 
module my_dff(input DFF_CLOCK, D, output logic Q);

    always @ (posedge DFF_CLOCK) begin
        Q <= D;
    end


endmodule
