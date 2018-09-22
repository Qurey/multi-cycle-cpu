`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:54:52 11/22/2015 
// Design Name: 
// Module Name:    IFID 
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
module IF_ID(
	input clk,
	input reset,
	input StallD,
	input [31:0] dout,        
	input [31:0] PC4F,
	output reg [31:0] InstrD,
	output reg [31:0] PC4D
    );
	 
	 
	 
	 always @(posedge clk or posedge reset)
	 begin
	 if(reset) begin
		PC4D<=0;
		InstrD<=0;
	 end
	 else if(StallD==0)begin
		PC4D<=PC4F;
		InstrD<=dout;
	 end
	 end

endmodule
