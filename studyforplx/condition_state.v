// 2023-12/31
// Verilog条件语句
// 关键词：if，选择器

// 条件语句
// 条件表达式必须在括号外
// eg:
if (condition1)       true_statement1 ;
else if (condition2)        true_statement2 ;
else if (condition3)        true_statement3 ;
else                      default_statement ;


// 条件语句中加入begin和end是一个很好的习惯
// eg:
if(en)
    if(sel == 2'b1)
        sout = p1s ;
    else
        sout = p0 ;

// 对于上述语句，不加入begin会显得不规整，改为下列
if(en) begin
    if(sel == 2'b1) begin
        sout = p1s ;
    end
    else begin
        sout = p0 ;
    end
end


