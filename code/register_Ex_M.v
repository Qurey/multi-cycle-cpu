`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:43:39 11/23/2016 
// Design Name: 
// Module Name:    register_Ex_M 
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
module register_Ex_M(
	 input clk,
	 input reset,
    input [31:0]instr_Ex,
	 input [31:0]pc4_Ex,
	 input [31:0]alu,
	 input [31:0]rtdata,
	 
	 output [31:0]instr_M,
	 output [31:0]pc4_M,
	 output [31:0]aluout,
	 output [31:0]rtdata_M
    );
reg [31:0]_instr_M;
reg [31:0]_pc4_M;
reg [31:0]_aluout;
reg [31:0]_rtdata_M;
initial begin
_instr_M = 0;
	_pc4_M = 32'h3000;
	_aluout = 0;
	_rtdata_M = 0;
	end
always @(posedge clk)begin
if (reset)begin
	_instr_M = 0;
	_pc4_M = 32'h3000;
	_aluout = 0;
	_rtdata_M = 0;
end
else begin
_instr_M = instr_Ex;
_pc4_M = pc4_Ex;
_aluout = alu;
_rtdata_M = rtdata;
end
end
assign instr_M = _instr_M;
assign pc4_M = _pc4_M;
assign aluout = _aluout;
assign rtdata_M = _rtdata_M;


endmodule
