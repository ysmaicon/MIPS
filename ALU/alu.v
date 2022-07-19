module alu(entradaA,entradaB,sel,out);
	input [31:0] entradaA,entradaB;
	input [1:0] sel;
	output reg signed [31:0] out;

	always @(entradaA or entradaB or sel)
	begin
		case(sel)
			2'b00: out = entradaA+entradaB;	
			2'b01: out = entradaA-entradaB;	
			2'b10: out = entradaA&entradaB;	
			2'b11: out = entradaA|entradaB;	
			default: out= 0;
		endcase
	end
endmodule 