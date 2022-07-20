module cpu(CLK,reset,resetclk,cs,wr_rd,ADDR,Data_BUS_WRITE,Data_BUS_READ,WriteBack);

	// conexões do módulo principal
	input CLK,reset,resetclk;
	output cs,wr_rd;
	output [31:0] ADDR;
	output [31:0] Data_BUS_WRITE;
	input  [31:0] Data_BUS_READ;
	output [31:0] WriteBack;
	
	// wires com keep
	(*keep=1*)wire [31:0]instruction;
	(*keep=1*)wire [31:0]output_register_A;
	(*keep=1*)wire [31:0]output_register_B_1;
	(*keep=1*)wire [31:0]output_register_D_1;
	(*keep=1*)wire [31:0]output_register_ctrl_1;
	(*keep=1*)wire [31:0]output_mult;	
	(*keep=1*)wire [31:0]output_datamemory;
	(*keep=1*)wire CLK_SYS;
	(*keep=1*)wire CLK_MUL;
	
	// wires
	wire locked;
	wire [9:0] counter;
	wire [31:0]output_register_inst;
	wire [31:0]output_control;	
	wire [31:0]output_extend;
	wire [31:0]output_registerfile_A;
	wire [31:0]output_registerfile_B;
	wire [31:0]output_register_IMM;
	wire [31:0]output_register_ctrl_2;
	wire [31:0]output_register_ctrl_3;
	wire [31:0]output_register_D_2;
	wire [31:0]output_mux_Execute_1;
	wire [31:0]output_alu;
	wire [31:0]output_register_B_2;
	wire [31:0]output_mux_Execute_2;
	wire [31:0]Data_BUS_READ;
	wire [31:0]output_buf_memory;
	wire output_addrdecoding;
	wire Done;
	wire Idle;
	wire [31:0]output_mux_write_back;
	
	// assign
	assign wr_rd = output_register_ctrl_2[7]; // sinal para dispositivos externos para indicar se é uma operação de leitura ou escrita
	assign cs = output_addrdecoding;
	assign ADDR = output_register_D_1;
	assign Data_BUS_WRITE = output_register_B_2;
	assign WriteBack = output_mux_write_back; 
	
	// PLL
	PLL PLLGenerator(
		resetclk,
		CLK,
		CLK_MUL,
		CLK_SYS,
		locked
	);
	
	// Instruction Fetch
	PC pc_MIPS(
		.Clk(CLK_SYS),
		.Rst(reset),
		.Saida(counter)
	);
	
	instructionmemory IM_MIPS(
		.CLK_SYS(CLK_SYS),
		.rst(reset),
		.pc(counter),
		.instruction(instruction)
	);
	
	////////////////////////////////////////////////////////////
	
	// Instruction Decode
	registerfile registerfile_MIPS(
		.clock(CLK_SYS),
		.rst(reset), 
		.control(output_register_ctrl_3[4:0]), 
		.rs(output_control[26:22]), 
		.rt(output_control[21:17]),
		.write_back_reg(output_mux_write_back),
		.outputA(output_registerfile_A),
		.outputB(output_registerfile_B),
		.wr(output_register_ctrl_3[5])
	);
	
	control control_MIPS(
		.instr(instruction),
		.output_control(output_control)
	);
	
	extend extend_MIPS(
		.instr(instruction), 
		.imm(output_extend)
	);
	
	register register_A(
		.clk(CLK_SYS),
		.rst(reset),
		.in(output_registerfile_A), 
		.out(output_register_A)
	);
	
	register register_B_1(
		.clk(CLK_SYS),
		.rst(reset),
		.in(output_registerfile_B), 
		.out(output_register_B_1)
	);
	
	register register_IMM(
		.clk(CLK_SYS),
		.rst(reset),
		.in(output_extend), 
		.out(output_register_IMM)
	);
	
	register register_CTRL_1(
		.clk(CLK_SYS),
		.rst(reset),
		.in(output_control), 
		.out(output_register_ctrl_1)
	);
	
	////////////////////////////////////////////////////////////
	
	// Execute
	alu alu_MIPS(
		.inputA(output_register_A), 
		.inputB(output_mux_Execute_1), 
		.sel(output_register_ctrl_1[9:8]), 
		.out(output_alu)
	);
	
	Multiplicador multiplicador_MIPS(
		.Clk(CLK_MUL),
		.Rst(reset),
		.St(output_register_ctrl_1[11]),
		.Done(Done),
		.Idle(Idle),
		.Multiplicando(output_register_A[15:0]),
		.Multiplicador(output_register_B_1[15:0]),
		.Produto(output_mult)
	);
	
	mux mux_Execute_1(
		.A(output_register_B_1),
		.B(output_register_IMM),
		.S(output_register_ctrl_1[10]),
		.X(output_mux_Execute_1)
	);
	
	mux mux_Execute_2(
		.A(output_alu),
		.B(output_mult),
		.S(output_register_ctrl_1[11]),
		.X(output_mux_Execute_2)
	);
	
	register register_D_1(
		.clk(CLK_SYS),
		.rst(reset), 
		.in(output_mux_Execute_2), 
		.out(output_register_D_1)
	);
	
	register register_B_2(
		.clk(CLK_SYS),
		.rst(reset), 
		.in(output_register_B_1), 
		.out(output_register_B_2)
	);
	
	register register_CTRL_2(
		.clk(CLK_SYS),
		.rst(reset), 
		.in(output_register_ctrl_1), 
		.out(output_register_ctrl_2)
	);
	
	////////////////////////////////////////////////////////////
	
	// Memory
	
	ADDRDecoding ADDRDecoding_MIPS(
		.Address(output_register_D_1), 
		.CS(output_addrdecoding)
	);
	
	datamemory datamemory_MIPS(
		.Clk(CLK_SYS),
		.rst(reset),
		.Addr(output_register_D_1[9:0]),
		.Data_in(output_register_B_2),
		.We(output_register_ctrl_2[7]),
		.Data_out(output_datamemory)
	);
	
	register register_D_2(
		.clk(CLK_SYS),
		.rst(reset), 
		.in(output_register_D_1), 
		.out(output_register_D_2)
	);
	
	register register_CTRL_3(
		.clk(CLK_SYS),
		.rst(reset),
		.in(output_register_ctrl_2), 
		.out(output_register_ctrl_3)
	);
	
	assign output_buf_memory = (~output_addrdecoding ? output_datamemory : 32'bZ);
	
	////////////////////////////////////////////////////////////
	
	//Write Back
	
	mux mux_out(
		.A(output_register_D_2),
		.B(output_buf_memory),
		.S(output_register_ctrl_3[6]),
		.X(output_mux_write_back)
	);
endmodule
	
	