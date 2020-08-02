`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:38 11/10/2019 
// Design Name: 
// Module Name:    peripherl 
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
module peripheral(opcode,periwrite,periread,clk,counter,sum
    );
input wire clk;
input wire [2:0] opcode;
input wire [31:0] periwrite;
output reg [31:0] periread;
output reg [31:0] counter;
output reg [31:0] sum;
initial begin
sum<=0;
counter<=0;
end

always@(*)begin
if (opcode==4) begin
periread<=0;
end
else if (opcode==3)begin
periread<=counter;
end

else if (opcode==2)begin
periread<=sum;
end
end

always@(posedge clk)begin
if (opcode==0)begin
sum<=0;
counter<=0; 
end
else if (opcode==1)begin
sum<=sum+periwrite;
counter<=counter+1;
end


end
endmodule
