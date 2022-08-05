local random_input = 0

function randomInput()
    random_input = math.random(0,7)
    if random_input == 2 then
        randomInput()
    end
end

local delay = 0

function updateBuffer()
    if delay == 40 then
        emu:addKey(random_input)
    end
    if delay == 44 then
        emu:clearKey(random_input)
        randomInput()
        delay = 0
    end
    delay = delay + 1
end

callbacks:add("frame", randomInput)
callbacks:add("frame", updateBuffer)
callbacks:add("keysRead", updateBuffer)
