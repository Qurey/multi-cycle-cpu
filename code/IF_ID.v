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
	 
	 output [31:0] bpc,//pc���㵥Ԫ���������ǰһ����Ԫ
	 output [31:0] jpc,
	 output [31:0] raddr,//��ַ
	 output [1:0]  pc_select,
	 output if_branch,
	 
	 output [31:0]ID_instr,
	 output ID_cal_r,
	 output ID_cal_rt,
	 output ID_cal_i,
	 output ID_load,
	 output ID_store,//������ǰָ������
	 output ID_rsrt,
	 output ID_rs,
	 output ID_rt,//rsrt,rs,rt tuse=0;
	 output ID_muldiv
    );
wire [31:0] IDPC;
wire [31:0] IDInstr;
register_IF_ID s0 (clk,reset,ir_en,Instr_IF,pc_IF,IDPC,IDInstr);  //IF_ID�Ĵ���,ȡ��ID�׶ε�PC��ָ��

assign Instr_ID=IDInstr;//ģ�������ָ��
assign PC=IDPC;			//ģ������ĵ�ַ��ԭpc��
assign ID_instr=IDInstr;

wire [4:0]rs;
wire [4:0]rt;
wire [31:0]grf_rs;//��grf��ȡ����rs����
wire [31:0]grf_rt;//��grf��ȡ����rt����
assign rs=IDInstr[25:21];
assign rt=IDInstr[20:16];
grf s1(clk,reset,write_regaddr,regwrite,writedata,rs,rt,grf_rs,grf_rt);//ȡ��rs,rt��ֵ

pc_cal_ID s2(IDPC,IDInstr,rsdata,bpc,jpc,raddr);// ����bpc��jpc

wire [31:0]zeroext;
wire [31:0]signext;
extension_ID s3(IDInstr,zeroext,signext);
assign extension =(extop==0)? zeroext:signext;//����չ

wire extop;
controller_ID s4(IDInstr,rsdata,rtdata,extop,
						ID_cal_r,ID_cal_rt,ID_cal_i,ID_load,ID_store,ID_rsrt,ID_rs,ID_rt,ID_muldiv,pc_select,if_branch);

mux8  rsD(grf_rs,pc8_ID_EX,pc8_EX_M,aluout,memout,,,,rs_select_ID,rsdata);
mux8  rtD(grf_rt,pc8_ID_EX,pc8_EX_M,aluout,memout,,,,rt_select_ID,rtdata);//��ת��������õ����Ժ�Ҫ��ʹ�õ�rs,td��ֵ

//assign raddr = rsdata;
//assign if_branch = (rsdata == rtdata)? 1:0;

endmodule
