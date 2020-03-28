function printf(fmt,...)
    return io.write(string.format(fmt,...))
end

local count = 0
printf("count:%d\n",count)
