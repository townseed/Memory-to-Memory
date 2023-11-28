module register16SP(
input [15:0] inputValue,
input reset,
input CLK,
input writeEnable,
output [15:0] outputValue
);

reg [15:0] val;

assign outputValue = val;

always @ (posedge(CLK))
begin
	
	if (reset == 1) begin 
		val = 'hfffd;
	end 
	else begin
		if(writeEnable == 1) begin
			val = inputValue;
		end
		else begin
			val = val;
		end
	end
end

endmodule
