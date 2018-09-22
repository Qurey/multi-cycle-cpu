`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:03 11/22/2015 
// Design Name: 
// Module Name:    PC 
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
module PC(
	 input clk,
	 input reset,
    input [31:0] NPC,
	 input StallF,
    output reg[31:0] PCF
    );
	 
	 always @(posedge clk or posedge reset)
	 begin
	 if(reset) begin
	 PCF <= 32'b0000_0000_0000_0000_0011_0000_0000_0000;
	 end
	 else if(StallF==0) begin
	 PCF <= NPC;
	 end
	 end
	

endmodule
