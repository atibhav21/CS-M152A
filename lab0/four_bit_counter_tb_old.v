`timescale 1ns / 1ps

module four_bit_counter_tb;
	reg reset;
	reg clock;
	wire [3:0] counter;
	always begin
		clock <= ~ clock;
		#1
	end
	four_bit_counter counter_mod(clock, reset, counter);
	initial begin
		reset = 1'b1;
		#1
		reset = 1'b0;
		#20
		
	end
endmodule