`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:35 11/02/2017 
// Design Name: 
// Module Name:    Stopwatch 
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
module Stopwatch(
    input clk,
    input reset,
    input adj,
    input select,
    input pause,
    output [7:0] segments,
    output [3:0] enables
    );

wire one_hertz_clk;
wire two_hertz_clk;
wire fast_clk;
wire blink_clk;

wire [3:0] minutes_tens;
wire [3:0] minutes_ones;
wire [3:0] seconds_tens;
wire [3:0] seconds_ones;

wire [3:0] final_minutes_tens;
wire [3:0] final_minutes_ones;
wire [3:0] final_seconds_tens;
wire [3:0] final_seconds_ones;

//////////////////////////////////////////////////////////////////////////////////
// Module Instantiations
//////////////////////////////////////////////////////////////////////////////////

clock_converter clk_cnv(
								.clk(clk),
								.rst(reset),
								.one_hertz_clk(one_hertz_clk), 
								.two_hertz_clk(two_hertz_clk),
								.fast_clk(fast_clk),
								.blink_clk(blink_clk)
								);
								
counter count(
					.one_hertz_clk(one_hertz_clk),
					.two_hertz_clk(two_hertz_clk),
					.fast_clk(fast_clk),
					.pause(pause),
					.reset(reset),
					.adj(adj),
					.select(select),
					.minutes_tens(minutes_tens),
					.minutes_ones(minutes_ones),
					.seconds_tens(seconds_tens),
					.seconds_ones(seconds_ones)
					);

modify_display cntrl_disp (
				.minutes_tens(minutes_tens), 
				.minutes_ones(minutes_ones), 
				.seconds_tens(seconds_tens), 
				.seconds_ones(seconds_ones),
				.blink_clk(blink_clk),
				.adj(adj),
				.sel(select),
				.o_minutes_tens(final_minutes_tens),
				.o_minutes_ones(final_minutes_ones),
				.o_seconds_tens(final_seconds_tens),
				.o_seconds_ones(final_seconds_ones)
	);

Display disp( 
				.fast_clk(fast_clk),
				.minutes_tens(final_minutes_tens),
				.minutes_ones(final_minutes_ones),
				.seconds_tens(final_seconds_tens),
				.seconds_ones(final_seconds_ones),
				.segments(segments),
				.enables(enables)
				);
					
///////////////////////////////////////////////////////////////////////////////////

endmodule
