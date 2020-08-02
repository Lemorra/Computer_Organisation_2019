// ID\EX pipeline register

module idex( clk, i_pc, i_rs1, i_rs2, i_rv1, i_rv2, i_rd, i_imm, i_offset, i_brnc, i_mem_r, i_mem_t_reg, i_alucon, i_mem_w, i_alu_src1, i_alu_src2, i_reg_w, i_offset_src, i_jal_act, i_rd_in,
			         o_pc, o_rs1, o_rs2, o_rv1, o_rv2, o_rd, o_imm, o_offset, o_brnc, o_mem_r, o_mem_t_reg, o_alucon, o_mem_w, o_alu_src1, o_alu_src2, o_reg_w, o_offset_src, o_jal_act, o_rd_in, flush);

			 input [31:0] i_pc, i_rv1, i_rv2, i_imm, i_offset;
			 input i_brnc, i_mem_t_reg, i_alu_src1, i_reg_w, i_alu_src2, i_offset_src, i_jal_act, i_rd_in, flush, clk;
			 input [1:0] i_mem_w, i_mem_r;
			 input [4:0] i_alucon, i_rs1, i_rs2, i_rd;

			 output reg [31:0] o_pc, o_rv1, o_rv2, o_imm, o_offset;
			 output reg o_brnc, o_mem_t_reg, o_alu_src1, o_reg_w, o_alu_src2, o_offset_src, o_jal_act, o_rd_in;
			 output reg [1:0] o_mem_w, o_mem_r;
			 output reg [4:0] o_alucon, o_rs1, o_rs2, o_rd;

			 reg brnc, mem_t_reg, alu_src1, reg_w, alu_src2, offset_src, jal_act, rd_in;
 			 reg[1:0] mem_w, mem_r;
 			 reg [4:0] alucon, rd, rs1, rs2;

 			 reg [31:0] pc, rv1, rv2, imm, offset;

 			 always@(*) begin

				o_pc <= pc;
				o_rs1 <= rs1;
				o_rs2 <= rs2;
				o_rv1 <= rv1;
				o_rv2 <= rv2;
				o_rd <= rd;
				o_imm <= imm;
				o_offset <= offset;

				o_brnc <= brnc;
				o_mem_t_reg <= mem_t_reg;
				o_alu_src1 <= alu_src1;
				o_reg_w <= reg_w;
				o_alu_src2 <= alu_src2;
				o_offset_src <= offset_src;
				o_jal_act <= jal_act;
				o_rd_in <= rd_in;
				o_mem_w <= mem_w;
				o_mem_r <= mem_r;
				o_alucon <= alucon;

				if(flush) begin
					pc <= 0;
					rv1 <= 0;
					rv2 <= 0;
					rs1 <= 0;
					rs2 <= 0;
					rd <= 0;
					imm <= 0;
					offset <= 0;
					mem_w <= 2'b11;
					reg_w <= 0;
					brnc <= 0;
					mem_t_reg <= 0;
					rd_in <= 0;
					end

			 end

			 always @ (posedge clk) begin

				pc <= i_pc;
				rs1 <= i_rs1;
				rs2 <= i_rs2;
				rv1 <= i_rv1;
				rv2 <= i_rv2;
				rd <= i_rd;
				imm <= i_imm;
				offset <= i_offset;
				
				brnc <= i_brnc;
				mem_t_reg <= i_mem_t_reg;
				alu_src1 <= i_alu_src1;
				reg_w <= i_reg_w;
				alu_src2 <= i_alu_src2;
				offset_src <= i_offset_src;
				jal_act <= i_jal_act;
				rd_in <= i_rd_in;
				mem_w <= i_mem_w;
				mem_r <= i_mem_r;
				alucon <= i_alucon;

			 end
endmodule