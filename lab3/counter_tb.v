`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:43:05 11/02/2017
// Design Name:   counter
// Module Name:   C:/Users/152/Documents/counter_tester/counter_tb.v
// Project Name:  counter_tester
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	// Inputs
	reg one_hertz_clk;
	reg two_hertz_clk;
	reg pause;
	reg reset;
	reg adj;
	reg select;

	// Outputs
	wire [3:0] minutes_tens;
	wire [3:0] minutes_ones;
	wire [3:0] seconds_tens;
	wire [3:0] seconds_ones;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.one_hertz_clk(one_hertz_clk), 
		.two_hertz_clk(two_hertz_clk), 
		.pause(pause), 
		.reset(reset), 
		.adj(adj), 
		.select(select), 
		.minutes_tens(minutes_tens), 
		.minutes_ones(minutes_ones), 
		.seconds_tens(seconds_tens), 
		.seconds_ones(seconds_ones)
	);

	initial begin
		// Initialize Inputs
		one_hertz_clk = 0;
		two_hertz_clk = 0;
		pause = 0;
		reset = 1;
		adj = 0;
		select = 0;

		// Wait 100 ns for global reset to finish
		#100;
		$display("%d%d:%d%d", minutes_tens, minutes_ones, seconds_tens, seconds_ones);
		// Add stimulus here
		reset = 0;
		
		#20
		repeat(100)
			#20
			$display("%d%d:%d%d", minutes_tens, minutes_ones, seconds_tens, seconds_ones);
		
		#20
		reset = 1;
		
		#20
		reset = 0;
		adj = 1;
		select = 1;
		
		#20
		repeat(100)
			#10
			$display("%d%d:%d%d", minutes_tens, minutes_ones, seconds_tens, seconds_ones);
		
		#20
		reset = 1;
		
		#20
		reset = 0;
		adj = 1;
		select = 0;
		
		#20
		repeat(100)
			#10
			$display("%d%d:%d%d", minutes_tens, minutes_ones, seconds_tens, seconds_ones);
		
		#20
		pause = 1;
		adj = 0;
		#20
		repeat(100)
			#10
			$display("%d%d:%d%d", minutes_tens, minutes_ones, seconds_tens, seconds_ones);
		
		#20 
		pause = 0;
		repeat(100)
			#20
			$display("%d%d:%d%d", minutes_tens, minutes_ones, seconds_tens, seconds_ones);
			
		#10000000
		$finish;
	end
	
	always 
		#10
		one_hertz_clk = ~ one_hertz_clk;
	
	always
		#5 
		two_hertz_clk = ~ two_hertz_clk;
      
endmodule

