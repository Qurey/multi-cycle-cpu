`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:23 11/22/2015 
// Design Name: 
// Module Name:    GPR 
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
`define DEBUG
module GPR(
    input clk,
    input reset,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input RegWriteW,
	 input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2
    );
	 reg [31:0] _reg [31:0];
	 integer i;
	 
	initial begin
	for(i=0;i<32;i=i+1) begin
		_reg[i]=32'b0;
	end
	end
	
	 always @(posedge clk  or posedge reset)
	 begin
	 if(reset) begin
		for(i=0;i<32;i=i+1) begin
			_reg[i]=0;
	 end
	 end
	 else if(RegWriteW) begin
	$display("$%d <= %x", A3, WD);	_reg[A3]=WD;
		
		//`ifdef DEBUG
		//	$display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",
		//	0, _reg[1], _reg[2], _reg[3], _reg[4], _reg[5], _reg[6], _reg[7]);
		//	$display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",
		//   _reg[8], _reg[9], _reg[10], _reg[11], _reg[12], _reg[13], _reg[14], _reg[15]);
		//	$display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",
		//   _reg[16], _reg[17], _reg[18], _reg[19], _reg[20], _reg[21], _reg[22], _reg[23]);
		//	$display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",
		//   _reg[24], _reg[25], _reg[26], _reg[27], _reg[28], _reg[29], _reg[30], _reg[31]);
		//	$display("\n\n");
		//`endif
			
	 end
	 end
	 
	 assign RD1=(A1===0)?0:        //GPR内部转发实现先写后读
					(A1===A3&RegWriteW)?WD:
					  _reg[A1];
	 
	 
	 assign RD2=(A2===0)?0:      //GPR内部转发实现先写后读
					(A2===A3&RegWriteW)?WD:
					  _reg[A2];
	 


endmodule
