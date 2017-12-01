

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:23 11/29/2017 
// Design Name: 
// Module Name:    pacman 
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
module pacman(
				clk,
				reset,
				button,
				seg,
				an,
				red,
				green,
				blue,
				hsync,
				vsync
    );
`include "pacman_definitions.v"


input clk;
input reset;
input [3:0] button;
output [7:0] seg;
output [3:0] an;
output [2:0] red;
output [2:0] green;
output [1:0] blue;
output hsync;
output vsync;




wire two_hertz_clk;
wire fast_clk;
wire twenty_five_megahertz_clk;

wire [2:0] board_data;
wire [5:0] x;
wire [5:0] y;
wire [13:0] score;
wire game_over;

wire [3:0] thousands;
wire [3:0] hundreds;
wire [3:0] tens;
wire [3:0] ones;

wire [7:0] thousands_segs;
wire [7:0] hundreds_segs;
wire [7:0] tens_segs;
wire [7:0] ones_segs;


clock_divider clk_div(
				  clk, 
				  reset, 
				  two_hertz_clk,
				  fast_clk,
				  twenty_five_megahertz_clk
				  );

board_state bd_st(
						two_hertz_clk, 
						reset,
						button[3],
						button[2],
						button[1],
						button[0],
						x,
						y,
						score,
						game_over,
						board_data
						);
score_to_digits sc_to_dig(
								  score,
								  thousands,
								  hundreds,
								  tens,
								  ones
								  );
								  
								  
								  
digits_to_segments digs_to_segs(
										  clk,
										  thousands,
										  hundreds,
										  tens,
										  ones,
										  thousands_segs,
										  hundreds_segs,
										  tens_segs,
										  ones_segs
										  );
									
										  
								  
seven_segment_display sev_seg_disp(
											  fast_clk,
											  thousands_segs,
											  hundreds_segs,
											  tens_segs,
											  ones_segs,
											  seg,
											  an
											  );
vga640x480 vga(
					twenty_five_megahertz_clk,
					board_data,
					red,
					green,
					blue,
					hsync,
					vsync,
					x,
					y
					);
											  
											  
										
								  
				
								  
						
				  

endmodule
