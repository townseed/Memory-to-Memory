module stage_2(

input writeA,
input writeB,
input writeDest,
input writeOp,

input valA,

input [15:0] MemOut,
input [15:0] valA1,

input reset,
input CLK,

output [15:0] AOutputValue,
output [15:0] BOutputValue,
output [15:0] DestOutputValue,
output [7:0] OpOutputValue
);

wire [15:0] AOut;
wire [15:0] BOut;
wire [15:0] DestOut;
wire [7:0] OpOut;
wire [15:0] valAOut;

register16 A
(
	.writeEnable(writeA),
	.inputValue(valAOut) ,	// input [15:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.CLK(CLK) ,	// input  CLK_sig
	.outputValue(AOut) 	// output [15:0] outputValue_sig
);

register16 B
(
	.writeEnable(writeB),
	.inputValue(MemOut) ,	// input [15:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.CLK(CLK) ,	// input  CLK_sig
	.outputValue(BOut) 	// output [15:0] outputValue_sig
);
register16 Dest
(
	.writeEnable(writeDest),
	.inputValue(MemOut) ,	// input [15:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.CLK(CLK) ,	// input  CLK_sig
	.outputValue(DestOut) 	// output [15:0] outputValue_sig
);

register8 Op
(
	.writeEnable(writeOp),
	.inputValue(MemOut[15:8]) ,	// input [15:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.CLK(CLK) ,	// input  CLK_sig
	.outputValue(OpOut) 	// output [15:0] outputValue_sig
);

mux16b2 ValA
(
	.a(MemOut) ,	// input [15:0] a_sig
	.b(valA1) ,	// input [15:0] b_sig
	.s(valA) ,	// input  s_sig
	.r(valAOut) 	// output [15:0] r_sig
);

assign AOutputValue = AOut;
assign BOutputValue = BOut;
assign DestOutputValue = DestOut;
assign OpOutputValue = OpOut;

endmodule
