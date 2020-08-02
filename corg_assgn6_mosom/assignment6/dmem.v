`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:43:25 10/08/2019 
// Design Name: 
// Module Name:    dmem 
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
module dmem(clk,
    daddr,
    dmemin,
    wemen,
	 re,
    dmemout,
	 signcontrol,new
);
 
    input wire new,clk;
	 input wire [31:0] daddr,dmemin;
	 input wire [3:0] wemen,re;
	 output reg [31:0] dmemout;
	 input wire signcontrol;
    reg [7:0] m0[0:31];
	 reg [7:0] m1[0:31];
	 reg [7:0] m2[0:31];
	 reg [7:0] m3[0:31];
	 
	 integer i;
	 initial begin
	
   m0[0]<=8'h00;
	m1[0]<=8'h11;
	m2[0]<=8'h22;
	m3[0]<=8'h33;
	
	m0[1]<=8'h44;
	m1[1]<=8'h55;
	m2[1]<=8'h66;
	m3[1]<=8'h77;
	
	m0[2]<=8'h88;
	m1[2]<=8'h99;
	m2[2]<=8'haa;
	m3[2]<=8'hbb;
	
	m0[3]<=8'hcc;
	m1[3]<=8'hdd;
	m2[3]<=8'hee;
	m3[3]<=8'hff;
	
	for (i=4;i<32;i=i+1)begin
	m0[i]<=0;
	m1[i]<=0;
	m2[i]<=0;
	m3[i]<=0;
	
	end
	
	end

    always@(daddr or re or signcontrol or new) begin
	 if (re==15)
	 dmemout<={m3[daddr],m2[daddr],m1[daddr],m0[daddr]};
	 else if (re==3 && signcontrol==1)//signcontrol1 unsigned extension
	 dmemout<={16'b0,m1[daddr],m0[daddr]};
	 else if (re==3 && signcontrol==0)//signcontrol0 signed extension
	 dmemout<=$signed({m1[daddr],m0[daddr]});
	 else if (re==12 && signcontrol==0)
	 dmemout<=$signed({m3[daddr],m2[daddr]});
	 else if (re==12 && signcontrol==1)
	 dmemout<={16'b0,m3[daddr],m2[daddr]};
	 else if (re==1 && signcontrol==1)
	 dmemout<={24'b0,m0[daddr]};
	 else if (re==1 && signcontrol==0)
	 dmemout<=$signed(m0[daddr][7:0]);
	 else if (re==2 && signcontrol==1)
	 dmemout<={24'b0,m1[daddr]};
    else if (re==2 && signcontrol==0)
	 dmemout<=$signed(m1[daddr][7:0]); 
	 else if (re==4 && signcontrol==1)
	 dmemout<={24'b0,m2[daddr]};
	 else if (re==4 && signcontrol==0)
	 dmemout<=$signed(m2[daddr][7:0]);
	 else if (re==8 && signcontrol==1)
	 dmemout<={24'b0,m3[daddr]};
	 else if (re==8 && signcontrol==0)
	 dmemout<=$signed(m3[daddr][7:0]);
	 else 
	 dmemout<=0;
	 end
    
		
    always@(posedge clk) begin
	 
		  
        /*if (wemen[2]==1)begin
		  m2[daddr]<=dmemin[23:16];
		  end

		 
		  
		  
		  if (wemen[3]==1)
		  m3[daddr]<=dmemin[31:24];
		  if (wemen[1]==1)
		  m1[daddr]<=dmemin[15:8];
		  if (wemen[0]==1)
		  m0[daddr]<=dmemin[7:0];*/
		  if (wemen==15)
		  {m3[daddr],m2[daddr],m1[daddr],m0[daddr]}<=dmemin;
		  if (wemen==12)
		  {m3[daddr],m2[daddr]}<=dmemin[15:0];
		  if (wemen==3)
		  {m1[daddr],m0[daddr]}<=dmemin[15:0];
		  if (wemen==8)
		  m3[daddr]<=dmemin[7:0];
		  if (wemen==4)
		  m2[daddr]<=dmemin[7:0];
		  if (wemen==2)
		  m1[daddr]<=dmemin[7:0];
		  if (wemen==1)
		  m0[daddr]<=dmemin[7:0];
		  
		
    end

	
endmodule
