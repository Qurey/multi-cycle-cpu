`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:15:35 11/23/2016 
// Design Name: 
// Module Name:    pc_IFU 
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
module pc_IFU(
    input clk,
	 input reset,
    input [31:0] pc_pc4,
    input [31:0] bpc,
    input [31:0] jpc,
    input [31:0] rpc,
    input [1:0] pc_select,
	 input if_branch,
	 input pc_en,
    output [31:0] PC
    );
reg [31:0]_PC;
initial begin
_PC=32'h00003000;
end  
always @(posedge clk)begin
	if(reset)
		_PC<=32'h00003000;
	else if(pc_en)begin
		case(pc_select)
		2'b00: _PC<=pc_pc4;
		2'b01: _PC<=(if_branch==1)? bpc:pc_pc4;
		2'b10: _PC<=jpc;
		2'b11: _PC<=rpc;
		default:_PC<=32'h00003000;
		endcase
	end
	else begin
	_PC<=pc_pc4;
	end
end
assign PC=_PC;

endmodule
