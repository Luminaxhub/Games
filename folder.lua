-- Flow's Prop Hunt Hub
-- Script by - @Luminaprojects
if game.PlaceId ~= 127655664262986 then
    return warn("Этот сценарий предназначен только для Prop Hunt от Flow..")
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local espName = "HiderESP"
local teamName = "Hiders"
local espColor = Color3.fromRGB(255, 255, 0)
local espEnabled, tpEnabled, noclipEnabled = false, false, false
local lobbyPosition = Vector3.new(3.13, 1935.48, -70.34)
local walkspeed = 16

-- UI
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "FlowsHub"
screenGui.ResetOnSpawn = false

-- OPEN Button
local openBtn = Instance.new("TextButton", screenGui)
openBtn.Text = "⚙️ OPEN"
openBtn.Size = UDim2.new(0, 80, 0, 30)
openBtn.Position = UDim2.new(0, 10, 0, 10)
openBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 18
openBtn.ZIndex = 3

-- Main Frame
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 270, 0, 280)
main.Position = UDim2.new(0, 100, 0, 10)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Visible = false
main.Active = true
main.Draggable = true

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔎 Flow's Prop Hunt"
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- ESP Button
local espBtn = Instance.new("TextButton", main)
espBtn.Position = UDim2.new(0, 10, 0, 40)
espBtn.Size = UDim2.new(1, -20, 0, 40)
espBtn.Text = "👁️ ESP: OFF"
espBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espBtn.TextColor3 = Color3.new(1, 1, 1)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 16

-- Auto Collect Coin
spawn(function()
    while task.wait(1) do
        for _, coin in pairs(workspace:GetDescendants()) do
            if coin:IsA("TouchTransmitter") and coin.Parent and coin.Parent:IsA("Part") and coin.Parent.Name == "Coin" then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, coin.Parent, 0)
                task.wait()
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, coin.Parent, 1)
            end
        end
    end
end)

-- TP Button
local tpBtn = Instance.new("TextButton", main)
tpBtn.Position = UDim2.new(0, 10, 0, 90)
tpBtn.Size = UDim2.new(1, -20, 0, 40)
tpBtn.Text = "👑 TP to Lobby (EASY WIN): OFF"
tpBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
tpBtn.TextColor3 = Color3.new(1, 1, 1)
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 15

-- Noclip Button
local noclipBtn = Instance.new("TextButton", main)
noclipBtn.Position = UDim2.new(0, 10, 0, 140)
noclipBtn.Size = UDim2.new(1, -20, 0, 40)
noclipBtn.Text = "🎯 Noclip: OFF"
noclipBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
noclipBtn.TextColor3 = Color3.new(1, 1, 1)
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 16

-- Walkspeed Label
local wsLabel = Instance.new("TextLabel", main)
wsLabel.Position = UDim2.new(0, 10, 0, 190)
wsLabel.Size = UDim2.new(1, -20, 0, 20)
wsLabel.Text = "🏃 Walkspeed: " .. walkspeed
wsLabel.BackgroundTransparency = 1
wsLabel.TextColor3 = Color3.new(1, 1, 1)
wsLabel.Font = Enum.Font.GothamBold
wsLabel.TextSize = 14
wsLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Walkspeed Slider
local wsSlider = Instance.new("TextButton", main)
wsSlider.Position = UDim2.new(0, 10, 0, 215)
wsSlider.Size = UDim2.new(1, -20, 0, 15)
wsSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
wsSlider.Text = ""
wsSlider.AutoButtonColor = false

local wsIndicator = Instance.new("Frame", wsSlider)
wsIndicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
wsIndicator.Size = UDim2.new((walkspeed - 16) / 84, 0, 1, 0)
wsIndicator.Position = UDim2.new(0, 0, 0, 0)

wsIndicator.Parent = wsSlider

-- RGB Credit
local rgbCredit = Instance.new("TextLabel", screenGui)
rgbCredit.Size = UDim2.new(1, 0, 0, 25)
rgbCredit.Position = UDim2.new(0, 0, 1, -25)
rgbCredit.BackgroundTransparency = 1
rgbCredit.Text = "Script by - @Luminaprojects"
rgbCredit.Font = Enum.Font.GothamBold
rgbCredit.TextSize = 14
rgbCredit.TextColor3 = Color3.fromRGB(255, 0, 0)

-- RGB Animation
task.spawn(function()
 while true do
  for i = 0, 255, 4 do
   rgbCredit.TextColor3 = Color3.fromHSV(i / 255, 1, 1)
   task.wait(0.03)
  end
 end
end)
