`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:14 11/09/2019 
// Design Name: 
// Module Name:    inp1mux 
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
module inp1mux(memwbdatain,exmemoutin,rs1muxout,idexinp1in,inp1muxcontrol
    );
input wire [31:0] memwbdatain;
input wire [31:0] exmemoutin;
input wire [31:0] rs1muxout;
output reg [31:0] idexinp1in;
input wire [1:0] inp1muxcontrol;

always@(*) begin
if (inp1muxcontrol==0)
idexinp1in<=rs1muxout;
if (inp1muxcontrol==1)
idexinp1in<=exmemoutin;
if (inp1muxcontrol==2)
idexinp1in<=memwbdatain;
if (inp1muxcontrol==3)
idexinp1in<=0;
end

endmodule
