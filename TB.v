`timescale 1ns/100ps

module TB; 

	reg CLK;
	reg [31:0]instruction;
	reg [31:0]output_register_A;
	reg [31:0]output_register_B_1;
	reg [31:0]output_register_D_1;
	reg [31:0]output_register_ctrl_1;
	reg [31:0]output_mult;
	reg [31:0]output_datamemory;
	reg CLK_SYS;
	reg CLK_MUL;
	reg reset;
	reg resetclk;
	reg [31:0] Data_BUS_READ;
	wire [31:0] Data_BUS_WRITE;
	wire [31:0] WriteBack;
	wire cs,wr_rd;
	wire [31:0] ADDR;

	cpu DUT(
		.CLK(CLK),
		.reset(reset),
		.resetclk(resetclk),
		.cs(cs),
		.wr_rd(wr_rd),
		.ADDR(ADDR),
		.Data_BUS_WRITE(Data_BUS_WRITE),
		.Data_BUS_READ(Data_BUS_READ),
		.WriteBack(WriteBack)
	);
	
	initial begin
		CLK = 0;
		reset = 1;
		resetclk = 1;
		#10 
		reset = 0;
		resetclk = 0;
		#15000;
		//reset = 0;
		resetclk = 1;
		#50;
		//reset = 0;
		resetclk = 0;
	end
	
	always begin
		#5 CLK = ~CLK;
	end
	
	initial begin
		$init_signal_spy("/TB/DUT/instruction","instruction",1);
		$init_signal_spy("/TB/DUT/output_register_A","output_register_A",1);
		$init_signal_spy("/TB/DUT/output_register_B_1","output_register_B_1",1);
		$init_signal_spy("/TB/DUT/output_register_D_1","output_register_D_1",1);
		$init_signal_spy("/TB/DUT/output_register_ctrl_1","output_register_ctrl_1",1);
		$init_signal_spy("/TB/DUT/output_mult","output_mult",1);
		$init_signal_spy("/TB/DUT/output_datamemory","output_datamemory",1);
		$init_signal_spy("/TB/DUT/CLK_SYS","CLK_SYS",1);
		$init_signal_spy("/TB/DUT/CLK_MUL","CLK_MUL",1);
	end


initial 
	#25200 $stop;

endmodule
