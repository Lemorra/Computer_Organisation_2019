`timescale 1ns / 1ps

//Implementation Testbench for IMEM

module top(
    input clk
    ); //Only input from the outside is clock //clk, i_addr, wre, wr_data, i_data
	 
	 wire [31:0] i_addr, i_data, wr_data;
	 wire wre;
	 wire manClk;
	 //Input-output ports controlled by VIO and ILA
	 
	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 
IMEM instanceA(
		  .clk(manClk), .i_addr(i_addr), .wre(wre), .wr_data(wr_data), .i_data(i_data) 
		 		 ) ;
//Calling the instruction memory instance


//Calls for ICON, VIO and ILA blocks
icon0 instanceB (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    //.CLK(clk), // IN
    .ASYNC_OUT({i_addr, wre, wr_data,manClk}), // OUT BUS [62:0]
    .ASYNC_IN(i_data) // IN BUS [31:0]
);

ila0 instanceD (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(i_data) // IN BUS [31:0]
    //.TRIG1(rdy), // IN BUS [0:0]
    //.TRIG2(p) // IN BUS [15:0]
    );

endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/