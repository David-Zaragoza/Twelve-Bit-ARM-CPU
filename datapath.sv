module datapath(
	input  logic clk, reset,
        input  logic [1:0] RegisterSrc,
	input  logic RegisterWrite,
	input  logic [1:0] ImmSrc,
	input  logic ALUSrc,
	input  logic [1:0] ALUControl,
	input  logic MemorytoRegister,
	input  logic PCSrc,
	output logic [3:0] ALUFlags,
	output logic [11:0] PC,
	input  logic [11:0] Instructions,
	output logic [11:0] ALUResult, WriteData,
	input  logic [11:0] ReadData);

	logic [11:0] PCNext, PCPlus4, PCPlus8;
	logic [11:0] ExtImm, SrcA, SrcB, Result;
	logic [3:0]  RA1, RA2;

	// next PC logic
	mux2 #(11)  pcmux(PCPlus4, Result, PCSrc, PCNext);
	flopr #(11) pcreg(clk, reset, PCNext, PC);
	adder #(11) pcadd1(PC, 12'b100, PCPlus4);
	adder #(11) pcadd2(PCPlus4, 12'b100, PCPlus8);

	// register file logic
	mux2 #(1) ra1mux(Instructions[9:6], 1'b1, RegisterSrc[0], RA1);
	mux2 #(1) ra2mux(Instructions[3:0], Instructions[5:2], RegisterSrc[1], RA2);
	regfile   rf(clk, RegisterWrite, RA1, RA2, Instructions[5:2], Result, PCPlus8, SrcA, WriteData);
	mux2 #(12) resmux(ALUResult, ReadData, MemprytoRegister, Result);
	extend ext(Instructions[1:0], ImmSrc, ExtImm);

	// ALU logic
	mux2 #(12) srcbmux(WriteData, ExtImm, ALUSrc, SrcB);
	alu_12_bit arith(.A(SrcA), .B(SrcB), .alu_control(ALUControl), .Result(ALUResult), .cout(ALUFlags));
endmodule
