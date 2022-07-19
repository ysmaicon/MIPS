module register(
	input clk, 
	input rst,
	input [31:0] in,
	output reg [31:0] out
);

	always @(posedge clk or posedge rst) begin
		if(rst)
			out <= 0;
		else
			out <= in;
	end
	
endmodule
