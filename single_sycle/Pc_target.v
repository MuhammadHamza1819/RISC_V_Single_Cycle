`timescale 1ns / 1ps


module Pc_target(
input [31:0] in1,
input [31:0] in2,
output [31:0] out
    );
    
    assign out = in1 + in2;
endmodule
