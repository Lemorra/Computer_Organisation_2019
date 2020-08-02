`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:04 11/10/2019 
// Design Name: 
// Module Name:    jalrhandler 
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
module jalrhandler(jalr,idexwritecontrolout,idexrdout,pcfreeze,rs1in,exmemrdout,rv1muxcontrol
    );
input wire jalr;
input wire [1:0] idexwritecontrolout;
input wire [4:0] idexrdout;
output reg pcfreeze;
input wire [4:0] rs1in;
input wire [4:0] exmemrdout;
output reg [1:0] rv1muxcontrol;

initial begin
pcfreeze<=0;
rv1muxcontrol<=2;
end

always@(*)begin
if (jalr==1)begin
if (idexrdout==rs1in && idexwritecontrolout ==3) begin
rv1muxcontrol<=0;
pcfreeze<=0;
end
if (idexrdout==rs1in && idexwritecontrolout !=3) begin
rv1muxcontrol<=3;
pcfreeze<=1;
end
if (exmemrdout==rs1in) begin
rv1muxcontrol<=1;
pcfreeze<=0;
end
end
else begin
rv1muxcontrol<=2;
pcfreeze<=0;
end

end 



endmodule
