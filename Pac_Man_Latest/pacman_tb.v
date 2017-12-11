`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:40:04 12/06/2017
// Design Name:   pacman
// Module Name:   C:/CSM152A/Pac_Man_Latest/pacman_tb.v
// Project Name:  Pac_Man
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pacman
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pacman_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] button;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hsync;
	wire vsync;

	// Instantiate the Unit Under Test (UUT)
	pacman uut (
		.clk(clk), 
		.reset(reset), 
		.button(button), 
		.seg(seg), 
		.an(an), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		button = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	#10000;
	end
      
	always begin
	#5	clk = ~clk;
	end
endmodule

