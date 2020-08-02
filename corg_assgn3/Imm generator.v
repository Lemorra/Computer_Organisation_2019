// Imm generator

 module gen( instr, imm, offset);

  input [31:0] instr;
  output reg [31:0] imm, offset;
  
  always@(*) begin

  case(instr[6:0])
  		7'b0110111: begin
						 imm <= {instr[31:12],{12{1'b0}}};
						 offset <= 32'd0;
						end
  		7'b0010111: begin
						 offset <= {{12{instr[31]}},instr[31:12]};
						 imm <= 32'd0;
						end
  		7'b1101111: begin
						 offset <= {{12{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
						 imm <= 32'd0;
						end
  		7'b1100111: begin
						 offset <= {{20{instr[31]}},instr[31:20]};
						 imm <= 32'd0;
						end
  		7'b1100011: begin
						 offset <= (instr[14:12] == 3'b110 | instr[14:12] == 3'b111)? {{20{1'b0}}, instr[31], instr[7], instr[30:25], instr[11:8],1'b0}: {{20{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8],1'b0};
						 imm <= 32'd0;
						end
  		7'b0000011: begin
						 offset <= (instr[14:12] == 3'b100 | instr[14:12] == 3'b101)? {{20{1'b0}},instr[31:20]}: {{20{instr[31]}},instr[31:20]};
						 imm <= 32'd0;
						end
  		7'b0100011: begin
						 offset <= {{20{instr[31]}},instr[31:25],instr[11:7]};
						 imm <= 32'd0;
						end
  		7'b0010011: begin
						 imm <= (instr[14:12] == 3'b001 | instr[14:12] == 3'b101)? {{27{1'b0}},instr[24:20]}: {{20{1'b0}},instr[31:20]};
						 offset <= 32'b0;
						end
  		default: begin
						 imm <= 32'd0;
						 offset <= 32'd0;
						end
  endcase
  end
  endmodule