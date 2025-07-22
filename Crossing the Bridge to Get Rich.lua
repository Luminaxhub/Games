-- 🌉 Crossing the Bridge to Get Rich UI - Made by @Luminaprojects
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create UI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "BridgeUI"
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 140, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.Text = "🌉 Toggle UI"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.ZIndex = 10

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0, 160, 0, 80)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌈 Crossing the Bridge to Get Rich"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 18

-- Tabs
local tabNames = {"TREASURE CHEST", "TELEPORT", "OBBY", "MORE SETTING", "CREDIT"}
local buttons, pages = {}, {}
for i, tabName in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton", mainFrame)
    tabBtn.Size = UDim2.new(0, 80, 0, 30)
    tabBtn.Position = UDim2.new(0, (i - 1) * 82 + 10, 0, 45)
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.TextColor3 = Color3.new(1, 1, 1)
    tabBtn.Text = tabName
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.TextSize = 13
    buttons[tabName] = tabBtn

    local page = Instance.new("Frame", mainFrame)
    page.Size = UDim2.new(1, -20, 1, -90)
    page.Position = UDim2.new(0, 10, 0, 85)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1)
    pages[tabName] = page

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
end

-- Toggle UI
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Teleport Helper
local function teleportTo(x, y, z)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char:MoveTo(Vector3.new(x, y, z))
    end
end

-- Treasure Chest
local chests = {
    {"1K CASH", Vector3.new(-1, 50, -1138)},
    {"2.5K CASH", Vector3.new(500, 52, -2636)},
    {"5K CASH", Vector3.new(999, 55, -5125)},
    {"10K CASH", Vector3.new(1499, 56, -10135)},
    {"25K CASH", Vector3.new(1999, 52, -25139)}
}
for i, data in ipairs(chests) do
    local btn = Instance.new("TextButton", pages["TREASURE CHEST"])
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, (i - 1) * 35)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Text = data[1]
    btn.MouseButton1Click:Connect(function()
        teleportTo(data[2].X, data[2].Y, data[2].Z)
    end)
end

-- Teleport Tab
local locations = {
    {"World 5", Vector3.new(2000, 3, 11)},
    {"World 4", Vector3.new(1498, 3, 13)},
    {"World 3", Vector3.new(999, 3, 12)},
    {"World 2", Vector3.new(499, 3, 11)},
    {"World 1", Vector3.new(0, 3, 10)},
    {"Obby Maps", Vector3.new(-199, 3, 11)}
}
for i, data in ipairs(locations) do
    local btn = Instance.new("TextButton", pages["TELEPORT"])
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, (i - 1) * 35)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Text = data[1]
    btn.MouseButton1Click:Connect(function()
        teleportTo(data[2].X, data[2].Y, data[2].Z)
    end)
end

-- Obby Tab
local obbyStages = {
    ["Easy Obby"] = {
        {-328, 3, 90}, {-367, 13, 89}, {-392, 3, 90}, {-428, 3, 89},
        {-447, 3, 90}, {-466, 3, 88}
    },
    ["Medium Obby"] = {
        {-308, 4, 10}, {-325, 3, 9}, {-342, 3, 10}, {-349, 3, 10},
        {-367, 8, 14}, {-419, 3, 10}, {-447, 3, 9}, {-470, 3, 10},
        {-494, 3, 9}, {-506, 3, 8}
    },
    ["Hard Obby"] = {
        {-304,3,-71}, {-330,3,-70}, {-340,3,-70}, {-351,3,-70},
        {-359,3,-70}, {-379,6,-71}, {-403,3,-66}, {-424,3,-74},
        {-434,3,-70}, {-453,3,-70}, {-475,3,-70}, {-481,9,-76},
        {-486,15,-70}, {-499,3,-70}, {-517,3,-69}, {-534,3,-70},
        {-549,3,-71}
    }
}
local offset = 0
for name, coords in pairs(obbyStages) do
    local btn = Instance.new("TextButton", pages["OBBY"])
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, offset)
    btn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Text = name .. " (Auto)"
    btn.MouseButton1Click:Connect(function()
        coroutine.wrap(function()
            for _, pos in ipairs(coords) do
                teleportTo(pos[1], pos[2], pos[3])
                wait(1)
            end
        end)()
    end)
    offset += 35
end

-- More Setting
local function createSlider(name, min, max, default, posY, callback)
    local label = Instance.new("TextLabel", pages["MORE SETTING"])
    label.Text = name
    label.Position = UDim2.new(0, 10, 0, posY)
    label.Size = UDim2.new(0, 100, 0, 30)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14

    local slider = Instance.new("TextButton", pages["MORE SETTING"])
    slider.Position = UDim2.new(0, 120, 0, posY)
    slider.Size = UDim2.new(0, 200, 0, 30)
    slider.Text = tostring(default)
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    slider.TextColor3 = Color3.new(1, 1, 1)
    slider.AutoButtonColor = false

    local dragging = false
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    slider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    slider.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local relX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * relX)
            slider.Text = tostring(val)
            callback(val)
        end
    end)
end

createSlider("WalkSpeed", 10, 100, 16, 10, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

createSlider("JumpPower", 20, 200, 50, 50, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

local unlockBtn = Instance.new("TextButton", pages["MORE SETTING"])
unlockBtn.Size = UDim2.new(0, 180, 0, 35)
unlockBtn.Position = UDim2.new(0, 10, 0, 100)
unlockBtn.BackgroundColor3 = Color3.fromRGB(70, 120, 70)
unlockBtn.TextColor3 = Color3.new(1, 1, 1)
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.TextSize = 14
unlockBtn.Text = "🔓 UNLOCKED FUN ZONE"
unlockBtn.MouseButton1Click:Connect(function()
    local zone = workspace:FindFirstChild("FunZone")
    if zone and zone:FindFirstChild("Barriers") and zone.Barriers:FindFirstChild("Entrance") then
        zone.Barriers.Entrance:Destroy()
        unlockBtn.Text = "✅ FUN ZONE UNLOCKED!"
    else
        unlockBtn.Text = "❌ Entrance not found"
    end
    wait(2)
    unlockBtn.Text = "🔓 UNLOCKED FUN ZONE"
end)

-- Credit Tab
local credit = Instance.new("TextLabel", pages["CREDIT"])
credit.Size = UDim2.new(1, 0, 1, 0)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(255, 0, 255)
credit.Text = "Script by - Luminaprojects"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 16
credit.TextWrapped = true
credit.TextScaled = true
