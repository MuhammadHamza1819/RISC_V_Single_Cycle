`timescale 1ns / 1ps

module RISC_V_single_cycle (
    input clk,
    input reset 
);
// Program Counter (PC)
wire [31:0] pc; // Current PC value
wire [31:0] pc_next; // Next PC value
wire [31:0] pcTarget;
wire [31:0] pcPlus4;
wire PC_src;
wire [31:0] instruction;

PC pc_uut (
    .pc_next(pc_next), 
    .clk(clk), 
    .reset(reset), 
    .pc(pc)
);

PC_plus4 pc_Plus_uut(
           .PC(pc),
           .PC_plus_4(pcPlus4)
    );   
// Instruction Memory

instruction_mem uu_ints_mem (
    .addr(pc), 
    .RD(instruction)
);

// Control Unit
//wire [6:0] Opcode = instruction[6:0];
//wire [2:0] Func_3 = instruction[14:12];
//wire Func_7 = instruction[30];
//wire PC_src;
//wire [1:0] Result_src;
//wire Mem_Write;
//wire [3:0] ALU_control;
//wire ALU_src;
//wire [1:0] Imm_src;
//wire Reg_write;
//wire zero;
//wire [31:0]ALU_result;
//wire [31:0]Result_out;

wire [6:0] Opcode = instruction[6:0];
wire [2:0] Func_3 = instruction[14:12];
wire Func_7 = instruction[30];
wire [1:0] Result_src;
wire Mem_Write;
wire [3:0] ALU_control;
wire ALU_src;
wire [1:0] Imm_src;
wire Reg_write;
wire zero;
wire [31:0]ALU_result;
wire [31:0]Result_out;
wire Branch;
wire Jump;
wire Un_conditional_Branch;

//controlUnit CU_uut (
//    .Opcode(Opcode),
//    .Func_3(Func_3),
//    .Func_7(Func_7),
//    .zero(zero),
//    .PC_src(PC_src),
//    .Result_src(Result_src),
//    .Mem_Write(Mem_Write),
//    .ALU_control(ALU_control),
//    .ALU_src(ALU_src),
//    .Imm_src(Imm_src),
//    .Reg_write(Reg_write)
//);

// Register File

controlUnit Cntrl_unit(
    .Opcode(Opcode),
    .Func_3(Func_3),
    .Func_7(Func_7),
    .Result_src(Result_src),
    .Mem_Write(Mem_Write),
    .ALU_control(ALU_control),
    .ALU_src(ALU_src),
    .Imm_src(Imm_src),
    .Reg_write(Reg_write),
    .jump(Jump),
    .Branch(Branch),
    .Un_conditional_Branch(Un_conditional_Branch)
    );

wire [31:0] RD1, RD2, WD3;
wire [4:0] A1 = instruction[19:15];
wire [4:0] A2 = instruction[24:20];
wire [4:0] A3 = instruction[11:7];

register_file RF_uut (
    .clk(clk),
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .WD3(Result_out),
    .WE3(Reg_write),
    .RD1(RD1),
    .RD2(RD2)
);

//// Immediate Extender
wire [31:0] imm_data;

Immed_Extender IM_uut (
    .instruction(instruction),
    .imm_src(Imm_src),
    .imm_data(imm_data)
);

// ALU Source MUX
wire [31:0] ALU_input2;

mux_2to1 ALU_src_uut (
    .a(RD2),
    .b(imm_data),
    .sel(ALU_src),
    .data_out(ALU_input2)
);

// ALU

//ALU ALU_control_uut (
//    .in1(RD1),
//    .in2(ALU_input2),
//    .alu_control(ALU_control),
//    .zero(zero),
//    .res(ALU_result)
//);
ALU ALU_control_uut (
    .op(ALU_control),
    .op1(RD1),
    .op2(ALU_input2),
    .res(ALU_result),
    .zero(zero)
);

arbitar for_pc_src_select(

.branch(Branch),
.Un_cond_branch(Un_conditional_Branch),
.zero(zero),
.Jump(Jump),
.Pc_src(PC_src)

 );
 
// Data Memory
wire [31:0] data_mem_out;

data_Memory DM_uut32 (
    .clk(clk),
    .WE(Mem_Write),
    .addr(ALU_result), // Result is the address
    .WD(RD2),      // Data to write
    .RD(data_mem_out) // Data read
);

mux_4to1 result_src(
    .a(ALU_result),
    .b(data_mem_out),
    .c(pcPlus4),
    .d(0),
    .sel(Result_src),
    .data_out(Result_out)
    );
    
 Pc_target PC_target_uut(
.in1(pc), 
.in2(imm_data),
.out(pcTarget)
 );
 
 mux_2to1 PC_SRC (
    .a(pcPlus4),
    .b(pcTarget),
    .sel(PC_src),
    .data_out(pc_next)
);

 
endmodule
