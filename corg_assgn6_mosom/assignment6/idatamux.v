`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:58:32 11/10/2019 
// Design Name: 
// Module Name:    idatamux 
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
module idatamux( inbranch,idataactual,idatadecoder
    );
input wire inbranch;
input wire [31:0] idataactual;
output reg [31:0] idatadecoder;

always@(*)begin
if (inbranch==1)
idatadecoder<=0;
else
idatadecoder<=idataactual;
end

endmodule
