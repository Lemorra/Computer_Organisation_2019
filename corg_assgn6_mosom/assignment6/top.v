`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:45 11/01/2019 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(clk,reset,pcactual,x31,idatasent,override,invalid,readerror,writeerror,outofboundaccess,branch_fail
    );
wire pcfreeze;
wire inbranchactual;
input wire clk,reset,override;
wire [31:0] dmemout;
wire validitymux;
wire [31:0] exmemoutin;
wire [4:0] exmemrdout;
wire [31:0] pc;
output wire [31:0]x31,pcactual;
output wire branch_fail;
assign pcactual=pc-4;
wire [31:0]rv1branch;
wire [1:0]pcmuxbranch;
wire inbranch;
wire [31:0] addressbranch;
wire [31:0] immtoimem;
wire [4:0] rs1out;
wire [4:0] rs2out;
wire [1:0] pcmuxtoimem;
wire newdecoder;
wire [31:0] pcstored;
wire pcpump,pclock;
wire [31:0] idataactual;
wire [31:0] idatadecoder;
output wire [31:0] idatasent;
wire [31:0] idexrv1in;
wire [31:0] rv1muxout;
wire [31:0] rv1toimem;
imem dut0(.clk(clk),.rv1(rv1toimem),.pcmux(pcmuxtoimem),.in(inbranchactual),.imm(immtoimem),.pc(pc),.new(newdecoder),
.idata(idataactual),.pcfreeze(pcfreeze),.pcpump(pcpump),.pclock(pclock),.pcstored(pcstored));

idatamux dut18( .inbranch(inbranchactual),.idataactual(idataactual),.idatadecoder(idatadecoder)
    );

wire [4:0] rs1in;
wire [4:0] rs2in;
wire [4:0] idexrdin;
wire [5:0] idexopin;
wire idexwrin;
wire [4:0] idexshamtin;
wire [31:0] idexaddressin;
wire rs1muxin;
wire rs2muxin;
wire [1:0] idexrdmuxin;
wire idexsigncontrolin;
wire [1:0] idexwritecontrolin;
wire [1:0] idexreadcontrolin;
wire [1:0]idexpcmuxin;
wire [31:0] idexpcout;
wire jalr;
wire luiin,luiout;
output wire invalid;
imm dut20(.inbranch(inbranchactual),.addressbranch(addressbranch),.idexaddressin(idexaddressin),.immtoimem(immtoimem)
    );
decoder dut1(.new(newdecoder),.reset(reset),.idata(idatasent),.rs1(rs1in),.rs2(rs2in),.rd(idexrdin),.invalid(invalid),
.op(idexopin),.wr(idexwrin),.shamt(idexshamtin),.address(idexaddressin),.rs1mux(rs1muxin),.rs2mux(rs2muxin),
.rdmux(idexrdmuxin),.signcontrol(idexsigncontrolin),.writecontrol(idexwritecontrolin),
.readcontrol(idexreadcontrolin),.pcmux(idexpcmuxin),.jalr(jalr),.luiin(luiin));

adjusted_branch_flag dut27(.inbranch(inbranch),.addressbranch(addressbranch),
.branch_miss(branch_fail),.inbranchactual(inbranchactual),.idexpcout(idexpcout)
    );

pcmuxmux dut19(.inbranch(inbranchactual),.pcmuxdecoder(idexpcmuxin),.pcmuxtoimem(pcmuxtoimem)
    );


wire [31:0] idexrv1out;
wire [31:0] idexaddressout;
wire [1:0] idexpcmuxout;
wire [31:0] idexinp1in;
wire [31:0] idexinp1out;
wire [31:0] idexinp2in;
wire [31:0] idexinp2out;
wire idexnewout;
wire [31:0] idexrv2in;
wire [31:0] idexrv2out;
wire [4:0] idexrdout;
wire [5:0] idexopout;
wire [1:0] idexrdmuxout;
wire [4:0] idexshamtout;
wire idexwrout;
wire idexsigncontrolout;
wire [1:0] idexwritecontrolout;
wire [1:0] idexreadcontrolout;
wire memwbwrout;
wire [4:0] memwbrdout;
wire [31:0] memwbwritedataout,memwbwritedatain;
wire [31:0] rs1muxout,rs2muxout;
registers dut2( .rs1(rs1in),.rs2(rs2in),.rd(memwbrdout),.wr(memwbwrout),.indata(memwbwritedataout),.rv1(idexrv1in),.rv2(idexrv2in),.x31(x31),.new(memwbnewout),
.clk(clk));
rs1mux dut3( .selectorrs1mux(rs1muxin),.rv1(idexrv1in),.imm(idexaddressin),.outrs1mux(rs1muxout),.new(newdecoder)
    );
rs2mux dut4(
   .selectorrs2mux(rs2muxin),.rv2(idexrv2in),.imm(idexaddressin),.outrs2mux(rs2muxout) ,.new(newdecoder));

wire [1:0] inp1muxcontrol,inp2muxcontrol;

inp1mux dut13(.memwbdatain(memwbwritedatain),.exmemoutin(exmemoutin),.rs1muxout(rs1muxout),.idexinp1in(idexinp1in),
.inp1muxcontrol(inp1muxcontrol)
    );

inp2mux dut14(.memwbdatain(memwbwritedatain),.exmemoutin(exmemoutin),.rs2muxout(rs2muxout),.idexinp2in(idexinp2in),
.inp2muxcontrol(inp2muxcontrol)
    );


IDEXREG dut5(.clk(clk),.inp1in(idexinp1in),.inp1out(idexinp1out),.inp2in(idexinp2in),
.inp2out(idexinp2out),.newin(newdecoder),.newout(idexnewout),.rv2in(idexrv2in),.rv2out(idexrv2out),
.rdin(idexrdin),.rdout(idexrdout),.opin(idexopin),.opout(idexopout),.rdmuxin(idexrdmuxin),
.rdmuxout(idexrdmuxout),.shamtin(idexshamtin),.shamtout(idexshamtout),.signcontrolin(idexsigncontrolin),
.signcontrolout(idexsigncontrolout),.readcontrolin(idexreadcontrolin),.readcontrolout(idexreadcontrolout),
.writecontrolin(idexwritecontrolin),.writecontrolout(idexwritecontrolout),.wrin(idexwrin),.wrout(idexwrout),
.pcmuxin(idexpcmuxin),.pcmuxout(idexpcmuxout),.addressin(idexaddressin),.addressout(idexaddressout),
.rv1in(idexrv1in),.rv1out(idexrv1out),.pcin(pc),.pcout(idexpcout),.idexrs1in(rs1in),.idexrs1out(rs1out),
.idexrs2in(rs2in),.idexrs2out(rs2out),.luiin(luiin),.luiout(luiout)
    );
wire [1:0] rv1muxcontrol;
jalrhandler dut21(.jalr(jalr),.idexwritecontrolout(idexwritecontrolout),
.idexrdout(idexrdout),.pcfreeze(pcfreeze),.rs1in(rs1in),.exmemrdout(exmemrdout),.rv1muxcontrol(rv1muxcontrol)
    );	 
rv1mux dut22 (.rv1muxcontrol(rv1muxcontrol),.exmemoutin(exmemoutin),.memwbdatain(memwbwritedatain),
.idexrv1in(idexrv1in),.rv1toimem(rv1toimem)
    );	
	
wire inp11muxcontrol,inp22muxcontrol;
wire [31:0] inp11muxout,inp22muxout;
 
forward_check dut17(.rs1in(rs1in),.rs2in(rs2in),.idexrdout(idexrdout),
.inp1muxcontrol(inp1muxcontrol),.inp2muxcontrol(inp2muxcontrol),.exmemrdout(exmemrdout),.rs1out(rs1out),.rs2out(rs2out),
.inp11muxcontrol(inp11muxcontrol),.inp22muxcontrol(inp22muxcontrol)
);

inp11mux dut15(.inp11muxcontrol(inp11muxcontrol),.memwbdatain(memwbwritedatain),.idexinp1out(idexinp1out),.inp11muxout(inp11muxout)
    );	 
inp22mux dut16(.inp22muxcontrol(inp22muxcontrol),.memwbdatain(memwbwritedatain),.idexinp2out(idexinp2out),.inp22muxout(inp22muxout));
	 
	 
	 
wire read,write;
wire exmemzeroin;
wire exmemzeroout;
wire [31:0] exmemoutout;
wire [31:0] exmempcout;
alu dut6( .inp1(inp11muxout),.inp2(inp22muxout),.shamt(idexshamtout),.op(idexopout),.zero(exmemzeroin),.out(exmemoutin),
.new(idexnewout)
    );
	 
branch dut7(.op(idexopout),.zero(exmemzeroin),.in(inbranch),.new(idexnewout),
.pcmuxin(idexpcmuxout),.pcmuxout(pcmuxbranch),.addressin(idexaddressout),.addressout(addressbranch),
.rv1in(idexrv1out),.rv1out(rv1branch)
    );	
wire [3:0] exmemwein;
wire [3:0] exmemweout;
wire [3:0] exmemrein;
wire [3:0] exmemreout;
wire [31:0] exmemdaddrin;
wire [31:0] exmemdaddrout;
wire [1:0] exmemrdmuxout2;
output wire readerror,writeerror,outofboundaccess;
wire [1:0]memdecoderreadcontrolout,memdecoderwritecontrolout;
memory_miss dut23(.aluout(exmemoutin),.writecontrol(idexwritecontrolout),
.readcontrol(idexreadcontrolout),.readerror(readerror),.writeerror(writeerror),.outofboundaccess(outofboundaccess),
.luiout(luiout)
    );
validity dut24(.clk(clk),.readerror(readerror),
.writeerror(writeerror),.outofboundaccess(outofboundaccess),.invalid(invalid),
.pc(pc),.pcstored(pcstored),.pcpump(pcpump),.override(override),.read(read),.write(write),.pclock(pclock),
.validitymux(validitymux)
    );
wire exmemwrin;
readwritecontrolmux dut25(.read(read),.write(write),.idexreadcontrolout(idexreadcontrolout),
.memdecoderreadcontrolout(memdecoderreadcontrolout),.idexwritecontrolout(idexwritecontrolout),
.memdecoderwritecontrolout(memdecoderwritecontrolout),.wrcheckin(idexwrout),.wrcheckout(exmemwrin),
.outofboundaccess(outofboundaccess)
    );

idatamux1 dut26(.validitymux(validitymux),.idatadecoder(idatadecoder),.idatasent(idatasent)
    );


memdecoder dut8( .aluout(exmemoutin),.writecontrol(memdecoderwritecontrolout),.readcontrol(memdecoderreadcontrolout),
.signcontrol(idexsigncontrolout),.wemen(exmemwein),.re(exmemrein),.daddr(exmemdaddrin),.new(idexnewout)
    );
wire exmemnewout;
wire [31:0] exmemrv2out;
wire exmemsigncontrolout;
wire exmemwrout;

EXMEM dut9(.clk(clk),.newin(idexnewout),.newout(exmemnewout),.rv2in(idexrv2out),.rv2out(exmemrv2out),
.rdin(idexrdout),.rdout(exmemrdout),.rdmuxin(idexrdmuxout),.rdmuxout(exmemrdmuxout2),.aluoutin(exmemoutin),
.aluoutout(exmemoutout),.zeroin(exmemzeroin),.zeroout(exmemzeroout),.daddrin(exmemdaddrin),.daddrout(exmemdaddrout),
.signcontrolin(idexsigncontrolout),.signcontrolout(exmemsigncontrolout),.wein(exmemwein),
.weout(exmemweout),.rein(exmemrein),.reout(exmemreout),.wrin(exmemwrin),.wrout(exmemwrout),.pcin(idexpcout),
.pcout(exmempcout)
    );  
 
dmem dut10(.clk(clk),
    .daddr(exmemdaddrout),
    .dmemin(exmemrv2out),
    .wemen(exmemweout),
	 .re(exmemreout),
    .dmemout(dmemout),
	 .signcontrol(exmemsigncontrolout),.new(exmemnewout)
);
writeregmux dut11( .selectorwrite(exmemrdmuxout2),.aluout(exmemoutout),.dmemout(dmemout),.zero(exmemzeroout),
.writedata(memwbwritedatain),.new(exmemnewout),.pcout(exmempcout)
    );
	 
MEMWB dut12(.clk(clk),.writedatain(memwbwritedatain),.writedataout(memwbwritedataout),
.rdin(exmemrdout),.rdout(memwbrdout),.newin(exmemnewout),.newout(memwbnewout),.wrin(exmemwrout),.wrout(memwbwrout));	 

endmodule
