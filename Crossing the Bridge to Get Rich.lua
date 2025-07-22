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

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 420)
main.Position = UDim2.new(0, 80, 0, 150)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 4
main.Visible = false
main.Active = true
main.Draggable = true

-- RGB border animation
spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		local color = Color3.fromHSV(hue/360,1,1)
		main.BorderColor3 = color
		task.wait(0.03)
	end
end)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🌉 Cross the Bridge, Get Rich!"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

-- RGB title animation
spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		title.TextColor3 = Color3.fromHSV(hue/360, 1, 1)
		task.wait(0.05)
	end
end)

-- Button function
local function makeBtn(text, posY, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(0, 260, 0, 30)
	btn.Position = UDim2.new(0, 20, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = text
	btn.MouseButton1Click:Connect(callback)
end

-- 💰 TREASURE
makeBtn("💰 1K CASH", 50, function() plr.Character:MoveTo(Vector3.new(-1, 50, -1138)) end)
makeBtn("💰 2.5K CASH", 85, function() plr.Character:MoveTo(Vector3.new(500, 52, -2636)) end)
makeBtn("💰 5K CASH", 120, function() plr.Character:MoveTo(Vector3.new(999, 55, -5125)) end)
makeBtn("💰 10K CASH", 155, function() plr.Character:MoveTo(Vector3.new(1499, 56, -10135)) end)
makeBtn("💰 25K CASH", 190, function() plr.Character:MoveTo(Vector3.new(1999, 52, -25139)) end)

-- 🌍 WORLDS
makeBtn("🌍 World 5", 230, function() plr.Character:MoveTo(Vector3.new(2000, 3, 11)) end)
makeBtn("🌍 World 4", 265, function() plr.Character:MoveTo(Vector3.new(1498, 3, 13)) end)
makeBtn("🌍 World 3", 300, function() plr.Character:MoveTo(Vector3.new(999, 3, 12)) end)
makeBtn("🌍 World 2", 335, function() plr.Character:MoveTo(Vector3.new(499, 3, 11)) end)
makeBtn("🌍 World 1", 370, function() plr.Character:MoveTo(Vector3.new(0, 3, 10)) end)

-- Credit
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 1, -30)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextSize = 13
credit.Text = "🔧 script by - luminaprojects"
credit.TextColor3 = Color3.new(1,1,1)

-- RGB credit animation
spawn(function()
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		credit.TextColor3 = Color3.fromHSV(hue/360, 1, 1)
		task.wait(0.07)
	end
end)

-- Toggle UI
toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

warn("✅ Lumina UI Loaded")
