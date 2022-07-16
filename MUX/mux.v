module mux(A,B,S,X);
 
	input [31:0] A, B;
	input S;
	output [31:0] X;
	 
	assign X = (!S) ? B : A;

endmodule
