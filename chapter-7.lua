--迭代器

----[[
function allwords(filename)
    local file = io.open(filename, "r")
    local line = file:read()
    --print(line)
    local pos = 1
    return function ()
        while line do
            local s, e = string.find(line,"%w+",pos)
            if s then
                pos = e + 1
                return string.sub(line, s, e)
            else
                line = file:read()
                --print(line)
                pos = 1
            end
        end
        return nil
    end
end


for word in allwords("./chapter-7.lua") do
    print(word)
end
--]]
--
local s = [[
local s = "\nare you ok!\n OK\n"
local t = {}
local i = 0
while true do
    i = string.find(s,"\n",i+1)
    if i == nil then break end
    table.insert(t,i)   
end

for k,v in pairs(t) do
    print(k,"->",v)  
end
]]

local pos = 1;
while true do
    local s,e = string.find(s, "%w+", pos)
    if s then
        pos = e + 1
        print(s .. "," .. e)
        
    else
        break
    end
end

t = {[1] = "test1", [4] = "test2", [3] = "test3"}
for k,v in next,t do
    print(k ..","..v)
end

