`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:18:42 11/22/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] inputA,
    input [31:0] inputB,
    input [1:0] ALUOp,
    output [31:0] result
    );
	 assign result=(ALUOp==2'b00)?inputA+inputB:
						(ALUOp==2'b01)?inputA-inputB:
						(ALUOp==2'b10)?inputA|inputB:
												32'b0;
	 
	 
endmodule