print(type("hello world")) -- string
print(type(10))            -- number
print(type(1.2345))        -- number
print(type(print))         -- function
print(type(true))          -- boolean
print(type(nil))           -- nil
print(type(type(10)))      -- string
print(type({}))            -- table
if 0 then 
    print("0 is true")
else
    print("0 is false")
end
if "" then
    print("\"\" is true")
else
    print("\"\" is false")
end
--[==[
使用[[  ]]来界定一个字符串
--]==]
a = [[
<html>
<head>
<title>an html</title>
</head>
<body>
hello world
</body>
</html>
]]
print(a)

-- 字符串连接
print("10" + 1)
print(123 .. "abc")

-- 表
function table_len(m_table)
    local len = 0
    for k,v in pairs(m_table) do
        if len < k then
            len = k
        end
    end
    return len
end

a = {}

a[1] = 1
a[1000] = 2
print(#a)
print(table_len(a))
