// 2023-12/31
// Verilog时延

// 时延

//普通时延，A&B计算结果延时10个时间单位赋值给Z
wire Z, A, B ;
assign #10    Z = A & B ;

//隐式时延，声明一个wire型变量时对其进行包含一定时延的连续赋值。
wire A, B;
wire #10        Z = A & B;

// 惯性时延
// 上述代码为例，若A，B其中一个值发生变化，则Z得到新值时，会有一个10ns的延迟
// 若是载这10ns期间，A，B又发生了变化，则第一次的变化无用（没有成功执行），我们取第二次变化的值
// 因此仿真时，设置的时延一定要合理，避免有些信号不能被有效延时

// eg:
module time_delay_module(
    input   ai, bi,
    output  so_lose, so_get, so_normal);
 
    assign #20      so_lose      = ai & bi ;
    assign  #5      so_get       = ai & bi ;
    assign          so_normal    = ai & bi ;
endmodule

// testbench
`timescale 1ns/1ns

module test ;
    reg  ai, bi ;
    wire so_lose, so_get, so_normal ;
 
    initial begin
        ai        = 0 ;
        #25 ;      ai        = 1 ;
        #35 ;      ai        = 0 ;        //60ns
        #40 ;      ai        = 1 ;        //100ns
        #10 /*由于这个1的延迟只有10， 因此来不及执行assign #20 so_lose = ai & bi*/;
		// ai就直接变成了下面的0      
		ai        = 0 ;        //110ns
    end
 
    initial begin
        bi        = 1 ;
        #70 ;      bi        = 0 ;
        #20 ;      bi        = 1 ;
    end
 
    time_delay_module  u_wire_delay(
        .ai              (ai),
        .bi              (bi),
        .so_lose         (so_lose),
        .so_get          (so_get),
        .so_normal       (so_normal));
 
    initial begin
        forever begin
            #100;
            //$display("---gyc---%d", $time);
            if ($time >= 1000) begin
                $finish ;
            end
        end
    end
 
endmodule