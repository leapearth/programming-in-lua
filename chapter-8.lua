-- dofile
dofile("test.lua")
function dofile(filename)
    f = assert(loadfile(filename))
    return f()
end
dofile("test.lua")
-- loadfile
f = loadfile("test.lua")
if f ~= nil then
    f()
end
