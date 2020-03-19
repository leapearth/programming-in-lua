-- 开始
print("hello world")

function fact(n)
    if n == 0 then
        return 1
    else
        return n*fact(n-1)
    end
end

print("enter a number:")
a = io.read("*number")
print(fact(a))

-- 1.1 程序块
--[[
--使用-i参数来启动Lua解释器，解释器会在完成指定
--程序块后进入交互模式
--  % lua -i 1-start.lua
--]]

function norm(x,y)
    return (x^2 + y^2)^0.5
end

function twice(x)
    return 2 * x
end

--[[
--交互模式使用dofile()函数加载1-start.lua
--]]

-- 1.2 词法规范
And = 10
AND = 12
print(And)
print(AND)

-- 1.3 全局变量

print(b)
a = 3
print(a)
a = nil
print(a)

-- 1.4 解释器程序

for i = 0, #arg  do
    print(arg[i])
end

