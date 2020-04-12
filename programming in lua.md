# Lua 程序设计(第二版)

## [第一章 开始](./chapter-1.lua)

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
and  	break   do 		else   		elseif
end  	false   for  	function  	if
in   	local   nil  	not   		or
repeat  return  then  	true   		until
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

  全局变量不需要声明，只需要赋值就可以创建。访问未初始化的变量不会产生错误，访问结果是**nil**，如果要删除一个变量，就将其赋值为**nil**

### 1.4 解释器程序

解释器程序的用法如下：

	lua [选项参数] [脚本[参数]]
选项参数“-e”可以在命令行直接输入代码，如下：

	lua -e "print(math.sin(12))"

选项参数“-l”用于加载库文件，如下：	
	
	lua -l a -e "x = 10"

​		解释器在运行脚本前会将所有的命令行参数创建一个名为“arg”的table，脚本名称位于索引0，参数以此类推，脚本之前的选项参数位于负数索引。
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

​		lua总是会将等号右边的值的个数调整到与右边相等，**若值的个数少于变量个数，那多余的变量会被赋值为nil，若值的个数多余变量的个数，那多余的值会被丢弃**。

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

​		for循环有两种：数字型for和泛型for。
数字型for如下

``` lua
	for var = exp1, exp2, exp3 do
		....
	end
```
​		var从exp1变换到exp2，每次步长exp3.三个表达式的值在循环开始的时候一次性求值，var会被自动声明为for语句的局部变量。

#### 4.3.5 泛型for循环

泛型for循环通过一个迭代器函数来遍历所有值

``` lua
for i,v in ipairs(a) do
	print(i .. ":" .. v)
end
```
​		lua的基础库提供了ipairs，是一个用于遍历数组的迭代器函数。在每次循环中，i会被赋予一个索引值，同时v被赋予一个对应该索引的元素。
​		标准库提供了几种迭代器，迭代文件中每行的**io.lines**、迭代table元素的**pairs**、迭代数组元素的**ipairs**、迭代字符串中单词的**string.gmatch**等。

## [第五章 函数](chapter-5.lua)

​		lua为面向对象式的调用提供了一种特殊的语法**冒号操作符**。表达式o.foo(o,x)的另一种写法是o:foo(x)，冒号操作符将o作为foo的第一个参数。

### 5.1多重返回值

lua允许函数返回多个结果。

``` lua
s, e = string.find("hello lua users", "lua")
print(s, e) -- 7, 9
```
lua会调整函数的返回值数量以适应不同的调用情况。
	
	function foo0() end
	function foo1() return "a" end
	function foo2() return "a", "b" end
> 若将函数调用作为一条单独的语句，则会丢弃所有返回值。

	foo0() 
	foo1()
	foo2()
> ​		若将函数作为表达式的一部分来调用，则只保留第一个返回值，只有当一个函数调用是一系列表达式中的最后一个元素，才能获得所有返回值。

	x, y = foo2()  --x = "a" y = "b"
	x = foo2()  --x = "a" "b"被丢弃
	x, y, z = 10, foo2() -- x = 10 y = "a" z = "b"
	x, y, z = foo2()， 10 -- x = "a" y = 10 z = nil
> 如果一个函数没有返回值或者没有返回足够多的返回值，那么就用nil补充缺失的值。

	x, y = foo0() --x = nil y = nil
> ​		当一个函数调用作为另一个函数调用的最后一个或者唯一一个实参时，第一个函数的所有返回值将作为参数传入第二个函数。

	pirnt(foo0())
	print(foo1())
	print(foo2())
	print(10,11,12,foo2())
> return语句会返回所有函数返回值

### 5.2 变长参数

``` lua
function add(...)
	local s = 0
	for i, v in ipairs{...} do
		s = s + v
	end
	return s
end
```
​		通常函数在遍历变长参数时只需使用表达式{...}，但是，有时变长参数中可能包含一些故意传入的nil，那就需要函数**select**来访问变长参数

``` lua
for i = 1, selsec('#', ...) do
	local arg = select(i, ...)
end
调用select时必须传入一个固定实参selector和一系列变长参数，如果selector为数字n，那么返回第n个元素，否则selector只能为字符串“#”，这时返回变长参数的总数。
```

## [第6章 深入函数](chapter-6.lua)

​		**lua中函数和所有其它值一样都是匿名的，它们没有名称。比如函数print，它其实是一个持有某函数的变量。**
### 闭合函数

	如果将一个函数写在另一个函数内部，那这个位于函数内部的函数就可以访问外部函数中的局部变量。

``` lua
-- 通过年纪来排序
names = {"Peter","Paul","Mary"}
grades = {Mary=10,Paul=7,Peter=8}
table.sort(names,function (n1,n2)
	return grades[n1] > grades[n2]
	end)

function sortbygrade(names, grades)
	table.sort(names,function(n1,n2)
		return grades[n1] > grades[n2]
	end)
end
```
第二个函数中匿名函数可以访问外部函数的局部变量grades

### 6.2 非全局函数

**函数不仅可以存储在全局变量中，还可以存储在table的字段中和局部变量中**

### 6.3 正确的尾调用

​		lua支持**尾调用消除**，尾调用即一种类似goto的函数调用，当一个函数调用是另一个函数的最后一个动作时，该调用才算是尾调用。

``` lua
function f(x)
	return g(x)
end
```
​		当函数f调用完函数g之后就无事可做了，这种情况时，程序就不需要返回函数f了，所以尾调用之后程序也不需要保存任何关于函数f的栈信息了，当函数g返回时，直接返回调用函数f的那个点上。
​	
​		由于**尾调用**不会耗费栈空间，所以一个程序可以拥有无数嵌套的**尾调用**。
``` lua
function foo(n)
	if n > 0 then 
		return foo(n - 1)
	end
end
```
> ​		在lua中只有“return <func>(<args>)”这样的形式才算一条**尾调用**

## [第七章](chapter-7.lua)

### 7.1 迭代器与闭合函数
​		lua中通常将迭代器表示为函数，每一次调用函数，即返回集合中的**下一个元素**。

``` lua
function values(t)
    local i = 0
    return function() i = i + 1; return t[i] end
end
```

### 7.2 泛型for的语义

​		泛型for在循环过程内部保存了迭代器函数，实际上他保存着3个值：一个迭代器函数、一个恒定状态、和一个控制变量。

​		泛型for的语法如下:

```lua
for <var-list> in <exp-list> do
	<body>
end
```
``` lua
for var_1, ..., var_n in <explist> do <block> end
-- 等价与
do
local _f, _s, _var = <explist>
while true do
 local var_1, ..., var_n = _f(_s, _var)
	_var = var_1
	if _var == nil then
  break
	else
		<block>
	end
end
```

  假设迭代器函数为f，恒定状态为s，控制变量为a0，那么在循环过程中控制变量的值依次为a1 = f(s，a0)、a2 = f(s，a1)，直到ai为nil结束循环。

## [第八章 编译、执行与错误](chapter-8.lua)

### 8.1 编译

​		dofile函数是一种内置的操作，用于运行Lua代码块，但实际上dofile是一个辅助函数，loadfile才做了真正的核心工作。loadfile会从一个文件加载Lua代码块，但它不会运行代码，只是编译代码，然后将编译结果作为一个函数返回。

​		dofile可以这样来定义：

``` lua
function dofile(filename)
    local f = assert(loadfile(filename))
    return f()
end
```

​		如果loadfile失败，assert就会引发一个错误。

​		函数loadstring和loadfile类似，不同之处是它从一个字符串中读取代码。

``` lua
f = loadstring("i = i + 1")
```

​		f就变成了一个函数，每次调用执行 “i = i + 1”

​		loadstring在编译时不涉及词法域，所以会出现以下：

``` lua
i = 32
local i = 0
f = loadstring("i = i + 1; print(i)")
g = function() i = i + 1;print(i) end
f()	-- 33
g() -- 1
```

​		loadstring总是在全局环境中编译它的字符串，所以导致操作了全局的i。

### 8.3 错误

Lua所遇到的任何未预期条件都会引发一个错误。例如，当视图将两个非数字的值相加、对一个不是函数的值用函数调用的方式调用。也可以显式的引发一个错误，通过调用error函数并传入一个错误消息的参数。

``` lua
print("enter a number:")
n = io.read("*number")
if not n then error("invalid input") end
```



## [第九章 协同程序](chapter-9.lua)

  协同程序和线程差不多，拥有自己独立的栈、局部变量和指针指令，同时又有与其他协同程序共享的全局变量和其他大部分东西。协同程序和线程的区别在于：**一个具有多个线程的程序可以同时运行几个线程，而协同程序却需要彼此协作地运行，也就是一个具有多个协同程序的程序在任意时刻只能运行一个协同程序。**

### 9.1 协同程序基础

​			当一个协同程序A唤醒另一个协同程序B的时候，协同程序就处于一个特殊状态，既不是挂起，也不是运行，所以将这种状态称为正常状态。

## [第十章 完整的示例](chapter-10.lua)

### 10.1 数据描述

### 10.2 马尔科夫链算法



## [第十一章 数据结构](chapter-11.lua)



## [第十二章 数据文件与持久性](chapter-12.lua)



## [第十三章 元表和元方法](chapter-13.lua)

​		lua中的每个值都有一套预定义的操作集合。例如，可以将数字相加，可以连接字符串等等。但是我们无法将两个table相加，无法对函数进行比较。

​		可以通过元表来修改一个值的行为，使其在面对一个非预定义的操作时执行一个指定的操作。例如，a和b都是table，通过元表可以定义如何计算表达式a+b。当试图将两个table相加的时候，它会检测两者之一是否有元表，然后检查该元表中是否有一个叫_add的字段。如果找到，就调用该字段对应的值。这个值就是所谓的元方法。

### 13.1 算术类的元方法

​		在元表中每种算数操作符都有对应的字段名:

``` lua
__add -- 对应加法
__sub -- 对应减法
__mul -- 对应乘法
__div -- 对应除法
__unm -- 对应取相反数
__mod -- 对应取模
__pow -- 对应乘幂
__concat -- 用于连接操作符的行为
```



### 13.2 关系类的元方法

``` lua
__eq -- 等于
__lt -- 小于
__le -- 小于等于
not(__eq) --不等于
```



### 13.3 库定义的元方法



### 13.4 table访问的元方法

#### 13.4.1 __index 元方法

​		若lua检测到w中没有某字段，但在其元表中却有一个__index字段,那么lua就会调用这个方法，然后元方法来索引原型table，并返回结果。

​		在lua中，将__index元方法用于继承是很普遍的方法，因此lua还提供了一种更便捷的方法来实现此功能。该元方法不一定是个函数，它还可以是一个table。当它是一个函数时，lua以table和不存在的key作为参数来调用该函数；当它是一个table时，lua就以相同的方式来重新访问这个table。

#### 13.4.2 __newindex元方法

​		__newIndex元方法与index类似，不同之处在于前者用于table的更新，后者用于table的查询。当对一个table中不存在的索引赋值时，解释器就会查找该元方法。

#### 13.4.3 具有默认值的table

​		常规table中的字段默认都是nil，通过元表就可以很容易的修改这个默认值：

``` lua
function setDefault(t, d)
    local mt = {__index = function() return d end}
    setmetatable(t, mt)
end

tab = {x = 10, y = 20}
print(tab.x, tab.z) -- 10 nil
setDefault(tab, 0)
print(tab.x, tab.z) -- 10 0
```



## [第十四章 环境](chapter-14.lua)



###  14.2 全局变量声明

​		lua中的全局变量不需要声明就可以使用，在大型程序中很容易出现变量名写错造成bug。由于lua将全局变量存放在一个普通的table中，可以通过元表来改变访问其全局变量时的行为。

``` lua
-- 一种是简单的检测所有对全局table中不存在的key的访问
setmetatable(_G, {
        __newindex = function(_,n)
            error("attempt to write undeclared variable" .. n, 2)
            end,
        __index = function(_, n)
            error("attempt to read undeclared variable" .. n, 2)
        end,
    })
```



###  14.3 非全局变量的声明

​		可以通过函数setfenv来改变一个函数的环境，该函数的参数是一个函数和一个新的环境table。第一个参数除了可以指定为函数本身，还可以指定为一个数字，以表示当前函数调用栈中的层数。数字1表示当前函数，数字2表示调用当前函数的函数，以此类推。

​		一旦改变了环境，所有的全局访问就都会使用心得table，比如print之类的函数，如果新的table是空的，那么print就会出错，所以要先将一些有用的值拷贝一份。

``` lua
a = 1
setfenv(1, {g = _G})
g.print(a)	--nil
g.print(g.a)	--1 a在原来的环境中声明，原来的环境被拷贝到了g中，现在切换了新的环境
				--所以要访问a要是g.a
```


​		在这段代码中新环境从原环境中继承了print和a，任何的赋值操作都在新环境，对原环境没有影响。

``` lua
a = 1
local newgt = {}
setmetatable(newgt, {__newindex = _G})
setfenv(1,newgt)
print(a)
```



## [第十五章 模块与包](chapter-15.lua)

​		lua可以通过require来使用模块，module来创建模块。

``` lua
require "mod"
mod.foo()
-- 还可以为模块设置一个局部名称
local m = require "mod"
m.foo()
-- 还可以为个别函数提供不同的名称
require "mod"
local f = mod.foo
f()
```

### 15.1 require函数

``` lua
function require(name)
    if not package.loaded[name] then
        local loader = findloader(name)
        if loader == nil then
            error("unable to load module" .. name)
        end
        package.loaded[name] = true
        local res = loader(name)
        if res ~= nil then
            package.loaded[name] = res
        end
    end
    return package.loaded[name]
end
```

​		如果require为指定模块找到了一个lua文件，那就通过loadfile来加载该文件。如果找到的是一个C程序库，就通过loadlib来加载。



### 15.2 编写模块的基本方法

​		在lua中创建一个模块最简单的方法是：创建一个table，将所有需要导出的函数放入其中，最后返回这个table。

``` lua
complex = {}

function complex.new (r, i)
    return {r = r, i = i}
end
-- 定义一个常量 'i'
complex.i = complex,new(0,1)

function complex.add (c1, c2)
	return complex.new(c1.r + c2.r, c1.i + c2.i)
end

function complex.sub (c1, c2)
    return complex.new(c1.r - c2.r, c1.i - c2.i)
end

function complex.mul (c1, c2)
    return complex.new(c1.r * c2.r - c1.i * c2.i, c1.r * c2.i + c1.i * c2.r)
end

local function inv (c)
    local n = c.r^2 + c.i^2
    return complex.new(c.r / n, -c.i / n)
end

function complex.div (c1, c2)
    return complex.new(c1, inv(c2))
end

return complex
```

​		上面的例子中没有提供与真正模板完全一致的功能性，必须要显示的将模块名放到每个函数的定义中，其次，一个函数在调用同一个模块中的另一个函数时，必须限制被调用函数的名称。可以使用一个固定的局部名称来定义和调用模块内的函数，然后将这个局部名称赋予模块最终的名称。

``` lua
local M = {}
complex = M -- 模块名

M.i = {r = 0, i = 1}

function M.new (r, i)
    return {r = r, i = i}
end

function M.add (c1, c2)
    return M.new(c1.r + c2.r, c1.i + c2.i)
end
-- <其余如上>
```

​		require函数会将模块名作为参数传给模块。

``` lua
local modname = ...
local M = {}
_G[modname] = M
```



### 15.3 使用环境

​		创建模块的基本方法缺点在于，他要求程序员在访问同一模块中其他公共实体时必须限定名称，并且只要一个函数的状态从私有变为公有就必须修改调用。另外在私有声明中也很容易忘记local关键字。

​		让模块的主程序独占一个环境，这样不仅它的所有函数都可以共享这个table，而且他的所有全局变量也都自动记录在这个table中，还可以将它所有的公有函数声明为全局变量。模块要做的就是将这个table赋予模块名和packag.loaded。

``` lua
local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] = M
setfenv(1, M)
--当声明函数add时，他就成为了complex.add
function add (c1, c2)
    return new(c1.r + c2.r, c1.i + c2.i)
end
```



###  15.4 module函数

​		在开始编写一个模块时，可以直接用module(...)代码来取代：

``` lua
local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] = M
	-- 其他
setfenv(1, M)
```

​		默认情况下，module不提供外部访问。必须在调用它之前，为需要访问的外部函数或模块声明适当的局部变量。也可以通过继承来实现外部访问，只需要在调用module时加一个选项package.seeall。其等价于：

```lua
-- module(..., package.seeall)
setmetatable(M, {__index = _G})
```



### 15.5 子模块与包



## [第十五章 面向对象编程](chapter-15.lua)

​		lua中的table就是一种对象，table与对象一样可以拥有状态，table也与对象一样拥有一个独立于其值的标识（一个self），table与对象一样具有独立于创建者和创建地的生命周期。