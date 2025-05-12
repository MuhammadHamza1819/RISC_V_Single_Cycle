`timescale 1ns / 1ps


module PC #(parameter WIDTH = 32)(
    input [WIDTH - 1 : 0] pc_next,
    input clk,
    input reset,                   // Reset signal
    output reg [WIDTH - 1 : 0] pc
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;               // Reset PC to 0
        else
            pc <= pc_next;         // Update PC to next value
    end
endmodule
