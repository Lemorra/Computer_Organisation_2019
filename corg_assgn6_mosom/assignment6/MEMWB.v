`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:21:16 10/29/2019 
// Design Name: 
// Module Name:    MEMWB 
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
module MEMWB(clk,writedatain,writedataout,rdin,rdout,newin,newout,wrin,wrout);
input wire clk;
input wire [31:0] writedatain;
output reg [31:0] writedataout;
input wire [4:0]rdin;
output reg [4:0]rdout;
input wire newin;
output reg newout;
input wire wrin;
output reg wrout;


always@(posedge clk) begin
writedataout<=writedatain;
rdout<=rdin;
newout<=newin;
wrout<=wrin;
end
    


endmodule
