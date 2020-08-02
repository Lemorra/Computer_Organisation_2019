`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:19 10/20/2019 
// Design Name: 
// Module Name:    imem 
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
module imem(clk,idata,new,pcmux,rv1,imm,in,pc
    );
input wire in;
output reg [31:0] pc;
output reg new;
input wire clk;
input wire [1:0]pcmux;
input wire [31:0]rv1;
input wire [31:0]imm;
output reg [31:0]idata;
reg [31:0]imem[0:31];
integer i;
initial begin
pc<=0;
new<=0;
idata<=0;
$readmemh("imem3_ini.mem",imem);
for (i=17;i<32;i=i+1) begin
imem[i]=0;
end
end

always@ (posedge clk) begin
if (pcmux==3)begin
idata<=imem[pc>>2];
pc<=pc+4;
new<=new+1;
end
if (pcmux==0)begin
idata<=imem[(rv1+imm)>>2];
pc<=((rv1+imm+4)>>2)<<2; 
new<=new+1;
end
if (pcmux==2) begin
if (in==0)begin
idata<=imem[pc>>2];
pc<=pc+4;
new<=new+1;
end
else begin
idata<=imem[(pc+imm-4)>>2];
pc<=((pc+imm)>>2)<<2;
new<=new+1;
end
end
if (pcmux==1)begin
idata<=imem[(pc+imm-4)>>2];//current pc jump assumed
pc<=((pc+imm)>>2)<<2;
new<=new+1;
end
end


endmodule
