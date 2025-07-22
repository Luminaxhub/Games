-- Made by @Luminaprojects – For Game ID: 15460478336 (Win Obby Land Only)

-- Game ID Lock
if game.PlaceId ~= 15460478336 then
	warn("This script is only for Win Obby Land.")
	return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 60, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "⚙️"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BorderSizePixel = 0

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 350)
Main.Position = UDim2.new(0.5, -150, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 4

-- RGB Border
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			Main.BorderColor3 = Color3.fromHSV(i, 1, 1)
			wait()
		end
	end
end)

Main.Visible = false

ToggleButton.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

-- Dragging
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.Heartbeat:Connect(function()
	if dragging and dragInput then
		update(dragInput)
	end
end)

-- Title with RGB
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🏆 Win Obby Land"
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			Title.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait()
		end
	end
end)

-- Buttons + Inputs
local spacing = 40
local function createButton(name, func)
	local btn = Instance.new("TextButton", Main)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, 0, spacing)
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(func)
	spacing += 35
end

local autoTP = false
createButton("Inf Wins 🏆", function()
	autoTP = not autoTP
	if autoTP then
		while autoTP do
			task.wait(2)
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character:PivotTo(CFrame.new(10, 276, -277))
			end
		end
	end
end)

createButton("Finish Path 🕊️", function()
	task.wait(2)
	LocalPlayer.Character:PivotTo(CFrame.new(12, 197, -239))
end)

createButton("Give Squid Pet 🐙", function()
	local args = { "Squid Pet" }
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PET_Equip"):FireServer(unpack(args))
end)

createButton("Toggle Fly 🌬️", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- WalkSpeed
local wsBox = Instance.new("TextBox", Main)
wsBox.PlaceholderText = "WalkSpeed (default 16)"
wsBox.Size = UDim2.new(0.9, 0, 0, 30)
wsBox.Position = UDim2.new(0.05, 0, 0, spacing)
wsBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
wsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
wsBox.BorderSizePixel = 0
wsBox.Font = Enum.Font.Gotham
wsBox.TextSize = 14
spacing += 35

wsBox.FocusLost:Connect(function()
	local num = tonumber(wsBox.Text)
	if num and LocalPlayer.Character then
		LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = num
	end
end)

-- JumpPower
local jpBox = Instance.new("TextBox", Main)
jpBox.PlaceholderText = "JumpPower (default 50)"
jpBox.Size = UDim2.new(0.9, 0, 0, 30)
jpBox.Position = UDim2.new(0.05, 0, 0, spacing)
jpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jpBox.BorderSizePixel = 0
jpBox.Font = Enum.Font.Gotham
jpBox.TextSize = 14
spacing += 35

jpBox.FocusLost:Connect(function()
	local num = tonumber(jpBox.Text)
	if num and LocalPlayer.Character then
		LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = num
	end
end)

-- Credit Label (RGB)
local credit = Instance.new("TextLabel", Main)
credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.new(0, 0, 1, -25)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamBold
credit.TextSize = 14
credit.Text = "⭐ Script by - luminaprojects ⭐"

spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait()
		end
	end
end)
