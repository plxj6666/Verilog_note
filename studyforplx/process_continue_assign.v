// 2024-1/1
// Verilog 过程连续赋值
// 关键词：deassign,force, release


// assign,deassign
// 第一类过程连续赋值语句
// 赋值对象：reg或reg组，不能是wire

// 下面是一个例子，用assign和deassign完成D触发器
// eg:
module dff_assign(
    input       rstn,
    input       clk,
    input       D,
    output reg  Q
 );
 
    always @(posedge clk) begin
        Q <= D ;       //Q = D at posedge of clock
    end
 
    always @(negedge rstn) begin
        if(!rstn) begin
            assign Q = 1'b0 ; //change Q value when reset effective
        end
        else begin        //cancel the Q value overlay,
            deassign Q ;  //and Q remains 0-value until the coming of clock posedge
        end
    end
 
endmodule


// force,release
// 第二类过程连续赋值
// 与assign和deassign类似，
// 但是其赋值对象可以是reg和wire
// 一般用于交互式调试
