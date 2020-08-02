 //Muxes

  module mux( min1, min2, mode, mout);

   input [31:0] min1, min2;
   input mode;
   output reg [31:0] mout;

	always@(*) begin

   case(mode)
   		1'b0:  mout <= min1;
   		1'b1:  mout <= min2;
   	endcase
	end
  endmodule