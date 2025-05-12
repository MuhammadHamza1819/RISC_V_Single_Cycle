`timescale 1ns / 1ps


module arbitar(

input branch,
input Un_cond_branch,
input zero,
input Jump,
output reg Pc_src
 );

always @(*)begin
//    Pc_src = (branch & zero) |  (Un_cond_branch & !zero) | Jump;    
    if(branch)
    begin
        Pc_src = branch & zero;
    end  
    else if(Un_cond_branch)
    begin
        Pc_src = (Un_cond_branch & !zero);
    end
    else if(Jump)
    begin
        Pc_src = 1'b1;
    end
    else
      Pc_src = 0;
end    
endmodule
