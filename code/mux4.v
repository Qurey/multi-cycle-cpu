`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:18:08 11/23/2016 
// Design Name: 
// Module Name:    mux4 
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
module mux4(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
	 input [1:0] select,
	 output [31:0] out
    );
reg [31:0]_out;
	always@(*)
		case(select)
			3'b00:_out=in0;
			3'b01:_out=in1;
			3'b10:_out=in2;
			3'b11:_out=in3;
			default:_out=0;
		endcase
assign out=_out;

endmodule
