// MEM\WB pipeline register

module memwb( clk, i_ddata, i_aluo, i_rd, i_imm, i_mem_t_reg, i_reg_w, i_rd_in,
			 o_ddata, o_aluo, o_rd, o_imm, o_mem_t_reg, o_reg_w, o_rd_in);

			 input [31:0] i_ddata, i_imm, i_aluo;
			 input [4:0] i_rd;
			 input i_mem_t_reg, i_reg_w, i_rd_in, clk;			 

			 output reg [31:0] o_ddata, o_imm, o_aluo;
			 output reg[4:0] o_rd;
			 output reg o_mem_t_reg, o_reg_w, o_rd_in; 

			 reg mem_t_reg, reg_w, rd_in;

 			 reg [31:0] PC_plus_4, PC_plus_offset, PC_rs1, imm, aluo, ddata;
			 reg [4:0] rd;

 			 always@(*) begin

				o_ddata <= ddata;
				o_rd <= rd;
				o_imm <= imm;
				o_aluo <= aluo;
				
				o_mem_t_reg <= mem_t_reg;
				o_reg_w <= reg_w;
				o_rd_in <= rd_in;

			 end

			 always @ (posedge clk) begin

				ddata <= i_ddata;
				rd <= i_rd;
				imm <= i_imm;
				aluo <= i_aluo;
				
				mem_t_reg <= i_mem_t_reg;
				reg_w <= i_reg_w;
				rd_in <= i_rd_in;

			 end
endmodule