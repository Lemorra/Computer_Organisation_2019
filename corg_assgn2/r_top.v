`timescale 1ns / 1ps

//Implementation Testbench for IMEM

module top(
    input clk
    ); //Only input from the outside is clock //clk, rs1, rs2, rd, we, indata, rv1, rv2
	 
	 wire [31:0] indata, rv1, rv2;
	 wire [4:0] rs1, rs2, rd;
     wire we;
	 //Input-output ports controlled by VIO and ILA
	 
	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 
//RegFile instanceA(
	//	  .clk(manclk), .rs1(rs1), .rs2(rs2), .rd(rd), .we(we), .indata(indata), .rv1(rv1), .rv2(rv2) 
		 // Inputs
		 //in1, in2, op
		// ) ;
//Calling the instruction memory instance

reg_file instance_name (
    .clk(manclk), 
    .we(we), 
    .rd(rd), 
    .indata(indata), 
    .rs1(rs1), 
    .rv1(rv1), 
    .rs2(rs2), 
    .rv2(rv2)
    );




//Calls for ICON, VIO and ILA blocks
icon1 instanceB (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio1 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    //.CLK(clk), // IN
    .ASYNC_OUT({rs1, rs2, rd, we, indata,manclk}), // OUT BUS [62:0]
    .ASYNC_IN({rv1, rv2}) // IN BUS [31:0]
);

ila1 instanceD (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(rv1), // IN BUS [31:0]
    .TRIG1(rv2) // IN BUS [0:0]
    //.TRIG2(p) // IN BUS [15:0]
);

endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/