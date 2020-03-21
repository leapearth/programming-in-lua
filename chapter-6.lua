-- 闭合函数
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

function newCounter()
    local i = 0
    return function()
        i = i + 1
        return i
    end
end

c1 = newCounter()
c2 = newCounter()
print(c1())
print(c1())
print(c2())
print(c2())

-- 非全局函数
--[[
local fact = function(n)
    if n == 0 then
        return 1
    else
        return n * fact(n - 1) -- 错误，尝试访问一个全局变量fact，fact为nil
    end
end
print(fact(5))
--]]
local fact
fact = function(n)
    if n == 0 then 
        return 1
    else
        return n * fact(n - 1)
    end
end
print(fact(5))



