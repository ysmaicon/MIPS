module instructionmemory(
    input CLK_SYS, rst,
    input[9:0] pc,
    output reg[31:0] instruction
);
	reg [31:0] instructionInt[1023:0];

	initial begin	
	   // Load word
		// grupo+1 _ 5 _ rt _ offset
		// offset = grupo * 500h + rt
		instructionInt[0] = 32'b000010_00101_00111_0000_0101_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[1] = 32'b000010_00101_00000_0000_0101_0000_0000;	// (Carrega A em registerfile0 - 00000)
		instructionInt[2] = 32'b000010_00101_00001_0000_0101_0000_0001;	// (Carrega B em registerfile1 - 00001) 
		instructionInt[3] = 32'b000010_00101_00010_0000_0101_0000_0010;	// (Carrega C em registerfile2 - 00010)
		instructionInt[4] = 32'b000010_00101_00011_0000_0101_0000_0011;	// (Carrega D em registerfile3 - 00011)
		
		// Operações aritméticas e lógicas
		// grupo _ rs _ rt _ rd _ 10 _ codOperacao
		instructionInt[5] = 32'b000001_00000_00001_01000_01010_110010;		// (Multiplica o conteudo do registerfile0(00000) pelo conteudo do registerfile1(00001) e carrega o resutlado no registerfile8 - 01000) 
		instructionInt[6] = 32'b000001_00010_00011_01001_01010_100000;		// (Soma o conteudo do registerfile0(00010) pelo conteudo do registerfile1(00011) e carrega o resutlado no registerfile9 - 01001) 
		instructionInt[7] = 32'b000001_01000_01001_01010_01010_100010;		// (Subtrai o conteudo do registerfile8(01000) pelo conteudo do registerfile9(01001) e carrega o resutlado no registerfile10 - 01010)
		instructionInt[8] = 32'b000001_01010_01011_01011_01010_100100;		// AND
		instructionInt[9] = 32'b000001_11000_11001_01111_01010_100101;		// OR
		
		// Save word
		// grupo+2 _ 5 _ rt _ offset
		instructionInt[10] = 32'b000011_00101_01010_0000_1000_1111_1111;	// (Armazena o resultado do registerfile10(01010) na posição 1023 da memória)	
		
		// *** INSERINDO BOLHAS - VERIFICANDO A NAO PRESENÇA DE PIPELINE HAZZARDS ***
		instructionInt[11] = 32'b000010_00101_00000_0001_1001_0000_0000;	// (Carrega A em registerfile0 - 00000)
		instructionInt[12] = 32'b000010_00101_00001_0001_1001_0000_0001;	// (Carrega B em registerfile1 - 00001) 
		instructionInt[13] = 32'b000010_00101_00010_0001_1001_0000_0010;	// (Carrega C em registerfile2 - 00010)
		instructionInt[14] = 32'b000010_00101_00011_0001_1001_0000_0011;	// (Carrega D em registerfile3 - 00011)
		instructionInt[15] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução)
		instructionInt[16] = 32'b000001_00000_00001_01000_01010_110010;	// (Multiplica o conteudo do registerfile0(00000) pelo conteudo do registerfile1(00001) e carrega o resutlado no registerfile8 - 01000) 
		instructionInt[17] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[18] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[19] = 32'b000001_00010_00011_01001_01010_100000;	// (Soma o conteudo do registerfile0(00010) pelo conteudo do registerfile1(00011) e carrega o resutlado no registerfile9 - 01001)
		instructionInt[20] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[21] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[22] = 32'b000001_01000_01001_01010_01010_100010;	// (Subtrai o conteudo do registerfile8(01000) pelo conteudo do registerfile9(01001) e carrega o resutlado no registerfile10 - 01010)
		instructionInt[23] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[24] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[25] = 32'b000001_01010_01011_01011_01010_100100;	// AND
		instructionInt[26] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[27] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[28] = 32'b000001_11000_11001_01111_01010_100101;	// OR
		instructionInt[29] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução) -> Load
		instructionInt[30] = 32'b000010_00101_00111_0001_1001_0000_0000;	// (Gasta uma instrução)-> Load
		instructionInt[31] = 32'b000011_00101_01010_0000_1000_1111_1111;	// (Armazena o resutlado do registerfile10(01010) na posição 1023 da memória)
	end

	always @(posedge CLK_SYS or posedge rst) begin
		if(rst)
			instruction <= 0;
		else
			instruction <= instructionInt[pc];
	end

endmodule
