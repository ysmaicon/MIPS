module ACC (Saidas, Load, Sh, Ad, Clk, Entradas);

	input Load, Sh, Ad, Clk;
	input [8:0] Entradas;
	output reg [8:0] Saidas;
	
	always @ (posedge Clk) begin
		if (Load)
			begin
				Saidas[3:0] <= Entradas[3:0];
				Saidas[8:4] <= 1'b0;
			end 
		
		if(Ad)
			begin
				Saidas[8:4] <= Entradas[8:4];
			end
		
		if(Sh)
			begin
				Saidas[8:0] <= {1'b0,Saidas[8:1]};
			end
	end

endmodule