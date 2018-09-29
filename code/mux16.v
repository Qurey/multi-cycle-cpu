`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:34:59 12/05/2016 
// Design Name: 
// Module Name:    mux16 
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
module mux16(
    input [3:0] select,
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
    input [31:0] a3,
    input [31:0] a4,
    input [31:0] a5,
    input [31:0] a6,
    input [31:0] a7,
    input [31:0] a8,
    input [31:0] a9,
    input [31:0] a10,
    input [31:0] a11,
    input [31:0] a12,
    input [31:0] a13,
    input [31:0] a14,
    input [31:0] a15,
    output [31:0] result
    );
reg [31:0]out;
always @(*)
	case(select)
		4'b0000:out=a0;
		4'b0001:out=a1;
		4'b0010:out=a2;
		4'b0011:out=a3;
		4'b0100:out=a4;
		4'b0101:out=a5;
		4'b0110:out=a6;
		4'b0111:out=a7;
		4'b1000:out=a8;
		4'b1001:out=a9;
		4'b1010:out=a10;
		4'b1011:out=a11;
		4'b1100:out=a12;
		4'b1101:out=a13;
		4'b1110:out=a14;
		//4'b1111:out=a15;
		default:out=32'b0;
	endcase
assign result=out;

endmodule
