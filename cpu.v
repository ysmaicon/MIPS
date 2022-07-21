/*
a) Qual a latência do sistema?
A latência do sistema é de 5 pulsos de clock, ou seja, cada instrução é executada em 5 ciclos de clock:
- primeiro lê a instrução na memória e carrega no registro de INSTR
- depois realiza a decodificação
- faz uma operação, seja ela +, -, |, & ou *
- leitura/escrita na memória de dados
- escreve no RegisterFile, através do WriteBack

b) Qual o throughput do sistema?
O throughput do sistema é de 32bits/clk, no caso, uma instrução por clk, a partir do momento em que o pipeline estiver cheio

c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador e para o sistema? (Indique a FPGA utilizada)
FPGA utilizada: Cyclone IV GX EP4CGX150DF31I7AD
Frequência Máxima Operacional do Sistema: 
-> Slow 100C: 243.19 MHz 
->  Slow 40C: 269.11 MHz
Frequência Máxima Operacional do Multiplicador:
-> Slow 1200mV - 40C: 368,73 MHz
-> Slow 1200mv 100C:: 314,07MHz 

d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)
A máxima frequência de operação do sistema é dada da seguinte forma:
Frequência Máxima Operacional do Sistema = Frequência Operacional do Multiplicador / 34, onde 34 corresponde ao número de vezes que a frequência do sistema deve ser menor em relação ao multiplicador calculado por (2N+2), com N= número de bits.
Logo,	
Frequência Máxima Operacional do Sistema para  Slow 100C = 243.19 MHz/34 = 7,15 MHz
Frequência Máxima Operacional do Sistema para  Slow 40C = 269.11 MHz/34 = 7,92 MHz
FPGA utilizada: Cyclone IV GX EP4CGX150DF31I7AD

e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente (se executada em sequência ininterrupta)? Por quê? O que pode ser feito para que a expressão seja calculada corretamente?
Não é executada corretamente. Isso deve-se ao fato de que não está sendo respeitado o tempo que leva para ser carregado um valor no registrador, já que as instruções leem do RegisterFile antes de serem guardadas. Dessa forma, é necessário adicionar “bolhas” para que passe a quantidade de tempo mínimo de leitura de dados antes de fazer uma operação, como foi feito na segunda parte do código do módulo de Instruction Memory.

f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com metaestabilidade? Por que?
Não há problema de metaestabilidade, pois o clock do sistema foi feito, por meio da PLL, para ser 34 vezes o clock do multiplicador e, assim, as bordas de subida dos dois clocks coincidem entre si quando necessário.

g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por que?
Não é eficiente, pois o multiplicador não possui paralelismo e o clock do sistema é limitado pelo multiplicador, que precisa de 34 clocks para realizar sua operação.
h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência de operação maior). Para cada modificação sugerida, qual a nova latência e throughput do sistema?
O mais importante para tornar o sistema mais rápido é modificar o multiplicador. Assim, pode-se aplicar paralelismo no multiplicador, implementando pipeline. Nesse caso, seria possível fazer mais instruções em paralelo, o que aumentaria o throughput e manteria a latência. No entanto, isso traria como ponto negativo ter mais pipelines hazzards. Outra modificação que poderia ser feita seria de usar um mesmo clock com enable em todos os registros do sistema. Dessa forma, o sistema esperaria apenas pelo multiplicador se fosse feita uma multiplicação, ou seja, a latência e throughput seriam os mesmos, em quantidade de clocks, mas com uma frequência maior. Essa possibilidade deveria ser considerada viável dependendo do número de operações de multiplicação a serem executadas.

*/


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
	
	