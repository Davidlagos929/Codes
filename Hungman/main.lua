local stdio = require("@lune/stdio")

local game = {}
local life = 5

local function split(str)
    local out = {}
    for word in str:gmatch(".") do
        table.insert(out, word)
    end
    return out
end

local function drawGame()
    print(`life: {life}`)
    print(table.concat(game, " "))
end

local function checkGame()
    for _, v in game do
        if v == "_" then return false end
    end
    return true
end

--// Init

while true do

    local word = stdio.prompt("text", "What's the word?")
    local letters = split(word)

    for i = 1, #word do game[i] = letters[i] == " " and " " or "_" end

    while not checkGame() and life ~= 0 do

        drawGame()
        local requestLetter = stdio.prompt("text", "Choose a letter:")

        local found = false
        for index, letter in letters do

            if letter:lower() ~= requestLetter:lower() then continue end

            game[index] = letter
            found = true
        end

        if not found then life -= 1 end
    end

    --// End
    drawGame()
    
    if not stdio.prompt("confirm", "Play again?") then
        break
    end
end
