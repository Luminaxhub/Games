-- 🌟 Shrink Hide & Seek UI - Script by @Luminaprojects
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- CONFIG
_G.ESP = false
_G.Noclip = false
_G.Hitbox = false
local HitboxSize = 10

-- CREATE UI
local MainUI = Instance.new("ScreenGui", game.CoreGui)
MainUI.Name = "ShrinkUI"

local Frame = Instance.new("Frame", MainUI)
Frame.Size = UDim2.new(0, 170, 0, 250)
Frame.Position = UDim2.new(0, 20, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

local RGBBorder = Instance.new("UIStroke", Frame)
RGBBorder.Thickness = 2
RGBBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RGBBorder.LineJoinMode = Enum.LineJoinMode.Round

-- RGB ANIMATION
spawn(function()
    local t = 0
    while true do
        t = t + 0.01
        local r = math.sin(t) * 127 + 128
        local g = math.sin(t + 2) * 127 + 128
        local b = math.sin(t + 4) * 127 + 128
        RGBBorder.Color = ColorSequence.new(Color3.fromRGB(r, g, b))
        wait(0.02)
    end
end)

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "⛺ Shrink ESP UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold

-- CREDIT
local Credit = Instance.new("TextLabel", Frame)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by - @Luminaprojects"
Credit.TextSize = 13
Credit.Font = Enum.Font.GothamSemibold
Credit.TextColor3 = Color3.new(1, 1, 1)

-- RGB CREDIT
spawn(function()
    local t = 0
    while true do
        t = t + 0.03
        local r = math.sin(t) * 127 + 128
        local g = math.sin(t + 2) * 127 + 128
        local b = math.sin(t + 4) * 127 + 128
        Credit.TextColor3 = Color3.fromRGB(r, g, b)
        wait()
    end
end)

-- BUTTON TEMPLATE
local function CreateToggle(text, state, callback)
    local Toggle = Instance.new("TextButton", Frame)
    Toggle.Size = UDim2.new(1, -20, 0, 30)
    Toggle.Position = UDim2.new(0, 10, 0, #Frame:GetChildren() * 35)
    Toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    Toggle.Text = text
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.TextSize = 14
    Toggle.Font = Enum.Font.GothamSemibold

    local corner = Instance.new("UICorner", Toggle)
    corner.CornerRadius = UDim.new(0, 6)

    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        callback(state)
    end)
end

-- ESP Function
local ESPTrackers = {}
local function CreateESP(player)
    if not player.Character then return end

    local Billboard = Instance.new("BillboardGui")
    Billboard.Size = UDim2.new(0, 100, 0, 20)
    Billboard.Adornee = player.Character:FindFirstChild("Head")
    Billboard.AlwaysOnTop = true
    Billboard.Name = "_ESP"

    local Tag = Instance.new("TextLabel", Billboard)
    Tag.Size = UDim2.new(1, 0, 1, 0)
    Tag.BackgroundTransparency = 1
    Tag.Text = "👤 " .. player.Name
    Tag.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tag.TextStrokeTransparency = 0.5
    Tag.TextSize = 13
    Tag.Font = Enum.Font.GothamBold

    Billboard.Parent = player.Character:FindFirstChild("Head")
    ESPTrackers[player] = Billboard
end

local function RemoveESP(player)
    if ESPTrackers[player] then
        ESPTrackers[player]:Destroy()
        ESPTrackers[player] = nil
    end
end

-- Main Toggles
CreateToggle("👀 ESP HIDERS", _G.ESP, function(state)
    _G.ESP = state
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            RemoveESP(p)
            if state and p.Team and p.Team.Name:lower():find("hider") then
                CreateESP(p)
            end
        end
    end
end)

CreateToggle("🚪 Noclip", _G.Noclip, function(state)
    _G.Noclip = state
end)

CreateToggle("📦 Hitbox", _G.Hitbox, function(state)
    _G.Hitbox = state
end)

-- HITBOX SLIDER
local HitboxLabel = Instance.new("TextLabel", Frame)
HitboxLabel.Size = UDim2.new(1, -20, 0, 20)
HitboxLabel.Position = UDim2.new(0, 10, 0, #Frame:GetChildren() * 35)
HitboxLabel.BackgroundTransparency = 1
HitboxLabel.Text = "📏 Hitbox Size: " .. HitboxSize
HitboxLabel.TextColor3 = Color3.new(1, 1, 1)
HitboxLabel.TextSize = 14
HitboxLabel.Font = Enum.Font.Gotham

local HitboxSlider = Instance.new("TextButton", Frame)
HitboxSlider.Size = UDim2.new(1, -20, 0, 20)
HitboxSlider.Position = HitboxLabel.Position + UDim2.new(0, 0, 0, 25)
HitboxSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HitboxSlider.Text = "Slide Me (Android Support)"
HitboxSlider.TextColor3 = Color3.new(1,1,1)
HitboxSlider.TextSize = 13
HitboxSlider.Font = Enum.Font.Gotham

local sliderCorner = Instance.new("UICorner", HitboxSlider)
sliderCorner.CornerRadius = UDim.new(0, 6)

HitboxSlider.MouseButton1Down:Connect(function()
    local conn
    conn = UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local mouseX = UIS:GetMouseLocation().X
            local scale = math.clamp((mouseX - HitboxSlider.AbsolutePosition.X) / HitboxSlider.AbsoluteSize.X, 0, 1)
            HitboxSize = math.floor(scale * 100)
            HitboxLabel.Text = "📏 Hitbox Size: " .. HitboxSize
        end
    end)
    UIS.InputEnded:Wait()
    conn:Disconnect()
end)

-- ESP Loop
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if _G.ESP and p.Team and p.Team.Name:lower():find("hider") then
                if not ESPTrackers[p] then
                    CreateESP(p)
                end
            else
                RemoveESP(p)
            end

            if _G.Hitbox and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                p.Character.HumanoidRootPart.Transparency = 0.7
                p.Character.HumanoidRootPart.Material = Enum.Material.Neon
                p.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
            elseif p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
                p.Character.HumanoidRootPart.Transparency = 0
                p.Character.HumanoidRootPart.Material = Enum.Material.Plastic
            end
        end
    end
end)

-- Noclip Loop
RunService.Stepped:Connect(function()
    if _G.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
