Quen = {}
local QUEN_MAX = 1024

function Quen.new_quen(quen)
    quen.first = 1
    quen.last = 0
end

function Quen.is_full(quen)
    local first = quen.first + 1
    local last = quen.last
    if (first > QUEN_MAX) then
        first = 1
    end
    if first == last then
        return true
    else
        return false
    end
end

function Quen.is_empty(quen)
    local first = quen.first
    local last = quen.last + 1
    if (last > QUEN_MAX) then
        last = 1
    end
    if last == first then
        return true
    else
        return false
    end
end

function Quen.in_quen(quen, value)
    local first = quen.first + 1
    if quen.is_full(quen) then
        print("Quen is full")
        return
    end
    if (first > QUEN_MAX) then
        first = 1
    end
    quen[quen.first] = value
    quen.first = first
end

function Quen.out_quen(quen)
    local last = quen.last + 1
    if quen.is_empty(quen) then
        print("Quen is empty")
        return
    end
    if (last > QUEN_MAX) then
        last = 1
    end
    quen.last = last
    return quen[quen.last]
end

--[[
Quen = Quen.new_quen(Quen)
for i = 1, 512 do
    Quen.in_quen(Quen, i)
end

for i = 1, 512 do
    print(Quen.out_quen(Quen))
end
--]]

f = io.open("test.txt","w")
if f == nil then
    error("open error")
else
    for i = 1, 512 * 1024 do
        f:write(string.format("%d,",i))
    end
end

f:close()

f = io.open("test.txt","r")
if f == nil then
    error("open error")
else
    local buff = ""
    for line in f:lines() do
        buff = buff .. line .. "\n"
    end
    print(buff)
end


