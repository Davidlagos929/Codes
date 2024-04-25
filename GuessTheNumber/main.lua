local stdio = require("@lune/stdio")

local life = 10

while true do
    local random = math.random(0, 100)
    stdio.write("\x1b[2J\x1b[H")
    
    print("The number is between 0 and 100!")

    for i = 1, 10 do

        local answer
        
        repeat
            answer = tonumber(stdio.prompt("text", `What's the number? (life: {life})`))
        until answer ~= nil

        if answer == random then
            print "You got the number right!"
            break
        else
            life -= 1
            if life == 0 then
                print "You lose!"
                break
            end

            if answer < random then
                print("Bigger!")
            else
                print("Smaller!")
            end
        end
    end

    if not stdio.prompt("confirm", "Play again?") then
        break
    end
end