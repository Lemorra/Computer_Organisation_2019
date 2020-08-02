// ALU
module ALU(alu_con, in1, in2, out, zero);

 input wire[4:0] alu_con;
 input wire[31:0] in1, in2;
 output reg[31:0] out;
 output reg[1:0] zero; 
 
 always@(*) begin
  zero <= 0;

 case(alu_con)
 	5'b00000:  out <= in1 + in2;//add
 	5'b00001:  out <= in1 << in2;
 	5'b00010:  out <= $signed(in1) < $signed(in2);
 	5'b00011:  out <= (in1 < in2)? in1: in2;
 	5'b00100:  out <= in1 ^ in2;
 	5'b00101:  out <= in1 >> in2;
 	5'b00110:  out <= in1 | in2;
 	5'b00111:  out <= in1 & in2;
 	5'b01000:  out <= $signed(in1) - $signed(in2);
 	5'b01001:  out <= $signed(in1) >> in2;
 	5'b01010: begin
				  zero <= ($signed(in1) == $signed(in2))? 2'b01: 2'b00;
				  out <= 32'd0;
				 end
 	5'b01011: begin
				  zero <= ($signed(in1) == $signed(in2))? 2'b00: 2'b01;
				  out <= 32'd0;
				 end
 	5'b01100: begin
				  zero <= ($signed(in1) < $signed(in2))? 2'b01: 2'b00;
				  out <= 32'd0;
				 end
 	5'b01101: begin
				  zero <= ($signed(in1) >= $signed(in2))? 2'b01: 2'b00;
				  out <= 32'd0;
				 end
 	5'b01110: begin
				  zero <= (in1 < in2)? 2'b01: 2'b00;
				  out <= 32'd0;
				 end
 	5'b01111: begin
				  zero <= (in1 >= in2)? 2'b01: 2'b00;
				  out <= 32'd0;
				 end
 	5'b10000: begin
				  out <= in1 + in2;
 	           zero <= 2'b10;
				 end
 	5'b10001: begin
				  out <= in1 + in2;
 	           zero <= 2'b01;
				 end
 endcase
 end
 endmodule