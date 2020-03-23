-- 协同程序
co = coroutine.create(function () print("hi") end)
print(co)
print(coroutine.status(co))
coroutine.resume(co)

f = function ()
    for i = 1, 10 do
        print("co", i)
        coroutine.yield()
    end
end

co = coroutine.create(f)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
