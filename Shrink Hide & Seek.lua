-- ⛺ Shrink Hide & Seek UI
-- Script by @Luminaprojects
-- Only works in game: https://www.roblox.com/games/137541498231955

if game.PlaceId ~= 137541498231955 then
    return warn("This script only works in Shrink Hide & Seek.")
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera

-- CONFIG
_G.ESP = false
_G.Noclip = false
_G.AutoSpin = false
_G.HeadSize = 1
_G.Disabled = true

-- UI SETUP
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ShrinkHideSeekUI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 300)
Main.Position = UDim2.new(0.05, 0, 0.3, 0)
Main.BackgroundTransparency = 0.3
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "⛺ Shrink Hide & Seek"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- BUTTON MAKER
local function createToggle(name, default, parent, callback)
    local toggle = Instance.new("TextButton", parent)
    toggle.Size = UDim2.new(1, -20, 0, 30)
    toggle.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 35)
    toggle.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggle.Text = name .. (default and " [ON]" or " [OFF]")
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 14
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)

    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        toggle.Text = name .. (state and " [ON]" or " [OFF]")
        callback(state)
    end)
end

-- ESP NAMETAG 👀 HIDERS
RunService.RenderStepped:Connect(function()
    if _G.ESP then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                if not player.Character.Head:FindFirstChild("ESP") then
                    local bill = Instance.new("BillboardGui", player.Character.Head)
                    bill.Name = "ESP"
                    bill.Size = UDim2.new(0,100,0,40)
                    bill.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bill)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.Text = "👀 HIDERS"
                    txt.TextColor3 = Color3.fromRGB(255,165,0)
                    txt.TextSize = 14
                    txt.Font = Enum.Font.GothamBold
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local esp = player.Character.Head:FindFirstChild("ESP")
                if esp then esp:Destroy() end
            end
        end
    end
end)

-- HITBOX EXPAND
RunService.RenderStepped:Connect(function()
    if _G.Disabled then
        for i,v in next, Players:GetPlayers() do
            if v.Name ~= LocalPlayer.Name and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            end
        end
    end
end)

-- Auto Expand to 50 then reset to 1
spawn(function()
    while task.wait(0.1) do
        if _G.Disabled then
            if _G.HeadSize < 50 then
                _G.HeadSize += 1
            else
                _G.HeadSize = 1
            end
        end
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if _G.Noclip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- Auto Spin
spawn(function()
    while task.wait() do
        if _G.AutoSpin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(10), 0)
        end
    end
end)

-- TOGGLES
createToggle("👀 ESP HIDERS", false, Main, function(state)
    _G.ESP = state
end)

createToggle("🎯 Hitbox Expander", false, Main, function(state)
    _G.Disabled = state
end)

createToggle("🚶‍♂️ Noclip", false, Main, function(state)
    _G.Noclip = state
end)

createToggle("🎡 Auto Spin", false, Main, function(state)
    _G.AutoSpin = state
end)

createToggle("🎟️ Mini Mode 39R$", false, Main, function(state)
    if state then
        LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(0.5,0.5,0.5)
    else
        LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
    end
end)

createToggle("📦 Big Mode", false, Main, function(state)
    if state then
        LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(4,4,4)
    else
        LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
    end
end)
