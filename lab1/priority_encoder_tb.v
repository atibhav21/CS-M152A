`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:23:17 10/07/2017
// Design Name:   priority_encoder
// Module Name:   C:/CSM152A/Lab1/priority_encoder_tb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: priority_encoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module priority_encoder_tb;

	// Inputs
	reg [7:0] in;

	// Outputs
	wire [2:0] out;

	// Instantiate the Unit Under Test (UUT)
	priority_encoder uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 8'd0;

		// Wait 100 ns for global reset to finish
		#100;
		//Add stimulus here
      in = 8'b0000_0000;
		#20;
		in = 8'b0000_0001;
		#20;
		in = 8'b0000_0011;
		#20;
		in = 8'b0000_0101;
		#20;
		in = 8'b0000_1010;
		#20;
		in = 8'b0001_0100;
		#20;
		in = 8'b0010_0010;
		#20;
		in = 8'b0100_0001;
		#20;
		in = 8'b1100_0000;
	$finish;
	end
      
endmodule

