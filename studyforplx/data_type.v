//2023-12/30
2.3 Verilog 数据类型
// 对信号重新组合成新的向量——借助大括号：
wire [31:0]    temp1, temp2 ;
assign temp1 = {byte1[0][7:0], data1[31:8]};  //数据拼接
assign temp2 = {32{1'b0}};  //赋值32位的数值0
	
// 整数，实数，时间寄存器
integer J; 
real I; //整数部分会赋值给I 3.75->3
time current_time = $time // 获取系统时间


// 虽然数组与向量的访问方式在一定程度上类似，但不要将向量和数组混淆。
// 向量是一个单独的元件，位宽为 n；数组由多个元件组成，其中每个元件的位宽为 n 或 1。它们在结构的定义上就有所区别。

// 参数parameter
parameter      data_width = 10'd32 ;
parameter      i=1, j=2, k=3 ;
parameter      mem_size = data_width * 10 ;
// 参数只能赋值一次 但是可以通过实例化的方法进行修改
// localparam ---> 无论如何都不能改变

// 字符串 每个字符占8bit，因此寄存器应该尽可能的宽
// 字符串不能多行书写
reg [0: 2 * 8 - 1] str;
initial begin
	str = "plx";
end

// 字符需要转义
