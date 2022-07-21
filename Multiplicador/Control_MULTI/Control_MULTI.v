module Control_MULTI (Idle, Done, Load, Sh, Ad, Clk, St, M, K, Rst);
	input Clk, Rst;
	input St, M, K;
	output reg Idle, Done, Load, Sh, Ad;
	
	// registro de estados
	(*keep=1*) reg [1:0]state;


	// declaração dos estados
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	// determinação do próximo estado 
	// baseado no estado atual
	always @ (posedge Clk, posedge Rst) begin
		if (Rst)
			begin
				state <= S0;
		end
		else
			begin
				case (state)
					S0:
						if (St)
							begin
								state <= S1;
							end
						else
							begin
								state <= S0;
							end
					S1:
							begin
								state <= S2;
							end
					S2:
						if (K)
							begin
								state <= S3;
							end
						else
							begin
								state <= S1;
							end
					S3:
							begin
								state <= S0;
							end
					default:
							begin
								state <= S0;
							end
				endcase
			end
	end

	// determinação das saidas
	// da máquina de estados
	always @ (state or St or M or K) begin
		Idle = 0; Load = 0; Ad = 0; Done = 0; Sh = 0;
		case (state)
			S0:
				begin
					Idle = 1;
					if (St)
						begin
							Load = 1;
						end
					else 
						begin
							Load = 0;
						end	
				end
			S1:
				if (M)
					begin
						Ad = 1;
					end
				else
					begin
						Ad = 0;
					end
			S2:
				begin
					Sh = 1;
				end
			S3:
				begin
					Done = 1;
				end
		endcase
	end

endmodule

