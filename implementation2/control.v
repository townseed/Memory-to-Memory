module control (writeOp, writeA, writeB, writeDest, writePC, writeSP, writeMem, valA, memWriteData,
					 inputPC, regOrPC, ALUOp, ALUSrcA, ALUSrcB, memAddr, branch, Opcode, CLK, RST);
					 
input [7:0] Opcode;
input CLK;
input RST;

output writeOp;
output writeA;
output writeB;
output writeDest;
output writePC;
output writeSP;
output writeMem;
output valA;
output [1:0] memWriteData;
output inputPC;
output regOrPC;
output [3:0] ALUOp;
output [1:0] ALUSrcA;
output [1:0] ALUSrcB;
output [1:0] memAddr;
output branch;

reg writeOp;
reg writeA;
reg writeB;
reg writeDest;
reg writePC;
reg writeSP;
reg writeMem;
reg valA;
reg [1:0] memWriteData;
reg inputPC;
reg regOrPC;
reg [3:0] ALUOp;
reg [1:0] ALUSrcA;
reg [1:0] ALUSrcB;
reg [1:0] memAddr;
reg branch;

integer State = 0;


always @ (posedge CLK)
begin
	writeOp = 1'b0;
	writeA = 1'b0;
	writeB = 1'b0;
	writeDest = 1'b0;
	writePC = 1'b0;
	writeSP = 1'b0;
	writeMem = 1'b0;
	valA = 1'b0;
	memWriteData = 2'b00;
	inputPC = 1'b0;
	regOrPC = 1'b0;
	ALUOp = 4'b0000;
	ALUSrcA = 2'b00;
	ALUSrcB = 2'b00;
	memAddr = 2'b00;
	branch = 1'b0;
	
	if (RST == 1) begin
		writeOp = 1'b0;
		writeA = 1'b0;
		writeB = 1'b0;
		writeDest = 1'b0;
		writePC = 1'b0;
		writeSP = 1'b0;
		writeMem = 1'b0;
		valA = 1'b0;
		memWriteData = 2'b00;
		inputPC = 1'b0;
		regOrPC = 1'b0;
		ALUOp = 4'b0000;
		ALUSrcA = 2'b00;
		ALUSrcB = 2'b00;
		memAddr = 2'b00;
		branch = 1'b0;
	end else begin
		case (State)
			0:
				begin
					writeOp = 1'b1;
					writePC = 1'b1;
					ALUSrcA = 2'b01;
					ALUSrcB = 2'b01;
					ALUOp = 4'b0000;
					regOrPC = 1'b0;
					inputPC = 1'b0;
				end
			1:
				begin
					writeA = 1'b1;
					writePC = 1'b1;
					ALUSrcA = 2'b01;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0000;
					regOrPC = 1'b0;
					inputPC = 1'b0;
					valA = 1'b0;
				end
			2:
				begin
					writeB = 1'b1;
					writePC = 1'b1;
					ALUSrcA = 2'b01;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0000;
					regOrPC = 1'b0;
					inputPC = 1'b0;
				end
			3:
				begin
					writeA = 1;
					regOrPC = 1;
					memAddr = 'b00;
					valA = 'b0;
				end
			4:
				begin
					writeB = 1'b1;
					regOrPC = 1'b1;
					memAddr = 2'b01;
				end
			5:
				begin
					ALUSrcA = 2'b00;
					ALUSrcB = 2'b00;
					if (Opcode == 8'b00000000 || Opcode == 8'b10000000) begin
						ALUOp = 4'b0000;
					end else if (Opcode == 8'b01100000) begin
						ALUOp = 4'b0001;
					end else if (Opcode == 8'b00000001 || Opcode == 8'b10000001) begin
						ALUOp = 4'b0010;
					end else if (Opcode == 8'b00000010 || Opcode == 8'b10000010) begin
						ALUOp = 4'b0011;
					end else if (Opcode == 8'b00000100 || Opcode == 8'b10000100) begin
						ALUOp = 4'b0100;
					end else if (Opcode == 8'b00111100 || Opcode == 8'b01111100) begin
						ALUOp = 4'b0101;
					end else if (Opcode == 8'b00111110 || Opcode == 8'b00111000) begin
						ALUOp = 4'b0110;
					end
					regOrPC = 1'b0;
					writeDest = 1'b1;
				end
			6:
				begin
					writePC = 1'b1;
					writeMem = 1'b1;
					ALUSrcA = 2'b01;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0000;
					memWriteData = 2'b01;
					regOrPC = 1'b1;
					inputPC = 1'b0;
					memAddr = 2'b10;
				end
			7:
				begin
					writePC = 1'b1;
					writeDest = 1'b1;
					ALUSrcA = 2'b01;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0000;
					regOrPC = 1'b0;
					inputPC = 1'b0;
				end
			8:
				begin
					writePC = 1'b0;
					ALUSrcA = 2'b00;
					ALUSrcB = 2'b00;
					if (Opcode == 8'b00110000 || Opcode == 8'b10110000) begin
						ALUOp = 4'b0111;
					end else if (Opcode == 8'b00111010 || Opcode == 8'b10111010) begin
						ALUOp = 4'b1001;
					end else if (Opcode == 8'b00111001 || Opcode == 8'b10111001) begin
						ALUOp = 4'b1000;
					end else if (Opcode == 8'b00110100 || Opcode == 8'b10110100) begin
						ALUOp = 4'b1010;
					end else if (Opcode == 8'b10100100) begin
						ALUOp = 4'b1100;
					end else if (Opcode == 8'b10101100) begin
						ALUOp = 4'b1011;
					end
					branch = 1'b1;
				end
			9:
				begin
					writePC = 1'b1;
					inputPC = 1'b1;
	
				end
			10:
				begin
					writeB = 1'b1;
					writeSP = 1'b1;
					ALUSrcA = 2'b10;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0001;
					regOrPC = 1'b1;
					memAddr = 2'b00;

				end
			11:
				begin
					writeMem = 1'b1;
					regOrPC = 1'b1;
					memAddr = 2'b11;
					memWriteData = 2'b00;

				end
			12:
				begin
					writeB = 1'b1;
					memAddr = 2'b11;
					regOrPC = 1'b1;

				end
			13:
				begin
					writeSP = 1'b1;
					writeMem = 1'b1;
					ALUSrcA = 2'b10;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0000;
					memWriteData = 2'b00;
					regOrPC = 1'b1;
					memAddr = 2'b00;

				end
			14:
				begin
					writeSP = 1'b1;
					ALUSrcA = 2'b10;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0001;
				end
			15:
				begin
					writeA = 1'b1;
					ALUSrcA = 2'b01;
					ALUSrcB = 2'b01;
					ALUOp = 4'b0000;
					valA = 1'b1;

				end
			16:
				begin
					writePC = 1'b1;
					writeMem = 1'b1;
					memAddr = 2'b11;
					ALUSrcA = 2'b01;
					ALUSrcB = 2'b10;
					ALUOp = 4'b0001;
					memWriteData = 2'b10;
					regOrPC = 1'b1;
					inputPC = 1'b0;
				end
			17:
				begin
					writeMem = 1'b1;
					regOrPC = 1'b1;
					memWriteData = 2'b10;
					memAddr = 2'b01;
				end
			default: ;
		endcase
	end
end
always @ (negedge CLK)
begin
	if (RST == 1) begin
		State = 0;
	end else begin
		case (State)
			0:
				begin
					State = 1;	
				end
			1:
				begin
					if (Opcode == 8'b00000000 || Opcode == 8'b01100000 || Opcode == 8'b00000001 || Opcode == 8'b00000010 ||
						 Opcode == 8'b00000100 || Opcode == 8'b00111110 || Opcode == 8'b00111100 || Opcode == 8'b00111000 ||
						 Opcode == 8'b01111100 || Opcode == 8'b10000000 || Opcode == 8'b10000010 || Opcode == 8'b10000001 ||
						 Opcode == 8'b10000100 || Opcode == 8'b00110000 || Opcode == 8'b00111010 || Opcode == 8'b00111001 ||
						 Opcode == 8'b00110100 || Opcode == 8'b10110000 || Opcode == 8'b10111010 || Opcode == 8'b10111001 ||
						 Opcode == 8'b10110100 || Opcode == 8'b10100100 || Opcode == 8'b10101100 || Opcode == 8'b10111111) begin
						State = 2;
					end else if (Opcode == 8'b00100000) begin
						State = 3;
					end else if (Opcode == 8'b10100000) begin
						State = 9;
					end else if (Opcode == 8'b01011111) begin
						State = 10;
					end else if (Opcode == 8'b01011110) begin
						State = 12;
					end else if (Opcode == 8'b01111111) begin
						State = 14;
					end
				end
			2:
				begin
					if (Opcode == 8'b00000000 || Opcode == 8'b01100000 || Opcode == 8'b00000001 || Opcode == 8'b00000010 ||
						 Opcode == 8'b00000100 || Opcode == 8'b00111110 || Opcode == 8'b00111100 || Opcode == 8'b00111000 ||
						 Opcode == 8'b01111100 || Opcode == 8'b10000000 || Opcode == 8'b10000010 || Opcode == 8'b10000001 ||
						 Opcode == 8'b10000100 || Opcode == 8'b00110000 || Opcode == 8'b00111010 || Opcode == 8'b00111001 ||
						 Opcode == 8'b00110100 || Opcode == 8'b10110000 || Opcode == 8'b10111010 || Opcode == 8'b10111001 ||
						 Opcode == 8'b10110100 || Opcode == 8'b10100100 || Opcode == 8'b10101100) begin
						State = 3;
					end else if (Opcode == 8'b10111111) begin
						State = 17;
					end
				end
			3:
				begin
					if (Opcode == 8'b00000000 || Opcode == 8'b01100000 || Opcode == 8'b00000001 || Opcode == 8'b00000010 ||
						 Opcode == 8'b00000100 || Opcode == 8'b00111110 || Opcode == 8'b00111100 || Opcode == 8'b00110000 ||
						 Opcode == 8'b00111010 || Opcode == 8'b00111001 || Opcode == 8'b00110100) begin
						State = 4;
					end else if (Opcode == 8'b00111000 || Opcode == 8'b01111100 || Opcode == 8'b10000000 || Opcode == 8'b10000010 ||
									 Opcode == 8'b10000001 || Opcode == 8'b10000100) begin
						State = 5;
					end else if (Opcode == 8'b10110000 || Opcode == 8'b10111010 || Opcode == 8'b10111001 || Opcode == 8'b10110100 ||
									 Opcode == 8'b10100100 || Opcode == 8'b10101100) begin
						State = 7;
					end else if (Opcode == 8'b00100000) begin
						State = 9;
					end
				end
			4:
				begin
					if (Opcode == 8'b00000000 || Opcode == 8'b01100000 || Opcode == 8'b00000001 || Opcode == 8'b00000010 ||
						 Opcode == 8'b00000100 || Opcode == 8'b00111110 || Opcode == 8'b00111100) begin
						State = 5;
					end else if (Opcode == 8'b00110000 || Opcode == 8'b00111010 || Opcode == 8'b00111001 || Opcode == 8'b00110100) begin
						State = 7;
					end
				end
			5:
				begin
					State = 6;
				end
			6:
				begin
					State = 0;
				end
			7:
				begin
					State = 8;
				end
			8:
				begin
					State = 0;
				end
			9:
				begin
					State = 0;
				end
			10:
				begin
					State = 11;
				end
			11:
				begin
					State = 0;
				end
			12:
				begin
					State = 13;
				end
			13:
				begin
					State = 0;
				end
			14:
				begin
					State = 15;
				end
			15:
				begin

					State = 16;
				end
			16:
				begin
					State = 0;
				end
			17:
				begin
					State = 0;
				end
			default:
				State = 0;
		endcase

	end

end

endmodule
