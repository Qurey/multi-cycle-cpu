`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:19:42 11/22/2015 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(
	 input [5:0] op,     //P5.1 addu subu ori lui j
	 input [5:0] func,
	 output [1:0] RegDstD,     //00ѡrt,lw��cal_i��sw��Ҳ��rt����д��/01ѡrd, cal_r  write register //10ѡ 31�żĴ���  jal
	 output [1:0] EXTOpD, //00����չ 01������չ 10lui
	 output [1:0] MemtoRegD,		//д��Ĵ���  00ѡalu�����01ѡ��dm���,10ѡPC+8
	 output [1:0] NPCselD, //00ѡ��PC+4  01ѡ��ת�Ƶ�ַbeq /10ѡ��Ĵ�����ַ jr/11ѡ����ת��ַjal��j
	 output MemWriteD,     //DMдʹ��
	 output [1:0] ALUOpD,  //aluѡ�� 00+   01-   10| 
	 output ALUsrcD,		//0 r��ָ�� beqѡ��GPR��RD2�����   1 lw sw ori lui ѡ��ext�����
	 output RegWriteD,     //gpr дʹ��
	 output [1:0] pcsrc,   // 00,PC+4,,/01,j,jal,beq����ת/10,jr
	 output cal_rD,
	 output cal_iD,
	 output ldD,
	 output stD,
	 output b_typeD,
	 output jrD,
	 output jalD
    );
	 
	 wire addu=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0];
	 wire subu=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0]&func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];
	 wire ori=~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0];
	 wire lw=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
	 wire sw=op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
	 wire beq=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
	 wire lui=~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0];
	 wire jal=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
	 wire jr=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0];
	 wire j=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0];
	 
	 assign cal_rD=addu|subu; //������R��ָ��
	 assign cal_iD=lui|ori;		//������i��ָ��
	 assign ldD=lw;				//load��ָ��
	 assign stD=sw;				//store��ָ��
	 assign b_typeD=beq;         
	 assign jrD=jr;
	 assign jalD=jal;
	 
	 
	 assign RegDstD[1]=jal;
	 assign RegDstD[0]=cal_rD;
	 assign EXTOpD[1]=lui;
	 assign EXTOpD[0]=lw|sw;
	 assign MemtoRegD[1]=jal;
	 assign MemtoRegD[0]=lw;
	 assign NPCselD[1]=jr|jal|j;
	 assign NPCselD[0]=jal|beq|j;
	 assign MemWriteD=sw;
	 assign ALUOpD[1]=ori|jr|jal;
	 assign ALUOpD[0]=subu|beq|jr|jal;
	 assign ALUsrcD=lw|sw|ori|lui;
	 assign RegWriteD=addu|subu|lw|ori|lui|jal;
	 assign pcsrc[1]=jr;
	 assign pcsrc[0]=b_typeD|j|jal;
	 
	 
endmodule