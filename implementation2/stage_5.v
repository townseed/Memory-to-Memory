module stage_5(
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

input writeMem,


input [15:0] ALUsrcA2,
input [15:0] MA3,

output [15:0] ALUoutVal,
output [7:0] OPOut,

input [15:0] ioInput,
output [15:0] ioOutput

);

wire normOrBranch;
wire WEpc;
wire isTrue;

assign normOrBranch = (branch && isTrue);
assign WEpc = (writePC || normOrBranch);


stage_4 stage_4_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	.inputPC(inputPC) ,	// input  inputPC_sig
	.writeMem(writeMem) ,	// input  writeMem_sig
	.regOrPC(regOrPC) ,	// input  regOrPC_sig
	.valA(valA) ,	// input  valA_sig
	.normOrBranch(normOrBranch) ,	// input  normOrBranch_sig
	.memAddr(memAddr) ,	// input [1:0] memAddr_sig
	.memWriteData(memWriteData) ,	// input [1:0] memWriteData_sig
	.ALUsrca(ALUsrca) ,	// input [1:0] ALUsrca_sig
	.ALUsrcb(ALUsrcb) ,	// input [1:0] ALUsrcb_sig
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	.writeA(writeA) ,	// input  writeA_sig
	.writeB(writeB) ,	// input  writeB_sig
	.writeDest(writeDest) ,	// input  writeDest_sig
	.writeOp(writeOp) ,	// input  writeOp_sig
	.WEpc(WEpc) ,	// input  WEpc_sig
	.ALUsrcA2(ALUsrcA2) ,	// input [15:0] ALUsrcA2_sig
	.MA3(MA3) ,	// input [15:0] MA3_sig
	.ALUoutVal(ALUoutVal) ,	// output [15:0] ALUoutVal_sig
	.isTrue(isTrue) ,	// output  isTrue_sig


	.Opout(OPOut) ,	// output [7:0] Opout_sig

	.ioOutput(ioOutput),
	.ioInput(ioInput)
);


endmodule
