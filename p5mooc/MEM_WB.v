`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:27 11/23/2015 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
	 input clk,
	 input reset,
    input RegWriteM,
    input [1:0] MemtoRegM,
    input [31:0] ReadDataM,
    input [31:0] ALUOutM,
    input [4:0] WriteRegM,
	 input [31:0] PC8M,
	 input cal_rM,
	 input cal_iM,
	 input ldM,
	 input stM,
	 input jalM,
    output reg RegWriteW,
    output reg [1:0] MemtoRegW,
    output reg [31:0] ReadDataW,
    output reg [31:0] ALUOutW,
    output reg [4:0] WriteRegW,
	 output reg [31:0] PC8W,
	 output reg cal_rW,
	 output reg cal_iW,
	 output reg ldW,
	 output reg stW,
	 output reg jalW

    );
	 
	 always @(posedge clk or posedge reset)
	 begin
	 if(reset) begin
		RegWriteW<=0;
		MemtoRegW<=0;
		ReadDataW<=0;
		ALUOutW<=0;
		WriteRegW<=0;
		cal_rW<=0;
		cal_iW<=0;
		ldW<=0;
		stW<=0;
		PC8W<=0;
		jalW<=0;
	 end
	 else begin
		RegWriteW<=RegWriteM;
		MemtoRegW<=MemtoRegM;
		ReadDataW<=ReadDataM;
		ALUOutW<=ALUOutM;
		WriteRegW<=WriteRegM;
		cal_rW<=cal_rM;
		cal_iW<=cal_iM;
		ldW<=ldM;
		stW<=stM;
		PC8W<=PC8M;
		jalW<=jalM;
	 end
	 end


endmodule
