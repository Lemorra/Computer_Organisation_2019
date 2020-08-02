`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:34:34 10/28/2019 
// Design Name: 
// Module Name:    IDEXREG 
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
module IDEXREG(clk,inp1in,inp1out,inp2in,inp2out,newin,newout,rv2in,rv2out,rdin,rdout,opin,opout,rdmuxin,rdmuxout,shamtin,shamtout,signcontrolin,
signcontrolout,readcontrolin,readcontrolout,writecontrolin,writecontrolout,wrin,wrout,pcmuxin,pcmuxout,addressin,addressout,
rv1in,rv1out,pcin,pcout,idexrs1in,idexrs1out,idexrs2in,idexrs2out,luiin,luiout
    );
input wire clk;
input wire [4:0] idexrs1in,idexrs2in;
output reg [4:0] idexrs1out,idexrs2out;
input wire [31:0] pcin;
output reg [31:0] pcout;
input wire [31:0]rv1in;
output reg [31:0]rv1out;
input wire [31:0]addressin;
output reg [31:0]addressout;
input wire [1:0]pcmuxin;
output reg [1:0]pcmuxout;
input wire [31:0] inp1in;
output reg [31:0] inp1out;
input wire [31:0] inp2in;
output reg [31:0] inp2out;
input wire newin;
output reg newout;
input wire [31:0] rv2in;
output reg [31:0] rv2out;
input wire [4:0] rdin;
output reg [4:0] rdout;
input wire [5:0] opin;
output reg [5:0] opout;
input wire [1:0]rdmuxin;
output reg [1:0]rdmuxout;
input wire [4:0]shamtin;
output reg [4:0]shamtout;
input wire signcontrolin;
input wire wrin;
output reg wrout;
output reg signcontrolout;
input wire [1:0] writecontrolin;
output reg [1:0] writecontrolout;
input wire [1:0] readcontrolin;
output reg [1:0] readcontrolout;
input wire luiin;
output reg luiout;

always@(posedge clk) begin
pcout<=pcin;
inp1out<=inp1in;
inp2out<=inp2in;
newout<=newin;
rv2out<=rv2in;
rdout<=rdin;
opout<=opin;
rdmuxout<=rdmuxin;
shamtout<=shamtin;
signcontrolout<=signcontrolin;
writecontrolout<=writecontrolin;
readcontrolout<=readcontrolin;
wrout<=wrin;
pcmuxout<=pcmuxin;
rv1out<=rv1in;
addressout<=addressin;
idexrs1out<=idexrs1in;
idexrs2out<=idexrs2in;
luiout<=luiin;
end




endmodule
