`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:47:52 11/22/2015 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [11:2] addr, 
    input [31:0] din,  //32bit input data
    input MemWrite,         //写使能
    input clk,				
    output [31:0] dout	//32-bit memory output
    );
	 integer i;
	 reg [31:0] dm [1023:0];
	 
	 
	 initial begin
	 for(i=0;i<1024;i=i+1) begin
		 dm[i]=32'b0;
	 end
//	 $readmemb("data.txt",dm); //用文件内容来初始化im
	 end
	 
	 assign dout=dm[addr];
	 always @(posedge clk)
	 begin
	 if(MemWrite) begin
	 dm[addr]=din;
	 end
	 end


endmodule
