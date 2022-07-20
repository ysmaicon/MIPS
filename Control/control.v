module control (
	input [31:0] instr,
	output [31:0] output_control
);
	// registros a, b e c
	reg a_reg, b_reg;
	
	// seleciona entre ALU ou multiplicador
   // 0: ALU
	// 1: *
	reg d_sel;
	
	// seleciona entre B ou saída do imm para entrar como segundo operando na ALU
	// 0: B
	// 1: IMM
	reg c_sel;
	
	// seleciona a operação na ALU (+, -, &, |):
	// 00: +
	// 01: -
	// 10: &
	// 11: |
	reg [1:0] alu_sel;
	
	
	// seleciona entre writeBack D ou M no register file
	// 0: D
	// 1: M
	reg write_back_sel;
	// 1: habilita write no registro
	reg write_back_en;
	// seleciona registro alvo
	reg [4:0] write_back_reg;
	
	
	// seleciona leitura ou escrita na memória de dados
	reg wr_rd;
	
	// formato de registro (R-Type)
	wire [5:0] op;
	wire [4:0] rs;
	wire [4:0] rt;
	reg [4:0] rd;
	wire [4:0] shamt;
	wire [5:0] funct;
	
	// atribuindo corretamente os bits de instr
	assign op = instr[31:26];
	assign rs = instr[25:21];
   assign rt = instr[20:16];
   // rd = instr[15:11];
	assign shamt = instr[10:6];
	assign funct = instr[5:0];
	
	always @(instr) begin
		
		// valores padrão
		d_sel = 1;
		c_sel = 1;
		alu_sel = 3; // operação &
		write_back_sel = 0;
		write_back_en = 0;
		write_back_reg = 0;
		a_reg = 0;
		b_reg = 0;
		rd = 0;
		
		// op: (+, -, &, |) -> Grupo   = 1; 
		//     (lw)         -> Grupo+1 = 2; 
		//     (sw)         -> Grupo+2 = 3 
		case(op)
			// R-Type para (+, -, &, |)
			1: begin
				// shamt no nosso caso deve ser 10
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
					
						// Soma
						32: begin
							d_sel = 0;
							alu_sel = 2'b00;
						end
						
						// Subtração
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
						
						// Multiplicação
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
	
	assign output_control = {{5'b0},    rs,       rt,       rd,    d_sel,  c_sel, alu_sel, wr_rd, write_back_sel, write_back_en, write_back_reg};
	//                     	[31:27] | [26:22] | [21:17] | [16:12] | [11] | [10] |  [9:8] |  [7] |      [6]      |      [5]     |      [4:0]
endmodule
					