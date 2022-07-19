module Counter(Load, Clk, Rst, K);

	input Load, Clk, Rst;
	output K;

	reg[5:0] n;

	assign K = (n == 32) ? 1'b1: 1'b0;

	always @(posedge Clk, posedge Rst) begin
		if(Rst)
			n <= 0;
		else 
			if(Load == 1)
			begin
				n <= 1;
			end
			else if (n >= 1)
			begin
				n <= n + 1;
			end
	end

endmodule 
