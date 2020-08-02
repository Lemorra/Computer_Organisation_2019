`timescale 1ns / 1ns

module reg_file
  (input clk,
   input we,
   input [4:0] rd,
   input [31:0] indata,
   input [4:0] rs1,
   output [31:0] rv1,
   input [4:0] rs2,
   output [31:0] rv2);

   reg [31:0] 	 regfile [0:31];
	assign rv1 = regfile[rs1];
   assign rv2 = regfile[rs2];

   always @(posedge clk) begin
		regfile[0] <= 32'h0000;  
		if (we && rd!== 32'h0000) regfile[rd] <= indata;
   end
endmodule
