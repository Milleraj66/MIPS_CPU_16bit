`timescale 1ns / 1ps
/*
Author: Arthur Miller
Due Date: 03-12-15
ECE 205L Final
purpose:
A 2-bit counter. The input clock comes from a 400Hz clock generator source. The 2
outputs are fed into the 4-to-1 Mux block as the select control inputs.
*/

module Three_Bit_Counter(clk,Q);
    input clk;
    output reg [2:0] Q;
    // counter from 0 to 9 
    // Posativ edge clock tick
    always @(posedge clk)
    begin
            Q = Q + 1;      
    end
endmodule
