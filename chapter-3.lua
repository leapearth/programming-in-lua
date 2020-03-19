-- 算数操作符
a = 3
b = a + 1
print(b)

b = 1234
c = b % a
print(c)
c = b - math.floor(b / a) * a
print(c)

-- 关系操作符
a = 1
b = 2
if a ~= b then
    print("a not euqal b")
end

-- 逻辑操作符
--[[
--and 和 or都是用短路求值，即只会在需要的时候才会去评估第二个操作数。
--]]

-- 在x为nil或者false的时候，将x设为一个默认值。
x = x or 1
x = nil
if not x then 
    x = 1
end
-- (a and b) or c 类似于c语言中的a？b:c
x = 2
y = 3
max = (x > y) and x or y

-- table constructor

days = {"Sun","Mon","Tue","Wed","Thur","Fri","Sat"}
print(days[4])
a = {x = 10, y = 12}
for k,v in pairs(a) do
    print(k..":" .. v)
end
a = {}
a.x = 10
a.y = 12

for k,v in pairs(a) do
    print(k..":" .. v)
end

polyline = {color="blue",thickness=2,points=4,
            {x=0,y=10},{x=12,y=11},{x=15,y=16},{x=-10,y=-1}}

print(polyline[1].x .. "," ..polyline[1].y)
print(polyline[4].x .."," ..polyline[4].y)
