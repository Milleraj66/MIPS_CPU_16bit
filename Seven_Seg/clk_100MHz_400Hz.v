`timescale 1ns / 1ps

/*
    Author: Arthur Miller
    Due Date: 03-12-15
    ECE 205L Final
    Purpose: 400 Hz Clock Module: This module will divide the input 100 Mhz clock down to 400Hz used for display purpose.

*/

//REV1: 03-06-15


// BLOCK 1
module clk_100Mhz_400Hz(clk_100Mhz, clk_400Hz);  
    input clk_100Mhz;
    output reg clk_400Hz;
    reg [26:0] counter;    

    always @ (posedge clk_100Mhz)     
        
        begin
        counter = counter +1;  
        
        // Increment counter  
        if (counter == 125_000) 
        // check if it reaches 50,000,000      
            begin   
            clk_400Hz=~clk_400Hz;  // if so, then flip the logic state of the    
            counter = 0;   // output and reset the counte      
            end       
        end
endmodule
