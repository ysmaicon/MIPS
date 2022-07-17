module control (
	input [31:0] instr,
	output [31:0] output_control
);
	// registers a, b and c
	reg a_reg, b_reg;
	
	// selects between ALU or multiplier
   // 0: ALU
	// 1: *
	reg d_sel;
	
	// selects between B or imm's output to enter as second term in ALU
	// 0: B
	// 1: IMM
	reg c_sel;
	
	// selects the operation in ALU (+, -, &, |):
	// 00: +
	// 01: -
	// 10: &
	// 11: |
	reg [1:0] alu_sel;
	
	
	// selects if writeBack D or M in the register file
	// 0: D
	// 1: M
	reg write_back_sel;
	// enable write into the register 
	// 1: enables writing
	reg write_back_en;
	// choose the target register
	reg [4:0] write_back_reg;
	
	
	// selects read or write in the data memory
	reg wr_rd;
	
	// register format (R-Type)
	wire [5:0] op;
	wire [4:0] rs;
	wire [4:0] rt;
	reg [4:0] rd;
	wire [4:0] shamt;
	wire [5:0] funct;
	
	// assigning the bits of instr
	assign op = instr[31:26];
	assign rs = instr[25:21];
   assign rt = instr[20:16];
   //assign rd = instr[15:11];
	assign shamt = instr[10:6];
	assign funct = instr[5:0];
	
	always @(instr) begin
		
		// default values
		d_sel = 1;
		c_sel = 1;
		alu_sel = 3; //operation &
		write_back_sel = 0;
		write_back_en = 0;
		write_back_reg = 0;
		a_reg = 0;
		b_reg = 0;
		rd = 0;
		
		// op: (+, -, &, |) -> Group   = 1; 
		//     (lw)         -> Group+1 = 2; 
		//     (sw)         -> Group+2 = 3 
		case(op)
			// R-Type for (+, -, &, |)
			1: begin
				// shamt in our case has to be 10
				if(shamt == 10) begin
					a_reg = rs;
					b_reg = rt;
					rd = instr[15:11];
					c_sel = 0;
					wr_rd = 0;
					write_back_sel = 0;
					write_back_en = 1;
					write_back_reg = rd;
					
					case(funct)
					
						// Add
						32: begin
							d_sel = 0;
							alu_sel = 2'b00;
						end
						
						// Subtract
						34: begin
							d_sel = 0;
							alu_sel = 2'b01;
						end
						
						// And (&)
						36: begin
							d_sel = 0;
							alu_sel = 2'b10;
						end
						
						// Or (|)
						37: begin
							d_sel = 0;
							alu_sel = 2'b11;
						end
						
						// Multiplier
						50: begin
							d_sel = 1;
							alu_sel = 2'b00;
						end
						
						default: ;
					endcase
				end
			end
			
			// Load
			2: begin
				a_reg = rs;
				b_reg = 0;
				rd = 0;
				d_sel = 0;
				c_sel = 1;
				alu_sel = 2'b00;
				wr_rd = 0;
				write_back_sel = 1;
				write_back_en = 1;
				write_back_reg = rt;
			end
			
			// Store
			3: begin
				a_reg = rs;
				b_reg = rt;
				rd = 0;
				d_sel = 0;
				c_sel = 1;
				alu_sel = 2'b00;
				wr_rd = 1;
				write_back_sel = 1;
				write_back_en = 0;
				write_back_reg = 0;
			end
			
			default: ;
		endcase
	end
	
	assign output_control = {{5'b0}, rs, rt, rd, d_sel, c_sel, alu_sel, wr_rd, write_back_sel, write_back_en, write_back_reg};
	
endmodule
					