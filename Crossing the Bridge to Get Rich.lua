-- fix bug system 
- create by Luminaprojects 

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Humanoid = nil

-- Wait until character and Humanoid loaded
repeat task.wait() until LocalPlayer.Character and LocalPlayer:FindFirstChild("PlayerGui")
Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "LuminaMobileUI"
ScreenGui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 100, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 200)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Text = "⚙️ UI"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Parent = ScreenGui
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local MainUI = Instance.new("Frame")
MainUI.Size = UDim2.new(0, 280, 0, 350)
MainUI.Position = UDim2.new(0, 120, 0, 200)
MainUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainUI.Visible = false
MainUI.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🌉 Bridge To Get Rich UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainUI

local function createButton(text, posY, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 240, 0, 30)
    Btn.Position = UDim2.new(0, 20, 0, posY)
    Btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.Parent = MainUI
    Btn.MouseButton1Click:Connect(callback)
end

-- 📦 TREASURE
createButton("💰 1K CASH", 40, function() LocalPlayer.Character:MoveTo(Vector3.new(-1, 50, -1138)) end)
createButton("💰 2.5K CASH", 75, function() LocalPlayer.Character:MoveTo(Vector3.new(500, 52, -2636)) end)
createButton("💰 5K CASH", 110, function() LocalPlayer.Character:MoveTo(Vector3.new(999, 55, -5125)) end)
createButton("💰 10K CASH", 145, function() LocalPlayer.Character:MoveTo(Vector3.new(1499, 56, -10135)) end)
createButton("💰 25K CASH", 180, function() LocalPlayer.Character:MoveTo(Vector3.new(1999, 52, -25139)) end)

-- 🗺️ TELEPORT
createButton("🌍 World 5", 215, function() LocalPlayer.Character:MoveTo(Vector3.new(2000, 3, 11)) end)
createButton("🌍 World 4", 250, function() LocalPlayer.Character:MoveTo(Vector3.new(1498, 3, 13)) end)
createButton("🌍 World 3", 285, function() LocalPlayer.Character:MoveTo(Vector3.new(999, 3, 12)) end)
createButton("🌍 World 2", 320, function() LocalPlayer.Character:MoveTo(Vector3.new(499, 3, 11)) end)

-- UI Toggle
ToggleBtn.MouseButton1Click:Connect(function()
    MainUI.Visible = not MainUI.Visible
end)

-- 🎉 CREDIT (auto show in output)
warn("👑 UI by Luminaprojects | YouTube: Luminaprojects")
