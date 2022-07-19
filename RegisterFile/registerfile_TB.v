`timescale 1ns/100ps

module registerfile_TB();
	
	reg clock, rst;
	reg [4:0] control;
	reg [4:0]
	rs, rt;
	reg [31:0] write_back_reg;
	reg wr; // write_back_en
	wire [31:0] outputA, outputB;

	registerfile DUT(
		.clock(clock),
		.rst(rst),
		.rs(rs),
		.rt(rt),
		.control(control),
		.write_back_reg(write_back_reg),
		.outputA(outputA),
		.outputB(outputB),
		.wr(wr)
	);
	
	integer i = 0;

	initial begin
		control = 0;
		clock = 0;
		rst = 0;
		write_back_reg = 250;
		wr = 1;
		rs=0;
		rt=1;
		
		for(i=0;i<7;i=i+1)
		begin
			#40
			write_back_reg = write_back_reg+25;
			control = control+1;
			rs=5;
			rt=i;
		end	
		
		#40
		write_back_reg = write_back_reg+25;
		control = control+1;
		rs=0;
		rt=4;
		
		#40
		write_back_reg = write_back_reg+25;
		control = control+1;
		rs=8;
		rt=9;
		
		#40
		write_back_reg = write_back_reg+25;
		control = control+1;
		rs=8;
		rt=9;
		
	end
	
	always #10 clock = ~clock;

initial
	 #400 $stop;

endmodule