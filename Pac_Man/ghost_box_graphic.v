
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:31:28 11/30/2017 
// Design Name: 
// Module Name:    ghost_box_graphic 
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
module ghost_box_graphic(
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
		//i = 0;
		//j = 0;
		for(i = 0; i < PIXELS_WIDTH; i = i + 1) begin
		//while (i < PIXELS_WIDTH) begin
			//while (j < PIXELS_WIDTH) begin
			for(j = 0; j < PIXELS_WIDTH; j = j + 1) begin	
				graphic[i][j] = 8'b11111111; //white
				//j = j + 1;	
			end
			//i = i + 1;
		end
	end
	
	assign pixels = graphic[x][y];
	
endmodule
