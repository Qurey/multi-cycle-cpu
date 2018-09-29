`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:20 11/30/2016 
// Design Name: 
// Module Name:    stallctr 
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
module stallctr(
    input [31:0] Instr_ID,
    input ID_cal_r,
	 input ID_cal_rt,
    input ID_cal_i,
    input ID_load,
    input ID_store,
    input ID_rsrt,
    input ID_rs_,
	 input ID_rt_,
	 input ID_muldiv,
	 input busy,
	 input muldiv,
    input [31:0] Instr_EX,
    input EX_cal_r,
    input EX_cal_i,
    input EX_load,
    input [31:0] Instr_M,
    input M_load,
    output IR_D_en,
    output IR_E_clr,
    output pc_en
    );
wire [4:0]ID_rs;
assign ID_rs=Instr_ID[25:21];
wire [4:0]ID_rt;
assign ID_rt=Instr_ID[20:16];
wire [4:0]EX_rt;
assign EX_rt=Instr_EX[20:16];
wire [4:0]EX_rd;
assign EX_rd=Instr_EX[15:11];
wire [4:0]M_rt;
assign M_rt=Instr_M[20:16];

wire stall_rsrt ,stall_cal_r, stall_cal_rt, stall_cal_i, stall_load, stall_store, stall_rs,stall_rt, stall_md;
//rsrt tuse=0; rsrt tuse=1; rt tuse=1; rs tuse=1; load; store; mul,div,busy
assign stall_rsrt = ID_rsrt & ((EX_cal_r & (((ID_rs!=0)&(ID_rs==EX_rd))|((ID_rt!=0)&(ID_rt==EX_rd))))
							  | (EX_cal_i & (((ID_rs!=0)&(ID_rs==EX_rt))|((ID_rt!=0)&(ID_rt==EX_rt))))
							  | (EX_load  & (((ID_rs!=0)&(ID_rs==EX_rt))|((ID_rt!=0)&(ID_rt==EX_rt))))
							  | (M_load   & (((ID_rs!=0)&(ID_rs==M_rt))|((ID_rt!=0)&(ID_rt==M_rt)))));
assign stall_cal_r = ID_cal_r & EX_load & (((ID_rs!=0)&(ID_rs==EX_rt))|((ID_rt!=0)&(ID_rt==EX_rt)));
assign stall_cal_rt= ID_cal_rt & EX_load& (ID_rt==EX_rt)&(ID_rt!=0);
assign stall_cal_i = ID_cal_i & EX_load & (ID_rs==EX_rt)&(ID_rs!=0);
assign stall_load  = ID_load  & EX_load & (ID_rs==EX_rt)&(ID_rs!=0);
assign stall_store = ID_store & EX_load & (ID_rs==EX_rt)&(ID_rs!=0);
assign stall_rs = ID_rs_ & ((EX_cal_r & (ID_rs==EX_rd))
							  | (EX_cal_i & (ID_rs==EX_rt))
							  | (EX_load  & (ID_rs==EX_rt))
							  | (M_load   & (ID_rs==M_rt)))&(ID_rs!=0);
assign stall_rt = ID_rt_ &((EX_cal_r & (ID_rt==EX_rd))
							  | (EX_cal_i & (ID_rt==EX_rt))
							  | (EX_load  & (ID_rt==EX_rt))
							  | (M_load   & (ID_rt==M_rt)))&(ID_rt!=0);
	
assign stall_md = ID_muldiv&(busy|muldiv);

wire stall;
assign stall=stall_rsrt|stall_cal_r|stall_cal_rt|stall_cal_i|stall_load|stall_store|stall_rs|stall_rt|stall_md;
assign IR_D_en=!stall;
assign IR_E_clr=stall;
assign pc_en=!stall;










endmodule
