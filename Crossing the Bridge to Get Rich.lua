local plr = game.Players.LocalPlayer
repeat task.wait() until plr:FindFirstChild("PlayerGui") and plr.Character
local hum = plr.Character:WaitForChild("Humanoid")

-- UI
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "CrossBridgeUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false

-- Toggle Button
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0, 60, 0, 35)
toggle.Position = UDim2.new(0, 10, 0, 150)
toggle.Text = "⚙️"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 18
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.BackgroundColor3 = Color3.fromRGB(45,45,45)
toggle.Draggable = true
toggle.Active = true

-- Main Frame (container)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 420)
main.Position = UDim2.new(0, 80, 0, 150)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 4
main.Visible = false
main.Active = true
main.Draggable = true
main.ClipsDescendants = true

-- RGB border
spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		main.BorderColor3 = Color3.fromHSV(hue/360,1,1)
		task.wait(0.03)
	end
end)

-- ScrollingFrame
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, 0, 1, -40)
scroll.Position = UDim2.new(0, 0, 0, 40)
scroll.CanvasSize = UDim2.new(0, 0, 0, 430)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Layout
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🌉 Cross the Bridge, Get Rich!"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		title.TextColor3 = Color3.fromHSV(hue/360, 1, 1)
		task.wait(0.05)
	end
end)

-- Button generator
local function makeBtn(text, callback)
	local btn = Instance.new("TextButton", scroll)
	btn.Size = UDim2.new(1, -40, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = text
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.MouseButton1Click:Connect(callback)
end

-- Cash Teleport Buttons
makeBtn("💰 1K CASH", function() plr.Character:MoveTo(Vector3.new(-1, 50, -1138)) end)
makeBtn("💰 2.5K CASH", function() plr.Character:MoveTo(Vector3.new(500, 52, -2636)) end)
makeBtn("💰 5K CASH", function() plr.Character:MoveTo(Vector3.new(999, 55, -5125)) end)
makeBtn("💰 10K CASH", function() plr.Character:MoveTo(Vector3.new(1499, 56, -10135)) end)
makeBtn("💰 25K CASH", function() plr.Character:MoveTo(Vector3.new(1999, 52, -25139)) end)

-- World Teleport Buttons
makeBtn("🌍 World 5", function() plr.Character:MoveTo(Vector3.new(2000, 3, 11)) end)
makeBtn("🌍 World 4", function() plr.Character:MoveTo(Vector3.new(1498, 3, 13)) end)
makeBtn("🌍 World 3", function() plr.Character:MoveTo(Vector3.new(999, 3, 12)) end)
makeBtn("🌍 World 2", function() plr.Character:MoveTo(Vector3.new(499, 3, 11)) end)
makeBtn("🌍 World 1", function() plr.Character:MoveTo(Vector3.new(0, 3, 10)) end)

-- Tambahan: Unlocked Fun Zone
makeBtn("💥 Unlocked Fun Zone", function()
	plr.Character:MoveTo(Vector3.new(-0, 3, 103)) -- Ganti posisi jika berbeda
end)

-- Credit
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 1, -30)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextSize = 13
credit.Text = "🔧 script by - luminaprojects"
credit.TextColor3 = Color3.new(1,1,1)

spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		credit.TextColor3 = Color3.fromHSV(hue/360, 1, 1)
		task.wait(0.07)
	end
end)

-- Toggle
toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

warn("✅ Lumina UI Loaded with Scroll & Unlocked Fun Zone")
