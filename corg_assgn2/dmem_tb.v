`timescale 1ns/1ns
`include "mem_parameters.v"

module tb ();

  // Inputs       clk, daddr, indata, outdata, str, stw

  reg tclk;
  reg [`width-1:0] tdaddr, tindata;
  reg [1:0] tstr, tstw;
  reg [`width-1:0] datatest [0:29];
  // Output

  wire [`width-1:0] toutdata;

  integer i;

  DMEM uut(

  			.clk(tclk), 
  			.daddr(tdaddr),
  			.indata(tindata),
  			.outdata(toutdata),
  			.str(tstr),
  			.stw(tstw)
  			);


always
        #5 tclk = ~tclk;

initial begin

tclk = 1;
tdaddr = 0;
tindata = 0;
i=0;
tstr = 3;
tstw = 3;

$readmemh("instr.txt",datatest);
tstw = 2;
end

 //tstw = 2;
 
always @(posedge tclk)
	begin
		if ( i <= 30) begin
			tstw = 2;
			tdaddr = i;
			tindata = datatest[i];
			i = i+1;
		end
	end
endmodule
