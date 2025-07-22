-- 🌈 Win Obby Land GUI - Script by @luminaprojects
if game.PlaceId ~= 15460478336 then return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "WinObbyGUI"
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "⚙️"
ToggleButton.TextScaled = true
ToggleButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BorderSizePixel = 0
ToggleButton.ZIndex = 10

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 330)
MainFrame.Position = UDim2.new(0, 60, 0, 80)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 0, 0)

task.spawn(function()
	while true do
		for i = 0, 255, 4 do
			UIStroke.Color = Color3.fromHSV(i / 255, 1, 1)
			task.wait()
		end
	end
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "🏆 Win Obby Land"
Title.TextScaled = true
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

task.spawn(function()
	while true do
		for i = 0, 255, 4 do
			Title.TextColor3 = Color3.fromHSV(i / 255, 1, 1)
			task.wait()
		end
	end
end)

local function createButton(text, callback)
	local btn = Instance.new("TextButton", MainFrame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, #MainFrame:GetChildren() * 45)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Text = text
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Inf Wins toggle
local autoWin = false
createButton("Inf Wins 🏆", function()
	autoWin = not autoWin
	while autoWin do
		LocalPlayer.Character:PivotTo(CFrame.new(10, 276, -277))
		task.wait(2)
	end
end)

-- Finish Path
createButton("Finish Path 🕊️", function()
	LocalPlayer.Character:PivotTo(CFrame.new(12, 197, -239))
	task.wait(2)
end)

-- Squid Pet
createButton("Give Squid Pet", function()
	local args = {"Squid Pet"}
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PET_Equip"):FireServer(unpack(args))
end)

-- Toggle Fly
createButton("Toggle Fly", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Hotdog120823/FlyGuiV5/refs/heads/main/FlyGui"))()
end)

-- WalkSpeed input
local WalkLabel = Instance.new("TextLabel", MainFrame)
WalkLabel.Text = "WalkSpeed:"
WalkLabel.Size = UDim2.new(1, -20, 0, 20)
WalkLabel.Position = UDim2.new(0, 10, 0, #MainFrame:GetChildren() * 45)
WalkLabel.BackgroundTransparency = 1
WalkLabel.TextColor3 = Color3.new(1, 1, 1)
WalkLabel.Font = Enum.Font.Gotham
WalkLabel.TextScaled = true

local WalkInput = Instance.new("TextBox", MainFrame)
WalkInput.PlaceholderText = "Default: 16"
WalkInput.Size = UDim2.new(1, -20, 0, 30)
WalkInput.Position = UDim2.new(0, 10, 0, #MainFrame:GetChildren() * 45)
WalkInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
WalkInput.TextColor3 = Color3.new(1, 1, 1)
WalkInput.Font = Enum.Font.Gotham
WalkInput.TextScaled = true
WalkInput.FocusLost:Connect(function()
	local value = tonumber(WalkInput.Text)
	if value then
		LocalPlayer.Character.Humanoid.WalkSpeed = value
	end
end)

-- JumpPower input
local JumpLabel = Instance.new("TextLabel", MainFrame)
JumpLabel.Text = "JumpPower:"
JumpLabel.Size = UDim2.new(1, -20, 0, 20)
JumpLabel.Position = UDim2.new(0, 10, 0, #MainFrame:GetChildren() * 45)
JumpLabel.BackgroundTransparency = 1
JumpLabel.TextColor3 = Color3.new(1, 1, 1)
JumpLabel.Font = Enum.Font.Gotham
JumpLabel.TextScaled = true

local JumpInput = Instance.new("TextBox", MainFrame)
JumpInput.PlaceholderText = "Default: 50"
JumpInput.Size = UDim2.new(1, -20, 0, 30)
JumpInput.Position = UDim2.new(0, 10, 0, #MainFrame:GetChildren() * 45)
JumpInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
JumpInput.TextColor3 = Color3.new(1, 1, 1)
JumpInput.Font = Enum.Font.Gotham
JumpInput.TextScaled = true
JumpInput.FocusLost:Connect(function()
	local value = tonumber(JumpInput.Text)
	if value then
		LocalPlayer.Character.Humanoid.JumpPower = value
	end
end)

-- Credit RGB
local Credit = Instance.new("TextLabel", MainFrame)
Credit.Size = UDim2.new(1, -20, 0, 25)
Credit.Position = UDim2.new(0, 10, 1, -30)
Credit.BackgroundTransparency = 1
Credit.TextScaled = true
Credit.Font = Enum.Font.GothamBold
Credit.Text = "Script by - luminaprojects"
Credit.TextColor3 = Color3.new(1, 1, 1)

task.spawn(function()
	while true do
		for i = 0, 255, 4 do
			Credit.TextColor3 = Color3.fromHSV(i / 255, 1, 1)
			task.wait()
		end
	end
end)

-- Toggle visibility
ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)
