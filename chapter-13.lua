a = 10
print(getmetatable(a))
a = true
print(getmetatable(a))
a = "test"
print(getmetatable(a)) --只有string有元表

t = {1,2,34,5,"123",'1235435345',"test"}
print(getmetatable(t))
t_meta_table = {}
setmetatable(t, t_meta_table)
print(getmetatable(t))


Set = {}
local mt = {} -- 元表
function Set.new (l)
    local set = {}
    setmetatable(set, mt)
    mt.__add = Set.union -- 设置元方法
    mt.__mul = Set.intersection
    for _,v in ipairs(l) do
        set[v] = true
    end
    return set
end

function Set.union(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = true 
    end
    for k in pairs(b) do
        res[k] = true
    end
    return res
end

function Set.intersection(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ", ") .. "}"
end

function Set.print(s)
    print(Set.tostring(s))
end

a = Set.new{1,2,3,46,9,6,4,2,5,6,3,0,5,6,78,9}
b = Set.new{1,2,6,7,8,9,0,4,3,2,4,5,6,7,8,9,9,5,3}
c = Set.union(a,b)
Set.print(c)
d = a + b
Set.print(d)
e = a * b
Set.print(e)
f = Set.intersection(a,b)
Set.print(f)

local meta_table = {}
local tab = {}
meta_table.__index = function(t, k)
    print("__index")
    return tab[k]
end
meta_table.__newindex = function(t, k, v)
    print("__newindex")
    tab[k] = v
end
test = {}
setmetatable(test,meta_table)

test[2] = 'a'
test[3] = "asdasd"
print(test[3])

Window = {}
Window.prototype = {
    x = 0, y = 0,
    width = 100, height = 100
}
Window.mt = {}
function Window.new (o)
    setmetatable(o, Window.mt)
    return o
end
--[[
Window.mt.__index = function(table, key)
    return Window.prototype[key]
end
--]]
Window.mt.__index = Window.prototype
w = Window.new{x = 10, y = 20}
print(w.width)


