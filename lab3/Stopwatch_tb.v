`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:22:34 11/07/2017
// Design Name:   Stopwatch
// Module Name:   E:/Lab3/Stopwatch/Stopwatch_tb.v
// Project Name:  Stopwatch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Stopwatch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Stopwatch_tb;

	// Inputs
	reg clk;
	reg reset;
	reg adj;
	reg select;
	reg pause;

	// Outputs
	reg [7:0] segments;
	reg [3:0] enables;

	// Instantiate the Unit Under Test (UUT)
	Stopwatch uut (
		.clk(clk), 
		.reset(reset), 
		.adj(adj), 
		.select(select), 
		.pause(pause), 
		.segments(segments), 
		.enables(enables)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		adj = 0;
		select = 0;
		pause = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	reset = 1;
	#100;
	reset = 0;
	#400;
	
	end
      
endmodule

