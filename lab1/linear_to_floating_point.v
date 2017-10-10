`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:08 10/07/2017 
// Design Name: 
// Module Name:    linear_to_floating_point 
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
module linear_to_floating_point(
										 sign_magnitude,
										 exponent,
										 significand,
										 fifth_bit
										 );
input [11:0] sign_magnitude;
output reg [2:0] exponent;
output reg [3:0] significand;
output reg fifth_bit;

reg [2:0] leading_zeroes;
wire [7:0] interm1;
wire [2:0] encoded;
wire all_zeroes;

//assign exponent = encoded + 3'b001;
assign interm1 = sign_magnitude[11:4];
assign all_zeroes = ~(|interm1);


priority_encoder pri_enc(
								.in(interm1),
								.out(encoded)
								);


always @(*)begin
	if (sign_magnitude == 12'b1000_0000_0000)	begin
		exponent = 3'b111;
		significand = 4'b1111;
		fifth_bit = 1'b0;
	end
	else begin
		if (all_zeroes) begin
			exponent = encoded;
			leading_zeroes = 8 - encoded;
			end
		else begin
			exponent = encoded + 1;
			leading_zeroes = 7 - encoded;
		end

		if (exponent == 3'd0) begin
			significand <= sign_magnitude[3:0];
			fifth_bit   <= 1'b0;
			end
		else begin
			significand <= sign_magnitude[(4'd11 - leading_zeroes)-:4];
			fifth_bit 	<= sign_magnitude[4'd7 - leading_zeroes];	
			/*
			significand <= sign_magnitude[4'd11 - leading_zeroes: 4'd8 - leading_zeroes];
			fifth_bit 	<= sign_magnitude[4'd7 - leading_zeroes];	*/
		end
	end
end

endmodule

