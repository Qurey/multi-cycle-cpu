`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:34 12/06/2016 
// Design Name: 
// Module Name:    BEext 
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
module BEext(
    input [31:0] Addr,
    input [1:0] BEop,
    output [3:0] BE
    );
wire[1:0]A;
assign A=Addr[1:0];
assign BE=(BEop==0)?4'b1111:
			 (BEop==2'b01&A==2'b00)?4'b0001:
			 (BEop==2'b01&A==2'b01)?4'b0010:
			 (BEop==2'b01&A==2'b10)?4'b0100:
			 (BEop==2'b01&A==2'b11)?4'b1000:
			 (BEop==2'b10&A[1]==0) ?4'b0011:
			 (BEop==2'b10&A[1]==1) ?4'b1100:
											4'b0000;

endmodule
