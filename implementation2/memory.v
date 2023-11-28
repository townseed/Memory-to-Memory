

// Quartus Prime Verilog Template
// True Dual Port RAM with single clock

module memory
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=11)
(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[0:2**ADDR_WIDTH-1];

	initial begin
		$readmemh("relprime.txt", ram);
	end
	
// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] <= data_a;
		end 
		q_a <= ram[addr_a];
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_b] <= data_b;
		end
		q_b <= ram[addr_b];
	end

endmodule

