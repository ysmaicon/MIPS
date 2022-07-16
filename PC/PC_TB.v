`timescale 1ns/100ps
module PC_TB();

	reg Clk;
	reg Rst;
	wire [9:0] Saida;
	
	PC DUT (
		.Clk(Clk),
		.Rst(Rst),
		.Saida(Saida)
	);
	
	always begin
		#5 Clk = ~Clk;
	end

	initial begin
		Clk = 0;
		Rst = 1;
		#10 Rst = 0;
		#1000 Rst = 1;
		#15 Rst = 0;
	end

	initial begin
		#1500 $stop;
	end
	
endmodule 