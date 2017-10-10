`timescale 1ns/1ps

module rounding_tb();
	reg [2:0] exponent;
	reg [3:0] significand;
	reg fifth_bit;
	reg done, done_2;
	wire [2:0] E;
	wire [3:0] F;
	rounding abc(exponent, significand, fifth_bit, E, F);

	initial begin
		$dumpfile("ab.vcd");
		$dumpvars(0, abc);
		#5
		exponent = 0;
		significand = 0;
		fifth_bit = 0;
		done_2= 0;
		#10
		$display("exponent: %d, significand: %d, fifth:%d, Out_E:%d, Out_F:%d", exponent, significand, fifth_bit, E, F);
		for(exponent = 0; exponent < 8 && ! done_2; exponent = exponent + 1) begin
			#20
			done = 0;
			for(significand = 0; significand < 16 && !done; significand = significand + 1) begin
				fifth_bit = 0;
				#10
				$display("exponent: %d, significand: %d, fifth:%d, Out_E:%d, Out_F:%d", exponent, significand, fifth_bit, E, F);
				#10
				fifth_bit = 1;
				#10
				$display("exponent: %d, significand: %d, fifth:%d, Out_E:%d, Out_F:%d", exponent, significand, fifth_bit, E, F);

				if(significand == 15) begin
					done = 1;
				end
			end
			if(exponent == 7) begin
				done_2 = 1;
			end
		end

	end

endmodule