module Stage_1_tb();

reg CLK; // the clock signal
reg reset;
reg [0:0] writepc;
reg [1:0] ALUsrca;
reg [1:0] ALUsrcb;
reg [3:0] ALUOp;

wire [15:0] outputValue;
wire [15:0] ALUValue;
wire isTrue;

Stage_1 stage_1
(
	.writepc(writepc) ,	// input  writepc_sig
	.WEpc(1) ,	// input  WEpc_sig
	.ALUsrca(ALUsrca) ,	// input [1:0] ALUsrca_sig
	.ALUsrcb(ALUsrcb) ,	// input [1:0] ALUsrcb_sig
	
	.ALUOp(ALUOp) ,	// input [3:0] ALUOp_sig
	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	
	.WritePC1(0) ,	// input [15:0] WritePC0_sig
	.ALUsrcA0(0) ,	// input [15:0] ALUsrcA0_sig
	.ALUsrcA2(0) ,	// input [15:0] ALUsrcA2_sig
	.ALUsrcB0(0) ,	// input [15:0] ALUsrcB0_sig
	
	.PCval(outputValue) ,	// output [15:0] PCval_sig
	.ALUval(ALUValue) ,	// output [15:0] ALUval_sig
	.isTrue(isTrue) 	// output  isTrue_sig
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
	//test wrong sources
	reset = 0;
	writepc = 0;
	ALUsrca = 0;
	ALUsrcb = 0;
	ALUOp = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 0) begin
			failures = failures + 1;
			$display("operation incorrectA + incorrectB returned %c", outputValue);
	end
	
	//test add 1
	writepc = 0;
	ALUsrca = 1;
	ALUsrcb = 1;
	ALUOp = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 1) begin
			failures = failures + 1;
			$display("adding 1 failed");
	end
	
	//test add 2 to 1
	writepc = 0;
	ALUsrca = 1;
	ALUsrcb = 2;
	ALUOp = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 3) begin
			failures = failures + 1;
			$display("adding 2 to 1 failed");
	end

	//test add 2 to 3
	writepc = 0;
	ALUsrca = 1;
	ALUsrcb = 2;
	ALUOp = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 5) begin
			failures = failures + 1;
			$display("adding 2 to 3 failed");
	end

	//test sub 2 from 5
	writepc = 0;
	ALUsrca = 1;
	ALUsrcb = 2;
	ALUOp = 1;
	#(2*HALF_PERIOD);
	
	if(outputValue != 3) begin
			failures = failures + 1;
			$display("subtracting 2 from 5 failed");
	end
	
	//test other input for writepc
	writepc = 1	;
	ALUsrca = 1;
	ALUsrcb = 2;
	ALUOp = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 0) begin
			failures = failures + 1;
			$display("other write to pc failed");
	end
	
	$stop;


end


endmodule
