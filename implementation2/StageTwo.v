module StageTwo();

reg reset; // the reset reg
reg CLK; // the clock signal
wire [15:0] AOutputValue;
reg AWriteEnable;

wire [15:0] BOutputValue;
reg BWriteEnable;

wire [15:0] DestOutputValue;
reg DestWriteEnable;

wire [7:0] OpOutputValue;
reg OpWriteEnable;

reg memWrite;
reg [15:0] MemInputValue;
reg [15:0] MemInputAddress;
wire [15:0] MemOutputValue;

parameter HALF_PERIOD = 25;
parameter CLOCK_PERIOD = 50;
integer cycle_counter = 0;
integer counter = 0;
integer failures = 0;

register16 A
(
	.inputValue(MemOutputValue) ,	// input [7:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.outputValue(AOutputValue) ,	// output [7:0] outputValue_sig
	.writeEnable(AWriteEnable),
	.CLK(CLK) 	// input  CLK_sig
);

register16 B
(
	.inputValue(MemOutputValue) ,	// input [7:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.outputValue(BOutputValue) ,	// output [7:0] outputValue_sig
	.writeEnable(BWriteEnable),
	.CLK(CLK) 	// input  CLK_sig
);

register16 Dest
(
	.inputValue(MemOutputValue) ,	// input [7:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.outputValue(DestOutputValue) ,	// output [7:0] outputValue_sig
	.writeEnable(DestWriteEnable),
	.CLK(CLK) 	// input  CLK_sig
);

register8 Op
(
	.inputValue(MemOutputValue) ,	// input [7:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.outputValue(OpOutputValue) ,	// output [7:0] outputValue_sig
	.writeEnable(OpWriteEnable),
	.CLK(CLK) 	// input  CLK_sig
);

memory mem(
	.memWrite(memWrite),
	.inputAddress(MemInputAddress),
	.inputValue(MemInputValue) ,	// input [7:0] inputValue_sig
	.outputValue(MemOutputValue) ,	// output [7:0] outputValue_sig
	.CLK(CLK) 	// input  CLK_sig
	);
	
initial begin
    CLK = 0;
    forever begin
        #(HALF_PERIOD);
        CLK = ~CLK;
    end
end

initial begin
	reset = 1;
	#(CLOCK_PERIOD);
	
	//here we go
	MemInputAddress = 0;
	MemInputValue = 69;
	memWrite = 1;
	#(CLOCK_PERIOD);
	//write 69 to all memory addresses
	repeat(65536) begin
		#(CLOCK_PERIOD);
		MemInputValue = MemInputValue + 1;
	end
	
	memWrite = 0;
	//read the value at mem[45] and write it into reg A
	MemInputAddress = 45;
	reset = 0;
	AWriteEnable = 1;
	//wait for propagation
	#(CLOCK_PERIOD);
	#(CLOCK_PERIOD);
	if(AOutputValue != 69) begin
		failures = failures + 1;
		$display("reg A failed read test");
	end
	AWriteEnable = 0;
	
	//write a different value to mem[10]
	
	MemInputAddress = 10;
	MemInputValue = 55;
	memWrite = 1;
	#(CLOCK_PERIOD);
	memWrite = 0;
	
	//read the value at mem[0] and write it into reg B
	MemInputAddress = 7;
	BWriteEnable = 1;
	#(CLOCK_PERIOD);
	#(CLOCK_PERIOD);
	if(BOutputValue != 69) begin
		failures = failures + 1;
		$display("reg B failed read test");
	end
	BWriteEnable = 0;
	
	//read the value of mem[10] into the dest reg
	
	MemInputAddress = 10;
	DestWriteEnable = 1;
	#(CLOCK_PERIOD);
	#(CLOCK_PERIOD);
	if(DestOutputValue != 55) begin
		failures = failures + 1;
		$display("reg Dest failed read test");
	end
	DestWriteEnable = 0;
	
	MemInputValue = 1023;
	MemInputAddress = 42069;
	memWrite = 1;
	#(CLOCK_PERIOD);
	
	memWrite = 0;
	
	OpWriteEnable = 1;
	#(CLOCK_PERIOD);
	#(CLOCK_PERIOD);
	if(OpOutputValue != 255) begin
		failures = failures + 1;
		$display("reg OP failed read test, did not truncate properly");
	end
	
	#(CLOCK_PERIOD);
	
	MemInputAddress = 409;
	#(CLOCK_PERIOD);
	#(CLOCK_PERIOD);
	if(OpOutputValue != 69) begin
		failures = failures + 1;
		$display("reg OP failed read test");
	end
	OpWriteEnable = 0;
	
	$display("tests finished with %d failures", failures);
	$stop;
	end
	endmodule
	
	
