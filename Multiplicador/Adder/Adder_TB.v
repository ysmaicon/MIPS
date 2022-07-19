`timescale 1ns/100ps
module Adder_TB();

	// operados de entrada
	reg [15:0] OperandoA;
	reg [15:0] OperandoB;
	
	// wires                                               
	wire [16:0] Soma;
                        
	Adder DUT (
		// port map - conexões entre ports e sinais/registros
		.OperandoA(OperandoA),
		.OperandoB(OperandoB),
		
		.Soma(Soma)
	);
	
	integer i=0;
	
	initial begin
		
		for(i=0;i<16;i=i+1) begin
			OperandoA = $urandom%65536;
			OperandoB = $urandom%65536;
			#40;
		end
		
		$display("Running testbench");  
	end
	
	initial begin
		#6000 $stop;
	end                                                   
endmodule 