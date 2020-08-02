 // Hazard detection unit

  module hdu( clk, idex_memr, idex_rd, ifid_rs1, ifid_rs2 , piprcon, pcnoch, ifidnoch);

    input [1:0] idex_memr;
	 input clk;
    input [4:0] idex_rd, ifid_rs1, ifid_rs2;
    output reg piprcon, pcnoch, ifidnoch;
	 
	 initial begin
		piprcon <= 0;
      pcnoch <= 0;
      ifidnoch <= 0;
	 end

    always@(*) begin

      if( idex_memr & ((idex_rd == ifid_rs1) | (idex_rd == ifid_rs2))) begin
        piprcon <= 1;
        pcnoch <= 1;
        ifidnoch <= 1;
      end

     // else begin
		   @( posedge clk) begin
        piprcon <= 0;
        pcnoch <= 0;
        ifidnoch <= 0;
		  end
       // end
		 /*if ( piprcon == 1 & clk) begin //To stall one clk cycle
			piprcon <= 0;
			pcnoch <= 0;
			ifidnoch <= 0;
			end*/

    end
  endmodule