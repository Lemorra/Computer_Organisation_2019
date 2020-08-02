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

 reg [31:0] PC;
 reg [31:0] PC_next;
 reg [31:0] PC_plus_4;
 reg [31:0] PC_plus_4a;
 reg [31:0] PC_plus_offset;
 wire [31:0] offset, x_offset;
 reg [31:0] PC_rs1;
 reg [31:0] r;
 wire branch, x_branch, m_branch; 
 wire mtr, x_mtr, m_mtr, b_mtr; 
 wire in1c, x_in1c; 
 wire rgw, fm;
 wire in2c, x_in2c; 
 wire ofin, ja; 
 wire rdi, x_rdi, m_rdi, b_rdi; 
 wire pipcon, pccon, ifcon; 
 wire x_ofin, flush; 
 wire i_regw, x_regw, m_regw, b_regw, m_regw;
 wire x_ja;
 wire [1:0] zero, m_zero;
 wire [1:0] memr, memw, x_memr, i_memw, x_memw, m_memr, m_memw; //*
 wire [2:0] aop;
 wire [31:0] imm, x_imm, m_imm, b_imm;
 //wire we;
 wire [31:0] in1, in2, fm_o;
 wire [31:0] data;
 wire [31:0] mtro;
 //reg [31:0] in1, in2;
 wire [31:0] alu1, alu2, off_src, jal_act; //*
 wire [4:0] acon, x_acon;
 wire [31:0] alu_out;
 wire [31:0] drdata_a;
 wire [31:0] dadd;
 wire [3:0] we_psudo;
 wire [31:0] reg31;
 wire [31:0] adjda;
 wire [31:0] m_aluo, b_aluo;

 wire [31:0] o_idata, o_PC, x_pc, x_rv1, x_rv2, m_rv2, o_data;
 
 wire [31:0] m_pc_plus_4, m_pc_plus_offset, m_pc_rs1;
 
 wire [4:0] x_rd, x_rs1, x_rs2, m_rd, b_rd;
 
 wire [1:0] f1_a1con, f1_a2con;
 wire [31:0] b_ddata;
 wire [31:0] t1, t2;

always@( posedge reset or posedge clk) begin
    if(reset)
        PC <= 32'h 00000000;
    else begin
	     if(!pccon) begin
        PC <= PC_next;
		  end
		  
		end
 end

 always@(*) begin
  pc <= PC;


  PC_plus_4 <= PC + 32'd4;

 
  PC_plus_4a <= x_pc + 32'd4;

  PC_plus_offset <= x_pc + x_offset;


  PC_rs1 <= (x_rs1 + x_offset) & 32'b11111111111111111111111111111110;


 if (m_branch == 1) begin
    case(m_zero)
        2'b00:  PC_next <= m_pc_plus_4;
        2'b01:  PC_next <= m_pc_plus_offset;
        2'b10:  PC_next <= m_pc_rs1;
    endcase    
 end else
     PC_next <= PC_plus_4; 


  x31 <= reg31;
  iaddr <= PC ;
  daddr <= dadd;
  we <= we_psudo;
  r <= in1;
  dwdata <= adjda;
 end


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//                     B/w (IF/ID) & (ID/EX)
/////////////////////////////////////////////////////////////////////////////////////////////////////////

 hdu hd1( .clk(clk), .idex_memr(x_memr), .idex_rd(x_rd), .ifid_rs1(o_idata[19:15]), .ifid_rs2(o_idata[24:20]) , .piprcon(pipcon), .pcnoch(pccon), .ifidnoch(ifcon));
 
 ifid i1( .clk(clk), .i_instr(idata), .i_pc(PC), .o_instr(o_idata), .o_pc(o_PC), .flush(flush), .ifcon(ifcon));

 CU c1(.op(o_idata[6:0]), .func3(o_idata[14:12]), .brnc(branch), .mem_r(memr), .mem_t_reg(mtr), .alu_op(aop), .mem_w(memw), .alu_src1(in1c), .reg_w(rgw), .alu_src2(in2c), .offset_src(ofin), .jal_act(ja), .rd_in(rdi));

 alu_con uu2(.fun_7(o_idata[31:25]),.fun_3(o_idata[14:12]), .alu_op(aop), .alu_con(acon));

 RegFile r1( .clk(clk), .rs1(o_idata[19:15]), .rs2(o_idata[24:20]), .rd(b_rd), .we(rgw), .indata(data), .rv1(in1), .rv2(in2), .reg31(reg31));  

 gen gu1 ( .instr(o_idata), .imm(imm), .offset(offset));
 
 splmux spm1(.i_reg_w(rgw), .i_mem_w(memw), .piprcon(pipcon), .o_reg_w(i_regw), .o_mem_w(i_memw));

 //////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//                     B/w (ID/EX) & (EX/MEM)
/////////////////////////////////////////////////////////////////////////////////////////////////////////

idex ide1( .clk(clk), .i_pc(o_PC), .i_rs1(o_idata[19:15]), .i_rs2(o_idata[24:20]), .i_rv1(in1), .i_rv2(in2), .i_rd(o_idata[11:7]), .i_imm(imm), .i_offset(offset), .i_brnc(branch), .i_mem_r(memr), .i_mem_t_reg(mtr), .i_alucon(acon), .i_mem_w(i_memw), .i_alu_src1(in1c), .i_alu_src2(in2c), .i_reg_w(i_regw), .i_offset_src(ofin), .i_jal_act(ja), .i_rd_in(rdi), 
                      .o_pc(x_pc), .o_rs1(x_rs1), .o_rs2(x_rs2), .o_rv1(x_rv1), .o_rv2(x_rv2), .o_rd(x_rd), .o_imm(x_imm), .o_offset(x_offset), .o_brnc(x_branch), .o_mem_r(x_memr), .o_mem_t_reg(x_mtr), .o_alucon(x_acon), .o_mem_w(x_memw), .o_alu_src1(x_in1c), .o_alu_src2(x_in2c), .o_reg_w(x_regw), .o_offset_src(x_ofin), .o_jal_act(x_ja), .o_rd_in(x_rdi), .flush(flush));

mux aluu1(.min1(x_pc), .min2(x_rv1), .mode(x_in1c), .mout(alu1));

forcon f11( .exmem_regw(m_regw), .exmem_rd(m_rd), .idex_rs1(x_rs1), .idex_rs2(x_rs2), .memwb_regw(b_regw), .memwb_rd(b_rd), .a1con(f1_a1con), .a2con(f1_a2con));

mux3 inp1( .min1(alu1), .min2(m_aluo), .min3(mtro), .mode(f1_a1con), .mout(t1));

mux3 inp2( .min1(x_rv2), .min2(m_aluo), .min3(mtro), .mode(f1_a2con), .mout(t2));

mux jalact(.min1(x_imm), .min2(32'd4), .mode(x_ja), .mout(jal_act));

mux offsrc(.min1(jal_act), .min2(offset), .mode(x_ofin), .mout(off_src));

mux aluu2(.min1(t2), .min2(off_src), .mode(in2c), .mout(alu2));

//alu_con uu2(.fun_7(idata[31:25]),.fun_3(idata[14:12]), .alu_op(aop), .alu_con(acon));

ALU aaluu1(.alu_con(x_acon), .in1(t1), .in2(alu2), .out(alu_out), .zero(zero));

/////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//                     B/w (EX/MEM) & (MEM/WB)
/////////////////////////////////////////////////////////////////////////////////////////////////////////

exmem m1( .clk(clk), .i_PC_plus_4(PC_plus_4a), .i_PC_plus_offset(PC_plus_offset), .i_PC_rs1(PC_rs1), .i_zero(zero), .i_aluo(alu_out), .i_rv2(x_rv2), .i_rd(x_rd), .i_imm(x_imm), .i_brnc(x_branch), .i_mem_r(x_memw), 
          .i_mem_t_reg(x_mtr), .i_mem_w(x_memw), .i_reg_w(x_regw), .i_rd_in(x_rdi),
          .o_PC_plus_4(m_pc_plus_4), .o_PC_plus_offset(m_pc_plus_offset), .o_PC_rs1(m_pc_rs1), .o_zero(m_zero), .o_aluo(m_aluo), .o_rv2(m_rv2), .o_rd(m_rd), .o_imm(m_imm), .o_brnc(m_branch), .o_mem_r(m_memr), .o_mem_t_reg(m_mtr), .o_mem_w(m_memw), .o_reg_w(m_regw), .o_rd_in(m_rdi), .flush(flush));

adjter ad1(.rs2(fm_o), .memw(m_memw), .aluo(m_aluo[1:0]), .wdata(adjda));

demem duut( .adata(m_aluo), .odata(drdata), .mem_w(m_memw), .mem_r(m_memr), .we(we_psudo), .out(drdata_a), .addr(dadd));

forconm frm1( .exmem_regw(m_regw), .exmem_rd(m_rd), .idex_rs2(x_rs2), .memwb_regw(b_regw), .memwb_rd(b_rd), .wrdatacon(fm));

mux fm1 ( .min1(m_rv2), .min2(mtro), .mode(fm), .mout(fm_o));

flush flu ( .branch(m_branch), .zero(m_zero), .out(flush));

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//                     After (MEM/WB)
/////////////////////////////////////////////////////////////////////////////////////////////////////////

memwb mem1( .clk(clk), .i_ddata(drdata_a), .i_aluo(m_aluo), .i_rd(m_rd), .i_imm(m_imm), .i_mem_t_reg(m_mtr), .i_reg_w(m_regw), .i_rd_in(m_rdi),
            .o_ddata(b_ddata), .o_aluo(b_aluo), .o_rd(b_rd), .o_imm(b_imm), .o_mem_t_reg(b_mtr), .o_reg_w(b_regw), .o_rd_in(b_rdi));

mux memtreg(.min1(b_aluo), .min2(b_ddata), .mode(b_mtr), .mout(mtro));

mux rdin( .min1(mtro), .min2(b_imm), .mode(b_rdi), .mout(data));

/////////////////////////////////////////////////////////////////////////////////////////////////////////

endmodule
