`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:03:48 11/23/2016 
// Design Name: 
// Module Name:    extension 
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
module extension_ID(
    input [31:0] instr,
    output [31:0] zero,
	 output [31:0] sign
    );
	wire[15:0]offset;
	assign offset=instr[15:0];
	assign zero={16'b0000_0000_0000_0000,offset};
	assign sign={{16{offset[15]}},offset};
	

endmodule