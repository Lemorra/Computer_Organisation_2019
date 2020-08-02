`include "mem_parameters.v"

module IMEM( clk, i_addr, wre, wr_data, i_data);

	input wire clk, wre;
	input wire [`width-1:0] i_addr;
	input wire [`width-1:0] wr_data;
	output reg [`width-1:0] i_data;

	reg [`width-1:0] memory_array [0:`IMEM_DEPTH-1];

	always @ (posedge clk)
		begin

			if(wre) begin
						memory_array[i_addr] <= wr_data;
					end
			else begin
					i_data <= memory_array[i_addr];
				end
		end

endmodule