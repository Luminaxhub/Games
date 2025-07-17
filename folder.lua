--[[
💡 Flow's Prop Hunt Script UI
📦 Fitur: ESP, Auto Coin, TP Lobby, Noclip, WalkSpeed Slider (Android), Toggle UI
📜 Script by - @Luminaprojects (RGB Text)
]]--

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

-- UI Setup
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "FlowHubUI"
screenGui.ResetOnSpawn = false

-- UI Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 100, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "⚙️ OPEN"
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Parent = screenGui

-- Main Hub
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 320)
mainFrame.Position = UDim2.new(0, 10, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Toggle Visibility
toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- UI Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔎 Flow's Prop Hunt"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Parent = mainFrame

-- Utility Function
local function createToggle(parent, name, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -20, 0, 30)
	button.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 35)
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Text = name..": OFF"
	local isOn = false
	button.MouseButton1Click:Connect(function()
		isOn = not isOn
		button.Text = name..": "..(isOn and "ON" or "OFF")
		button.BackgroundColor3 = isOn and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(60, 60, 60)
		callback(isOn)
	end)
	button.Parent = parent
end

-- ESP Hider
createToggle(mainFrame, "👁️ ESP", function(state)
	if state then
		RunService:BindToRenderStep("ESP", Enum.RenderPriority.Camera.Value, function()
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					if not player.Character:FindFirstChild("ESPTag") then
						local tag = Instance.new("BillboardGui", player.Character)
						tag.Name = "ESPTag"
						tag.Size = UDim2.new(0, 100, 0, 40)
						tag.AlwaysOnTop = true
						tag.StudsOffset = Vector3.new(0, 3, 0)
						local text = Instance.new("TextLabel", tag)
						text.Size = UDim2.new(1, 0, 1, 0)
						text.BackgroundTransparency = 1
						text.TextColor3 = Color3.new(1,0,0)
						text.Text = "👀 Hider"
					end
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("ESP")
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("ESPTag") then
				player.Character:FindFirstChild("ESPTag"):Destroy()
			end
		end
	end
end)

-- Auto Collect Coin
createToggle(mainFrame, "💰 Auto Coin", function(state)
	task.spawn(function()
		while state do
			for _,v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("coin") and v:IsA("BasePart") then
					firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 0)
					wait()
					firetouchinterest(LocalPlayer.Character.HumanoidRootPart, v, 1)
				end
			end
			task.wait(1)
		end
	end)
end)

-- TP to Lobby
createToggle(mainFrame, "🚪 TP Lobby", function(state)
	if state then
		local tp = workspace:FindFirstChild("Lobby")
		if tp then
			LocalPlayer.Character:PivotTo(tp.CFrame)
		end
	end
end)

-- Noclip
createToggle(mainFrame, "👻 Noclip", function(state)
	task.spawn(function()
		while state do
			for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
			task.wait()
		end
	end)
end)

-- WalkSpeed Slider
local walkspeed = Instance.new("TextLabel")
walkspeed.Text = "🏃 WalkSpeed"
walkspeed.TextColor3 = Color3.new(1,1,1)
walkspeed.BackgroundTransparency = 1
walkspeed.Position = UDim2.new(0, 10, 0, #mainFrame:GetChildren() * 35)
walkspeed.Size = UDim2.new(1, -20, 0, 25)
walkspeed.Parent = mainFrame

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(0, 250, 0, 20)
slider.Position = UDim2.new(0, 10, 0, #mainFrame:GetChildren() * 35)
slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
slider.Text = "Adjust WalkSpeed"
slider.TextColor3 = Color3.new(1,1,1)
slider.Parent = mainFrame

local dragging = false
slider.MouseButton1Down:Connect(function()
	dragging = true
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.Touch then
		dragging = false
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local pos = input.Position.X - slider.AbsolutePosition.X
		local percent = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)
		local speed = math.floor(16 + percent * 100)
		LocalPlayer.Character.Humanoid.WalkSpeed = speed
		slider.Text = "WalkSpeed: "..speed
	end
end)

-- RGB Credit (Bottom Center)
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.BackgroundTransparency = 1
credit.Text = "Script by - @Luminaprojects"
credit.Font = Enum.Font.GothamBold
credit.TextScaled = true
credit.Parent = screenGui

-- RGB Text Effect
spawn(function()
	while true do
		local t = tick()
		local r = math.sin(t)*127+128
		local g = math.sin(t + 2)*127+128
		local b = math.sin(t + 4)*127+128
		credit.TextColor3 = Color3.fromRGB(r, g, b)
		wait(0.1)
	end
end)
