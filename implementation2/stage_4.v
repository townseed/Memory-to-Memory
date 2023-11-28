module stage_4(
input CLK,
input reset,

input  inputPC,
input writeMem,
input regOrPC,
input  valA,
input  normOrBranch,
input [1:0]memAddr,
input [1:0] memWriteData,
input [1:0] ALUsrca,
input [1:0] ALUsrcb,


input [3:0] ALUOp,

input writeA,
input writeB,
input writeDest,
input writeOp,
input WEpc,


input [15:0] ALUsrcA2,
input [15:0] MA3,

output [15:0] ALUoutVal,
output isTrue,

output [7:0] Opout,

input [15:0] ioInput,
output [15:0] ioOutput

);

wire [15:0] AOut;
wire [15:0] BOut;
wire [15:0] DestOut;
wire [7:0] OpOut;
wire [15:0] MemAddrOut;
wire [15:0] RegOrPCOut;

wire [15:0] PCval;
wire [15:0] ALUval;

wire [15:0] memOut;


assign ALUoutVal = ALUval;



assign Opout = OpOut;

Stage_1 stage_1
(
	.inputPC(inputPC) ,	// input  writepc_sig
	.WEpc(WEpc) ,	// input  WEpc_sig
	.normOrBranch(normOrBranch) ,
	.ALUsrca(ALUsrca) ,	// input [1:0] ALUsrca_sig
	.ALUsrcb(ALUsrcb) ,	// input [1:0] ALUsrcb_sig
	
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	
	.inputPC1(AOut) ,	// input [15:0] WritePC0_sig
	.ALUsrcA0(AOut) ,	// input [15:0] ALUsrcA0_sig
	.ALUsrcA2(ALUsrcA2) ,	// input [15:0] ALUsrcA2_sig
	.ALUsrcB0(BOut) ,	// input [15:0] ALUsrcB0_sig
	.NOB1(DestOut) ,
	
	.PCval(PCval) ,	// output [15:0] PCval_sig
	.ALUval(ALUval) ,	// output [15:0] ALUval_sig
	.isTrue(isTrue) 	// output  isTrue_sig
);

stage_2 stage_2
(
	.writeA(writeA) ,	// input  writeA_sig
	.writeB(writeB) ,	// input  writeB_sig
	.writeDest(writeDest) ,	// input  writeDest_sig
	.writeOp(writeOp) ,	// input  writeOp_sig
	
	.MemOut(memOut) ,	// input [15:0] memOut_sig
	.reset(reset) ,	// input  reset_sig
	.CLK(CLK) ,	// input  CLK_sig
	
	.valA(valA) ,
	.valA1(ALUval) ,

	.AOutputValue(AOut) ,	// output [15:0] AOutputValue_sig
	.BOutputValue(BOut) ,	// output [15:0] BOutputValue_sig
	.DestOutputValue(DestOut) ,	// output [15:0] DestOutputValue_sig
	.OpOutputValue(OpOut) 	// output [7:0] OpOutputValue_sig
);

stage_3 stage_3
(
	.writeMem(writeMem) ,// input  writeMem_sig
	.memWriteData(memWriteData) ,	// input [1:0] memWriteData_sig
	.ALUoutput(ALUval) ,	// input [15:0] ALUoutput_sig

	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	.memAddr(RegOrPCOut) ,
	
	.MWD0(BOut) ,	// input [15:0] MWD0_sig
	.MWD2(AOut) ,// input [15:0] MWD2_sig
	.memOut(memOut) ,	// output [15:0] memout_sig
	.ioOutput(ioOutput),
	.ioInput(ioInput)
);

mux16b4 MemAddr
(
	.a(AOut) ,	// input [15:0] a_sig
	.b(BOut) ,	// input [15:0] b_sig
	.c(DestOut) ,	// input [15:0] c_sig
	.d(MA3) ,	// input [15:0] d_sig
	.s(memAddr) ,	// input [1:0] s_sig
	.r(MemAddrOut) 	// output [15:0] r_sig
);

mux16b2 RegOrPC
(
	.a(PCval) ,	// input [15:0] a_sig
	.b(MemAddrOut) ,	// input [15:0] b_sig
	.s(regOrPC) ,	// input  s_sig
	.r(RegOrPCOut) 	// output [15:0] r_sig
);





endmodule
