`timescale 1ns/100ps
module mux_TB();

	// test vector input registers
	reg [31:0] A;
	reg [31:0] B;
	reg S;
	
	// wires                                               
	wire X;

	// assign statements                           
	mux DUT (
	// port map - connection between master ports and signals/registers   
		.A(A),
		.B(B),
		.S(S),
		.X(X)
	);
	
	initial begin
		S='b0;
		A='b0;
		B='b0;
		#40
		
		S='b0;
		A='hFFFF;
		B='b0;
		#40
		
		S='b1;
		#40	
		
		$display("Running testbench");  
	end
	
	initial begin
		#480 $stop;
	end                                                   
endmodule 