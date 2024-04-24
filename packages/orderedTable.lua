local orderedTable = {}

function orderedTable.new()
    local mt = { __metatable=nil }
    local this = {}

    local map = {}

	local function getIndex(index)

		for key, v in ipairs(map) do
            if v[1] == index then
                return key
            end
        end
	end

	function mt:__()
		
	end

    function mt:__index(index)
        
		local element = map[getIndex(index)]
        return element and element[2]
    end

    function mt:__newindex(self, index, value)

		local key = getIndex(index)
		if key then
			
			if value == nil then
				map[key] = nil
			else
				map[key][2] = value
			end
		else

			table.insert(map, {index, value})
		end
	end

	function this:sort(callback)
		
	end

	function this:every(callback)

		for k,v in this:iter() do
			if not callback(k, v) then
				return false
			end
		end
	end

	function this:filter(callback)

		local out = orderedTable.new()

		for k, v in this:iter() do
			if callback(k, v) then
				out[k] = v
			end
		end

		return out
	end

	function this:some(callback)

		for k,v in this:iter() do

			if callback(k,v) then
				return true
			end
		end

		return false
	end

	function this:random()
		if not this:next() then return end
		
		local choose = map[math.random(1, #map)]
		return table.unpack(choose)
	end

	function this:next(lastIndex)
		
		if not lastIndex then
			return map[1] and table.unpack(map[1])
			
		else
			local index = getIndex(lastIndex)
			if not index or not map[index + 1] then return end
			
			return table.unpack(map[index + 1])
		end
	end

    function this:iter()

        return coroutine.wrap(function()
            for _, value in ipairs(map) do
                coroutine.yield(value[1], value[2])
            end
        end)
    end

    return setmetatable(this, mt)
end

return orderedTable