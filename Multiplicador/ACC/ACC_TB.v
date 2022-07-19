`timescale 1ns/100ps
module ACC_TB();

	reg Clk, Rst;
	reg [32:0] Entradas;
	reg Load;
	reg Sh;
	reg Ad;
	
	wire [32:0] Produto;
                         
	ACC DUT (  
		.Clk(Clk),
		.Rst(Rst),
		.Entradas(Entradas),
		.Load(Load),
		.Sh(Sh),
		.Ad(Ad),
		
		.Saidas(Produto)
	);
	
	initial begin
		forever #40 Clk = ~Clk;
		
	end
	
	integer i=0,j=0,k=0;
	
	initial begin
		Clk = 0;
		Rst = 1;
		#5 Rst = 0;
		Entradas = 33'b011011100001010010101101111011011;
		Load = 0; 
		Sh = 0;
		Ad = 0;
		
		for(i=0;i<2;i=i+1) begin
			for(j=0;j<2;j=j+1) begin
				for(k=0;k<2;k=k+1) begin
					#80
					Ad = ~Ad;
				end
				Sh = ~Sh;
			end
			Load =~Load;
		end
		
		$display("Running testbench");  
	end
	
	initial begin
		#1200 $stop;
	end                                                   
endmodule