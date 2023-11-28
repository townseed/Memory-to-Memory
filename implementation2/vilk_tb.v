
  module vilk_tb();

    //inputs
    reg rst, CLK;
    reg [15:0] IN;

    //outputs
   wire [15:0]  OUT;
	wire [15:0]  memOut;
	wire [15:0]  state;
	wire [7:0] op;

    DietVilk UUT (
        .reset(rst),
        .inputValue(IN),
        .outputValue(OUT),
        .CLK(CLK)
        );

    //block to run the clock
	 parameter HALF_PERIOD = 25 ;
	 parameter PERIOD = 50;
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
			
        rst = 1;
        #(2*HALF_PERIOD);
			IN = 'h13b0;
        rst = 0;
        @(OUT != 0);
		  $display("input = %d, output = %d", IN, OUT);
        #(PERIOD);

        $stop;
    end
	 
	 always @(posedge CLK) begin
	counter = counter + 1;
	if (state  == 0) begin
		instructions = instructions + 1;
	end
end
	 
    endmodule
	 