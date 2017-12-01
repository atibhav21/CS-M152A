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

module clock_converter_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	//wire [25:0] counter;
	wire two_hertz_clk;
	wire four_megahertz_clk;
	wire four_hundred_hertz_clk;

	// Instantiate the Unit Under Test (UUT)
	clock_divider uut (
		.clk(clk), 
		.rst(rst), 
		.two_hertz_clk(two_hertz_clk),
		.fast_clk(four_hundred_hertz_clk),
		.four_megahertz_clk(four_megahertz_clk)
	);

	initial begin
		$dumpfile("clock_converter.vcd");
		$dumpvars(0, uut);
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
			rst = 1;
		// Add stimulus here
		#100
			rst = 0;

		#1000000
		$finish;
	end
	always begin
		#5 clk = ~clk;
    end
  
endmodule