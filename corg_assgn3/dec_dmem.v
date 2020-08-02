// Decoder for Dmem

module demem( adata, odata, mem_w, mem_r, we, out, addr);

	input [31:0] adata, odata;
	input [1:0] mem_w, mem_r;
	output reg[3:0] we;
	output reg[31:0] out, addr;

always@(*) begin

	case(mem_w)
		2'b00:begin 
				 addr <= {adata[31:2],{2{1'b0}}};
				case(adata[1:0])
					2'b00:  we <= 4'b0001;
					2'b01:  we <= 4'b0010;
					2'b10:  we <= 4'b0100;
					2'b11:  we <= 4'b1000;
				endcase
				end
		2'b01:begin
				 addr <=  {adata[31:1],{1{1'b0}}};
				case(adata[1])
					1'b0:  we <= 4'b0011;
					1'b1:  we <= 4'b1100;
				endcase
				end
		2'b10:begin
				 addr <= adata;
				 we <= 4'b1111;
				end
		2'b11: we <= 4'b0000;
	endcase

	case(mem_r)
		2'b00: case(adata[1:0])
				2'b00: begin
						  addr <= adata;
						  out <= {{24{1'b0}},odata[7:0]};
						 end
				2'b01: begin
						  addr <= adata;
						  out <= {{24{1'b0}},odata[15:8]};
						 end
				2'b10: begin
						  addr <= adata;
						  out <= {{24{1'b0}},odata[23:16]};
						 end
				2'b11: begin
						  addr <= adata;
						  out <= {{24{1'b0}},odata[31:24]};
						 end
				endcase
		2'b01: case(adata[1])
				1'b0: begin
						 addr <= adata;
						 out <= {{16{1'b0}},odata[15:0]};
						end
				1'b1: begin
						 addr <= adata;
						 out <= {{16{1'b0}},odata[31:16]};
						end
				endcase
		2'b10: begin
				  addr <= adata;
				  out <= odata;
				 end
	endcase
end
endmodule