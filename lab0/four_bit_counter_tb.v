`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:37:31 10/03/2017
// Design Name:   four_bit_counter
// Module Name:   C:/Users/152/lab0_part_2/four_bit_counter_tb.v
// Project Name:  lab0_part_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: four_bit_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module four_bit_counter_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] counter;

	// Instantiate the Unit Under Test (UUT)
	four_bit_counter uut (
		.clk(clk), 
		.rst(rst), 
		.counter(counter)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
			rst = 1;
		// Add stimulus here
		#20
			rst = 0;

	end
	always
		#5 clk = ~clk;
      
endmodule

