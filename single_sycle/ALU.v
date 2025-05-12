`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////


module ALU #(parameter WIDTH = 32)(

input [WIDTH - 1: 0]in1,
input [WIDTH - 1: 0]in2,
input [2 : 0] alu_control,

output zero,
output reg[WIDTH - 1: 0]result
); 
always@(*)
begin
    case(alu_control)
     3'b000: result = in1 + in2;
     3'b001: result = in1 - in2;
     3'b010: result = in1 & in2;
     3'b011: result = in1 | in2;
     3'b101: result = (in1 < in2) ? 1 : 0;  // Set Less Than (SLT)
     default : result = 0;
     
    endcase
 end
      
 assign zero = (result == 0);
 
endmodule



//module ALU #(parameter WIDTH = 32)(
//    input [WIDTH - 1:0] in1,           // Pehla operand
//    input [WIDTH - 1:0] in2,           // Dusra operand
//    input [2:0] alu_op,                // ALU operation code
//    output zero,                       // Zero flag
//    output reg [WIDTH - 1:0] result    // Result of operation
//);

//    always @(*) begin
//        case (alu_op)
//            3'b000: result = in1 + in2;    // Addition
//            3'b001: result = in1 - in2;    // Subtraction
//            3'b010: result = in1 & in2;    // AND
//            3'b011: result = in1 | in2;    // OR
//            3'b100: result = in1 ^ in2;    // XOR
//            3'b101: result = (in1 < in2) ? 1 : 0;  // Set Less Than (SLT)
//            default: result = 0;           // Default case
//        endcase
//    end

//    // Zero flag logic
//    assign zero = (result == 0);

//endmodule
