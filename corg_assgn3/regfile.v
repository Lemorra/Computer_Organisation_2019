`include "mem_parameters.v"

module RegFile ( clk, rs1, rs2, rd, we, indata, rv1, rv2, reg31 );

	input wire [`rwidth-1:0] rs1, rs2, rd;
	input wire [`width-1:0] indata;
	input wire we, clk;
	output  [`width-1:0] rv1, rv2;
   output  [31:0] reg31;
	
	reg [31:0] RF [0:31];
	
	integer i;
	
	initial begin            //Code borrowed from my friend
	 for(i=0 ; i<32 ; i=i+1)
	  RF[i] = {32{1'b0}};
	end
	
	//always@(*) begin
	 assign rv1 = RF[rs1];
	 assign rv2 = RF[rs2];
	 assign reg31 = RF[32'd31];
	//end

	//always @ (posedge clk)
	always @ (*)
		begin 
			RF[0] <= 32'h0000;
			if(we && rd!== 32'h0000)
				RF[rd] <= indata;
			//rv1 <= RF[rs1];
			//rv2 <= RF[rs2];
		end
endmodule
