`timescale 1ns/100ps

module extend_TB;
	
	reg [31:0] instr;
	wire [31:0] imm;
 
	extend DUT (
		.instr(instr),
		.imm(imm)
	);
	
	initial begin
		instr = 1;
		#50 instr = instr + 1000;
		#50 instr = instr + 1000;
		#50 instr = instr + 1000;
		#50 instr = instr + 1000;
		#50 instr <= 32'hBB6AEF03;
		#50 instr <= 32'hAB7E6521;
	end


	initial begin
		#500 $stop;
	end
 
endmodule
