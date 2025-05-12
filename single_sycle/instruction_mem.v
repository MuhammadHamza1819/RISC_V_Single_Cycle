`timescale 1ns / 1ps

module instruction_mem#(parameter WIDTH = 32)(
    input [WIDTH-1:0] addr,   // Byte address
    output reg [WIDTH-1:0] RD // Instruction read
);
    
    // Define a memory array to store 1024 words, each 32 bits wide
    reg [31:0] Mem[1023:0];

    // Initialize memory with the provided instructions
    initial begin
        // Existing instructions
        
//          Mem[0] = 32'h00200093;  //    addi x1, x0, 1
//          Mem[1] = 32'h00200113;  //    addi x2, x0, 2
//          Mem[2] = 32'hFE110CE3; //     bltu x2, x1, target
          
          
//        Mem[0] = 32'h00002697;  //    auipc x13,2
//        Mem[1] = 32'h00002737;  //    lui x14,1

        Mem[0] = 32'h00100093; // addi x1, x0, 1
        Mem[1] = 32'h00A00113; // addi x2, x0, 10
        Mem[2] = 32'h01400193; // addi x3, x0, 20
        Mem[3] = 32'h00109513; // slli x10, x1, 1
        Mem[4] = 32'h00108093; // addi x1, x0, 1
        Mem[5] = 32'hFE209CE3; // bne x1, x2, -0x02 (loop)
        Mem[6] = 32'h0020F533; // and x10, x1, x2 
       
//        Mem[0] = 32'h00200113;  // addi x2, x0, 2
//        Mem[1] = 32'h00300193;  // addi x3, x0, 3
//        Mem[2] = 32'h00310233;  // add  x4, x3, x2
//        Mem[3] = 32'h40218233;  // sub  x4, x3, x2
//        Mem[4] = 32'h003172B3;  // and  x5, x2, x3
//        Mem[5] = 32'h00117293;  // andi x5, x2, 1   
//        Mem[6] = 32'h00316333;  // or   x6, x2, x3
//        Mem[7] = 32'h00116313;  // ori  x6, x2, 1
//        Mem[8] = 32'h003143B3;  // xor  x7, x2, x3
//        Mem[9] = 32'h00114393;  // xori x7, x2, 1
//        Mem[10] = 32'h00311433; // sll  x8, x2, x3
//        Mem[11] = 32'h00111413; // slli x8, x2, 1
//        Mem[12] = 32'h003154B3; // srl  x9, x2, x3
//        Mem[13] = 32'h004000EF; // jal x1, 4
//        Mem[14] = 32'h00628A63; // beq x5, x6, offset
//        Mem[15] = 32'h00115493; // slli x9, x2, 1
//        Mem[16] = 32'h00312533; // slt x10, x2, x3
//        Mem[17] = 32'h00112513; // slti x10, x2, 1
//        Mem[18] = 32'h003135B3; // sltu x11, x2, x3
//        Mem[19] = 32'h00113593; // sltiu x11, x2, 1
//        Mem[20] = 32'h40315633;  // sra x12, x2, x3
//        Mem[21] = 32'h40115613;  // srai x12, x2, 1
//        Mem[22] = 32'h06400167;  // jalr x2, x0, 0x64
//        Mem[23] = 32'h00422023;  // sw x4, 0x0(x4)
//        Mem[24] = 32'h00022203;  // lw x4, 0x0(x4)
       
//        Mem[25] = 32'h00100093; // addi x1, x0, 1
//        Mem[26] = 32'h00A00113; // addi x2, x0, 10
//        Mem[27] = 32'h01400193; // addi x3, x0, 20
//        Mem[28] = 32'h00109513; // slli x10, x1, 1
//        Mem[29] = 32'h00108093; // addi x1, x0, 1
//        Mem[30] = 32'hFE209CE3; // bne x1, x2, -0x02 (loop)
//        Mem[31] = 32'h0020F533; // and x10, x1, x2 
       
    end

    // Always block to handle read operation
    always @(*) begin
        RD = Mem[addr[31:2]]; // Fetch word (4 bytes) aligned to the address
    end

endmodule
