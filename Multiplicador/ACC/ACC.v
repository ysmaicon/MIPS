module ACC (Saidas, Load, Sh, Ad, Clk, Entradas, Rst);

	input Load, Sh, Ad, Clk, Rst;
	input [32:0] Entradas;
	output reg [32:0] Saidas;
	
	always @ (posedge Clk, posedge Rst) begin
		if (Rst)
			begin
				Saidas[32:0] <= 1'b0;
			end
		else 
			begin
				if (Load)
					begin
						Saidas[15:0] <= Entradas[15:0];
						Saidas[32:16] <= 1'b0;
					end 
				
				if(Ad)
					begin
						Saidas[32:16] <= Entradas[32:16];
					end
				
				if(Sh)
					begin
						Saidas[32:0] <= {1'b0,Saidas[32:1]};
					end
			end
	end

endmodule