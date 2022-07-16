`timescale 1ns/10ps
module DataMemory_TB();
	
	reg Clk;
	reg [31:0] Addr;
	wire [31:0] Data_out;
	reg [31:0] Data_in;
	reg We;

	DataMemory DUT (
		.Clk(Clk),
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
		We = 0;
		
		Addr = 0;
		Data_in = 34000;
		#100
		Addr = 1;
		#50
		Addr = 2;
		#50
		Addr = 3;
		#50
		Addr = 4;
		
		We = 1;
		Addr = 0;
		Data_in = 34000;
		#100
		Addr = 1;
		#50
		Addr = 2;
		#50
		Addr = 3;
		#50
		Addr = 4;
		
		We = 0;
		Addr = 0;
		Data_in = 34000;
		#100
		Addr = 1;
		#50
		Addr = 2;
		#50
		Addr = 3;
		#50
		Addr = 4;
	end
	
	initial begin
		#750 $stop;
	end
	
endmodule 