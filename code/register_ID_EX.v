`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:24:59 11/23/2016 
// Design Name: 
// Module Name:    register_ID_EX 
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
module register_ID_EX(
    input clk,
    input clr,
	 input reset,
    input [31:0] Instr_ID,
    input [31:0] pc4,
    input [31:0] rsdata,
    input [31:0] rtdata,
    input [31:0] ext,
    output [31:0] Instr_Ex,
    output [31:0] pc4_Ex,
    output [31:0] rsdata_Ex,
    output [31:0] rtdata_Ex,
    output [31:0] ext_Ex
    );
reg [31:0]_Instr_ex;
reg [31:0]_pc4;
reg [31:0]_rsdata;
reg [31:0]_rtdata;
reg [31:0]_ext;
initial begin
_Instr_ex <= 0;
    _pc4 <= 0;
    _rsdata <= 0;
    _rtdata <= 0;
    _ext <= 0;
end
always @(posedge clk)begin
if (reset)begin
	 _Instr_ex <= 0;
    _pc4 <= 0;
    _rsdata <= 0;
    _rtdata <= 0;
    _ext <= 0;
end
else if(clr)begin
    _Instr_ex <= 0;
    _pc4 <= 0;
    _rsdata <= 0;
    _rtdata <= 0;
    _ext <= 0;
end

else begin  
    _Instr_ex <= Instr_ID;
    _pc4 <= pc4;
    _rsdata <= rsdata;
    _rtdata <= rtdata;
    _ext <= ext;
end
end
assign Instr_Ex = _Instr_ex;
assign pc4_Ex = _pc4;
assign rsdata_Ex = _rsdata;
assign rtdata_Ex = _rtdata;
assign ext_Ex = _ext;

endmodule
