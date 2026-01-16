--!strict
local hep_reduce = {}


local function check_char(char: Model)
    if (not char:IsA("Model") or not char) then
        error("Invalid character provided! From: " .. debug.info(2, "sln"))
    end
end

local function check_seconds(seconds: number): number | nil
    if (type(seconds) ~= "number" or seconds ~= seconds) then
        warn("Invalid seconds provided! Defaulting to 0")
        return 0
    end

    return nil
end

local function get_char_instance(char: Model, inst_name: string): Instance | nil
    local found_inst: Instance | nil = char:FindFirstChild(inst_name)
    return found_inst
end

function hep_reduce.is_studio(): boolean
    if game["Run Service"]:IsStudio() then
        return true
    end

    return false
end

-- @return the updated debounce for debugging purposes
-- @usage hep_reduce.debouncer(debounce, 0.3)
function hep_reduce.debouncer(debounce: boolean, duration: number): boolean
    if debounce then return true end
    debounce = true

    task.delay(duration, function()
        debounce = false
    end)

    return debounce
end

-- Get the model's "Head" using its character
-- @usage hep_reduce.get_head(char)
function hep_reduce.get_head(char: Model): BasePart
    check_char(char)

    local head: BasePart | nil = get_char_instance(char, "Head") :: BasePart | nil

    if not head then
        error("Couldn't get Head for " .. char.Name .. "!")
    end

    return head
end

-- Get the model's "HumanoidRootPart" using its character
-- @usage hep_reduce.get_hrp(char)
function hep_reduce.get_hrp(char: Model): BasePart
    check_char(char)

    local hrp: BasePart | nil = get_char_instance(char, "HumanoidRootPart") :: BasePart | nil

    if not hrp then
        error("Couldn't get HumanoidRootPart for " .. char.Name .. "!")
    end

    return hrp
end

-- Get the model's "Humanoid" using its character
-- @usage hep_reduce.get_hum(char)
function hep_reduce.get_hum(char: Model): Humanoid
    check_char(char)

    local hum: Humanoid | nil = get_char_instance(char, "Humanoid") :: Humanoid | nil

    if not hum then
        error("Couldn't get Humanoid for " .. char.Name .. "!")
    end

    return hum
end


-- @param seconds - setting it to 0 will default to RunService.Heartbeat:Wait()
-- @return the thread for cleanup purposes
-- @usage hep_reduce.wait_async(3)
function hep_reduce.wait_async(seconds: number): thread?
    local invalid_seconds: number | nil = check_seconds(seconds)

    local thread: thread | nil = nil

    if seconds == 0 or invalid_seconds then
        thread = task.spawn(function() task.wait() end)
    else
        thread = task.delay(seconds, function() end)
    end

    if not thread then
        warn("Couldn't return async thread!")
        return
    end

    return thread
end

return hep_reduce