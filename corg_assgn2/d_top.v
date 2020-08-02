`timescale 1ns / 1ps

//Implementation Testbench for DMEM

module top(
    input clk
    ); //Only input from the outside is clock //clk, daddr, indata, outdata, str, stw
	 
	 wire [31:0] daddr, indata, outdata;
	 wire [1:0] str, stw;
	 //Input-output ports controlled by VIO and ILA
	 wire we;
	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 
DMEM instanceA(
		  .clk(manclk), .daddr(daddr), .indata(indata), .outdata(outdata), .str(str), .stw(stw), .we(we) 
		 // Inputs
		 //in1, in2, op
		 ) ;
//Calling the instruction memory instance


//Calls for ICON, VIO and ILA blocks
icon2 instanceB (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio2 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    //.CLK(clk), // IN
    .ASYNC_OUT({daddr, indata, str, stw, manclk,we}), // OUT BUS [69:0]
    .ASYNC_IN(outdata) // IN BUS [31:0]
);

ila2 instanceD (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(outdata) // IN BUS [31:0]
    //.TRIG1(rdy), // IN BUS [0:0]
    //.TRIG2(p) // IN BUS [15:0]
);

endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/