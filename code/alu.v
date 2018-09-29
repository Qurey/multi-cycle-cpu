`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:03 11/23/2016 
// Design Name: 
// Module Name:    alu 
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
module alu(
	 input [31:0]Instr,
	 input [3:0]aluop,
    input [31:0] A,//rs
    input [31:0] B,//rt
	 input signed [31:0] sign_A,
	 input signed [31:0] sign_B,
	 output [31:0] aluresult
    );
wire [31:0]a0;wire [31:0]a1;wire[31:0]a2;wire[31:0]a3;wire[31:0]a4;wire[31:0]a5;wire[31:0]a6;wire[31:0]a7;
		wire[31:0]a8;wire[31:0]a9;wire[31:0]a10;wire[31:0]a11;wire[31:0]a12;wire[31:0]a13;wire[31:0]a14;wire[31:0]a15;
assign a0 = A+B;//plus
assign a1 = A-B;//minus
assign a2 = A|B;//or
assign a3 = {Instr[15:0],16'b0000_0000_0000_0000};//lui
assign a4 = B<<Instr[10:6];//sll
assign a5 = B<<A[4:0];//sllv
assign a6 = sign_B>>>Instr[10:6];//sra
assign a7 = sign_B>>>A[4:0];//srav
assign a8 = B>>Instr[10:6];//srl
assign a9 = B>>A[4:0];//srlv
assign a10= A&B;//and
assign a11= A^B;//xor
assign a12= ~(A|B);//nor
assign a13= (sign_A<sign_B)?32'b1:32'b0;//slt,slti
assign a14= (A<B)?32'b1:32'b0;//sltu,sltiu
mux16 alu(aluop,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,,aluresult);


endmodule