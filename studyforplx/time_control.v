//2023-12/31
// Verilog时序控制赋值
// 关键词：时延控制，时间控制，边沿触发，电平触发

// 时延控制
// 出现在表达式中，制定了语句从开始到执行完毕的时间间隔

// 常规时延
// eg:
reg value_test;
reg value_general;
# 10 value_general = value_test;

// 另一种方法
#10;
value_single = value_test;


// 内嵌时延
// 遇到内嵌延时时，该语句先将计算结果保存，然后等待一定的时间后赋值给目标信号。
// eg:
reg value_test;
reg value_embed;
value_embed = #10 value_test;

// 这两种时延方式的效果有所不同
// 当右边是常量时，两种赋值效果是一样的
// 当右边是变量是，效果可能不同 
// 对于常规时延，他会在时延后将时延后的值赋值给左边
// 而对于内嵌时延，他会在时延之前保存此时的值，等到时延之后在赋值
// eg:

`timescale 1ns/1ns
 
module test ;
    reg  value_test ;
    reg  value_general, value_embed, value_single ;
 
    //signal source
    initial begin
        value_test        = 0 ;
        #25 ;      value_test        = 1 ;
        #35 ;      value_test        = 0 ;        //absolute 60ns
        #40 ;      value_test        = 1 ;        //absolute 100ns
        #10 ;      value_test        = 0 ;        //absolute 110ns
    end
 
    //(1)general delay control
    initial begin
        value_general     = 1;
        #10 value_general  = value_test ; //10ns, value_test=0
        #45 value_general  = value_test ; //55ns, value_test=1
        #30 value_general  = value_test ; //85ns, value_test=0
        #20 value_general  = value_test ; //105ns, value_test=1
    end
 
    //(2)embedded delay control
    initial begin
        value_embed       = 1;
        value_embed  = #10 value_test ; //0ns, value_test=0
        value_embed  = #45 value_test ; //10ns, value_test=0
        value_embed  = #30 value_test ; //55ns, value_test=1
        value_embed  = #20 value_test ; //85ns, value_test=0
    end
 
    //(3)single delay control
    initial begin
        value_single      = 1;
        #10 ;
        value_single = value_test ; //10ns, value_test=0
        #45 ;
        value_single = value_test ; //55ns, value_test=1
        #30 ;
        value_single = value_test ; //85ns, value_test=0
        #20 ;
        value_single = value_test ; //105ns, value_test=1
    end
 
    always begin
        #10;
        if ($time >= 150) begin
            $finish ;
        end
    end
 
endmodule


// 边沿触发时间控制
// 在Verilog中，事件是指一个reg或者wire型变量发生了值得变化

// 一般事件控制
// 事件控制使用'@'
// 语句执行条件：信号的值发生特定方向的变化
// posedge发生正向边沿跳转，也就是我们说的上升沿
// negedge发生负向边沿跳转，也就是我们说的下降沿
// 如果不说明，则都发生
// eg:
always @(clk) q <= d;
// 只要发生变化，就会令q=d;

always @(posedge clk) q<= d;
// 只有上升沿才有q=d;


// 命名事件控制
// 用户可以命名event类型的变量，并触发该变量来识别事件是否发生。命名事件用event来声明
// 触发信号用'->'表示
// eg:
event start_receiving;
always @(posedge clk_samp) begin
	-> start_receiving;
end

always @(start_receiving) begin
	data_buf = {data_if[0], data_if[1]};
end


// 敏感列表
// 使用'or'连接多个信号或事件
// eg:
always @(posedge clk or negedge rstn) begin
// always @(posedge clk, negedge rstn) begin
// 也可以如上采用逗号进行陈列
	if (!rstn) begin
		q <= 1'b;
	end
	else begin
		q <= d;
	end
end

// 可使用always @* 或者 @* 表示语块中的所有输入变量均是敏感的
// eg:
always @(*) begin
//always @(a, b, c, d, e, f, g, h, i, j, k, l, m) begin 
//两种写法等价
    assign s = a? b+c : d ? e+f : g ? h+i : j ? k+l : m ;
end



// 电平敏感事件控制
// verilog还支持电平作为敏感信号控制时序，即后面的语句需要等待条件为真
// 使用wait表示这种敏感情况
// eg:
initial begin
	wait(start_enable) ;
	forever begin
		// start信号使能后，在slk_samp的上升沿对数据进行整合
		data_buf = {data_if[0], data_if[1]};
	end
end
















































































