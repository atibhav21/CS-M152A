module clock_divider(clk, rst, two_hertz_clk, fast_clk, four_megahertz_clk);
	input clk, rst;

	output reg two_hertz_clk;
	output reg fast_clk;
	output reg four_megahertz_clk;
	
	reg [24:0] counter_two_hertz;
	reg [18:0] counter_fast;
	reg 	   counter_four_mhz_clk;
	
	always @(posedge clk) begin
		if(rst) begin			
			counter_two_hertz <= 25'd0;
			two_hertz_clk <= 0;
			
			counter_fast <= 19'd0;
			fast_clk <= 0;

			counter_four_mhz_clk <= 1'd0;
			four_megahertz_clk <= 0;
		end
		else begin 
			
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

			if(counter_four_mhz_clk == 1'd1) begin
				counter_four_mhz_clk <= 0;
				four_megahertz_clk <= ~four_megahertz_clk;
			end
			else begin
				counter_four_mhz_clk = counter_four_mhz_clk + 1;
			end
		end
	end
endmodule
