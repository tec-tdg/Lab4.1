module FASE1 #(N = 32) (input logic [N-1:0]  A,B,
								output logic [N-1:0] Mayor,Menor, output logic [7:0]diff_exp );
								

//Comparar Quién es mayor y quién es menor								
logic [N-1:0] mayor, menor;


Comparador#32 comparador(A,B,mayor,menor);

logic [7:0] mayor_exp, menor_exp, menor_exp_compl_2, result_exp;

assign mayor_exp = mayor[30:23];
assign menor_exp = menor[30:23];


logic [3:0] control;
assign control = 4'b0001;



//Resta de exponentes Mayor exponente - Menor Exponente
	//Módulo para apiclar el complemento a 2 del exponente menor
	Binterface#8 binterface(menor_exp,control,menor_exp_compl_2);
	logic carryout;
	logic carryin; assign carryin = 4'b0000;
	//Full adder de 8 bits con carry de entrada de 1 para aplicar resta
	//Fulladder input logic[N-1:0] a,b,input logic cin,	output logic[N-1:0] s,output logic carryout
	Fulladder#8 restador(mayor_exp,menor_exp_compl_2,carryin,result_exp,carryout);

assign Mayor = mayor;
assign Menor = menor;
assign diff_exp = result_exp;	
	
					
endmodule
