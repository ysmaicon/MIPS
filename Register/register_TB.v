`timescale 1ns/100ps

module register_TB;
	
	reg clk, rst;
	reg [31:0] in;
	wire [31:0] out;

	register DUT(
		.clk(clk),
		.rst(rst),
		.in(in),
		.out(out)
	);

	always begin
		#10 clk = ~clk;
	end
	
	initial begin
		clk = 0;
		rst = 1;
		#10 rst = 0;
		in = 20;
	end

	always begin
		#20 in = in + 10;
	end

	initial begin
		#600 $stop;
	end

endmodule