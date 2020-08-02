`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:01 11/28/2019 
// Design Name: 
// Module Name:    idatamux1 
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
module idatamux1(validitymux,idatadecoder,idatasent
    );
input wire validitymux;
input wire [31:0] idatadecoder;
output reg [31:0] idatasent;

always@(*)begin
if (validitymux==0)
idatasent<=idatadecoder;
else
idatasent<=0;
end

endmodule
