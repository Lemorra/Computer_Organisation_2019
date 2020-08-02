`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:08:25 11/10/2019 
// Design Name: 
// Module Name:    inp22mux 
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
module inp22mux(inp22muxcontrol,memwbdatain,idexinp2out,inp22muxout
    );
input wire inp22muxcontrol;
input wire [31:0] memwbdatain;
input wire [31:0] idexinp2out;
output reg [31:0] inp22muxout;

always@(*)begin
if(inp22muxcontrol==1)
inp22muxout<=memwbdatain;
else
inp22muxout<=idexinp2out;
end

endmodule
