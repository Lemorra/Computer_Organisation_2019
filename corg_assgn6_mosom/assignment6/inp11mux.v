`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:58:46 11/09/2019 
// Design Name: 
// Module Name:    inp11mux 
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
module inp11mux(inp11muxcontrol,memwbdatain,idexinp1out,inp11muxout
    );
input wire inp11muxcontrol;
input wire [31:0] memwbdatain;
input wire [31:0] idexinp1out;
output reg [31:0] inp11muxout;

always@(*)begin
if(inp11muxcontrol==1)
inp11muxout<=memwbdatain;
else
inp11muxout<=idexinp1out;
end






endmodule
