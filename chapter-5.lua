function inc_count(n)
    n = n or 1
    count = count + n
end
-- 多重返回值
s, e = string.find("hello lua users", "lua")
print(s, e) -- 7, 9

function maxmin(a)
    local max = 1
    local min = math.huge
    for i,val in ipairs(a) do
        if val > max then
            max = val
        elseif val < min then
            min = val
        end
    end
    return max,min
end

a = {1,4,5,2,3,6,7,8,9,45,76,33,2,5,345,5345}
print(maxmin(a))

function foo0() end
function foo1() return "a" end
function foo2() return "a", "b" end

x, y, z = 10, foo2() -- x = 10 y = "a" z = "b"
print(x,y,z)
x, y, z = foo2(), 10 -- x = "a" y = 10 z = nil
print(x,y,z)

--边长参数

function printf(fmt,...)
    return io.write(string.format(fmt,...))
end

i = 10
j = 10.1
s = "hello"
printf("test printf:%d,%.2f,%s\n",i,j,s)

-- select
function test(...)
    for i,v in ipairs{...} do
        print(v)
    end
end

function select_test(...)
    for i = 1, select('#', ...) do
        local arg = select(i, ...)
        print(arg)
    end
end

select_test("select_test",1,2,4,nil,5,6)
test("test",1,2,4,nil,5,6)
