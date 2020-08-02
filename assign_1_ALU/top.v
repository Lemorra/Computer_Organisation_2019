`timescale 1ns / 1ps

//Implementation Testbench for A0

module top(
    input clk
    ); //Only input from the outside is clock
	 
	 wire [31:0] in1,in2,out,instr;
	 wire [5:0] op;
	 //Input-output ports controlled by VIO and ILA
	 
	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 
ALU32 instanceA(
		 // Outputs
		 .out(out), 
		 // Inputs
		 .in1(in1), .in2(in2), .op(op)
		 ) ;
DummyDecoder dec(
    // Inputs
    .instr(instr),
	 // Output
    .op(op)
);
//Calling the multiplier instance


//Calls for ICON, VIO and ILA blocks
icon0 instanceB (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    //.CLK(clk), // IN
    .ASYNC_OUT({in1,in2,instr}), // OUT BUS [95:0]
    .ASYNC_IN(out) // IN BUS [31:0]
);

ila0 instanceD (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(out) // IN BUS [31:0]
    //.TRIG1(rdy), // IN BUS [0:0]
    //.TRIG2(p) // IN BUS [15:0]
);

endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/