`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:01:33 11/10/2019 
// Design Name: 
// Module Name:    memdatamux 
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
module memdatamux( memdatamuxcontrol,periread,dmemout,memdataout
    );
input wire memdatamuxcontrol;
input wire [31:0] periread;
input wire [31:0] dmemout;
output reg [31:0] memdataout;

always@(*)begin
if (memdatamuxcontrol)
memdataout<=periread;
else
memdataout<=dmemout;
end

endmodule
