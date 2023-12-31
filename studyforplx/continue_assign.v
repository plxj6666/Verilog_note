// 2023-12/31
// Verilog 连续赋值

// assign 只能用于对wire变量赋值
// eg:
wire      Cout, A, B ;
assign    Cout  = A & B ;     //实现计算A与B的功能

// 也可以隐式赋值
// eg:
wire      A, B ;
wire      Cout = A & B ;


// 加法器及其仿真
module full_adder1(Ai, Bi, Ci, So, Co);
	input Ai, Bi, Ci;
	output So, Co;
	
	assign So = Ai ^ Bi ^ Ci;
	assign Co = (Ai & Bi) | (Ci & ( Ai | Bi));

endmodule

// 仿真testbench
`timescale 1ns/1ns

module fa_tb;
	reg Ai, Bi, Ci;
	wire So, Co;
	
	initial begin
		{Ai, Bi, Ci} = 3'b000;
		forever begin
			# 10;
			{Ai, Bi, Ci} = {Ai, Bi, Ci} + 1b'1;
		end
	end
	
	full_adder1 u_adder(.Ai(Ai), .Bi(Bi), .Ci(Ci), .So(So), .Co(Co));
	
	initial begin	
		forever begin
			#100;
			// $display("--gyc---%d", $time)
			if ($time >= 1000) begin
				$finish;
			end
		end
	end
endmodule
