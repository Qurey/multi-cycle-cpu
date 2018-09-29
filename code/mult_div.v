`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:41 12/06/2016 
// Design Name: 
// Module Name:    mult_div 
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
module mult_div(
    input clk,
    input reset,
    input [31:0] rs,
    input [31:0] rt,
    input hilo,//写入hi,还是lo
    input [2:0] op,//000:multu,001:mult,010:divu,011:div
    input start,//开始乘除计算
    input write,//往hi,lo中写入数据
    output reg busy,
    output reg [31:0] Hidata,
    output reg [31:0] Lodata
    );
integer i;
reg [31:0]Hi;
reg [31:0]Lo;
reg [2:0]_op;
initial begin
i<=0;
Hi<=0;
Lo<=0;
busy<=0;
Hidata<=0;
Lodata<=0;
_op<=0;
end
always @(posedge clk)begin
	if(reset)begin
		i<=0;
		Hi<=0;
		Lo<=0;
		Hidata<=0;
		Lodata<=0;
		busy<=0;
		_op<=0;
	end
	
	else if(start&(~busy))begin
		i<=0;
		busy<=1;
		_op<=op;
		case(op)
			3'b000:begin {Hi,Lo}<={1'b0,rs}*{1'b0,rt};end
			3'b001:begin {Hi,Lo}<=$signed(rs)*$signed(rt);end
			3'b010:begin Lo<=(rt==0)?0:{1'b0,rs}/{1'b0,rt};
							 Hi<=(rt==0)?0:{1'b0,rs}%{1'b0,rt};end
			3'b011:begin Lo<=(rt==0)?0:$signed(rs)/$signed(rt);
							 Hi<=(rt==0)?0:$signed(rs)%$signed(rt);end
			default:begin Lo<=0;Hi<=0;end
		endcase
	end
	
	//乘法延迟5个周期，除法十个周期，乘除以op[1]来区分
	else if((i==5&~_op[1]&~write)|(i==10&_op[1]&~write)) begin
				Hidata<=Hi;
				Lodata<=Lo;
				busy<=0;
				_op<=0;
	end
	
	else if(write)begin
		case (hilo)
			0:begin Lodata<=rs;Lo<=rs;end
			1:begin Hidata<=rs;Hi<=rs;end
		endcase
		//Hidata=Hi;
		//Lodata=Lo;
	end
	
	i=i+1;
	Hidata=Hi;
	Lodata=Lo;
end

endmodule
