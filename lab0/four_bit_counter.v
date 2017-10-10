module four_bit_counter(clk, rst, counter);
	input clk, rst;
	output reg [3:0] counter;
	wire intermediate_1, intermediate_2;
	
	assign intermediate_1 = counter[0] & counter[1];
	assign intermediate_2 = intermediate_1 & counter[2];
	
	always @(posedge clk) begin
		if(rst) begin
			counter[0] <= 1'b0;
			counter[1] <= 1'b0;
			counter[2] <= 1'b0;
			counter[3] <= 1'b0;
		end
		else begin 
			counter[0] <= ~ counter[0];
			counter[1] <= counter[1] ^ counter[0];
			counter[2] <= counter[2] ^ intermediate_1;
			counter[3] <= counter[3] ^ intermediate_2;
		end
	end
endmodule