// EX\MEM pipeline register

module exmem( clk, i_PC_plus_4, i_PC_plus_offset, i_PC_rs1, i_zero, i_aluo, i_rv2, i_rd, i_imm, i_brnc, i_mem_r, i_mem_t_reg, i_mem_w, i_reg_w, i_rd_in,
			 o_PC_plus_4, o_PC_plus_offset, o_PC_rs1, o_zero, o_aluo, o_rv2, o_rd, o_imm, o_brnc, o_mem_r, o_mem_t_reg, o_mem_w, o_reg_w, o_rd_in, flush);

			 input [31:0] i_PC_plus_4, i_PC_plus_offset, i_PC_rs1, i_rv2, i_imm, i_aluo;
			 input [4:0] i_rd;
			 input i_brnc, i_mem_t_reg, i_reg_w, i_rd_in, flush, clk;
			 input [1:0] i_mem_w, i_mem_r;
			 input [1:0] i_zero; 

			 output reg[31:0] o_PC_plus_4, o_PC_plus_offset, o_PC_rs1, o_rv2, o_imm, o_aluo;
			 output reg[4:0] o_rd;
			 output reg o_brnc, o_mem_t_reg, o_reg_w, o_rd_in;
			 output reg [1:0] o_mem_w, o_mem_r;
			 output reg [1:0] o_zero; 

			 reg brnc, mem_t_reg, reg_w, rd_in;
 			 reg[1:0] mem_w, mem_r;
 			 reg [1:0] zero;

 			 reg [31:0] PC_plus_4, PC_plus_offset, PC_rs1, rv2, imm, aluo;
			 reg [4:0] rd;

 			 always@(*) begin

				o_PC_plus_4 <= PC_plus_4;
				o_PC_plus_offset <= PC_plus_offset;
				o_PC_rs1 <= PC_rs1;
				o_rv2 <= rv2;
				o_rd <= rd;
				o_imm <= imm;
				o_aluo <= aluo;
				
				o_brnc <= brnc;
				o_mem_t_reg <= mem_t_reg;
				o_reg_w <= reg_w;
				o_rd_in <= rd_in;
				o_mem_w <= mem_w;
				o_mem_r <= mem_r;
				o_zero <= zero;

				if(flush) begin
					mem_w <= 2'b11;
					reg_w <= 0;
					end

			 end

			 always @ (posedge clk) begin

				PC_plus_4 <= i_PC_plus_4;
				PC_plus_offset <= i_PC_plus_offset;
				PC_rs1 <= i_PC_rs1;
				rv2 <= i_rv2;
				rd <= i_rd;
				imm <= i_imm;
				aluo <= i_aluo;
				
				brnc <= i_brnc;
				mem_t_reg <= i_mem_t_reg;
				reg_w <= i_reg_w;
				rd_in <= i_rd_in;
				mem_w <= i_mem_w;
				mem_r <= i_mem_r;
				zero <= i_zero;

			 end
endmodule