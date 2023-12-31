// 2023-12/31
// Verilog多路分支语句
// 关键字：case，选择器

// case语句，类似于C语言，但是也有不同
// 不用每次都是用break跳出来
// 必须必须必须要有default
// eg:
case(case_expr)
    condition1     :             true_statement1 ;
    condition2     :             true_statement2 ;
    ……
    default        :             default_statement ;
endcase


// casex, casez用来表示条件选项中的无关项

module mux4_1(sel1, sel2, data1, data2, data3, data4, res);
	input sel1;
	input sel2;
	input data1;
	input data2;
	input data3;
	input data4;
	output res;
	case({se1, sel2})
		2'b00: res = data1;
		2'b01: res = data2;
		2'b10: res = data3;
		2'b11: res = data4;
	endcase
endmodule


	
	