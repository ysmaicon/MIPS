module extend(
	input [31:0] instr,
	output [31:0] imm
);

	// extends the signal by taking bit 15 of instr as the basis 
	assign imm = {{16{instr[15]}}, instr[15:0]};

endmodule
