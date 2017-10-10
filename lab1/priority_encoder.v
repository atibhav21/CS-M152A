`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:10:34 10/07/2017 
// Design Name: 
// Module Name:    priority_encoder 
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
module priority_encoder(
							  in,
					  		  out
    );
input wire [7:0] in;
output wire [2:0] out;

assign out[2] = in[7] | in[6] | in[5] | in[4];
assign out[1] = in[7] | in[6] | (~in[5] & ~in[4] & in[3]) | (~in[5] & ~in[4] & in[2]);
assign out[0] = in[7] | (~in[6] & in[5]) | (~in[6]  & ~in[4] & in[3]) | (~in[6] & ~in[4] & ~in[2] & in[1]);

endmodule
