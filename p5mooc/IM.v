`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:24:54 11/22/2015 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [9:2] addr,
    output [31:0] dout
    );
	 integer i;
	reg [31:0] im [255:0];
	initial begin
	for(i=0;i<256;i=i+1) begin
		im[i]=32'b0;
	end
	$readmemb("code.txt",im); //用文件内容来初始化im
	end
	
	
	assign dout=im[addr];
endmodule