local stdio = require("@lune/stdio")

local win = 0
local lose = 0

local function drawGame()
    stdio.write("\x1b[2J\x1b[H")
    print(`Win: {win}\tLose: {lose}`)
end

local message = "..."

local nameList = {
    [1] = "Rock",
    [2] = "Paper",
    [3] = "Scissors",
}
local function check(t1, t2)

    message = `{nameList[t1]} vs {nameList[t2]}`
    if (t1 == 1 and t2 == 3) or (t1 == 2 and t2 == 1) or (t1 == 3 and t2 == 2) then
        win += 1
        message ..= "...Win!"
    else
        if t1 ~= t2 then
            lose += 1
            message ..= "...Lose!"
        else
            message ..= "...Tie!"
        end
    end
end

while true do
    drawGame()
    print(`\n{message}\n`)
    local choice = stdio.prompt("select", "What's your choice?", {"Rock", "Paper", "Scissors"})
    local IA = math.random(1, 3)

    check(choice, IA)

    if win == 5 or lose == 5 then
        drawGame()
        print(win == 5 and "You win!" or "You lose!")

        if stdio.prompt("confirm", "Play again?") then 
            win = 0
            lose = 0
        else
            break
        end
    end
end