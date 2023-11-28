//`timescale 1 ns/1 ps
module memorytest();

reg CLK; // the clock signal
reg memWrite;
reg [7:0] inputValue;
reg [15:0] inputAddress;
wire [7:0] outputValue;

memory uut(
	.memWrite(memWrite),
	.inputAddress(inputAddress),
	.inputValue(inputValue) ,	// input [15:0] inputValue_sig
	.outputValue(outputValue) ,	// output [15:0] outputValue_sig
	.clk(CLK) 	// input  CLK_sig
	);
	
parameter HALF_PERIOD = 25;
integer cycle_counter = 0;
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

	
	
	//read from memory test
	memWrite = 0;
	inputAddress = 0;

	#(2*HALF_PERIOD);
	if(outputValue != 0) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end
	
	memWrite = 0;
	inputAddress = 1;

	#(2*HALF_PERIOD);
	if(outputValue != 12) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end
	
	memWrite = 0;
	inputAddress = 3;

	#(2*HALF_PERIOD);
	if(outputValue != 14) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end
	
	memWrite = 0;
	inputAddress = 4;

	#(2*HALF_PERIOD);
	if(outputValue != 'h0e00) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end
	
	memWrite = 0;
	inputAddress = 5;

	#(2*HALF_PERIOD);
	if(outputValue != 16) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end
	
	memWrite = 0;
	inputAddress = 12;

	#(2*HALF_PERIOD);
	if(outputValue != 10) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end

	memWrite = 0;
	inputAddress = 14;

	#(2*HALF_PERIOD);
	if(outputValue != 5) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end


//	$stop;

	//write 55 into every address of memory
	memWrite = 1;
	
	inputAddress = 0;
	inputValue = 'h5555;
	
	#(2*HALF_PERIOD);
	repeat(65536) begin
		#(2*HALF_PERIOD);
		inputAddress = inputAddress + 1;
	end
	memWrite = 0;
	//wait a few cycles to make sure the values aren't lost
	
	repeat(180) begin
		#(2*HALF_PERIOD);
	end
	
	//read all addresses and print/count failures
	
	inputAddress = 0;
	#(2*HALF_PERIOD);
	if(outputValue != 'h5555) begin
		$display("address %d failed read verification", inputAddress);
		failures = failures + 1;
	end
	
	inputAddress = 1;
	
	repeat(65536) begin
		#(2*HALF_PERIOD);
		if(outputValue != 'h5555) begin
			$display("address %d failed read verification", inputAddress);
			failures = failures + 1;
		end
		inputAddress = inputAddress + 1;
	end
	
	
	#(2*HALF_PERIOD);
	$display("Test concluded with %f failures", failures);
	$stop;
	
end
endmodule
