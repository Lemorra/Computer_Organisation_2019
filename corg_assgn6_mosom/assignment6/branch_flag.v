`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:19:02 11/29/2019 
// Design Name: 
// Module Name:    branch_flag 
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
module adjusted_branch_flag(inbranch,addressbranch,branch_miss,inbranchactual,idexpcout
    );

input wire inbranch;
input wire [31:0] idexpcout;
input wire [31:0] addressbranch;
output reg branch_miss;
output reg inbranchactual;

initial begin
branch_miss<=0;
inbranchactual<=0;
end

always@(*)begin
if (inbranch==0)begin
branch_miss<=0;
inbranchactual<=0;
end
if (inbranch==1)begin
if (addressbranch%4==0 && $signed(idexpcout+$signed(addressbranch))<128 
&& $signed(idexpcout+$signed(addressbranch))>=0 )begin
branch_miss<=0;
inbranchactual<=1;
end
else begin
branch_miss<=1;
inbranchactual<=0;
end
end
end




endmodule
