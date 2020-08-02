// Forwarding control

  module forcon( exmem_regw, exmem_rd, idex_rs1, idex_rs2, memwb_regw, memwb_rd, a1con, a2con);

  	input exmem_regw, memwb_regw;
  	input [4:0] exmem_rd, idex_rs1, idex_rs2, memwb_rd;
  	output reg [1:0] a1con, a2con;
  	//output wrdatacon;

  	always@(*) begin

  		if(exmem_regw & (exmem_rd != 0) & (exmem_rd == idex_rs1)) begin
  			a1con <= 2'b10;
			end

  		else if(memwb_regw & (memwb_rd != 0) & !(exmem_regw & (exmem_rd != 0)& (exmem_rd == idex_rs1)) & (memwb_rd == idex_rs1))
  			a1con <= 2'b01;

  		else
  		    a1con <= 2'b00;

  		if(exmem_regw & (exmem_rd != 0) & (exmem_rd == idex_rs2))
  			a2con <= 2'b10;

  		else if(memwb_regw & (memwb_rd != 0) & !(exmem_regw & (exmem_rd != 0)& (exmem_rd == idex_rs2)) & (memwb_rd == idex_rs2))
  			a2con <= 2'b01;

  		else
  			a2con <= 2'b00;

  		//if(memwb_regw & (memwb_rd != 0) & !(exmem_regw & (exmem_rd != 0)& (exmem_rd == idex_rs2)) & (memwb_rd == idex_rs2))
  		//	wrdatacon <= 1;

  		//else 
  		//	wrdatacon <= 0;

  	end
  endmodule