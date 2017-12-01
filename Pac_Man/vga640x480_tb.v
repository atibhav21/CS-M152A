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
	reg [7:0] pixel_colors[639:0][479:0];

	// Outputs
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hsync;
	wire vsync;



	reg x;
	reg y;
	// Instantiate the Unit Under Test (UUT)
	vga640x480 uut (
		.clk(clk), 
		.pixel_colors(pixel_colors), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		pixel_colors = 0;
		x = 0;
		y = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		for ( ; x < 640; x = x+1) begin
			for ( ; y < 480; y = y + 1) begin
			pixel_colors[x][y] = 8'b00000111;
			end
		end
		#100;
	end
      
	always begin
	 #10 clk = ~clk;
	end
	
endmodule

