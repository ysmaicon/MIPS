`timescale 1ns/10ps

module registerfile_TB();
	
	reg clock, reset;
	reg [4:0] controle;
	reg [4:0]
	rs, rt;
	reg [31:0] entrada;
	reg wr;
	wire [31:0] saidaA, saidaB;

	registerfile DUT(
		.clock(clock),
		.reset(reset),
		.rs(rs),
		.rt(rt),
		.controle(controle),
		.entrada(entrada),
		.saidaA(saidaA),
		.saidaB(saidaB),
		.wr(wr)
	);
	
	integer i = 0;

	initial begin
		controle = 0;
		clock = 0;
		reset = 0;
		entrada = 250;
		wr = 1;
		rs=0;
		rt=1;
		
		for(i=0;i<7;i=i+1)
		begin
			#40
			entrada = entrada+25;
			controle = controle+1;
			rs=5;
			rt=i;
		end	
		
		#40
		entrada = entrada+25;
		controle = controle+1;
		rs=0;
		rt=4;
		
		#40
		entrada = entrada+25;
		controle = controle+1;
		rs=8;
		rt=9;
		
		#40
		entrada = entrada+25;
		controle = controle+1;
		rs=8;
		rt=9;
		
	end
	
	always #10 clock = ~clock;

initial
	 #400 $stop;

endmodule