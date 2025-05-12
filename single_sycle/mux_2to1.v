`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module mux_2to1 #(parameter WIDTH = 32)(

input wire [WIDTH - 1 : 0] a,
input wire [WIDTH - 1 : 0] b,
input wire  sel,

output wire [WIDTH - 1 : 0] data_out
    );
    
 assign data_out = (sel)?  b : a;     
 
endmodule
