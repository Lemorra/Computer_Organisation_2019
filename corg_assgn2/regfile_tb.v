`timescale 1ns/1ns
`include "mem_parameters.v"     //clk, rs1, rs2, rd, we, indata, rv1, rv2

module tb ();

    // Inputs
    reg clk;
    reg [`rwidth-1:0] rs1,rs2,rd;
    reg we;
    reg [`width-1:0] indata;
    
    

    // Outputs
    wire [`width-1:0] rv1, rv2;
    
    integer i;

    // Instantiate the Unit Under Test (UUT)
    RegFile uut (
        .clk(clk),
        .rs1(rs1),		  
        .rs2(rs2), 
        .rd(rd),
        .we(we),
        .indata(indata),
        .rv1(rv1), 
        .rv2(rv2) 
        
    );
    
    always
        #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 1;
        we = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;  
        #20;
        //Write all the locations of RAM
          
        we = 1;
      for(i=1; i <= 31; i = i + 1) begin
            indata = i;
            rd = i-1;
            #10;
        end
        we = 0; 
        //Read from port 1, all the locations of RAM.
        for(i=1; i <= 30; i = i + 1) begin
            rs1 = i-1;
            rs2 = i;
            #10;
        end
    end
      
endmodule