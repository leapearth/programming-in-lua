for v in pairs(_G) do 
    print(v)
end

setmetatable(_G, {
        __newindex = function(_,n)
            error("attempt to write undeclared variable" .. n, 2)
            end,
        __index = function(_, n)
            error("attempt to read undeclared variable" .. n, 2)
        end,
    })

--print(a)

--x = 10

local y = 20
