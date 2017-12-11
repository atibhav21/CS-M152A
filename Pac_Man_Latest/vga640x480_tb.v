`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:23:31 11/28/2017
// Design Name:   vga640x480
// Module Name:   C:/CSM152A/Pac_Man/vga640x480_tb.v
// Project Name:  Pac_Man
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga640x480
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga640x480_tb;

	// Inputs
	reg clk;
	reg [2:0] board_data;

	// Outputs
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hsync;
	wire vsync;
	wire [5:0] x;
	wire [5:0] y;


	// Instantiate the Unit Under Test (UUT)
	vga640x480 uut (
		.clk(clk), 
		.board_data(board_data), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync),
		.x(x),
		.y(y)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		board_data = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		board_data = 3; 
		#100000;
	end
      
	always begin
	 #10 clk = ~clk;
	end
	
endmodule

