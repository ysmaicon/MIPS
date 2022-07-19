module datamemory (
	input Clk, rst,
	input We,
	input [9:0] Addr,
	input [31:0] Data_in,
	output [31:0] Data_out
);

	reg [31:0] MemoryRam [1023:0];
	reg [9:0] AddrReg;
	
	integer i;

	initial begin
		// [0] -> A = 2001 ; 
		// [1] => B = 4001 ; 
		// [2] => C = 5001 ; 
		// [3] => D = 3001
		MemoryRam[0] = 32'b0000_0000_0000_0000_0000_0111_1101_0001;
		MemoryRam[1] = 32'b0000_0000_0000_0000_0000_1111_1010_0001;
		MemoryRam[2] = 32'b0000_0000_0000_0000_0001_0011_1000_1001;
		MemoryRam[3] = 32'b0000_0000_0000_0000_0000_1011_1011_1001;
		
		// inicializando as outras posições da memória
		for(i = 4; i < 1024; i = i + 1)
			MemoryRam[i] = 0;
			
	end

	always @(posedge Clk or posedge rst) begin
		if(rst)
			AddrReg <= 0;
		else 
			begin	
				if (We == 0) // write: 0; read = 1
					MemoryRam[Addr] <= Data_in;
				AddrReg <= Addr;
			end
	end
	assign Data_out = MemoryRam[AddrReg];

endmodule
