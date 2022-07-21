`timescale 1ns/100ps
module Control_MULTI_TB();

	reg Clk, Rst;
	reg K;
	reg M;
	reg St;
																
	wire Ad;
	wire Done;
	wire Idle;
	wire Load;
	wire Sh;

									 
	Control_MULTI DUT (
		.Ad(Ad),
		.Clk(Clk),
		.Rst(Rst),
		.Done(Done),
		.Idle(Idle),
		.K(K),
		.Load(Load),
		.M(M),
		.Sh(Sh),
		.St(St)
	);

	integer i = 0,j = 0,k = 0;

	initial begin
		forever #1 Clk = ~Clk;
	end

	initial begin
		Rst = 1;
		#10 Rst = 0;
		#6;
		K = ~K;
		#2;
		K = ~K;
		#12;
		K = ~K;
		#2;
		K = ~K;
		#5;
		K = ~K;
		for(i=0;i<18;i=i+1) begin
			#2;
			K = ~K;
		end
	end 

	initial begin
		#4;
		M = ~M;
		#2;
		M = ~M;
		#12;
		M = ~M;
		#2;
		M = ~M;
		#9;
		M = ~M;
		for(j=0;j<8;j=j+1) begin
			#4;
			M = ~M;
		end
	end 

	initial begin
		#2;
		St = ~St;
		#2;
		St = ~St;
		#8;
		St = ~St;
		#2;
		St = ~St;
		#19;
		St = ~St;
		for(k=0;k<3;k=k+1) begin
			#8;
			St = ~St;
		end
	end 

	initial begin 
		Clk = 1'b0;
		K = 1'b0;
		M = 1'b0;
		St = 1'b0;
		#64 $stop;
	end 
endmodule
