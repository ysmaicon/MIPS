module Multiplicador (
	input St, 
	input Clk,
	input [3:0] Multiplicando, 
	input [3:0] Multiplicador,
	output Idle, Done, 
	output [7:0] Produto
);
	wire Load, Sh, Ad, msbAcc, K;
	wire [4:0] Soma;
	
	ACC ACC0 (.Saidas({msbAcc, Produto}), 
				 .Load(Load), 
				 .Sh(Sh),
				 .Ad(Ad), 
				 .Clk(Clk), 
				 .Entradas({Soma[4:0], Multiplicador[3:0]})
				); //{} concatena vetores
				
	Adder ADD0 (.Soma(Soma), 
				   .OperandoA(Multiplicando),
				   .OperandoB(Produto[7:4])
				  );
				  
	Counter COUNT0 (.K(K),
						 .Load(Load), 
						 .Clk(Clk)
						);
						
	Control CON0 (.Idle(Idle), 
					  .Done(Done), 
					  .Load(Load), 
					  .Sh(Sh), 
					  .Ad(Ad), 
					  .Clk(Clk), 
					  .St(St), 
					  .M(Produto[0]), 
					  .K(K)
					 );
endmodule 