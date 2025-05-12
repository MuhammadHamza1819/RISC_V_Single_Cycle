module ALU (
    input [3:0] op,                // ALU_Control signal from ALU decoder
    input signed [31:0] op1,       // Operand 1
    input signed [31:0] op2,       // Operand 2
    output reg signed [31:0] res, // Result
    output zero
);
    always @(*) begin
        case (op)
            4'b0000: res = op1 + op2;                        // ADD
            4'b0001: res = op1 - op2;                        // SUB
            4'b0010: res = op1 & op2;                        // AND
            4'b0011: res = op1 | op2;                        // OR
            4'b0100: res = op1 ^ op2;                        // XOR
            4'b0101: res = op1 << op2[4:0];                  // SLL (Shift Left Logical)
            4'b0110: res = op1 >> op2[4:0];                  // SRL (Shift Right Logical)
            4'b0111: res = op1 >>> op2[4:0];                 // SRA (Shift Right Arithmetic)
            4'b1000: res = (op1 < op2) ? 32'b1 : 32'b0;      // SLT (Set Less Than)
            4'b1001: res = ($unsigned(op1) < $unsigned(op2)) ? 32'b1 : 32'b0; // SLTU (Set Less Than Unsigned)
            default: res = 32'b0;                            // Default case
        endcase
    end
    
    assign zero = (res == 0);
endmodule
