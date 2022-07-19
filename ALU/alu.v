module alu(inputA,inputB,sel,out);
	input [31:0] inputA,inputB;
	input [1:0] sel;
	output reg signed [31:0] out;

	always @(inputA or inputB or sel)
	begin
		case(sel)
			2'b00: out = inputA + inputB;	
			2'b01: out = inputA - inputB;	
			2'b10: out = inputA & inputB;	
			2'b11: out = inputA | inputB;	
			default: out= 0;
		endcase
	end
endmodule 