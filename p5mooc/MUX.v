`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:57 11/22/2015 
// Design Name: 
// Module Name:    MUX 
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
module mux2x32(
	input [31:0] d0,
	input [31:0] d1,
	input s,
	output [31:0] out
    );
	 assign out=(s===1)?d1:d0;
					
endmodule



module mux3x32(
	input [31:0] d0,
	input [31:0] d1,
	input [31:0] d2,
	input [1:0] s,
	output [31:0] out
    );
	 assign out=(s==2'b00)?d0:
				   (s==2'b01)?d1:
					(s==2'b10)?d2:
					32'b0;
endmodule


module mux3x5(
	input [4:0] d0,
	input [4:0] d1,
	input [4:0] d2,
	input [1:0] s,
	output [4:0] out
    );
	 assign out=(s==2'b00)?d0:
				   (s==2'b01)?d1:
					(s==2'b10)?d2:
					32'b0;
endmodule






