`timescale 1ns/100ps

module ADDRDecoding_TB();
	
	reg [15:0] Address;
	wire Saida;
	
	ADDRDecoding DUT(
		.Address(Address),
		.Saida(Saida)
	);
	
	integer i;
	
	initial begin
		for(i = 0; i <= 2**15; i = i + 1)
			#20 Address = i;
	end
	
	initial begin
		#655370 $stop;
	end
	
endmodule