module registerfile(
	input rst, clock,
	input [4:0] control,
	input [4:0] rs, rt,
	input [31:0] write_back_reg,
	output [31:0] outputA, outputB,
	input wr // write_back_en
);
	

	reg [31:0] register[31:0];
	
	integer i;
	
	always@(posedge clock or posedge rst) 
	begin
		if(rst == 1) 
		begin
			for(i=0;i<32;i=i+1)
			begin
				register[i]<=0;
			end
		end
		else if(wr == 1) 
		begin
			register[control]<=write_back_reg;
		end
	end
 

	//always@(*) begin
	assign outputA = register[rs];
	//end

	//always@(*) begin
	assign outputB = register[rt];
	//end

endmodule
