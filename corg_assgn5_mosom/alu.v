`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:39:26 10/07/2019 
// Design Name: 
// Module Name:    alu 
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
module alu( inp1,inp2,shamt,op,zero,out,new
    );
input wire [31:0] inp1;
input wire [31:0] inp2;
input wire [4:0] shamt;
input wire [5:0] op;
input wire new;
output reg [31:0] out;
output reg zero;
initial begin 
out<=0;
zero<=0;
end
always@(inp1 or inp2 or shamt or op or new) begin
if (op==0)begin
out<=0;
zero<=0;
end
if (op==1)begin
out<=inp1+inp2;
zero<=0;
end
if (op==2)begin
out<=0;
if ($signed(inp1)<$signed(inp2)) 
zero<=1;   //rd set to 1
else
zero<=0; //rd set to 0
end
if (op==3)begin
out<=0;
if ($unsigned(inp1)<$unsigned(inp2)) 
zero<=1;   //rd set to 1
else
zero<=0; //rd set to 0
end
if (op==4) begin
zero<=0;
out<=inp1^inp2;
end
if (op==5) begin
zero<=0;
out<=inp1|inp2;
end
if (op==6) begin
zero<=0;
out<=inp1&inp2;
end
if (op==7) begin
zero<=0;
out<=(inp1<<$unsigned(shamt));
end
if (op==8) begin
zero<=0;
out<=(inp1>>$unsigned(shamt));
end
if (op==9) begin
zero<=0;
out<=($signed(inp1)>>>$unsigned(shamt));
end
if (op==10) begin
zero<=0;
out<=inp1-inp2;
end
if (op==11) begin
zero<=0;	
out<=inp1<<$unsigned(inp2[4:0]);
end
if (op==12) begin
zero<=0;
out<=(inp1)>>$unsigned(inp2[4:0]);
end
if (op==13) begin
zero<=0;
out<=$signed(inp1)>>>$unsigned(inp2[4:0]);
end

if (op==14) begin
zero<=0;
out<=inp1<<12;
end

if (op==15) begin
out<=0;
if (inp1==inp2)
zero<=1;
else
zero<=0;
end

if (op==16) begin
out<=0;
if (inp1!=inp2)
zero<=1;
else
zero<=0;
end

if (op==17) begin
out<=0;
if ($signed(inp1)<$signed(inp2))
zero<=1;
else
zero<=0;
end

if (op==18) begin
out<=0;
if ($signed(inp1)>=$signed(inp2))
zero<=1;
else
zero<=0;
end

if (op==19) begin
out<=0;
if ($unsigned(inp1)<$unsigned(inp2))
zero<=1;
else
zero<=0;
end
if (op==20) begin
out<=0;
if ($unsigned(inp1)>=$unsigned(inp2))
zero<=1;
else
zero<=0;
end

end


endmodule
