`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author : http://www.delorie.com/electronics/bin2seven/sevenseg.v
// Create Date: 01/29/2016 02:00:50 PM
// Module Name: sevenseg

//////////////////////////////////////////////////////////////////////////////////


// Copyright (C) 2008 DJ Delorie <dj@delorie.com>
// Distributed under the terms of the GNU General Public License,
// either verion 2 or (at your choice) any later version.

module sevenseg(ibcd, oseg);
    input [3:0] ibcd;
    output [6:0] oseg;

    reg [6:0] oseg;

always @ (ibcd)
begin
  case (ibcd)  // abcdefg
    0 : oseg = 7'b1111110;
    1 : oseg = 7'b0110000;
    2 : oseg = 7'b1101101;
    3 : oseg = 7'b1111001;
    4 : oseg = 7'b0110011;
    5 : oseg = 7'b1011011;
    6 : oseg = 7'b1011111;
    7 : oseg = 7'b1110000;
    8 : oseg = 7'b1111111;
    9 : oseg = 7'b1111011;
    default : oseg = 0;
  endcase
end

endmodule
