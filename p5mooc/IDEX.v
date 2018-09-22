`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:13:22 11/22/2015 
// Design Name: 
// Module Name:    IDEX 
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
module ID_EX(
	 input clk,
	 input reset,
	 input FlushE,
	 input [1:0]RegDstD,       //0选rt,lw  /1选rd, R  write register
	 input [1:0] MemtoRegD,		//写入寄存器  00选alu输出，01选择dm输出,10选PC+8。jal   
	 input MemWriteD,     //DM写使能
	 input [1:0] ALUOpD,  //alu选择 00+   01-   10| 
	 input ALUsrcD,		//0 r型指令 beq选择GPR的RD2输出，   1 lw sw ori lui 选择ext的输出
	 input RegWriteD,     //gpr 写使能
	 input [31:0] PC8D,
	 input [4:0] RsD,
	 input [4:0] RtD,
	 input [4:0] RdD,
	 input [31:0] RD1D,
	 input [31:0] RD2D,
	 input [31:0] extD,
	 input cal_rD,
	 input cal_iD,
	 input ldD,
	 input stD,
	 input jalD,
	 output reg [1:0] RegDstE,
	 output reg [1:0] MemtoRegE,
	 output reg MemWriteE,
	 output reg [1:0] ALUOpE,
	 output reg ALUsrcE,
	 output reg RegWriteE,
	 output reg [31:0] PC8E,
	 output reg [4:0] RsE,
	 output reg [4:0] RtE,
	 output reg [4:0] RdE,
	 output reg [31:0] RD1E,
	 output reg [31:0] RD2E,
	 output reg [31:0] extE,
	 output reg cal_rE,
	 output reg cal_iE,
	 output reg ldE,
	 output reg stE,
	 output reg jalE
    );
	 
	 always @(posedge clk  or posedge reset)
	 begin
		if(reset|FlushE==1) begin
			RegDstE <= 0;
			MemtoRegE<=0;
			MemWriteE<=0;
			ALUOpE<=0;
			ALUsrcE<=0;
			RegWriteE<=0;
			RsE<=0;
			RtE<=0;
			RdE<=0;
			RD1E<=0;
			RD2E<=0;
			cal_rE<=0;
			cal_iE<=0;
			extE<=0;
			ldE<=0;
			stE<=0;
			PC8E<=0;
			jalE<=0;
		end
		else begin
			RegDstE <= RegDstD ;
			MemtoRegE<=MemtoRegD;
			MemWriteE<=MemWriteD;
			ALUOpE<=ALUOpD;
			ALUsrcE<=ALUsrcD;
			RegWriteE<=RegWriteD;
			RsE<=RsD;
			RtE<=RtD;
			RdE<=RdD;
			RD1E<=RD1D;
			RD2E<=RD2D;
			cal_rE<=cal_rD;
			cal_iE<=cal_iD;
			extE<=extD;
			ldE<=ldD;
			stE<=stD;
			PC8E<=PC8D;
			jalE<=jalD;
		end
	 end
	 
endmodule
