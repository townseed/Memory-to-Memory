module stage_3(
input writeMem,
input [1:0] memWriteData,
input [15:0] ALUoutput,

input CLK,
input reset,

input [15:0] memAddr,

input [15:0] MWD0,
input [15:0] MWD2,

output [15:0] memOut,

input [15:0] ioInput,
output [15:0] ioOutput
);

// wire [15:0] ALUinput;
wire [15:0] ALUout;
wire [15:0] memWD;

//wire [15:0] addr;



register16 ALUOut
(
	.writeEnable(1'b1),
	.inputValue(ALUoutput) ,	// input [15:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.CLK(CLK) ,	// input  CLK_sig
	.outputValue(ALUout) 	// output [15:0] outputValue_sig
);

mux16b4 MemWriteData
(
	.a(MWD0) ,	// input [15:0] a_sig
	.b(ALUout) ,	// input [15:0] b_sig
	.c(MWD2) ,	// input [15:0] c_sig
	.d(16'b0) ,	// input [15:0] d_sig
	.s(memWriteData) ,	// input [1:0] s_sig
	.r(memWD) 	// output [15:0] r_sig
);


//memory memory_inst
//(
//	.CLK(CLK) ,	// input  CLK_sig
//	.memWrite(writeMem) ,	// input  memWrite_sig
//	.inputAddress(memAddr) ,	// input [15:0] inputAddress_sig
//	.inputValue(memWD) ,	// input [15:0] inputValue_sig
//	.outputValue(memOut) 	// output [15:0] outputValue_sig
//);

memoryio memio
(
	.data_a(memWD[15:8]) ,	// input [DATA_WIDTH-1:0] data_a_sig
	.data_b(memWD[7:0]) ,	// input [DATA_WIDTH-1:0] data_b_sig
	.addr_a(memAddr) ,	// input [ADDR_WIDTH-1:0] addr_a_sig
	.addr_b(memAddr + 16'b01) ,	// input [ADDR_WIDTH-1:0] addr_b_sig
	.we_a(writeMem) ,	// input  we_a_sig
	.we_b(writeMem) ,	// input  we_b_sig
	.clk(~CLK) ,	// input  clk_sig
	.q(memOut) ,	// output [DATA_WIDTH-1:0] q_a_sig	
	.out(ioOutput),
	.in(ioInput),
	.reset(reset)
);


endmodule
