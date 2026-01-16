local hep_reduce = require("./hep_reduce")

local test_gui: ScreenGui = game.StarterGui:WaitForChild("test_gui", 10)
local test_btn: TextButton = test_gui and test_gui:FindFirstChild("test_btn") :: TextButton

local debounce: boolean = false


local function debounced_click()
    print("Click")
    debounce = hep_reduce.debouncer(debounce, 0.3)
    print("Debounced the click")
end

test_btn.Activated:Connect(debounced_click)