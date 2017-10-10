module rounding(exponent, significand, fifth_bit, E, F);
	input wire [2:0] exponent;
	input wire [3:0] significand;
	input wire fifth_bit;

	output reg [2:0] E;
	output reg [3:0] F;

	reg [4:0] intermediate_1;

	always @(significand or fifth_bit or exponent) begin
		intermediate_1 = significand + fifth_bit;
		E = exponent + intermediate_1[4];

		F = intermediate_1[3:0];

		if(intermediate_1[4] == 1) begin
			F = intermediate_1[4:1];
		end
		if (E == 0 && exponent != 0) begin
			E = 3'b111;
			F = 4'b1111;
		end
	end


endmodule