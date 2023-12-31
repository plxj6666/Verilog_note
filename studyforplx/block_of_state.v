//2023-12/31
// Verilog语句块
// 关键字：顺序块，并行块，嵌套块，命名块，disable

// 顺序块
begin
//...
end

// 并行块
// 采用fork和join表示
// 他的每一个语句都是并行的，即便是阻塞的
// 并行块每条语句的时延和块语句开始执行的时间有关
// eg:

`timescale 1ns/1ns
 
module test ;
    reg [3:0]   ai_sequen, bi_sequen ;
    reg [3:0]   ai_paral,  bi_paral ;
    reg [3:0]   ai_nonblk, bi_nonblk ;
 
 //============================================================//
    //(1)Sequence block
    initial begin
        #5 ai_sequen         = 4'd5 ;    //at 5ns	//由于阻塞，因此下一条命令需要等10ns
        #5 bi_sequen         = 4'd8 ;    //at 10ns
    end
    //(2)fork block
    initial fork
        #5 ai_paral          = 4'd5 ;    //at 5ns
        #5 bi_paral          = 4'd8 ;    //at 5ns
    join
    //(3)non-block block
    initial fork
        #5 ai_nonblk         <= 4'd5 ;    //at 5ns
        #5 bi_nonblk         <= 4'd8 ;    //at 5ns
    join
 
endmodule


// 嵌套块
// eg:
`timescale      1ns/1ns
 
module test ;
 
    reg [3:0]   ai_sequen2, bi_sequen2 ;
    reg [3:0]   ai_paral2,  bi_paral2 ;
    initial begin
        ai_sequen2         = 4'd5 ;    //at 0ns
        fork
            #10 ai_paral2          = 4'd5 ;    //at 10ns
            #15 bi_paral2          = 4'd8 ;    //at 15ns
        join
        #20 bi_sequen2      = 4'd8 ;    //at 35ns	// 取得是上面并行指令的最长的时延
    end
 
endmodule

// 命名块
`timescale 1ns/1ns
 
module test;
 
    initial begin: runoob   //命名模块名字为runoob，分号不能少
        integer    i ;       //此变量可以通过test.runoob.i 被其他模块使用
        i = 0 ;
        forever begin
            #10 i = i + 10 ;       
        end
    end
 
    reg stop_flag ;
    initial stop_flag = 1'b0 ;
    always begin : detect_stop
        if ( test.runoob.i == 100) begin //i累加10次，即100ns时停止仿真
            $display("Now you can stop the simulation!!!");
            stop_flag = 1'b1 ;
        end
        #10 ;
    end
 
endmodule

// 禁止块
// 类似于break，与命名块结合后可以用来退出处理错误
// 但其相对于break可以禁止设计中任何一个命名的模块

`timescale 1ns/1ns
 
module test;
 
    initial begin: runoob_d //命名模块名字为runoob_d
        integer    i_d ;
        i_d = 0 ;
        while(i_d<=100) begin: runoob_d2
            # 10 ;
            if (i_d >= 50) begin       //累加5次停止累加
                disable runoob_d3.clk_gen ;//stop 外部block: clk_gen
                disable runoob_d2 ;       //stop 当前block: runoob_d2
            end
            i_d = i_d + 10 ;
        end
    end
 
    reg clk ;
    initial begin: runoob_d3
        while (1) begin: clk_gen  //时钟产生模块
            clk=1 ;      #10 ;
            clk=0 ;      #10 ;
        end
    end
 
endmodule



