`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:23 11/24/2015 
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
	 wire [4:0] WriteRegW,RsD,RtD,RdD,RsE,RtE,RdE,WriteRegM,WriteRegE,R31E;
	 wire [31:0] PC4F,NPCD,NPC1,PCF,InstrF,InstrD,PC4D,GPRWD,RD1D,RD2D,extD,RD1E,RD2E,extE,RD1,RD2;
	 wire [31:0] inputA,out1,inputB,ALUOutE,WriteDataE,ALUOutM,WriteDataM,PCbtype;
	 wire [31:0] ReadDataM,ReadDataW,ALUOutW,PC8D,PC8E,PC8M,PC8W,DMWriteData,Mforward;
	 wire [1:0] EXTOpD,NPCselD,ALUOpD, ALUOpE,ForwardRSE,ForwardRTE,RegDstD,RegDstE,MemtoRegD,MemtoRegE,MemtoRegM,MemtoRegW;
	 wire [1:0] pcsrc;
	 wire StallF,StallD,MemWriteD,ALUsrcD,RegWriteD,cal_rD,cal_iD;
	 wire RegWriteW,FlushE,MemWriteE,ALUsrcE,RegWriteE,RegWriteM,MemWriteM;
	 wire cal_rM,cal_iM,cal_rW,cal_iW,cmp,ldD,stD,ldE,stE,ldM,stM,ldW,stW,b_typeD,jrD,jalW;
	 wire ForwardRSD,ForwardRTD,ForwardWDM,jalD,jalE,jalM;
	 assign PC4F=PCF+4;
	 assign PC8D=PC4D+4;
	 assign WriteDataE=out1;
	 assign RsD=InstrD[25:21];
	 assign RtD=InstrD[20:16];
	 assign RdD=InstrD[15:11];
	 assign R31E=5'b11111;
	 
	 mux3x32 PCsrc(PC4F,NPCD,RD1D,pcsrc,NPC1);
	 PC pc(clk,reset,NPC1,StallF,PCF);//rst
	 IM im(PCF[9:2],InstrF);
	 IF_ID ifid(clk,reset,StallD,InstrF,PC4F,InstrD,PC4D);
	 ctrl CTRL(InstrD[31:26],InstrD[5:0],RegDstD,EXTOpD,MemtoRegD,NPCselD,MemWriteD,ALUOpD,ALUsrcD,RegWriteD,
	 pcsrc,cal_rD,cal_iD,ldD,stD,b_typeD,jrD,jalD);
	 
	 GPR gpr(clk,reset,InstrD[25:21],InstrD[20:16],WriteRegW,RegWriteW,GPRWD,RD1,RD2);//rst
	 EXT ext(InstrD[15:0],EXTOpD,extD);
	 NPC npc(InstrD[25:0],PC4D,NPCselD,RD1,cmp,NPCD,PCbtype);
	 mux2x32 GPR_rs_out(RD1,Mforward,ForwardRSD,RD1D);
	 mux2x32 GPR_rt_out(RD2,Mforward,ForwardRTD,RD2D);
	 CMP b_type_cmp(RD1D,RD2D,cmp);
	 
	 ID_EX idex(clk,reset,FlushE,RegDstD,MemtoRegD,MemWriteD,ALUOpD,ALUsrcD,RegWriteD,PC8D,
	 RsD,RtD,RdD,RD1D,RD2D,extD,cal_rD,cal_iD,ldD,stD,jalD,RegDstE,MemtoRegE,MemWriteE,ALUOpE,
	 ALUsrcE,RegWriteE,PC8E,RsE,RtE,RdE,RD1E,RD2E,extE,cal_rE,cal_iE,ldE,stE,jalE);
	 
	 mux2x32 M_forward(ALUOutM,PC8M,jalM,Mforward);//M级为jal转发PC+8，否则转发ALUOut
	 mux3x5 regdst(RtE,RdE,R31E,RegDstE,WriteRegE);
	 mux3x32 MFRSE(RD1E,Mforward,GPRWD,ForwardRSE,inputA);
	 mux3x32 MFRTE(RD2E,Mforward,GPRWD,ForwardRTE,out1);
	 mux2x32 alusrc(out1,extE,ALUsrcE,inputB);
	 ALU alu(inputA,inputB,ALUOpE,ALUOutE);
	 EX_MEM exmem(clk,reset,RegWriteE,MemtoRegE,MemWriteE,ALUOutE,WriteDataE,WriteRegE,PC8E,
	 cal_rE,cal_iE,ldE,stE,jalE,
	 RegWriteM,MemtoRegM,MemWriteM,ALUOutM,WriteDataM,WriteRegM,PC8M,cal_rM,cal_iM,ldM,stM,jalM);
	 
	 mux2x32 dmWD(WriteDataM,GPRWD,ForwardWDM,DMWriteData);
	 DM dm(ALUOutM[11:2],DMWriteData,MemWriteM,clk,ReadDataM);
	 MEM_WB memwb(clk,reset,RegWriteM,MemtoRegM,ReadDataM,ALUOutM,WriteRegM,PC8M,cal_rM,cal_iM,ldM,stM,jalM,
	 RegWriteW,MemtoRegW,ReadDataW,ALUOutW,WriteRegW,PC8W,cal_rW,cal_iW,ldW,stW,jalW);
	 
	 mux3x32 memtoreg(ALUOutW,ReadDataW,PC8W,MemtoRegW,GPRWD);
	 stallctrl stall(RsD,RtD,RdD,RsE,RtE,RdE,WriteRegE,WriteRegM,WriteRegW,
	 b_typeD,jrD,cal_rD,cal_iD,cal_rE,cal_iE,cal_rM,cal_iM,cal_rW,cal_iW,
	 ldD,stD,ldE,stE,ldM,stM,ldW,stW,StallF,StallD,FlushE);
	 
	 hazardctrl forward(RsD,RtD,RdD,RsE,RtE,RdE,WriteRegE,WriteRegM,WriteRegW,
	 b_typeD,jrD,cal_rE,cal_iE,cal_rM,cal_iM,cal_rW,cal_iW,ldE,stE,ldM,stM,ldW,
	 stW,jalM,jalW,ForwardRSE,ForwardRTE,ForwardRSD,ForwardRTD,ForwardWDM);

endmodule
