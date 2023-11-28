module DietVilk(
input [15:0] inputValue,
output [15:0] outputValue,
input CLK,
input reset
);



stage_7 vvilk(
	.CLK(CLK),
	.reset(reset),
	.ioInput(inputValue),
	.ioOutput(outputValue)
	);
	
	
endmodule
	