`include "mem_parameters.v"

module DMEM ( clk,wr_en, data_in, addr_in_0, addr_in_1, port_en_0, port_en_1, data_out_0, data_out_1 );

	input wire clk;
	input wire wr_en ;
	input wire [`width-1:0] data_in  ;
	input wire [`width-1:0] addr_in_0  ;
	input wire [`width-1:0] addr_in_1  ;
	input wire [`n-1:0] port_en_0;
	input wire [`n-1:0] port_en_1;
	output reg [`width-1:0] data_out_0;
	output reg [`width-1:0] data_out_1  ;

	reg [7:0] ram1 [0:`IMEM_DEPTH-1];
	reg [7:0] ram2 [0:`IMEM_DEPTH-1];
	reg [7:0] ram3 [0:`IMEM_DEPTH-1];
	reg [7:0] ram4 [0:`IMEM_DEPTH-1];

	always @ (posedge clk)
		begin

			if(wr_en) begin
				case(port_en_0)
				4'd1:ram1[addr_in_0[9:0]] <= data_in;
				4'd2:ram2[addr_in_0[9:0]] <= data_in;
				4'd4:ram3[addr_in_0[9:0]] <= data_in;
				4'd8:ram4[addr_in_0[9:0]] <= data_in;
				4'd3:{ram2[addr_in_0[9:0]],ram1[addr_in_0[9:0]]} <= data_in;
				4'd12:{ram4[addr_in_0[9:0]],ram3[addr_in_0[9:0]]} <= data_in;
				4'd15:{ram4[addr_in_0[9:0]],ram3[addr_in_0[9:0]],ram2[addr_in_0[9:0]],ram1[addr_in_0[9:0]]} <= data_in;
				endcase
				end
			else begin
				case(port_en_0)
				4'd1:data_out_0 <= ram1[addr_in_0[9:0]];
				4'd2:data_out_0 <= ram2[addr_in_0[9:0]];
				4'd4:data_out_0 <= ram3[addr_in_0[9:0]];
				4'd8:data_out_0 <= ram4[addr_in_0[9:0]];
				4'd3:data_out_0 <= {ram2[addr_in_0[9:0]],ram1[addr_in_0[9:0]]} ;
				4'd12:data_out_0 <= {ram4[addr_in_0[9:0]],ram3[addr_in_0[9:0]]} ;
				4'd15:data_out_0 <= {ram4[addr_in_0[9:0]],ram3[addr_in_0[9:0]],ram2[addr_in_0[9:0]],ram1[addr_in_0[9:0]]} ;
				endcase
				end
			case(port_en_1)
				4'd1:data_out_1 <= ram1[addr_in_1[9:0]];
				4'd2:data_out_1 <= ram2[addr_in_1[9:0]];
				4'd4:data_out_1 <= ram3[addr_in_1[9:0]];
				4'd8:data_out_1 <= ram4[addr_in_1[9:0]];
				4'd3:data_out_1 <= {ram2[addr_in_1[9:0]],ram1[addr_in_1[9:0]]} ;
				4'd12:data_out_1 <= {ram4[addr_in_1[9:0]],ram3[addr_in_1[9:0]]} ;
				4'd15:data_out_1 <= {ram4[addr_in_1[9:0]],ram3[addr_in_1[9:0]],ram2[addr_in_1[9:0]],ram1[addr_in_1[9:0]]} ;
				endcase

		end
endmodule