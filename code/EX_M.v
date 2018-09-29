`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:02:35 11/23/2016 
// Design Name: 
// Module Name:    EX_M 
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
module EX_M(
    input clk,
	 input reset,
	 input [31:0]Instr_M,//命名方式以当前执行的指令而命名
	 input [31:0]pc_M,
	 input [31:0]aluout_M,
	 input [31:0]rtdata_M,
	 input [31:0]new_rt_data,
	 input dm_sel,
	 //output [31:0]Instr_WB,
	 output [31:0]aluout_WB,
	 output [31:0]memdata,
	 output [31:0]PC,
	 //output [31:0]bypass_aluresult,//来自寄存器，旁路转发的结果
	 output [31:0]pc8,
	 output ifjal,
	 output ifjalr,
	 output bypass_cal_r,
	 output bypass_cal_i,
	 output [31:0]bypass_Instr,
	 output [31:0]M_instr,
	 output EX_load
	 
    );
wire [31:0]Instr;
wire [31:0]pc;
wire [31:0]aluout;
wire [31:0]rtdata;

register_Ex_M s0(clk,reset,Instr_M,pc_M,aluout_M,rtdata_M,Instr,pc,aluout,rtdata);

assign bypass_Instr = Instr;
wire memwrite;
wire [1:0]BEop;
controller_M s1(Instr,memwrite,BEop,bypass_cal_r,bypass_cal_i,ifjal,ifjalr,EX_load);

wire [31:0]write_in_dm;
assign write_in_dm = (dm_sel==0)? rtdata:new_rt_data;

wire [3:0]BE;
BEext s3(aluout,BEop,BE);

dm s2 (clk,reset,memwrite,BE,write_in_dm,memdata,aluout);
//assign Instr_WB=Instr;
assign aluout_WB=aluout;
assign PC=pc;
assign pc8=pc+8;
assign M_instr=Instr;

endmodule
