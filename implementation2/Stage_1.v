module Stage_1(
//actual stage 1 inputs
input  inputPC,
input  WEpc,
input  normOrBranch,
input [1:0] ALUsrca,
input [1:0] ALUsrcb,


input [3:0] ALUOp,
input CLK,
input reset,

//inputs to connect it to other stages
input [15:0] inputPC1,
input [15:0] ALUsrcA0,
input [15:0] ALUsrcA2,
input [15:0] ALUsrcB0,
input [15:0] NOB1,

//outputs for connections and testing
output [15:0] PCval,
output [15:0] ALUval,
output isTrue
);

wire  isTrueOut;
wire [15:0] ALUinA;
wire [15:0] ALUinB;
wire [15:0] ALUout;
wire [15:0] PCin;
wire [15:0] PCout;
wire [15:0] inputPCOut;

alu ALU
(
	.A(ALUinA) ,	// input [15:0] A_sig
	.B(ALUinB) ,	// input [15:0] B_sig
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	.outputValue(ALUout) ,	// output [15:0] outputValue_sig
	.isTrue(isTrueOut) 	// output [0:0] isTrue_sig
);

register16 PC
(
	.inputValue(PCin) ,	// input [15:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.writeEnable(WEpc) ,	// input  writeEnable
	.CLK(CLK) ,	// input  CLK_sig
	.outputValue(PCout) 	// output [15:0] outputValue_sig
);

mux16b2 InputPC
(
	.a(ALUout) ,	// input [15:0] a_sig
	.b(inputPC1) ,	// input [15:0] b_sig
	.s(inputPC) ,	// input  s_sig
	.r(inputPCOut) 	// output [15:0] r_sig
);

mux16b2 NormOrBranch
(
	.a(inputPCOut) ,	// input [15:0] a_sig
	.b(NOB1) ,	// input [15:0] b_sig
	.s(normOrBranch) ,	// input  s_sig
	.r(PCin) 	// output [15:0] r_sig
);

mux16b4 ALUsrcA
(
	.a(ALUsrcA0) ,	// input [15:0] a_sig
	.b(PCout) ,	// input [15:0] b_sig
	.c(ALUsrcA2) ,	// input [15:0] c_sig
	.d(16'b0) ,	// input [15:0] d_sig
	.s(ALUsrca) ,	// input [1:0] s_sig
	.r(ALUinA) 	// output [15:0] r_sig
);


mux16b4 ALUsrcB
(
	.a(ALUsrcB0) ,	// input [15:0] a_sig
	.b(16'b01) ,	// input [15:0] b_sig
	.c(16'b010) ,	// input [15:0] c_sig
	.d(16'b0) ,	// input [15:0] d_sig
	.s(ALUsrcb) ,	// input [1:0] s_sig
	.r(ALUinB) 	// output [15:0] r_sig
);


assign PCval = PCout;
assign ALUval = ALUout;
assign isTrue = isTrueOut;

endmodule
