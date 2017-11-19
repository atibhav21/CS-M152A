`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:15:45 11/03/2017
// Design Name:   convert_to_segments
// Module Name:   C:/Users/152/Documents/Lab3/Stopwatch/convert_to_segments_tb.v
// Project Name:  Stopwatch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: convert_to_segments
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module convert_to_segments_tb;

	// Inputs
	reg [3:0] i_data;

	// Outputs
	wire [7:0] o_data;

	// Instantiate the Unit Under Test (UUT)
	convert_to_segments uut (
		.i_data(i_data), 
		.o_data(o_data)
	);

	initial begin
		// Initialize Inputs
		i_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
		i_data = 8'd0;
		#10 i_data = 8'd1;
		#10 i_data = 8'd2;
		#10 i_data = 8'd3;
		#10 i_data = 8'd4;
		#10 i_data = 8'd5;
		#10 i_data = 8'd6;
		#10 i_data = 8'd7;
		#10 i_data = 8'd8;
		#10 i_data = 8'd9;
        
		  #10 $finish;
		// Add stimulus here

	end
      
endmodule

