module modify_display(
				minutes_tens, 
				minutes_ones, 
				seconds_tens, 
				seconds_ones,
				blink_clk,
				adj,
				sel,
				o_minutes_tens,
				o_minutes_ones,
				o_seconds_tens,
				o_seconds_ones
				);


input [3:0] minutes_tens;
input [3:0] minutes_ones;
input [3:0] seconds_tens;
input [3:0] seconds_ones;
input blink_clk;
input adj;
input sel;

output [3:0] o_minutes_tens;
output [3:0] o_minutes_ones;
output [3:0] o_seconds_tens;
output [3:0] o_seconds_ones;

reg curr_state;

parameter display_state = 0;
parameter off_state = 1;

reg [3:0] seconds_tens_blink;
reg [3:0] seconds_ones_blink;
reg [3:0] minutes_tens_blink;
reg [3:0] minutes_ones_blink;

/////////////////////////////////////////////
assign o_seconds_tens = adj ? seconds_tens_blink : seconds_tens;
assign o_seconds_ones = adj ? seconds_ones_blink : seconds_ones;
assign o_minutes_tens = adj ? minutes_tens_blink : minutes_tens;
assign o_minutes_ones = adj ? minutes_ones_blink : minutes_ones;
//////////////////////////////////////////

initial begin
seconds_tens_blink = seconds_tens;
seconds_ones_blink = seconds_ones;
minutes_tens_blink = minutes_tens;
minutes_ones_blink = minutes_ones;
curr_state = 0;
end

always @(posedge blink_clk) begin
	if(adj && sel) begin
		case (curr_state)
			display_state: begin
				seconds_tens_blink <= seconds_tens;
				seconds_ones_blink <= seconds_ones;
				minutes_tens_blink <= 10;
				minutes_ones_blink <= 10;
				curr_state <= off_state;
			end
			off_state: begin
				seconds_tens_blink <= 10;
				seconds_ones_blink <= 10;
				minutes_tens_blink <= 10;
				minutes_ones_blink <= 10;
				curr_state <= display_state;
			end
			default: begin
				seconds_tens_blink <= 10;
				seconds_ones_blink <= 10;
				minutes_tens_blink <= 10;
				minutes_ones_blink <= 10;
				curr_state <= display_state;
			end
		endcase

	end
	else if(adj && ! sel) begin
		case (curr_state)
			display_state: begin
				minutes_tens_blink <= minutes_tens;
				minutes_ones_blink <= minutes_ones;
				seconds_tens_blink <= 10;
				seconds_ones_blink <= 10;
				curr_state <= off_state;
			end
			off_state: begin
				seconds_tens_blink <= 10;
				seconds_ones_blink <= 10;
				minutes_tens_blink <= 10;
				minutes_ones_blink <= 10;
				curr_state <= display_state;
			end
			default: begin
				seconds_tens_blink <= 10;
				seconds_ones_blink <= 10;
				minutes_tens_blink <= 10;
				minutes_ones_blink <= 10;
				curr_state <= display_state;
			end
		endcase
	end
end

endmodule