module DataMemory(
	input Clk,
	input We,
	input [9:0] Addr,
	input [31:0] Data_in,
	output reg[31:0] Data_out
);
	
	reg [31:0] Memory [0:1023];

	initial begin
		// [0] -> A = 2001 ; [1] => B = 4001 ; [2] => C = 5001 ; [3] => D = 3001
		Memory[0] = 32'b0000_0000_0000_0000_0000_0111_1101_0001;
		Memory[1] = 32'b0000_0000_0000_0000_0000_1111_1010_0001;
		Memory[2] = 32'b0000_0000_0000_0000_0001_0011_1000_1001;
		Memory[3] = 32'b0000_0000_0000_0000_0000_1011_1011_1001;
	end

	always @(posedge Clk) begin
		if (We)
			begin
				Memory[Addr-256] <= Data_in;
			end
		else
			begin
				Data_out <= Memory[Addr-256];
			end
	end

endmodule