module registerfile(
	input reset, clock,
	input [4:0] controle,
	input [4:0] rs, rt,
	input [31:0] entrada,
	output [31:0] saidaA, saidaB,
	input wr
);
	

	reg [31:0] registrador [31:0];
	
	integer i;
	
	always@(posedge clock) 
	begin
		if(reset == 1) 
		begin
			for(i=0;i<32;i=i+1)
			begin
				registrador[i]<=0;
			end
		end
		else if(wr == 1) 
		begin
			registrador[controle]<=entrada;
		end
	end
 

	//always@(*) begin
	assign saidaA = registrador[rs];
	//end

	//always@(*) begin
	assign saidaB = registrador[rt];
	//end

endmodule