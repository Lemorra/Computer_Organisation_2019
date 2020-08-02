`timescale 1ns / 1ps

//Implementation Testbench for A0

module handler(
     clk
    ); //Only input from the outside is clock
 input wire clk;
 wire manclk;
 wire reset;
 wire [31:0] x31,pcactual,idata ;
 wire [35:0] ILA_CONTROL, VIO_CONTROL;
 wire override_interrupt,invalid,readerror,writeerror,outofboundaccess,branch_fail;
	 //Control wires used by ICON to control VIO and ILA
	 
top instanceA( 
		 // Outputs
		 .reset(reset),.clk(manclk), 
		 // Inputs
		 .x31(x31),.pcactual(pcactual),.idatasent(idata),.override(override_interrupt),.invalid(invalid),.readerror(readerror),
		 .writeerror(writeerror),.outofboundaccess(outofboundaccess),.branch_fail(branch_fail)
		 ) ;
		 
		 
//Calls for ICON, VIO and ILA blocks
icon1 instanceD (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio22 instanceE (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .ASYNC_OUT({reset,manclk,override_interrupt}), // OUT BUS [16:0]
    .ASYNC_IN({pcactual,x31,idata,invalid,readerror,writeerror,outofboundaccess,branch_fail}) // IN BUS [16:0]
);             
 
ila1 instanceF (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk) ,
	 .TRIG0(clk)// IN
);

endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/