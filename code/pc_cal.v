`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:58:28 11/23/2016 
// Design Name: 
// Module Name:    pc_cal 
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
module pc_cal_ID(
    input [31:0] pc,
    input [31:0] Instr,
	 input [31:0] rpc,
    output [31:0] bpc,
	 output [31:0] jpc,
	 output [31:0] jrpc
    );
wire [31:0]offset;
assign offset={{14{Instr[15]}},Instr[15:0],2'b00};
assign bpc = pc+offset+4;
assign jpc = {pc[31:28],Instr[25:0],2'b00};
assign jrpc = rpc;

endmodule