local stdio = require("@lune/stdio")

local dealer = {
    cards = 0,
    count = 0
}
local player = {
    cards = 0,
    count = 0
}

local inGame = true

local function colorString(str, color)
    return stdio.color(color) .. str .. stdio.color("reset")
end

function giveCard(to, amount)

    amount = amount or 1
    to.cards += amount
    for i = 1, amount do
        to.count += math.random(1, 10)
    end
end

function drawGame()
    print(`Your Cards: {player.cards}\t`, `Dealer Cards: {dealer.cards}`)
    print(`Total: {player.count}\n`)
end

local function stay()

    local win = colorString("You Win!", "green")
    local lose = colorString("You Lose!", "red")
    local tie = colorString("Tie!", "blue")

    local message = ""
    if dealer.count > 21 then
        message = win
    elseif player.count > 21 then
        message = lose
    elseif player.count == dealer.count then
        message = tie
    elseif player.count > dealer.count then
        message = win
    else
        message = lose
    end

    print(`You: {player.count}\t`, `Dealer: {dealer.count}\n`)
    print(message)

    local answer = stdio.prompt("confirm", "Play again?")
    if answer then
        setup()
    else
        inGame = false
    end
end

--// Init
function setup()

    dealer = {
        cards = 0,
        count = 0
    }
    player = {
        cards = 0,
        count = 0
    }    

    giveCard(player, 2)
    while dealer.count < 17 do
        giveCard(dealer)
    end
end

setup()

while inGame do

    drawGame()
    local action = stdio.prompt("select", "What you choose?", {"Hit", "Stay"})

    if action == 1 and player.cards < 21 then
        giveCard(player)
        if player.count >= 21 then
            stay()
        end
    else 
        stay()
    end
end