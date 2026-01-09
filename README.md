# Hep Reduce
- A module for Roblox Studio to reduce coding repetitiveness.

## Installation
[hep_reduce.rbxm](https://github.com/Placewith5s/hep_reduce/releases/download/0.1.0/hep_reduce.rbxm)

## Usage
```lua
--!strict
local hep_reduce = require(game.ServerScriptService.hep_reduce)

repeat task.wait() until #game.Players:GetPlayers() > 0 -- studio's poop break :)


local function test_wait_async()
	print("Hello from async serial!")
end

local function test_while_wait_async()
	print("Repeated hello from while async serial")
end

local cancelable_thread: thread = hep_reduce.wait_async(3, test_wait_async)
local cancelable_thread_2: thread = hep_reduce.while_wait_async(1, test_while_wait_async, false)
```

## Documentation
- LuaDoc