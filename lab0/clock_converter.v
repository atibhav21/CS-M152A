module clock_converter(clk, rst, led);
	input clk, rst;
	reg [25:0] counter;
	output reg led;

	always @(posedge clk) begin
		if(rst) begin
			counter <= 0;
			led <= 0;
		end
		else begin 
          if(counter == 49999999) begin
				counter <= 0;
				led <= ~ led;
			end
			else begin
				counter <= counter + 1;
			end
		end
	end
endmodule