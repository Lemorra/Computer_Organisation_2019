`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:39:46 11/09/2019 
// Design Name: 
// Module Name:    inp2mux 
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
module inp2mux(memwbdatain,exmemoutin,rs2muxout,idexinp2in,inp2muxcontrol
    );

input wire [31:0] memwbdatain;
input wire [31:0] exmemoutin;
input wire [31:0] rs2muxout;
output reg [31:0] idexinp2in;
input wire [1:0] inp2muxcontrol;

always@(*) begin
if (inp2muxcontrol==0)
idexinp2in<=rs2muxout;
if (inp2muxcontrol==1)
idexinp2in<=exmemoutin;
if (inp2muxcontrol==2)
idexinp2in<=memwbdatain;
if (inp2muxcontrol==3)
idexinp2in<=0;
end

endmodule
