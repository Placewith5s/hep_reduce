--!strict
local hep_reduce = {}

-- Wait asynchronously for an x amount of time
-- @param seconds - setting it to 0 will default to RunService.Heartbeat:Wait()
-- @param func_inside - runs inside the task.spawn or task.delay, depending on seconds choice
-- @usage hep_reduce.wait_async(3, test_wait_async)
function hep_reduce.wait_async(seconds: number, func_inside: () -> ()): thread
	if type(seconds) ~= "number" or seconds ~= seconds then
		error("Invalid seconds provided!")
	end
	if type(func_inside) ~= "function" then
		error("Invalid function inside provided!")
	end
	
	local thread: thread | nil = nil
	
	if not seconds then
		thread = task.spawn(function()
			task.wait()
			func_inside()
		end)
	else
		thread = task.delay(seconds, function()
			func_inside()
		end)
	end
	
	return thread
end


-- Repeated asynchronous wait in a while loop
-- @param seconds - setting it to 0 will default to RunService.Heartbeat:Wait()
-- @param func_inside - runs inside the task.spawn or task.delay, depending on seconds choice
-- @param shall_break - if this is true, the loop will break
-- @usage hep_reduce.while_wait_async(1, test_while_wait_async, false)
function hep_reduce.while_wait_async(seconds: number, func_inside: () -> (), shall_break: boolean): thread
	if type(seconds) ~= "number" or seconds ~= seconds then
		error("Invalid seconds provided!")
	end
	if type(func_inside) ~= "function" then
		error("Invalid function inside provided!")
	end
	if type(shall_break) ~= "boolean" then
		error("Invalid shall break provided!")
	end

	local thread: thread | nil = nil

	if not seconds then
		thread = task.spawn(function()
			while true do
				task.wait()
				func_inside()
				
				if shall_break then
					break
				end
			end
		end)
	else
		thread = task.spawn(function()
			while true do
				task.wait(seconds)
				func_inside()
				
				if shall_break then
					break
				end
			end
		end)
	end

	return thread
end

return hep_reduce