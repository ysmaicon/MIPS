`timescale 1ns/10ps

module alu_TB();

	reg [31:0] entradaA, entradaB;
	reg [1:0] sel;
	wire [31:0] out;

	alu DUT(
		.entradaA(entradaA),
		.entradaB(entradaB),
		.sel(sel),
		.out(out)
	);

	initial begin
		sel = 0;
		entradaA =5001;
		entradaB =3001;
		#40
		sel = 1;
		#40
		sel = 2;
		#40
		sel = 3;
		#40
		sel = 0;
		entradaA =8006001;
		entradaB =8002;
	end

	initial begin
		#300 $stop;
	end

endmodule