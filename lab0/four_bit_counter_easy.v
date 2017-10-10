module four_bit_counter(clk, rst, counter);
	input clk, rst;
	output reg [3:0] counter;

	always @(posedge clk) begin
		if(rst) begin
			counter <= 4'b0000;
		end
		else begin 
			counter <= counter + 1'b1;
		end
	end
endmodule