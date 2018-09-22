`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:46:12 11/26/2015 
// Design Name: 
// Module Name:    CMP 
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
module CMP(                //实现b类指令的比较操作
    input [31:0] A,
    input [31:0] B,
    output cmp            //Br=1，条件成立；   Br=0，条件不成立
    );
	 assign cmp=(A===B)?1:0;


endmodule
