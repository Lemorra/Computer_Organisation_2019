`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:18 10/08/2019 
// Design Name: 
// Module Name:    rs1mux 
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
module rs1mux( selectorrs1mux,rv1,imm,outrs1mux,new
    );
input wire selectorrs1mux,new;
input wire [31:0] rv1;
input wire [31:0] imm;
output reg [31:0] outrs1mux;

always@(selectorrs1mux or rv1 or imm or new) begin
if (selectorrs1mux==0)
outrs1mux<=rv1;
else 
outrs1mux<=imm;
end


endmodule
