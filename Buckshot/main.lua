local stdio = require("@lune/stdio")
local task = require("@lune/task")

local bullets = 5

local playerLife = 5
local aiLife = 5

local bulletIn = math.random(1, bullets)
local shoots = 0

local log = "..."

local function colorString(str, color)
    return stdio.color(color) .. str .. stdio.color("reset")
end

local function drawGame()
    stdio.write("\x1b[2J\x1b[H")-- cls
    
    print(`You: {colorString(("#"):rep(playerLife), "red")}`, 
    `AI: {colorString(("#"):rep(aiLife), "red")}`) -- show lifes
    
    print(`\n{log}`) -- show log
    
    print(`\nBullets: {bullets - shoots}\n`) -- show bullets in gun
end

--// return boolean if is true
local function shoot()

    shoots += 1
    if shoots == bulletIn then --// reset bullets
        shoots = 0
        bulletIn = math.random(1, bullets)
        return true 
    end

    return false
end

function player()

    local answer = stdio.prompt("select", "What action you choose?", {"Shoot yourself", "Shoot him"})
    if answer == 1 then
        log = "Player shot himself..."
        if shoot() then
            log ..= "bang!"
            playerLife -= 1
            return false
        end
        log ..= "nothing."
    else
        log = "Player shot AI..."
        if shoot() then
            log ..= "bang!"
            aiLife -= 1
        else
            log ..= "nothing."
        end

        return false
    end

    return true
end

function ai()
    local choose = math.random(1, 2)

    --> shot player if have one bullet
    if shoots == bullets-1 then choose = 2 end

    if choose == 1 then
        log = "AI shot himself..."
        if shoot() then
            log ..= "bang!"
            aiLife -= 1
            return false
        end
        log ..= "nothing."
    else
        log = "AI shot player..."
        if shoot() then

            log ..= "bang!"
            playerLife -= 1
        else
            log ..= "nothing."
        end

        return false
    end

    return true
end

local turn = "player"
while playerLife ~= 0 and aiLife ~= 0 do
    drawGame()

    --// if player() or ai() return true, don't change the turn
    if turn == "player" then
        if not player() then turn = "ai" end
    else
        task.wait(2)
        if not ai() then turn = "player" end
    end
end

drawGame()
if playerLife == 0 then
    print(colorString("You lose!", "red"))
else
    print(colorString("You Win!", "green"))
end