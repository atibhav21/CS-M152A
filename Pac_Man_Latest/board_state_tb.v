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

	wire [5:0] x;
	wire [5:0] y;
	wire [2:0] board_data;
	wire game_over;
	wire [13:0] score;

	// Instantiate the Unit Under Test (UUT)
	board_state uut (
		.clk(clk), 
		.reset(reset), 
		.btn_up(btn_up), 
		.btn_down(btn_down), 
		.btn_left(btn_left), 
		.btn_right(btn_right),
		.x(x),
		.y(y),
		.ghost_loc_x(ghost_loc_x),
		.ghost_loc_y(ghost_loc_y),
		.score(score),
		.game_over(game_over),
		.board_data(board_data)
	);

	assign x = 0;
	assign y = 5;

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
      	reset = 1;

      	#10;
      	reset = 0;

      	#100;
		// Add stimulus here
		//btn_right = 1;
		repeat(20) begin
			#10
			$display("Ghost X:%d , Ghost Y:%d, Board Data: %d ", ghost_loc_x, ghost_loc_y, board_data);
		end

		$finish;
		/*#80
		//btn_right = 0;
		//btn_up = 1;
		repeat(8) begin
			#10
			$display("Ghost X:%d , Ghost Y:%d ", ghost_loc_x, ghost_loc_y);
		end
		#80
		//btn_up = 0;
		//btn_down = 1;
		repeat(8) begin
			#10
			$display("Ghost X:%d , Ghost Y:%d ", ghost_loc_x, ghost_loc_y);
		end
		#100
		//btn_down = 0;
		//btn_left = 1;
		repeat(8) begin
			#10
			$display("Ghost X:%d , Ghost Y:%d ", ghost_loc_x, ghost_loc_y);
		
		#80
			$display("Ghost X:%d , Ghost Y:%d ", ghost_loc_x, ghost_loc_y);
		$finish;
		end*/
	end
	
	always begin
		#5
		clk = ~clk;
	end
      
endmodule

