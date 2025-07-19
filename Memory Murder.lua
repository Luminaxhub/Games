if game.PlaceId ~= 9638489687 then
    return warn("This script only works in Memory Murder.")
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "MemoryMurderUI"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 300, 0, 280)
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.BackgroundTransparency = 0.2
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

local UIListLayout = Instance.new("UIListLayout", Main)
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Toggle Button
local toggleButton = Instance.new("TextButton", ScreenGui)
toggleButton.Text = "🟢 OPEN UI"
toggleButton.Position = UDim2.new(0, 10, 0.1, 0)
toggleButton.Size = UDim2.new(0, 120, 0, 35)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.AutoButtonColor = true
toggleButton.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

-- RGB Credit
local credit = Instance.new("TextLabel", Main)
credit.Text = "🔎 Script by - @Luminaprojects"
credit.Size = UDim2.new(1, -10, 0, 30)
credit.TextScaled = true
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(255, 0, 0)

spawn(function()
	while task.wait() do
		credit.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	end
end)

-- Walkspeed Slider
local WalkspeedSlider = Instance.new("TextBox", Main)
WalkspeedSlider.PlaceholderText = "WalkSpeed (default 16)"
WalkspeedSlider.Size = UDim2.new(0.9, 0, 0, 30)
WalkspeedSlider.Text = ""
WalkspeedSlider.TextScaled = true
WalkspeedSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
WalkspeedSlider.TextColor3 = Color3.new(1, 1, 1)
WalkspeedSlider.FocusLost:Connect(function()
	local val = tonumber(WalkspeedSlider.Text)
	if val then
		LocalPlayer.Character.Humanoid.WalkSpeed = val
	end
end)

-- JumpPower Slider
local JumpSlider = Instance.new("TextBox", Main)
JumpSlider.PlaceholderText = "JumpPower (default 50)"
JumpSlider.Size = UDim2.new(0.9, 0, 0, 30)
JumpSlider.Text = ""
JumpSlider.TextScaled = true
JumpSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
JumpSlider.TextColor3 = Color3.new(1, 1, 1)
JumpSlider.FocusLost:Connect(function()
	local val = tonumber(JumpSlider.Text)
	if val then
		LocalPlayer.Character.Humanoid.JumpPower = val
	end
end)

-- NoClip Toggle
local Noclip = false
local NoclipBtn = Instance.new("TextButton", Main)
NoclipBtn.Text = "❌ NoClip OFF"
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 30)
NoclipBtn.TextScaled = true
NoclipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NoclipBtn.TextColor3 = Color3.new(1, 1, 1)

NoclipBtn.MouseButton1Click:Connect(function()
	Noclip = not Noclip
	NoclipBtn.Text = Noclip and "✅ NoClip ON" or "❌ NoClip OFF"
end)

RunService.Stepped:Connect(function()
	if Noclip and LocalPlayer.Character then
		for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
end)

-- Script Loader
loadstring(game:HttpGet("https://raw.githubusercontent.com/rndmq/Serverlist/refs/heads/main/Loader"))()
