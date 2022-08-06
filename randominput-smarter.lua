--Variables and functions are prefaced with the set of buttons they affect. f = face buttons, d = d-pad

local f_delay = 0
local f_random_input = 0
local f_wait_time = 0
local f_hold_time = 0
local start_chance = 0

local f_max_wait_time = 60 --The script randomly decides how long to wait before pressing a button, between 1 frame and the number of frames listed here
local f_max_hold_time = 180 --Same as above but for how long the button is held

local d_delay = 0
local d_random_input = 0
local d_wait_time = 0
local d_hold_time = 0

local d_max_wait_time = 60
local d_max_hold_time = 180

math.randomseed(os.time())
math.random() --Seed the script so the same inputs don't happen every time

function fRandomInput()
    f_random_input = math.random(0,3) --See "Constants" @ https://mgba.io/docs/scripting.html
    if f_random_input == 2 then --Skips Select inputs
        fRandomInput()
    end
    if f_random_input == 3 then
        start_chance = math.random(0,99) --When fRandomInput attempts to push Start, the input will only succeed 1/10 times. If it fails, fRandomInput is called again. This is to prevent the bot from frequently pausing
        if start_chance <= 9 then
            f_random_input = 3
        else
            fRandomInput()
        end
    end
end

function fWaitTime()
    f_wait_time = math.random(1,f_max_wait_time) --How long to wait before pressing a button, in frames
end

function fHoldTime()
    f_hold_time = f_wait_time + math.random(1,f_max_hold_time) --How long to hold a button before releasing it, in frames
end

function fUpdateBufferKeysRead()
    if f_delay == f_wait_time then
        emu:addKey(f_random_input)
    end
    if f_delay == f_hold_time then
        emu:clearKey(f_random_input)
        fRandomInput()
        f_delay = 0
    end
    if f_delay == 0 then
        fWaitTime() --Rolls new wait and hold times after the input ends
        fHoldTime()
    end
    f_delay = f_delay + 1
end

function dRandomInput()
    d_random_input = math.random(4,7) --See "Constants" @ https://mgba.io/docs/scripting.html
end

function dWaitTime()
    d_wait_time = math.random(1,d_max_wait_time) --See line 30
end

function dHoldTime()
    d_hold_time = d_wait_time + math.random(1,d_max_hold_time) --See line 34
end

function dUpdateBufferKeysRead()
    if d_delay == d_wait_time then
        emu:addKey(d_random_input)
    end
    if d_delay == d_hold_time then
        emu:clearKey(d_random_input)
        dRandomInput()
        d_delay = 0
    end
    if d_delay == 0 then
        dWaitTime() --See line 47
        dHoldTime()
    end
    d_delay = d_delay + 1
end

function updateBufferFrame()
    --active_keys = emu:getKeys()
    --console:log("Active keys: " .. active_keys) --Debug
end

callbacks:add("frame", updateBufferFrame)
callbacks:add("keysRead", fUpdateBufferKeysRead)
callbacks:add("keysRead", dUpdateBufferKeysRead)
