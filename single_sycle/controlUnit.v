`timescale 1ns / 1ps
//module controlUnit(

//input [6:0]Opcode,
//input [2:0]Func_3,
//input Func_7,
//input zero,
//output PC_src,
//output [1:0]Result_src,
//output Mem_Write,
//output [3:0]ALU_control,
//output ALU_src,
//output [1:0] Imm_src,
//output Reg_write
//    );

//wire Branch;
//wire  [1:0]Alu_op;
//wire jump;
    
//main_Decoder main_decod_uut(

//.Opcode(Opcode),
//.Branch(Branch),
//.Result_src(Result_src),
//.Mem_Write(Mem_Write),
//.Alu_Src(ALU_src),
//.Imm_Src(Imm_src),
//.Reg_Write(Reg_write),
//.Alu_op(Alu_op),
//.jump(jump)
//);   

//wire Branch_condition;

////// Branch condition logic based on Func_3
////assign Branch_condition = (Func_3 == 3'b000) ? zero :          // beq
////                          (Func_3 == 3'b001) ? ~zero :         // bne
//////                          (Func_3 == 3'b100) ? ALU_negative :  // blt
//////                          (Func_3 == 3'b101) ? ~ALU_negative : // bge
////                          1'b0;                               // Default: No branch

////// Update PC_src
////assign PC_src = (Branch & Branch_condition) | jump;

//assign PC_src = (Branch & zero) | jump;

//ALU_decoder_new Alu_dec_uut(

//.ALU_op(Alu_op),
//.Func_3(Func_3),
//.Opc_5_bit(Opcode[5]),     // 5 bit of opcode 
//.Func_7(Func_7),

//.ALU_Control(ALU_control)
//    ); 
//endmodule


module controlUnit(

input [6:0]Opcode,
input [2:0]Func_3,
input Func_7,
output [1:0]Result_src,
output Mem_Write,
output [3:0]ALU_control,
output ALU_src,
output [1:0] Imm_src,
output Reg_write,
output jump,
output Branch,
output Un_conditional_Branch
    );

wire  [1:0]Alu_op;

 
main_Decoder main_decod_uut(

.Opcode(Opcode),
.Func_3(Func_3),
.Branch(Branch),
.Result_src(Result_src),
.Mem_Write(Mem_Write),
.Alu_Src(ALU_src),
.Imm_Src(Imm_src),
.Reg_Write(Reg_write),
.Alu_op(Alu_op),
.jump(jump),
.Un_Cond_Branch(Un_conditional_Branch)
);   

//assign PC_src = Branch & zero;


ALU_decoder_new Alu_dec_uut(
.ALU_op(Alu_op),
.Func_3(Func_3),
.Opc_5_bit(Opcode[5]),     // 5 bit of opcode 
.Func_7(Func_7),

.ALU_Control(ALU_control)
    ); 
endmodule

