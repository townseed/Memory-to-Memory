module memoryio #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=16)(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output [(2*DATA_WIDTH-1):0] q,
	input reset,
	input [15:0] in,
	output [15:0] out
);
wire [15:0] q_m;



memory memory_inst
(
	.data_a(data_a) ,	// input [DATA_WIDTH-1:0] data_a_sig
	.data_b(data_b) ,	// input [DATA_WIDTH-1:0] data_b_sig
	.addr_a(addr_a) ,	// input [ADDR_WIDTH-1:0] addr_a_sig
	.addr_b(addr_b) ,	// input [ADDR_WIDTH-1:0] addr_b_sig
	.we_a(we_a) ,	// input  we_a_sig
	.we_b(we_b) ,	// input  we_b_sig
	.clk(clk) ,	// input  clk_sig
	.q_a(q_m[15:8]) ,	// output [DATA_WIDTH-1:0] q_a_sig
	.q_b(q_m[7:0]) 	// output [DATA_WIDTH-1:0] q_b_sig

);

//wire [15:0] outb, q_x;
//assign out  = outb;
//assign q = q_x;
assign q = (addr_a == 'hfffe) ? in : q_m;
assign out = (addr_a == 'hf010) ? {data_a,data_b} : 1'b0;
//
//always @(addr_a) begin
//		outb = 0;
//		q_x = q_m;
//        case(addr_a)
//			'hf010: 
//			 outb = {data_a,data_b};
//			'hfffe:
//			 q_x = in;
//         default: begin
//			 q_x = q_m;
//			 outb = 0;
//		end
//        endcase
//
//end


endmodule
