`include "mem_parameters.v"

module TDPram ( clk, we_0, we_1, data_in0, data_in1, addr_in_0, addr_in_1, data_out_0, data_out_1 );

	input wire clk;
	input wire we_0, we_1 ;
	input wire [`mem_wid-1:0] data_in0, data_in1  ;
	input  [`width-1:0] addr_in_0  ;
	input wire [`width-1:0] addr_in_1  ;
	output reg [`mem_wid-1:0] data_out_0;
	output reg [`mem_wid-1:0] data_out_1  ;

	reg [7:0] ram [0:`IMEM_DEPTH-1];
	//reg [7:0] ram2 [0:`IMEM_DEPTH-1];
	//reg [7:0] ram3 [0:`IMEM_DEPTH-1];
	//reg [7:0] ram4 [0:`IMEM_DEPTH-1];

	always @ (posedge clk)begin
		//if(enable) begin
			if(we_0) begin
				ram[addr_in_0] <= data_in0;
				end
			else
				data_out_0 <= ram[addr_in_0[9:0]];
		end
		//end

	always @ (posedge clk)begin
		//if(enable) begin
			if(we_1) begin                            //keeping we_1 at 0 always to dual port ram
				ram[addr_in_1] <= data_in1;
				end
			else
				data_out_1 <= ram[addr_in_1[9:0]];
		//end
		end

endmodule

module DMEM ( clk, daddr, indata, outdata, str, stw, we);

input wire clk; 
input wire [1:0] stw, str;
input wire [31:0] daddr;
input wire we;
input wire [31:0] indata;
output reg [31:0] outdata;

reg we_t0, we_t1, we_t2, we_t3;
reg [`mem_wid-1:0] indata1, indata2, indata3, indata4;
wire [31:0] outdata_01, outdata_02, outdata_03, outdata_04;
wire [31:0] outdata_11, outdata_12, outdata_13, outdata_14;
wire [31:0] add1;

assign add1 = daddr[31:0];
//reg [7:0] dm [0:1023];

//assuming that str takes care for operation involving byte, half word, word
// and reading and writing doesnt happen at the same address location 
always @ (*)begin
if(we) begin
case(stw)
	2'd0:case(daddr[1:0])
	     2'd0:begin
	     		 we_t0 <= 1'b1;
				 we_t1 <= 1'b0;
				 we_t2 <= 1'b0;
				 we_t3 <= 1'b0;
	     		 indata1 <= indata[7:0];
	     	  end
	     2'd1:begin
	     		 we_t0 <= 1'b0;
				 we_t1 <= 1'b1;
				 we_t2 <= 1'b0;
				 we_t3 <= 1'b0;
	     		 indata2 <= indata[7:0];
	     	  end
		 2'd2:begin
	     		 we_t0 <= 1'b0;
				 we_t1 <= 1'b0;
				 we_t2 <= 1'b1;
				 we_t3 <= 1'b0;
	     		 indata3 <= indata[7:0];
	     	  end
	     2'd3:begin
	     		 we_t0 <= 1'b0;
				 we_t1 <= 1'b0;
				 we_t2 <= 1'b0;
				 we_t3 <= 1'b1;
	     		 indata4 <= indata[7:0];
	     	  end
	     endcase
	2'd1:case(daddr[1])
			2'd0:begin
					 we_t0 <= 1'b1;
					 we_t1 <= 1'b1;
					 we_t2 <= 1'b0;
					 we_t3 <= 1'b0;
					 indata1 <= indata[15:8];
					 indata2 <= indata[7:0];
					end
			2'd1:begin
					 we_t0 <= 1'b0;
					 we_t1 <= 1'b0;
					 we_t2 <= 1'b1;
					 we_t3 <= 1'b1;
					 indata3 <= indata[15:8];
					 indata4 <= indata[7:0];
					end
	     endcase
	2'd2:begin
			 we_t0 <= 1'b1;
			 we_t1 <= 1'b1;
			 we_t2 <= 1'b1;
			 we_t3 <= 1'b1;
			 indata1 <= indata[7:0];
			 indata2 <= indata[15:8];
			 indata3 <= indata[23:16];
			 indata4 <= indata[31:24];
			end
	2'd3:begin
			 we_t0 <= 1'b0;
			 we_t1 <= 1'b0;
			 we_t2 <= 1'b0;
			 we_t3 <= 1'b0;
			end
endcase
end else begin			
 case(str)
 	 2'd0:case(daddr[1:0])
			2'd0: outdata <= outdata_11 ;
			2'd1: outdata <= outdata_12;
			2'd2: outdata <= outdata_13;
			2'd3: outdata <= outdata_14;
			endcase
	 2'd1:case(daddr[1])
			2'd0:begin
					 outdata <= {outdata_11,outdata_12};
					 //outdata <= {outdata_13,outdata_14};
					end
			2'd1:begin
					 outdata <= {outdata_13,outdata_14};
					end
			endcase		
	 2'd2:begin
			 outdata <= {outdata_11,outdata_12,outdata_13,outdata_14};
			end
	 2'd3:begin
			 outdata <= 0;
			end
 endcase
 end
end
TDPram m1(.clk(clk), .we_0(we_t0), .we_1(1'b0), .data_in0(indata1), .data_in1(0), .addr_in_0(add1), .addr_in_1(add1), .data_out_0(outdata_01), .data_out_1(outdata_11));
TDPram m2(.clk(clk), .we_0(we_t1), .we_1(1'b0), .data_in0(indata2), .data_in1(0), .addr_in_0(add1), .addr_in_1(add1), .data_out_0(outdata_02), .data_out_1(outdata_12));
TDPram m3(.clk(clk), .we_0(we_t2), .we_1(1'b0), .data_in0(indata3), .data_in1(0), .addr_in_0(add1), .addr_in_1(add1), .data_out_0(outdata_03), .data_out_1(outdata_13));
TDPram m4(.clk(clk), .we_0(we_t3), .we_1(1'b0), .data_in0(indata4), .data_in1(0), .addr_in_0(add1), .addr_in_1(add1), .data_out_0(outdata_04), .data_out_1(outdata_14));
endmodule			