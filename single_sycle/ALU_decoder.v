module ALU_decoder_new(
    input [1:0] ALU_op,
    input [2:0] Func_3,
    input Opc_5_bit,  // 5-bit opcode
    input Func_7,
    output reg [3:0] ALU_Control
);

    always @(*) begin
        case (ALU_op)
            2'b00: ALU_Control = 4'b0000;   // ADD
            2'b01: ALU_Control = 4'b0001;   // SUB
            2'b10: begin
                case (Func_3)
                    3'b000: begin
                        // ADD for Func_7=00/01/10 and SUB for Func_7=11
                        case ({Opc_5_bit, Func_7})
                            2'b00, 2'b01, 2'b10: ALU_Control = 4'b0000;  // ADD
                            2'b11: ALU_Control = 4'b0001;  // SUB
                            default: ALU_Control = 4'bxxxx;
                        endcase
                    end
                    3'b111: ALU_Control = 4'b0010;   // AND
                    3'b110: ALU_Control = 4'b0011;   // OR
                    3'b100: ALU_Control = 4'b0100;   // XOR
                    3'b001: ALU_Control = 4'b0101;   // SLL (Shift Left Logical)
                    3'b101: begin
                        // SRL for Func_7=00 and SRA for Func_7=01
                        if (Func_7 == 1'b0)
                            ALU_Control = 4'b0110;   // SRL (Shift Right Logical)
                        else
                            ALU_Control = 4'b0111;   // SRA (Shift Right Arithmetic)
                    end
                    3'b010: ALU_Control = 4'b1000;   // SLT (Set Less Than)
                    3'b011: ALU_Control = 4'b1001;   // SLTU (Set Less Than Unsigned)
                    default: ALU_Control = 4'bxxxx;  // Undefined
                endcase
            end
            default: ALU_Control = 4'bxxxx; // Undefined
        endcase
    end
endmodule
