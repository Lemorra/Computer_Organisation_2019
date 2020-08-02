`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:07:35 11/10/2019 
// Design Name: 
// Module Name:    imm 
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
module imm(inbranch,addressbranch,idexaddressin,immtoimem
    );
input wire inbranch;
input wire [31:0] addressbranch;
input wire [31:0] idexaddressin;
output reg [31:0] immtoimem;

always@(*)begin
if (inbranch==1)
immtoimem<=addressbranch;
else
immtoimem<=idexaddressin;
end

endmodule
