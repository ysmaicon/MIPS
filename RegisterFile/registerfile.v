module registerfile(
	input reset, clock,
	input [4:0] controle,
	input [4:0] rs, rt,
	input [31:0] entrada,
	output reg [31:0] saidaA, saidaB,
	input wr
);
	

	reg[31:0] s0, s1, s2, s3, s4, s5, s6, s7, t0, t1, t2, t3, t4, t5, t6, t7;

	always@(posedge clock) 
	begin
		if(reset == 1) 
		begin
			s0<=0; s1<=0; s2<=0; s3<=0; s4<=0; s5<=0; s6<=0; s7<=0; 
			t0<=0; t1<=0; t2<=0; t3<=0; t4<=0; t5<=0; t6<=0; t7<=0;
		end
		else if(wr == 1) 
		begin
			case(controle) 
				0: s0 <= entrada;
				1: s1 <= entrada;
				2: s2 <= entrada;
				3: s3 <= entrada;
				4: s4 <= entrada;
				5: s5 <= entrada;
				6: s6 <= entrada;
				7: s7 <= entrada;
				8: t0 <= entrada;
				9: t1 <= entrada;
				10: t2 <= entrada;
				11: t3 <= entrada;
				12: t4 <= entrada;
				13: t5 <= entrada;
				14: t6 <= entrada;
				15: t7 <= entrada;
				default: s0=entrada;
			endcase
		end
	end
 

	always@(*) begin
		case(rs)
			0: saidaA = s0;
			1: saidaA = s1;
			2: saidaA = s2;
			3: saidaA = s3;
			4: saidaA = s4;
			5: saidaA = s5;
			6: saidaA = s6;
			7: saidaA = s7;
			8: saidaA = t0;
			9: saidaA = t1;
			10: saidaA = t2;
			11: saidaA = t3;
			12: saidaA = t4;
			13: saidaA = t5;
			14: saidaA = t6;
			15: saidaA = t7;
			default:saidaA = entrada;
		endcase		
	end

	always@(*) begin
		case(rt)
			0: saidaB = s0;
			1: saidaB = s1;
			2: saidaB = s2;
			3: saidaB = s3;
			4: saidaB = s4;
			5: saidaB = s5;
			6: saidaB = s6;
			7: saidaB = s7;
			8: saidaB = t0;
			9: saidaB = t1;
			10: saidaB = t2;
			11: saidaB = t3;
			12: saidaB = t4;
			13: saidaB = t5;
			14: saidaB = t6;
			15: saidaB = t7;
			default:saidaB = entrada;
		endcase
	end

endmodule