local uiCode = [[
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

repeat task.wait() until LocalPlayer:FindFirstChild("PlayerGui")

local DamageRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("PunchEvents"):WaitForChild("DamageRE")
local RebirthRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("RebirthEvents"):WaitForChild("Rebirth")

local npcList = {
    "Noob Farmer", "Strong Farmer", "Bandit", "Cowboy", "Candy Man", "Gingerbread Man",
    "Snow Bandit", "Snow Knight", "Monkey", "Monkey King", "Toy Soldier", "Teddy Bear",
    "Astronaut", "Space Man", "Crew Member", "Pirate Captain", "Lava Guard", "Dark Trooper"
}

-- Create UIs
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DualSystemUI_Mobile"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Toggle buttons
local ToggleButton1 = Instance.new("TextButton")
ToggleButton1.Text = "🥊"
ToggleButton1.Font = Enum.Font.GothamBold
ToggleButton1.TextSize = 20
ToggleButton1.Size = UDim2.new(0, 40, 0, 40)
ToggleButton1.Position = UDim2.new(0, 10, 0.5, -60)
ToggleButton1.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
ToggleButton1.TextColor3 = Color3.new(1, 1, 1)
ToggleButton1.BackgroundTransparency = 0.3
Instance.new("UICorner", ToggleButton1).CornerRadius = UDim.new(0, 12)
ToggleButton1.Parent = ScreenGui

local ToggleButton2 = Instance.new("TextButton")
ToggleButton2.Text = "💰"
ToggleButton2.Font = Enum.Font.GothamBold
ToggleButton2.TextSize = 20
ToggleButton2.Size = UDim2.new(0, 40, 0, 40)
ToggleButton2.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton2.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleButton2.TextColor3 = Color3.new(1, 1, 1)
ToggleButton2.BackgroundTransparency = 0.3
Instance.new("UICorner", ToggleButton2).CornerRadius = UDim.new(0, 12)
ToggleButton2.Parent = ScreenGui

-- UI 1: Original Punch System
local MainFrame1 = Instance.new("Frame")
MainFrame1.Size = UDim2.new(0, 220, 0, 350)
MainFrame1.Position = UDim2.new(0.5, -250, 0.1, 0)
MainFrame1.AnchorPoint = Vector2.new(0.5, 0)
MainFrame1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame1.BackgroundTransparency = 0.3
MainFrame1.Visible = false
Instance.new("UICorner", MainFrame1).CornerRadius = UDim.new(0, 12)

-- [Previous UI1 code remains exactly the same as your original punch UI]

-- UI 2: Cash/Strength Reward System
local MainFrame2 = Instance.new("Frame")
MainFrame2.Size = UDim2.new(0, 220, 0, 220)
MainFrame2.Position = UDim2.new(0.5, 30, 0.1, 0)
MainFrame2.AnchorPoint = Vector2.new(0.5, 0)
MainFrame2.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MainFrame2.BackgroundTransparency = 0.3
MainFrame2.Visible = false
Instance.new("UICorner", MainFrame2).CornerRadius = UDim.new(0, 12)

-- (Semua isi UI2 seperti RewardType, Amount, StrengthFrame, ButtonClaim dll tidak saya ubah)

-- Toggle & Close
ToggleButton1.MouseButton1Click:Connect(function()
    MainFrame1.Visible = not MainFrame1.Visible
end)

ToggleButton2.MouseButton1Click:Connect(function()
    MainFrame2.Visible = not MainFrame2.Visible
end)

CloseButton2.MouseButton1Click:Connect(function()
    MainFrame2.Visible = false
end)

-- Drag Function
local function setupDrag(frame, titleBar)
    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then 
                    dragging = false 
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

setupDrag(MainFrame1, TitleBar1) -- Pastikan TitleBar1 kamu ada
setupDrag(MainFrame2, TitleBar2)

MainFrame1.Parent = ScreenGui
MainFrame2.Parent = ScreenGui

local Credit = Instance.new("TextLabel")
Credit.Text = "by Luminaprojects"
Credit.Font = Enum.Font.GothamMedium
Credit.TextSize = 12
Credit.Position = UDim2.new(0.5, -60, 1, -25)
Credit.Size = UDim2.new(0, 120, 0, 20)
Credit.BackgroundTransparency = 1
Credit.TextColor3 = Color3.fromRGB(200, 200, 200)
Credit.Parent = ScreenGui
]]

-- ✅ Jalankan UI code
local success, err = pcall(function()
    loadstring(uiCode)()
end)

if not success then
    warn("Error executing script: " .. err)
end
