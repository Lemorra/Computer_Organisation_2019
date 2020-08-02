`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:41 11/28/2019 
// Design Name: 
// Module Name:    readcontrolmux 
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
module readwritecontrolmux(read,write,idexreadcontrolout,memdecoderreadcontrolout,idexwritecontrolout,
memdecoderwritecontrolout,
wrcheckin,wrcheckout,outofboundaccess
    );
input wire read,write,outofboundaccess;
input wire [1:0] idexreadcontrolout;
output reg [1:0] memdecoderreadcontrolout;
input wire [1:0] idexwritecontrolout;
output reg [1:0] memdecoderwritecontrolout;
input wire wrcheckin;
output reg wrcheckout;
always@(*)begin
if (read==0  && write==0 && outofboundaccess == 0) begin
memdecoderreadcontrolout<=idexreadcontrolout;
memdecoderwritecontrolout<=idexwritecontrolout;
wrcheckout<=wrcheckin;
end
if (read==0  && write==0 && outofboundaccess != 0) begin
memdecoderreadcontrolout<=3;
memdecoderwritecontrolout<=3;
wrcheckout<=0;
end
if (read==0  && write==1 && outofboundaccess == 0) begin
memdecoderreadcontrolout<=idexreadcontrolout;
memdecoderwritecontrolout<=3;
wrcheckout<=wrcheckin;
end
if (read==0  && write==1 && outofboundaccess != 0) begin
memdecoderreadcontrolout<=3;
memdecoderwritecontrolout<=3;
wrcheckout<=0;
end
if (read==1 && write==0 && outofboundaccess == 0) begin
memdecoderreadcontrolout<=3;
memdecoderwritecontrolout<=idexwritecontrolout;
wrcheckout<=0;
end
if (read==1 && write==0 && outofboundaccess != 0) begin
memdecoderreadcontrolout<=3;
memdecoderwritecontrolout<=3;
wrcheckout<=0;
end
if (read==1 && write==1) begin
memdecoderreadcontrolout<=3;
memdecoderwritecontrolout<=3;
wrcheckout<=0;
end
end




endmodule
