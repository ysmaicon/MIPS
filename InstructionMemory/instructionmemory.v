module instructionmemory(
    input CLK_SYS, rst,
    input[9:0] pc,
    output reg[31:0] instruction
);
	reg [31:0] instructionInt[1023:0];

	initial begin	
	   // Load word
		// grupo = 1
		// grupo+1 _ rs = 31 _ rt _ offset
		// offset = grupo * 500h + rt
		instructionInt[0] = 32'b000010_11111_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		instructionInt[1] = 32'b000010_11111_00000_0000_0101_0000_0000;	// (Carrega A em registerfile0 - 00000)
		instructionInt[2] = 32'b000010_11111_00001_0000_0101_0000_0001;	// (Carrega B em registerfile1 - 00001) 
		instructionInt[3] = 32'b000010_11111_00010_0000_0101_0000_0010;	// (Carrega C em registerfile2 - 00010)
		instructionInt[4] = 32'b000010_11111_00011_0000_0101_0000_0011;	// (Carrega D em registerfile3 - 00011)
		
		// Operações aritméticas e lógicas
		// grupo _ rs _ rt _ rd _ 10 _ codOperacao
		instructionInt[5] = 32'b000001_00000_00001_00100_01010_110010;		// (Multiplica o conteudo do registerfile0(00000) pelo conteudo do registerfile1(00001) e carrega o resutlado no registerfile4 - 00100) 
		instructionInt[6] = 32'b000001_00010_00011_00101_01010_100000;		// (Soma o conteudo do registerfile0(00010) pelo conteudo do registerfile1(00011) e carrega o resutlado no registerfile5 - 01001) 
		instructionInt[7] = 32'b000001_00100_00101_00110_01010_100010;		// (Subtrai o conteudo do registerfile4(00100) pelo conteudo do registerfile5(00101) e carrega o resutlado no registerfile6 - 00110)
		
		// Save word
		// grupo+2 _ rs = 31 _ rt _ offset
		instructionInt[8] = 32'b000011_11111_00110_0000_1000_1111_1111;	// (Armazena o resultado na última posição da memória)	
		
		
		
		// *** INSERINDO BOLHAS - VERIFICANDO A NAO PRESENÇA DE PIPELINE HAZZARDS ***
		instructionInt[9]  = 32'b000010_11111_00000_0000_0101_0000_0000;	// (Carrega A em registerfile0 - 00000)
		instructionInt[10] = 32'b000010_11111_00001_0000_0101_0000_0001;	// (Carrega B em registerfile1 - 00001) 
		instructionInt[11] = 32'b000010_11111_00010_0000_0101_0000_0010;	// (Carrega C em registerfile2 - 00010)
		instructionInt[12] = 32'b000010_11111_00011_0000_0101_0000_0011;	// (Carrega D em registerfile3 - 00011)
		
		instructionInt[13] = 32'b000010_00101_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		
		instructionInt[14] = 32'b000001_00000_00001_01000_01010_110010;	// (Multiplica o conteudo do registerfile0(00000) pelo conteudo do registerfile1(00001) e carrega o resutlado no registerfile4 - 00100) 
		
		instructionInt[15] = 32'b000010_11110_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		instructionInt[16] = 32'b000010_11110_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		
		instructionInt[17] = 32'b000001_00010_00011_00101_01010_100000;	// (Soma o conteudo do registerfile0(00010) pelo conteudo do registerfile1(00011) e carrega o resutlado no registerfile5 - 00101)
		
		instructionInt[18] = 32'b000001_11110_11110_01011_01010_100100;	// (Gasta uma instrução) -> AND
		instructionInt[19] = 32'b000010_11110_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		instructionInt[20] = 32'b000010_11110_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		
		instructionInt[21] = 32'b000001_00100_00101_00110_01010_100010;	// (Subtrai o conteudo do registerfile4(00100) pelo conteudo do registerfile5(00101) e carrega o resutlado no registerfile6 - 00110)
		
		instructionInt[22] = 32'b000001_11110_11110_01011_01010_100101;	// (Gasta uma instrução) -> OR
		instructionInt[23] = 32'b000010_11110_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		instructionInt[24] = 32'b000010_11110_00111_0000_0101_0000_0111;	// (Gasta uma instrução) -> Load
		
		instructionInt[25] = 32'b000011_11111_00110_0000_1000_1111_1111;	// (Armazena o resultado na última posição da memória)
	end

	always @(posedge CLK_SYS or posedge rst) begin
		if(rst)
			instruction <= 0;
		else
			instruction <= instructionInt[pc];
	end

endmodule
