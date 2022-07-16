module PC(
	input Clk,
	input Rst,
	output reg [9:0] Saida
);

	always@(posedge Clk or posedge Rst) begin 
		if (Rst)
			begin
				Saida <= 0;
			end
		else
			begin
				Saida <= Saida + 1'b1;
			end	
	end

endmodule 