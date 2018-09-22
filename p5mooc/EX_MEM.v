`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:14:46 11/23/2015 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
	 input clk,
	 input reset,
	 input RegWriteE, //GPR写使能
	 input [1:0] MemtoRegE, //写入寄存器  0选alu输出，1选择dm输出
	 input MemWriteE,	//DM写使能
	 input [31:0] ALUOutE,   //ALU输出
	 input [31:0] WriteDataE, //写入DM的数据
	 input [4:0] WriteRegE,  //写入GPR的地址
	 input [31:0] PC8E,
	 input cal_rE,
	 input cal_iE,
	 input ldE,
	 input stE,
	 input jalE,
	 output reg RegWriteM,
	 output reg [1:0] MemtoRegM,
	 output reg MemWriteM,
	 output reg [31:0] ALUOutM,
	 output reg [31:0] WriteDataM,
	 output reg [4:0] WriteRegM,
	 output reg [31:0] PC8M,
	 output reg cal_rM,
	 output reg cal_iM,
	 output reg ldM,
	 output reg stM,
	 output reg jalM
    );
	 
	 always @(posedge clk or posedge reset)
	 begin
	 if(reset) begin
		RegWriteM<=0;
		MemtoRegM<=0;
		MemWriteM<=0;
		ALUOutM<=0;
		WriteDataM<=0;
		WriteRegM<=0;
		cal_rM<=0;
		cal_iM<=0;
		ldM<=0;
		stM<=0;
		PC8M<=0;
		jalM<=0;
	 end
	 else begin
		RegWriteM<=RegWriteE;
		MemtoRegM<=MemtoRegE;
		MemWriteM<=MemWriteE;
		ALUOutM<=ALUOutE;
		WriteDataM<=WriteDataE;
		WriteRegM<=WriteRegE;
		cal_rM<=cal_rE;
		cal_iM<=cal_iE;
		ldM<=ldE;
		stM<=stE;
		PC8M<=PC8E;
		jalM<=jalE;
		
	 end
	 end

endmodule
