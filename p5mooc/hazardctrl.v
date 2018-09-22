`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:27:38 11/23/2015 
// Design Name: 
// Module Name:    hazardctrl 
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
module hazardctrl(
    input [4:0] RsD,
    input [4:0] RtD,
    input [4:0] RdD,
    input [4:0] RsE,
    input [4:0] RtE,
    input [4:0] RdE,
    input [4:0] WriteRegE,
    input [4:0] WriteRegM,
    input [4:0] WriteRegW,
	 input b_typeD,
	 input jrD,
	 input cal_rE,
	 input cal_iE,
	 input cal_rM,
	 input cal_iM,
	 input cal_rW,
	 input cal_iW,
	 input ldE,
	 input stE,
	 input ldM,
	 input stM,
	 input ldW,
	 input stW,
	 input jalM,
	 input jalW,
    output [1:0] ForwardRSE,
    output [1:0] ForwardRTE,
	 output ForwardRSD,
	 output ForwardRTD,
	 output ForwardWDM
    );
	 
	 
	 
	 //ת������     ForwardRSE����ALUinputA��ת������ 00ΪԭRD1�����01ΪALU�����ת��AOM, 10ΪDMд�����ݵ�ת��MUX
	 assign ForwardRSE=(cal_rE|cal_iE|ldE|stE)&(cal_rM|cal_iM|jalM)&(RsE==WriteRegM)&RsE!=0?2'b01:
								//(RS)jal,cal_r,cal_i--cal_r,cal_i,ld,st
							 (cal_rE|cal_iE|ldE|stE)&(cal_rW|cal_iW|jalW)&(RsE==WriteRegW)&RsE!=0?2'b10: 
							 //(RS)jal,cal_r,cal_i--nop--cal_r,cal_i,ld,st
							 (cal_rE|cal_iE|ldE|stE)&ldW&(RsE==WriteRegW)&RsE!=0?2'b10:    
							 //(RS)ld--nop--cal_r,cal_i,ld,st
																	2'b00;
																	
	//	ForwardRSE����ALUinputB��ת������ 00ΪԭRD1�����01ΪALU�����ת��AOM, 10ΪDMд�����ݵ�ת��MUX															
	 assign ForwardRTE=(cal_rE|stE)&(cal_rM|cal_iM|jalM)&(RtE==WriteRegM)&RtE!=0?2'b01:	
								//(RT)jal,cal_r,cal_i--cal_r,store													
							 (cal_rE|stE)&(cal_rW|cal_iW|jalW)&(RtE==WriteRegW)&RtE!=0?2'b10: 
							 //(RT),jal,cal_r,cal_i--nop--cal_r,st	
							 (cal_rE|stE)&ldW&(RtE==WriteRegW)&RtE!=0?2'b10:   //(RT)load--nop--cal_r,st
																	2'b00;
	 

	 //GPR�������ID/EX�Ĵ���֮���ת����·ѡ������ 0ΪGPR���RD1��1ΪALU���ALUOutM
	 assign ForwardRSD=(b_typeD|jrD)&(cal_rM|cal_iM)&(RsD==WriteRegM)&RsD!=0?1:0;//beq���ж�
	 

	 assign ForwardRTD=(b_typeD|jrD)&(cal_rM|cal_iM)&(RtD==WriteRegM)&RsD!=0?1:0;
	 
	 //writedataM��DM��WD֮��Ķ�·ѡ����  0Ϊ������WritedataE�������1Ϊת����DMд������mux��ת������
	 //st��M�׶�WriteReg��ֵҲΪrt,���ǲ�дGPR,
	 assign ForwardWDM=(stM&ldW&(WriteRegM==WriteRegW))?1:0;//(RT)ld-st(ld��rt��st��rt��ͬ)


endmodule
