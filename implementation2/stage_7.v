module stage_7(

input CLK,
input reset,

input [15:0] ioInput,
output [15:0] ioOutput

);

wire  inputPC;

wire regorPC;
wire  valA;
wire  branch;
wire [1:0]memAddr;
wire [1:0] memWriteData;
wire [1:0] ALUsrca;
wire [1:0] ALUsrcb;

wire [3:0] ALUOp;

wire writeOp;
wire writeA;
wire writeB;
wire writeDest;
wire writePC;
wire writeSP;
wire writeMem;
wire [7:0] OPOut;

stage_6 stage_6_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	.inputPC(inputPC) ,	// input  inputPC_sig
	.regOrPC(regorPC) ,	// input  regOrPC_sig
	.valA(valA) ,	// input  valA_sig
	.branch(branch) ,	// input  branch_sig
	.memAddr(memAddr) ,	// input [1:0] memAddr_sig
	.memWriteData(memWriteData) ,	// input [1:0] memWriteData_sig
	.ALUsrca(ALUsrca) ,	// input [1:0] ALUsrca_sig
	.ALUsrcb(ALUsrcb) ,	// input [1:0] ALUsrcb_sig
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	.writeOp(writeOp) ,	// input  writeOp_sig
	.writeA(writeA) ,	// input  writeA_sig
	.writeB(writeB) ,	// input  writeB_sig
	.writeDest(writeDest) ,	// input  writeDest_sig
	.writePC(writePC) ,	// input  writePC_sig
	.writeSP(writeSP) ,	// input  writeSP_sig
	.writeMem(writeMem) ,	// input  writeMem_sig
	.OPOut(OPOut), 	// output [7:0] OPOut_sig
	.ioOutput(ioOutput),
	.ioInput(ioInput)
);


control control
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(reset) ,	// input  reset_sig
	.inputPC(inputPC) ,	// input  inputPC_sig
	.regOrPC(regorPC) ,	// input  regOrPC_sig
	
	.valA(valA) ,	// input  valA_sig
	.branch(branch) ,	// input  branch_sig
	.memAddr(memAddr) ,	// input [1:0] memAddr_sig
	.memWriteData(memWriteData) ,	// input [1:0] memWriteData_sig
	
	.ALUSrcA(ALUsrca) ,	// input [1:0] ALUsrca_sig
	.ALUSrcB(ALUsrcb) ,	// input [1:0] ALUsrcb_sig
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	.writeOp(writeOp) ,	// input  writeOp_sig
	
	.writeA(writeA) ,	// input  writeA_sig
	.writeB(writeB) ,	// input  writeB_sig
	.writeDest(writeDest) ,	// input  writeDest_sig
	.writePC(writePC) ,	// input  writePC_sig
	
	.writeSP(writeSP) ,	// input  writeSP_sig
	.writeMem(writeMem) ,	// input  writeMem_sig
	.Opcode(OPOut)	// output [7:0] OPOut_sig
	
);

endmodule
