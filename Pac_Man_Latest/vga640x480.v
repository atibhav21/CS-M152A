
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:50 11/25/2017 
// Design Name: 
// Module Name:    vga640x480 
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
module vga640x480(
						clk,
						board_data,
						red,
						green,
						blue,
						hsync,
						vsync,
						x,
						y
    );
	 
`include "pacman_definitions.v"
	/////////////////////////////////////////////////////////////////////////////////
	//Inputs/Outputs
	/////////////////////////////////////////////////////////////////////////////////
	input clk;
   input [2:0] board_data;
   output [2:0] red;
   output [2:0] green;
   output [1:0] blue;
   output hsync;
   output vsync;
	output reg [5:0] x;
	output reg [5:0] y;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Wire/Reg Declarations
	/////////////////////////////////////////////////////////////////////////////////
	reg [9:0] hor_counter; //Counts through horizontal pixels
	reg [9:0] ver_counter; //Counts through vertical pixels
	
	reg enable;
	
	reg [9:0] norm_x;
	reg [9:0] norm_y;
	reg [5:0] cur_board_state_x;
	reg [5:0] cur_board_state_y;
	reg [REL_BITS - 1:0] rel_x;
	reg [REL_BITS - 1:0] rel_y;
	reg [3:0] state;
	
	//Pixel colors to be shown
	reg [PIXEL_COLOR_BITS - 1:0] pixel_colors;
	
	//Pixel colors to be selected
	wire [PIXEL_COLOR_BITS - 1:0] empty_pixels;
	wire [PIXEL_COLOR_BITS - 1:0] food_pixels;
	wire [PIXEL_COLOR_BITS - 1:0] wall_pixels;
	wire [PIXEL_COLOR_BITS - 1:0] pacman_pixels;
	wire [PIXEL_COLOR_BITS - 1:0] ghost_pixels;
	
	initial begin
	hor_counter = 0;
	ver_counter = 0;
	x = 0;
	y = 0;
	rel_x = 0;
	rel_y = 0;
	end
	
	/////////////////////////////////////////////////////////////////////////////////
	//Constants
	/////////////////////////////////////////////////////////////////////////////////
	parameter hor_pixels = 800;
	parameter ver_pixels = 521;
	parameter hor_pulse = 96;
	parameter ver_pulse = 2;
	parameter hor_back_porch = 144;
	parameter hor_front_porch = 784;
	parameter ver_back_porch = 31;
	parameter ver_front_porch = 511;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Combinational Logic
	/////////////////////////////////////////////////////////////////////////////////
	//Sends the horizontal and vertical pulses to the monitor
	assign hsync = (hor_counter < hor_pulse) ? 0 : 1; //Send pulse when horizontal pixel is from 0 to hor_pulse
	assign vsync = (ver_counter < ver_pulse) ? 0 : 1; //Send pulse when vertical pixel is from 0 to ver_pulse
	
	assign red = enable ? pixel_colors[2:0] : 0;
	assign green = enable ? pixel_colors[5:3] : 0;
	assign blue = enable ? pixel_colors[7:6] : 0;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Sequential Logic
	/////////////////////////////////////////////////////////////////////////////////
	
	//Keeps track of the position of the pixel being updated
	always @(posedge clk) begin
		if (hor_counter < hor_pixels - 1) //Increment horizontal counter
			hor_counter <= hor_counter + 1;
		else begin		//Otherwise, reset horizontal counter / increment vertical counter
			hor_counter <= 0;
			if (ver_counter < ver_pixels - 1) //Incremement vertical counter
				ver_counter <= ver_counter + 1;
			else
				ver_counter <= 0; //Reset vertical counter
		end
	end
/*
always @(*) begin
	if ( (hor_counter >= hor_back_porch && hor_counter < hor_front_porch)  &&
		(ver_counter >= ver_back_porch && ver_counter < ver_front_porch) ) begin
		
	
		if (rel_x < PIXELS_WIDTH) begin //Increment x relative pixel
			rel_x = rel_x + 1;
		end
		else begin
			rel_x = 0; //Otherwise set to 0
			if (x < BOARD_WIDTH)  begin //Check whether to increment cur x
				x = x + 1;
			end
			else begin
				x = 0;
				if (rel_y < PIXELS_WIDTH) begin
					rel_y = rel_y + 1;
				end
				else begin
					rel_y = 0;
					if (y < BOARD_LENGTH) begin
						y = y + 1;
					end
					else begin
						y = 0;
					end
				end
				
			end
		end
		state = board_data;
		enable = 1;
	end	
	else begin
		rel_x = 0;
		//rel_y = 0;
		x = 0;
		//y = 0;
		enable = 0;
		state = 0;
	
	end
end*/

	always @(*) begin
		//Check whether in active pixel range
		
		if ( (hor_counter >= hor_back_porch && hor_counter < hor_front_porch)  &&
			 (ver_counter >= ver_back_porch && ver_counter < ver_front_porch) ) begin
				enable = 1;
				//Calculate pixel between 0-639 and 0-479
				norm_x = hor_counter - hor_back_porch;
				norm_y = ver_counter - ver_back_porch;
				
				//Calculate what location we are at 
				cur_board_state_x = norm_x / PIXELS_WIDTH;
				cur_board_state_y = norm_y / PIXELS_WIDTH;
				
				//Calculate relative x and relative y
				rel_x = norm_x % PIXELS_WIDTH; //TODO
				rel_y = norm_y % PIXELS_WIDTH;
				
				//Set state of the board
				y = cur_board_state_y; // Y because that is the first dimension in board_state
				x = cur_board_state_x;
				state = board_data;
		end		
		else begin
			//Doesn't matter what is displayed out of active pixel range
			enable = 0;
			cur_board_state_x = 0;
			//cur_board_state_y = 0;
			rel_x = 0;
			//rel_y = 0;
			//y = 0;
			x = 0;
			state = 0;
		end
	end
	
	always @(*)
		case (state) 
			empty_box: 
				pixel_colors = empty_pixels;
			food_box: 
				pixel_colors = food_pixels;
			wall_box: 
				pixel_colors = wall_pixels;
			pacman_box:
				pixel_colors = pacman_pixels;
			ghost_box:
				pixel_colors = ghost_pixels;
			ghost_and_food_box: //Display ghost 
				pixel_colors = ghost_pixels;
			default:
				pixel_colors = empty_pixels;
		endcase
	
	/////////////////////////////////////////////////////////////////////////////////
	//Module Instantiations
	/////////////////////////////////////////////////////////////////////////////////
	
	//Inputs to modules: relative x and relative y
	//Outputs from modules: Pixel color
	empty_box_graphic a(
							 rel_x,
							 rel_y,
							 empty_pixels
							 );
							 
	food_box_graphic b(
							rel_x,
							rel_y,
							food_pixels
							);
							
	wall_box_graphic c(
							rel_x,
							rel_y,
							wall_pixels
							);
							
	pacman_box_graphic d(
							  rel_x,
							  rel_y,
							  pacman_pixels
							  );
							  
	ghost_box_graphic e(
								rel_x,
								rel_y,
								ghost_pixels
								);
		
endmodule
