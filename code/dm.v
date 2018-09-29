`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:03 11/24/2016 
// Design Name: 
// Module Name:    dm 
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
module dm(
    input clk,
    input reset,
    input memwrite,
	 input [3:0]BE,//4个字节的写使能信号
    input [31:0] rdata,
    output [31:0] memdata,
    input [31:0] waddr
    );
	parameter length =2048;
	integer i;
	reg [31:0] dm[2047:0];
	wire [10:0]addr;
	assign addr=waddr[12:2];
	initial begin
	for(i=0;i<length;i=i+1)
	dm[i]=0;
	end
	always @(posedge clk)begin
	if (reset) begin
	for(i=0;i<length;i=i+1)
		dm[i]=0;
	end
	else if (memwrite)begin
		case(BE)
		4'b1111:begin 
		$display("*%h <= %h",waddr,rdata);
		dm[addr]<=rdata;
		end
		4'b0011:begin
		$display("*%h <= %h",waddr,rdata[15:0]);
		dm[addr][15:0]<=rdata[15:0];
		end
		4'b1100:begin
		$display("*%h <= %h",waddr,rdata[15:0]);
		dm[addr][31:16]<=rdata[15:0];
		end
		4'b0001:begin
		$display("*%h <= %h",waddr,rdata[7:0]);
		dm[addr][7:0]<=rdata[7:0];
		end
		4'b0010:begin
		$display("*%h <= %h",waddr,rdata[7:0]);
		dm[addr][15:8]<=rdata[7:0];
		end
		4'b0100:begin
		$display("*%h <= %h",waddr,rdata[7:0]);
		dm[addr][23:16]<=rdata[7:0];
		end
		4'b1000:begin
		$display("*%h <= %h",waddr,rdata[7:0]);
		dm[addr][31:24]<=rdata[7:0];
		end
		endcase
		
		
	end
	end
	assign memdata = dm[addr];
		

endmodule
