`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:08 11/23/2016 
// Design Name: 
// Module Name:    ID_EX 
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
	 input clr, //���ID_EX�Ĵ���
	 input reset,
    input [31:0]Instr_ID,
	 input [31:0]rsdata_ID,
	 input [31:0]rtdata_ID,
	 input [31:0]extension_ID,
	 input [31:0]pc_ID,	//����ID_EX�Ĵ���������
	 
	 input [31:0]pc8,
	 input [31:0]aluout,
	 input [31:0]memout,
	 input [1:0] rs_select,
	 input [1:0] rt_select,//ת���ź�
	 
	 output [31:0]aluresult_EX,
	 output [31:0]rtdata_EX,
	 output [31:0]Instr_EX,
	 output [31:0]PC_EX,
	 
	 output [31:0]_pc8,
	 output ifjal,
	 output ifjalr,
	 output [31:0]EX_instr,
	 output EX_cal_r,
	 output EX_cal_i,
	 output EX_load,
	 output busy,//�漰��ͣ
    output ifmuldiv
	 );
wire [31:0] Instr;
wire [31:0] pc;
wire [31:0] rsdata;
wire [31:0] rtdata;
wire [31:0] extension;
wire [31:0]alunum1;
wire [31:0]_alunum2;
wire [31:0]alunum2;
register_ID_EX s0 (clk,clr,reset,Instr_ID,pc_ID,rsdata_ID,rtdata_ID,extension_ID,Instr,pc,rsdata,rtdata,extension);
wire alusrc;
wire [3:0]aluop;

wire hilo;//ָ����mthi,����mtlo,0��mtlo,1��mthi
wire [2:0]mul_divop;//ִ�еĳ˳�ָ��000multu,001mult,010divu,011div
wire start;
wire hilowrite;
wire ifmfhi,ifmflo;
controller_Ex s1(Instr,alusrc,aluop,EX_cal_r,EX_cal_i,EX_load,ifjal,ifjalr,hilo,mul_divop,start,hilowrite,ifmfhi,ifmflo,ifmuldiv);//�õ���ָ���alu��������Դ��ִ�е�alu����


mux4 rsE (rsdata,pc8,aluout,memout,rs_select,alunum1);
mux4 rtE (rtdata,pc8,aluout,memout,rt_select,_alunum2);//ѡ�����پ���alusrcѡ��
assign alunum2 = (alusrc==0)? _alunum2:extension;

wire [31:0]direct_aluresult_EX;
alu s2 (Instr,aluop,alunum1,alunum2,alunum1,alunum2,direct_aluresult_EX);//��alu���������mfhi,mflo�Ƚϵó�

//wire busy;
wire [31:0]hidata;
wire [31:0]lodata;
mult_div s3(clk,reset,alunum1,alunum2,hilo,mul_divop,start,hilowrite,busy,hidata,lodata);

assign aluresult_EX= (ifmfhi==1)?hidata:(ifmflo==1)?lodata:direct_aluresult_EX;
//mux4 alu (aluout0,aluout1,aluout2,aluout3,aluop[1:0],aluresult_EX);
assign rtdata_EX = _alunum2;//����ת��ѡ����rtֵ
assign Instr_EX = Instr;
assign PC_EX = pc;
assign _pc8=pc+8;
assign EX_instr = Instr;

endmodule
