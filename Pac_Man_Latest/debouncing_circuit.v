`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:16:42 12/04/2017 
// Design Name: 
// Module Name:    debouncing_circuit 
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
module debouncing_circuit(
								d_clk,
								in,
								out
    );
	 
	 /////////////////////////////////////////////////////////////////////////////////
	//Inputs/Outputs
	/////////////////////////////////////////////////////////////////////////////////
    input d_clk;
    input in;
    output wire out;
	 
	/////////////////////////////////////////////////////////////////////////////////
	//Wire/Reg Declarations
	/////////////////////////////////////////////////////////////////////////////////
	 //wire is_posedge;
	 reg [2:0] step_d;
	 //reg clk_delay;

	/////////////////////////////////////////////////////////////////////////////////
	//Sequential Logic
	/////////////////////////////////////////////////////////////////////////////////
	 /*initial begin
		out = 0;
	 end*/
	 
	 assign out = ~step_d[0] & step_d[1];
	 
	 /*always @(d_clk) begin
		clk_delay <= d_clk;
	 end*/
	 
	 always @(posedge d_clk) begin
		step_d[2:0] <= {in, step_d[2:1]};
	 end
	/*
	always @ (posedge d_clk) begin
		if(is_posedge) begin
			out <= ! out;
		end
	end*/
	

endmodule