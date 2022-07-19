`timescale 1ns/100ps

module ADDRDecoding_TB();
	
	reg [31:0] Address;
	wire CS;
	
	ADDRDecoding DUT(
		.Address(Address),
		.CS(CS)
	);
	
	integer i;
	
	initial begin
		Address = 32'h0000;
	
		// endereço anterior ao intervalo
		#50 Address = 32'h04FF;
		// endereços compreendidos dentro do intervalo em que CS é selecionado
		for(i = 1279; i <= 2048; i = i + 256)
			#50 Address = i;
		// endereço após o intervalo
		#50 Address = 32'h0900;
	end
	
	initial begin
		#600 $stop;
	end
	
endmodule