module counter(one_hertz_clk, two_hertz_clk, fast_clk, pause, reset, adj,
			select, minutes_tens, minutes_ones, seconds_tens, seconds_ones);
	
	input one_hertz_clk;
	input two_hertz_clk;
	input fast_clk;
	input pause;
	input reset;
	input adj;
	input select;
	
	output reg [3:0] minutes_tens;
	output reg [3:0] minutes_ones;
	output reg [3:0] seconds_tens;
	output reg [3:0] seconds_ones;
	
	// WRITTEN BY CODE_BEAST21
	// PAUSE SIGNAL OVERRIDES EVERYTHING

	wire temp_clk = (adj) ? two_hertz_clk : one_hertz_clk;
	
	reg pause_status;
	reg [2:0] step_d;
	reg	clk_delay;
	wire is_pause_posedge;
	
	initial begin
		pause_status = 0;
	end
	
	assign is_pause_posedge = ~step_d[0] & step_d[1];
	
	always @(fast_clk) begin
		clk_delay <= fast_clk;
	end
	always @(posedge fast_clk) begin
		step_d[2:0] <= {pause, step_d[2:1]};
	end

	always @ (posedge clk_delay) begin
		if(is_pause_posedge) begin
			pause_status <= ! pause_status;
		end
		//pause_status <= is_pause_posedge;
	end

	always @(posedge temp_clk or posedge reset) begin
		if(reset) begin
			// reset all outputs
			minutes_ones = 0;
			minutes_tens = 0;
			seconds_ones = 0;
			seconds_tens = 0;
		end
		else if(! adj && ! pause_status) begin
			// increment regularly
			if (seconds_ones == 9 && seconds_tens == 5) begin
					// reset seconds to 0 and increment minutes
					seconds_ones = 0;
					seconds_tens = 0;
					
					// increment minutes
					if (minutes_ones == 9 && minutes_tens == 5) begin
						// reset to 0, this is where hours would be incremented if we had an hours display
						minutes_ones = 0;
						minutes_tens = 0;
					end
					else if (minutes_ones == 9) begin 
						// increment 10s value of minutes
						minutes_ones = 0;
						minutes_tens = minutes_tens + 1;
					end
					else begin
						minutes_ones = minutes_ones + 1;
					end
				end
				else if (seconds_ones == 9) begin
					// rest seconds ones to 0 and increment seconds 10s
					seconds_ones = 0;
					seconds_tens = seconds_tens + 1;
				end
				else begin
					// just increment seconds ones
					seconds_ones = seconds_ones + 1;
				end		
			end
		
		else if(adj && ! pause_status) begin
			// increment only based on select signal
			if(select) begin
				// increment seconds
				if (seconds_ones == 9 && seconds_tens == 5) begin
						// reset to 0, this is where hours would be incremented if we had an hours display
						seconds_ones = 0;
						seconds_tens = 0;
					end
					else if (seconds_ones == 9) begin 
						// increment 10s value of minutes
						seconds_ones = 0;
						seconds_tens = seconds_tens + 1;
					end
					else begin
						seconds_ones = seconds_ones + 1;
					end
			end
			else begin
				// increment minutes
				if (minutes_ones == 9 && minutes_tens == 5) begin
						// reset to 0, this is where hours would be incremented if we had an hours display
						minutes_ones = 0;
						minutes_tens = 0;
					end
					else if (minutes_ones == 9) begin 
						// increment 10s value of minutes
						minutes_ones = 0;
						minutes_tens = minutes_tens + 1;
					end
					else begin
						minutes_ones = minutes_ones + 1;
					end
			end
		end
		/*else begin
			// PAUSE mode
		end*/
	end
	
/*	always @(posedge one_hertz_clk) begin
		if(reset) begin
			// reset all outputs
			minutes_ones = 0;
			minutes_tens = 0;
			seconds_ones = 0;
			seconds_tens = 0;
		end
		else begin
			if (! pause && ! adj) begin
				if (seconds_ones == 9 && seconds_tens == 5) begin
					// reset seconds to 0 and increment minutes
					seconds_ones = 0;
					seconds_tens = 0;
					
					// increment minutes
					if (minutes_ones == 9 && minutes_tens == 5) begin
						// reset to 0, this is where hours would be incremented if we had an hours display
						minutes_ones = 0;
						minutes_tens = 0;
					end
					else if (minutes_ones == 9) begin 
						// increment 10s value of minutes
						minutes_ones = 0;
						minutes_tens = minutes_tens + 1;
					end
					else begin
						minutes_ones = minutes_ones + 1;
					end
				end
				else if (seconds_ones == 9) begin
					// rest seconds ones to 0 and increment seconds 10s
					seconds_ones = 0;
					seconds_tens = seconds_tens + 1;
				end
				else begin
					// just increment seconds ones
					seconds_ones = seconds_ones + 1;
				end
			end
		end
	end
	
	
	
	always @(posedge two_hertz_clk) begin
		if(adj && ! pause) begin
			// if its not in pause mode, then only adjust
			// clock is in adjustment mode so either change minutes or seconds
			if(select) begin
				// increment seconds
				if (seconds_ones == 9 && seconds_tens == 5) begin
						// reset to 0, this is where hours would be incremented if we had an hours display
						seconds_ones = 0;
						seconds_tens = 0;
					end
					else if (seconds_ones == 9) begin 
						// increment 10s value of minutes
						seconds_ones = 0;
						seconds_tens = seconds_tens + 1;
					end
					else begin
						seconds_ones = seconds_ones + 1;
					end
			end
			else begin
				// increment minutes
				if (minutes_ones == 9 && minutes_tens == 5) begin
						// reset to 0, this is where hours would be incremented if we had an hours display
						minutes_ones = 0;
						minutes_tens = 0;
					end
					else if (minutes_ones == 9) begin 
						// increment 10s value of minutes
						minutes_ones = 0;
						minutes_tens = minutes_tens + 1;
					end
					else begin
						minutes_ones = minutes_ones + 1;
					end
			end
		end
	end
*/
endmodule
			