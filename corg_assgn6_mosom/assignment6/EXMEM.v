`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:01 10/29/2019 
// Design Name: 
// Module Name:    EXMEM 
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
module EXMEM(clk,newin,newout,rv2in,rv2out,rdin,rdout,rdmuxin,rdmuxout,aluoutin,aluoutout,zeroin,zeroout,daddrin,daddrout,
signcontrolin,signcontrolout,wein,weout,rein,reout,wrin,wrout,pcin,pcout
    );
input wire clk;
input wire [31:0] pcin;
output reg [31:0] pcout;
input wire newin;
output reg newout;
input wire [31:0]rv2in;
output reg [31:0]rv2out;
input wire [4:0]rdin;
output reg [4:0]rdout;
input wire [1:0]rdmuxin;
output reg [1:0]rdmuxout;
input wire [31:0]aluoutin;
output reg [31:0]aluoutout;
input wire zeroin;
output reg zeroout;
input wire [31:0]daddrin;
output reg [31:0]daddrout;
input wire signcontrolin;
output reg signcontrolout;
input wire [3:0]wein;
output reg [3:0]weout;
input wire [3:0]rein;
output reg [3:0]reout;
input wire wrin;
output reg wrout;
  
always@(posedge clk)begin
newout<=newin;
pcout<=pcin;
rv2out<=rv2in;
rdout<=rdin;
rdmuxout<=rdmuxin;
aluoutout<=aluoutin;
zeroout<=zeroin;
daddrout<=daddrin;
signcontrolout<=signcontrolin;
weout<=wein;
reout<=rein;
wrout<=wrin;
end


endmodule
