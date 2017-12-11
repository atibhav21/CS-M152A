

module board_state(clk, reset, btn_up, btn_down, btn_left, btn_right, x, y, score, game_over, board_data); 

`include "pacman_definitions.v"

	input clk;
	input reset;
	input btn_up;
	input btn_down;
	input btn_left;
	input btn_right;
	input [5:0] x;
	input [5:0] y;

	output wire [2:0] board_data;
	output reg [13:0] score;
	output reg game_over;
	
	// 32 locations wide, 24 locations long
	reg [2:0] board [BOARD_LENGTH-1:0][BOARD_WIDTH-1:0];
	reg [4:0] player_loc_x; // corresponds to board_width
	reg [4:0] player_loc_y; // corresponds to board_length

	reg [4:0] ghost_loc_x; 
	reg [4:0] ghost_loc_y; 
	reg [1:0] ghost_move_direction;

	

	integer i, j;
	integer steps_in_current_dir; // Number of steps for ghost in current direction

	initial begin

		// INITIALIZE THE GAME BOARD
		player_loc_x = 0; 
		player_loc_y = 0;
		ghost_loc_x = BOARD_WIDTH-1;
		ghost_loc_y = BOARD_LENGTH-1;
		ghost_move_direction = DOWN;
		score = 0;
		game_over = 0;
		steps_in_current_dir = 0;
		
		for(i = 0; i <= BOARD_WIDTH - 1; i = i + 1) begin
			for(j = 0; j <= BOARD_LENGTH - 1; j = j + 1) begin
				board[j][i] = food_box;
			end
		end

		board[1][1] = wall_box;
		board[1][2] = wall_box;
		board[2][1] = wall_box;
		board[1][5] = wall_box;
		board[1][6] = wall_box;
		board[2][6] = wall_box;
		board[3][1] = wall_box;
		board[3][3] = wall_box;
		board[3][4] = wall_box;
		board[4][1] = wall_box;
		board[4][2] = wall_box;
		board[4][5] = wall_box;
		board[4][6] = wall_box;

		// Set Board[player_loc_y][player_loc_x] = player_box and same for ghost
		board[player_loc_y][player_loc_x] = pacman_box;
		board[ghost_loc_y][ghost_loc_x] = ghost_and_food_box;
		

	end

	assign board_data = board[y][x];
	

	// Always block to update the player location, do this at the positive edge of the fast clock
	always @(posedge clk or posedge reset) begin
		// move the player
		if(reset) begin
			
				// INITIALIZE THE GAME BOARD
			player_loc_x = 0; 
			player_loc_y = 0;
			ghost_loc_x = BOARD_WIDTH-1;
			ghost_loc_y = BOARD_LENGTH-1;
			ghost_move_direction = DOWN;
			score = 0;
			game_over = 0;
			steps_in_current_dir = 0;
			
			// SET WALLS ON ALL EDGES OF BOARD
			/*for (i = 0; i < BOARD_WIDTH; i = i + 1) begin
				board[0][i] = wall_box;
				board[BOARD_LENGTH-1][i] = wall_box;
			end
			for (i = 0; i < BOARD_LENGTH; i = i + 1) begin
				board[i][0] = wall_box;
				board[i][BOARD_WIDTH-1] = wall_box;
			end*/
			
			for(i = 0; i <= BOARD_WIDTH - 1; i = i + 1) begin
				for(j = 0; j <= BOARD_LENGTH - 1; j = j + 1) begin
					board[j][i] = food_box;
				end
			end

			board[1][1] = wall_box;
			board[1][2] = wall_box;
			board[2][1] = wall_box;
			board[1][5] = wall_box;
			board[1][6] = wall_box;
			board[2][6] = wall_box;
			board[3][1] = wall_box;
			board[3][3] = wall_box;
			board[3][4] = wall_box;
			board[4][1] = wall_box;
			board[4][2] = wall_box;
			board[4][5] = wall_box;
			board[4][6] = wall_box;

			// Set Board[player_loc_y][player_loc_x] = player_box and same for ghost
			board[player_loc_y][player_loc_x] = pacman_box;
			board[ghost_loc_y][ghost_loc_x] = ghost_and_food_box;


		end
		// GHOST EATS PACMAN, GAME OVER
		else if(game_over || score == 340) begin
			game_over = 1; // ASSERT GAME OVER, in case its over by score
			for (i = 0; i < BOARD_WIDTH; i = i + 1) begin
				for(j = 0; j < BOARD_LENGTH; j = j + 1) begin
					board[j][i] = empty_box;
				end
			end
			
		end
		else begin
			if(btn_up) begin
				// move up if possible
				if (player_loc_y < BOARD_LENGTH-1 && board[player_loc_y + 1][player_loc_x] != wall_box) begin
					if(board[player_loc_y + 1][player_loc_x] == ghost_box || board[player_loc_y + 1][player_loc_x] == ghost_and_food_box) begin
						game_over = 1;
						board[player_loc_y][player_loc_x] = empty_box;
					end
					else begin
						board[player_loc_y][player_loc_x] = empty_box;
						player_loc_y = player_loc_y + 1;
						if(board[player_loc_y][player_loc_x] == food_box) begin
							score = score + 10;
						end
						board[player_loc_y][player_loc_x] = pacman_box;
					end
				end
			end
			else if (btn_down) begin
				// move down if possible
				if (player_loc_y > 0 && board[player_loc_y - 1][player_loc_x] != wall_box) begin
					if(board[player_loc_y-1][player_loc_x] == ghost_box || board[player_loc_y-1][player_loc_x] == ghost_and_food_box) begin
						game_over = 1;
						board[player_loc_y][player_loc_x] = empty_box;
					end
					else begin
						board[player_loc_y][player_loc_x] = empty_box;
						player_loc_y = player_loc_y - 1;
						if(board[player_loc_y][player_loc_x] == food_box) begin
							score = score + 10;
						end
						board[player_loc_y][player_loc_x] = pacman_box;
					end
					
				end
			end
			else if (btn_left) begin
				// move left if possible
				if (player_loc_x > 0 && board[player_loc_y][player_loc_x - 1] != wall_box) begin
					if(board[player_loc_y][player_loc_x-1] == ghost_box || board[player_loc_y][player_loc_x-1] == ghost_and_food_box) begin
						// player moves to ghost box
						game_over = 1;
						board[player_loc_y][player_loc_x] = empty_box;
					end
					else begin
						// move player and update previous box
						board[player_loc_y][player_loc_x] = empty_box;
						player_loc_x = player_loc_x - 1;
						if(board[player_loc_y][player_loc_x] == food_box) begin
							score = score + 10;
						end
						board[player_loc_y][player_loc_x] = pacman_box;
					end
					
				end
			end
			else if (btn_right) begin
				// Move right if possible
				if (player_loc_x < BOARD_WIDTH-1 && board[player_loc_y][player_loc_x + 1] != wall_box) begin
					if(board[player_loc_y][player_loc_x+1] == ghost_box || board[player_loc_y][player_loc_x+1] == ghost_and_food_box) begin
						game_over = 1;
						board[player_loc_y][player_loc_x] = empty_box;
					end
					else begin
						board[player_loc_y][player_loc_x] = empty_box;
						player_loc_x = player_loc_x + 1;
						if(board[player_loc_y][player_loc_x] == food_box) begin
							score = score + 10;
						end
						board[player_loc_y][player_loc_x] = pacman_box;
					end
					
				end
			end
			
			// MOVE THE GHOST
			
			case (ghost_move_direction)
				UP: begin
					if(steps_in_current_dir >= 2) begin
						
						if(ghost_loc_x < BOARD_WIDTH - 1 && board[ghost_loc_y][ghost_loc_x+1] != wall_box) begin
							ghost_move_direction = RIGHT;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
							ghost_move_direction = LEFT;
							steps_in_current_dir = 0;
						end
						else begin
							// stay in current direction
							// might delay movement by a clock cycle
							if(ghost_loc_y < BOARD_LENGTH - 1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
								steps_in_current_dir = steps_in_current_dir - 1;
							end
							else begin
								ghost_move_direction = DOWN;
								steps_in_current_dir = 0;
							end
						end
					end
					else if(ghost_loc_y < BOARD_LENGTH-1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
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
						steps_in_current_dir = steps_in_current_dir + 1;
					end
					else begin
						// MOVE IN NEW DIRECTION
						// TRY MOVING LEFT/RIGHT BASED PLAYER LOCATION, else just move DOWN
						// Only CHANGE ghost_move_direction this clock cycle
						if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
							ghost_move_direction = LEFT;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_x < BOARD_WIDTH - 1 && board[ghost_loc_y][ghost_loc_x+1] != wall_box) begin
							ghost_move_direction = RIGHT;
							steps_in_current_dir = 0;
						end
						else begin
							ghost_move_direction = DOWN;
							steps_in_current_dir = 0;
						end
					end
				end
				DOWN: begin
					if(steps_in_current_dir >= 2) begin
						if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
							ghost_move_direction = LEFT;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_x < BOARD_WIDTH - 1 && board[ghost_loc_y][ghost_loc_x+1] != wall_box) begin
							ghost_move_direction = RIGHT;
							steps_in_current_dir = 0;
						end
						else begin
							// stay in current direction
							// might delay movement by a clock cycle
							if(ghost_loc_y > 0 && board[ghost_loc_y - 1][ghost_loc_x] != wall_box) begin
								steps_in_current_dir = steps_in_current_dir - 1;
							end
							else begin
								ghost_move_direction = UP;
								steps_in_current_dir = 0;
							end
						end
					end
					else if(ghost_loc_y > 0 && board[ghost_loc_y-1][ghost_loc_x] != wall_box) begin
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
						steps_in_current_dir = steps_in_current_dir + 1;
					end
					else begin
						// MOVE IN NEW DIRECTION
						// TRY MOVING LEFT/RIGHT BASED PLAYER LOCATION, else just move DOWN
						// Only CHANGE ghost_move_direction this clock cycle
						if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
							ghost_move_direction = LEFT;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_x < BOARD_WIDTH - 1 && board[ghost_loc_y][ghost_loc_x+1] != wall_box) begin
							ghost_move_direction = RIGHT;
							steps_in_current_dir = 0;
						end
						else begin
							ghost_move_direction = DOWN;
							steps_in_current_dir = 0;
						end
					end
				end
				LEFT: begin
					if(steps_in_current_dir >= 2) begin
						if(ghost_loc_y < BOARD_LENGTH - 1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = UP;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_y > 0 && board[ghost_loc_y - 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = DOWN;
							steps_in_current_dir = 0;
						end
						else begin
							// stay in current direction
							// might delay movement by a clock cycle
							if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x - 1] != wall_box) begin
								steps_in_current_dir = steps_in_current_dir - 1;
							end
							else begin
								ghost_move_direction = RIGHT;
								steps_in_current_dir = 0;
							end
						end
					end
					else if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x-1] != wall_box) begin
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
						steps_in_current_dir = steps_in_current_dir + 1;
					end
					else begin
						// Move in New Direction
						// Try moving Up/down based on player location, otherwise move right
						if(ghost_loc_y < BOARD_LENGTH - 1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = UP;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_y > 0 && board[ghost_loc_y - 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = DOWN;
							steps_in_current_dir = 0;
						end
						else begin
							ghost_move_direction = RIGHT;
							steps_in_current_dir = 0;
						end
					end
				end
				RIGHT: begin
					if(steps_in_current_dir >= 2) begin
						if(ghost_loc_y < BOARD_LENGTH - 1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = UP;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_y > 0 && board[ghost_loc_y - 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = DOWN;
							steps_in_current_dir = 0;
						end
						else begin
							// stay in current direction
							// might delay movement by a clock cycle
							if(ghost_loc_x > 0 && board[ghost_loc_y][ghost_loc_x + 1] != wall_box) begin
								steps_in_current_dir = steps_in_current_dir - 1;
							end
							else begin
								ghost_move_direction = LEFT;
								steps_in_current_dir = 0;
							end
						end
					end
					else if(ghost_loc_x < BOARD_WIDTH-1 && board[ghost_loc_y][ghost_loc_x + 1] != wall_box) begin
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
						steps_in_current_dir = steps_in_current_dir + 1;
					end
					else begin
						// Move in New Direction
						// Try moving Up/down based on player location, otherwise move right
						if(ghost_loc_y < BOARD_LENGTH - 1 && board[ghost_loc_y + 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = UP;
							steps_in_current_dir = 0;
						end
						else if(ghost_loc_y > 0 && board[ghost_loc_y - 1][ghost_loc_x] != wall_box) begin
							ghost_move_direction = DOWN;
							steps_in_current_dir = 0;
						end
						else begin
							ghost_move_direction = RIGHT;
							steps_in_current_dir = 0;
						end
					end
				end
			endcase
			
		end
		
		
	end
endmodule