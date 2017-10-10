`timescale 1us / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:20:30 10/07/2017
// Design Name:   linear_to_floating_point
// Module Name:   C:/CSM152A/Lab1/linear_to_floating_point_tb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: linear_to_floating_point
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module linear_to_floating_point_tb;

	// Inputs
	reg [11:0] sign_magnitude;

	// Outputs
	wire [2:0] exponent;
	wire [3:0] significand;
	wire fifth_bit;

	// Instantiate the Unit Under Test (UUT)
	linear_to_floating_point uut (
		.sign_magnitude(sign_magnitude), 
		.exponent(exponent), 
		.significand(significand), 
		.fifth_bit(fifth_bit)
	);

	initial begin
		// Initialize Inputs
		sign_magnitude = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		sign_magnitude = 12'b0110_0000_0000;
		#20;
		sign_magnitude = 12'b0010_0000_0000;
		#20;
		sign_magnitude = 12'b0001_1010_0000;
		#20;
		sign_magnitude = 12'b0000_1110_0000;
		#20;
		sign_magnitude = 12'b0000_0101_0000;
		#20;
		sign_magnitude = 12'b0000_0011_0000;
		#20;
		sign_magnitude = 12'b0000_0001_1011;
		#20;
		sign_magnitude = 12'b0000_0000_0111;
		#20;
		sign_magnitude = 12'b0000_0000_0011;
		#20;
		sign_magnitude = 12'b0000_0000_0001;
		#20;
	$finish;
	end
      
endmodule

