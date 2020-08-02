
// Special Mux to support hazard detection unit

module splmux(i_reg_w, i_mem_w, piprcon, o_reg_w, o_mem_w);

	input i_reg_w, piprcon;
	input [1:0] i_mem_w;
	output reg o_reg_w;
	output reg [1:0] o_mem_w;

	always @ (*) begin

		if (piprcon) begin
			o_reg_w <= 0;
			o_mem_w <= 2'b11;

			end

		else begin

			o_reg_w <= i_reg_w;
			o_mem_w <= i_mem_w;
		end

	end

endmodule