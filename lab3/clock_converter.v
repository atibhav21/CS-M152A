module clock_converter(clk, rst, one_hertz_clk, two_hertz_clk, fast_clk, blink_clk);
	input clk, rst;
	
	output reg one_hertz_clk;
	output reg two_hertz_clk;
	output reg fast_clk;
	output reg blink_clk;
	
	
	reg [25:0] counter_one_hertz;
	reg [24:0] counter_two_hertz;
	reg [18:0] counter_fast;
	reg [25:0] counter_blink;
	
	always @(posedge clk) begin
		if(rst) begin
			counter_one_hertz <= 26'd0;
			one_hertz_clk <= 0;
			
			counter_two_hertz <= 25'd0;
			two_hertz_clk <= 0;
			
			counter_fast <= 19'd0;
			fast_clk <= 0;
			
			counter_blink <= 26'd0;
			blink_clk <= 0;
		end
		else begin 
			// maintain one hertz clock
			if(counter_one_hertz == 26'd49999999) begin
				counter_one_hertz <= 0;
				one_hertz_clk <= ~ one_hertz_clk;
			end
			else begin
				counter_one_hertz <= counter_one_hertz + 1;
			end
			
			// Mantain two hertz clock
			if(counter_two_hertz == 25'd24999999) begin
				counter_two_hertz <= 0;
				two_hertz_clk <= ~ two_hertz_clk;
			end
			else begin
				counter_two_hertz <= counter_two_hertz + 1;
			end
			
			// Mantain fast clock at 400 Hz
			if(counter_fast == 19'd124999) begin
				counter_fast <= 0;
				fast_clk <= ~fast_clk;
			end
			else begin 
				counter_fast <= counter_fast + 1;
			end
			
			// Mantain blink clock at 4 Hz
			if(counter_blink == 26'd12499999) begin
				counter_blink <= 0;
				blink_clk <= ~blink_clk;
			end
			else begin 
				counter_blink <= counter_blink + 1;
			end
		end
	end
endmodule
