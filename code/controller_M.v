`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:19 11/24/2016 
// Design Name: 
// Module Name:    controller_M 
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
module controller_M(
    input [31:0] Instr,
	 output memwrite,
	 output [1:0]BEop,//00sw,01sb,10sh
	 output cal_r,
	 output cal_i,
	 output ifjal,
	 output ifjalr,
	 output M_load
    );
wire addu,subu,ori,add,sub,mult,multu,div,divu,sll,srl,sra,sllv,srlv,srav,and_,or_,xor_,nor_,addi,addiu,andi,
		xori,lui,slt,slti,sltiu,sltu,	mfhi,mflo,mthi,mtlo,
		sw,lw,lb,lbu,lh,lhu,sb,sh,
		beq,bne,blez,bgtz,bltz,bgez,
		j,jal,jr,jalr;
		
//计算类指令/包括涉及乘除
assign addu = (~|Instr[31:26])&Instr[5]&(~|Instr[4:1])&Instr[0];
assign subu = (~|Instr[31:26])&Instr[5]&(~|Instr[4:2])&Instr[1]&Instr[0];
assign ori	=  ~Instr[31]&~Instr[30]&Instr[29]&Instr[28]&~Instr[27]&Instr[26];
assign lui	=	~Instr[31]&~Instr[30]&Instr[29]&Instr[28]&Instr[27]&Instr[26];
assign add  =  (~|Instr[31:26])&Instr[5]&(~|Instr[4:0]);
assign addi =  ~Instr[31]&~Instr[30]&Instr[29]&~Instr[28]&~Instr[27]&~Instr[26];
assign addiu=  ~Instr[31]&~Instr[30]&Instr[29]&~Instr[28]&~Instr[27]&Instr[26];
assign and_ =  (~|Instr[31:26])&Instr[5]&~Instr[4]&~Instr[3]&Instr[2]&~Instr[1]&~Instr[0];
assign andi =  ~Instr[31]&~Instr[30]&Instr[29]&Instr[28]&~Instr[27]&~Instr[26];
assign div  =  (~|Instr[31:26])&~Instr[5]&Instr[4]&Instr[3]&~Instr[2]&Instr[1]&~Instr[0];
assign divu =  (~|Instr[31:26])&~Instr[5]&Instr[4]&Instr[3]&~Instr[2]&Instr[1]&Instr[0];
assign mfhi =  (~|Instr[31:26])&~Instr[5]&Instr[4]&~Instr[3]&~Instr[2]&~Instr[1]&~Instr[0];
assign mflo =  (~|Instr[31:26])&~Instr[5]&Instr[4]&~Instr[3]&~Instr[2]&Instr[1]&~Instr[0];
assign mthi =  (~|Instr[31:26])&~Instr[5]&Instr[4]&~Instr[3]&~Instr[2]&~Instr[1]&Instr[0];
assign mtlo =  (~|Instr[31:26])&~Instr[5]&Instr[4]&~Instr[3]&~Instr[2]&Instr[1]&Instr[0];
assign mult =  (~|Instr[31:26])&~Instr[5]&Instr[4]&Instr[3]&~Instr[2]&~Instr[1]&~Instr[0];
assign multu=  (~|Instr[31:26])&~Instr[5]&Instr[4]&Instr[3]&~Instr[2]&~Instr[1]&Instr[0];
assign nor_ =  (~|Instr[31:26])&Instr[5]&~Instr[4]&~Instr[3]&Instr[2]&Instr[1]&Instr[0];
assign or_  =  (~|Instr[31:26])&Instr[5]&~Instr[4]&~Instr[3]&Instr[2]&~Instr[1]&Instr[0];
assign sll  =  (~|Instr[31:26])&(~|Instr[5:0]);
assign sllv =  (~|Instr[31:26])&~Instr[5]&~Instr[4]&~Instr[3]&Instr[2]&~Instr[1]&~Instr[0];
assign slt  =  (~|Instr[31:26])&Instr[5]&~Instr[4]&Instr[3]&~Instr[2]&Instr[1]&~Instr[0];
assign slti =  ~Instr[31]&~Instr[30]&Instr[29]&~Instr[28]&Instr[27]&~Instr[26];
assign sltiu=  ~Instr[31]&~Instr[30]&Instr[29]&~Instr[28]&Instr[27]&Instr[26];
assign sltu =  (~|Instr[31:26])&Instr[5]&~Instr[4]&Instr[3]&~Instr[2]&Instr[1]&Instr[0];
assign sra  =  (~|Instr[31:26])&~Instr[5]&~Instr[4]&~Instr[3]&~Instr[2]&Instr[1]&Instr[0];
assign srav =  (~|Instr[31:26])&~Instr[5]&~Instr[4]&~Instr[3]&Instr[2]&Instr[1]&Instr[0];
assign srl  =  (~|Instr[31:26])&~Instr[5]&~Instr[4]&~Instr[3]&~Instr[2]&Instr[1]&~Instr[0];
assign srlv =  (~|Instr[31:26])&~Instr[5]&~Instr[4]&~Instr[3]&Instr[2]&Instr[1]&~Instr[0];
assign sub  =  (~|Instr[31:26])&Instr[5]&~Instr[4]&~Instr[3]&~Instr[2]&Instr[1]&~Instr[0];
assign xor_ =  (~|Instr[31:26])&Instr[5]&~Instr[4]&~Instr[3]&Instr[2]&Instr[1]&~Instr[0];
assign xori =  ~Instr[31]&~Instr[30]&Instr[29]&Instr[28]&Instr[27]&~Instr[26];

//b类指令
assign beq	=	~Instr[31]&~Instr[30]&~Instr[29]&Instr[28]&~Instr[27]&~Instr[26];
assign bgez =  ~Instr[31]&~Instr[30]&~Instr[29]&~Instr[28]&~Instr[27]&Instr[26]&(~|Instr[20:17])&Instr[16];
assign bgtz =  ~Instr[31]&~Instr[30]&~Instr[29]&Instr[28]&Instr[27]&Instr[26];
assign blez =  ~Instr[31]&~Instr[30]&~Instr[29]&Instr[28]&Instr[27]&~Instr[26];
assign bltz =  ~Instr[31]&~Instr[30]&~Instr[29]&~Instr[28]&~Instr[27]&Instr[26]&(~|Instr[20:16]);
assign bne  =  ~Instr[31]&~Instr[30]&~Instr[29]&Instr[28]&~Instr[27]&Instr[26];

//J类指令
assign j		=	~Instr[31]&~Instr[30]&~Instr[29]&~Instr[28]&Instr[27]&~Instr[26];
assign jal	=	~Instr[31]&~Instr[30]&~Instr[29]&~Instr[28]&Instr[27]&Instr[26];
assign jr	=	(~|Instr[31:26])&~Instr[5]&~Instr[4]&Instr[3]&~Instr[2]&~Instr[1]&~Instr[0];
assign jalr =  (~|Instr[31:26])&~Instr[5]&~Instr[4]&Instr[3]&~Instr[2]&~Instr[1]&Instr[0];

//存储类指令
assign sw	=	Instr[31]&~Instr[30]&Instr[29]&~Instr[28]&Instr[27]&Instr[26];
assign sb   =  Instr[31]&~Instr[30]&Instr[29]&~Instr[28]&~Instr[27]&~Instr[26];
assign sh   =  Instr[31]&~Instr[30]&Instr[29]&~Instr[28]&~Instr[27]&Instr[26];
assign lw	=	Instr[31]&~Instr[30]&~Instr[29]&~Instr[28]&Instr[27]&Instr[26];
assign lb   =  Instr[31]&~Instr[30]&~Instr[29]&~Instr[28]&~Instr[27]&~Instr[26];
assign lbu  =  Instr[31]&~Instr[30]&~Instr[29]&Instr[28]&~Instr[27]&~Instr[26];
assign lh   =  Instr[31]&~Instr[30]&~Instr[29]&~Instr[28]&~Instr[27]&Instr[26];
assign lhu  =  Instr[31]&~Instr[30]&~Instr[29]&Instr[28]&~Instr[27]&Instr[26];

assign cal_r=add|addu|and_|mfhi|mflo|nor_|or_|sll|sllv|slt|sltu|sra|srav|srl|srlv|sub||subu|xor_;
assign cal_i = addi|addiu|andi|ori|xori|slti|sltiu|lui;


assign M_load = lb|lbu|lh|lhu|lw;
assign memwrite=sw|sh|sb;
wire BEop0,BEop1;
assign BEop0=sb;
assign BEop1=sh;
assign BEop={BEop1,BEop0};

assign ifjal=jal;
assign ifjalr=jalr;
endmodule
