`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module mux_4to1 #(parameter WIDTH = 32)(
    input wire [WIDTH - 1 : 0] a,
    input wire [WIDTH - 1 : 0] b,
    input wire [WIDTH - 1 : 0] c,
    input wire [WIDTH - 1 : 0] d,
    input wire [1:0] sel,

    output wire [WIDTH - 1 : 0] data_out
    );

    assign data_out = (sel == 2'b00) ? a :
                      (sel == 2'b01) ? b :
                      (sel == 2'b10) ? c :
                                       {WIDTH{1'b0}}; // Default case: Output all zeros

endmodule
