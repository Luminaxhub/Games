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

-- UI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AutoSystemUI_Mobile"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 280)
MainFrame.Position = UDim2.new(0.5, -100, 0.1, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BackgroundTransparency = 0.3
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
TitleBar.BackgroundTransparency = 0.2
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "🥊1 Punch Every Second"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 16
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BackgroundTransparency = 0.5
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, -10, 1, -40)
Content.Position = UDim2.new(0, 5, 0, 35)
Content.BackgroundTransparency = 1

local autoTrain, autoRebirth, autoKill = false, false, false

local function createMobileButton(text, yPos)
    local btn = Instance.new("TextButton", Content)
    btn.Text = text
    btn.Font = Enum.Font.GothamMedium
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 14
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    btn.BackgroundTransparency = 0.3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local status = Instance.new("TextLabel", btn)
    status.Text = "OFF"
    status.Font = Enum.Font.GothamBold
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.TextSize = 14
    status.Size = UDim2.new(0, 50, 1, 0)
    status.Position = UDim2.new(1, -55, 0, 0)
    status.BackgroundTransparency = 1
    status.TextXAlignment = Enum.TextXAlignment.Right

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        status.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(200, 80, 80)
        status.TextColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)

        if text == "Auto Train" then autoTrain = state end
        if text == "Auto Rebirth" then autoRebirth = state end
        if text == "Kill Aura" then autoKill = state end
    end)

    return btn, status
end

createMobileButton("Auto Train", 0)
createMobileButton("Auto Rebirth", 38)
createMobileButton("Aura 3x", 76)
createMobileButton("Kill Aura", 114)

-- Dropdown NPC
local SelectedNPC = "Bandit"
local Dropdown = Instance.new("TextButton", Content)
Dropdown.Size = UDim2.new(1, 0, 0, 32)
Dropdown.Position = UDim2.new(0, 0, 0, 152)
Dropdown.Text = "NPC: " .. SelectedNPC
Dropdown.Font = Enum.Font.Gotham
Dropdown.TextSize = 14
Dropdown.TextColor3 = Color3.new(1, 1, 1)
Dropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Dropdown.BackgroundTransparency = 0.3
Instance.new("UICorner", Dropdown).CornerRadius = UDim.new(0, 8)

Dropdown.MouseButton1Click:Connect(function()
    local currentIndex = table.find(npcList, SelectedNPC) or 1
    local nextIndex = currentIndex + 1
    if nextIndex > #npcList then nextIndex = 1 end
    SelectedNPC = npcList[nextIndex]
    Dropdown.Text = "NPC: " .. SelectedNPC
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Drag (mobile)
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
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
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Toggle Button
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Text = "⚙️"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 20
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BackgroundTransparency = 0.3
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 12)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Credit
local Credit = Instance.new("TextLabel", ScreenGui)
Credit.Text = "⭐ Script by - @Luminaprojects ⭐"
Credit.Font = Enum.Font.GothamMedium
Credit.TextSize = 12
Credit.Position = UDim2.new(0.5, -80, 1, -25)
Credit.Size = UDim2.new(0, 160, 0, 20)
Credit.BackgroundTransparency = 1
Credit.TextColor3 = Color3.new(1,1,1)

-- Loop
task.spawn(function()
    while true do
        local character = LocalPlayer.Character
        if autoTrain and character then
            for i = 1, 9 do
                local zone = Workspace:FindFirstChild("Zone "..i)
                if zone and zone:FindFirstChild("Punching bag "..i) then
                    local bag = zone["Punching bag "..i]:FindFirstChild("PunchBag")
                    if bag then
                        DamageRE:FireServer(character, bag, true)
                    end
                end
            end
        end
        if autoRebirth then
            pcall(function()
                RebirthRE:FireServer()
            end)
        end
        if autoKill and character then
            for zone = 1, 9 do
                local zoneFolder = Workspace:FindFirstChild("Zone " .. zone)
                if zoneFolder and zoneFolder:FindFirstChild("NPC's") then
                    local npcFolder = zoneFolder["NPC's"]
                    local npc = npcFolder:FindFirstChild(SelectedNPC)
                    if npc and npc:FindFirstChild("LowerTorso") then
                        local dist = (character.HumanoidRootPart.Position - npc.LowerTorso.Position).Magnitude
                        if dist <= 30 then
                            local args = {character, npc.LowerTorso, false, true}
                            DamageRE:FireServer(unpack(args))
                        end
                    end
                end
            end
        end
        RunService.RenderStepped:Wait()
    end
end)
]]

-- Eksekusi script
local success, err = pcall(function()
    loadstring(uiCode)()
end)
if not success then
    warn("Script Error: " .. err)
end
