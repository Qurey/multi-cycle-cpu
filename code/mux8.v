`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:23 11/29/2016 
// Design Name: 
// Module Name:    mux8 
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
module mux8(
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    input [31:0] in6,
    input [31:0] in7,
    input [31:0] in8,
    input [2:0] sel,
    output [31:0] out
    );
reg [31:0]_out;
	always@(*)
		case(sel)
			3'b000:_out=in1;
			3'b001:_out=in2;
			3'b010:_out=in3;
			3'b011:_out=in4;
			3'b100:_out=in5;
			default:_out=0;
		endcase
assign out=_out;

endmodule
