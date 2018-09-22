`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:54 11/24/2015 
// Design Name: 
// Module Name:    stallctrl 
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
module stallctrl(
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
	 input cal_rD,
	 input cal_iD,
	 input cal_rE,
	 input cal_iE,
	 input cal_rM,
	 input cal_iM,
	 input cal_rW,
	 input cal_iW,
	 input ldD,
	 input stD,
	 input ldE,
	 input stE,
	 input ldM,
	 input stM,
	 input ldW,
	 input stW,
    output StallF,
    output StallD,
    output FlushE
    );
	 //‘›Õ£ª˙÷∆

//		assign StallF=0;
//		assign StallD=0;
//		assign FlushE=0;

	 wire pcstall,idstall,exflush;
	
	 assign pcstall=(b_typeD&(RsD==WriteRegE|RtD==WriteRegE)&(cal_rE|cal_iE|ldE))?1: //cal_r(cal_i,load)--beq≥ÂÕª
						(b_typeD&(RsD==WriteRegM|RtD==WriteRegM)&ldM)?1:            //load--nop--beq≥ÂÕª
						(cal_rD&(RsD==WriteRegE|RtD==WriteRegE)&ldE)?1:				//load-cal_r≥ÂÕª
						(cal_iD&RsD==WriteRegE&ldE)?1:							 //load--cal_i≥ÂÕª
						((ldD|stD)&RsD==WriteRegE&ldE)?1:                   //load--load(store)≥ÂÕª
						(jrD&RsD==WriteRegE&(ldE|cal_rE|cal_iE))?1:			 //load(cal_r,cal_i)--jr≥ÂÕª
						(jrD&RsD==WriteRegM&ldM)?1:								//laod--nop--jr≥ÂÕª
														0;
						
			
	 assign idstall=(b_typeD&(RsD==WriteRegE|RtD==WriteRegE)&(cal_rE|cal_iE|ldE))?1: //cal_r(cal_i,load)--beq≥ÂÕª
						(b_typeD&(RsD==WriteRegM|RtD==WriteRegM)&ldM)?1:            //load--nop--beq≥ÂÕª
						(cal_rD&(RsD==WriteRegE|RtD==WriteRegE)&ldE)?1:				//load-cal_r≥ÂÕª
						(cal_iD&RsD==WriteRegE&ldE)?1:							 //load--cal_i≥ÂÕª
						((ldD|stD)&RsD==WriteRegE&ldE)?1:                   //load--load(store)≥ÂÕª
						(jrD&RsD==WriteRegE&(ldE|cal_rE|cal_iE))?1:			 //load(cal_r,cal_i)--jr≥ÂÕª
						(jrD&RsD==WriteRegM&ldM)?1:								//laod--nop--jr≥ÂÕª
														0;
	 
	 
	 assign exflush=(b_typeD&(RsD==WriteRegE|RtD==WriteRegE)&(cal_rE|cal_iE|ldE))?1: //cal_r(cal_i,load)--beq≥ÂÕª
						(b_typeD&(RsD==WriteRegM|RtD==WriteRegM)&ldM)?1:            //load--nop--beq≥ÂÕª
						(cal_rD&(RsD==WriteRegE|RtD==WriteRegE)&ldE)?1:				//load-cal_r≥ÂÕª
						(cal_iD&RsD==WriteRegE&ldE)?1:							 //load--cal_i≥ÂÕª
						((ldD|stD)&RsD==WriteRegE&ldE)?1:                   //load--load(store)≥ÂÕª
						(jrD&RsD==WriteRegE&(ldE|cal_rE|cal_iE))?1:			 //load(cal_r,cal_i)--jr≥ÂÕª
						(jrD&RsD==WriteRegM&ldM)?1:								//laod--nop--jr≥ÂÕª
														0;
														
														
	 
	 assign StallF=(pcstall===1)?1:0;    //”√”⁄≥ı ºªØ
	 assign StallD=(idstall===1)?1:0;
	 assign FlushE=(exflush===1)?1:0;

	

endmodule
