-- Win Obby Land UI by @Luminaprojects

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Teleporting = false

-- UI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 220, 0, 240)
mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.BorderSizePixel = 3

-- RGB Border
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			mainFrame.BorderColor3 = Color3.fromHSV(i, 1, 1)
			task.wait(0.01)
		end
	end
end)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Win Obby Land"
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextStrokeTransparency = 0.2

-- RGB Title
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			title.TextColor3 = Color3.fromHSV(i, 1, 1)
			task.wait(0.02)
		end
	end
end)

-- Drag UI
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Toggle UI Button
local toggle = Instance.new("TextButton", screenGui)
toggle.Text = "⚙️"
toggle.Size = UDim2.new(0, 40, 0, 40)
toggle.Position = UDim2.new(0, 10, 0, 10)
toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.TextSize = 25
toggle.Font = Enum.Font.GothamBold

toggle.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Button Generator
local function createButton(text, pos, callback)
	local button = Instance.new("TextButton", mainFrame)
	button.Size = UDim2.new(0.9, 0, 0, 30)
	button.Position = pos
	button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.Text = text
	button.MouseButton1Click:Connect(callback)
end

-- Inf Wins
local autoTP = false
createButton("Inf Wins 🏆", UDim2.new(0.05, 0, 0, 40), function()
	autoTP = not autoTP
	if autoTP then
		while autoTP do
			local char = Players.LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char:MoveTo(Vector3.new(10, 276, -277))
			end
			task.wait(2)
		end
	end
end)

-- Finish Path
createButton("Finish Path 🕊️", UDim2.new(0.05, 0, 0, 75), function()
	local char = Players.LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		task.delay(2, function()
			char:MoveTo(Vector3.new(21, 197, -229))
		end)
	end
end)

-- Squid Pet
createButton("Give Squid Pet 🐙", UDim2.new(0.05, 0, 0, 110), function()
	local args = { "Squid Pet" }
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PET_Equip"):FireServer(unpack(args))
end)

-- Show Path 😳
createButton("Show Path 😳", UDim2.new(0.05, 0, 0, 145), function()
	local root = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	for _, part in ipairs(workspace:GetDescendants()) do
		if part:IsA("Part") and part.Size.Y < 1 and part.Position.Y > root.Position.Y - 10 and part.Position.Y < root.Position.Y + 30 then
			if part.Anchored and part.CanCollide and part.Transparency < 0.4 then
				-- Clone untuk cek apakah jatuh
				local test = part:Clone()
				test.Anchored = false
				test.CanCollide = true
				test.Position = part.Position + Vector3.new(0, 3, 0)
				test.Parent = workspace
				task.wait(0.1)
				local fall = math.abs(test.Position.Y - part.Position.Y)
				test:Destroy()

				if fall < 1 then
					-- Aman, kasih highlight
					local highlight = Instance.new("Highlight")
					highlight.Parent = part
					highlight.FillColor = Color3.fromRGB(0, 255, 0)
					highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
					highlight.FillTransparency = 0.3
					highlight.OutlineTransparency = 0
				else
					part:Destroy() -- Salah, hapus
				end
			end
		end
	end
end)

-- Credit
local credit = Instance.new("TextLabel", mainFrame)
credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.new(0, 0, 1, -25)
credit.BackgroundTransparency = 1
credit.Text = "script by - luminaprojects"
credit.TextSize = 12
credit.Font = Enum.Font.GothamBold
credit.TextStrokeTransparency = 0.4

-- RGB Credit
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			task.wait(0.02)
		end
	end
end)
