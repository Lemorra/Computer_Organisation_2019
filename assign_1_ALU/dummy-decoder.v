`include "parameters.v"

module DummyDecoder (
    instr,
    op
);
    input [`width-1:0] instr;
    output reg [`OPWIDTH-1:0] op;

    always @(instr) begin
        // Use a case statement or some other logic to generate suitable op code
        //op = 0; // - replace this with some proper logic
		  case(instr[`OPWIDTH:0])
		  7'b0010011: begin
							case(instr[14:12])
							3'b000: op = 6'b000100;
							3'b010: op = 6'b000101;
							3'b011: op = 6'b000110;
							3'b100: op = 6'b000111;
							3'b110: op = 6'b001000;
							3'b111: op = 6'b001001;
							3'b001: op = 6'b001010;
							3'b101: begin 
										case(instr[31:25])
										7'b0000000: op = 6'b001011;
										7'b0100000: op = 6'b001100;
										endcase
									  end	
							endcase
							end
		  7'b0110011: begin
							case(instr[14:12])
							3'b000: begin 
										case(instr[31:25])
										7'b0000000: op = 6'b001101;
										7'b0100000: op = 6'b001110;
										endcase
									  end
							3'b001: op = 6'b001111;
							3'b010: op = 6'b010000;
							3'b011: op = 6'b010001;
							3'b100: op = 6'b010010;
							3'b101: begin 
										case(instr[31:25])
										7'b0000000: op = 6'b010011;
										7'b0100000: op = 6'b010100;
										endcase
									  end
							3'b110: op = 6'b010101;
							3'b111: op = 6'b010110;
							endcase
							end

			endcase
    end

endmodule
