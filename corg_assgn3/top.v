`timescale 1ns / 1ps

//Implementation Testbench for Single cycle cpu

module top(
    input clk
    ); //Only input from the outside is clock 
	 
	 wire [31:0] iaddr, idata, daddr, drdata, dwdata, x31, pc, wr_data;
	 wire [3:0] we;
	 //Input-output ports controlled by VIO and ILA
	 wire manCLK;
	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 
CPU instanceA(
		  .clk(manCLK), .reset(reset), .iaddr(iaddr), .idata(idata), .daddr(daddr), .drdata(drdata), .dwdata(dwdata), .we(we), .x31(x31), .pc(pc)
		 		 ) ;
//Calling the CPU instance

imem instanceB(.iaddr(iaddr), .idata(idata));
//Calling the IMEM instance

dmem instanceC( .clk(manCLK), .daddr(daddr), .dwdata(dwdata), .we(we), .drdata(drdata));
//Calling the DMEM instance

//Calls for ICON, VIO and ILA blocks
icon0 instanceD (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceE (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .ASYNC_OUT({reset,manCLK}), // OUT BUS 2 bit
    .SYNC_IN({idata,we,x31,pc}) // IN BUS [99:0]
);

ila0 instanceF (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(x31), // IN BUS [31:0]
    .TRIG1(pc), // IN BUS [31:0]
	 .TRIG2(we), // IN BUS [3:0]
	 //.TRIG3(dwdata), // IN BUS [31:0]
	 //.TRIG4(drdata), // IN BUS [31:0]
	 //.TRIG5(daddr), // IN BUS [31:0]
	 .TRIG3(idata) // IN BUS [31:0]
	 //.TRIG6(iaddr)// IN BUS [31:0]
    );

endmodule
