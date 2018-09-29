`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:19 11/23/2016 
// Design Name: 
// Module Name:    im 
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
module im(
    input [31:0] pc,
    output [31:0] Instr
    );
	 parameter length=2048;
	 //reg [31:0] _instr;
	 wire[12:2]addr;
	 wire[31:0]tpc;//需要减去0x00003000后再在im中寻找指令
	 assign tpc=pc-32'h00003000;
	 assign addr = tpc[12:2];
	 reg [31:0]_im[2047:0];
	 integer i;
	 initial begin
	 for(i=0;i<length;i=i+1)
		_im[i]=0;
	 end
	 initial begin
	 $readmemh("code.txt",_im);
	 end
	 assign Instr=_im[addr];

endmodule
