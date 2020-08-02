`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:35:14 11/01/2019 
// Design Name: 
// Module Name:    branch 
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
module branch(op,zero,in,new
    );
input wire [5:0] op;
input wire zero;
output reg in;
input wire new;

always@(op or zero or new) begin
if (op==15 || op==16 || op==17 || op==18 || op==19 || op==20) begin
if (zero)
in<=1;
else
in<=0;
end


end

endmodule
