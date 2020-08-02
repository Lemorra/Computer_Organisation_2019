`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:08 10/07/2019 
// Design Name: 
// Module Name:    decoder 
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
module decoder(reset,idata,rs1,new,jalr,
    rs2,
    rd,
    op,
    address,
	 rs2mux,
	 rs1mux,
	 rdmux,
	 shamt,
	 wr,
	 signcontrol,
	 writecontrol,
	 readcontrol,pcmux,invalid,luiin
    );
output reg luiin;
input wire reset;
input wire new;
input wire [31:0] idata; 
output reg [4:0] rs1;
 output reg [4:0] rs2;
 output reg [4:0] rd;
 output reg [5:0] op;
 output reg wr;
 output reg [4:0] shamt;
 output reg [31:0] address;
output reg rs2mux,rs1mux;
output reg [1:0] rdmux; //write mux control signal

output reg signcontrol;    //unsigned operation handler--logic high for unsigned enable
output reg [1:0] writecontrol;  //dmem write logic
output reg [1:0] readcontrol;   //dmem read logic
output reg [1:0] pcmux;
output reg jalr,invalid;
initial begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 luiin<=0;
	 op<=0;
	 wr<=0;
	 shamt<=0;
	 address<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 jalr<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=0;
	 end
	 always@(reset or idata or new)begin
	 if (reset)begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 op<=0;       //do nothing alu
	 wr<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 address<=0;
	 shamt<=0;
	 jalr<=0;
	 luiin<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else begin
	 if (idata[6:0]==103)begin//jalr
    rs1<=idata[19:15];
    rs2<=0;
	 rd<=idata[11:7];
	 rs2mux<=0;
    rs1mux<=0 ;
	 luiin<=0;
    rdmux<=3;	 //imm over rv2 into alu as 2nd input
	 op<=0; //add alu
	 wr<=1;
	 readcontrol<=3;
	 jalr<=1;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=0;
	 address<=({{20{idata[31]}},idata[31:20]});//imem not byte addressable, hence no byte offset
	 invalid<=0;
	 end
	 else if (idata[6:0]==55)begin
	 rs1<=0;
	 rs2<=0;
	 rd<=idata[11:7]; //link to combinational reg file
	 address<=$unsigned(idata[31:12]); //bypass control to mux later
	 rs2mux<=0;
    rs1mux<=1 ;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 op<=14; //add alu
	 wr<=1;
	 luiin<=1;
	 jalr<=0;
	 readcontrol<=0;
	 writecontrol<=0;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 
	 else if (idata[6:0]==99)begin
	 if (idata[14:12]==0)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=0; //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31],idata[7],idata[30:25],idata[11:8]})<<1; //bypass control to mux later
	 rs2mux<=0;
    rs1mux<=0;
	 jalr<=0;
	 luiin<=0;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 op<=15; //add alu
	 wr<=0;
	 readcontrol<=0;
	 writecontrol<=0;
	 signcontrol<=0;
	 pcmux<=2;
	 invalid<=0;
	 end
	 else if (idata[14:12]==1)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=0; //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31],idata[7],idata[30:25],idata[11:8]})<<1; //bypass control to mux later
	 rs2mux<=0;
    rs1mux<=0;
	 jalr<=0;
	 luiin<=0;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 op<=16; //add alu
	 wr<=0;
	 readcontrol<=0;
	 writecontrol<=0;
	 signcontrol<=0;
	 pcmux<=2;
	 invalid<=0;
	 end
	  else if (idata[14:12]==5)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=0; //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31],idata[7],idata[30:25],idata[11:8]})<<1; //bypass control to mux later
	 rs2mux<=0;
    rs1mux<=0;
	 luiin<=0;
	 jalr<=0;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 op<=18;																																							 //add alu
	 wr<=0;
	 readcontrol<=0;
	 writecontrol<=0;
	 signcontrol<=0;
	 pcmux<=2;
	 invalid<=0;
	 end
	 
	 
	 else if (idata[14:12]==4)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=0; //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31],idata[7],idata[30:25],idata[11:8]})<<1; //bypass control to mux later
	 rs2mux<=0;
	 luiin<=0;
    rs1mux<=0;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 op<=17;																																							 //add alu
	 wr<=0;
	 jalr<=0;
	 readcontrol<=0;
	 writecontrol<=0;
	 signcontrol<=0;
	 pcmux<=2;
	 invalid<=0;
	 end
	 
	 else if (idata[14:12]==6)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=0; //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31],idata[7],idata[30:25],idata[11:8]})<<1; //bypass control to mux later
	 rs2mux<=0;
    rs1mux<=0;
	 luiin<=0;
	 jalr<=0;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 op<=19;																																							 //add alu
	 wr<=0;
	 readcontrol<=0;
	 writecontrol<=0;
	 signcontrol<=0;
	 pcmux<=2;
	 invalid<=0;
	 end
	 
	 else if (idata[14:12]==7)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=0; //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31],idata[7],idata[30:25],idata[11:8]})<<1; //bypass control to mux later
	 rs2mux<=0;
	 luiin<=0;
	 jalr<=0;
    rs1mux<=0;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 op<=20;																																							 //add alu
	 wr<=0;
	 readcontrol<=0;
	 writecontrol<=0;
	 signcontrol<=0;
	 pcmux<=2;
	 invalid<=0;
	 end
	 
	 else begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 op<=0;       //do nothing alu
	 wr<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 address<=0;
	 shamt<=0;
	 jalr<=0;
	 luiin<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=1;
	 end
	 
	 end
	 else if (idata[6:0]==111)begin //jal
	 rs1<=0;
    rs2<=0;
	 luiin<=0;
	 rd<=idata[11:7];
	 rs2mux<=0;
    rs1mux<=0;
    rdmux<=3;	 //imm over rv2 into alu as 2nd input
	 op<=0; //add alu
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=1;
	 address<={{12{idata[31]}},idata[31],idata[19:12],idata[20],idata[30:21],1'b0};//imem not byte addressable, hence no byte offset
	 invalid<=0;
	 end
    else if (idata[6:0]==3)begin
	 if (idata[14:12]==0)begin
	 rs1<=idata[19:15];
	 rs2<=0;
	 luiin<=0;
	 rd<=idata[11:7]; //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later
	 rs2mux<=1;
	 jalr<=0;
    rs1mux<=0 ;
    rdmux<=1;	 //imm over rv2 into alu as 2nd input
	 op<=1; //add alu
	 wr<=1;
	 readcontrol<=0;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==1)begin
	 rs1<=idata[19:15];
	 rs2<=0;
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later
	 op<=1; //add alu
	 wr<=1;
	 luiin<=0;
	 jalr<=0;
	 rs2mux<=1;
    rs1mux<=0 ;
	 rdmux<=1;
	 //imm over rv2 into alu as 2nd input
	 readcontrol<=1;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==2)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=1; //add alu
	 wr<=1;
	 jalr<=0;
	 luiin<=0;
	 readcontrol<=2;
	 writecontrol<=3;
	 rs2mux<=1;
    rs1mux<=0 ;
    rdmux<=1;	 //imm over rv2 into alu as 2nd input
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==4)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rd<=idata[11:7];  //link to combinational reg file
	 address<={{20{idata[31]}},idata[31:20]}; //bypass control to mux later, b4 alu
	 op<=1; //add alu
	 wr<=1;
	 luiin<=0;
	 readcontrol<=0;
	 writecontrol<=3;
	 rs2mux<=1;
    rs1mux<=0 ;
	 jalr<=0;
    rdmux<=1;	 //imm over rv2 into alu as 2nd input
	 signcontrol<=1;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==5)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=1; //add alu
	 wr<=1;
	 luiin<=0;
	 rs2mux<=1;
    rs1mux<=0 ;
	 jalr<=0;
	 rdmux<=1;//imm over rv2 into alu as 2nd input
	 readcontrol<=1;
	 writecontrol<=3;
	 signcontrol<=1;
	 pcmux<=3;
	 invalid<=0;
	 end
	 	 else begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 op<=0;       //do nothing alu
	 wr<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 address<=0;
	 shamt<=0;
	 luiin<=0;
	 jalr<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=1;
	 end
	 end
	 else if (idata[6:0]==35)begin
	 if (idata[14:12]==0)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=idata[24:20];
	 rd<=0;  //link to combinational reg file
	 address<={{20{idata[31]}},idata[31:25],idata[11:7]}; //bypass control to mux later, b4 alu
	 op<=1; //add alu
	 wr<=0;
	 luiin<=0;
	 rs2mux<=1;
   	 //rv2 into alu as 2nd input
	 rs1mux<=0;//rs1 into alu as first input
	 readcontrol<=3;
	 writecontrol<=0;
	 jalr<=0;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==1)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=idata[24:20];
	 rd<=0;  //link to combinational reg file
	 address<={{20{idata[31]}},idata[31:25],idata[11:7]}; //bypass control to mux later, b4 alu
	 op<=1; //add alu
	 wr<=0;
	 luiin<=0;
	 rs2mux<=1; 
	 rs1mux<=0 ;//imm over rv2 into alu as 2nd input
	 readcontrol<=3;
	 writecontrol<=1;
	 jalr<=0;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==2)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=idata[24:20];
	 rd<=0;  //link to combinational reg file
	 address<={{20{idata[31]}},idata[31:25],idata[11:7]}; //bypass control to mux later, b4 alu
	 op<=1; //add alu
	 wr<=0;
	 luiin<=0;
	 rs2mux<=1; //imm over rv2 into alu as 2nd input
	 rs1mux<=0 ;
	 readcontrol<=3;
	 writecontrol<=2;
	 jalr<=0;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 	 else begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 op<=0;       //do nothing alu
	 wr<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 luiin<=0;
	 address<=0;
	 shamt<=0;
	 jalr<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=1;
	 end
	 end
	 else if (idata[6:0]==19)begin
	 if (idata[14:12]==0)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=1; //add alu
	 wr<=1;
	 luiin<=0;
	 jalr<=0;
	 rs2mux<=1;
    rs1mux<=0;
    rdmux<=0;	 //imm over rv2 into alu as 2nd input
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0; //refers to dmem write sign extension, not alu's sign ext.
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==2)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 jalr<=0;
	 luiin<=0;
	 rs2mux<=1; 
	 rs1mux<=0 ;
	 rdmux<=2;//imm over rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=2; //if inp1<imm, set rd to 1,else 0.. further alu combinational logic follows later
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==3)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rs2mux<=1;
	 luiin<=0;
	 jalr<=0;
    rs1mux<=0 ;
    rdmux<=2;	 //imm over rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=3; //if unsigned(inp1)<unsigned(imm), set rd to 1,else 0.. further alu combinational logic follows later
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==4)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rs2mux<=1; 
	 jalr<=0;
	 luiin<=0;
	 rs1mux<=0 ;
	 rdmux<=0;//imm over rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=4; //xor
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==6)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rs2mux<=1; 
	 rs1mux<=0 ;
	 luiin<=0;
	 rdmux<=0;//imm over rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=5; //or
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==7)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rs2mux<=1; 
	 rs1mux<=0 ;
	 rdmux<=0;//imm over rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 address<=({{20{idata[31]}},idata[31:20]}); //bypass control to mux later, b4 alu
	 op<=6; //and		
	 wr<=1;
	 luiin<=0;
	 jalr<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==1)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 rdmux<=0;
	 luiin<=0;
	 //rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 op<=7; //logical left shift inp1 by shamt
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 shamt<=idata[24:20];
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==5)begin
	 if (idata[30]==0)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 rs2mux<=0; 
	 luiin<=0;
	 rs1mux<=0 ;
	 rdmux<=0;//rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 op<=8; //logical right shift inp1 by shamt
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 shamt<=idata[24:20];
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[30]==1)begin
	 rs1<=idata[19:15];  //sign extension enabled by default???????????????????????????????????(guess:yes)extensionhandlerneeded	
	 rs2<=0;
	 luiin<=0;
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 rdmux<=0;//rv2 into alu as 2nd input
	 rd<=idata[11:7];  //link to combinational reg file
	 op<=9; //arithmatic right shift inp1 by shamt
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 shamt<=idata[24:20];
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 end
	 	 else begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 op<=0;       //do nothing alu
	 wr<=0;
	 rs2mux<=0;
	 luiin<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 address<=0;
	 shamt<=0;
	 jalr<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=1;
	 end
	 end
	 else if (idata[6:0]==51)begin
	 if (idata[14:12]==0)begin
	 if (idata[30]==0)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 luiin<=0;
	 rs1mux<=0 ;//rv2 into alu as 2nd input
	 op<=1; //add alu
	 wr<=1;
	 jalr<=0;
	 rdmux<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[30]==1)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 luiin<=0;
	 rdmux<=0;//rv2 into alu as 2nd input
	 op<=10; //sub alu
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 end
	 else if (idata[14:12]==1)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 luiin<=0;
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 rdmux<=0;//rv2 into alu as 2nd input
	 op<=11; //shift left by rv2
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==2)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 luiin<=0;
	 jalr<=0;
	 rs1mux<=0 ;
	 rdmux<=2;//rv2 into alu as 2nd input
	 op<=2; //if inp1<inp2, set rd to 1,else 0.. further alu combinational logic follows later
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==3)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 luiin<=0;
	 jalr<=0;
	 rdmux<=2;//rv2 into alu as 2nd input
	 op<=3; //if unsigned(inp1)<unsigned(inp2), set rd to 1,else 0.. further alu combinational logic follows later
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==4)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 jalr<=0;
	 luiin<=0;
	 rs1mux<=0 ;
	 rdmux<=0;//rv2 into alu as 2nd input
	 op<=4; //xor
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==5)begin
	 if (idata[30]==0)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 luiin<=0;
	 rs1mux<=0 ;
	 rdmux<=0;//rv2 into alu as 2nd input
	 op<=12; //right shift by rv2
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[30]==1) begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 luiin<=0;
	 rdmux<=0;//rv2 into alu as 2nd input
	 op<=13; //arithmetic right shift by rv2
	 wr<=1;
	 jalr<=0;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 end
	 else if (idata[14:12]==6)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 jalr<=0;
	 luiin<=0;
	 rdmux<=0;//rv2 into alu as 2nd input
	 op<=5; //or
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else if (idata[14:12]==7)begin
	 rs1<=idata[19:15];
	 rs2<=idata[24:20];
	 rd<=idata[11:7]; //link to combinational reg file
	 rs2mux<=0; 
	 rs1mux<=0 ;
	 jalr<=0;
	 luiin<=0;
	 rdmux<=0;//rv2 into alu as 2nd input
	 op<=6; //and
	 wr<=1;
	 readcontrol<=3;
	 writecontrol<=3;
	 signcontrol<=0;
	 pcmux<=3;
	 invalid<=0;
	 end
	 	 else begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 op<=0;       //do nothing alu
	 wr<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 luiin<=0;
	 rdmux<=0;
	 address<=0;
	 shamt<=0;
	 jalr<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=1;
	 end
	 end
	 else if (idata==0) begin
	  rs1<=0;
	 rs2<=0;
	 rd<=0;
	 luiin<=0;
	 op<=0;
	 wr<=0;
	 shamt<=0;
	 jalr<=0;
	 address<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=0;
	 end
	 else begin
	 rs1<=0;
	 rs2<=0;
	 rd<=0;
	 op<=0;
	 wr<=0;
	 shamt<=0;
	 luiin<=0;
	 jalr<=0;
	 address<=0;
	 rs2mux<=0;
	 rs1mux<=0;
	 rdmux<=0;
	 signcontrol<=0;
	 writecontrol<=3;
	 readcontrol<=3;
	 pcmux<=3;
	 invalid<=1;
	 end
	 end
	 
	 end
	 
	 
	  
	 
	 
	 
	 

endmodule
