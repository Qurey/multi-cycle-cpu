`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:05 11/22/2015 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm,
    input [1:0] EXTOp,
    output [31:0] ext
    );
	 
	 assign ext=(EXTOp==2'b00)?{16'b0,imm}:        //0��չ
					(EXTOp==2'b01)?{{16{imm[15]}},imm}:  //������չ
					(EXTOp==2'b10)?{imm,16'b0}:					//lui
					(EXTOp==2'b11)?{{14{imm[15]}},imm,2'b0}:  //shift2, ������չ
											{{16{imm[15]}},imm};
											
											
	 
endmodule
