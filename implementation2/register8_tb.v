`timescale 1 ns/1 ps
module register8_tb (
);

reg reset; // the reset reg
reg CLK; // the clock signal
reg [7:0] inputValue;
wire [7:0] outputValue;



register8 reg8
(
	.inputValue(inputValue) ,	// input [7:0] inputValue_sig
	.reset(reset) ,	// input  reset_sig
	.outputValue(outputValue) ,	// output [7:0] outputValue_sig
	.CLK(CLK) 	// input  CLK_sig
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
	reset = 1;
	
	#(2*HALF_PERIOD);
	if (outputValue != 0) begin
			 failures = failures + 1;
			 $display("%t (COUNT UP) Error at cycle %d, output = %d, expecting = %d", $time, cycle_counter, outputValue, 0);
		end
	reset = 0;
	#(2*HALF_PERIOD);
	
	
	inputValue = 0;
	//-----TEST 1-----
	//Testing counting up 
	$display("Testing counting up.");
	reset = 1;
	counter = 0;
	cycle_counter = 0;
	inputValue = 0;
	#(2*HALF_PERIOD);
	reset = 0;
	repeat (128) begin
		inputValue = inputValue + 1;
		#(2*HALF_PERIOD);
		counter = counter + 1;
		cycle_counter = cycle_counter + 1;
		if (outputValue != counter) begin
			 failures = failures + 1;
			 $display("%t (COUNT UP) Error at cycle %d, output = %d, expecting = %d", $time, cycle_counter, outputValue, counter);
		end
	end
	
	#(2*HALF_PERIOD);
	reset = 1;
	#(2*HALF_PERIOD);
	if (outputValue != 0) begin
			 failures = failures + 1;
			 $display("%t (COUNT UP) Error at cycle %d, output = %d, expecting = %d", $time, cycle_counter, outputValue, 0);
		end
	$stop;
	
end

endmodule
