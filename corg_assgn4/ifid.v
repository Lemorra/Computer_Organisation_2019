// IF\ID pipeline register

module ifid( clk, i_instr, i_pc, o_instr, o_pc, flush, ifcon );

	input [31:0] i_instr, i_pc;
	input flush, ifcon, clk;
	output reg [31:0] o_instr, o_pc;

	reg [31:0] instr, pc;

	always@(*) begin

		o_instr <= instr;
		o_pc <= pc;

		if(flush) begin
			instr <= 0;
			pc <= 0;
			end

		end

	always @ (posedge clk) begin

		if(!ifcon) begin
		instr <= i_instr;
		pc <= i_pc;
		end

		end
endmodule