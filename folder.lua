-- 🔎 Flow's Prop Hunt
-- Script by - @Luminaprojects (RGB credit)
-- Featured ⚙️

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FlowESP_UI"

local main = Instance.new("Frame", screenGui)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BackgroundTransparency = 0.2
main.BorderSizePixel = 0
main.Position = UDim2.new(0, 50, 0, 100)
main.Size = UDim2.new(0, 250, 0, 220)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Text = "🔎 Flow's Prop Hunt"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Position = UDim2.new(0, 0, 0, 0)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1

local subtitle = Instance.new("TextLabel", main)
subtitle.Text = "Featured ⚙️"
subtitle.Font = Enum.Font.Gotham
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.TextSize = 14
subtitle.Position = UDim2.new(0, 0, 0, 30)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.BackgroundTransparency = 1

local minimize = Instance.new("TextButton", main)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 0)
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimize.BorderSizePixel = 0

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 0, 0, 55)
content.Size = UDim2.new(1, 0, 1, -55)
content.BackgroundTransparency = 1

local espToggle = Instance.new("TextButton", content)
espToggle.Text = "ESP ON"
espToggle.Font = Enum.Font.GothamBold
espToggle.TextSize = 16
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Size = UDim2.new(0.9, 0, 0, 30)
espToggle.Position = UDim2.new(0.05, 0, 0, 10)
espToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
espToggle.BorderSizePixel = 0

local featured = Instance.new("TextLabel", content)
featured.Text = "Health Bar ESP"
featured.Font = Enum.Font.Gotham
featured.TextSize = 14
featured.TextColor3 = Color3.fromRGB(180, 180, 180)
featured.Size = UDim2.new(1, -20, 0, 20)
featured.Position = UDim2.new(0, 10, 0, 45)
featured.BackgroundTransparency = 1

-- RGB credit
local credit = Instance.new("TextLabel", screenGui)
credit.Text = "Script by - @Luminaprojects"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 16
credit.Position = UDim2.new(0.5, -100, 1, -40)
credit.Size = UDim2.new(0, 200, 0, 30)
credit.BackgroundTransparency = 1

-- RGB Animation
task.spawn(function()
	while true do
		local hue = tick() % 5 / 5
		local color = Color3.fromHSV(hue, 1, 1)
		credit.TextColor3 = color
		task.wait(0.1)
	end
end)

-- ESP Logic
local espEnabled = false
local boxes = {}

local function clearESP()
	for _, box in pairs(boxes) do
		box:Destroy()
	end
	table.clear(boxes)
end

local function createESP(player)
	if player == localPlayer then return end
	local char = player.Character
	if not (char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid")) then return end

	local box = Instance.new("BillboardGui")
	box.Adornee = char.HumanoidRootPart
	box.AlwaysOnTop = true
	box.Size = UDim2.new(4, 0, 5, 0)
	box.Name = player.Name.."_ESP"
	box.Parent = screenGui

	local healthBar = Instance.new("Frame", box)
	healthBar.Size = UDim2.new(0.1, 0, 1, 0)
	healthBar.Position = UDim2.new(1, 0, 0, 0)
	healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

	boxes[player] = box

	runService.RenderStepped:Connect(function()
		if espEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
			local hp = player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth
			healthBar.Size = UDim2.new(0.1, 0, hp, 0)
			healthBar.Position = UDim2.new(1, 0, 1 - hp, 0)
		end
	end)
end

local function updateESP()
	clearESP()
	for _, plr in ipairs(players:GetPlayers()) do
		if plr.Team ~= localPlayer.Team then
			createESP(plr)
		end
	end
end

espToggle.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espToggle.Text = espEnabled and "ESP OFF" or "ESP ON"
	if espEnabled then
		updateESP()
	else
		clearESP()
	end
end)

-- Minimize
local minimized = false
minimize.MouseButton1Click:Connect(function()
	if not minimized then
		main:TweenSize(UDim2.new(0, 250, 0, 40), "Out", "Quad", 0.25, true)
		content.Visible = false
	else
		main:TweenSize(UDim2.new(0, 250, 0, 220), "Out", "Quad", 0.25, true)
		content.Visible = true
	end
	minimized = not minimized
end)
