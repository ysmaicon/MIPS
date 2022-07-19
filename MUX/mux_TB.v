`timescale 1ns/100ps
module mux_TB();

	// vetores dos registros de entrada
	reg [31:0] A;
	reg [31:0] B;
	reg S;
	
	// wires                                               
	wire [31:0] X;
                         
	mux DUT (
	   // port map - conexões entre ports e sinais/registros   
		.A(A),
		.B(B),
		.S(S),
		.X(X)
	);
	
	initial begin
		S <= 0;
		A <= 32'h00000000;
		B <= 32'h00000000;
		#40
		
		S <= 1;
		A <= 32'h0000FFFF;
		B <= 32'hFFFF0000;
		#40
		
		S = 1;
		A <= 32'h12874321;
		B <= 32'h52001543;
		#40	
		
		S = 0;
		
		$display("Running testbench");  
	end
	
	initial begin
		#480 $stop;
	end                                                   
endmodule 