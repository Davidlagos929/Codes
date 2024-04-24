local rawtable = table
local table = setmetatable({}, { __index=rawtable, 
    __newindex = function(self, key, value)
        _G.table[key] = value
    end
})

table.split = function(str, sep)

    local out = {}

    if not sep then
        for letter in str:gmatch(".") do
            table.insert(out, letter)
        end
    else
        for s in str:gmatch("([^"..sep .."]+)") do
            table.insert(out, s)
        end
    end

    return out
end

table.unpack = function(...)
	local out = {}
    for _, t in ipairs({...}) do
        for _, value in ipairs(t) do

            table.insert(out, value)
        end
    end
    
    return out
end

table.reverse = function(tbl)

    local out = {}
    for i = #tbl, 1, -1 do
        table.insert(out, tbl[i])
    end
    return out
end

table.find = function(tbl, value)
	for index, v in ipairs(tbl) do
        if value == v then
            return index
        end
    end
end

return table