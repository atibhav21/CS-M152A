
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:55:36 10/07/2017 
// Design Name: 
// Module Name:    FPCVT 
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
module FPCVT(
				D,
				S,
				E,
				F
				);
	 
input [11:0] D;
output reg S;
output reg [2:0] E;
output reg [3:0] F;

wire [11:0] sign_magnitude;
wire [2:0]	exponent;
wire [3:0]	significand;
wire fifth_bit;


///////////////////////////////////////////////////////////////////////////////////
//Module Instantiations
///////////////////////////////////////////////////////////////////////////////////

twos_complement_to_sign_magnitude a(
											  D,
											  S,
											  sign_magnitude
											  );
											 
linear_to_floating_point b(
								  sign_magnitude,
								  exponent,
								  significand,
								  fifth_bit
								  );
									
									
											 
rounding c(
			 exponent,
			 significand,
			 fifth_bit,
			 E,
			 F
			 );
			  
endmodule
