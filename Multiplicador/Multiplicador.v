module Multiplicador (
	input St, 
	input Clk,
	input Rst,
	input [15:0] Multiplicando, 
	input [15:0] Multiplicador,
	output Idle, Done, 
	output [31:0] Produto
);
	wire Load, Sh, Ad, msbAcc, K;
	wire [16:0] Soma;
	
	ACC ACC0 (.Saidas({msbAcc, Produto}), 
				 .Load(Load), 
				 .Sh(Sh),
				 .Ad(Ad),
				 .Clk(Clk), 
				 .Entradas({Soma[16:0], Multiplicador[15:0]}),
				 .Rst(Rst)
				); //{} concatena vetores
				
	Adder ADD0 (.Soma(Soma), 
				   .OperandoA(Multiplicando),
				   .OperandoB(Produto[31:16])
				  );
				  
	Counter COUNT0 (.K(K),
						 .Load(Load), 
						 .Clk(Clk),
						 .Rst(Rst)
						);
						
	Control_MULTI CON0 (.Idle(Idle), 
					  .Done(Done), 
					  .Load(Load), 
					  .Sh(Sh), 
					  .Ad(Ad), 
					  .Clk(Clk), 
					  .St(St), 
					  .M(Produto[0]), 
					  .K(K),
					  .Rst(Rst)
					 );
endmodule 