`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:01 11/23/2016 
// Design Name: 
// Module Name:    controller_ID 
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
module controller_ID(
    input [31:0] Instr,
	 input [31:0]rsdata,
	 input [31:0]rtdata,
    output extop,
	 output ID_cal_r,
	 output ID_cal_rt,
	 output ID_cal_i,
	 output ID_load,
	 output ID_store,
	 output ID_rsrt,
	 output ID_rs,
	 output ID_rt,
	 output ID_multdiv,
	 output [1:0]pc_sel,
	 output if_branch
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


assign extop = sw|sb|sh|lw|lb|lbu|lh|lhu|addi|addiu|slti|sltiu;
assign ID_rsrt = beq|bne;//tuse=0,both rs,rt
assign ID_cal_r = addu|subu|add|sub|mult|multu|div|divu|sllv|srlv|srav|and_|or_|xor_|nor_|slt|sltu;//rs,rt,tuse=1
assign ID_cal_rt = sll|sra||srl;//rt,tuse=1;
assign ID_cal_i = ori|addi|addiu|andi|xori|slti|sltiu|mthi|mtlo;//rs,tuse=1
assign ID_load = lw|lb|lh|lbu|lhu;
assign ID_store = sw|sb|sh;
assign ID_rs=jr|jalr|bgez|bgtz|blez|bltz;//tuse=0,just rs
assign ID_rt=0;//rt的tuse=0，课下测试不需使用

wire jcode,bcode,jrcode;  //定义是否为j指令,b指令，jr指令
assign jcode = j|jal;
assign bcode = beq|bne|blez|bgtz|bltz|bgez;
assign jrcode = jr|jalr; 
wire pc_sel1;
assign pc_sel1=jcode|jrcode;
wire pc_sel0;
assign pc_sel0=bcode|jrcode;
assign pc_sel={pc_sel1,pc_sel0};
assign if_branch=((rsdata==rtdata)&beq)|((rsdata!=rtdata)&bne)|((rsdata[31]==0)&bgez)|(rsdata[31]==0&rsdata!=0&bgtz)
						|(((rsdata[31]==1)|rsdata==0)&blez)|(rsdata[31]==1&bltz);

assign ID_multdiv=mult|multu|div|divu|mfhi|mflo|mthi|mtlo;

endmodule

