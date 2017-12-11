`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:38 12/04/2017 
// Design Name: 
// Module Name:    debouncing 
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
module debouncing(
						d_clk,
						button3,
						button2,
						button1,
						button0,
						reset,
						b3,
						b2,
						b1,
						b0,
						rst
    );
	 
	/////////////////////////////////////////////////////////////////////////////////
	//Inputs/Outputs
	/////////////////////////////////////////////////////////////////////////////////
    input d_clk;
    input button3;
    input button2;
    input button1;
    input button0;
	 input reset;
    output b3;
    output b2;
    output b1;
    output b0;
	 output rst;

	/////////////////////////////////////////////////////////////////////////////////
	//Module Instantiations
	/////////////////////////////////////////////////////////////////////////////////
	debouncing_circuit bt3(d_clk, button3, b3);
	debouncing_circuit bt2(d_clk, button2, b2);
	debouncing_circuit bt1(d_clk, button1, b1);
	debouncing_circuit bt0(d_clk, button0, b0);
	debouncing_circuit rset(d_clk, reset, rst);

endmodule
