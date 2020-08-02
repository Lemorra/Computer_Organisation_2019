`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:56 11/10/2019 
// Design Name: 
// Module Name:    rv1mux 
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
module rv1mux( rv1muxcontrol,exmemoutin,memwbdatain,idexrv1in,rv1toimem
    );
input wire [1:0] rv1muxcontrol;
input wire [31:0] exmemoutin;
input wire [31:0] memwbdatain;
input wire [31:0] idexrv1in;
output reg [31:0] rv1toimem;
always@(*)begin
if (rv1muxcontrol==0)
rv1toimem<=exmemoutin;
if (rv1muxcontrol==1)
rv1toimem<=memwbdatain;
if (rv1muxcontrol==2)
rv1toimem<=idexrv1in;
if (rv1muxcontrol==3)
rv1toimem<=0;

end


endmodule
