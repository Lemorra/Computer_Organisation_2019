`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:35 11/09/2019 
// Design Name: 
// Module Name:    forward_check 
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
module forward_check(rs1in,rs2in,idexrdout,inp1muxcontrol,inp2muxcontrol,exmemrdout,rs1out,rs2out,
inp11muxcontrol,inp22muxcontrol
);
input wire [4:0]rs1in,rs2in,exmemrdout,rs1out,rs2out;
input wire [4:0]idexrdout;
output reg [1:0]inp1muxcontrol;
output reg [1:0]inp2muxcontrol;
output reg inp11muxcontrol;
output reg inp22muxcontrol;

always@(*) begin
if (idexrdout==rs1in && rs1in!=0)begin
inp1muxcontrol<=1;
end
if (idexrdout==rs1in && rs1in==0)begin
inp1muxcontrol<=0;
end
if (idexrdout!=rs1in && exmemrdout!=rs1in)begin
inp1muxcontrol<=0;
end
if (idexrdout==rs2in && rs2in!=0)begin
inp2muxcontrol<=1;
end
if (idexrdout==rs2in && rs2in==0)begin
inp2muxcontrol<=0;
end
if (idexrdout!=rs2in && exmemrdout!=rs2in)begin
inp2muxcontrol<=0;
end

if (exmemrdout==rs1out && rs1out!=0)begin
inp11muxcontrol<=1;
end
if (exmemrdout==rs1out && rs1out==0)begin
inp11muxcontrol<=0;
end
if (exmemrdout!=rs1out)begin
inp11muxcontrol<=0;
end
if (exmemrdout==rs2out && rs2out!=0)begin
inp22muxcontrol<=1;
end
if (exmemrdout==rs2out && rs2out==0)begin
inp22muxcontrol<=0;
end
if (exmemrdout!=rs2out)begin
inp22muxcontrol<=0;
end


if (exmemrdout==rs1in && idexrdout!=rs1in && rs1in!=0)begin
inp1muxcontrol<=2;
end
if (exmemrdout==rs1in && idexrdout!=rs1in && rs1in==0)begin
inp1muxcontrol<=0;
end
if (exmemrdout==rs2in && idexrdout!=rs2in && rs2in!=0)begin
inp2muxcontrol<=2;
end
if (exmemrdout==rs2in && idexrdout!=rs2in && rs2in==0)begin
inp2muxcontrol<=0;
end


end


endmodule
