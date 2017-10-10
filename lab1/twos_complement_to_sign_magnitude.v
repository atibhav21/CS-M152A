// Code your design here
module twos_complement_to_sign_magnitude(D, S, sign_magnitude);
	input wire [11:0] D;
	output wire S;
	output reg [11:0] sign_magnitude;

	assign S = D[11];

	always @(*) begin
		if(S == 1'b1) begin
			sign_magnitude = (~D) + 1;
		end
		else begin
			sign_magnitude = D;
		end
	end

endmodule