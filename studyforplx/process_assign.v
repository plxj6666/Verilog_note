// 2023-12/31
// Verilog过程赋值
// 阻塞赋值， 非阻塞赋值，并行

/* 
总述：过程性赋值是在initial或者always语句块中执行的赋值;
赋值对象是寄存器，整数，实数;
过程性赋值其值保持不变直至二次赋值，也就是说只有语句执行时才会赋值;
而连续性赋值总是激活，只要操作数改变，就会重新赋值。
*/


// 阻塞赋值
// 阻塞赋值属于顺序执行，即下一条语句执行前，当前语句一定执行完毕；
// 使用 “=” 进行赋值


// 非阻塞赋值
// 同时赋值， 使用 <=
// 注:我们指的同时赋值是指 所有的<= 同时赋值而不包括 = ，如果有= 依旧按照先后顺序

// eg:
`timescale 1ns/1ns
 
module test ;
    reg [3:0]   ai, bi ;
    reg [3:0]   ai2, bi2 ;
    reg [3:0]   value_blk ;
    reg [3:0]   value_non ;
    reg [3:0]   value_non2 ;
 
    initial begin
        ai            = 4'd1 ;   //(1)
        bi            = 4'd2 ;   //(2)
        ai2           = 4'd7 ;   //(3)
        bi2           = 4'd8 ;   //(4)
        #20 ;                    //(5)
 		
        //non-block-assigment with block-assignment
        ai            = 4'd3 ;     //(6)
        bi            = 4'd4 ;     //(7)
        value_blk     = ai + bi ;  //(8) 
        value_non     <= ai + bi ; //(9) // 由于在(6),(7)阻塞赋值之后，因此其取新值7
 
        //non-block-assigment itself
        ai2           <= 4'd5 ;           //(10)
        bi2           <= 4'd6 ;           //(11)
        value_non2    <= ai2 + bi2 ;      //(12) 由于与（10），（11）并行，因此其等不到新值，直接取旧值15
    end
 
   //stop the simulation
    always begin
        #10 ;
        if ($time >= 1000) $finish ;
    end
 
endmodule


// 使用非阻塞赋值避免竞争
// always时序模块多用非阻塞赋值，always逻辑模块采用阻塞赋值
// initial使用阻塞赋值

// 如下是一个交换寄存器值的赋值功能
// eg:
always @(posedge clk) begin
	a = b;
end

always @(posedge clk) begin
	b = a;
end

// 此时由于是阻塞赋值，两条语句总有一条先，一条后，因此最终都会是相等
// a = a = b; a = b = b;

always @(posedge clk) begin
	a <= b;
end

always @(posedge clk) begin
	b <= a;
end

// 此时使用非阻塞赋值，两条指令同时执行，便可以交换数值

// 当然，也可以采用中间变量
always @(posedge clk) begin
	temp = a;
	a = b;
	b = temp;
end




















