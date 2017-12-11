
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:19:27 11/30/2017 
// Design Name: 
// Module Name:    food_box_graphic 
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
module food_box_graphic(
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
	integer a;
	integer b;
	
	parameter radius_squared = 225;

	//Initialize food to white circle
	initial begin
		for(i = 0; i < PIXELS_WIDTH; i = i + 1) begin
			for(j = 0; j < PIXELS_WIDTH; j = j + 1) begin
				a = i - 40;
				b = j - 40;
				if ( (a*a + b*b) < radius_squared ) begin
					graphic[i][j] = 8'b11111111; //yellow
				end
				else begin
					graphic[i][j] = 8'b00000000; //black
				end	
			end
		end
	end
	
	assign pixels = graphic[x][y];
endmodule
