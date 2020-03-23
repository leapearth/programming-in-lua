-- 数据描述

function printf(fmt, ...)
    return io.write(string.format(fmt, ...))
end

function write_header()
    io.write([[
    <html>
        <head>
            <title>Project using Lua</title>
        </head>
        <body bgcolor="#FFFFFF">
            Here are brief descriptions of some projects around the
            world that use <a href="home.html">Lua</a>
            <br>
    ]])
end

function list_title(title_table)
    count = count + 1
    local title = title_table.title or 'no title'
    printf('<li><a href="#%d">%s</a>\n', count, title)
end

function list_brief(brief_table)
    count = count + 1
    printf('<hr>\n<h3>\n')
    local href = brief_table.url and string.format('href="%s"', brief_table.url) or ''
    printf('<a name="%d"%s>%s</a>\n', count, href, title)
    if brief_table.title and brief_table.org then
        printf('<br>\n<small><em>%s</em></small>', brief_table.org)
    end
    printf('\n</h3>\n')
    if brief_table.description then
        printf('%s<p>\n',
            string.gsub(brief_table.description, '\n\n+', '<p>\n'))
    end
    if brief_table.email then
        printf('Contact: <a href="mailto:%s">%s</a>\n',brief_table.email,
        brief_table.contact or brief_table.email)
    elseif brief_table.contact then
        printf('Contact:%s\n',brief_table.contact)
    end
end

function write_tail()
    printf('</body></html>\n')
end

function data_desc()
    local inputfile = 'db.lua'
    write_header()
    
    count = 0
    f = loadfile(inputfile)
    if f ~= nil then
        entry = list_title
        printf('<ul>\n')
        f()
        printf('</ul>\n')
    
        count = 0
        entry = list_brief
        f()
        write_tail()
    else
        printf("open file %s failed\n", inputfile)
    end
end    

--data_desc()

--马尔科夫链算法

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

function prefix (w1, w2)
    return w1 .. " " .. w2
end

local state_table = {}

function insert(index, value)
    local list = state_table[index]
    if list == nil then
        state_table[index] = {value}
    else
        list[#list + 1] = value
    end
end

local N = 2
local MAXGEN = 10000
local NOWORD = "\n"
-- 构建table
local w1, w2 = NOWORD, NOWORD
for w in allwords("test.txt") do
    insert(prefix(w1, w2), w)
    w1 = w2
    w2 = w
end
insert(prefix(w1, w2), NOWORD)

--生成文本
w1 = NOWORD
w2 = NOWORD
for i = 1, MAXGEN do
    local list = state_table[prefix(w1, w2)]
    local r = math.random(#list)
    local next_word = list[r]
    if next_word == NOWORD then 
        return
    end
    printf("%s ", next_word)
    --io.write(next_word, " ")
    w1 = w2
    w2 = next_word
end

-- TODO 实现中文版本
