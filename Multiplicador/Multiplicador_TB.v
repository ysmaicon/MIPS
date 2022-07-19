`timescale 1ns/100ps
module Multiplicador_TB();

	reg Clk;
	reg [15:0] Multiplicando;
	reg [15:0] Multiplicador;
	reg St;
	reg Rst;
	
	wire Done;
	wire Idle;
	wire [31:0]  Produto;
                        
	Multiplicador DUT (  
		.St(St),
		.Clk(Clk),
		.Multiplicando(Multiplicando),
		.Multiplicador(Multiplicador),
		.Idle(Idle),
		.Done(Done),
		.Produto(Produto),
		.Rst(Rst)
	);
	
	initial begin
		forever #5 Clk = ~Clk;
	end
	
	initial begin
		Clk = 0;
		St  = 0;
		Rst = 1;
		Multiplicador = 11;
		Multiplicando = 13;
		#20;
		St = 1;
		Rst = 0;
		#335;
		Multiplicador = 2001;
		Multiplicando = 4001;
		#20;
		St = 0;
		
		#335;
		St  = 1;
		Multiplicador = 65535;
		Multiplicando = 65535;
		#20;
		St = 0;
		#315;
		Rst = 1;
		
		$display("Running testbench");  
	end
	
	initial begin
		#2000 $stop;
	end                                                   
endmodule 
