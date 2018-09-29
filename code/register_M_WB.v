`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:47 11/24/2016 
// Design Name: 
// Module Name:    register_M_WB 
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
module register_M_WB(
	 input  clk,
	 input  reset,
    input [31:0] instr_m,
	 input [31:0] pc4,
	 input [31:0] alu,
	 input [31:0] memdata,
	 output [31:0] instr_B,
	 output [31:0] pc4_B,
	 output [31:0] alu_B,
	 output [31:0] memdata_B
    );
reg [31:0] _instr_B;
reg [31:0] _pc4_B;
reg [31:0] _alu_B;
reg [31:0] _memdata_B;
initial begin
_instr_B=0;
	_pc4_B=32'h3000;
	_alu_B=0;
	_memdata_B=0;
end
always @(posedge clk)begin
if(reset)begin
	_instr_B=0;
	_pc4_B=32'h3000;
	_alu_B=0;
	_memdata_B=0;
end
else begin		
	_instr_B=instr_m;
	_pc4_B=pc4;
	_alu_B=alu;
	_memdata_B=memdata;
end
end
assign instr_B = _instr_B;
assign pc4_B = _pc4_B;
assign alu_B = _alu_B;
assign memdata_B = _memdata_B;

endmodule
