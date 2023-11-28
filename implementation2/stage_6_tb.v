module stage_6_tb();

reg CLK; // the clock signal
reg reset;

reg inputPC;
reg writeMem;
reg regOrPC;
reg valA;

reg branch;
reg [1:0] memAddr;
reg [1:0] memWriteData;
reg [1:0] ALUsrca;
reg [1:0] ALUsrcb;

reg [3:0] ALUOp;

reg writeA;
reg writeB;
reg writeDest;
reg writeOp;
reg WEpc;
reg writeSP;


reg [15:0] inputPC1;
reg [15:0] ALUsrcA2;
reg [15:0] MA3;


wire [15:0] ALUoutVal;
wire isTrue;
wire [15:0] MemOut;
wire [15:0] AOut;
wire [15:0] BOut;
wire [15:0] DestOut;
wire [7:0] PCOut;
wire [7:0] OpOut;



stage_6 stage_6_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	
	.inputPC(inputPC) ,	// input  inputPC_sig
	
	
	.regOrPC(regOrPC) ,	// input  regOrPC_sig
	.valA(valA) ,
	.branch(branch) ,
	
	.memAddr(memAddr) ,	// input  memAddr_sig
	.memWriteData(memWriteData) ,	// input [1:0] memWriteData_sig
	.ALUsrca(ALUsrca) ,	// input [1:0] ALUsrca_sig
	.ALUsrcb(ALUsrcb) ,	// input [1:0] ALUsrcb_sig
	
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	
	.writeOp(writeOp) ,	// input  writeOp_sig
	.writeA(writeA) ,	// input  writeA_sig
	.writeB(writeB) ,	// input  writeB_sig
	.writeDest(writeDest) ,	// input  writeDest_sig
	.writePC(WEpc) ,	// input  WEpc_sig
	.writeSP(WriteSP) ,	// input  WEpc_sig
	.writeMem(writeMem) ,	// input  writeMem_sig

	.OPOut(OpOut) ,
	.MemOut(MemOut) 	// output [15:0] MemOut_sig
);

parameter HALF_PERIOD = 25;
integer counter = 0;
integer failures = 0;



initial begin
    CLK = 0;
    forever begin
        #(HALF_PERIOD);
        CLK = ~CLK;
    end
end

initial begin

	reset = 1;
	
	#(2*HALF_PERIOD);
	
	// test 1 Addition
	
	//cycle 1
	counter = counter + 1;
	reset = 0;

	writeSP = 0;
	inputPC = 'b0;
	writeMem = 'b0;
	regOrPC = 'b0;
	valA = 'b0;
	branch = 'b0;
	memAddr = 'b0;
	memWriteData = 'b0;
	ALUsrca = 'b01;
	ALUsrcb = 'b01;
	ALUOp = 'b0000;


	writeA = 'b0;
	writeB = 'b0;
	writeDest = 'b0;
	writeOp = 'b1;
	WEpc = 'b1;


	inputPC1 = 'b0;
	ALUsrcA2 = 'b0;
	MA3 = 'b0;

	#(2*HALF_PERIOD);
	
		
	//cycle 2
	counter = counter + 1;
	reset = 'b0;
	inputPC = 'b0;
	writeMem = 'b0;
	regOrPC = 'b0;
	valA = 'b0;
	memAddr = 'b0;
	memWriteData = 'b0;
	ALUsrca = 'b01;
	ALUsrcb = 'b10;

	ALUOp = 'b0000;

	writeA = 'b1;
	writeB = 'b0;
	writeDest = 'b0;
	writeOp = 'b0;
	WEpc = 'b1;


	inputPC1 = 'b0;
	ALUsrcA2 = 'b0;
	MA3 = 'b0;
	
	#(2*HALF_PERIOD);
	
	
	//cycle 3
	counter = counter + 1;
	reset = 'b0;
	inputPC = 'b0;
	writeMem = 'b0;
	regOrPC = 'b0;
	valA = 'b0;
	memAddr = 'b0;
	memWriteData = 'b0;
	ALUsrca = 'b01;
	ALUsrcb = 'b10;

	ALUOp = 'b0000;

	writeA = 'b0;
	writeB = 'b1;
	writeDest = 'b0;
	writeOp = 'b0;
	WEpc = 'b1;

	inputPC1 = 'b0;
	ALUsrcA2 = 'b0;
	MA3 = 'b0;

	#(2*HALF_PERIOD);
	
	
	//cycle 4
	counter = counter + 1;
	reset = 'b0;
	inputPC = 'b0;
	writeMem = 'b0;
	regOrPC = 'b1;
	valA = 'b0;
	memAddr = 'b00;
	memWriteData = 'b0;
	ALUsrca = 'b0;
	ALUsrcb = 'b0;

	ALUOp = 'b0;

	writeA = 'b1;
	writeB = 'b0;
	writeDest = 'b0;
	writeOp = 'b0;
	WEpc = 'b0;

	inputPC1 = 'b0;
	ALUsrcA2 = 'b0;
	MA3 = 'b0;
	
	#(2*HALF_PERIOD);
	
	
	//cycle 5
	counter = counter + 1;
	reset =  'b0;
	inputPC = 'b0;
	writeMem = 'b0;
	regOrPC = 'b1;
	valA = 'b0;
	memAddr = 'b01;
	memWriteData = 'b0;
	ALUsrca = 'b0 ;
	ALUsrcb = 'b0 ;

	ALUOp = 'b0 ;

	writeA = 'b0 ;
	writeB = 'b1;
	writeDest = 'b0;
	writeOp = 'b0;
	WEpc = 'b0;

	inputPC1 = 'b0;
	ALUsrcA2 = 'b0;
	MA3 = 'b0;
	
	#(2*HALF_PERIOD);
	
	
	//cycle 6
	counter = counter + 1;
	reset = 'b0;
	inputPC = 'b0;
	writeMem = 'b0;
	regOrPC = 'b0;
	valA = 'b0;
	memAddr = 'b00;
	memWriteData = 'b0;
	ALUsrca = 'b00;
	ALUsrcb = 'b00;

	ALUOp = 'b0000;

	writeA = 'b1;
	writeB = 'b0;
	writeDest = 'b1;
	writeOp = 'b0;
	WEpc = 'b0;

	inputPC1 ='b0;
	ALUsrcA2 ='b0;
	MA3 = 'b0;
 
	#(2*HALF_PERIOD);
	
 
	//cycle 7
	counter = counter + 1;
	reset = 'b0;
	inputPC = 'b0;
	writeMem = 'b1;
	regOrPC = 'b1;
	valA = 'b0;
	memAddr = 'b10;
	memWriteData = 'b01;
	ALUsrca = 'b01;
	ALUsrcb = 'b10;

	ALUOp = 'b0000;

	writeA = 'b0;
	writeB = 'b0;
	writeDest = 'b0;
	writeOp = 'b0;
	WEpc = 'b1;

	inputPC1 = 'b0;
	ALUsrcA2 = 'b0;
	MA3 = 'b0;
	
	#(2*HALF_PERIOD);
	
	if(MemOut != 15) begin
			failures = failures + 1;
			$display("didnt make 15");
	end
	
	$stop;
end
	
endmodule
