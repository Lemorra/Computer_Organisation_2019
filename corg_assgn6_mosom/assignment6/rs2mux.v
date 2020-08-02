`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:57 10/07/2019 
// Design Name: 
// Module Name:    rs2mux 
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
module rs2mux(
   selectorrs2mux,rv2,imm,outrs2mux ,new);
input wire selectorrs2mux,new;
input wire [31:0] rv2;
input wire [31:0] imm;
output reg [31:0] outrs2mux;

always@(selectorrs2mux or rv2 or imm or new) begin
if (selectorrs2mux==0)
outrs2mux<=rv2;
else 
outrs2mux<=imm;
end

endmodule
