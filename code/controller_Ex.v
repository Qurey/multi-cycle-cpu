`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:20:58 11/23/2016 
// Design Name: 
// Module Name:    controller_Ex 
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
module controller_Ex(
    input [31:0] Instr,
    output alusrc,
    output [3:0] aluop,
	 output EX_cal_r,
	 output EX_cal_i,
	 output EX_load,//涉及暂停
	 output ifjal,//涉及转发
	 output ifjalr,
	 output hilo,//0是mtlo,1是mthi
	 output [2:0]mul_divop,//000：multu,001:mult,010:divu,011:div
	 output start,
	 output hilowrite,
	 output ifmfhi,
	 output ifmflo,
	 output ifmuldiv
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

//store,load,cal_i用来判断alusrc
wire store,load,cal_r,cal_i;
assign store =sw|sb|sh;
assign load  =lb|lbu|lh|lhu|lw;
assign cal_i =addi|addiu|andi|ori|xori|slti|sltiu;//alu的操作数之一来自立即数扩展
assign alusrc = store|load|cal_i;

//plus,minus等用来判断alu进行的操作类型
wire plus,minus,ex_or,ex_and,ex_xor,ex_l,ex_l_u;
assign plus		=	store|load|add|addu|addi|addiu;
assign minus	=	sub|subu;
assign ex_or	=	or_|ori;
assign ex_and	=	and_|andi;
assign ex_xor	=	xor_|xori;
assign ex_l 	= 	slt|slti;
assign ex_l_u 	=	sltu|sltiu;
//组装aluop的4位选择
wire aluop0,aluop1,aluop2,aluop3;
assign aluop0	=	minus|lui|sllv|srav|srlv|ex_xor|ex_l;
assign aluop1	=	ex_or|lui|sra|srav|ex_and|ex_xor|ex_l_u;
assign aluop2	=	sll|sllv|sra|srav|nor_|ex_l|ex_l_u;
assign aluop3	=	srl|srlv|ex_and|ex_xor|nor_|ex_l|ex_l_u;
assign aluop={aluop3,aluop2,aluop1,aluop0};

//做出改变的是rt还是rd
wire change_rd,change_rt;
assign change_rd = add|addu|and_|mfhi|mflo|nor_|or_|sll|sllv|slt|sltu|sra|srav|srl|srlv|sub||subu|xor_;
assign change_rt = addi|addiu|andi|ori|xori|slti|sltiu|lui;
assign EX_cal_r=change_rd;
assign EX_cal_i=change_rt;
assign EX_load = load;
assign ifjal=jal;
assign ifjalr=jalr;

assign hilo=mthi;
wire md0,md1,md2;
assign md0=mult|div;
assign md1=divu|div;
assign md2=1'b0;
assign mul_divop={md2,md1,md0};
assign start = mult|multu|div|divu;
assign hilowrite=mthi|mtlo;
assign ifmfhi=mfhi;
assign ifmflo=mflo;
assign ifmuldiv=mult|multu|div|divu;

endmodule
