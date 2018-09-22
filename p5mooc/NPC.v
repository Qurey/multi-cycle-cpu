`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:13 11/23/2015 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [25:0] imm,
    input [31:0] PC4D,
    input [1:0] NPCsel,
	 input [31:0] RD1D,
	 input cmp,
    output [31:0] NPC,
	 output [31:0] PC_b_type
    );
	 wire [31:0] offset={{14{imm[15]}},imm[15:0],2'b0};
	
	 assign PC_b_type=(cmp===1)?PC4D+offset:PC4D+4;
	 
	 
	 assign NPC=(NPCsel==2'b00)?PC4D:
					(NPCsel==2'b01)?PC_b_type:   //beq
					(NPCsel==2'b10)?RD1D:          //jr
					(NPCsel==2'b11)?{PC4D[31:28],imm[25:0],2'b0}://j/jal
										PC4D;


endmodule
