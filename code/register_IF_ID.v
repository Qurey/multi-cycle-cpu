`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:08:09 11/23/2016 
// Design Name: 
// Module Name:    register_IF_ID 
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
module register_IF_ID(
    input clk,
	 input reset,
	 input ir_en,
    input [31:0] Instr_IF,
    input [31:0] pc_IF,
    output [31:0] pc_ID,
    output [31:0] Instr_ID
    );
reg [31:0]_pc_ID;
reg [31:0]_Instr_ID;
initial begin
_pc_ID=32'h00003000;
_Instr_ID=32'b0000_0000_0000_0000_0000_0000_0000_0000;
end
always @(posedge clk)begin
if(reset)begin
_pc_ID=32'h00003000;
_Instr_ID=0;
end
else begin
if(ir_en)begin
_pc_ID=pc_IF;
_Instr_ID=Instr_IF;
end
end
end
assign pc_ID=_pc_ID;
assign Instr_ID=_Instr_ID;

endmodule