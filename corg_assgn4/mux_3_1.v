// Mux 3-1

module mux3( min1, min2, min3, mode, mout);

   input [31:0] min1, min2, min3;
   input [1:0] mode;
   output reg [31:0] mout;
	
	always @ (*) begin
	
   case(mode)
   		1'b00: mout <= min1;
   		1'b01: mout <= min2;
   		1'b10: mout <= min3;
   	endcase
	end	

  endmodule