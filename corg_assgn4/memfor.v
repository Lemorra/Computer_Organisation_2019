// Forwarding control for mem

  module forconm( exmem_regw, exmem_rd, idex_rs2, memwb_regw, memwb_rd, wrdatacon);

  	input exmem_regw, memwb_regw;
  	input [4:0] exmem_rd, idex_rs2, memwb_rd;
  	output reg wrdatacon;

  		always@(*) begin

  			if(memwb_regw & (memwb_rd != 0) & !(exmem_regw & (exmem_rd != 0)& (exmem_rd == idex_rs2)) & (memwb_rd == idex_rs2))
  				wrdatacon <= 1;

  			else 
  				wrdatacon <= 0;

  		end

  endmodule