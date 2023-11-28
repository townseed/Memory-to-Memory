module alu(
input signed [15:0] A,
input signed [15:0] B,
input [3:0] ALUOp,
output signed [15:0] outputValue,
output isTrue
);


reg [15:0] ALU_Result;
reg isTrue_val;
    assign outputValue = ALU_Result;
	 assign isTrue = isTrue_val; // ALU out
    always @(A or B or ALUOp)
    begin
		ALU_Result = A + B;
		isTrue_val = 1;
        case(ALUOp)
			4'b0000: // Addition
				ALU_Result = A + B ; 
			4'b0001: // Subtraction
				ALU_Result = A - B ;
			4'b0010: //  Logical or
				ALU_Result = A | B;
			4'b0011: //  Logical and 
				ALU_Result = A & B;
			4'b0100: //  Logical xor 
				ALU_Result = A ^ B;
			4'b0101: // Logical shift left
				ALU_Result = A<<B;
         4'b0110: // Logical shift right
				ALU_Result = A>>B;
			4'b0111: // Equal comparison   
            isTrue_val = (A==B)? 1'b1:1'b0 ;
			4'b1000: // Equal comparison   
            isTrue_val = (A!=B)? 1'b1:1'b0 ;
			4'b1001: // Equal comparison   
            isTrue_val = (A<B)? 	1'b1:1'b0 ;
			4'b1010: // Equal comparison   
            isTrue_val = (A>=B)? 1'b1:1'b0 ;
			4'b1011: // Equal comparison   
            isTrue_val = (A<=B)? 1'b1:1'b0 ;
			4'b1100: // Greater comparison
				isTrue_val = (A>B)? 	1'b1:1'b0 ;
         default: ALU_Result = A + B ; 
        endcase
		end
  endmodule 
