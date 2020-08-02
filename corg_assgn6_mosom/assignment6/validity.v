`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:44 11/28/2019 
// Design Name: 
// Module Name:    validity 
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
module validity(clk,readerror,writeerror,outofboundaccess,invalid,pc,pcstored,pcpump,override,read,write,pclock,
validitymux
    );
input wire readerror;
input wire clk;
input wire override;
input wire writeerror;
input wire outofboundaccess;
input wire invalid;
reg [1:0] state;
output reg validitymux;
output reg pcpump;
input wire [31:0] pc;
output reg [31:0] pcstored;
output reg read,write,pclock;
initial begin
state<=0;
validitymux<=0;
pcpump<=0;
pcstored<=0;
read<=0;
write<=0;
pclock<=0;
end

always@(negedge clk)begin
if (state==0)begin
if(writeerror==0 && readerror==0 && outofboundaccess==0 && invalid==0)begin
validitymux<=0;
pcpump<=0;
pcstored<=0;
state<=0;
pclock<=0;
read<=0;
write<=0;
end
if(invalid==1)begin
validitymux<=1;
pclock<=1;
pcpump<=0;
pcstored<=pc;
state<=2;
read<=0;
write<=0;
end
if((writeerror==1 || readerror==1 || outofboundaccess==1) && invalid==0)begin
if (outofboundaccess==0)begin
validitymux<=1;
pclock<=1;
pcpump<=0;
state<=1;
read<=readerror;
write<=writeerror;
end
if (outofboundaccess==1)begin
validitymux<=1;
pclock<=1;
pcpump<=0;
state<=1;
read<=1;
write<=1;
end
end
end
if (state==1)begin
if (override==0)begin
state<=1;
pcpump<=0;
validitymux<=1;
pclock<=1;
read<=0;
write<=0;
end
if (override==1)begin
state<=0;
pcpump<=0;
validitymux<=0;
pclock<=0;
read<=0;
write<=0;
end
end
if (state==2)begin
if (override==0)begin
state<=2;
pcpump<=0;
validitymux<=1;
pclock<=1;
read<=0;
write<=0;
end
if (override==1)begin
state<=0;
pcpump<=1;
validitymux<=0;
pclock<=0;
read<=0;
write<=0;
end
end
end

endmodule
