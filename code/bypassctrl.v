`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:34:21 11/24/2016 
// Design Name: 
// Module Name:    bypassctrl 
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
module bypassctrl(
    input [31:0] Instr_ID,
    input [31:0] Instr_EX,
    input [31:0] Instr_M,
    input [31:0] Instr_WB,
    input M_cal_r,
    input M_cal_i,
    input WB_cal_r,
    input WB_cal_i,
	 input ifjal_ID_EX,
	 input ifjal_EX_M,
	 input ifjal_M_WB,
	 input ifjalr_ID_EX,//jalr改变的是rd域寄存器,因为最后mux4将其看做为cal_r指令，故只需考虑EX,M阶段的rd域是否冲突即可
	 input ifjalr_EX_M,
	 input ifjalr_M_WB,
	 
    output [2:0] rs_ID_sel,
    output [2:0] rt_ID_sel,
    output [1:0] rs_EX_sel,
    output [1:0] rt_EX_sel,
	 output dm_sel
    );
wire [4:0]ID_rs;
wire [4:0]ID_rt;
wire [4:0]EX_rs;
wire [4:0]EX_rt;
wire [4:0]M_rs;
wire [4:0]M_rt;

assign ID_rs = Instr_ID[25:21];
assign ID_rt = Instr_ID[20:16];
assign EX_rs = Instr_EX[25:21];
assign EX_rt = Instr_EX[20:16];
assign M_rs	 = Instr_M[25:21];
assign M_rt	 = Instr_M[20:16];

wire jal_ID_EX_rs_IF_ID;
wire jal_ID_EX_rt_IF_ID;
assign jal_ID_EX_rs_IF_ID= ifjal_ID_EX&&(ID_rs==5'b11111);
assign jal_ID_EX_rt_IF_ID= ifjal_ID_EX&&(ID_rt==5'b11111);//判断ID_EX是否存在与IF_ID阶段的jal指令冲突

wire jalr_ID_EX_rs_IF_ID;
wire jalr_ID_EX_rt_IF_ID;
wire [4:0]jalr_rd_EX;
assign jalr_rd_EX=Instr_EX[15:11];
assign jalr_ID_EX_rs_IF_ID= ifjalr_ID_EX&&(ID_rs==jalr_rd_EX);
assign jalr_ID_EX_rt_IF_ID= ifjalr_ID_EX&&(ID_rt==jalr_rd_EX);//判断ID_EX是否存在与IF_ID阶段的jalr指令冲突



wire jal_EX_M_rs_IF_ID;
wire jal_EX_M_rt_IF_ID;
assign jal_EX_M_rs_IF_ID= ifjal_EX_M&&(ID_rs==5'b11111);
assign jal_EX_M_rt_IF_ID= ifjal_EX_M&&(ID_rt==5'b11111);//判断EX_M是否存在与IF_ID阶段的jal指令冲突


wire jalr_EX_M_rs_IF_ID;
wire jalr_EX_M_rt_IF_ID;
wire [4:0]jalr_rd_M;
assign jalr_rd_M=Instr_M[15:11];
assign jalr_EX_M_rs_IF_ID= ifjalr_EX_M&&(ID_rs==jalr_rd_M);
assign jalr_EX_M_rt_IF_ID= ifjalr_EX_M&&(ID_rt==jalr_rd_M);//判断EX_M是否存在与IF_ID阶段的jalr指令冲突

wire jal_M_WB_rs_IF_ID;
wire jal_M_WB_rt_IF_ID;
assign jal_M_WB_rs_IF_ID= ifjal_M_WB&&(ID_rs==5'b11111);
assign jal_M_WB_rt_IF_ID= ifjal_M_WB&&(ID_rt==5'b11111);//判断M_WB是否存在与IF_ID阶段的jal指令冲突

wire jal_EX_M_rs_ID_EX;
wire jal_EX_M_rt_ID_EX;
assign jal_EX_M_rs_ID_EX= ifjal_EX_M&&(EX_rs==5'b11111);
assign jal_EX_M_rt_ID_EX= ifjal_EX_M&&(EX_rt==5'b11111);//判断EX_M是否存在与ID_EX阶段的jal指令冲突

wire jalr_EX_M_rs_ID_EX;
wire jalr_EX_M_rt_ID_EX;
assign jalr_EX_M_rs_ID_EX= ifjalr_EX_M&&(EX_rs==jalr_rd_M);
assign jalr_EX_M_rt_ID_EX= ifjalr_EX_M&&(EX_rt==jalr_rd_M);//判断EX_M是否存在与ID_EX阶段的jalr指令冲突



wire jal_M_WB_rs_ID_EX;
wire jal_M_WB_rt_ID_EX;
assign jal_M_WB_rs_ID_EX= ifjal_M_WB&&(EX_rs==5'b11111);
assign jal_M_WB_rt_ID_EX= ifjal_M_WB&&(EX_rt==5'b11111);//判断M_WB是否存在与ID_EX阶段的jal指令冲突

wire jal_M_WB_rt_EX_M;
assign jal_M_WB_rt_EX_M= ifjal_M_WB&&(M_rt==5'b11111);//判断M_WB是否存在与EX_M阶段rt域的jal指令冲突



wire [4:0]M_rdst;
assign M_rdst = (M_cal_r==0)? (M_cal_i==1)? Instr_M[20:16]:5'b0 :Instr_M[15:11];
wire [4:0]WB_rdst;
assign WB_rdst = (WB_cal_r==0)? (WB_cal_i==1)?Instr_WB[20:16]:5'b0  :Instr_WB[15:11];



assign rs_ID_sel = (ID_rs==0)?3'b000:(jal_ID_EX_rs_IF_ID|jalr_ID_EX_rs_IF_ID)? 3'b001:(jal_EX_M_rs_IF_ID|jalr_EX_M_rs_IF_ID)?3'b010:
						(ID_rs==M_rdst)?3'b011:(jal_M_WB_rs_IF_ID|(WB_rdst==ID_rs))? 3'b100:3'b000 ;

assign rt_ID_sel = (ID_rt==0)?3'b000:(jal_ID_EX_rt_IF_ID|jalr_ID_EX_rt_IF_ID)? 3'b001:(jal_EX_M_rt_IF_ID|jalr_EX_M_rt_IF_ID)?3'b010:
						(ID_rt==M_rdst)?3'b011:(jal_M_WB_rt_IF_ID|(WB_rdst==ID_rt))? 3'b100:3'b000 ;

assign rs_EX_sel = (EX_rs==0)?2'b00:(jal_EX_M_rs_ID_EX|jalr_EX_M_rs_ID_EX)?2'b01:(EX_rs==M_rdst)?2'b10:(jal_M_WB_rs_ID_EX|(EX_rs==WB_rdst))?2'b11:2'b00;

assign rt_EX_sel = (EX_rt==0)?2'b00:(jal_EX_M_rt_ID_EX|jalr_EX_M_rt_ID_EX)?2'b01:(EX_rt==M_rdst)?2'b10:(jal_M_WB_rt_ID_EX|(EX_rt==WB_rdst))?2'b11:2'b00;


assign dm_sel = (M_rt==0)?1'b0 :(jal_M_WB_rt_EX_M|(M_rt ==WB_rdst))? 1'b1:1'b0;

endmodule
