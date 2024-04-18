module arm( 
	input logic clk, reset,
	output logic [11:0] PC,
	input logic  [11:0] Instructions,
	output logic        MemoryWrite,
	output logic [11:0] ALUResult, WriteData,
	input logic  [11:0] ReadData);
				
	logic [3:0] ALUFlags;
	logic       RegisterWrite, ALUSrc, MemtoReg, PCSrc;
	logic [1:0] RegisterSrc, ImmSrc, ALUControl;
	
	controller c(clk, reset, Instructions[11:4], ALUFlags, RegisterSrc, RegisterWrite, ImmSrc, ALUSrc, ALUControl, MemoryWrite, MemorytoRegister, PCSrc);
	datapath dp(clk, reset, RegisterSrc, RegisterWrite, ImmSrc, ALUSrc, ALUControl, MemorytoRegister, PCSrc, ALUFlags, PC, Instructions, ALUResult, WriteData, ReadData);

endmodule
				
