module Adder (Soma, OperandoA, OperandoB);
	input [15:0] OperandoA; 
	input [15:0] OperandoB;
	output [16:0] Soma;

	assign Soma = OperandoA + OperandoB;

endmodule 