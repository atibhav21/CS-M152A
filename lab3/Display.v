module Display(
					fast_clk,
					minutes_tens, 
					minutes_ones, 
					seconds_tens, 
					seconds_ones,
					segments,
					enables
					);

//////////////////////////////////////////////////////////////////////
//Port Declarations
//////////////////////////////////////////////////////////////////////
input fast_clk;
input [3:0] minutes_tens;
input [3:0] minutes_ones;
input [3:0] seconds_tens;
input [3:0] seconds_ones;

output reg [7:0] segments;
output reg [3:0] enables;
///////////////////////////////////////////////////////////////////////
//Wire/Reg Declarations
///////////////////////////////////////////////////////////////////////
wire [7:0] mins_tens_segs;
wire [7:0] mins_ones_segs;
wire [7:0] secs_tens_segs;
wire [7:0] secs_ones_segs;
reg [1:0] sm1;

////////////////////////////////////////////////////////////////////////
//States
////////////////////////////////////////////////////////////////////////
parameter st_mins_tens = 0;
parameter st_mins_ones = 1;
parameter st_secs_tens = 2;
parameter st_secs_ones = 3;

////////////////////////////////////////////////////////////////////////
//Sequential Logic
////////////////////////////////////////////////////////////////////////
initial begin
	sm1 <= st_mins_tens;
end

always @(posedge fast_clk) begin
	case (sm1)
		st_mins_tens: begin //Illuminate minutes tens digit
			enables <= 4'b0111;
			segments <= mins_tens_segs;
			sm1 <= st_mins_ones;
			end
		st_mins_ones: begin //Illuminate minutes ones digit
			enables <= 4'b1011;
			segments <= mins_ones_segs;
			sm1 <= st_secs_tens;
		end
		st_secs_tens: begin //Illuminate seconds tens digit
			enables <= 4'b1101;
			segments <= secs_tens_segs;
			sm1 <= st_secs_ones;
		end
		st_secs_ones: begin //Illuminate seconds ones digit
			enables <= 4'b1110;
			segments <= secs_ones_segs;
			sm1 <= st_mins_tens;
		end
		default: begin
			enables <= 4'b1111; //Do not illuminate any digit
			segments <= 8'b11111111;
		end
	endcase
end

/////////////////////////////////////////////////////////////////////////////////////////
// Module Instantiations
/////////////////////////////////////////////////////////////////////////////////////////
convert_to_segments a(minutes_tens, mins_tens_segs);
convert_to_segments b(minutes_ones, mins_ones_segs);
convert_to_segments c(seconds_tens, secs_tens_segs);
convert_to_segments d(seconds_ones, secs_ones_segs);
/////////////////////////////////////////////////////////////////////////////////////////

endmodule 


module convert_to_segments(
									i_data,
									o_data
									);
input [3:0] i_data;
output reg [7:0] o_data;

//Convert the digit to the necessary outputs for the segments
always @(*) begin
	case (i_data)
		4'b0000:	o_data = 8'b11000000;
		4'b0001:	o_data = 8'b11111001;
		4'b0010: o_data = 8'b10100100;
		4'b0011: o_data = 8'b10110000;
		4'b0100: o_data = 8'b10011001;
		4'b0101: o_data = 8'b10010010;
		4'b0110: o_data = 8'b10000010;
		4'b0111: o_data = 8'b11111000;
		4'b1000: o_data = 8'b10000000;
		4'b1001: o_data = 8'b10010000;
		4'b1010: o_data = 8'b11111111; //If given 10, turn off all segments
		default: o_data = 8'b11111111; //Turn off all segments
	endcase
end

endmodule
