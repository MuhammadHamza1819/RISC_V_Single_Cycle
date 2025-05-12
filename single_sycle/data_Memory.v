`timescale 1ns / 1ps


module data_Memory#(parameter WIDTH = 32)(

input clk,
input WE,
input    [WIDTH-1:0]addr,
input    [WIDTH-1:0]WD,
output   [WIDTH-1:0] RD
    );
    
    
 /////creation of memory
 reg [31:0] dataMemory [1023:0];
  integer i = 0;

 initial 
 begin
 for(i = 0; i < 1024; i = i +1 )
 begin
    dataMemory[i] = i;
 end
 end 
assign RD = (WE == 1'b0)? dataMemory[addr] : 32'h00000000;
    
always@(posedge clk)
begin
    if(WE)begin
        dataMemory[addr] <= WD;
    end 
end    
endmodule
