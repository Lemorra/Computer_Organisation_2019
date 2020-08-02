// Control Unit

module CU(op, func3, brnc, mem_r, mem_t_reg, alu_op, mem_w, alu_src1, reg_w, alu_src2, offset_src, jal_act, rd_in);

 input wire[6:0] op;
 input wire[2:0] func3;
 output reg brnc, mem_t_reg, alu_src1, reg_w, alu_src2, offset_src, jal_act, rd_in;
 output reg[1:0] mem_w, mem_r;
 output reg [2:0] alu_op;

always@(*) begin
 case(op)
 	7'b0110111: begin
					 brnc <= 0;  //LUI
 	             mem_r <= 2'b11;
 	             mem_t_reg <=0;
 	             alu_op <= 3'b000;
 	             mem_w <= 2'b11;
 	             alu_src1 <= 1;
 	             alu_src2 <= 1;
 	             offset_src <= 0;
 	             reg_w <=1;
 	             jal_act <= 0;
 	             rd_in <= 1;
					end
 	7'b0010111: begin
					 brnc <= 0;  //AUIPC
 	             mem_r <= 2'b11;
 	             mem_t_reg <=0;
 	             alu_op <= 3'b000;
 	             mem_w <= 2'b11;
 	             alu_src1 <= 0;
 	             alu_src2 <= 1;
 	             offset_src <= 1;
 	             reg_w <=1;
 	             jal_act <= 0;
 	             rd_in <= 0;
					end
 	7'b1101111: begin
					 brnc <= 1;  //JAL
 	             mem_r <= 2'b11;
 	             mem_t_reg <=0;
 	             alu_op <= 3'b010;
 	             mem_w <= 2'b11;
 	             alu_src1 <= 0;
 	             alu_src2 <= 1;
 	             offset_src <= 0;
 	             reg_w <=1;
 	             jal_act <= 1;
 	             rd_in <= 0;
					end
 	7'b1100111: begin
					 brnc <= 1;  //JALR
 	             mem_r <= 2'b11;
 	             mem_t_reg <=0;
 	             alu_src1 <= 0;
 	             alu_src2 <= 1;
 	             offset_src <= 0;
 	             mem_w <= 2'b11;
 	             alu_op <= 3'b100;
 	             reg_w <=1;
 	             jal_act <= 1;
 	             rd_in <= 0;
					end
 	7'b1100011: begin
				    brnc <= 1;  //Branch
 	             mem_r <= 2'b11;
 	             mem_t_reg <=0;
 	             alu_op <= 3'b001;
 	             mem_w <= 2'b11;
 	             alu_src1 <= 1;
 	             alu_src2 <= 0;
 	             offset_src <= 0;
 	             reg_w <=0;
 	             jal_act <= 0;
 	             rd_in <= 0;
					end
 	7'b0000011: begin
					 brnc <= 0;  //Load
					case(func3)
					3'b000:  mem_r <= 2'b00;
					3'b001:  mem_r <= 2'b01;
					3'b010:  mem_r <= 2'b10;
					3'b100:  mem_r <= 2'b00;
					3'b101:  mem_r <= 2'b01;
					endcase
 	             mem_t_reg <= 1;
 	             alu_op <= 3'b000;
 	             mem_w <= 2'b11;
 	             alu_src1 <= 1;
 	             alu_src2 <= 1;
 	             reg_w <=1;
 	             offset_src <= 1;
 	             jal_act <= 0;
 	             rd_in <= 0;
					end
 	7'b0100011: begin
					 brnc <= 0;  //Store 
 	             mem_r <= 2'b11;
 	             mem_t_reg <= 0;
 	             alu_op <= 3'b000;
 	            case(func3)
					3'b000:  mem_w <= 2'b00;
					3'b001:  mem_w <= 2'b01;
					3'b010:  mem_w <= 2'b10;
					endcase
 	             alu_src1 <= 1;
 	             alu_src2 <= 1;
 	             reg_w <=0;
 	             offset_src <= 1;
 	             jal_act <= 0;
 	             rd_in <= 0;
					end
 	7'b0010011: begin
					 brnc <= 0;  //Immediate alu 
 	             mem_r <= 2'b11;
 	             mem_t_reg <= 0;
 	             alu_op <= 3'b101;
 	             mem_w <= 2'b11;
 	             alu_src1 <= 1;
 	             alu_src2 <= 1;
 	             reg_w <=1;
 	             offset_src <= 0;
 	             jal_act <= 0;
 	             rd_in <= 0;
					end
 	7'b0110011: begin
					 brnc <= 0;  //Alu 
 	             mem_r <= 2'b11;
 	             mem_t_reg <= 0;
 	             alu_op <= 3'b011;
 	             mem_w <= 2'b11;
 	             alu_src1 <= 1;
 	             alu_src2 <= 0;
 	             reg_w <=1;
 	             offset_src <= 0;
 	             jal_act <= 0;
 	             rd_in <= 0;
					end
 endcase
 end
 endmodule