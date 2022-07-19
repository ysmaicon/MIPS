module extend(
	input [31:0] instr,
	output [31:0] imm
);

	// extensão do sinal tomando o bit 15 de instr 
	assign imm = {{16{instr[15]}}, instr[15:0]};

endmodule
