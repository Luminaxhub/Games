-- 🌈 Crossing the Bridge to Get Rich UI (Mobile Optimized)
-- Owner: Luminaprojects | YouTube: Luminaprojects

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.Character

local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuminaUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 100, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Text = "🌉 Toggle UI"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 16
ToggleBtn.Parent = ScreenGui
ToggleBtn.Active = true
ToggleBtn.Draggable = true

-- Main UI Frame
local MainUI = Instance.new("Frame")
MainUI.Size = UDim2.new(0, 280, 0, 400)
MainUI.Position = UDim2.new(0, 120, 0, 150)
MainUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainUI.BorderSizePixel = 0
MainUI.Visible = false
MainUI.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "🌈 Lumina Bridge UI"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainUI

-- Button Creator
local function createButton(text, yPos, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 240, 0, 30)
	btn.Position = UDim2.new(0, 20, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = MainUI
	btn.MouseButton1Click:Connect(callback)
end

-- 💰 TREASURE
createButton("1K CASH", 50, function() LocalPlayer.Character:MoveTo(Vector3.new(-1, 50, -1138)) end)
createButton("2.5K CASH", 85, function() LocalPlayer.Character:MoveTo(Vector3.new(500, 52, -2636)) end)
createButton("5K CASH", 120, function() LocalPlayer.Character:MoveTo(Vector3.new(999, 55, -5125)) end)
createButton("10K CASH", 155, function() LocalPlayer.Character:MoveTo(Vector3.new(1499, 56, -10135)) end)
createButton("25K CASH", 190, function() LocalPlayer.Character:MoveTo(Vector3.new(1999, 52, -25139)) end)

-- 🌍 WORLD
createButton("World 5", 230, function() LocalPlayer.Character:MoveTo(Vector3.new(2000, 3, 11)) end)
createButton("World 4", 265, function() LocalPlayer.Character:MoveTo(Vector3.new(1498, 3, 13)) end)
createButton("World 3", 300, function() LocalPlayer.Character:MoveTo(Vector3.new(999, 3, 12)) end)
createButton("World 2", 335, function() LocalPlayer.Character:MoveTo(Vector3.new(499, 3, 11)) end)
createButton("World 1", 370, function() LocalPlayer.Character:MoveTo(Vector3.new(0, 3, 10)) end)

-- 🔁 Toggle Function
ToggleBtn.MouseButton1Click:Connect(function()
	MainUI.Visible = not MainUI.Visible
end)

-- 📜 Credit
warn("🌟 Script UI by Luminaprojects | YouTube: Luminaprojects")
