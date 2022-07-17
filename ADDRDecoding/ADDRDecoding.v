module ADDRDecoding(
	input [15:0] Address,
	output Saida
);
	
	//Decoficando memória interna em nível lógico baixo para a faixa de 500(h) até 8FF(h) => 1024 posições
	assign Saida = (Address[15]) | 
						(Address[14]) |
						(Address[13]) | 
						(Address[12]) | 
						(~Address[11] & ~Address[9] & ~Address[8]) |
						(~Address[10] & Address[8]) | 
						(~Address[10] & Address[9]) | 
						(Address[11] & Address[10]);
	
endmodule	