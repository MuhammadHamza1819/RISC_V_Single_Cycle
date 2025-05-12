`timescale 1ns / 1ps

module Immed_Extender #(parameter WIDTH = 32)(
    input [WIDTH - 1 : 0] instruction,
    input [1:0] imm_src,
    output reg [WIDTH - 1 : 0] imm_data 
);
 
always @(*) begin
    case(imm_src)
        2'b00: imm_data = {{20{instruction[31]}}, instruction[31:20]}; // I-Type
        2'b01: imm_data = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // S-Type
        2'b10: imm_data = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // B-Type
        2'b11: begin
            if (instruction[6:0] == 7'b0110111 || instruction[6:0] == 7'b0010111) // U-Type: LUI/AUIPC
                imm_data = {instruction[31:12], 12'b0};
            else // J-Type: JAL
                imm_data = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        end
        default: imm_data = 32'b0; // Default case to avoid latches
    endcase
end

endmodule
