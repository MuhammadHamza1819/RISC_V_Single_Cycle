`timescale 1ns / 1ps

module adder_For_aui(

input [31:0] in1, in2,
output[31:0] res
    );
    
   assign res = in1 + in2;
    
endmodule
