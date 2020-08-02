`include "parameters.v"

module ALU32 (
    in1, in2, op, out
);
    input [`width-1:0] in1, in2;
    input [`OPWIDTH-1:0] op;
    output reg [`width-1:0] out;

    always @(in1 or in2 or op) begin
        case(op)
		  6'b000100: out = in1 + in2;
		  6'b000101: out = $signed(in1) < $signed(in2);
		  6'b000110: out = in1 < in2;
		  6'b000111: out = in1 ^ in2;
		  6'b001000: out = in1 | in2;
		  6'b001001: out = in1 & in2;
		  6'b001010: out = in1 << in2[3:0];
		  6'b001011: out = in1 >> in2[3:0];
		  6'b001100: out = $signed(in1) >>> in2[3:0];
		  6'b001101: out = in1 + in2;
		  6'b001110: out = in1 - in2;
		  6'b001111: out = in1 << in2[3:0];
		  6'b010000: out = $signed(in1) < $signed(in2);
		  6'b010001: out = in1 < in2;
		  6'b010010: out = in1 ^ in2;
		  6'b010011: out = in1 >> in2[3:0];
		  6'b010100: out = $signed(in1) >>> in2[3:0];
		  6'b010101: out = in1 | in2;
		  6'b010110: out = in1 & in2;
		  default:$display("Invalid opcode");
		  endcase
    end

endmodule