local scriptCode = [[
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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoSystemUI_Mobile"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 350)
MainFrame.Position = UDim2.new(0.5, -110, 0.1, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BackgroundTransparency = 0.3
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
TitleBar.BackgroundTransparency = 0.2
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "🥊 Auto Punch"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 16
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BackgroundTransparency = 0.5
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)
CloseButton.Parent = TitleBar

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -10, 1, -40)
Content.Position = UDim2.new(0, 5, 0, 35)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local function createMobileButton(text, yPos, color)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Font = Enum.Font.GothamMedium
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 14
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.Parent = Content

    local status = Instance.new("TextLabel")
    status.Text = "OFF"
    status.Font = Enum.Font.GothamBold
    status.TextColor3 = Color3.new(1,1,1)
    status.TextSize = 14
    status.Size = UDim2.new(0, 50, 1, 0)
    status.Position = UDim2.new(1, -55, 0, 0)
    status.BackgroundTransparency = 1
    status.TextXAlignment = Enum.TextXAlignment.Right
    status.Parent = btn

    return btn, status
end

local ToggleTrain, TrainStatus = createMobileButton("Auto Train", 0, Color3.fromRGB(80, 120, 200))
local ToggleRebirth, RebirthStatus = createMobileButton("Auto Rebirth", 38, Color3.fromRGB(200, 80, 80))
local ToggleAura3x, AuraStatus = createMobileButton("Aura 3x", 76, Color3.fromRGB(200, 160, 50))
local ToggleKill, KillStatus = createMobileButton("Kill Aura", 114, Color3.fromRGB(80, 200, 120))
local ToggleEgg, EggStatus = createMobileButton("Hatch Egg", 152, Color3.fromRGB(160, 80, 200))

local DropdownFrame = Instance.new("Frame")
DropdownFrame.Size = UDim2.new(1, 0, 0, 32)
DropdownFrame.Position = UDim2.new(0, 0, 0, 190)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DropdownFrame.BackgroundTransparency = 0.3
Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 8)
DropdownFrame.Parent = Content

local DropdownLabel = Instance.new("TextLabel")
DropdownLabel.Text = "NPC:"
DropdownLabel.Font = Enum.Font.GothamMedium
DropdownLabel.TextColor3 = Color3.new(1, 1, 1)
DropdownLabel.TextSize = 14
DropdownLabel.Size = UDim2.new(0, 40, 1, 0)
DropdownLabel.Position = UDim2.new(0, 5, 0, 0)
DropdownLabel.BackgroundTransparency = 1
DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
DropdownLabel.Parent = DropdownFrame

local SelectedNPC = "Strong Farmer"
local NPCLabel = Instance.new("TextLabel")
NPCLabel.Text = SelectedNPC
NPCLabel.Font = Enum.Font.GothamMedium
NPCLabel.TextColor3 = Color3.new(1, 1, 1)
NPCLabel.TextSize = 14
NPCLabel.Size = UDim2.new(1, -50, 1, 0)
NPCLabel.Position = UDim2.new(0, 45, 0, 0)
NPCLabel.BackgroundTransparency = 1
NPCLabel.TextXAlignment = Enum.TextXAlignment.Right
NPCLabel.Parent = DropdownFrame

DropdownFrame.MouseButton1Click:Connect(function()
    local currentIndex = table.find(npcList, SelectedNPC) or 2
    local nextIndex = currentIndex + 1
    if nextIndex > #npcList then nextIndex = 1 end
    SelectedNPC = npcList[nextIndex]
    NPCLabel.Text = SelectedNPC
end)

-- Script lanjutan di bawah terlalu panjang, silakan lanjut dari file aslinya

-- Tambahkan sisa script di sini...
]]

-- Jalankan script
local success, err = pcall(function()
    loadstring(scriptCode)()
end)

if not success then
    warn("Error executing script: " .. err)
end
