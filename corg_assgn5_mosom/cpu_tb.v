`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:49:17 10/08/2019
// Design Name:   CPU
// Module Name:   D:/Comp.Org/singlecycle/cpu_tb.v
// Project Name:  singlecycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;
	// Inputs
	reg clk;
	reg reset;
	wire [31:0] pcactual;
   //reg [2:0] counter;
	// Outputs
	wire [31:0] x31,idata,sum,counter;
   
	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reset(reset),  
		.x31(x31),.pcactual(pcactual),.idata(idata),.sum(sum),.counter(counter)
	);
 
	initial begin 
		// Initialize Inputs
		clk <= 0;
		reset <= 0; 
		//counter<=0; 
 end
		// Wait 100 ns for global reset to finish
	always #10
	 clk=~clk;

		// all expected outputs matched in simulation


      
endmodule

