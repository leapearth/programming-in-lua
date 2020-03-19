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

--[[
-- 由"--[["开始一个块注释
-- 由 "]]" 结束块注释
--]]
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

