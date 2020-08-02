//`include "alu.v"
//`include "dec_dmem.v"
//`include "con_unit.v"
//`include "alu_con.v"
//`include "regfile.v"
//`include "imem.v"
//`include "dmem.v"
//`include "mux.v"


module CPU(
    input clk,
    input reset,
    output reg[31:0] iaddr,  // address to instruction memory
    input [31:0] idata,   // data from instruction memory
    output reg[31:0] daddr,  // address to data memory
    input [31:0] drdata,  // data read from data memory
    output reg[31:0] dwdata, // data to be written to data memory
    output reg[3:0] we,      // write enable signal for each byte of 32-b word
    // Additional outputs for debugging
    output reg[31:0] x31,
    output reg[31:0] pc
);

 //Program counter
//always@(*) begin
 //reg [31:0] pc;
 reg [31:0] PC;
 reg [31:0] PC_next;
 reg [31:0] PC_plus_4;
 reg [31:0] PC_plus_offset;
 wire [31:0] offset;
 reg [31:0] PC_rs1;
 reg [31:0] r;
 wire branch, mtr, in1c, rgw, in2c, ofin, ja, rdi;
 wire [1:0] zero;
 wire [1:0] memr, memw; //*
 wire [2:0] aop;
 wire [31:0] imm;
 //wire we;
 wire [31:0] in1, in2;
 wire [31:0] data;
 wire [31:0] mtro;
 //reg [31:0] in1, in2;
 wire [31:0] alu1, alu2, off_src, jal_act; //*
 wire [4:0] acon;
 wire [31:0] alu_out;
 wire [32:0] drdata_a;
 wire [31:0] dadd;
 wire [3:0] we_psudo;
 wire [31:0] reg31;
 wire [31:0] adjda;
 //assign instr = idata;

 always@( posedge reset or posedge clk) begin
    if(reset)
        PC <= 32'h 00000000;
    else
        PC <= PC_next;
 end

 always@(*) begin
  pc <= PC;

// reg [31:0] PC_plus_4;
  PC_plus_4 <= PC + 32'd4;

 
 //reg [31:0] PC_plus_offset;
 //reg [31:0] offset;

  PC_plus_offset <= PC + offset;

 //reg [31:0] PC_rs1;
 //reg [31:0] r;
  PC_rs1 <= (in1 + offset) & 32'b11111111111111111111111111111110;
 //assign r = in1 + offset;
 //reg branch, memr, mtr, memw, in1c, rgw, in2c, ofin, ja, rdi, zero;
 //reg [2:0] aop;

 if (branch == 1) begin
    case(zero)
        2'b00:  PC_next <= PC_plus_4;
        2'b01:  PC_next <= PC_plus_offset;
        2'b10:  PC_next <= PC_rs1;
    endcase    
 end else
     PC_next <= PC_plus_4; 

  //instr = idata;
  x31 <= reg31;
  iaddr <= PC ;
  daddr <= dadd;
  we <= we_psudo;
  r <= in1;
  dwdata <= adjda;
 end
///////////////////////////////////////
//reg [31:0] instr;  

//imem im (.iaddr(PC), .idata(instr));

////////////////////////////////////////

//reg [31:0] imm, offset;

//gen gu1 ( .instr(idata), .imm(imm), .offset(offset));

////////////////////////////////////////////
//wire we;
//reg [31:0] in1, in2;

//wire [6:0]op = idata[6:0];

CU u1(.op(idata[6:0]), .func3(idata[14:12]), .brnc(branch), .mem_r(memr), .mem_t_reg(mtr), .alu_op(aop), .mem_w(memw), .alu_src1(in1c), .reg_w(rgw), .alu_src2(in2c), .offset_src(ofin), .jal_act(ja), .rd_in(rdi));
alu_con uu2(.fun_7(idata[31:25]),.fun_3(idata[14:12]), .alu_op(aop), .alu_con(acon));

gen gu1 ( .instr(idata), .imm(imm), .offset(offset));
///////////////////////////////////////////


//reg [31:0] data, mtro;

mux rdin( .min1(mtro), .min2(imm), .mode(rdi), .mout(data)); //incomplete connections a,b;

//////////////////////////////////////////////////////////


//reg [31:0] in1, in2;

RegFile r1( .clk(clk), .rs1(idata[19:15]), .rs2(idata[24:20]), .rd(idata[11:7]), .we(rgw), .indata(data), .rv1(in1), .rv2(in2), .reg31(reg31));

//r1( .clk(clk), .rs1(32'd31), .rs2(32'd0), .rd(32'd0), .we(32'd0), .indata(32'd0), .rv1(reg31), .rv2(reg0) );

//assign r = in1;
//assign dwdata = in2;

////////////////////////////////////////////////////////////////
adjter ad1(.rs2(in2), .memw(memw), .aluo(alu_out[1:0]), .wdata(adjda));

//reg [31:0] alu1, alu2, off_src, jal_act;

mux aluu1(.min1(PC), .min2(in1), .mode(in1c), .mout(alu1));

////////////////////////////////////////////////////////////////////

mux aluu2(.min1(in2), .min2(off_src), .mode(in2c), .mout(alu2));

///////////////////////////////////////////////////////////////////////

mux offsrc(.min1(jal_act), .min2(offset), .mode(ofin), .mout(off_src));

//////////////////////////////////////////////////////////////////////

mux jalact(.min1(imm), .min2(32'd4), .mode(ja), .mout(jal_act));

///////////////////////////////////////////////////////////////////////

ALU aaluu1(.alu_con(acon), .in1(alu1), .in2(alu2), .out(alu_out), .zero(zero));

////////////////////////////////////////////////////////////////////////
//reg [31:0] dememo, daddr;
//reg [3:0] we;

demem duut( .adata(alu_out), .odata(drdata), .mem_w(memw), .mem_r(memr), .we(we_psudo), .out(drdata_a), .addr(dadd));

//////////////////////////////////////////////////////////////////////////////////

//dmem dmuut(.clk(clk), .daddr(daddr), .dwdata(in2), .we(we), .drdata(odata));

/////////////////////////////////////////////////////////////////////////////////

//reg [31:0] mtro

mux memtreg(.min1(alu_out), .min2(drdata_a), .mode(mtr), .mout(mtro));

//////////////////////////////////////////////////////////////////////////////


endmodule