module stage_7_tb();

reg CLK; // the clock signal
reg reset;

wire [15:0] MemOut;
wire [15:0] state;

stage_7 stage_7_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.reset(reset) ,	// input  reset_sig
	.MemOut(MemOut),
	.state(state)
);

parameter HALF_PERIOD = 25;
integer counter = 0;
integer failures = 0;
integer instructions = 0;


initial begin
    CLK = 1;
    forever begin
        #(HALF_PERIOD);
        CLK = ~CLK;
    end
end

initial begin
	reset = 1;
	#(2*HALF_PERIOD);
	reset=0;
end

always @(posedge CLK) begin
	counter = counter + 1;
	if (state  == 0) begin
		instructions = instructions + 1;
	end
end

endmodule
