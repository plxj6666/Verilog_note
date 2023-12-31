//2023-12/31
// Verilog过程设计

// 关键字initial always
// 一个模块可以包含多个initial和always，但是不可以嵌套
// 这些模块并行执行，和其前后顺序没有关系
// 但是模块内部时顺序执行的


// initial语句
// 从0开始只执行一次
// 如果包含多个语句，需要使用begin和end组成语句块
// 如果是一个语句，begin和end也可以不用
// eg:

`timescale 1nx/1ns

module test;
	reg ai, bi;
	
	initial begin
		ai = 0;
		#25;	ai = 1;
		#35;	ai = 0;
		#40; 	ai = 1;
	end
	
	initial begin
		bi = 1;
		#70;	bi = 0;
		#20;	bi = 1;
	end
	
	// stop the test
	initial begin
		forever begin
			#100
			//$display("---gyc---%d, $time);
			if ($time >= 1000) begin
				$finish;
			end
		end
	end
	
endmodule


// always 语句
// 重复执行，与initial相反
// 从0开始，当执行完最后一条语句后，就又开始执行第一条语句反复执行
// 多用于仿真时钟的产生，信号行为的检测
// eg:

`timescale 1ns/1ns

module test ;

	parameter CLK_FREQ = 100; // 100MHZ
	parameter CLK_CYCLE = 1e9 / (CLK_FREQ * 1e6);
	
	reg clk;
	initial clk = 1'b0;
	always # (CLK_CYCLE / 2) clk = ~clk;	// generating a real clock by reversing
	
	always begin
		#10;
		if ($time >= 1000) begin
			$finish;
		end
	end

endmodule
	






































