local delay = 0
local random_input = 0
local wait_time = 0
local hold_time = 0
local max_wait_time = 60 --The script randomly decides how long to wait before pressing a button, between 1 frame and the number of frames listed here
local max_hold_time = 180 --Same as above but for how long the button is held

math.randomseed(os.time())
math.random() --Seed the script so the same inputs don't happen every time

function randomInput()
    random_input = math.random(0,7) --Currently excluding 8 and 9 to disable triggers, see "Constants" @ https://mgba.io/docs/scripting.html
    if random_input == 2 then --Skips Select inputs
        randomInput()
    end
end

function waitTime()
    wait_time = math.random(1,max_wait_time) --How long to wait before pressing a button, in frames
end

function holdTime()
    hold_time = wait_time + math.random(1,max_hold_time) --How long to hold a button before releasing it, in frames
end

function updateBufferKeysRead()
    if delay == wait_time then
        emu:addKey(random_input)
    end
    if delay == hold_time then
        emu:clearKey(random_input)
        randomInput()
        delay = 0
    end
    if delay == 0 then
    waitTime()
    holdTime()
    end
    delay = delay + 1
end

function updateBufferFrame()
end

callbacks:add("frame", updateBufferFrame)
callbacks:add("keysRead", updateBufferKeysRead)
