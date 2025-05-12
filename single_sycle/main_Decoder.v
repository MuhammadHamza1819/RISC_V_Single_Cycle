`timescale 1ns / 1ps

//module main_Decoder(

//input [6:0]Opcode,
//output reg Branch,
//output reg [1:0]Result_src,
//output reg Mem_Write,
//output reg Alu_Src,
//output reg [1:0] Imm_Src,
//output reg Reg_Write,
//output reg [1:0]Alu_op,
//output reg jump
//);

//always@(*)
//begin
//    case(Opcode)
//      7'b0000011:            // load Word instruction
//      begin
//        Branch <= 1'b0; Result_src <= 2'b01; Mem_Write <= 1'b0 ; Alu_Src <= 1'b1 ; Imm_Src <= 2'b00; Reg_Write <= 1'b1; Alu_op <= 2'b00; jump <= 1'b0;
//      end    
//      7'b0100011:           // Store Word 
//      begin
//        Branch <= 1'b0; Result_src <= 2'bxx; Mem_Write <= 1'b1 ; Alu_Src <= 1'b1 ; Imm_Src <= 2'b01; Reg_Write <= 1'b0; Alu_op <= 2'b00; jump <= 1'b0;
//      end
//      7'b0110011:           //R-type
//      begin
//        Branch <= 1'b0; Result_src <= 2'b00; Mem_Write <= 1'b0 ; Alu_Src <= 1'b0 ; Imm_Src <= 2'bxx; Reg_Write <= 1'b1; Alu_op <= 2'b10; jump <= 1'b0;
//      end    
//       7'b1100011:          // Branch Equal        
//      begin
//        Branch <= 1'b1; Result_src <= 2'bxx; Mem_Write <= 1'b0 ; Alu_Src <= 1'b0 ; Imm_Src <= 2'b10; Reg_Write <= 1'b0; Alu_op <= 2'b01; jump <= 1'b0;
//      end   
//       7'b0010011:          // I_type ALU        
//      begin
//        Branch <= 1'b0; Result_src <= 2'b00; Mem_Write <= 1'b0 ; Alu_Src <= 1'b1 ; Imm_Src <= 2'b00; Reg_Write <= 1'b1; Alu_op <= 2'b10; jump <= 1'b0;
//      end
//       7'b1101111:          //  JUmp       
//      begin
//        Branch <= 1'b0; Result_src <= 2'b10; Mem_Write <= 1'b0 ; Alu_Src <= 1'bx ; Imm_Src <= 2'b11; Reg_Write <= 1'b1; Alu_op <= 2'b01; jump <= 1'b1; 
//      end
//       7'b0110111: // LUI (U-type)
//        begin
//            Branch <= 1'b0;  Result_src <= 2'b00; Mem_Write <= 1'b0; Alu_Src <= 1'b1; Imm_Src <= 2'b11; Reg_Write <= 1'b1; Alu_op <= 2'bxx; jump <= 1'b0;
//        end 
        
//      7'b0010111: // AUIPC (U-type)
//        begin
//            Branch <= 1'b0; Result_src <= 2'b00; Mem_Write <= 1'b0; Alu_Src <= 1'b1; Imm_Src <= 2'b11; Reg_Write <= 1'b1; Alu_op <= 2'b00; jump <= 1'b0;
//        end   
        
//        default: // Default values for unsupported instructions
//        begin
//            Branch <= 1'b0;
//            Result_src <= 2'bxx;
//            Mem_Write <= 1'b0;
//            Alu_Src <= 1'bx;
//            Imm_Src <= 2'bxx;
//            Reg_Write <= 1'b0;
//            Alu_op <= 2'bxx;
//            jump <= 1'b0;
//        end                                      
//    endcase
//end    
//endmodule



`timescale 1ns / 1ps

module main_Decoder(
input [6:0]Opcode,
input [2:0] Func_3,
output reg Branch,
output reg [1:0]Result_src,
output reg Mem_Write,
output reg Alu_Src,
output reg [1:0] Imm_Src,
output reg Reg_Write,
output reg [1:0]Alu_op,
output reg jump,
output reg Un_Cond_Branch
);

always@(*)
begin
    case(Opcode)
      7'b0000011:            // load Word instruction
      begin
        Branch <= 1'b0; Result_src <= 2'b01; Mem_Write <= 1'b0 ; Alu_Src <= 1'b1 ; Imm_Src <= 2'b00; Reg_Write <= 1'b1; Alu_op <= 2'b00; jump <= 1'b0; Un_Cond_Branch <=0;
      end    
      7'b0100011:           // Store Word 
      begin
        Branch <= 1'b0; Result_src <= 2'bxx; Mem_Write <= 1'b1 ; Alu_Src <= 1'b1 ; Imm_Src <= 2'b01; Reg_Write <= 1'b0; Alu_op <= 2'b00; jump <= 1'b0; Un_Cond_Branch <= 0;
      end
      7'b0110011:           //R-type
      begin
        Branch <= 1'b0; Result_src <= 2'b00; Mem_Write <= 1'b0 ; Alu_Src <= 1'b0 ; Imm_Src <= 2'bxx; Reg_Write <= 1'b1; Alu_op <= 2'b10; jump <= 1'b0; Un_Cond_Branch <= 0;
      end    
       7'b1100011:          // Branch Equal        
      begin
        if(Func_3 == 3'b000)
        begin 
            Branch <= 1'b1; Result_src <= 2'bxx; Mem_Write <= 1'b0 ; Alu_Src <= 1'b0 ; Imm_Src <= 2'b10; Reg_Write <= 1'b0; Alu_op <= 2'b01; jump <= 1'b0; Un_Cond_Branch <=0;
        end    
        else
            begin
                Branch <= 1'b0; Result_src <= 2'bxx; Mem_Write <= 1'b0 ; Alu_Src <= 1'b0 ; Imm_Src <= 2'b10; Reg_Write <= 1'b0; Alu_op <= 2'b01; jump <= 1'b0; Un_Cond_Branch <= 1;
            end
      end   
      
       7'b0010011:          // I_type ALU        
      begin
        Branch <= 1'b0; Result_src <= 2'b00; Mem_Write <= 1'b0 ; Alu_Src <= 1'b1 ; Imm_Src <= 2'b00; Reg_Write <= 1'b1; Alu_op <= 2'b10; jump <= 1'b0; Un_Cond_Branch <=0;
      end
       7'b1101111:          //  JUmp       
      begin
        Branch <= 1'b0; Result_src <= 2'b10; Mem_Write <= 1'b0 ; Alu_Src <= 1'bx ; Imm_Src <= 2'b11; Reg_Write <= 1'b1; Alu_op <= 2'b01; jump <= 1'b1; Un_Cond_Branch <=0;
      end                                        
    endcase
end    
endmodule

