
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:29 11/25/2017 
// Design Name: 
// Module Name:    score_to_digits 
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
module score_to_digits(
							  score,
							  thousands,
							  hundreds,
							  tens,
							  ones
    );
	/////////////////////////////////////////////////////////////////////////////////
	//Inputs/Outputs
	/////////////////////////////////////////////////////////////////////////////////
	input [13:0] score;
	output [3:0] thousands;
	output [3:0] hundreds;
	output [3:0] tens;
	output [3:0] ones;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Wire/Reg Declarations
	/////////////////////////////////////////////////////////////////////////////////
	wire [9:0] thousands_rem; //holds up to 1024, needs up to 999
	wire [6:0] hundreds_rem; //holds up to 128, needs up to 99
	wire [3:0] tens_rem; //holds up to 16, needs up to 9
	
	/////////////////////////////////////////////////////////////////////////////////
	//Combinational Logic
	/////////////////////////////////////////////////////////////////////////////////
	assign thousands = score / 1000; 
	assign hundreds = thousands_rem / 100;
	assign tens = hundreds_rem / 10;
	
	assign thousands_rem = score % 1000;
	assign hundreds_rem = thousands_rem % 100;
	assign ones = hundreds_rem % 10;


endmodule
