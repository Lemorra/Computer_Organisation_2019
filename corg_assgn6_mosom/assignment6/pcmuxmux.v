`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:06:27 11/10/2019 
// Design Name: 
// Module Name:    pcmuxmux 
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
module pcmuxmux(inbranch,pcmuxdecoder,pcmuxtoimem
    );
input wire inbranch;
input wire [1:0] pcmuxdecoder;
output reg [1:0] pcmuxtoimem;

always@(*)begin
if (inbranch==1)
pcmuxtoimem<=2;
else 
pcmuxtoimem<=pcmuxdecoder;
end
endmodule
