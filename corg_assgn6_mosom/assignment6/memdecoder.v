`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:29:34 10/08/2019 
// Design Name: 
// Module Name:    memdecoder 
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
module memdecoder( aluout,writecontrol,readcontrol,signcontrol,wemen,re,daddr,new
    );
input wire [31:0] aluout;
input wire [1:0] writecontrol;
input wire [1:0] readcontrol;
input wire new;
input wire signcontrol;
output reg [3:0]wemen;
output reg [3:0]re;
output reg [31:0] daddr;

always@( aluout or writecontrol or readcontrol or signcontrol or new) begin
if (writecontrol==3 && readcontrol==3) begin
re<=0;
wemen<=0;
daddr<=0;
end
if (writecontrol==2 && readcontrol==3) begin //store a word
wemen<=15;
re<=0;
daddr<=(aluout>>2);
end
if (writecontrol==1 && readcontrol==3) begin //store a halfword
if (aluout%4==0)
wemen<=3;
else
wemen<=12;
re<=0;
daddr<=(aluout>>2);
end
if (writecontrol==0 && readcontrol==3) begin //store a byte
if (aluout[1:0]==0)
wemen<=1;
else if (aluout[1:0]==1)
wemen<=2;
else if (aluout[1:0]==2)
wemen<=4;
else if (aluout[1:0]==3)
wemen<=8;
re<=0;
daddr<=(aluout>>2);
end
if (writecontrol==3 && readcontrol==2) begin //load a word
daddr<=(aluout>>2);
wemen<=0;
re<=15;
end
if (writecontrol==3 && readcontrol==1) begin //load a halfword
daddr<=(aluout>>2);
wemen<=0;
if (aluout%4==0)
re<=3;
else
re<=12;
end
if (writecontrol==3 && readcontrol==0) begin //load a byte
if (aluout[1:0]==0)
re<=1;
else if (aluout[1:0]==1)
re<=2;
else if (aluout[1:0]==2)
re<=4;
else if (aluout[1:0]==3)
re<=8;
wemen<=0;
daddr<=(aluout>>2);
end
end



endmodule
