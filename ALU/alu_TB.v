`timescale 1ns/100ps

module alu_TB();

	reg [31:0] inputA, inputB;
	reg [1:0] sel;
	wire [31:0] out;

	alu DUT(
		.inputA(inputA),
		.inputB(inputB),
		.sel(sel),
		.out(out)
	);

	initial begin
		// testando todas as operações para duas entradas
		sel = 0;
		inputA <= 5001;
		inputB <= 3001;
		#40
		sel <= 1;
		#40
		sel <= 2;
		#40
		sel <= 3;
		// testando soma para outras duas entradas
		#40
		sel <= 0;
		inputA <= 8006001;
		inputB <= 8002;
		
		// teste: underflow e overflow
		#40
		inputA <= 32'h00000000;
		inputB <= 32'h00000001;
		sel <= 1;
		#40
		inputA <= 32'hFFFFFFFF;
		inputB <= 32'h00000001;
		sel <= 0;
		
	end

	initial begin
		#300 $stop;
	end

endmodule