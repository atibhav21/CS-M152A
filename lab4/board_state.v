`include "pacman_definitions.v";

module board_state(clk, reset, btn_up, btn_down, btn_left, btn_right);

	input clk;
	input reset;
	input btn_up;
	input btn_down;
	input btn_left;
	input btn_right;

	// 24 locations wide, 32 locations long
	reg [BOARD_LENGTH-1:0][BOARD_WIDTH-1:0] board [2:0];

	reg [4:0] player_loc_x; // corresponds to board_width
	reg [4:0] player_loc_y; // corresponds to board_length

	reg [4:0] ghost_loc_x;
	reg [4:0] ghost_loc_y;
	reg [1:0] ghost_move_direction;
	
	parameter UP = 0;
	parameter DOWN = 1;
	parameter LEFT = 2;
	parameter RIGHT = 3;

	parameter empty_box = 0;
	parameter food_box = 1;
	parameter wall_box = 2;
	parameter pacman_box = 3;
	parameter ghost_box = 4;
	parameter ghost_and_food_box = 5;

	integer i;

	initial begin
		for (i = 0; i < BOARD_WIDTH; i = i + 1) begin
			board[0][i] = wall_box;
			board[BOARD_LENGTH-1][i] = wall_box;
		end
		for (i = 0; i < BOARD_LENGTH; i = i + 1) begin
			board[i][0] = wall_box;
			board[i][BOARD_WIDTH-1] = wall_box;
		end

	end

	// Always block to update the player location, do this at the positive edge of the fast clock
	always @(posedge clk) begin
		// move the player
		if(btn_up) begin
			// move up if possible
			if (player_loc_y < BOARD_LENGTH-1 && board[player_loc_y + 1][player_loc_x] != wall_box) begin
				board[player_loc_y][player_loc_x] = empty_box;
				player_loc_y += 1;
				board[player_loc_y][player_loc_x] = pacman_box;
			end
		end
		else if (btn_down) begin
			// move down if possible
			if (player_loc_y > 0 && board[player_loc_y - 1][player_loc_x] != wall_box) begin
				board[player_loc_y][player_loc_x] = empty_box;
				player_loc_y -= 1;
				board[player_loc_y][player_loc_x] = pacman_box;
			end
		end
		else if (btn_left) begin
			// move left if possible
			if (player_loc_x > 0 && board[player_loc_y][player_loc_x - 1] != wall_box) begin
				board[player_loc_y][player_loc_x] = empty_box;
				player_loc_x -= 1;
				board[player_loc_y][player_loc_x] = pacman_box;
			end
		end
		else if (btn_right) begin
			// Move right if possible
			if (player_loc_x < BOARD_WIDTH-1 && board[player_loc_y][player_loc_x + 1] != wall_box) begin
				board[player_loc_y][player_loc_x] = empty_box;
				player_loc_x += 1;
				board[player_loc_y][player_loc_x] = pacman_box;
			end
		end

		case ghost_move_direction:
			UP: begin
				if(ghost_loc_y < BOARD_LENGTH-1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
					board[ghost_loc_y][ghost_loc_x] = empty_box;
					ghost_loc_x += 1;
					board[ghost_loc_y][ghost_loc_x] = ghost_box;
				end
				else begin
					// MOVE IN NEW DIRECTION
					// TRY MOVING LEFT/RIGHT BASED PLAYER LOCATION, else just move DOWN
				end
			end
			DOWN: begin
				
			end
			LEFT: begin
				
			end
			RIGHT: begin
				
			end
		endcase
	end
endmodule