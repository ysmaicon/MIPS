`timescale 1ns/100ps
module Counter_TB();

	reg Load, Clk, Rst;                                       
	wire K;
                      
	Counter DUT (  
		.Load(Load),
		.Clk(Clk),
		.Rst(Rst),
		.K(K)
	);
	
	initial begin
		forever #40 Clk = ~Clk;
	end
	
	initial begin
		Rst = 0;
		Load = 1;
		Clk = 1;
		$display("Running testbench");  
	end
	
	always begin
		#80;
		Load = 0; 
	end
	
	initial begin
		#3600 $stop;
	end                                                   
endmodule