`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:12:54 11/28/2017
// Design Name:   board_state
// Module Name:   C:/Users/152/Documents/Board/board_state_tb.v
// Project Name:  Board
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: board_state
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module board_state_tb;

	// Inputs
	reg clk;
	reg reset;
	reg btn_up;
	reg btn_down;
	reg btn_left;
	reg btn_right;
	
	wire [4:0] player_loc_x;
	wire [4:0] player_loc_y;
	wire [4:0] ghost_loc_x;
	wire [4:0] ghost_loc_y;

	// Instantiate the Unit Under Test (UUT)
	board_state uut (
		.clk(clk), 
		.reset(reset), 
		.btn_up(btn_up), 
		.btn_down(btn_down), 
		.btn_left(btn_left), 
		.btn_right(btn_right),
		.player_loc_x(player_loc_x),
		.player_loc_y(player_loc_y),
		.ghost_loc_x(ghost_loc_x),
		.ghost_loc_y(ghost_loc_y)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		btn_up = 0;
		btn_down = 0;
		btn_left = 0;
		btn_right = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		btn_right = 1;
		repeat(8) begin
			#10
			$display("Player X:%d , Player Y:%d , Ghost X:%d , Ghost Y:%d ", player_loc_x, player_loc_y, ghost_loc_x, ghost_loc_y);
		end
		#80
		btn_right = 0;
		btn_up = 1;
		repeat(8) begin
			#10
			$display("Player X:%d , Player Y:%d , Ghost X:%d , Ghost Y:%d ", player_loc_x, player_loc_y, ghost_loc_x, ghost_loc_y);
		end
		#80
		btn_up = 0;
		btn_down = 1;
		repeat(8) begin
			#10
			$display("Player X:%d , Player Y:%d , Ghost X:%d , Ghost Y:%d ", player_loc_x, player_loc_y, ghost_loc_x, ghost_loc_y);
		end
		#100
		btn_down = 0;
		btn_left = 1;
		repeat(8) begin
			#10
			$display("Player X:%d , Player Y:%d , Ghost X:%d , Ghost Y:%d ", player_loc_x, player_loc_y, ghost_loc_x, ghost_loc_y);
		end
		
		#80
			$display("Player X:%d , Player Y:%d , Ghost X:%d , Ghost Y:%d ", player_loc_x, player_loc_y, ghost_loc_x, ghost_loc_y);
		$finish;
	end
	
	always begin
		#5
		clk = ~clk;
	end
      
endmodule

