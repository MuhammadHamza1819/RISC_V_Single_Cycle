`timescale 1ns / 1ps


module register_file#(parameter WIDTH = 32)(

input clk,
input[4:0] A1,
input [4:0]A2,
input [4:0] A3,
input [WIDTH -1:0] WD3,
input WE3,

output [WIDTH -1:0] RD1,
output [WIDTH -1:0]RD2
);

reg [WIDTH -1:0] Reg_file [ 31:0];
integer i;
initial
begin
    for(i = 0; i < 32; i= i+1)
        begin
            Reg_file[i] = i;
        end
 end       
assign RD1 = Reg_file[A1];
assign RD2 = Reg_file[A2];

always @(posedge clk)
begin
    if(WE3)
    begin
        Reg_file[A3] <= WD3;
    end
end    
endmodule
