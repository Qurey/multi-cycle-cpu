`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:43 11/23/2016 
// Design Name: 
// Module Name:    grf 
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
module grf(
    input clk,
    input reset,
    input [4:0] Waddr,
    input regwrite,
    input [31:0] Wdata,
    input [4:0] ra1,
    input [4:0] ra2,
    output [31:0] rdata1,
    output [31:0] rdata2
    );
parameter length=32;
	reg[31:0]_reg[31:0];
	integer i;
	initial begin
	for(i=0;i<length;i=i+1)
		_reg[i]=0;
	end
	always@(posedge clk )begin
		if (reset)begin
			for(i=0;i<length;i=i+1)
			_reg[i]=0;
		end
		else if(regwrite&(Waddr!=0))begin
		$display("$%d <= %h",Waddr,Wdata);
		_reg[Waddr]=Wdata;
		end
	end
	assign rdata1= ra1==0? 0:_reg[ra1];
	assign rdata2= ra2==0? 0:_reg[ra2]; 

endmodule
