local stdio = require("@lune/stdio")
local table = require("../packages/extensions.lua")

print(stdio.format(table))

local up_x_1 = {0, 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 18, 19, 20, 27, 28, 29, 36, 37, 38}
local up_x_2 = {2, 5, 8, 1, 7, 0, 3, 6, 36, 37, 38, 9, 10, 11, 18, 19, 20, 27, 28, 29}

local md_x_1 = {12, 13, 14, 21, 22, 23, 30, 31, 32, 39, 40, 41}
local md_x_2 = {39, 40, 41, 12, 13, 14, 21, 22, 23, 30, 31, 32}

local dw_x_1 = {15, 16, 17, 24, 25, 26, 33, 34, 35, 42, 43, 44, 45, 46, 47, 48, 50, 51, 52, 53}
local dw_x_2 = {42, 43, 44, 15, 16, 17, 24, 25, 26, 33, 34, 35, 51, 48, 45, 52, 46, 53, 50, 47}

local le_y_1 = {0, 3, 6, 9, 12, 15, 29, 32, 35, 36, 37, 38, 39, 41, 42, 43, 44, 51, 52, 53}
local le_y_2 = {9, 12, 15, 51, 52, 53, 6, 3, 0, 38, 41, 44, 37, 43, 36, 39, 42, 35, 32, 29}

local md_y_1 = {1, 4, 7, 10, 13, 16, 28, 31, 34, 48, 49, 50}
local md_y_2 = {10, 13, 16, 48, 49, 50, 7, 4, 1, 34, 31, 28}

local ri_y_1 = {2, 5, 8, 11, 14, 17, 18, 19, 20, 21, 23, 24, 25, 26, 27, 30, 33, 45, 46, 47}
local ri_y_2 = {11, 14, 17, 45, 46, 47, 24, 21, 18, 25, 19, 26, 23, 20, 8, 5, 2, 33, 30, 27}

local le_z_1 = {6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 21, 24, 38, 41, 44, 45, 48, 51}
local le_z_2 = {18, 21, 24, 11, 14, 17, 10, 16, 9, 12, 15, 45, 48, 51, 8, 7, 6, 44, 41, 38}

local md_z_1 = {3, 4, 5, 19, 22, 25, 37, 40, 43, 46, 49, 52}
local md_z_2 = {19, 22, 25, 46, 49, 52, 5, 4, 3, 43, 40, 37}

local ri_z_1 = {0, 1, 2, 20, 23, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 39, 42, 47, 50, 53}
local ri_z_2 = {20, 23, 26, 47, 50, 53, 33, 30, 27, 34, 28, 35, 32, 29, 2, 1, 0, 42, 39, 36}

local keys_moves = {
    "l",
    "l'",
    "r'",
    "r",
    "f",
    "f'",
    "b'",
    "b",
    "u",
    "u'",
    "d'",
    "d",
}

local keys = {
    ["l"] = {le_y_1, le_y_2},
    ["r"] = {ri_y_2, ri_y_1},
    ["f"] = {le_z_1, le_z_2},
    ["b"] = {ri_z_2, ri_z_1},
    ["u"] = {up_x_1, up_x_2},
    ["d"] = {dw_x_2, dw_x_1},
    ["m"] = {md_y_1, md_y_2},
    ["s"] = {md_z_1, md_z_2},
    ["e"] = {md_x_1, md_x_2},
    ["rw"] = {table.unpack(ri_y_2, md_y_2), table.unpack(ri_y_1, md_y_1)},
    ["lw"] = {table.unpack(le_y_1, md_y_1), table.unpack(le_y_2, md_y_2)},
    ["fw"] = {table.unpack(le_z_1, md_z_1), table.unpack(le_z_2, md_z_2)},
    ["bw"] = {table.unpack(ri_z_2, md_z_1), table.unpack(ri_z_1, md_z_2)},
    ["uw"] = {table.unpack(up_x_1, md_x_1), table.unpack(up_x_2, md_x_2)},
    ["dw"] = {table.unpack(dw_x_2, md_x_1), table.unpack(dw_x_1, md_x_2)},
    ["x"] = {table.unpack(le_y_2, md_y_2, ri_y_2), table.unpack(le_y_1, md_y_1, ri_y_1)},
    ["z"] = {table.unpack(le_z_1, md_z_1, ri_z_1), table.unpack(le_z_2, md_z_2, ri_z_2)},
    ["y"] = {table.unpack(up_x_1, md_x_1, dw_x_1), table.unpack(up_x_2, md_x_2, dw_x_2)},
}

-----------------------

local function parse(input)
	local tokens = table.split(input)
	
	local out = {}
	for k, letter in ipairs(tokens) do
        
        local old = out[#out]
		local move = {}

		if letter == "'" then
			if old then
				old.reverse = true
			end
		elseif letter == "2" then
			if old then
				table.insert(out, old)
			end
        elseif letter == "w" then
            if old and not old.key:match("w") then
				old.key = old.key .. "w"
			end
		else
            if keys[letter] then
			    move.key = letter
            end
		end

        if move.key then
            table.insert(out, move)
        end
	end

    for _, move in ipairs(out) do
        
        move.rot = keys[move.key]
        if move.reverse then
            move.rot = table.reverse(move.rot)
        end
    end
	
	return out
end

local colors = {
    [0] = " ",
    [1] = "\27[31m#\27[0m",
    [2] = "\27[34mO\27[0m",
    [3] = "\27[33m%\27[0m",
    [4] = "\27[32m@\27[0m",
    [5] = "\27[93m.\27[0m",
}

local a = {}
for f = 0, 5 do
    for x = 0, 8 do
       local res = f * 9 + x
        a[res] = colors[f]
    end
end

function rotate(move)
    local r1 = move.rot[1]
    local r2 = move.rot[2]

    local l = {}
    for r = 1, #r1 do
        l[r] = a[r1[r]]
    end
    for r = 1, #r2 do
        a[r2[r]] = l[r]
    end
end

function checkCube()
    for f = 0, 45, 9 do
        local res = f + 1
        local res2 = f + 8
        for n = res, res2 do
            if a[f] ~= a[n] then
               return false
            end
        end
    end

    return true
end

local function clear()
    stdio.write("\x1b[2J\x1b[H")
end
-----------------------

print("Scrambling...")
for _ = 0, 100 do
    local move = parse(keys_moves[math.random(1, 12)])[1]
    rotate(move)
end

local count = 0
local moves = {}

while true do

    clear()
    do
        print("         /\\")
        print("        /" .. a[0] .. a[0] .. "\\")
        print("       /" .. a[0] .. a[0] .. a[0] .. a[0] .. "\\")
        print("      /\\" .. a[0] .. a[0] .. a[0] .. a[0] .. "/\\")
        print("     /" .. a[3] .. a[3] .. "\\" .. a[0] .. a[0] .. "/" .. a[1] .. a[1] .. "\\")
        print("    /" .. a[3] .. a[3] .. a[3] .. a[3] .. "\\/" .. a[1] .. a[1] .. a[1] .. a[1] .. "\\       Moves: " .. count)
        print("   /\\" .. a[3] .. a[3] .. a[3] .. a[3] .. "/\\" .. a[1] .. a[1] .. a[1] .. a[1] .. "/\\      +---------------------+")
        print("  /" .. a[6] .. a[6] .. "\\" .. a[3] .. a[3] .. "/" .. a[4] .. a[4] .. "\\" .. a[1] .. a[1] .. "/" .. a[2] .. a[2] .. "\\     |      Controls:      |")
        print(" /" .. a[6] .. a[6] .. a[6] .. a[6] .. "\\/" .. a[4] .. a[4] .. a[4] .. a[4] .. "\\/" .. a[2] .. a[2] .. a[2] .. a[2] .. "\\    +----------+----------+")
        print("|" .. a[6] .. a[6] .. a[6] .. a[6] .. a[6] .. "/\\" .. a[4] .. a[4] .. a[4] .. a[4] .. "/\\" .. a[2] .. a[2] .. a[2] .. a[2] .. a[2] .. "|   |  MOVES:  |  ROTATE: |")
        print("|\\" .. a[6] .. a[6] .. a[6] .. "/" .. a[7] .. a[7] .. "\\" .. a[4] .. a[4] .. "/"..a[5] .. a[5] .. "\\" .. a[2] .. a[2] .. a[2] .. "/|   |  U   M   |  x       |")
        print("|" .. a[9] .. "\\" .. a[6] .. "/" .. a[7] .. a[7] .. a[7] .. a[7] .. "\\/" .. a[5] .. a[5] .. a[5] .. a[5] .. "\\".. a[2] .."/" .. a[20] .. "|   |  U'  M'  |  x'      |")
        print("|" .. a[9] .. a[9] .. "\\" .. a[7] .. a[7] .. a[7] .. a[7] .. a[7] .. "/\\" .. a[5] .. a[5] .. a[5] .. a[5] .. a[5] .. "/" .. a[20] .. a[20] .. "|   |  D       |  y       |")
        print("|" .. a[9] .. a[9] .. "|\\" .. a[7] .. a[7] .. a[7] .. "/" .. a[8] .. a[8] .. "\\" .. a[5] .. a[5] .. a[5] .. "/|" .. a[20] .. a[20] .. "|   |  D'      |  y'      |")
        print("|\\" .. a[9] .. "|" .. a[10] .. "\\" ..a[7] .. "/" .. a[8] .. a[8] .. a[8] .. a[8] .. "\\".. a[5] .."/" .. a[19] .. "|" .. a[20] .. "/|   |  R       |          |")
        print("|" .. a[12] .. "\\|" .. a[10] .. a[10] .. "\\" .. a[8] .. a[8] .. a[8] .. a[8] .. a[8] .. a[8] .. "/" .. a[19] .. a[19] .. "|/" .. a[23] .. "|   |  R'      |          |")
        print("|" .. a[12] .. a[12] .. "\\" .. a[10] .. a[10] .. "|\\" .. a[8] .. a[8] .. a[8] .. a[8] .. "/|" .. a[19] .. a[19] .. "/" .. a[23] .. a[23] .. "|   |  L       +----------+")
        print("|" .. a[12] .. a[12] .. "|" .. "\\" .. a[10] .. "|".. a[11] .."\\".. a[8] .. a[8] .. "/" .. a[18] .. "|" .. a[19] .. "/|" .. a[23] .. a[23] .. "|   |  L'      |  EXIT:   |")
        print("|" .. a[12] .. a[12] .. "|" .. a[13] .. "\\|" .. a[11] .. a[11] .. "\\/" .. a[18] .. a[18] .. "|/" .. a[22] .. "|" .. a[23] .. a[23] .. "|   |  F       |  Type    |")
        print("|\\" .. a[12] .. "|" .. a[13] .. a[13] .. "\\" .. a[11] .. a[11] .. "||" .. a[18] .. a[18] .. "/" .. a[22] .. a[22] .. "|" .. a[23] .. "/|   |  F'      |  \"exit\". |")
        print("|" .. a[15] .. "\\|" .. a[13] .. a[13] .. "|\\" .. a[11] .. "||" .. a[18] .. "/|" .. a[22] .. a[22] .. "|/" .. a[26] .. "|   |  B       |          |")
        print("|" .. a[15] .. a[15] .. "\\" .. a[13] .. a[13] .. "|" .. a[14] .. "\\||/" .. a[21] .. "|" .. a[22] .. a[22] .. "/" .. a[26] .. a[26] .. "|   |  B'      |          |")
        print("|" .. a[15] .. a[15] .. "|\\" .. a[13] .. "|" .. a[14] .. a[14] .. "||" .. a[21] .. a[21] .. "|" .. a[22] .. "/|" .. a[26] .. a[26] .. "|   +----------+----------+")
        print(" \\" .. a[15] .. "|" .. a[16] .. "\\|" .. a[14] .. a[14] .. "||" .. a[21] .. a[21] .. "|/" .. a[25] .. "|" .. a[26] .. "/")
        print("  \\|" .. a[16] .. a[16] .. "\\" .. a[14] .. a[14] .. "||" .. a[21] .. a[21] .. "/" .. a[25] .. a[25] .. "|/")
        print("   \\" .. a[16] .. a[16] .. "|\\" .. a[14] .. "||" .. a[21] .. "/|" .. a[25] .. a[25] .. "/")
        print("    \\" .. a[16] .. "|" .. a[17] .. "\\||/" .. a[24] .. "|" .. a[25] .. "/")
        print("     \\|" .. a[17] .. a[17] .. "||" .. a[24] .. a[24] .. "|/")
        print("      \\" .. a[17] .. a[17] .. "||" .. a[24] .. a[24] .. "/")
        print("       \\" .. a[17] .. "||" .. a[24] .. "/")
        print("        \\||\n")
    end

    --// Input
    local answer = ""
    if next(moves) then
        table.remove(moves, 1)
    else
        answer = stdio.prompt('text', "Enter command:"):lower()
        moves = parse(answer)
    end

    if answer == "exit" then
        break
    end
    
    local move = moves[1]
    if move then
    
        rotate(move)
        
        count += 1
        
        if checkCube() then
            break
        end
    end
end

clear()
if checkCube() then
    print("You won^^! Congratulations^^!")
    print("You solved the cube in " .. count .. " moves.")
else
    print("You don't complete the cube!")
end
