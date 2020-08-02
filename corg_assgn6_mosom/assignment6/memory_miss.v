`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:31:46 11/28/2019 
// Design Name: 
// Module Name:    memory_miss 
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
module memory_miss(aluout,writecontrol,readcontrol,readerror,writeerror,outofboundaccess,luiout
    );
input wire [31:0] aluout;
input wire luiout;
input wire [1:0] writecontrol;
input wire [1:0] readcontrol;
output reg readerror;
output reg writeerror;
output reg outofboundaccess;
initial begin
readerror<=0;
writeerror<=0;
outofboundaccess<=0;
end

always@(*)begin
if (writecontrol==2 && readcontrol==3 && aluout%4!=0 && luiout==0)begin
writeerror<=1;
readerror<=0;
outofboundaccess<=0;
end
else if (writecontrol==1 && readcontrol==3 && aluout%4!=0 && aluout%4!=2 && luiout==0)begin
writeerror<=1;
readerror<=0;
outofboundaccess<=0;
end
else if (writecontrol==3 && readcontrol==2 && aluout%4!=0 && luiout==0)begin
writeerror<=0;
readerror<=1;
outofboundaccess<=0;
end
else if (writecontrol==3 && readcontrol==1 && aluout%4!=0 && aluout%4!=2 && luiout==0)begin
writeerror<=0;
readerror<=1;
outofboundaccess<=0;
end
else if ((writecontrol!=3 || readcontrol!=3) && ($signed(aluout)>=128 || $signed(aluout)<0) && luiout==0)begin
writeerror<=0;
readerror<=0;
outofboundaccess<=1;
end 
else begin
writeerror<=0;
readerror<=0;
outofboundaccess<=0;
end



end
endmodule
