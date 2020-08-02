`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:01:37 10/20/2019 
// Design Name: 
// Module Name:    pchandler 
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
module pchandler(nextaddress,pc
    );
input wire [1:0]nextaddress;
output wire [1:0]pc;
assign pc=nextaddress;

endmodule
