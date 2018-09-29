`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:08:58 11/23/2016 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input clk,
    input reset,
    input pc_en,
    input [31:0] bpc,
    input [31:0] jpc,
    input [31:0] rdata,
    input [1:0] pc_select,
	 input if_branch,
    output [31:0] Instr,
    output [31:0] pc
    );
wire [31:0]npc;
wire [31:0]_npc;
wire [31:0]jrdata;

pc_IFU s0 (clk,reset,npc,bpc,jpc,jrdata,pc_select,if_branch,pc_en,_npc);

im  s1(_npc,Instr);

assign pc=_npc;

assign npc = (pc_en==0)? _npc :_npc+4;
assign jrdata = (pc_en==0)?_npc+4:rdata;

endmodule
