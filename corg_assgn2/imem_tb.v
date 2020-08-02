`timescale 1ns/1ns
`include "mem_parameters.v"

module tb ();

    // Inputs
    reg clk;
    reg wr_en;
    reg [`width-1:0] data_in;
    reg [`width-1:0] addr_in_0;
    
    
    

    // Outputs
    wire [`width-1:0] data_out_0;
    
    integer i;

    // Instantiate the Unit Under Test (UUT)
    IMEM uut (
        .clk(clk),
        .i_addr(addr_in_0),		  
        .wre(wr_en), 
        .wr_data(data_in), 
        .i_data(data_out_0) 
        
    );
    
    always
        #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 1;
        wr_en = 0;
        data_in = 0;
        addr_in_0 = 0;  
        #20;
        //Write all the locations of RAM
          
        wr_en = 1;
      for(i=1; i <= 49; i = i + 1) begin
            data_in = i;
            addr_in_0 = i-1;
            #10;
        end
        wr_en = 0; 
        //Read from port 1, all the locations of RAM.
        for(i=1; i <= 49; i = i + 1) begin
            addr_in_0 = i-1;
            #10;
        end
    end
      
endmodule