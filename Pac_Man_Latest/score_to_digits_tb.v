`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:10:24 11/25/2017
// Design Name:   score_to_digits
// Module Name:   C:/CSM152A/Pac_Man/score_to_digits_tb.v
// Project Name:  Pac_Man
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: score_to_digits
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module score_to_digits_tb;

	// Inputs
	reg [13:0] score;

	// Outputs
	wire [3:0] thousands;
	wire [3:0] hundreds;
	wire [3:0] tens;
	wire [3:0] ones;

	// Instantiate the Unit Under Test (UUT)
	score_to_digits uut (
		.score(score), 
		.thousands(thousands), 
		.hundreds(hundreds), 
		.tens(tens), 
		.ones(ones)
	);

	initial begin
		// Initialize Inputs
		score = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while ( score  < 10000) begin
		#10; 
		score = score + 1;
		
		end
		$finish;
	end
      
endmodule

