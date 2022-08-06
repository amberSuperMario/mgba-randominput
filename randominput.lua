local random_input = 0

function randomInput()
    random_input = math.random(0,7)
    if random_input == 2 then
        randomInput()
    end
end

local delay = 0

function updateBufferKeysRead()
    if delay == 20 then
        emu:addKey(random_input)
    end
    if delay == 22 then
        emu:clearKey(random_input)
        randomInput()
        delay = 0
    end
    delay = delay + 1
end

function updateBufferFrame()
end

callbacks:add("frame", randomInput)
callbacks:add("frame", updateBufferFrame)
callbacks:add("keysRead", updateBufferKeysRead)
