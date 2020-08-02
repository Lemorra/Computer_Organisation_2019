`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:14:29 10/08/2019 
// Design Name: 
// Module Name:    registers 
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
module registers( rs1,rs2,rd,wr,indata,rv1,rv2,x31,new,clk
    );
	 input wire new,clk;
    input [4:0] rs1,rs2;
    input wr;
	 input [4:0] rd;
	 input [31:0] indata;
	 output reg [31:0] rv1,rv2;
	 output wire [31:0] x31;
	 reg [31:0]RF[0:31];
	 
	 integer i;
	 initial begin
	 RF[0]=0;
	 for (i=1;i<32;i=i+1) begin
	 RF[i]=2; 
	 end
	 end
	 assign x31=RF[31];
	


	 always@(rs1 or rs2 or new) begin
	 rv1<=RF[rs1];
	 rv2<=RF[rs2];
	 end
	 always@(posedge clk) begin
	 if (wr) begin
	 if (rd) begin
	 RF[rd]<=indata;
	 RF[0]<=0;
	 end
    end
	 end
	 
	
    endmodule