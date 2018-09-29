`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:02:59 11/23/2016 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
    input [31:0] Instr_IF,
    input [31:0] pc_IF,
    input clk,
    input reset,
	 input ir_en,
	 input regwrite,
    input [4:0] write_regaddr,
    input [31:0] writedata,
    input [31:0] pc8_ID_EX,
	 input [31:0] pc8_EX_M,
    input [31:0] aluout,
    input [31:0] memout,
	 input [2:0] rs_select_ID,
	 input [2:0] rt_select_ID,
    
	 output [31:0] Instr_ID,
    output [31:0] rsdata,
    output [31:0] rtdata,
    output [31:0] extension,
    output [31:0] PC,
	 
	 output [31:0] bpc,//pc计算单元计算出传回前一级单元
	 output [31:0] jpc,
	 output [31:0] raddr,//地址
	 output [1:0]  pc_select,
	 output if_branch,
	 
	 output [31:0]ID_instr,
	 output ID_cal_r,
	 output ID_cal_rt,
	 output ID_cal_i,
	 output ID_load,
	 output ID_store,//传出当前指令类型
	 output ID_rsrt,
	 output ID_rs,
	 output ID_rt,//rsrt,rs,rt tuse=0;
	 output ID_muldiv
    );
wire [31:0] IDPC;
wire [31:0] IDInstr;
register_IF_ID s0 (clk,reset,ir_en,Instr_IF,pc_IF,IDPC,IDInstr);  //IF_ID寄存器,取出ID阶段的PC和指令

assign Instr_ID=IDInstr;//模块输出的指令
assign PC=IDPC;			//模块输出的地址（原pc）
assign ID_instr=IDInstr;

wire [4:0]rs;
wire [4:0]rt;
wire [31:0]grf_rs;//从grf中取出的rs数据
wire [31:0]grf_rt;//从grf中取出的rt数据
assign rs=IDInstr[25:21];
assign rt=IDInstr[20:16];
grf s1(clk,reset,write_regaddr,regwrite,writedata,rs,rt,grf_rs,grf_rt);//取出rs,rt的值

pc_cal_ID s2(IDPC,IDInstr,rsdata,bpc,jpc,raddr);// 计算bpc和jpc

wire [31:0]zeroext;
wire [31:0]signext;
extension_ID s3(IDInstr,zeroext,signext);
assign extension =(extop==0)? zeroext:signext;//做扩展

wire extop;
controller_ID s4(IDInstr,rsdata,rtdata,extop,
						ID_cal_r,ID_cal_rt,ID_cal_i,ID_load,ID_store,ID_rsrt,ID_rs,ID_rt,ID_muldiv,pc_select,if_branch);

mux8  rsD(grf_rs,pc8_ID_EX,pc8_EX_M,aluout,memout,,,,rs_select_ID,rsdata);
mux8  rtD(grf_rt,pc8_ID_EX,pc8_EX_M,aluout,memout,,,,rt_select_ID,rtdata);//经转发分析后得到的以后要被使用的rs,td的值

//assign raddr = rsdata;
//assign if_branch = (rsdata == rtdata)? 1:0;

endmodule
