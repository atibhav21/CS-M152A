

module board_state(clk, reset, btn_up, btn_down, btn_left, btn_right, state_1, x_1, y_1, read, write, write_data, score, game_over);

`include "pacman_definitions.v"

	input clk;
	input reset;
	input btn_up;
	input btn_down;
	input btn_left;
	input btn_right;
	input [2:0] state_1;

	// 32 locations wide, 24 locations long
	//output reg [2:0] board [BOARD_LENGTH-1:0][BOARD_WIDTH-1:0];
	output reg [5:0] x_1;
	output reg [5:0] y_1;
	output read;
	output write;
	output [2:0] write_data;
	output reg [13:0] score;
	output reg game_over;

	reg [4:0] player_loc_x; // corresponds to board_width
	reg [4:0] player_loc_y; // corresponds to board_length

	reg [4:0] ghost_loc_x;
	reg [4:0] ghost_loc_y;
	reg [1:0] ghost_move_direction;

	

	integer i, j;

	initial begin

		// INITIALIZE THE GAME BOARD
		player_loc_x = 1;
		player_loc_y = 1;
		ghost_loc_x = BOARD_WIDTH-2;
		ghost_loc_y = BOARD_LENGTH-2;
		ghost_move_direction = DOWN;
		score = 0;
		game_over = 0;
		
		// SET WALLS ON ALL EDGES OF BOARD
		for (i = 0; i < BOARD_WIDTH; i = i + 1) begin
			y_1 = 0;
			x_1 = i;
			write = 1;
			//board[0][i] = wall_box;
			board[BOARD_LENGTH-1][i] = wall_box;
		end
		for (i = 0; i < BOARD_LENGTH; i = i + 1) begin
			board[i][0] = wall_box;
			board[i][BOARD_WIDTH-1] = wall_box;
		end
		
		// ONLY NEED TO CODE COL 1:11 and rows 1:30, symmetric after that
		for(i = 1; i < BOARD_WIDTH - 1; i = i + 1) begin
			for(j = 1; j < BOARD_LENGTH - 1; j = j + 1) begin
				board[j][i] = food_box;
			end
		end

		// Set Board[player_loc_y][player_loc_x] = player_box and same for ghost
		board[player_loc_y][player_loc_x] = pacman_box;
		board[ghost_loc_y][ghost_loc_x] = ghost_and_food_box;

		// TODO: SET THE WALLS
		

	end


	

	// Always block to update the player location, do this at the positive edge of the fast clock
	always @(posedge clk or posedge reset) begin
		// move the player
		if(reset) begin
			player_loc_x = 1;
			player_loc_y = 1;
			ghost_loc_x = BOARD_WIDTH-2;
			ghost_loc_y = BOARD_LENGTH-2;
			score = 0;
			game_over = 0;

			// TODO: RESET THE GAME BOARD
		end
		// GHOST EATS PACMAN, GAME OVER
		else if(game_over) begin
			;
		end
		else begin
			if(btn_up) begin
				// move up if possible
				if (player_loc_y < BOARD_LENGTH-1 && board[player_loc_y + 1][player_loc_x] != wall_box) begin
					board[player_loc_y][player_loc_x] = empty_box;
					player_loc_y = player_loc_y + 1;
					if(board[player_loc_y][player_loc_x] == food_box) begin
						score = score + 10;
					end
					board[player_loc_y][player_loc_x] = pacman_box;
				end
			end
			else if (btn_down) begin
				// move down if possible
				if (player_loc_y > 0 && board[player_loc_y - 1][player_loc_x] != wall_box) begin
					board[player_loc_y][player_loc_x] = empty_box;
					player_loc_y = player_loc_y - 1;
					if(board[player_loc_y][player_loc_x] == food_box) begin
						score = score + 10;
					end
					board[player_loc_y][player_loc_x] = pacman_box;
				end
			end
			else if (btn_left) begin
				// move left if possible
				if (player_loc_x > 0 && board[player_loc_y][player_loc_x - 1] != wall_box) begin
					board[player_loc_y][player_loc_x] = empty_box;
					player_loc_x = player_loc_x - 1;
					if(board[player_loc_y][player_loc_x] == food_box) begin
						score = score + 10;
					end
					board[player_loc_y][player_loc_x] = pacman_box;
				end
			end
			else if (btn_right) begin
				// Move right if possible
				if (player_loc_x < BOARD_WIDTH-1 && board[player_loc_y][player_loc_x + 1] != wall_box) begin
					board[player_loc_y][player_loc_x] = empty_box;
					player_loc_x = player_loc_x + 1;
					if(board[player_loc_y][player_loc_x] == food_box) begin
						score = score + 10;
					end
					board[player_loc_y][player_loc_x] = pacman_box;
				end
			end
			
			// MOVE THE GHOST
			case (ghost_move_direction)
				UP: begin
					if(ghost_loc_y < BOARD_LENGTH-1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
						if(board[ghost_loc_y][ghost_loc_x] == ghost_and_food_box) begin
							board[ghost_loc_y][ghost_loc_x] = food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = empty_box;
						end
						ghost_loc_y = ghost_loc_y + 1;
						if(board[ghost_loc_y][ghost_loc_x] == pacman_box) begin
							game_over = 1;
						end
						else if(board[ghost_loc_y][ghost_loc_x] == food_box) begin
							board[ghost_loc_y][ghost_loc_x] = ghost_and_food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = ghost_box;
						end
						
					end
					else begin
						// MOVE IN NEW DIRECTION
						// TRY MOVING LEFT/RIGHT BASED PLAYER LOCATION, else just move DOWN
						// Only CHANGE ghost_move_direction this clock cycle
						if(board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
							ghost_move_direction = LEFT;
						end
						else if(board[ghost_loc_y][ghost_loc_x+1] != wall_box) begin
							ghost_move_direction = RIGHT;
						end
						else begin
							ghost_move_direction = DOWN;
						end
					end
				end
				DOWN: begin
					if(ghost_loc_y > 0 && board[ghost_loc_y-1][ghost_loc_x] != wall_box) begin
						// update old location correctly
						if(board[ghost_loc_y][ghost_loc_x] == ghost_and_food_box) begin
							board[ghost_loc_y][ghost_loc_x] = food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = empty_box;
						end
						ghost_loc_y = ghost_loc_y - 1;

						// Update current box correctly
						if(board[ghost_loc_y][ghost_loc_x] == pacman_box) begin
							game_over = 1;
						end
						else if(board[ghost_loc_y][ghost_loc_x] == food_box) begin
							board[ghost_loc_y][ghost_loc_x] = ghost_and_food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = ghost_box;
						end
					end
					else begin
						// MOVE IN NEW DIRECTION
						// TRY MOVING LEFT/RIGHT BASED PLAYER LOCATION, else just move DOWN
						// Only CHANGE ghost_move_direction this clock cycle
						if(board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
							ghost_move_direction = LEFT;
						end
						else if(board[ghost_loc_y][ghost_loc_x+1] != wall_box) begin
							ghost_move_direction = RIGHT;
						end
						else begin
							ghost_move_direction = DOWN;
						end
					end
				end
				LEFT: begin
					if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
						if(board[ghost_loc_y][ghost_loc_x] == ghost_and_food_box) begin
							board[ghost_loc_y][ghost_loc_x] = food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = empty_box;
						end

						ghost_loc_x = ghost_loc_x - 1;

						if(board[ghost_loc_y][ghost_loc_x] == pacman_box) begin
							game_over = 1;
						end
						else if(board[ghost_loc_y][ghost_loc_x] == food_box) begin
							board[ghost_loc_y][ghost_loc_x] = ghost_and_food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = ghost_box;
						end
					end
					else begin
						// Move in New Direction
						// Try moving Up/down based on player location, otherwise move right
						if(board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = UP;
						end
						else if(board[ghost_loc_y - 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = DOWN;
						end
						else begin
							ghost_move_direction = RIGHT;
						end
					end
				end
				RIGHT: begin
					if(ghost_loc_x < BOARD_WIDTH-1 && board[ghost_loc_y][ghost_loc_x + 1] != wall_box) begin
						if(board[ghost_loc_y][ghost_loc_x] == ghost_and_food_box) begin
							board[ghost_loc_y][ghost_loc_x] = food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = empty_box;
						end

						ghost_loc_x = ghost_loc_x + 1;

						if(board[ghost_loc_y][ghost_loc_x] == pacman_box) begin
							game_over = 1;
						end
						else if(board[ghost_loc_y][ghost_loc_x] == food_box) begin
							board[ghost_loc_y][ghost_loc_x] = ghost_and_food_box;
						end
						else begin
							board[ghost_loc_y][ghost_loc_x] = ghost_box;
						end
					end
					else begin
						// Move in New Direction
						// Try moving Up/down based on player location, otherwise move right
						if(board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = UP;
						end
						else if(board[ghost_loc_y - 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = DOWN;
						end
						else begin
							ghost_move_direction = RIGHT;
						end
					end
				end
			endcase
		
		end
		
		
	end
endmodule