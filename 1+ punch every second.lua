-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local DamageRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("PunchEvents"):WaitForChild("DamageRE")
local RebirthRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("RebirthEvents"):WaitForChild("Rebirth")
local RewardEvent = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("PlaytimeRewardEvent"):WaitForChild("ButtonClicked")

-- NPC List by Zone
local npcZones = {
	[1] = {"Noob Farmer", "Strong Farmer"},
	[2] = {"Bandit", "Cowboy"},
	[3] = {"Candy Man", "Gingerbread Man"},
	[4] = {"Snow Bandit", "Snow Knight"},
	[5] = {"Monkey", "Monkey King"},
	[6] = {"Toy Soldier", "Teddy Bear"},
	[7] = {"Astronaut", "Space Man"},
	[8] = {"Crew Member", "Pirate Captain"},
	[9] = {"Lava Guard", "Dark Trooper"},
}

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AutoSystemUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 360)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIGradient = Instance.new("UIGradient", MainFrame)
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(136, 84, 208)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 219, 251))
}
UIGradient.Rotation = 45

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "+1 Punch Every Second"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Minimize = Instance.new("TextButton", MainFrame)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.TextSize = 20
Minimize.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
Minimize.Size = UDim2.new(0, 30, 0, 30)
Minimize.Position = UDim2.new(1, -35, 0, 10)
Minimize.AnchorPoint = Vector2.new(0, 0)
Minimize.AutoButtonColor = true

local UICornerMin = Instance.new("UICorner", Minimize)
UICornerMin.CornerRadius = UDim.new(0, 8)

local Content = Instance.new("Frame", MainFrame)
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -50)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1

-- Drag Logic
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Buttons
local function createButton(name, positionY, color)
	local button = Instance.new("TextButton", Content)
	button.Text = name .. ": OFF"
	button.Font = Enum.Font.GothamBold
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextSize = 18
	button.BackgroundColor3 = color
	button.Size = UDim2.new(0, 280, 0, 40)
	button.Position = UDim2.new(0, 0, 0, positionY)
	button.AutoButtonColor = true
	local corner = Instance.new("UICorner", button)
	corner.CornerRadius = UDim.new(0, 8)
	return button
end

local ToggleTrain = createButton("Auto Train", 0, Color3.fromRGB(100, 100, 255))
local ToggleRebirth = createButton("Auto Rebirth", 50, Color3.fromRGB(255, 100, 100))
local ToggleKill = createButton("Auto Kill", 100, Color3.fromRGB(100, 255, 150))
local ToggleReward = createButton("Give Coins", 150, Color3.fromRGB(255, 170, 80))
local ToggleStrength = createButton("Give Strength", 200, Color3.fromRGB(255, 170, 100))

-- Minimize
local minimized = false
Minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	Content.Visible = not minimized
	MainFrame:TweenSize(UDim2.new(0, 320, 0, minimized and 50 or 360), "Out", "Quad", 0.3, true)
end)

-- Toggle Flags
local autoTrain, autoRebirth, autoKill, autoReward, autoStrength = false, false, false, false, false

ToggleTrain.MouseButton1Click:Connect(function()
	autoTrain = not autoTrain
	ToggleTrain.Text = "Auto Train: " .. (autoTrain and "ON" or "OFF")
	ToggleTrain.BackgroundColor3 = autoTrain and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(100, 100, 255)
end)

ToggleRebirth.MouseButton1Click:Connect(function()
	autoRebirth = not autoRebirth
	ToggleRebirth.Text = "Auto Rebirth: " .. (autoRebirth and "ON" or "OFF")
	ToggleRebirth.BackgroundColor3 = autoRebirth and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(255, 100, 100)
end)

ToggleKill.MouseButton1Click:Connect(function()
	autoKill = not autoKill
	ToggleKill.Text = "Auto Kill: " .. (autoKill and "ON" or "OFF")
	ToggleKill.BackgroundColor3 = autoKill and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(100, 255, 150)
end)

ToggleReward.MouseButton1Click:Connect(function()
	autoReward = not autoReward
	ToggleReward.Text = "Give Coins: " .. (autoReward and "ON" or "OFF")
	ToggleReward.BackgroundColor3 = autoReward and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(255, 170, 80)
end)

ToggleStrength.MouseButton1Click:Connect(function()
	autoStrength = not autoStrength
	ToggleStrength.Text = "Give Strength: " .. (autoStrength and "ON" or "OFF")
	ToggleStrength.BackgroundColor3 = autoStrength and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(255, 170, 100)
end)

-- ESP + Logic
local esp = Drawing.new("Circle")
esp.Thickness = 2
esp.Radius = 6
esp.Filled = true
esp.Color = Color3.fromRGB(255, 0, 0)
esp.Visible = false

task.spawn(function()
	local killRadius = 20
	while true do
		if autoTrain then
			for i = 1, 9 do
				local zone = workspace:FindFirstChild("Zone " .. i)
				if zone and zone:FindFirstChild("Punching bag "..i) then
					local bag = zone["Punching bag "..i]:FindFirstChild("PunchBag")
					if bag then
						DamageRE:FireServer(LocalPlayer.Character, bag, true)
					end
				end
			end
		end
		if autoRebirth then
			local stats = LocalPlayer:FindFirstChild("leaderstats")
			if stats and stats:FindFirstChild("Coins") and stats.Coins.Value >= 1000000 then
				RebirthRE:FireServer()
			end
		end
		if autoKill then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				for zone = 1, 9 do
					local folder = workspace:FindFirstChild("Zone " .. zone)
					if folder and folder:FindFirstChild("NPC's") then
						for _, name in pairs(npcZones[zone]) do
							local npc = folder["NPC's"]:FindFirstChild(name)
							if npc and npc:FindFirstChild("LowerTorso") then
								local dist = (char.HumanoidRootPart.Position - npc.LowerTorso.Position).Magnitude
								if dist <= killRadius then
									DamageRE:FireServer(char, npc.LowerTorso, false, false)
								end
							end
						end
					end
				end
			end
		end
		if autoReward then
			local stats = LocalPlayer:FindFirstChild("leaderstats")
			if stats and stats:FindFirstChild("Coins") and stats.Coins.Value >= 1000000 then
				RewardEvent:InvokeServer(true, 250, "Cash")
			end
		end
		if autoStrength then
			local stats = LocalPlayer:FindFirstChild("leaderstats")
			if stats and stats:FindFirstChild("Coins") and stats.Coins.Value >= 1000000 then
				RewardEvent:InvokeServer(true, 1000, "Strength")
			end
		end
		RunService.RenderStepped:Wait()
	end
end)

-- RGB Credit
local Credit = Instance.new("TextLabel", ScreenGui)
Credit.Text = "Script By - @Luminaprojects"
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 16
Credit.Position = UDim2.new(0.5, -150, 1, -30)
Credit.Size = UDim2.new(0, 300, 0, 25)
Credit.BackgroundTransparency = 1
Credit.TextStrokeTransparency = 0.5
Credit.TextStrokeColor3 = Color3.new(0, 0, 0)
Credit.TextWrapped = true

task.spawn(function()
	local h = 0
	while true do
		h = (h + 1) % 360
		Credit.TextColor3 = Color3.fromHSV(h/360, 1, 1)
		task.wait(0.05)
	end
end)
