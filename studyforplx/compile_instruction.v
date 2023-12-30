//2023-12/30
// Verilog编译指令

// 以反引号 ` 开始的某些标识符是 Verilog 系统编译指令。

// `define ==># define in C language
// eg: `define DATA_DW 32	


// `undef 取消宏定义
//eg:
`define A 32
B = A; // B = 32
...
`undef A
B = A; // B = XXXX


// 条件编译
// eg: 如果MCU51已经定义，就采用第一种，否则第二种、第三种
`ifdef       MCU51
    parameter DATA_DW = 8   ;
`elsif       WINDOW
    parameter DATA_DW = 64  ;
`else
    parameter DATA_DW = 32  ;
`endif

// `ifndef == if not define


// `include 将一个verilog文件嵌入进另一个verilog
// eg
`include "header.v"


// `timescale 
// 在 Verilog 模型中，时延有具体的单位时间表述，并用 `timescale 编译指令将时间单位与实际时间相关联。
//该指令用于定义时延、仿真的单位和精度，格式为：

// 精度不能超过时间单位大小
//eg:
`timescale 1ns/100ps    //时间单位为1ns，精度为100ps，合法
//`timescale 100ps/1ns  //不合法
module AndFunc(Z, A, B);
    output Z;
    input A, B ;
    assign #5.207 Z = A & B 	 // 则延迟5.207ns输出A&B
endmodule

// `timescale 的时间精度设置是会影响仿真时间的。时间精度越小，仿真时占用内存越多，实际使用的仿真时间就越长。


// `default_nettype  该指令用于为隐式的线网变量指定为线网类型
// eg:
`default_nettype wand
// 说明未定义的线网是线与类型






