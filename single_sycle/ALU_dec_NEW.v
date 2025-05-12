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
                    3'b001: ALU_Control = 4'b0010;   // AND
                    3'b010: ALU_Control = 4'b0011;   // OR
                    3'b011: ALU_Control = 4'b0100;   // XOR
                    3'b100: ALU_Control = 4'b0101;   // Shift Left
                    3'b101: begin
                        // SRL or SRA based on Func_7
                        if ({Opc_5_bit, Func_7} == 2'b00 || {Opc_5_bit, Func_7} == 2'b01 || {Opc_5_bit, Func_7} == 2'b10)
                            ALU_Control = 4'b0110;   // SRL
                        else if ({Opc_5_bit, Func_7} == 2'b11)
                            ALU_Control = 4'b0111;   // SRA
                        else
                            ALU_Control = 4'bxxxx;
                    end
                    3'b110: ALU_Control = 4'b1000;   // SLT (Set Less Than)
                    3'b111: ALU_Control = 4'b1001;   // Signed SLT (Set Less Than)
                    default: ALU_Control = 4'bxxxx;
                endcase
            end
            default: ALU_Control = 4'bxxxx;  // Undefined ALU_op
        endcase
    end

endmodule


















//module ALU_dec_NEW(

//input [1:0]ALU_op,
//input [2:0]Func_3,
//input Opc_5_bit,     // 5 bit of opcode 
//input Func_7,
//output reg [3:0]ALU_Control
//    );
    
// always @(*)
// begin
//      case (ALU_op)
//        2'b00:        //  LW case for load instruction LW
//          begin
//            case (Func_3)
//                 3'b000: ALU_Control <= 4'b000;    //load byte
//                 3'b001: ALU_Control <= 4'b001;    //load halfword
//                 3'b010: ALU_Control <= 4'b010;    //load word
//                 3'b100: ALU_Control <= 4'b100;    //load byte
//                 3'b101: ALU_Control <= 4'b101;    //load byte
//            endcase
//          end
//        2'b10:            //R-type instruction
//          begin     
//            case (Func_3)
//                 3'b000: ALU_Control <= 4'b0000;    //addi instru
//                 3'b001:                            // slli instruction
//                 begin
//                    if(Func_7 == 0)
//                        ALU_Control <= 4'b001;
//                 end
//                 3'b010: ALU_Control <= 4'b010;    //slti
//                 3'b011: ALU_Control <= 4'b011;    //sltiu
//                 3'b100: ALU_Control <= 4'b100;    //xori
//                 3'b101:
//                 begin
//                    if(Func_7)
//                        ALU_Control <= 4'b101;    //srli
//                 end
//                 3'b110: ALU_Control <= 4'b110;    //ori
//                 3'b111: ALU_Control <= 4'b111;    //andi
//            endcase
//          end  
          
//         2'b10:            //R-type instruction
//          begin     
//            case (Func_3)
//                 3'b000: ALU_Control <= 4'b000;    //addi instru
//                 3'b001:                            // slli instruction
//                 begin
//                    if(Func_7 == 0)
//                        ALU_Control <= 4'b001;
//                 end
//                 3'b010: ALU_Control <= 4'b010;    //slti
//                 3'b011: ALU_Control <= 4'b011;    //sltiu
//                 3'b100: ALU_Control <= 4'b100;    //xori
//                 3'b101:
//                 begin
//                    if(Func_7)
//                        ALU_Control <= 4'b101;    //srli
//                 end
//                 3'b110: ALU_Control <= 4'b110;    //ori
//                 3'b111: ALU_Control <= 4'b111;    //andi
//            endcase
//          end                
//      endcase
// end
//endmodule
