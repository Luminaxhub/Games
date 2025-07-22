-- ✅ Script by - luminaprojects | Game Lock: Win Obby Land
local gameTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
if not string.find(gameTitle, "Win Obby Land") then
    warn("❌ Script only for game: Win Obby Land")
    return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- CONFIG
local teleportEnabled = false
local teleportPos = Vector3.new(10, 276, -277)
local finishPos = Vector3.new(12, 197, -239)

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 280, 0, 300)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2

-- RGB Border
local rgb = 0
spawn(function()
	while task.wait() do
		rgb = (rgb + 1) % 255
		mainFrame.BorderColor3 = Color3.fromHSV(rgb/255, 1, 1)
	end
end)

-- RGB Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🌈 Win Obby Land GUI"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
spawn(function()
	while task.wait() do
		local h = (tick() * 0.5) % 1
		title.TextColor3 = Color3.fromHSV(h, 1, 1)
	end
end)

-- Drag
local dragging, dragStart, startPos
title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Helper: Create Button
local function createButton(text, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, 0, #mainFrame:GetChildren() * 35)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Text = text
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Inf Wins 🏆 (Auto TP)
createButton("Inf Wins 🏆", function()
	teleportEnabled = not teleportEnabled
	if teleportEnabled then
		while teleportEnabled and task.wait(2) do
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character:MoveTo(teleportPos)
			end
		end
	end
end)

-- Finish Path 🕊️
createButton("Finish Path 🕊️", function()
	task.wait(2)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character:MoveTo(finishPos)
	end
end)

-- Give Squid Pet 🐙
createButton("Give Squid Pet 🐙", function()
	local args = { "Squid Pet" }
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PET_Equip"):FireServer(unpack(args))
end)

-- Toggle Fly 🌬️
createButton("Toggle Fly 🌬️", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Hotdog120823/FlyGuiV5/refs/heads/main/FlyGui"))()
end)

-- WalkSpeed Input
local wsBox = Instance.new("TextBox", mainFrame)
wsBox.Size = UDim2.new(0.9, 0, 0, 30)
wsBox.Position = UDim2.new(0.05, 0, 0, #mainFrame:GetChildren() * 35)
wsBox.PlaceholderText = "Enter WalkSpeed (default 16)"
wsBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
wsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
wsBox.Font = Enum.Font.Gotham
wsBox.TextSize = 14
wsBox.FocusLost:Connect(function()
	local num = tonumber(wsBox.Text)
	if num and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = num
	end
end)

-- JumpPower Input
local jpBox = Instance.new("TextBox", mainFrame)
jpBox.Size = UDim2.new(0.9, 0, 0, 30)
jpBox.Position = UDim2.new(0.05, 0, 0, #mainFrame:GetChildren() * 35)
jpBox.PlaceholderText = "Enter JumpPower (default 50)"
jpBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jpBox.Font = Enum.Font.Gotham
jpBox.TextSize = 14
jpBox.FocusLost:Connect(function()
	local num = tonumber(jpBox.Text)
	if num and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.JumpPower = num
	end
end)

-- Toggle UI Button ⚙️
local toggleBtn = Instance.new("TextButton", ScreenGui)
toggleBtn.Size = UDim2.new(0, 100, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
toggleBtn.Text = "⚙️"
toggleBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Credit
local credit = Instance.new("TextLabel", mainFrame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.Text = "⭐ Script by - luminaprojects ⭐"
credit.Font = Enum.Font.Gotham
credit.TextSize = 14
spawn(function()
	while task.wait() do
		local hue = (tick() % 5) / 5
		credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
	end
end)
