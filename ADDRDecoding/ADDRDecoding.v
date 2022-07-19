module ADDRDecoding(
	input [31:0] Address,
	output CS
);
	
	wire [20:0] mostSigAddr;
	assign mostSigAddr[20:0] = (Address[31:12] & 0);
	
	// temos para a memória de 500(h) até 8FF(h)
	//     | 11 10 9  8 | 7 6 5 4 | 3 2 1 0 | CS |  
	// 04FF| 0  1  0  0 | 1 1 1 1 | 1 1 1 1 | 1  |
	// 0500| 0  1  0  1 | 0 0 0 0 | 0 0 0 0 | 0  |
	// 05FF| 0  1  0  1 | 1 1 1 1 | 1 1 1 1 | 0  |
	// 0600| 0  1  1  0 | 0 0 0 0 | 0 0 0 0 | 0  |
	// 06FF| 0  1  1  0 | 1 1 1 1 | 1 1 1 1 | 0  |
	// 0700| 0  1  1  1 | 0 0 0 0 | 0 0 0 0 | 0  |
	// 0700| 0  1  1  1 | 1 1 1 1 | 1 1 1 1 | 0  |
	// 0800| 1  0  0  0 | 0 0 0 0 | 0 0 0 0 | 0  |
	// 08FF| 1  0  0  0 | 1 1 1 1 | 1 1 1 1 | 0  |
	// 0900| 1  0  0  1 | 0 0 0 0 | 0 0 0 0 | 1  |
	
	// mapa de Karnaugh:
	//      \9,8 | 00 | 01 | 11 | 10 |
	// 11,10|  00|  1 |  1 |  1 |  1 |
	//         01|  1 |  0 |  0 |  0 |
	//    	  11|  1 |  1 |  1 |  1 |
	//         10|  0 |  1 |  1 |  1 |
	
	// pelas especificações, agrupando os zeros, temos:
	// CS = (~Address[11] | Address[10] | Address[9] | Address[8]) &
	//      (Address[11] | ~Address[10] | ~Address[8]) &
	//      (Address[11] | ~Address[10] | ~Address[9])
	
	// decoficando memória interna em nível lógico baixo para a faixa de 500(h) até 8FF(h) => 1024 posições
	assign CS = (mostSigAddr[20:0]) | 
	            ((~Address[11] | Address[10] | Address[9] | Address[8]) &
					 (Address[11] | ~Address[10] | ~Address[8]) &
					 (Address[11] | ~Address[10] | ~Address[9]));
	
endmodule	