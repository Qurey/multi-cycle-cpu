`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:22:11 11/24/2016 
// Design Name: 
// Module Name:    M_WB 
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
module M_WB(
    input clk,
	 input reset,
	 input [31:0]Instr_M,
	 input [31:0]pc_M,
	 input [31:0]aluout_M,
	 input [31:0]memdata_M,
	 output [31:0]mux4,
	 output [4:0]writeaddr,
	 output [31:0]writedata,
	 output regwrite,
	 output [31:0]bypass_Instr,
	 output bypass_cal_r,
	 output bypass_cal_i,
	 output _ifjal,
	 output ifjalr
    );
wire [31:0]Instr;
wire [31:0]pc;
wire [31:0]alu;
wire [31:0]memdata;
wire memtoreg;//�ж���lw����һ�������ָ��
wire ifjal;//�ж��Ƿ���jalָ��
//wire ifjalr;//�ж��Ƿ���jalrָ��
wire regdst;
register_M_WB s0(clk,reset,Instr_M,pc_M,aluout_M,memdata_M,Instr,pc,alu,memdata);

wire [2:0]dm_extop;
controller_WB s1(Instr,dm_extop,regwrite,regdst,memtoreg,ifjal,ifjalr,bypass_cal_r,bypass_cal_i);

wire [31:0]true_memdata;//����������չģ��������
DM_ext s2 (alu,memdata,dm_extop,true_memdata);

wire [31:0] write_sel1;//�ж���lw����һ���alu����ָ��
assign write_sel1 = (memtoreg==1)? true_memdata:alu;
wire [31:0] write_sel2;//�ж��Ƿ�Ϊjalָ��
wire [31:0] pc8;
assign pc8=pc+8;
assign write_sel2 = (ifjal==1|ifjalr==1)? pc8:write_sel1;//�Ƿ�pc+8����ra�Ĵ���

assign mux4 = write_sel2;
assign writedata=write_sel2;

wire [4:0] i_write_addr;
assign i_write_addr = (regdst==0)?Instr[15:11]:Instr[20:16];
assign writeaddr = (ifjal==0)? i_write_addr:32'b11111;
assign bypass_Instr=Instr;
assign _ifjal=ifjal;

endmodule
