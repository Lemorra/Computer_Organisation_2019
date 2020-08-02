// module for adjusting the write data for dmem

module adjter(rs2, memw, aluo, wdata);

  input wire[31:0] rs2;
  input wire[1:0] memw;
  input wire[1:0] aluo;
  output reg [31:0] wdata;

  always @(*) begin

   case(memw)
    2'b00: begin
    		case(aluo)
    		 2'b00:  wdata <= rs2;
    		 2'b01:  wdata <= {{16{1'b0}},rs2[7:0],{8{1'b0}}};
    		 2'b10:  wdata <= {{8{1'b0}},rs2[7:0],{16{1'b0}}};
    		 2'b11:  wdata <= {rs2[7:0],{24{1'b0}}};
    		endcase
    	   end
    2'b01: begin
            case(aluo[1])
             1'b0:  wdata <= rs2;
             1'b1:  wdata <= {rs2[15:0],{16{1'b0}}};
				endcase 
           end
    default:  wdata <= rs2;
   endcase
  end
endmodule