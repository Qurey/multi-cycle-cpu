`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:48 11/24/2016 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
	 );
wire pc_en;
wire [31:0]bpc;
wire [31:0]jpc;
wire [31:0]rdata;
wire [1:0]pc_select;
wire [31:0]Instr_IF_ID;
wire [31:0]pc_IF_ID;
wire if_branch;//判断是否满足b指令的跳转条件
IFU part0 (clk,reset,pc_en,bpc,jpc,rdata,pc_select,if_branch,Instr_IF_ID,pc_IF_ID);

assign pc=pc_IF_ID;
assign outInstr=Instr_IF_ID;  
assign pcsel=pc_select;

wire ir_en;
wire regwrite_WB;//WB阶段传回的写使能信号
wire [4:0]write_reg_addr;//WB传回的写入编号
wire [31:0]writedata;//WB传回的写入数据
wire [31:0]aluout_reg;//流水级寄存器的alu数据
wire [31:0]memout;//流水级经过Mux4的数据,涉及转发
wire [2:0]rs_select_ID;
wire [2:0]rt_select_ID;
wire [31:0]Instr_ID_EX;//传向下一级,输入进转发控制
wire [31:0]rsdata_ID_EX;
wire [31:0]rtdata_ID_EX;
wire [31:0]extension_ID_EX;
wire [31:0]pc_ID_EX;
wire [31:0]pc8_ID_EX;
wire [31:0]pc8_EX_M;//EX_M阶段可能转发的pc8

//暂停信号处理
wire [31:0]ID_instr;
wire ID_cal_r,ID_cal_rt,ID_cal_i,ID_load,ID_store,ID_rsrt,ID_rs_,ID_rt_,ID_muldiv;//ID_cal_rt为sll,sra,srl;ID_rsrt,ID_rs tuse=0;
wire [31:0]EX_instr;
wire EX_cal_r,EX_cal_i,EX_load;
wire [31:0]M_instr;
wire M_load;
//暂停控制模块所需的信号

IF_ID part1 (Instr_IF_ID,pc_IF_ID,clk,reset,ir_en,regwrite_WB,write_reg_addr,writedata,pc8_ID_EX,pc8_EX_M,aluout_reg,memout,rs_select_ID,rt_select_ID,
				Instr_ID_EX,rsdata_ID_EX,rtdata_ID_EX,extension_ID_EX,pc_ID_EX,bpc,jpc,rdata,pc_select,if_branch,
				ID_instr,ID_cal_r,ID_cal_rt,ID_cal_i,ID_load,ID_store,ID_rsrt,ID_rs_,ID_rt_,ID_muldiv);
wire clr;
wire [1:0]rs_select_EX;
wire [1:0]rt_select_EX;
wire [31:0]aluout_EX_M;//传向下一级
wire [31:0]rtdata_EX_M;
wire [31:0]Instr_EX_M;//输入进转发控制
wire [31:0]pc_M;

wire ifjal_ID_EX;//id_ex阶段可能涉及转发的信号
wire ifjalr_ID_EX;
wire busy,ifmuldiv;

ID_EX part2 (clk,clr,reset,Instr_ID_EX,rsdata_ID_EX,rtdata_ID_EX,extension_ID_EX,pc_ID_EX,pc8_EX_M,aluout_reg,memout,rs_select_EX,rt_select_EX,	
				aluout_EX_M,rtdata_EX_M,Instr_EX_M,pc_M,pc8_ID_EX,ifjal_ID_EX,ifjalr_ID_EX,EX_instr,EX_cal_r,EX_cal_i,EX_load,busy,ifmuldiv );

//wire [31:0]Instr_M_WB;
wire [31:0]aluout_M_WB;
assign aluout_M_WB = aluout_reg;
wire [31:0]pc_WB;
wire [31:0]memdata;//数据存储器中的值输入进WB

wire EX_M_cal_r;
wire EX_M_cal_i;
wire [31:0]Instr_M_WB;//进转发机制
wire dm_sel;//在ex_m阶段的转发选择信号

wire ifjal_EX_M;//EX_M阶段是否为Jal指令
wire ifjalr_EX_M;

EX_M part3(clk,reset,Instr_EX_M,pc_M,aluout_EX_M,rtdata_EX_M,memout,dm_sel, aluout_reg,memdata,pc_WB,
			pc8_EX_M,ifjal_EX_M,ifjalr_EX_M,EX_M_cal_r,EX_M_cal_i,Instr_M_WB,M_instr,M_load);//

wire [31:0]Instr_WB;//进转发控制单元
wire WB_cal_r;
wire WB_cal_i;
wire ifjal_M_WB;
wire ifjalr_M_WB;
M_WB part4(clk,reset,Instr_M_WB,pc_WB,aluout_M_WB,memdata,memout,write_reg_addr,writedata,regwrite_WB,Instr_WB,WB_cal_r,WB_cal_i,ifjal_M_WB,ifjalr_M_WB);

bypassctrl part5(Instr_ID_EX,Instr_EX_M,Instr_M_WB,Instr_WB,EX_M_cal_r,EX_M_cal_i,WB_cal_r,WB_cal_i,
						ifjal_ID_EX,ifjal_EX_M,ifjal_M_WB,
						ifjalr_ID_EX,ifjalr_EX_M,ifjalr_M_WB,
						rs_select_ID,rt_select_ID,rs_select_EX,rt_select_EX,dm_sel);

stallctr stall(ID_instr,ID_cal_r,ID_cal_rt,ID_cal_i,ID_load,ID_store,ID_rsrt,ID_rs_,ID_rt_,ID_muldiv,busy,ifmuldiv
					,EX_instr,EX_cal_r,EX_cal_i,EX_load,M_instr,M_load,
					ir_en,clr,pc_en);


endmodule
