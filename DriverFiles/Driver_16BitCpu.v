`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: Driver_16BitCpu
// Create Date: 11/30/2015 11:33:01 PM
// Edit Date: Arthur Miller & Bibek B. 12/01/2015
// EDIT: Arthur Miller: 12/1/2015
// ECE425L LAB #4 Problem 1
// Purpose: Driver module for 16 bit Cpu datapath
////////////////////////////////////////////////////////////////////////////////////
module Driver_16BitCpu(Clk_100MHz,Reset,Restart,an,seg7,seg6,seg5,seg4,seg3,seg2,seg1,seg0);
    // **** Inputs
    input Clk_100MHz;                   // Nexy's 4 100Mhz Clock
    input Reset;                        // Register File Reset Switch
    input Restart;                      // Program Reset button
    // **** DataPathOutput Wires
    wire [3:0] PC_4bit;          // First four bits of PC                  
    wire [3:0] Ins_4bit;         // Last four bits of Instruction (the opcode)               
    wire [3:0] ALU_Out_4bit;     // First four bits of ALU_Out   
    wire [3:0] Mem_Out_4bit;     // First four bits of Memory Output
    // **** bcd Outputs Wires
    wire [3:0] bcd1_PC;
    wire [3:0] bcd0_PC;
    wire [3:0] bcd1_Ins;
    wire [3:0] bcd0_Ins;
    wire [3:0] bcd1_ALU;
    wire [3:0] bcd0_ALU;
    wire [3:0] bcd1_Mem;
    wire [3:0] bcd0_Mem;  
    // **** sevenseg Output Wires
    wire [6:0] seg0;
    wire [6:0] seg1; 
    wire [6:0] seg2; 
    wire [6:0] seg3; 
    wire [6:0] seg4; 
    wire [6:0] seg5; 
    wire [6:0] seg6;
    wire [6:0] seg7;          
    // **** Outputs
    output  [7:0]an;                // turn on all 7 seg anodes
    assign an[7:0] = 8'b0000_0000;
    output  [6:0] seg;          // Segments  

    // **** Intermediate Wires
    wire Clk_2Hz;                       // Slowed down clock 
    wire clk_400Hz;                     // Slowed down clock 
    wire [2:0] CnterOut;                 // 3 bit counter output                  
    
    
    //*** 1. Slow clock from 100Mhz cycle to 2Hz cycle
    Slower_Clock                        SLOW_CLOCK          (Clk_100MHz,Clk_2Hz);
    
    //*** 2. Instantiate Datapath
    // (Clock[1b],RegisterReset,InstructionRestart,PC[3:0],Ins[15:12],ControlSig[11b],A[16b],B[3:0],ALU_Out[3:0],RegFileInAddr[4b],DataMemOut[3:0])
    DataPath16BitCpu_Clean              UUT                 (Clk_2Hz,Reset,Restart,PC_4bit,Ins_4bit,,,,ALU_Out_4bit,,Mem_Out_4bit);   
    
    //*** 3. Convert DataPathOutputs to be displayed on Seven Segment Display
    // Convert DataPathOutputs from binary to BCD
    bcd(PC_4bit,, bcd1_PC, bcd0_PC);
    bcd(Ins_4bit,,bcd1_Ins,bcd0_Ins);
    bcd(ALU_Out_4bit,,bcd1_ALU,bcd0_ALU);
    bcd(Mem_Out_4bit,,bcd1_Mem,bcd0_Mem);
    // BCD to SevenSeg Decoder
    sevenseg(bcd0_PC,   seg0);
    sevenseg(bcd1_PC,   seg1);
    sevenseg(bcd0_Ins,  seg2);
    sevenseg(bcd1_Ins,  seg3);
    sevenseg(bcd0_ALU,  seg4);
    sevenseg(bcd1_ALU,  seg5);
    sevenseg(bcd0_Mem,  seg6);
    sevenseg(bcd1_Mem,  seg7);
    //*** 4. Mux 7seg's to display 8 outputs
    // Slow clock to 400Hz for muxing 7seg
    clk_100Mhz_400Hz(.clk_100Mhz(Clk_100MHz), .clk_400Hz(clk_400Hz));
    // three bit counter to syn mux and decoder
    Three_Bit_Counter(.clk(clk_400Hz),.Q(CnterOut));
    // Enable anodes decoder
    Decoder_3to8(.E(1'b1),.X(CnterOut),.Z(an));
    // Select seg output to display 
    Mux7bit_8to1(.E(1'b1),.S(CnterOut),.X0(seg0),.X1(seg1),.X2(seg2),.X3(seg3),.X4(seg4),.X5(seg5),.X6(seg6),.X7(seg7), .Z(seg));
endmodule
