module alutest();

reg CLK; // the clock signal
reg signed [15:0] inputA;
reg signed [15:0] inputB;
reg [3:0] operation;
wire [0:0] isTrue;
wire signed [15:0] outputValue;


alu UUT
(
	.A(inputA) ,	
	.B(inputB),
	.ALUOp(operation),
	.outputValue(outputValue) ,
	.isTrue(isTrue),
	.CLK(CLK)
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
	#(2*HALF_PERIOD);
	
	
	//test addition
	inputA = 0;
	inputB = 0;
	operation = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 0) begin
			failures = failures + 1;
			$display("operation %d + %d returned %d", inputA, inputB, outputValue);
	end
	#(2*HALF_PERIOD);
	inputA = 100;
	inputB = 30;
	operation = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 130) begin
			failures = failures + 1;
			$display("operation %d + %b returned %c", inputA, inputB, outputValue);
	end
	#(2*HALF_PERIOD);
	inputA = -1;
	inputB = 5;
	operation = 0;
	#(2*HALF_PERIOD);
	
	if(outputValue != 4) begin
			failures = failures + 1;
			$display("operation %d + %b returned %c", inputA, inputB, outputValue);
	end
	
	
	//test subtraction
	#(2*HALF_PERIOD);
	inputA = 55;
	inputB = 5;
	operation = 1;
	#(2*HALF_PERIOD);
	
	if(outputValue != 50) begin
			failures = failures + 1;
			$display("operation %d - %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = -1;
	inputB = 5;
	operation = 1;
	#(2*HALF_PERIOD);
	
	if(outputValue != -6) begin
			failures = failures + 1;
			$display("operation %d - %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 20;
	inputB = 20;
	operation = 1;
	#(2*HALF_PERIOD);
	
	if(outputValue != 0) begin
			failures = failures + 1;
			$display("operation %d - %b returned %c", inputA, inputB, outputValue);
	end
	
	
	//test logical or
	#(2*HALF_PERIOD);
	inputA = 16'b0000000000000000;
	inputB = 16'b0000000000000000;
	operation = 2;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0000000000000000) begin
			failures = failures + 1;
			$display("operation %d or %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b1111111111111111;
	inputB = 16'b0000000000000000;
	operation = 2;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b1111111111111111) begin
			failures = failures + 1;
			$display("operation %d or %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b1010101010101010;
	inputB = 16'b0101010101010101;
	operation = 2;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b1111111111111111) begin
			failures = failures + 1;
			$display("operation %d or %b returned %c", inputA, inputB, outputValue);
	end
	
	//test logical and
	#(2*HALF_PERIOD);
	inputA = 16'b1010101010101010;
	inputB = 16'b0101010101010101;
	operation = 3;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0000000000000000) begin
			failures = failures + 1;
			$display("operation %d and %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b1111111111111111;
	inputB = 16'b0101010101010101;
	operation = 3;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0101010101010101) begin
			failures = failures + 1;
			$display("operation %d and %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b1111111010101010;
	inputB = 16'b0101010111111111;
	operation = 3;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0101010010101010) begin
			failures = failures + 1;
			$display("operation %d and %b returned %c", inputA, inputB, outputValue);
	end
	
	//test logical xor
	
	#(2*HALF_PERIOD);
	inputA = 16'b1111111111111111;
	inputB = 16'b1111111111111111;
	operation = 4;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0000000000000000) begin
			failures = failures + 1;
			$display("operation %d xor %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b1111111111111111;
	inputB = 16'b0000000000000000;
	operation = 4;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b1111111111111111) begin
			failures = failures + 1;
			$display("operation %d xor %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b1011111111000000;
	inputB = 16'b1111000000111111;
	operation = 4;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0100111111111111) begin
			failures = failures + 1;
			$display("operation %d xor %b returned %c", inputA, inputB, outputValue);
	end
	
	//test shift left
	
	#(2*HALF_PERIOD);
	inputA = 16'b1111111111111111;
	inputB = 5;
	operation = 5;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b1111111111100000) begin
			failures = failures + 1;
			$display("operation %d << %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b0000000000000001;
	inputB = 10;
	operation = 5;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0000010000000000) begin
			failures = failures + 1;
			$display("operation %d << %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b0000000010000000;
	inputB = 5;
	operation = 5;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0001000000000000) begin
			failures = failures + 1;
			$display("operation %d << %b returned %c", inputA, inputB, outputValue);
	end
	
	//test shift right
	#(2*HALF_PERIOD);
	inputA = 16'b1111111111100000;
	inputB = 5;
	operation = 6;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0000011111111111) begin
			failures = failures + 1;
			$display("operation %d >> %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b0000010000000000;
	inputB = 10;
	operation = 6;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0000000000000001) begin
			failures = failures + 1;
			$display("operation %d >> %b returned %c", inputA, inputB, outputValue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 16'b0001000000000000;
	inputB = 5;
	operation = 6;
	#(2*HALF_PERIOD);
	
	if(outputValue != 16'b0000000010000000) begin
			failures = failures + 1;
			$display("operation %d >> %b returned %c", inputA, inputB, outputValue);
	end
	
	//test comparisons
	//test equal
	
	#(2*HALF_PERIOD);
	inputA = 5;
	inputB = 5;
	operation = 7;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d == %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 0;
	inputB = 0;
	operation = 7;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d == %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = -1;
	inputB = -1;
	operation = 7;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d == %b returned %c", inputA, inputB, isTrue);
	end
	
	//test not equal
	#(2*HALF_PERIOD);
	inputA = 1;
	inputB = 5;
	operation = 8;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d != %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 1;
	inputB = -1;
	operation = 8;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d != %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 0;
	inputB = 69;
	operation = 8;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d != %b returned %c", inputA, inputB, isTrue);
	end
	
	//test less than
	#(2*HALF_PERIOD);
	inputA = 1;
	inputB = 5;
	operation = 9;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d < %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 0;
	inputB = 30;
	operation = 9;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d < %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = -100;
	inputB = 5;
	operation = 9;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d < %d returned %d", inputA, inputB, isTrue);
	end
	
	//test >=
	
	#(2*HALF_PERIOD);
	inputA = 10;
	inputB = 5;
	operation = 10;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d >= %d returned %d", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 10;
	inputB = -1;
	operation = 10;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d >= %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 1;
	inputB = 1;
	operation = 10;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d >= %b returned %c", inputA, inputB, isTrue);
	end
	
	//test <=
	
	#(2*HALF_PERIOD);
	inputA = 0;
	inputB = 5;
	operation = 11;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d <= %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 10;
	inputB = 500;
	operation = 11;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d <= %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 5;
	inputB = 5;
	operation = 11;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d <= %b returned %c", inputA, inputB, isTrue);
	end
	
	//test Greater than
	
	#(2*HALF_PERIOD);
	inputA = 10;
	inputB = 5;
	operation = 12;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d > %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 0;
	inputB = -5;
	operation = 12;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d > %b returned %c", inputA, inputB, isTrue);
	end
	
	#(2*HALF_PERIOD);
	inputA = 69;
	inputB = 3;
	operation = 12;
	#(2*HALF_PERIOD);
	
	if(isTrue != 1) begin
			failures = failures + 1;
			$display("operation %d > %b returned %c", inputA, inputB, isTrue);
	end
	
	$display("Tests complete. %d total failures.", failures);
	
	$stop;
	
end
endmodule
