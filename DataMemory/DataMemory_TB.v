`timescale 1ns/100ps
module datamemory_TB();
	
	reg Clk, rst;
	reg We;
	reg [31:0] Addr;
	wire [31:0] Data_out;
	reg [31:0] Data_in;

	datamemory DUT (
		.Clk(Clk),
		.rst(rst),
		.Addr(Addr),
		.Data_out(Data_out),
		.Data_in(Data_in),
		.We(We)
	);
	
	always begin
		#10 Clk = ~Clk;
	end

	initial begin
		Clk = 0;
		rst = 1;
		We = 1;
		Data_in = 0;
		Addr = 0;
		#10
		rst = 0;
		
		// lendo da memória
		We = 1;
		Addr = 0;
		#50
		Addr = 1;
		#50
		Addr = 2;
		#50
		Addr = 3;
		#50
		Addr = 4;
		
		// escrevendo na memória
		We = 0;
		Addr = 0;
		Data_in = 33400;
		#100
		Addr = 1;
		#50
		Addr = 2;
		#50
		Addr = 3;
		#50
		Addr = 4;
		
		// lendo da memória
		We = 1;
		Addr = 0;
		#50
		Addr = 1;
		#50
		Addr = 2;
		#50
		Addr = 3;
		#50
		Addr = 4;
		#50
		Addr = 5;
		#50
		Addr = 6;
		#50
		Addr = 7;
		#50
		Addr = 8;
		#50
		Addr = 9;
	end
	
	initial begin
		#900 $stop;
	end
	
endmodule 