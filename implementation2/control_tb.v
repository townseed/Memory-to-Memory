`timescale 1ns/1ps

module control_tb();

reg [7:0] op;
reg CLK;
reg RST;

wire writeOp;
wire writeA;
wire writeB;
wire writeDest;
wire writePC;
wire writeSP;
wire writeMem;
wire valA;
wire [1:0] memWriteData;
wire inputPC;
wire regOrPC;
wire [3:0] ALUOp;
wire [1:0] ALUSrcA;
wire [1:0] ALUSrcB;
wire [1:0] memAddr;
wire branch;

control UUT (.writeOp(writeOp), .writeA(writeA), .writeB(writeB), .writeDest(writeDest), .writePC(writePC), .writeSP(writeSP),
				 .writeMem(writeMem), .valA(valA), .memWriteData(memWriteData), .inputPC(inputPC), .regOrPC(regOrPC), .ALUOp(ALUOp),
				 .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .memAddr(memAddr), .branch(branch), .Opcode(op), .CLK(CLK), .RST(RST));
				 
parameter HALF_PERIOD = 50;
parameter PERIOD = HALF_PERIOD * 2;
integer failures = 0;

initial begin
	CLK = 0;
	forever begin
		#(HALF_PERIOD);
		CLK = ~CLK;
	end
end

initial begin
	RST = 1;
	#(HALF_PERIOD);
	RST = 0;
	
	// Test A type
	op = 8'b00000000;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for A type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for A type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 2 failed for A type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b00 && valA == 1'b0)) begin
		$display("Cycle 3 failed for A type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b01)) begin
		$display("Cycle 4 failed for A type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(ALUSrcA == 2'b00 && ALUSrcB == 2'b00 && ALUOp == 4'b0000 && regOrPC == 1'b0 && writeDest == 1'b1)) begin
		$display("Cycle 5 failed for A type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b1 && writeMem == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && memWriteData == 2'b01 && regOrPC == 1'b1 && inputPC == 1'b0 && memAddr == 2'b10)) begin
		$display("Cycle 6 failed for A type");
		failures = failures + 1;
	end
	

	// Test AI type
	op = 8'b10000001;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for AI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for AI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 2 failed for AI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b00 && valA == 1'b0)) begin
		$display("Cycle 3 failed for AI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(ALUSrcA == 2'b00 && ALUSrcB == 2'b00 && ALUOp == 4'b0010 && regOrPC == 1'b0 && writeDest == 1'b1)) begin
		$display("Cycle 5 failed for AI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b1 && writeMem == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && memWriteData == 2'b01 && regOrPC == 1'b1 && inputPC == 1'b0 && memAddr == 2'b10)) begin
		$display("Cycle 6 failed for AI type");
		failures = failures + 1;
	end
	
	// Test BR type
	op = 8'b00110000;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for BR type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for BR type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 2 failed for BR type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b00 && valA == 1'b0)) begin
		$display("Cycle 3 failed for BR type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b01)) begin
		$display("Cycle 4 failed for BR type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b1 && writeDest == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 7 failed for BR type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b0 && ALUSrcA == 2'b00 && ALUSrcB == 2'b00 && ALUOp == 4'b0111 && branch == 1'b1)) begin
		$display("Cycle 8 failed for BR type");
		failures = failures + 1;
	end

	// Test BRI type
	op = 8'b10111001;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for BRI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for BRI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 2 failed for BRI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b00 && valA == 1'b0)) begin
		$display("Cycle 3 failed for BRI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b1 && writeDest == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 7 failed for BRI type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b0 && ALUSrcA == 2'b00 && ALUSrcB == 2'b00 && ALUOp == 4'b1000 && branch == 1'b1)) begin
		$display("Cycle 8 failed for BRI type");
		failures = failures + 1;
	end

	// Test J type
	op = 8'b10100000;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for J type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for J type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b1 && inputPC == 1'b1)) begin
		$display("Cycle 9 failed for J type");
		failures = failures + 1;
	end
	
	// Test JA type
	op = 8'b00100000;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for JA type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for JA type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b00 && valA == 1'b0)) begin
		$display("Cycle 3 failed for JA type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b1 && inputPC == 1'b1)) begin
		$display("Cycle 9 failed for JA type");
		failures = failures + 1;
	end

	// Test push
	op = 8'b01011111;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for JA push");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for JA push");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && writeSP == 1'b1 && ALUSrcA == 2'b10 && ALUSrcB == 2'b10 && ALUOp == 4'b0001 && regOrPC == 1'b1 && memAddr == 2'b00)) begin
		$display("Cycle 10 failed for JA push");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeMem == 1'b1 && memAddr == 2'b11 && memWriteData == 2'b00 && regOrPC == 1'b1)) begin
		$display("Cycle 11 failed for JA push");
		failures = failures + 1;
	end

	// Test pop
	op = 8'b01011110;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for JA pop");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for JA pop");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && regOrPC == 1'b1 && memAddr == 2'b11)) begin
		$display("Cycle 12 failed for JA pop");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeSP == 1'b1 && writeMem == 1'b1 && ALUSrcA == 2'b10 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && memWriteData == 2'b00 && regOrPC == 1'b1 && memAddr == 2'b00)) begin
		$display("Cycle 13 failed for JA pop");
		failures = failures + 1;
	end

	// Test SP type
	op = 8'b01111111;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for SP type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for SP type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeSP == 1'b1 && ALUSrcA == 2'b10 && ALUSrcB == 2'b10 && ALUOp == 4'b0001)) begin
		$display("Cycle 14 failed for SP type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && valA == 1'b1)) begin
		$display("Cycle 15 failed for SP type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writePC == 1'b1 && writeMem == 1'b1 && memAddr == 2'b11 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0001 && memWriteData == 2'b10 && regOrPC == 1'b1 && inputPC == 1'b0)) begin
		$display("Cycle 16 failed for JA type");
		failures = failures + 1;
	end

	// Test L type
	op = 8'b10111111;
	#(PERIOD);
	if (~(writeOp == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b01 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 0 failed for L type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeA == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0 && valA == 1'b0)) begin
		$display("Cycle 1 failed for L type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeB == 1'b1 && writePC == 1'b1 && ALUSrcA == 2'b01 && ALUSrcB == 2'b10 && ALUOp == 4'b0000 && regOrPC == 1'b0 && inputPC == 1'b0)) begin
		$display("Cycle 2 failed for L type");
		failures = failures + 1;
	end
	#(PERIOD);
	if (~(writeMem == 1'b1 && regOrPC == 1'b1 && memWriteData == 2'b10 && memAddr == 2'b01)) begin
		$display("Cycle 17 failed for L type");
		failures = failures + 1;
	end
	

	// Test Reset
	RST = 1;
	#(PERIOD);
	if(~(writeOp == 1'b0 && writeA == 1'b0 && writeB == 1'b0 && writeDest == 1'b0 && writePC == 1'b0 && writeSP == 1'b0 && writeMem == 1'b0 && valA == 1'b0 && memWriteData == 2'b00 && inputPC == 1'b0 && regOrPC == 1'b0 && ALUOp == 4'b0000 && ALUSrcA == 2'b00 && ALUSrcB == 2'b00 && memAddr == 2'b00 && branch == 1'b0)) begin
		$display("Reset failed");
		failures = failures + 1;
	end
	
	if (failures > 0) begin
		$display("%d failures", failures);
	end else begin
		$display("All tests passed");
	end
	
	$stop;
	
end

endmodule
