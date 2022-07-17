`timescale 1ns/10ps

module control_TB();

	reg [31:0] instr;
	wire [31:0] output_control;
	
	control DUT(
		.instr(instr),
		.output_control(output_control)
	);

	initial begin
		
		// load A: to initialize
		instr = 32'b000010_00101_00000_0001_1001_0000_0000;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// load A
		#50
		instr = 32'b000010_00101_00000_0001_1001_0000_0000;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// load B
		#50 
		instr = 32'b000010_00101_00001_0001_1001_0000_0001;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// load C
		#50 
		instr = 32'b000010_00101_00010_0001_1001_0000_0010;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// load D
		#50 
		instr = 32'b000010_00101_00011_0001_1001_0000_0011;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// multiply: A*B
		#50 
		instr = 32'b000001_00000_00001_01000_01010_110010;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// add: C+D
		#50 
		instr = 32'b000001_00010_00011_01001_01010_100000;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// subtract: (A*B)-(C+D)
		#50 
		instr = 32'b000001_01000_01001_01010_01010_100010;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// store the result
		#50 
		instr = 32'b000011_00101_01010_0001_1100_1111_1111;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// or: C|D
		#50 
		instr = 32'b000001_00010_00011_01001_01010_100101;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		// and: C&D
		#50 
		instr = 32'b000001_00010_00011_01001_01010_100100;
		#10
		$display("Instruction = %b    |    output_control = %b", instr, output_control);
		
		
	end
	
	initial #800 $stop;
		
endmodule
