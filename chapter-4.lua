-- 局部变量与块

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

-- if then else end
a = 10
b = 11
if a > b then
    return a
else
    return b
end

if op == "+" then
    return a + b
elseif op == "-" then
    return a - b
elseif op == "*" then
    return a * b
elseif op == "/" then
    return a / b
else
    error("invalid operation")
end
-- while

local i = 1
while i < 10 do
    print(i)
    i = i + 1
end

-- repeat

repeat
    line = io.read()
until line ~= ""
print(line)

-- for

--[[
--for var = exp1,exp2,exp3 do
-- ....
-- end
-- exp1 初始值，exp2 结束值，exp3 步进值
--]]
a = {}
for i = 1, 10, 1 do
    print(i)
    a[i] = i^2
end
--泛型for循环
for i,v in ipairs(a) do
    print(i .. ":" .. v)
end

-- break 和 return

function test()
    local i = 1
    while a[i] do
        if a[i] == v then break end
        i = i + 1
    end
    return i
end


