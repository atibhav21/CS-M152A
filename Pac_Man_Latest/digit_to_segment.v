`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:06 11/16/2017 
// Design Name: 
// Module Name:    digit_to_segments 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module convert_to_segments(
								digit,
								segments
	);
	
	/////////////////////////////////////////////////////////////////////////////////
	//Inputs/Outputs
	/////////////////////////////////////////////////////////////////////////////////
	input [3:0] digit;
	output reg [7:0] segments;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Sequential Logic
	/////////////////////////////////////////////////////////////////////////////////
	
	always @(*) begin //Convert the digit to the necessary outputs for the segments
		case (digit)
			4'b0000:	segments = 8'b11000000;
			4'b0001:	segments = 8'b11111001;
			4'b0010: segments = 8'b10100100;
			4'b0011: segments = 8'b10110000;
			4'b0100: segments = 8'b10011001;
			4'b0101: segments = 8'b10010010;
			4'b0110: segments = 8'b10000010;
			4'b0111: segments = 8'b11111000;
			4'b1000: segments = 8'b10000000;
			4'b1001: segments = 8'b10010000;
			default: segments = 8'b11111111; //Turn off all segments
		endcase
	end

endmodule
