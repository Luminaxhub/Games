-- 📦 Memory Murder Key System & Auto Loader
-- 🔐 Script by - @Luminaprojects (EN Version)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "MemoryMurderKeyUI"
screenGui.ResetOnSpawn = false

-- Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 320, 0, 180)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.15
mainFrame.Active = true
mainFrame.Draggable = true

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔐 Memory Murder - Key System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold

-- Key Input
local keyBox = Instance.new("TextBox", mainFrame)
keyBox.Size = UDim2.new(0.8, 0, 0, 35)
keyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
keyBox.PlaceholderText = "Enter your key..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false

-- Get Key Button
local getKeyBtn = Instance.new("TextButton", mainFrame)
getKeyBtn.Size = UDim2.new(0.45, 0, 0, 30)
getKeyBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
getKeyBtn.Text = "🌐 Get Key"
getKeyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.Font = Enum.Font.Gotham
getKeyBtn.TextSize = 14
getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://get-key-luminakey.vercel.app/")
end)

-- Verify Button
local verifyBtn = Instance.new("TextButton", mainFrame)
verifyBtn.Size = UDim2.new(0.45, 0, 0, 30)
verifyBtn.Position = UDim2.new(0.5, 0, 0.7, 0)
verifyBtn.Text = "✅ Verify Key"
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 50)
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.Gotham
verifyBtn.TextSize = 14

verifyBtn.MouseButton1Click:Connect(function()
    local inputKey = keyBox.Text
    if inputKey == "LUMINAKEY_pxs0up8r2bh2j19" then
        mainFrame:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminaxhub/Games/refs/heads/main/Memory%20Murder.lua"))()
    else
        verifyBtn.Text = "❌ Invalid Key"
        verifyBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
        wait(1.5)
        verifyBtn.Text = "✅ Verify Key"
        verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 50)
    end
end)
