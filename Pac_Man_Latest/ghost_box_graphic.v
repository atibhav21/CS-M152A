
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
	integer a;
	integer b;
	parameter radius_squared = 400;
	
	initial begin
		for(i = 0; i < PIXELS_WIDTH; i = i + 1) begin
			for(j = 0; j < PIXELS_WIDTH; j = j + 1) begin
				if ((i > 20 && i < 60) && (j > 20 && j < 60)) begin
					a = i - 40;
					b = j - 40;
					if (j < 40) begin
						if ( (a*a + b*b) < radius_squared) begin //red semicircle
							graphic[i][j] = 8'b00000111; //red
						end
						else begin
							graphic[i][j] = 8'b00000000; //black
						end
					end
					else  begin
					graphic[i][j] = 8'b00000111; //red
					end
				end
				else begin
					graphic[i][j] = 8'b00000000; //black
				end
			end
		end
	end
	
	assign pixels = graphic[x][y];
	
endmodule
