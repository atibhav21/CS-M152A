`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:21:06 11/03/2017
// Design Name:   Display
// Module Name:   C:/Users/152/Documents/Lab3/Stopwatch/Display_tb.v
// Project Name:  Stopwatch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Display_tb;

	// Inputs
	reg fast_clk;
	reg blink_clk;
	reg [3:0] minutes_tens;
	reg [3:0] minutes_ones;
	reg [3:0] seconds_tens;
	reg [3:0] seconds_ones;
	reg adj;
	reg select;

	// Outputs
	wire [7:0] segments;
	wire [3:0] enables;

	integer i;
	// Instantiate the Unit Under Test (UUT)
	Display uut (
		.fast_clk(fast_clk), 
		.blink_clk(blink_clk), 
		.minutes_tens(minutes_tens), 
		.minutes_ones(minutes_ones), 
		.seconds_tens(seconds_tens), 
		.seconds_ones(seconds_ones), 
		.adj(adj), 
		.select(select), 
		.segments(segments), 
		.enables(enables)
	);

	initial begin
		// Initialize Inputs
		fast_clk = 0;
		blink_clk = 0;
		minutes_tens = 0;
		minutes_ones = 0;
		seconds_tens = 0;
		seconds_ones = 0;
		adj = 0;
		select = 0;

		// Wait 100 ns for global reset to finish
		#100;
		minutes_tens = 0;
		minutes_ones = 0;
		seconds_tens = 0;
		seconds_ones = 0;
		// Add stimulus here
		/*for (i = 0; i < ; i=i+1) begin

			if (seconds_ones == 9) begin
				seconds_ones = 0;
				if (seconds_tens == 9) begin
					minutes_ones = 0;
				if (minutes_ones 
				end
			end
		end*/
	end
      
always
	#5 fast_clk = ~fast_clk;

always 
	#20 blink_clk = ~blink_clk;
endmodule

