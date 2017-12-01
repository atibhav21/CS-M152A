
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:27:24 11/16/2017 
// Design Name: 
// Module Name:    seven_segment_display 
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
module seven_segment_display(
							display_clk,
							thousands,
							hundreds,
							tens,
							ones,
							segments,
							enables
    );
	 
	/////////////////////////////////////////////////////////////////////////////////
	//Inputs/Outputs
	/////////////////////////////////////////////////////////////////////////////////
	input display_clk;
	input [7:0] thousands;
   input [7:0] hundreds;
   input [7:0] tens;
	input [7:0] ones;
   output reg[7:0] segments;
   output reg[3:0] enables;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Wire/Reg Declarations
	/////////////////////////////////////////////////////////////////////////////////
	reg [1:0] sm;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Constants
	/////////////////////////////////////////////////////////////////////////////////
	parameter st_thousands = 0;
	parameter st_hundreds = 1;
	parameter st_tens = 2;
	parameter st_ones = 3;

	/////////////////////////////////////////////////////////////////////////////////
	//Sequential Logic
	/////////////////////////////////////////////////////////////////////////////////
	initial begin
	sm = st_thousands;
	end
	
	always @(posedge display_clk)begin
		case (sm)
			st_thousands: begin
				enables <= 4'b0111;
				segments <= thousands;
				sm <= st_hundreds;
			end
			st_hundreds: begin
				enables <= 4'b1011;
				segments <= hundreds;
				sm <= st_tens;
			end
			st_tens: begin
				enables <= 4'b1101;
				segments <= tens;
				sm <= st_ones;
			end
			st_ones: begin
				enables <= 4'b1110;
				segments <= ones;
				sm <= st_thousands;
			end
			default: begin
				enables <=4'b1111;
				segments <= 8'b11111111;
				end
		endcase
	end
	
endmodule
