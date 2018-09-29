`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:42 12/06/2016 
// Design Name: 
// Module Name:    DM_ext 
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
module DM_ext(
    input [31:0] addr,
    input [31:0] memdata,
    input [2:0] op,
    output [31:0] Dout
    );
wire [1:0]A;//表示低两位地址
assign A=addr[1:0];

//000无扩展，001无符号字节扩展，010符号字节，011无符号半字，100符号半字
assign Dout = (op==3'b000)?memdata://lw
				  (op==3'b001&A==2'b00)?{24'b0,memdata[7:0]}:
				  (op==3'b001&A==2'b01)?{24'b0,memdata[15:8]}:
				  (op==3'b001&A==2'b10)?{24'b0,memdata[23:16]}:
				  (op==3'b001&A==2'b11)?{24'b0,memdata[31:24]}://lbu
				  (op==3'b010&A==2'b00)?{{24{memdata[7]}},memdata[7:0]}:
				  (op==3'b010&A==2'b01)?{{24{memdata[15]}},memdata[15:8]}:
				  (op==3'b010&A==2'b10)?{{24{memdata[23]}},memdata[23:16]}:
				  (op==3'b010&A==2'b11)?{{24{memdata[31]}},memdata[31:24]}://lb
				  (op==3'b011&A[1]==0)?{16'b0,memdata[15:0]}:
				  (op==3'b011&A[1]==1)?{16'b0,memdata[31:16]}://lhu
				  (op==3'b100&A[1]==0)?{{16{memdata[15]}},memdata[15:0]}:
				  (op==3'b100&A[1]==1)?{{16{memdata[31]}},memdata[31:16]}://lh
				  memdata;


endmodule
