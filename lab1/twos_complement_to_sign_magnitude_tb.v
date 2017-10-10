`timescale 1ns / 1ps

module twos_complement_to_sign_magnitude_tb();
	reg [11:0] a;
	wire s;
	wire [11:0] sign_mag;

	twos_complement_to_sign_magnitude abcd(a, s, sign_mag);
	initial begin
		a = 0;
      for(a=12'b0;a < 4095;a=a+1) begin
        	#4
			$display("Input:%d, Sign:%d , Sign Magnitude: %d ", a, s, sign_mag);
			
		end
	end

endmodule