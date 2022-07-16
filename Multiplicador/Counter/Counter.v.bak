module Counter(Load, Clk, K);

	input Load, Clk;
	output K;

	reg[3:0] n;

	assign K = (n == 8) ? 1'b1: 1'b0;

	always @(posedge Clk) begin
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