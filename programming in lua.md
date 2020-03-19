# Lua 程序设计(第二版)

## [第一章 开始](chapter-1.lua)

### 1.1 程序块
lua执行的每一段代码都称作**程序块**
``` lua
function norm(x,y)
    return (x^2 + y^2)^0.5
end

function twice(x)
    return 2 * x
end
```

### 1.2 词法规范
lua中的标识符可以由任意字母、数字和下划线构成，不能以数字开头。
``` lua
-- lua中的保留字
and 	break 		do 		else 		elseif
end 	false 		for 	function 	if 
in  	local 		nil 	not 		or
repeat 	return 		then 	true 		until
while
```

> lua区分大小写，and 和And，AND不是同一个标识符

``` lua
-- lua由“--”开始一个行注释

--[=[
-- 由"--[["开始一个块注释，可以在[[之间插入适当数量的等号。
-- 由 "]]" 结束块注释，可以在]]之间插入适当数量的等号，与注释开始匹配。
--]=]
```

### 1.3 全局变量
全局变量不需要声明，只需要赋值就可以创建。访问未初始化的变量不会产生错误，访问结果是**nil**

如果要删除一个变量，就将其赋值为**nil**
### 1.4 解释器程序
解释器程序的用法如下：
	lua [选项参数] [脚本[参数]]
选项参数“-e”可以在命令行直接输入代码，如下：
	lua -e "print(math.sin(12))"
选项参数“-l”用于加载库文件，如下：
	lua -l a -e "x = 10"

解释器在运行脚本前会将所有的命令行参数创建一个名为“arg”的table，脚本名称位于索引0，参数以此类推，脚本之前的选项参数位于负数索引。
> lua -e "sin = math.sin" script a b
> arg[-3] = "lua"
> arg[-2] = "-e"
> arg[-1] = "sin = math.sin"
> arg[0] = "script"
> arg[1] = "a"
> arg[2] = "b"

## [第二章 类型与值](chapter-2.lua)
**lua将false和nil视为假，其余都为真，也就是数字0和空字符串也为真**

## [第三章 表达式](chapter-3.lua)

## [第四章 语句](chapter-4.lua)
### 4.1 赋值
lua允许多重赋值 如：
	a,b = 10,11
	赋值后变量a为10，b为11
lua总是会将等号右边的值的个数调整到与右边相等，**若值的个数少于变量个数，那多余的变量会被赋值为nil，若值的个数多余变量的个数，那多余的值会被丢弃**。
``` lua
a, b, c = 0, 1
print(a, b, c) -- 0,1,nil
a, b = a+1, b+1, a+b
print(a, b) --1,2
a, b, c = 0
print(a, b, c) --0,nil,nil
```
### 4.2 局部变量与块
lua中通过local来创建局部变量
``` lua
j = 10	-- 全局变量
local i = 11 --局部变量
```
**局部变量的作用范围只限与声明它的那个块**
``` lua
x = 10
local i = 1 -- 程序块中的局部变量
while i <= x do
	local x = i * 2 -- while循环体中的局部变量
    print(x)        -- 2, 4, 6, 8,....
    i = i + 1
end
if i < 20 then
    local x -- then 中的局部变量
    x = 20
    print(x + 2) -- 22
else
    print(x) -- 10 全局变量
end
print(x) -- 全局变量
```
### 4.3 控制结构
#### 4.3.1 if then else
if语句先测试条件，然后根据结果执行then部分或者else部分
``` lua
if a < 0 then a = 0 end
if a < b then return a else return b end
```
也可以使用**elseif**来编写嵌套的if

#### 4.3.2 while
与其他语言的while一样

#### 4.3.3 repeat
repeat-until循环至少会执行一次。

#### 4.3.4 数字型for循环
for循环有两种：数字型for和泛型for。
数字型for如下
	for var = exp1, exp2, exp3 do
		....
	end
var从exp1变换到exp2，每次步长exp3.三个表达式的值在循环开始的时候一次性求值，var会被自动声明为for语句的局部变量。

#### 4.3.5 泛型for循环
泛型for循环通过一个迭代器函数来遍历所有值
``` lua
for i,v in ipairs(a) do
	print(i .. ":" .. v)
end
```
lua的基础库提供了ipairs，是一个用于遍历数组的迭代器函数。在每次循环中，i会被赋予一个索引值，同时v被赋予一个对应该索引的元素。
标准库提供了几种迭代器，迭代文件中每行的**io.lines**、迭代table元素的**pairs**、迭代数组元素的**ipairs**、迭代字符串中单词的**string.gmatch**等。



