module register8(
    input [7:0] inputValue,
    input reset,
	 input writeEnable,
    output [7:0] outputValue,
    input CLK
    );
	 
reg [7:0] val;

assign outputValue = val;

always @ (posedge(CLK))
begin
	
	if (reset == 1) begin 
		val = 0;
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
