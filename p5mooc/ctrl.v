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
	 output [1:0] RegDstD,     //00选rt,lw，cal_i（sw的也是rt但不写）/01选rd, cal_r  write register //10选 31号寄存器  jal
	 output [1:0] EXTOpD, //00零扩展 01符号扩展 10lui
	 output [1:0] MemtoRegD,		//写入寄存器  00选alu输出，01选择dm输出,10选PC+8
	 output [1:0] NPCselD, //00选择PC+4  01选择转移地址beq /10选择寄存器地址 jr/11选择跳转地址jal和j
	 output MemWriteD,     //DM写使能
	 output [1:0] ALUOpD,  //alu选择 00+   01-   10| 
	 output ALUsrcD,		//0 r型指令 beq选择GPR的RD2输出，   1 lw sw ori lui 选择ext的输出
	 output RegWriteD,     //gpr 写使能
	 output [1:0] pcsrc,   // 00,PC+4,,/01,j,jal,beq等跳转/10,jr
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
	 
	 assign cal_rD=addu|subu; //计算类R型指令
	 assign cal_iD=lui|ori;		//计算类i型指令
	 assign ldD=lw;				//load类指令
	 assign stD=sw;				//store类指令
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