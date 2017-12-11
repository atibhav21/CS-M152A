
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:06:28 11/30/2017 
// Design Name: 
// Module Name:    empty_box_graphic 
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
module empty_box_graphic(
								x,
								y,
								pixels
    );
	`include "pacman_definitions.v"
	 input [REL_BITS - 1:0] x;
    input [REL_BITS - 1:0] y;
    output [PIXEL_COLOR_BITS - 1:0] pixels;

	reg [PIXEL_COLOR_BITS - 1:0] graphic[PIXELS_WIDTH - 1:0][PIXELS_WIDTH - 1:0];
	integer i;
	integer j;
	
	
	
	initial begin
		for(i = 0; i < PIXELS_WIDTH; i = i + 1) begin
			for(j = 0; j < PIXELS_WIDTH; j = j + 1) begin	
				graphic[i][j] = 8'b00000000; //black
			end
		end
	end
	
	assign pixels = graphic[x][y];
endmodule
