module stage_6(
input CLK,
input reset,

input  inputPC,

input regOrPC,
input  valA,
input  branch,

input [1:0]memAddr,
input [1:0] memWriteData,
input [1:0] ALUsrca,
input [1:0] ALUsrcb,

input [3:0] ALUOp,

input writeOp,
input writeA,
input writeB,
input writeDest,
input writePC,
input writeSP,
input writeMem,

output [7:0] OPOut,

input [15:0] ioInput,
output [15:0] ioOutput
);

wire [15:0] ALUoutVal;
wire [15:0] SPOut;

stage_5 stage_5_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	.inputPC(inputPC) ,	// input  inputPC_sig
	.writeMem(writeMem) ,	// input  writeMem_sig
	.regOrPC(regOrPC) ,	// input  regOrPC_sig
	.valA(valA) ,	// input  valA_sig
	.branch(branch) ,	// input  branch_sig
	.memAddr(memAddr) ,	// input [1:0] memAddr_sig
	.memWriteData(memWriteData) ,	// input [1:0] memWriteData_sig
	.ALUsrca(ALUsrca) ,	// input [1:0] ALUsrca_sig
	.ALUsrcb(ALUsrcb) ,	// input [1:0] ALUsrcb_sig
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	.writeA(writeA) ,	// input  writeA_sig
	.writeB(writeB) ,	// input  writeB_sig
	.writeDest(writeDest) ,	// input  writeDest_sig
	.writeOp(writeOp) ,	// input  writeOp_sig
	.writePC(writePC) ,	// input  writePC_sig
	.ALUsrcA2(SPOut) ,	// input [15:0] ALUsrcA2_sig
	.MA3(SPOut) ,	// input [15:0] MA3_sig
	.ALUoutVal(ALUoutVal) ,	// output [15:0] ALUoutVal_sig
	.OPOut(OPOut),
	.ioOutput(ioOutput),
	.ioInput(ioInput)
);

register16SP SP
(
	.writeEnable(writeSP),
	.inputValue(ALUoutVal) ,	// input [15:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.CLK(CLK) ,	// input  CLK_sig
	.outputValue(SPOut) 	// output [15:0] outputValue_sig
);




endmodule
