// 2024-1/1
// Verilog循环语句
// 关键字：while,for,repeat,forever

// while循环
// eg:
while (condition) begin
	...
end


// for循环
// eg:
for (initial_assignment; condition; step_assignment) begin
	...
end

// 以上两种循环和C语言差不多


// repeat
// eg:
repeat (loop_times) begin
	...
end

// loop_times如果是变量信号，那么循环次数是循环开始时loop_times的值，即使他发生改变


// forever
// forever表示永久循环，不包含任何条件表达式
// 使用系统函数$finish可以推出forever
// eg:
reg          clk ;
initial begin
    clk       = 0 ;
    forever begin
        clk = ~clk ;
        #5 ;
    end
end

