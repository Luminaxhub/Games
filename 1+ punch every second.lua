local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

repeat task.wait() until LocalPlayer:FindFirstChild("PlayerGui")

local DamageRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("PunchEvents"):WaitForChild("DamageRE")
local RebirthRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("RebirthEvents"):WaitForChild("Rebirth")
local RewardEvent = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("PlaytimeRewardEvent"):WaitForChild("ButtonClicked")

local npcZones = {
	[1] = {"Noob Farmer", "Strong Farmer"}, [2] = {"Bandit", "Cowboy"},
	[3] = {"Candy Man", "Gingerbread Man"}, [4] = {"Snow Bandit", "Snow Knight"},
	[5] = {"Monkey", "Monkey King"}, [6] = {"Toy Soldier", "Teddy Bear"},
	[7] = {"Astronaut", "Space Man"}, [8] = {"Crew Member", "Pirate Captain"},
	[9] = {"Lava Guard", "Dark Trooper"}
}

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AutoSystemUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 270)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -135)
MainFrame.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local gradient = Instance.new("UIGradient", MainFrame)
gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(136, 84, 208)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 219, 251))
}

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "+1 Punch Every Second 🥊"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local Minimize = Instance.new("TextButton", MainFrame)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.TextSize = 20
Minimize.Size = UDim2.new(0, 30, 0, 30)
Minimize.Position = UDim2.new(1, -35, 0, 10)
Minimize.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 6)

local Content = Instance.new("Frame", MainFrame)
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -50)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1

-- DRAG
local dragging, dragStart, startPos
Title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- BUTTON CREATOR
local function createButton(text, yPos, color)
	local btn = Instance.new("TextButton", Content)
	btn.Text = text .. ": OFF"
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextSize = 16
	btn.Size = UDim2.new(0, 180, 0, 34)
	btn.Position = UDim2.new(0, 0, 0, yPos)
	btn.BackgroundColor3 = color
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

-- BUTTONS
local ToggleTrain = createButton("Auto Train", 0, Color3.fromRGB(100, 100, 255))
local ToggleRebirth = createButton("Auto Rebirth", 40, Color3.fromRGB(255, 100, 100))
local ToggleKill = createButton("Auto Kill", 80, Color3.fromRGB(100, 255, 150))
local ToggleReward = createButton("Give Coins", 120, Color3.fromRGB(255, 170, 80))
local ToggleStrength = createButton("Give Strength", 160, Color3.fromRGB(255, 170, 100))

-- TOGGLES
local autoTrain, autoRebirth, autoKill, autoReward, autoStrength = false, false, false, false, false

ToggleTrain.MouseButton1Click:Connect(function()
	autoTrain = not autoTrain
	ToggleTrain.Text = "Auto Train: " .. (autoTrain and "ON" or "OFF")
end)
ToggleRebirth.MouseButton1Click:Connect(function()
	autoRebirth = not autoRebirth
	ToggleRebirth.Text = "Auto Rebirth: " .. (autoRebirth and "ON" or "OFF")
end)
ToggleKill.MouseButton1Click:Connect(function()
	autoKill = not autoKill
	ToggleKill.Text = "Auto Kill: " .. (autoKill and "ON" or "OFF")
end)
ToggleReward.MouseButton1Click:Connect(function()
	autoReward = not autoReward
	ToggleReward.Text = "Give Coins: " .. (autoReward and "ON" or "OFF")
end)
ToggleStrength.MouseButton1Click:Connect(function()
	autoStrength = not autoStrength
	ToggleStrength.Text = "Give Strength: " .. (autoStrength and "ON" or "OFF")
end)

-- MINIMIZE
local minimized = false
Minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	Content.Visible = not minimized
	MainFrame:TweenSize(UDim2.new(0, 200, 0, minimized and 50 or 270), "Out", "Quad", 0.3, true)
end)

-- LOOP
task.spawn(function()
	while true do
		if autoTrain then
			for i = 1, 9 do
				local zone = Workspace:FindFirstChild("Zone "..i)
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
					local folder = Workspace:FindFirstChild("Zone " .. zone)
					if folder and folder:FindFirstChild("NPC's") then
						for _, name in pairs(npcZones[zone]) do
							local npc = folder["NPC's"]:FindFirstChild(name)
							if npc and npc:FindFirstChild("LowerTorso") then
								local dist = (char.HumanoidRootPart.Position - npc.LowerTorso.Position).Magnitude
								if dist <= 20 then
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

-- CREDIT
local Credit = Instance.new("TextLabel", ScreenGui)
Credit.Text = "⭐ Script By - @Luminaprojects ⭐"
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 14
Credit.Position = UDim2.new(0.5, -120, 1, -25)
Credit.Size = UDim2.new(0, 240, 0, 20)
Credit.BackgroundTransparency = 1
Credit.TextStrokeTransparency = 0.5
Credit.TextStrokeColor3 = Color3.new(0, 0, 0)
Credit.TextWrapped = true

task.spawn(function()
	local h = 0
	while true do
		h = (h + 1) % 360
		Credit.TextColor3 = Color3.fromHSV(h / 360, 1, 1)
		task.wait(0.05)
	end
end)
