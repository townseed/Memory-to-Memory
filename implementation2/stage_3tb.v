module stage_3tb();

reg CLK; // the clock signal
reg reset;
reg [0:0] writeMem;
reg [0:0] WEaluOut;
reg [1:0] memWriteData;
reg [15:0] ALUval;
reg [15:0] addr;

wire [15:0] outputValue;

stage_3 stage_3
(
	.WEaluOut(WEaluOut) ,	// input  WEaluOut_sig
	.writeMem(writeMem) ,// input  writeMem_sig
	.memWriteData(memWriteData) ,	// input [1:0] memWriteData_sig
	.ALUoutput(ALUval) ,	// input [15:0] ALUoutput_sig

	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	.memAddr(addr) ,
	
	.MWD0(0) ,	// input [15:0] MWD0_sig
	.MWD2(0) ,// input [15:0] MWD2_sig
	.memOut(outputValue) 	// output [15:0] memout_sig
);

parameter HALF_PERIOD = 25;
integer failures = 0;

initial begin
    CLK = 0;
    forever begin
        #(HALF_PERIOD);
        CLK = ~CLK;
    end
end

initial begin

	// Test 1: Does it work?

	reset = 1;
	#(2*HALF_PERIOD);
	reset = 0;
	writeMem = 1;
	WEaluOut = 1;
	ALUval = 17;
	memWriteData = 1;
	addr = 0;
	
	#(4*HALF_PERIOD);		// This is a little goofy. It will store, it just needs an extra cycle
	
	if(outputValue != 17) begin
			failures = failures + 1;
			$display("Storing 17 failed.");
	end
	
	// Test 2: Does the writeMem flag work?

	reset = 0;
	writeMem = 0;
	WEaluOut = 1;
	ALUval = 1;
	memWriteData = 1;
	addr = 0;
	
	#(4*HALF_PERIOD);
	
	if(outputValue != 17) begin
			failures = failures + 1;
			$display("keeping 17 failed.");
	end
	
	reset = 0;
	writeMem = 1;
	WEaluOut = 1;
	ALUval = 1;
	memWriteData = 1;
	addr = 0;
	
	#(4*HALF_PERIOD);
	
	if(outputValue != 1) begin
			failures = failures + 1;
			$display("Storing 1 failed.");
	end
	
	// Test 3: Will another address overwrite a different address?

	reset = 0;
	writeMem = 1;
	WEaluOut = 1;
	ALUval = 12;
	memWriteData = 1;
	addr = 2;
	
	#(4*HALF_PERIOD);
	
	if(outputValue != 12) begin
			failures = failures + 1;
			$display("Storing 12 failed.");
	end

	reset = 0;
	writeMem = 0;
	WEaluOut = 1;
	ALUval = 12;
	memWriteData = 1;
	addr = 0;
	
	#(4*HALF_PERIOD);
	
	if(outputValue != 1) begin
			failures = failures + 1;
			$display("getting 1 failed.");
	end
	
	$stop;

end


endmodule
