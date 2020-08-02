// ALU Control(Under construction)

module alu_con(fun_7,fun_3, alu_op, alu_con);

input [6:0] fun_7;
input [2:0] fun_3;
input [2:0] alu_op;
output reg [4:0] alu_con;
always@(*) begin
case(alu_op)
	3'b000:  alu_con <= 5'b00000;//add
	3'b001: begin
			case(fun_3)
				3'b000:  alu_con <= 5'b01010;//eq
				3'b001:  alu_con <= 5'b01011;//neq
				3'b100:  alu_con <= 5'b01100;//lt
				3'b101:  alu_con <= 5'b01101;//ge
				3'b110:  alu_con <= 5'b01110;//ltu
				3'b111:  alu_con <= 5'b01111;//geu
			endcase
			end
	3'b010:  alu_con <= 5'b10001;	
	3'b011: begin //alu
			case(fun_7)
				7'b0000000:case(fun_3)
							3'b000:  alu_con <= 5'b00000; //add
							3'b001:  alu_con <= 5'b00001; //sll
							3'b010:  alu_con <= 5'b00010; //slt
							3'b011:  alu_con <= 5'b00011; //sltu
							3'b100:  alu_con <= 5'b00100; //xor
							3'b101:  alu_con <= 5'b00101; //srl
							3'b110:  alu_con <= 5'b00110; //or
							3'b111:  alu_con <= 5'b00111; //and
						   endcase
				7'b0100000:case(fun_3)
							3'b000:  alu_con <= 5'b01000; //sub
							3'b101:  alu_con <= 5'b01001; //sra
						   endcase
				endcase
		  end
	3'b100:  alu_con <= 5'b10000;
	3'b101: begin //alu immediate
				case(fun_3)
				3'b000:  alu_con <= 5'b00000; //add
				3'b001:  alu_con <= 5'b00001; //sll
				3'b010:  alu_con <= 5'b00010; //slt
				3'b011:  alu_con <= 5'b00011; //sltu
				3'b100:  alu_con <= 5'b00100; //xor
				3'b101: begin
							case(fun_7)
							7'b0000000: alu_con <= 5'b00101; //srl
							7'b0100000: alu_con <= 5'b01001; //sra
							endcase
						  end
				3'b110:  alu_con <= 5'b00110; //or
				3'b111:  alu_con <= 5'b00111; //and
				endcase
			 end					
endcase
end
endmodule