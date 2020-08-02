`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:35:22 10/08/2019 
// Design Name: 
// Module Name:    rdmux 
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
module writeregmux( selectorwrite,aluout,dmemout,zero,writedata,new,pcout
    );
input wire [1:0] selectorwrite;
input wire [31:0] aluout;
input wire [31:0] dmemout,pcout;
input wire zero,new;
output reg [31:0] writedata;

always@(*) begin
if (selectorwrite==0)
writedata<=aluout;
if (selectorwrite==1)
writedata<=dmemout;
if (selectorwrite==2) 
writedata<=32'b0+zero;
if (selectorwrite==3) 
writedata<=pcout;
end
endmodule
